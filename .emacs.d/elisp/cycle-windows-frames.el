(require 'dash)

(defun cycle-windows ()
  "Cycle windows."
  (interactive)
  (let* ((ws (window-list))
         (bs (mapcar 'window-buffer ws)))
    (-zip-with 'set-window-buffer ws (-snoc (cdr bs) (car bs)))))

(defun cycle-frames ()
  "Cycle states of frames."
  (interactive)
  (let* ((ws (mapcar 'frame-root-window (frame-list)))
         (ss (mapcar (lambda (w) (window-state-get w t)) ws)))
    (mapcar 'raise-frame (frame-list)) 
    (-zip-with (lambda (s w) (window-state-put s w 'safe)) (-snoc (cdr ss) (car ss)) ws)))

(defun cycle-multiframe-windows ()
  (interactive)
  (let* ((wins (mapcan 'window-list (frame-list)))
         (bufs (mapcar 'window-buffer wins)))
    (mapcar 'raise-frame (frame-list))
    (-zip-with 'set-window-buffer wins (-snoc (cdr bufs) (car bufs)))))