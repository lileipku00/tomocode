subroutine prepare_model_v(re,ar,ips,iter,igr)

character*1 gr,ps,it
character*8 ar,re,line

common/pi/pi,per
common/center/fi0,tet0
common/grid/nornt,ornt(4),sinal,cosal,&
		nlev,ylev(200),ntop(200),nobr,&
		xtop(100000,200), ztop(100000,200),n_pop(100000,200),&
		dv_mod(100000),vab_mod(100000)

write(ps,'(i1)')ips
write(it,'(i1)')iter
write(gr,'(i1)')igr



!******************************************************************
open(1,file='../../DATA/'//re//'/'//ar//'/INI_PARAM/major_param.dat')
do i=1,10000
	read(1,'(a8)',end=573)line
	if(line.eq.'ORIENTAT') goto 574
end do
573 continue
write(*,*)' cannot find ORIENTATIONS in major_param.dat!!!'
call pause()
574 read(1,*)nornt
read(1,*)(ornt(i),i=1,nornt)
close(1)
!******************************************************************

!write(*,*)' fi0=',fi0,' tet0=',tet0
orient=ornt(igr)
sinal=sin(orient*per)
cosal=cos(orient*per)
!write(*,*)' orient=',orient


open(1,file='../../DATA/'//re//'/'//ar//'/GRIDS/levinfo'//ps//gr//'.dat')
i=0
722 i=i+1
	read(1,*,end=721)n,ylev(i)
	goto 722
721 nlev=i-1
!write(*,*)' nlev=',nlev
close(1)



ntop=0
open(1,file='../../DATA/'//re//'/'//ar//'/GRIDS/gr'//ps//gr//'.dat')

do n=1,nlev
	read(1,*,end=556)ntop(n)
	!write(*,*)' y=',ylev(n),' ntop=',ntop(n)
	do i=1,ntop(n)
		read(1,*)xtop(i,n),ztop(i,n),n_pop(i,n)
	end do
end do
556		close(1)

!open(21,file='grid2tmp.dat')
!do i=1,ntop(2)
!	x=xtop(i,2)
!	y=ytop(i,2)
!	zz=0
!	ind=0
!	call decsf(x,y,zz,ind,fi0,tet0,FI,TET,h)
!	write(21,*)fi,tet
!end do
!close(21)
!call pause()

open(1,file='../../DATA/'//re//'/'//ar//'/GRIDS/obr'//ps//gr//'.dat')
read(1,*) nobr
if(nobr.gt.100000) then
	write(*,*)' nobr=',nobr
	write(*,*)' One should increase size of dv_mod'
	call pause()
end if
close(1)

if(ips.eq.1) then
	open(1,file='../../DATA/'//re//'/'//ar//'/RESULT/vel_p_'//it//gr//'.dat')
else
	open(1,file='../../DATA/'//re//'/'//ar//'/RESULT/vel_s_'//it//gr//'.dat')
end if

do i=1,nobr
	read(1,*)  dv_mod(i),vab_mod(i)
	!dv_mod(i)=100*dv_mod(i)/vab_mod(i)
end do
close(1)
return
end

