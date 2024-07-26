;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;

; Solving the polytropic constants for n=5
; (hopefully) final version

pro constants_n5

n=5

;------------------------------------------------------------------------;
;  Rn
;------------------------------------------------------------------------;
;Instead of solving the Rn from Lane-Emden equation like in the
;previous versions, just set Rn to be ridiculously large

;Rn=10.d0^38
Rn=10.d0^99

;------------------------------------------------------------------------;
; (dtheta/dksi)_ksi1
;------------------------------------------------------------------------;
;The derivative of the analytical solution (at ksi=Rn) is:

dtheta_dksi=-0.5d0*(1.d0+Rn^2/3.d0)^(-1.5d0)*2.d0/3*Rn

;------------------------------------------------------------------------;
; Dn
;------------------------------------------------------------------------;
Dn=-1.d0/(3.d0/Rn*dtheta_dksi)
print,'Dn'
print,Dn

print,'Compare with: infinity'

;------------------------------------------------------------------------;
; Mn
;------------------------------------------------------------------------;
Mn=-Rn^2*dtheta_dksi
print,'Mn'
print,Mn

print,'Compare with:'
print,sqrt(3.d0)

;------------------------------------------------------------------------;
; Bn
;------------------------------------------------------------------------;
Bn=(3.d0*Dn)^((3.d0-n)/(3.d0*n))/((n+1.d0)*Mn^((n-1.d0)/n)*Rn^((3.d0-n)/n))
print,'Bn'
print,Bn

print,'Compare with:'
print,(3.d0^(1.d0/3)*6.d0)^(-1.d0)

end
