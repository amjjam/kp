;+
; NAME:
;      reformKP
; PURPOSE:
;      Reformat the KP values from potsdam .tab files to create a more
;      easily readable file format.
; CALLING SEQUENCE:
;      reformKP,<filename>
; INPUTS:
;      FILENAME=STRING. Name of .tab potsdam format.
; OUTPUTS:
;      Creates a file with the same name except the extension .tab is
;      changed to .dat
;
;      The format of the output file is as follows:
;      N=LONG. Number of times in the file.
;      then follows N data blocks like this:
;      YR=LONG. Year
;      MO=LONG. Month
;      DY=LONG. Day
;      HR=LONG. Hour
;      KP=LFOAT. Kp values 0-9 with decimal 0.0, 0.3, or 0.7
; NOTES:
;      Calls loadKpTab.pro which must be compiled prior to compiling
;      this program.
;-

pro reformKP,filename

;; spawn,'wc '+filename,result
;; n=long((str_sep(strtrim(strcompress(result),2),' '))[0])-4
;; m=8l*n

;; yr=lonarr(m) & mo=lonarr(m) & dy=lonarr(m) & hr=lonarr(m) & kp=fltarr(m)
;; line=''

;; ; First load the file

;; openr,un,filename,/get_lun

;; for i=0,n-1 do begin
;;    readf,un,line

;;    yr[8*i:8*(i+1)-1]=2000+long(strmid(line,0,2))
;;    mo[8*i:8*(i+1)-1]=long(strmid(line,2,2))
;;    dy[8*i:8*(i+1)-1]=long(strmid(line,4,2))
;;    hr[8*i:8*(i+1)-1]=indgen(8)*3
   
;;    k=8
;;    for j=0,7 do begin
;;       l=8*i+j
;;       kp[l]=float(strmid(line,k,1))
;;       c=strmid(line,k+1,1)
;;       if c eq '-' then kp[l]=kp[l]-0.3 else if c eq '+' then kp[l]=kp[l]+0.3
;;       k=k+3
;;       if j eq 3 then k=k+1
;;    endfor
;; endfor

;; free_lun,un

; Second save the new format

d=loadKpTab(filename)

ofile=strmid(filename,0,strlen(filename)-4)+".dat"

print,ofile

openw,un,ofile,/get_lun,/compress

writeu,un,m
for i=0,m-1 do begin
   writeu,un,yr[i],mo[i],dy[i],hr[i],kp[i]
endfor

free_lun,un

end


