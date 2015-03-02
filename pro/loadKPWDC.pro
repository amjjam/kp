function loadKPWDC,xfiles

;+
; NAME:
;   loadKPWDC
; PURPOSE:
;   Load one or more WDC Kp data files
; CALLING SEQUENCE:
;   d=loadKPWDC(files)
; INPUTS:
;   FILES=STRING or STRARR
; OUTPUTS:
;   D=array of{
;     YR=LONG.
;     MO=LONG.
;     DY=LONG
;     HR=LONG.
;     EPOCH=DOUBLE. TT2000 Epoch
;     KP=FLOAT
;     }
;-

  template={yr:0l,mo:0l,dy:0l,hr:0l,epoch:0d,kp:0.}
  n=1l
  d=[template]
  i=0l
  line=''

  files=[xfiles]  
  for j=0,n_elements(xfiles)-1 do begin
     openr,un,xfiles[j],/get_lun
     while not eof(un) do begin
        readf,un,line
        yr=long(strmid(line,0,2))
        if yr gt 50 then $
           yr+=1900 $
        else $
           yr+=2000
        mo=long(strmid(line,2,2))
        dy=long(strmid(line,4,2))
        for k=0,7 do begin
           if i eq n then begin
              d=[d,d]
              n*=2
           endif
           d[i].yr=yr
           d[i].mo=mo
           d[i].dy=dy
           d[i].hr=k*3
           cdf_tt2000,tepoch,yr,mo,dy,d[i].hr,0,/compute_epoch
           d[i].epoch=tepoch
           d[i].kp=float(strmid(line,12+k*2,2))/10.
           i++
        endfor        
     endwhile
     free_lun,un
  endfor
  i--
  d=d[0:i]
  
  return,d
end
