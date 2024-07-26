;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;

;Plot the n=0 and n=1 analytical solutions for Lane-Emden equation

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

pro analytical
;------------------------------------------------------------------------;
; Vector ksi
;------------------------------------------------------------------------;
; Ksi has values in the range [0,10]
;ksi=findgen(10000)*0.001d0

;range [0,300] for n=5
ksi=findgen(300000)*0.001d0

;------------------------------------------------------------------------;
; Vector theta
;------------------------------------------------------------------------;
; Vector Theta has the same amount of components as Ksi
;Fist option is for n=0 and the second for n=1
;theta=1-1.d0/6*ksi^2
;theta=sin(ksi)/ksi

;for n=5
theta=(1.d0+ksi^2/3.d0)^(-0.5d0)

;Plot the results as (ksi,theta) for all values of n
plot,ksi,theta,xrange=[0,300],yrange=[-0.1,1.1],title='Lane-Emden, analytical solution for n=5',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5
oplot,[0,300],[0,0],linestyle=1

;Rn=!pi
;print,Rn
;oplot,[Rn,Rn],[-0.2,1.2],linestyle=1
;xyouts,3.75,-0.05,'!9x!X!N!D1!N = 3.14159'

end

;------------------------------------------------------------------------;

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro plot_analytical
PsPlot, 'analytical', 'analytical.ps'
end
