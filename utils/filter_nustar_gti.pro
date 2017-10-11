FUNCTION filter_nustar_gti, data, hkdata, gti, $
                            cleanhk = cleanhk, $
                            nclean = nclean, veto_inds = veto_inds, nveto = nveto
  
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

  hkind = floor(data.time - min(hkdata.time))
  gti_filter = hk_filter[hkind]

  clean = where(gti_filter, nclean)
  veto_inds = where(~gti_filter, nveto)
  return, clean
  

END


