FUNCTION filter_nustar_badpix, data, nclean = nclean, $
                               veto_inds = veto_inds, nveto = nveto, $
                               nodepth = nodepth, $
                               depth_ind = depth_ind

; Okay, now clean out the nuflagbad STATUS flags:
badpix = 1B
dispix = 2B
userpix = 4B
nearbadpix= 8B
edge = 16B
hotpix = 32B
neighborhot=64B
depth=128B


IF keyword_set(nodepth) THEN begin 
   badfilter = (data.status[1] AND badpix) EQ badpix OR $
               (data.status[1] AND dispix) EQ dispix OR $
               (data.status[1] AND hotpix) EQ hotpix
   depth_ind = where( (data.status[1] AND depth) EQ depth)
   print, 'Not applying depth cut...'
ENDIF ELSE BEGIN
   print, 'Applying depth cut...'
   badfilter = (data.status[1] AND badpix) EQ badpix OR $
               (data.status[1] AND dispix) EQ dispix OR $
               (data.status[1] AND hotpix) EQ hotpix  OR $
               (data.status[1] AND depth) EQ depth
ENDELSE





clean = where(~badfilter, nclean)
veto_inds =  where(badfilter, nveto)

return, clean


END


