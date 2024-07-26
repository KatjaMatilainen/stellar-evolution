;------------------------------------------------------------------------;
; lane_emden2.pro - for case n=5
;------------------------------------------------------------------------;

; Description:
; Function for solving the Lane-Emden equation for given polytropic
; index n. Creates vector ksi and solves theta for those values.
; Also added: return dTheta/dKsi

; This version is optimized for solving the n=5 case.
; For other values of n, use 'lane_emden.pro'

; Input: n
; Output: array result=[[ksi], [theta],[dtheta_dksi]]
;------------------------------------------------------------------------;

function lane_emden2,n
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
while i lt n_elements(ksi) do begin
if theta[i-1] le 0 then break
;Theta
   theta[i]=theta[i-1]+(ksi[i]-ksi[i-1])*dtheta_dksi[i-1]
;Derivative of theta
   dtheta_dksi[i]=dtheta_dksi[i-1]-(ksi[i]-ksi[i-1])*(theta[i-1]^n+2.d0/ksi[i]*dtheta_dksi[i-1])
;Increase index i
   i=i+1
endwhile

;Result array is [[ksi],[theta],[dtheta_dksi]]
result=[[ksi],[theta],[dtheta_dksi]]

return,result
end
