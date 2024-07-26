;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART I - Plot Lane-Emden

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
; n=[0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5]
; and plot the results (ksi,theta).

pro stellar_part1

;Use the function lane_emden for solving the Lane-Emden equation

;------------------------------------------------------------------------;
;For n=0
;------------------------------------------------------------------------;
n1=0
results1=lane_emden(n1)
;Separate the results
ksi1=results1[*,0]
theta1=results1[*,1]

;Plot the results as (ksi,theta) for all values of n
;plot,ksi1,theta1,xrange=[0,10],yrange=[-0.1,1.1],title='Numerical solution for n=1',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5
;oplot,[0,10],[0,0],linestyle=1
;xyouts,2.1,-0.05,'n=0'

;Rn (or ksi_1 as it was marked in the lectures) is the last element of ksi1
;last=n_elements(ksi1)
;print, ksi1(last-1)

;oplot,[2.45,2.45],[-0.2,1.2],linestyle=1
;xyouts,2.6,-0.05,'!9x!X!N!D1!N = 2.4500000'

;------------------------------------------------------------------------;
;For n=0.5
;------------------------------------------------------------------------;
n2=0.5
results2=lane_emden(n2)
;Separate the results
ksi2=results2[*,0]
theta2=results2[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi2,theta2
;xyouts,2.5,-0.05,'n=0.5'

;------------------------------------------------------------------------;
;For n=1
;------------------------------------------------------------------------;
n3=1
results3=lane_emden(n3)
;Separate the results
ksi3=results3[*,0]
theta3=results3[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi3,theta3
;xyouts,3.1,-0.05,'n=1'

plot,ksi3,theta3,xrange=[0,10],yrange=[-0.1,1.1],title='Numerical solution for n=1',xtitle='!9x!X!N',ytitle='!9q!X!N',charsize=1.5
oplot,[0,10],[0,0],linestyle=1

print,ksi3(n_elements(ksi3)-1)
oplot,[3.13,3.13],[-0.2,1.2],linestyle=1
xyouts,3.3,-0.05,'!9x!X!N!D1!N = 3.1300000'

;------------------------------------------------------------------------;
;For n=1.5
;------------------------------------------------------------------------;
n4=1.5
results4=lane_emden(n4)
;Separate the results
ksi4=results4[*,0]
theta4=results4[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi4,theta4
;xyouts,3.55,-0.05,'n=1.5'

;------------------------------------------------------------------------;
;For n=2
;------------------------------------------------------------------------;
n5=2
results5=lane_emden(n5)
;Separate the results
ksi5=results5[*,0]
theta5=results5[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi5,theta5
;xyouts,4.25,-0.05,'n=2'

;------------------------------------------------------------------------;
;For n=2.5
;------------------------------------------------------------------------;
n6=2.5
results6=lane_emden(n6)
;Separate the results
ksi6=results6[*,0]
theta6=results6[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi6,theta6
;xyouts,5.25,-0.05,'n=2.5'

;------------------------------------------------------------------------;
;For n=3
;------------------------------------------------------------------------;
n7=3
results7=lane_emden(n7)
;Separate the results
ksi7=results7[*,0]
theta7=results7[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi7,theta7
;xyouts,6.75,-0.05,'n=3'

;------------------------------------------------------------------------;
;For n=3.5
;------------------------------------------------------------------------;
n8=3.5
results8=lane_emden(n8)
;Separate the results
ksi8=results8[*,0]
theta8=results8[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi8,theta8
;xyouts,9.2,-0.05,'n=3.5'

;------------------------------------------------------------------------;
;For n=4
;------------------------------------------------------------------------;
n9=4
results9=lane_emden(n9)
;Separate the results
ksi9=results9[*,0]
theta9=results9[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi9,theta9
;xyouts,9.4,0.08,'n=4'

;------------------------------------------------------------------------;
;For n=4.5
;------------------------------------------------------------------------;
n10=4.5
results10=lane_emden(n10)
;Separate the results
ksi10=results10[*,0]
theta10=results10[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi10,theta10
;xyouts,9,0.145,'n=4.5'

;------------------------------------------------------------------------;
;For n=5
;------------------------------------------------------------------------;
n11=5
results11=lane_emden(n11)
;Separate the results
ksi11=results11[*,0]
theta11=results11[*,1]

;Plot the results as (ksi,theta) for all values of n
;oplot,ksi11,theta11
;xyouts,8.6,0.21,'n=5'


end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything
PsPlot, 'stellar_part1', 'stellar_part1.ps'
end
