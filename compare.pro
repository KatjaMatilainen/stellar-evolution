;------------------------------------------------------------------------;
; Stellar structure and evolution
; Computer assignment for advanced students
;------------------------------------------------------------------------;
; Final part - compare to a more realistic solar model
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
; MAIN PROGRAM starts here
;------------------------------------------------------------------------;
pro compare

;------------------------------------------------------------------------;
; Read data from bs05_agsop.dat -file
; 12 columns, 1284 rows
;------------------------------------------------------------------------;

;create empty array
data=fltarr(12,1284)
;open the data file
openr,lun,'bs05_agsop.dat',/get_lun
;read data
readf,lun,data
;close the file
close,/all
;check the data array
help,data
;print,data

;Separate the columns that are needed

mass=reform(data(0,*))
;help,mass
;print,mass

radius=reform(data(1,*))
;help,radius
;print,radius


temperature=alog10(reform(data(2,*)))
;help,temperature
;print,temperature
;Central temperature:
temperature_c=data(2,0)
print,'Central temperature (K)'
print,temperature_c

;Central density:
density_c=data(3,0)*1000.d0
print,'Central density (kg/m^3)'
print,density_c
;Density:
density=reform(data(3,*))*1000.d0
density_log=alog10(density)
;help,density
;print,density

pressure=reform(data(4,*))*0.1d0
pressure_log=alog10(pressure)
;Central pressure
pressure_c=data(4,0)*0.1d0
print,'Central pressure (Pa)'
print,pressure_c
;help,pressure
;print,pressure

;------------------------------------------------------------------------;
; Solar model:
; log(rho) as a function of R/Rsol
;------------------------------------------------------------------------;
;!p.multi=[0,2,2]
;nwin
;plot,radius,density_log,xtitle='R/Rsol',ytitle='log(!9r!X!N)',title='Density profile (logarithmic), solar model';,yrange=[-10,0]

;Non-logarithmic density
;nwin
;plot,radius,density,xtitle='R/Rsol',ytitle='!9r!X!N(r)',title='Density profile, solar model';,yrange=[-10,0]

;------------------------------------------------------------------------;
; Solar model:
; log(P) as a function of R/Rsol
;------------------------------------------------------------------------;
;nwin
;plot,radius,pressure_log,xtitle='R/Rsol',ytitle='log(P)',title='Pressure profile (logarithmic), solar model'

;Non-logarithmic pressure
;nwin
;plot,radius,pressure,xtitle='R/Rsol',ytitle='P(r)',title='Pressure profile, solar model'

;------------------------------------------------------------------------;
; Solar model:
; M/Msol as a function of R/Rsol
;------------------------------------------------------------------------;
;nwin
;plot,radius,mass,xtitle='R/Rsol',ytitle='M/Msol',title='Mass profile, solar model'

;------------------------------------------------------------------------;
; Solar model:
; log(T) as a function of R/Rsol
;------------------------------------------------------------------------;
;nwin
;plot,radius,temperature,xtitle='R/Rsol',ytitle='log(T)',title='Temperature profile (logarithmic), solar model'

;------------------------------------------------------------------------;
; Profiles for n=3 polytrope
;------------------------------------------------------------------------;

; Solve the Lane-Emden equation for n=3
n=3.d0
results=lane_emden(n)
ksi=results[*,0]
theta=results[*,1]
dtheta_dksi=results[*,2]

; Solve Rn
Rn=ksi(n_elements(ksi)-1)
print,'Rn'
print,Rn

; Solve Mn
Mn=-Rn^2*dtheta_dksi(n_elements(ksi)-1)
print,'Mn'
print,Mn

; Solve Dn
Dn=-(3.d0/Rn*dtheta_dksi(n_elements(ksi)-1))^(-1.d0)
print,'Dn'
print,Dn

; Solve Bn
Bn=(3.d0*Dn)^((3.d0-n)/(3*n))/((n+1.d0)*Mn^((n-1.d0)/n)*Rn^((3.d0-n)/n))
print,'Bn'
print,Bn

;-----------------------------------------------------------------------;
; n=3: Density profile
;-----------------------------------------------------------------------;
; Transform theta(ksi) -> rho(r/R)
; r/R = ksi/Rn and rho/rho_c = theta^n

; Solar mass (in kg)
Msol=1.9891d0*10.d0^30.d0
; Solar radius (in m)
Rsol=6.955d0*10.d0^8
; Solar volume (in m^3)
Vsol=4.d0/3*!dpi*Rsol^3
; Central density
rho_c=Dn*Msol/Vsol
print,'Central density from n3 (kg/m^3)'
print,rho_c

; Relative radius r/R
radius_n3=ksi/Rn

; Density rho
densityn3=theta^n*rho_c
; log(rho)
density_n3=alog10(densityn3)

; Plot (r,rho)
;nwin
;plot,radius_n3,density_n3,title='Density profile (logarithmic), n=3 polytrope',xtitle='r/Rsol',ytitle='log(!9r!X!N)';,yrange=[-10,0]

;----------------------------------------------------------------------;
; ABSOLUTE density rho (kg/m^3)
;----------------------------------------------------------------------;
;Absolute density = (rho/rho_c)*rho_c
rho=densityn3;*rho_c

;Plot rho and compare with lecture notes
;nwin
;plot,radius_n3,densityn3,title='Density profile, n=3 polytrope',xtitle='r/Rsol',ytitle='!9r!X(r)!N'

;-----------------------------------------------------------------------;
; ABSOLUTE radius (m)
;-----------------------------------------------------------------------;
Rabs=radius_n3*Rsol

