#lang racket/gui
;;*****************************************
;;Copyright 2015 Sasha <movr1r2@gmail.com>

;;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
;;WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
;;INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;;OF MERCHANTABILITY,FITNESS FOR A PARTICULAR
;;PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
;;SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
;;LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
;;LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;;TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;;CONNECTION WITH THE SOFTWARE OR THE USE OR 
;;OTHER DEALINGS IN THE SOFTWARE.
;;*******************************************

(define lst1 (file->list  "upr.conf"))
(define player  (car  lst1))
(define  spisok  (cdr  lst1))


(define  lst   (file->list  (car  spisok)))



;;********************************************************
(define frame (new frame% [label "muzon"])) 
(define msg (new message% [parent frame] 
                          [label "Ipsa olera olla legit"])) 
(define panel (new horizontal-panel% [parent frame])) 
(define  boxlist 
(new list-box%   [label  " "]
                           [choices   spisok]
						   [parent  panel]
						   [selection  0]
						   [min-width  80]
						     (callback  (lambda (list-box event)
							   (lstbx)  ))))
;;**********************************************************

;;**********************************************************
(define regim
(new radio-box%  [label  "regim"]
                             [choices  '("regular"  "random"  "uno-random") ]
							 [parent  panel]
							 (callback (lambda (radio-box  event) 
                         (send msg set-label ( ~a (send  regim  get-selection)))
						 ;(lambda (radio-box event)  (define  rgm (send regim get-selection)))
						 ))) )
;;***************************************************************

(new button%  [label "start"]
                         [parent panel]
						  (callback (lambda (button event) 
                         (strt)))) 
;;****************************************************************
(new button%  [label "play dir"]
                         [parent panel]
						  (callback (lambda (button event) 
                         (pl-dir)))) 
;;*****************************************************************

(send frame show #t) 
;;****************************************************************
;(send msg set-label (~a  (send  regim  get-selection)))
;;****************************************************************

(define (strt) 
             ((let  ([a  (send  regim  get-selection)]) 

(thread  (lambda () (			 
			 (cond [(= 0 a) (map (lambda (x) (system* "play.exe"  x) ) lst )]
             [(= 1 a) (map (lambda (x) (system* "play-rand.exe" x) ) (shuffle lst))]
		     [(= 2 a) (map (lambda (x) (system* "play-uno.exe"  x) ) (shuffle lst))]) )))  )))  
;;****************************************************************************

(define  (pl-dir)
(thread (lambda ()  (
(system* "play.exe" (get-directory)))
   )))
 ;;****************************************************************************

;;****************************************************************************
(define  (lstbx) ( let  ([i (send  boxlist  get-selections)])
                                 ( set! lst  (file->list (list-ref spisok (car i))) )  )   )
								 
;;********************************************************************************
;;(define (play  pap)  ((current-directory pap) 
  ;;                             (map (lambda (x)  (system* player  x)) 
    ;;                           (glob-mp3 (directory-list pap)) )))
		;;					   
;;*********************************************************************************
;;(define (play-rand pap)
  ;;            ( (current-directory pap)
    ;;            (map (lambda (x) (system* player x))
      ;;            (shuffle (glob-mp3 (directory-list pap)))     )))
		;;		  
;;*********************************************************************************

;;(define  (play-uno  pap)
  ;;                              ( (current-directory  pap)
    ;;                            (system*  player  (car (shuffle (glob-mp3 (directory-list pap))) ))))
		;;		 
;;***********************************************************************************