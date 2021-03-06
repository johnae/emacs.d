;-----------;
;;; LaTeX ;;;
                                        ;-----------;
(require 'auctex-latexmk)
(auctex-latexmk-setup)

(require 'tex-site)
(require 'font-latex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)

(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'outline-minor-mode-hook
            (lambda () (local-set-key "\C-c\C-m"
                                      outline-mode-prefix-map)))


(add-hook 'message-mode-hook 'turn-on-auto-fill)

(add-hook 'text-mode-hook
  (lambda ()
  (auto-fill-mode 1)
  (setq default-justification 'full)))

;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -interaction=nonstopmode -synctex=1  -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; make latexmk -xelatex available via C-c C-c
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("xelatexmk" "latexmk -xelatex -interaction=nonstopmode -synctex=1 -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk with xelatex on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "xelatexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

(server-start); start emacs in server mode so that skim can talk to it

;; Monenclature
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list 
                '("Nomenclature" "makeindex %s.nlo -s //Users/thorey/.emacs.d/settings/nomencl.ist -o %s.nls"
                  (lambda (name command file)
                    (TeX-run-compile name command file)
                    (TeX-process-set-variable file 'TeX-command-next TeX-command-default))
                  nil t :help "Create nomenclature file")))

(provide 'latex-settings)










































































































