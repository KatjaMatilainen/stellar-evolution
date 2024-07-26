;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;

;  PART IIIc - Polytropic constants for n=5

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

pro desperate_effort

;As the n=5 case can't be directly solved, we need to iterate n->5
;and see what values of Dn, Bn and Mn the result approaches

;------------------------------------------------------------------------;
;  Starting values
;------------------------------------------------------------------------;

;Iteration index i
i=1
;Polytropic index
n=4.d0

;The (soon-to-be) array for results [[result1],[result2],...]
;Initial value for n=4

result=lane_emden2(n)

;------------------------------------------------------------------------;
; Iteration loop where n->5
;------------------------------------------------------------------------;

while n lt 5 do begin

;Make sure the loop is not infinite
;(Later make a fancier version where the i and i+1 cases must be close
;enough for the loop to end)
if i ge 10 then break

;Increase n each step by 0.9 and 0.09 and 0.009 and so on
   n=n+0.9d0*10^(-1.d0*(i-1))

;Use the function lane_emden to solve ksi,theta,and dtheta/dksi
;for each value of n, and add the results in the result array

;Add result
   result=[[result],[lane_emden2(n)]]

;Increase i
   i=i+1
endwhile

print,'n'
print,n

;Separate the results

;ksi
   ksi_array=result[*,0,*]
;print,ksi_array

;theta
   theta_array=result[*,1,*]

;dtheta/dksi
   dtheta_dksi_array=result[*,2,*]

print,'n_elements(result)'
print,n_elements(result)

print,'n_elements(ksi_array)'
print,n_elements(ksi_array)

print,'n_elements(theta_array)'
print,n_elements(theta_array)

print,'n_elements(dtheta_dksi_array)'
print,n_elements(dtheta_dksi_array)

;-------------------------------------------------------------------------;
;Calculate and print the results
;-------------------------------------------------------------------------;

;First, check that the values make some sense

print,'final_ksi'
final_ksi=ksi_array[n_elements(ksi_array)-1,*]
print,final_ksi

print,'final_theta'
final_theta=theta_array[n_elements(ksi_array)-1,*]
print,final_theta

print,'final_dtheta_dksi'
final_dtheta_dksi=dtheta_dksi_array[n_elements(ksi_array)-1,*]
print,final_dtheta_dksi


;-------------------------------------------------------------------------;
; Make a loop for solving Rn, Dn, Mn and Bn for different values of n
;-------------------------------------------------------------------------;

j=1
;while j lt n_elements(

;-------------------------------------------------------------------------;
; Solve for Rn
;-------------------------------------------------------------------------;

Rn=final_ksi(n_elements(final_ksi)-1)
print,'Rn2(n=0.5)'
print,Rn2

;-------------------------------------------------------------------------;
; Solve for Dn
;-------------------------------------------------------------------------;

Dn=-1.d0/(3.d0/Rn*final_dtheta_dksi(n_elements(final_ksi)-1))
print,'Dn2(n=0.5)'
print,Dn2

;-------------------------------------------------------------------------;
; Solve for Mn
;-------------------------------------------------------------------------;
;Mn=-Rn^2*final_dtheta_dksi(n_elements(final_ksi)-1)
;print,'Mn2(n=0.5)'
;print,Mn2

;-------------------------------------------------------------------------;
; Solve for Bn
;-------------------------------------------------------------------------;
;Bn=(3.d0*Dn)^((3.d0-n)/(3.d0*n))/((n+1.d0)*Mn^((n-1.d0)/n)*Rn^((3.d0-n)/n))
;print,'Bn(n=0.5)'
;print,Bn


end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything
PsPlot, 'desperate_effort', 'desperate_effort.ps'
end
