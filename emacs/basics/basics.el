;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

(icomplete-mode 1)


;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.config/emacs/config.org"))

;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)