;-----------------------------------------------------------------------;
; n=3: Mass profile
;-----------------------------------------------------------------------;

;Integrate from density profile
;dM=rho(r)*4*pi*r^2*dr

mass_n3=radius_n3*0.d0
i=1
while i lt n_elements(radius_n3) do begin
  dr=Rabs[i]-Rabs[i-1]
  mass_n3[i]=mass_n3(i-1)+rho[i]*4.d0*!dpi*Rabs[i]^2*dr
  i=i+1
endwhile

; Scale the mass to M/Msol
massn3=mass_n3/max(mass_n3)

;print,mass_n3
;Plot this after the pressure profiles
;plot,radius_n3,massn3,title='Mass profile, n=3 polytrope',xtitle='r/Rsol',ytitle='M/Msol'

;-----------------------------------------------------------------------;
; n=3: Pressure profile
;-----------------------------------------------------------------------;
;Gravitational constant (m^3/(kg*s^2))
G=6.67408d0*10^(-11.d0)

;Central pressure
press_c=(4.d0*!dpi)^(1.d0/3)*Bn*G*Msol^(2.d0/3)*rho_c^(4.d0/3)
print,'Central pressure (Pa)'
print,press_c

;-----------------------------------------------------------------------;
; Solve the pressure profile from polytropic eq. of state  P=K*rho^gamma, 
; where gamma=1+1/n is the adiabatic index
;-----------------------------------------------------------------------;

;Adiabatic index
gamma=1.d0+1.d0/n

;Constant K
K=(4.d0*!dpi*G/(n+1.d0)^n*(G*Msol/Mn)^(n-1.d0)*(Rsol/Rn)^(3.d0-n))^(1.d0/n)

;Polytropic eq. of state
press_n3=K*rho^gamma

;log(P)
pressn3=alog10(press_n3)

;nwin
;plot,radius_n3,pressn3,title='Pressure profile (logarithmic), n=3 polytrope',xtitle='r/Rsol',ytitle='log(P)'

;nwin
;plot,radius_n3,press_n3,title='Pressure profile, n=3 polytrope',xtitle='r/Rsol',ytitle='P(r)'

;Plot the mass profile now
;nwin
;plot,radius_n3,massn3,title='Mass profile, n=3 polytrope',xtitle='r/Rsol',ytitle='M/Msol'

;-----------------------------------------------------------------------;
; n=3: Temperature profile
;-----------------------------------------------------------------------;
;Assume that the gas in Sun is non-degenerate -> ideal gas
;P=RR/mu*rho*T -> T=P*mu/(RR*rho)

;Specific ideal gas constant RR (J/(mol*K))
;RR=kB/mH (from the lectures)
RR=1.3806488*10^(-23.d0)/(1.008d0*1.660539*10.d0^(-27.d0))
print,'RR'
print,RR

;Ratio of ions and electrons
mu=0.61d0

;Temperature
temp_n3=press_n3*mu/(RR*rho)

;log(T)
tempn3=alog10(temp_n3)

;plot,radius_n3,tempn3,title='Temperature profile (logarithmic), n=3
;polytrope',xtitle='r/Rsol',ytitle='log(T)'

;Central temperature Tc
mu=0.61d0
Tc_n3=mu*press_c/(RR*rho_c)
print,'Central temperature from n3'
print,Tc_n3

;------------------------------------------------------------------------;
; COMBINED FINAL PLOTS
;------------------------------------------------------------------------;

;------------------------------------------------------------------------;
; log(rho) as a function of R/Rsol
;------------------------------------------------------------------------;
!p.multi=[0,2,2]
nwin
plot,radius,density_log,xtitle='R/Rsol',ytitle='log(!9r!X!N)',title='Density profile (logarithmic)',thick=3;,yrange=[-10,20]
oplot,radius_n3,density_n3,col=130,thick=3

nwin
plot,radius,density,xtitle='R/Rsol',ytitle='!9r!X!N',title='Density profile',thick=3;,yrange=[-10,20]
oplot,radius_n3,densityn3,col=130,thick=3

;------------------------------------------------------------------------;
; log(P) as a function of R/Rsol
;------------------------------------------------------------------------;
nwin
plot,radius,pressure_log,xtitle='R/Rsol',ytitle='log(P)',title='Pressure profile (logarithmic), solar model',thick=3;,yrange=[0,30]
oplot,radius_n3,pressn3,col=130,thick=3

;Non-logarithmic pressure
nwin
plot,radius,pressure,xtitle='R/Rsol',ytitle='P(r)',title='Pressure profile, solar model',thick=3;,yrange=[0,2*10^19]
oplot,radius_n3,press_n3,col=130,thick=3

;------------------------------------------------------------------------;
; M/Msol as a function of R/Rsol
;------------------------------------------------------------------------;
nwin
plot,radius,mass,xtitle='R/Rsol',ytitle='M/Msol',title='Mass profile',thick=3
oplot,radius_n3,massn3,col=130,thick=3

;------------------------------------------------------------------------;
; log(T) as a function of R/Rsol
;------------------------------------------------------------------------;
nwin
plot,radius,temperature,xtitle='R/Rsol',ytitle='log(T)',title='Temperature profile (logarithmic)',thick=3;,yrange=[0,10]
oplot,radius_n3,tempn3,col=130,thick=3;,title='Temperature profile (logarithmic), n=3 polytrope',xtitle='r/Rsol',ytitle='log(T)'

end

;------------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;------------------------------------------------------------------------;
pro plot_everything
PsPlot, 'compare', 'compare.ps'
end
