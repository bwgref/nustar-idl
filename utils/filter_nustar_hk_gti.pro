FUNCTION filter_nustar_hk_gti, hkdata, gti

  ngti = n_elements(gti)
  hk_filter = bytarr(n_elements(hkdata)) 
  FOR t = 0, ngti - 1 DO BEGIN
     hk_goodones = where(hkdata.time Ge gti[t].start AND $
                         hkdata.time Le gti[t].stop $ 
                         ,nhkin)
     IF nhkin GT 0 THEN $
        hk_filter[hk_goodones] = 1B
  ENDFOR

; Return the cleaned housekeeping
  cleanhk = hkdata[where(hk_filter)]

  return, cleanhk
  

END


