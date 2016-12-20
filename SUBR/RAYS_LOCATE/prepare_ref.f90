subroutine prepare_ref(re,ar)
character*8 ar,re

common/reftable/izttab,ntab(2,200),hzttab(2,200),ttab(2,200,5000),rtab(2,200,5000),etab(2,200,5000),atab(2,200,5000)
common/refmod/nrefmod,hmod(600),vmodp(600),vmods(600)


open(1,file='../../DATA/'//re//'/'//ar//'/INI_PARAM/refmod.dat')
read(1,*,end=81)vpvs
i=0
82	i=i+1
	read(1,*,end=81)hmod(i),vmodp(i),vs
	if(vpvs.lt.0.000001) then
		vmods(i)=vs
	else
		vmods(i)=vmodp(i)/vpvs
	end if
	!write(*,*)hmod(i),vmodp(i),vmods(i)
goto 82
81	close(1)
nrefmod=i-1
!write(*,*)' nrefmod=',nrefmod

open(1,file='../../DATA/'//re//'/'//ar//'/TIMES/table.dat',form='unformatted')
izt=0
nrmax=0
34	continue
	izt=izt+1
	do ips=1,2
		read(1,end=35)hzttab(ips,izt),ntab(ips,izt)
		if(ntab(ips,izt).gt.nrmax) nrmax=ntab(ips,izt)
		!write(*,*)' i=',izt,' z=',hzttab(ips,izt),' ips=',ips,' nref=',ntab(ips,izt)
		do i=1,ntab(ips,izt)
			read(1)etab(ips,izt,i),ttab(ips,izt,i),atab(ips,izt,i),rtab(ips,izt,i)
			!write(*,*)etab(ips,izt,i),ttab(ips,izt,i),atab(ips,izt,i),rtab(ips,izt,i)
		end do
		!pause
	end do
goto 34
35 close(11)
izttab=izt-1
write(*,*)' izttab=',izttab,' nrmax=',nrmax
!pause
return 
end
