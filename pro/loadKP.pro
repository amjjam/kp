;+
; NAME:
;      loadKP
; PURPOSE:
;      Load a KP *.dat file created by reformKP
; CALLING SEQUENCE:
;      d=loadKP(<filename>)
; INPUTS:
;      FILENAME=STRING. Name of *.dat KP file
; OUTPUTS:
;      D={YR=LONARR(N). Year
;         MO=LONARR(N). Month
;         DY=LONARR(N). Day
;         HR=LONARR(N). Hour
;         KP=FLTARR(N). Kp 
;        }
; MODIFICATION HISTORY:
;      $Log: loadKP.pro,v $
;      Revision 1.2  2011/06/30 19:34:39  anders
;      Fixed forgot to close the file after reading.
;
;      Revision 1.1.1.1  2011/06/20 17:12:13  anders
;      This is code related to manipulating KP index data.
;
;-

function loadKP,filename

openr,un,filename,/get_lun,/compress
n=0l
readu,un,n

yr=lonarr(n) & mo=lonarr(n) & dy=lonarr(n) & hr=lonarr(n) & kp=fltarr(n)
xyr=0l & xmo=0l & xdy=0l & xhr=0l & xkp=0.

for i=0,n-1 do begin
   readu,un,xyr,xmo,xdy,xhr,xkp
   yr[i]=xyr
   mo[i]=xmo
   dy[i]=xdy
   hr[i]=xhr
   kp[i]=xkp
endfor

free_lun,un

return,{yr:yr,mo:mo,dy:dy,hr:hr,kp:kp}

end
