;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq load-path (cons "~/.emacs.d/custom-lisp/" load-path))

(when (equal system-type 'darwin)
  (require 'cask))
(when (equal system-type 'gnu/linux)
  (require 'cask "~/.cask/cask.el"))
(cask-initialize)

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(keyboard-translate ?\C-h ?\C-?)
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))
(load-theme 'wombat t)
(load-theme 'madhat2r t)

;; emmet-mode
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(setq emmet-move-cursor-between-quotes t)

;; neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
(setq neo-smart-open t)

(progn
  (require 'whitespace)
  (setq whitespace-style
        '(
          face ; faceで可視化
          trailing ; 行末
          tabs ; タブ
          spaces ; スペース
          space-mark ; 表示のマッピング
          tab-mark
          ))
  (setq whitespace-display-mappings
        '(
          (space-mark ?\u3000 [?\u2423])
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
          ))
  (setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (set-face-attribute 'whitespace-trailing nil
                      :foreground "RoyalBlue4"
                      :background "RoyalBlue4"
                      :underline nil)
  (set-face-attribute 'whitespace-tab nil
                      :foreground "yellow4"
                      :background "yellow4"
                      :underline nil)
  (set-face-attribute 'whitespace-space nil
                      :foreground "gray40"
                      :background "gray20"
                      :underline nil)
  (global-whitespace-mode t)
  )


;; タブ幅をスペース2つ分にする
(setq-default tab-width 2)

;; 基本インデントの設定
(setq-default c-basic-offset 2     ;;基本インデント量2
              tab-width 2          ;;タブ幅2
              indent-tabs-mode nil)  ;;インデントをタブでするかスペースでするか


;; 行番号の表示
(global-linum-mode t)
(setq linum-format "%4d:")

;; 更新のあったファイルの自動再読み込み
(global-auto-revert-mode 1)

;; Auto Complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ


;; Ruby
(setq ruby-insert-encoding-magic-comment nil) ;; マジックコメント挿入無効化

;; python-mode
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (madhat2r-theme snazzy-theme base16-theme ensime scala-mode whitespace-cleanup-mode vue-mode anything rinari yasnippet web-mode-edit-element use-package smex smartparens python-mode projectile prodigy popwin pallet package-utils nyan-mode neotree multiple-cursors magit jedi-direx idle-highlight-mode htmlize flycheck-cask expand-region exec-path-from-shell emmet-mode drag-stuff auto-virtualenvwrapper)))
 '(py-indent-offset 4))

(add-hook 'python-mode-hook
          '(lambda()
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             )
          )

;;jedi
(require 'epc)
(require 'auto-complete-config)
(require 'python)

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; virtualenvwrapper
(require 'virtualenvwrapper)
(require 'auto-virtualenvwrapper)
(add-hook 'python-mode-hook 'auto-virtualenvwrapper-activate)



;; web-mode
(require 'web-mode)
;;; 適用する拡張子
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?$"      . web-mode))
(add-to-list 'auto-mode-alist '("\\.js[x]?$"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx?$"      . web-mode))

;; 拡張子 .js でもJSX編集モードに
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;;; インデント数
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  )
(add-hook 'web-mode-hook 'web-mode-hook)

;; React用のインデント設定
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-attr-indent-offset nil)
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             (setq web-mode-sql-indent-offset 2)
             (setq indent-tabs-mode nil)
             (setq tab-width 2)
             ))

;; ;; React用の色
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(mmm-default-submode-face ((t nil)))
;;  '(web-mode-comment-face ((t (:foreground "#587F35"))))
;;  '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
;;  '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
;;  '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
;;  '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
;;  '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
;;  '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
;;  '(web-mode-css-string-face ((t (:foreground "#D78181"))))
;;  '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
;;  '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
;;  '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
;;  '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
;;  '(web-mode-html-tag-bracket-face ((t (:foreground "#4A8ACA"))))
;;  '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
;;  '(web-mode-server-comment-face ((t (:foreground "#587F35"))))
;;  '(whitespace-trailing ((t (:background "red1" :foreground "yellow" :underline t :weight bold)))))


(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; web-modeの設定
  (setq web-mode-markup-indent-offset 2) ;; html indent
  (setq web-mode-css-indent-offset 2) ;; css indent
  (setq web-mode-code-indent-offset 2) ;; script indent(js,php,etc..)
  ;; htmlの内容をインデント
  ;; TEXTAREA等の中身をインデントすると副作用が起こったりするので
  ;; デフォルトではインデントしない
  ;;(setq web-mode-indent-style 2)
  ;; コメントのスタイル
  ;; 1:htmlのコメントスタイル(default)
  ;; 2:テンプレートエンジンのコメントスタイル
  ;; (Ex. {# django comment #},{* smarty comment *},{{-- blade comment --}})
  (setq web-mode-comment-style 2)
  ;; 終了タグの自動補完をしない
  ;;(setq web-mode-disable-auto-pairing t)
  ;; color:#ff0000;等とした場合に指定した色をbgに表示しない
  ;;(setq web-mode-disable-css-colorization t)
  ;;css,js,php,etc..の範囲をbg色で表示
  ;; (setq web-mode-enable-block-faces t)
  ;; (custom-set-faces
  ;; '(web-mode-server-face
  ;; ((t (:background "grey")))) ; template Blockの背景色
  ;; '(web-mode-css-face
  ;; ((t (:background "grey18")))) ; CSS Blockの背景色
  ;; '(web-mode-javascript-face
  ;; ((t (:background "grey36")))) ; javascript Blockの背景色
  ;; )
  ;;(setq web-mode-enable-heredoc-fontification t)
  ;; auto tag closing
  ;; 0=no auto-closing
  ;; 1=auto-close with </
  ;; 2=auto-close with > and </
  (setq web-mode-auto-close-style 2)
  (setq web-mode-tag-auto-close-style 2)
  )



;; 色の設定

                                        ;コメント
(add-hook 'web-mode-hook 'web-mode-hook)


;; Javascriptインデント
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; vue-mode
(require 'vue-mode)
(defun vue-mode/init-vue-mode ()
  (use-package vue-mode
    :config
    ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
    (setq mmm-submode-decoration-level 1)))

;; pallet
(require 'pallet)



;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)
;; Rinari
(add-to-list 'load-path "~/path/to/your/elisp/rinari")
(require 'rinari)

;; prettier
(require 'prettier-js)

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.js[x]?\\'" . prettier-js-mode))))

(add-hook 'web-mode-hook #'(lambda ()
                             (enable-minor-mode
                              '("\\.tsx?\\'" . prettier-js-mode))))

;; (add-hook 'web-mode-hook 'prettier-js-mode)

(defun my/prettier ()
  (interactive)
  (shell-command
   (format "%s --write %s"
           (shell-quote-argument (executable-find "prettier"))
           (shell-quote-argument (expand-file-name buffer-file-name))))
  (revert-buffer t t t))

(global-set-key (kbd "C-c C-p") 'my/prettier)

(add-hook 'markdown-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'my/prettier t t)))

;; scala-mode
;; 動かん
;;(require 'scala-mode-auto)
