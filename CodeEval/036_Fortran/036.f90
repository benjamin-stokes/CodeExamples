program main
  implicit none
  integer i, j, io, k, n, outcount, tmpint
  character(len=1024) :: arg
  character(len=1024) :: line
  character(len=1024) :: outstr
  character(len=1), dimension(7,0:127) ::key
  call get_command_argument(1, arg)
  open(14, file=arg)
  do
     read(14,'(A)', IOSTAT=io) line
     if (io<0) exit
     i = 1
     j = 1
     k = 0
     outcount = 0
     do
        if (line(i:i) .eq. "0" .or. line(i:i) .eq. "1") exit
        key(j,k) = line(i:i)
        i=i+1
        k=k+1
        if (k .eq. 2**j-1) then
           k=0
           j=j+1
        end if
     end do
     do
        j=0
        do n=0,2
           read(line(i+n:i+n),*)tmpint
           j=j+tmpint*2**(2-n)
        end do
        if (j .eq. 0) exit
        i=i+3
        if (j .eq. 0) exit
        do
           k=0
           do n=0,j-1
              read(line(i+n:i+n),*)tmpint
              k=k+tmpint*2**(j-n-1)
           end do
           i=i+j
           if (k .eq. (2**j - 1)) exit
           outcount = outcount+1
           outstr(outcount:outcount) = key(j,k)
        end do
     end do
     write(*,*)outstr(1:outcount)
  end do
end program main
