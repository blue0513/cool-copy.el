;;; cool-copy --- simple but helpful copy tool

;; Copyright (C) 2019- blue0513

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: blue0513
;; URL: https://github.com/blue0513/cool-copy
;; Version: 0.1.0

;;; Commentary:

;; Edit your init.el
;;
;; (require 'cool-copy)
;;

;;; Code:

(require 'posframe nil t)

(defcustom cool-copy-show 'minibuffer
  "Method for showing the result of copy action."
  :type '(choice (const :tag "nothing" nil)
                 (const :tag "minibuffer" minibuffer)
                 (const :tag "posframe" posframe))
  :group 'cool-copy)

(defvar cool-copy-posframe-buffer " *cool-copy-posframe")
(defvar cool-copy-posframe-background "black")

(defun cool-copy--copy-at-point ()
  (kill-new (thing-at-point 'symbol))
  (cool-copy--show-message (format "cp!: %s" (thing-at-point 'symbol))))

(defun cool-copy--copy-region (beg end)
  (copy-region-as-kill beg end)
  (cool-copy--show-message "region copied!"))

(defun cool-copy--show-posframe (str)
  (posframe-show cool-copy-posframe-buffer
                 :string str
                 :no-properties nil
                 :background-color cool-copy-posframe-background)
  (add-hook 'pre-command-hook 'cool-copy--hide-message))

(defun cool-copy--show-message (str)
  (when (eq cool-copy-show 'minibuffer)
    (message str))
   (when (eq cool-copy-show 'posframe)
     (cool-copy--show-posframe str)))

(defun cool-copy--hide-message ()
  (remove-hook 'pre-command-hook 'cool-copy--hide-message)
  (posframe-hide cool-copy-posframe-buffer))

;;; Main

(defun cool-copy ()
  "If the region is selected, copy the region. If not, copy thing-at-point."
  (interactive)
  (cond
   ((region-active-p)
    (cool-copy--copy-region (region-beginning) (region-end)))
   ((thing-at-point 'symbol)
    (cool-copy--copy-at-point))
   (t
    (cool-copy--show-message "No symbol or region selected"))))

;; * provide

(provide 'cool-copy)

;;; cool-copy.el ends here
