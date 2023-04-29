; Needed packages:
; sudo apt-get install xautomation
; sudo apt-get install xbindkeys

; bind shift + vertical scroll to horizontal scroll events
(xbindkey '(shift "b:4") "xte 'mouseclick 6'")
(xbindkey '(shift "b:5") "xte 'mouseclick 7'")

; Then run "xbindkeys" in terminal
