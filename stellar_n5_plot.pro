;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART IIIb - Plot Lane-Emden for polytrope n=5

; Note: this is only for plotting (ksi, theta) for n=5.
; Polytropic constants for n=5 are solved in 'stellar_n5_iter.pro'

;------------------------------------------------------------------------;
; Use the subroutine PsPlot to save results in a postscript plot 
; (written by Heikki Salo)
;------------------------------------------------------------------------;

pro PsPlot,routine,filename
	thisdir=getenv('PWD')+'/'
	psopen,/color,dir=thisdir,filename
	call_procedure,routine
	psclose		
end
;------------------------------------------------------------------------;


;------------------------------------------------------------------------;
;  MAIN PROGRAM starts here
;------------------------------------------------------------------------;
; Solve the Lane-Emden equation for
; n=[5]
; and plot the results (ksi,theta).

pro stellar_poly5

;Use the function lane_emden for solving the Lane-Emden equation

;------------------------------------------------------------------------;
;For n=5
;------------------------------------------------------------------------;
n11=5.d0
;n11=4.99d0
results11=lane_emden(n11)
;Separate the results
ksi11=results11[*,0]
theta11=results11[*,1]

print,n_elements(theta11)
print,theta11

;Plot the results as (ksi,theta) for n=5
plot,ksi11,theta11,xrange=[0,300],yrange=[-0.1,1.1],title='Lane-Emden, n=5',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5
oplot,[0,300],[0,0],linestyle=1
;xyouts,2.1,-0.05,'n=0'
;oplot,[65,65],[-0.2,1.2],linestyle=1
;xyouts,8.6,0.21,'n=5'


end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything
PsPlot, 'stellar_n5_plot', 'stellar_n5_plot.ps'
end
