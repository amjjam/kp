;+
; NAME:
;      loadKpTab
; PURPOSE:
;      Loads the content of a *.tab file from potsdam
; CALLING SEQUENCE:
;      d=loadKpTab(file)
; INPUTS:
;      FILE=STRING. Name of *.tab file to load.
; OUTPUTS:
;      D={YR=LONARR(N) Year
;         MO=LONARR(N) Month
;         DY=LONARR(N) Day
;         HR=LONARR(N) Hour
;         KP=FLTARR(N) Kp value
;        }
;-

function loadKpTab,filename

  spawn,'wc '+filename,result
  n=long((str_sep(strtrim(strcompress(result),2),' '))[0])-4
  m=8l*n
  
  yr=lonarr(m) & mo=lonarr(m) & dy=lonarr(m) & hr=lonarr(m) & kp=fltarr(m)
  line=''
  
  openr,un,filename,/get_lun
  
  for i=0,n-1 do begin
     readf,un,line
     
     yr[8*i:8*(i+1)-1]=2000+long(strmid(line,0,2))
     mo[8*i:8*(i+1)-1]=long(strmid(line,2,2))
     dy[8*i:8*(i+1)-1]=long(strmid(line,4,2))
     hr[8*i:8*(i+1)-1]=indgen(8)*3
     
     k=8
     for j=0,7 do begin
        l=8*i+j
        kp[l]=float(strmid(line,k,1))
        c=strmid(line,k+1,1)
        if c eq '-' then kp[l]=kp[l]-0.3 else if c eq '+' then kp[l]=kp[l]+0.3
        k=k+3
        if j eq 3 then k=k+1
     endfor
  endfor
  
  free_lun,un

  return,{yr:yr,mo:mo,dy:dy,hr:hr,kp:kp}
end
