program main
  implicit none
  integer i, j, io
  character(len=1024) :: arg
  character(len=1024) :: line

  call get_command_argument(1, arg)
  open(14, file=arg)
  do
     read(14,*, IOSTAT=io) line
     if (io<0) exit
     do i = 1, len_trim(line)
        do j = 1, len_trim(line)
           if (line (i:i) .eq. line(j:j) .and. i .ne. j) then
              go to 10
           end if
        end do
        write(*,'(a)')line(i:i)
        go to 20
10   end do
20 end do
end program main
