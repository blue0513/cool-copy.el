# Cool Copy

If the region is selected, copy the region.   
If not, copy thing-at-point with message.

[![Image from Gyazo](https://i.gyazo.com/0370706f96521b8ddc646de315964aaa.png)](https://gyazo.com/0370706f96521b8ddc646de315964aaa)

## Setup

`git clone` and edit your init.el as below.

```elisp
(add-to-list 'load-path "YOUR PATH")
(require 'cool-copy)

;; optional
(global-set-key [YOUR KEY] 'cool-copy)
```

## Usage

+ thing-at-point: When your cursor on the symbol, you can copy it
+ region: When you selected the region, you can copy the region

## Custom

you can select the prefer method for showing the message.

```elisp
;; show message on minibuffer (default)
(setq cool-copy-show 'minibuffer)
;; show message on posframe
(setq cool-copy-show 'posframe)
;; do not show message
(setq cool-copy-show nil)
```
