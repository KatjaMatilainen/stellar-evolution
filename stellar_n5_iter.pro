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

pro stellar_n5_iter

;As the n=5 case can't be directly solved, we need to iterate n->5
;and see what values Rn, Dn, Bn, and Mn approach

;------------------------------------------------------------------------;
;  Starting values
;------------------------------------------------------------------------;

;Iteration index i
i=1
;Polytropic index
n=4.d0

;The (soon-to-be) array for results [[result1],[result2],...]
result=lane_emden2(n)

;------------------------------------------------------------------------;
; Iteration loop where n->5
;------------------------------------------------------------------------;

while n lt 5 do begin

;Make sure the loop is not infinite (Later make a fancier version?)
;if i ge 20 then break
;Actually, no additional break is needed, since at i=17 n is so close to
;5 that it counts as a 5 and the loop ends!

;Increase n each step by 0.9 and 0.09 and 0.009 and so on
   n=n+9.d0*10^(-1.d0*i)

;Use the function lane_emden2 to solve ksi,theta,and dtheta/dksi
;for each value of n, and add the results in the result array

;Add result
   result=[[[result]],[[lane_emden2(n)]]]

;Increase i
   i=i+1
endwhile

;Check what the final value of n is, and at what index i the loop ended
;print,n
;print,i
   
;-------------------------------------------------------------------------;
; Plot the results (just for fun, and to see if everything works)
;-------------------------------------------------------------------------;

;Basic structure for the plot

plot,result[*,0,0],result[*,1,0],title='Lane-Emden, iteration for n=5',xrange=[0,400],yrange=[-0.1,1.1]
oplot,[0,400],[0,0],linestyle=1

;Add results for different values of n to the plot

j=0
while j lt i do begin
oplot,result[*,0,j],result[*,1,j]
j=j+1
endwhile

;------------------------------------------------------------------------;
; Solve the polytropic constants for each value of n, so you'll see 
; what values the results approach.
;------------------------------------------------------------------------;

;Use the result array that has values of n=[4,4.9,4.99,...]

;------------------------------------------------------------------------;
; Separate the results (ksi, theta, dtheta_dksi)
;------------------------------------------------------------------------;

;Starting values (empty)
   ksi_array=!NULL
   theta_array=!NULL
   dtheta_dksi_array=!NULL

;n=[4,4.9,4.99,...]
   k=0
   while k lt i do begin
     ksi_array=[[ksi_array],[result[*,0,k]]]
     theta_array=[[theta_array],[result[*,1,k]]]
     dtheta_dksi_array=[[dtheta_dksi_array],[result[*,2,k]]]
     k=k+1
   endwhile

;------------------------------------------------------------------------;
; Rn
;------------------------------------------------------------------------;
;Because all result vectors in the result array needed to be the same 
;length, the lane_emden2 -program did not cut the zeroes away from the 
;end of theta-vectors.

;To find out Rn, find the index where theta=0 for the first time. The
;corresponding ksi is Rn.

l=0
m=0
limit=!NULL

;l is the index for different values of n
;go through all values of n
while l lt i do begin
;m is the index for the elements of ksi- and theta-vectors
;go through each theta-vector until you reach 0
   while m lt n_elements(ksi_array[*,0])-1 do begin
      if theta_array[m,l] eq 0 then begin
;save the points where theta=0 for the first time for each value of n
      limit=[[limit],[m]]
      break
      endif
   m=m+1
   endwhile
l=l+1
endwhile

print, limit
;Only 2 results, why? -> judging from the plot, only the first 2
;graphs reach 0 between ksi=[0,300]
;Can I increase the ksi range?
;Nope, program gets too heavy. And dropping the accuracy leads to
;really bad results.

print, theta_array[*,2]

; Rn is now ksi_array[limit,*]. 
;(Note: DO NOT use n as an index, it is already in use elsewhere!)

;p=0
;Rn_array=!NULL
;while p lt i do begin
;Rn_array=[[Rn_array],[ksi_array[limit(p),p]]]
;p=p+1
;endwhile
;------------------------------------------------------------------------;
; Dn
;------------------------------------------------------------------------;

;------------------------------------------------------------------------;
; Mn
;------------------------------------------------------------------------;

;------------------------------------------------------------------------;
; Bn
;------------------------------------------------------------------------;


end

;--------------------------------------------------------------------;
; Save the results to a PostScript file using PsPlot
;--------------------------------------------------------------------;

pro Plot_everything
PsPlot, 'stellar_n5_iter', 'stellar_n5_iter.ps'
end
