FUNCTION filter_nustar, data, hkdata, gti=gti, fpm, $
                        cleanhk = cleanhk


IF keyword_set(gti)  THEN begin 
   ngti = n_elements(gti)
   hk_filter = bytarr(n_elements(hkdata)) 
   FOR t = 0, ngti - 1 DO BEGIN
      hk_goodones = where(hkdata.time Ge gti[t].start AND $
                          hkdata.time Le gti[t].stop $ 
                          ,nhkin)
      IF nhkin GT 0 THEN $
         hk_filter[hk_goodones] = 1B
   ENDFOR
   cleanhk = hkdata[where(hk_filter)]
ENDIF ELSE BEGIN
   cleanhk = hkdata
   hk_filter = bytarr(n_elements(hkdata)) + 1B
ENDELSE


; Generic filters:
hkind = round(data.time - min(hkdata.time))
gti_filter = hk_filter[hkind]
grade_filter = data.grade LT 27
status_filter = data.status[0] EQ 0
shield_filter = data.shield EQ 0


filter = gti_filter AND grade_filter AND status_filter AND shield_filter
goodones = where(filter, ngood)

IF ngood EQ 0 THEN BEGIN
   print, 'Too harsh filters!'
   stop
ENDIF
cleandata = data[goodones]                     

return, cleandata


END


