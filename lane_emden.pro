;------------------------------------------------------------------------;
; lane_emden.pro
;------------------------------------------------------------------------;

; Description:
; Function for solving the Lane-Emden equation for given polytropic
; index n. Creates vector ksi and solves theta for those values.
; Also added: return dTheta/dKsi

; Input: n, range (of ksi)
; Output: array result=[[ksi],[theta],[dtheta_dksi]]
;------------------------------------------------------------------------;

function lane_emden,n
;------------------------------------------------------------------------;
; Polytropic index
;------------------------------------------------------------------------;
; Polytropic index n is taken from the input
n=n

;------------------------------------------------------------------------;
; Vector ksi
;------------------------------------------------------------------------;
; Ksi has values in the range [0,300]
ksi=findgen(30000)*0.01d0

;NOTE! For some reason range 400 produces errors, find out why!

; Vectors dTheta/dKsi and Theta have the same amount of components as Ksi
dtheta_dksi=ksi*0.d0
theta=ksi*0.d0

;------------------------------------------------------------------------;
; Lane-Emden equation
;------------------------------------------------------------------------;
;Loop that solves theta[i] from ksi[i]

;Starting values
i=1
dtheta_dksi[0]=0.d0
ksi[0]=0.d0
theta[0]=1.d0

;Integration loop
while theta[i-1] gt 0.d0 do begin
if i ge n_elements(ksi) then break
;Theta
   theta[i]=theta[i-1]+(ksi[i]-ksi[i-1])*dtheta_dksi[i-1]
;if theta[i] lt 0 then do theta[i]=0.d0
;Derivative of theta
   dtheta_dksi[i]=dtheta_dksi[i-1]-(ksi[i]-ksi[i-1])*(theta[i-1]^n+2.d0/ksi[i]*dtheta_dksi[i-1])
;Increase index i
   i=i+1
endwhile

;------------------------------------------------------------------------;
;Cut the zeroes away from the end of the theta -vector, and
;make ksi to be the same length as theta.
;------------------------------------------------------------------------;

;Make new vectors ksi0 and theta0
ksi0=0.d0
theta0=1.d0
dtheta_dksi0=0.d0

j=1
while theta[j-1] gt 0.d0 do begin
if j ge n_elements(ksi) then break
theta0=[theta0,theta[j]]
ksi0=[ksi0,ksi[j]]
dtheta_dksi0=[dtheta_dksi0,dtheta_dksi[j]]
j=j+1
endwhile

;Result array is [[ksi0],[theta0],[dtheta_dksi0]]
result=[[ksi0],[theta0],[dtheta_dksi0]]

return,result
end
