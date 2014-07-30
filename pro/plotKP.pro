;+
; NAME:
;      plotkP
; PURPOSE:
;      Plot a KP data set
; CALLING SEQUENCE:
;      plotKP,d
; INPUTS:
;      D={}. Data structure returned by loadKP()
;      T0=[YR,MO,DY,HR,MN,SE,MS]. Time to use as zero point.
; OUTPUTS:
;      Generates a plot.
; KEYWORDS:
;
; MODIFICATION HISTORY:
;      $Log: plotKP.pro,v $
;      Revision 1.2  2011/06/30 14:11:25  anders
;      Added keywords.
;
;      Revision 1.1  2011/06/30 13:14:23  anders
;      Added a program for plotting KP data.
;
;-

pro plotKP,d,t0,_extra=extra
  
  t=dblarr(n_elements(d.yr))

  for i=0,n_elements(d.yr)-1 do begin
     cdf_epoch,xt,d.yr[i],d.mo[i],d.dy[i],d.hr[i],/compute_epoch
     t[i]=xt
  endfor
  
  tt0=t0
  if n_elements(tt0) lt 7 then tt0=[tt0,lonarr(7-n_elements(tt0))]
  cdf_epoch,xt0,tt0[0],tt0[1],tt0[2],tt0[3],tt0[4],tt0[5],tt0[6],$
            /compute_epoch
  
  t=(t-xt0)/86.4d6
  
  hr0=strtrim(tt0[3],2)
  if strlen(hr0) eq 1 then hr0='0'+hr0
  mn0=strtrim(tt0[4],2)
  if strlen(mn0) eq 1 then mn0='0'+mn0
  se0=strtrim(tt0[5],2)
  if strlen(se0) eq 1 then se0='0'+se0
  xtitle='Days since '+strtrim(tt0[0],2)+'/'+strtrim(tt0[1],2)+'/'+$
         strtrim(tt0[2],2)+' '+hr0+':'+mn0+':'+se0
  
  plot,t,d.kp,xtitle=xtitle,ytitle='K!DP!N',psym=10,_extra=extra
end

