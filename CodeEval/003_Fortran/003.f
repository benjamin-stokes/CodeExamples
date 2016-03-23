      program main
      implicit none
      integer i, j, k, testnum, factmax

      do i = 9, 1, -1
         do j = 9, 0, -1
            testnum = 100*i+10*j+i
            factmax = int(sqrt(real(testnum)))
            do k = 2,factmax, 1
               if (mod(testnum, k) == 0) then
                  go to 10
               end if
            end do
 100        format(I3)
            write(*,100)testnum
            stop
 10      end do
      end do
      end
