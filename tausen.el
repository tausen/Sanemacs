;;; MT customizations

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; undo some sanemacs things
;; undo change cursor type
(setq-default cursor-type t)

;; undo line numbers
(remove-hook 'prog-mode-hook
                  (if (fboundp 'display-line-numbers-mode)
                       #'display-line-numbers-mode
                           #'linum-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; delete pair of parens, ..
(global-set-key (kbd "C-x p") 'delete-pair)

;; Disable blinking cursor
(blink-cursor-mode 0)

;; Allow copying to system clipboard
(setq x-select-enable-clipboard t)

;; god-mode
(add-to-list 'load-path "~/.emacs.d/lib/")
(require 'god-mode)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)
(global-set-key (kbd "C-x C-{") 'shrink-window-horizontally)
(global-set-key (kbd "C-x C-}") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x C-[") 'shrink-window)
(global-set-key (kbd "C-x C-]") 'enlarge-window)
(global-set-key (kbd "C-x C-5 C-0") 'delete-frame)
(global-set-key (kbd "C-x C-#") 'server-edit)
(global-set-key (kbd "C-x C-o") 'other-window)
(define-key god-local-mode-map (kbd "z") 'repeat)
(define-key god-local-mode-map (kbd "i") 'god-or-newline)

(global-set-key (kbd "<RET>") 'god-or-newline) ;; really bad when pasting into nowindow

;; make god-mode work in vhdl-mode
(add-hook 'vhdl-mode-hook (lambda () (local-set-key (kbd "<RET>") 'god-mode-all)))
(add-hook 'vhdl-mode-hook (lambda () (define-key god-local-mode-map (kbd "<SPC>") 'set-mark-command)))

;; exceptions
(add-to-list 'god-exempt-major-modes 'term-mode)
(setq god-exempt-predicates '(god-exempt-mode-p god-view-mode-p god-special-mode-p))

;; indicate whether god-mode is on by changing the cursor
;; only works with x11
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box)))
(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; indicate whether god-mode is on with blue mode-line background
;; always works (if not in limited colors term..)
(defun c/god-mode-update-cursor ()
  (cond (god-local-mode (progn (set-face-background 'mode-line "deep sky blue")))
        (t (progn (set-face-background 'mode-line "gray80")))))
(add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
(add-hook 'god-mode-disabled-hook 'c/god-mode-update-cursor)

(set-face-foreground 'minibuffer-prompt "gray50")
(set-face-background 'region "yellow")

;; toggle RET between god-mode-all and newline with bind-ret-god
(setq god-bound-to-ret t)

(defun god-or-newline ()
  (interactive)
  (if god-bound-to-ret (god-mode-all) (newline)))

(defun bind-ret-god ()
  (cond

   (god-bound-to-ret (global-set-key (kbd "<RET>") 'newline)
                     (setq god-bound-to-ret nil)
                     (message "RET bound to newline") )

   (t (global-set-key (kbd "<RET>") 'god-or-newline)
      (setq god-bound-to-ret t)
      (message "RET bound to god-mode-all") )
   
   ))

(global-set-key (kbd "<f7>") (lambda () (interactive) (bind-ret-god)))

;; Some scrolling hotkeys
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 5)))
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 5)))
(global-set-key (kbd "C-s-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-s-n") (lambda () (interactive) (next-line 5)))
;; (global-set-key (kbd "s-p") (lambda () (interactive) (scroll-previous-line 1)))
;; (global-set-key (kbd "s-n") (lambda () (interactive) (scroll-next-line 1)))
(global-set-key (kbd "M-s-p") (lambda () (interactive) (scroll-previous-line 5)))
(global-set-key (kbd "M-s-n") (lambda () (interactive) (scroll-next-line 5)))

;; enable indentation after C-j
(electric-indent-mode -1)

;; dont prompt when using disabled commands
(setq disabled-command-function nil)

;; load tango-dark theme
(disable-theme 'wheatgrass)
(load-theme 'tango-dark t)

;; change some undo-tree key bindings
(define-key undo-tree-map (kbd "C-x u") 'undo-tree-undo)
(define-key undo-tree-map (kbd "C-x y") 'undo-tree-redo)
(define-key undo-tree-map (kbd "C-c u") 'undo-tree-visualize)
(add-hook 'undo-tree-visualizer-mode-hook (lambda () (local-set-key (kbd "RET") 'undo-tree-visualizer-quit)))

;; ido-mode
(ido-mode t)
(setq ido-enable-flex-matching t)

;; some hotkeys
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; show column number in mode line
(column-number-mode)

;; prefer spaces over tabs
(setq-default indent-tabs-mode nil)
