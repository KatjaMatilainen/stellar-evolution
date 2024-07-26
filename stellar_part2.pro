;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;
; Part II: Compare the analytical solutions for n=0 and n=1
; with the numerical ones

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

pro stellar_part2

;------------------------------------------------------------------------;
; n=0
;------------------------------------------------------------------------;
; Analytical solution
ksi0a=findgen(10000)*0.001d0
theta0a=1-1.d0/6*ksi0a^2

;Rn was analytically solved
print,'Ksi1, analytical'
print,2.44949

;Numerical solution
n0=0
results0=lane_emden(n0)
ksi0=results0[*,0]
theta0=results0[*,1]

;Plot the results as (ksi,theta)
nwin
;Numerical
plot,ksi0,theta0,xrange=[0,10],yrange=[-0.1,1.1],title='Numerical and analytical solutions for n=0',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5,thick=4
oplot,[0,10],[0,0],linestyle=1
;xyouts,2.1,-0.05,'n=0'

;Rn (or ksi_1 as it was marked in the lectures) is the last element of ksi1
last=n_elements(ksi0)
print,'Ksi1, numerical'
print,ksi0(last-1)

oplot,[2.45,2.45],[-0.2,1.2],linestyle=1
xyouts,2.6,0.05,'!9x!X!N!D1!N (numerical) = 2.4500000'

;Analytical
oplot,ksi0a,theta0a,color=130

oplot,[2.44949,2.44949],[-0.2,1.2],linestyle=1
xyouts,2.6,-0.05,'!9x!X!N!D1!N (analytical) = 2.44949'

;------------------------------------------------------------------------;
; n=1
;------------------------------------------------------------------------;
; Analytical solution
ksi1a=findgen(10000)*0.001d0
theta1a=sin(ksi1a)/ksi1a
;Rn was analytically solved
print,'Ksi1, analytical'
print,3.14159

;Numerical solution
n1=1
results1=lane_emden(n1)
ksi1=results1[*,0]
theta1=results1[*,1]

;Plot the results as (ksi,theta)
nwin
;Numerical
plot,ksi1,theta1,xrange=[0,10],yrange=[-0.1,1.1],title='Numerical and analytical solutions for n=1',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5,thick=4
oplot,[0,10],[0,0],linestyle=1
;xyouts,2.1,-0.05,'n=0'

;Rn (or ksi_1 as it was marked in the lectures) is the last element of ksi1
last=n_elements(ksi1)
print,'Ksi1, numerical'
print,ksi1(last-1)

oplot,[3.1300000,3.1300000],[-0.2,1.2],linestyle=1
xyouts,3.1300000+0.1,0.05,'!9x!X!N!D1!N (numerical) =3.1300000'

;Analytical
oplot,ksi1a,theta1a,color=130
Rna=!dpi
oplot,[Rna,Rna],[-0.2,1.2],linestyle=1
xyouts,Rna+0.2,-0.05,'!9x!X!N!D1!N (analytical) = 3.14159'


end
;------------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;------------------------------------------------------------------------;

pro plot_everything
PsPlot, 'stellar_part2', 'stellar_part2.ps'
end
