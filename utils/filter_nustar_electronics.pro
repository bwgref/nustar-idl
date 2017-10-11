FUNCTION filter_nustar_electronics, data, fpm, nclean = nclean, $
                                    veto_inds = veto_inds, nveto = nveto, $
                                    nbaseline = nbaseline, nprior = nprior, $
                                    nreset = nreset

energy = data.pi * 0.04 + 1.6 ; Convert to keV

IF fpm EQ 'A' THEN begin

   baseline_filter = data.prephas[4] LT 1900 AND energy LT 25.
   baseline_filter2 = data.prephas[4] gt 13500

   prior_filter = data.prior lt 30e-6
   prior_filter_2 = data.prior GT 0.86e-3 AND data.prior LT 0.91e-3 AND energy LT 26.5

   reset_filter = data.reset lt 27.3e-6
   reset_filter_2 = data.reset gt 196e-6 AND data.reset lt 215e-6 AND energy GT 23 AND energy LT 26.5

   data_filter = baseline_filter or baseline_filter2 or $
                 prior_filter or prior_filter_2 or $
                 reset_filter or reset_filter_2
ENDIF
IF fpm EQ 'B' THEN BEGIN
   baseline_filter = data.prephas[4] LT 2100 AND energy LT 25.
;   baseline_filter2 = data.prephas[4] ge 13500

   prior_filter = data.prior lt 100e-6
   reset_filter = data.reset lt 27.3e-6

   data_filter = baseline_filter or $
                    prior_filter or reset_filter

endif

baseline_fail = where(baseline_filter, nbaseline)
prior_fail = where(prior_filter, nprior)
reset_fail = where(reset_filter, nreset)

clean = where(~data_filter, nclean)
veto_inds = where(data_filter, nveto) 


return, clean


END


