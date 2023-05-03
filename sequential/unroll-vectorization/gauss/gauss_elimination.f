
      program gauss_elimination
          implicit none

          integer, parameter :: n  = 4096 

          double precision, dimension(n,n) :: A
          double precision, dimension(n)   :: b, x

          integer :: i, j
          do  i = 1, n 
          b(i) = i*0.1d1 + 1.0d2
          do j = 1, n
          A(j,i) = i*0.7d1 -j*0.33d1 + 1.0d1
          enddo
          enddo

          x = gauss( A, b, n )

      contains
          ! Elimination de Gauß pour triangulariser un système linéaire
          function gauss ( A, b, n )
              implicit none

              double precision, dimension(n, n), intent(inout) :: A
              double precision, dimension(n),    intent(inout) :: b
              integer, intent(in) :: n

              double precision, dimension(n) :: gauss 
              double precision :: m 
              integer :: k, i, j

              do k = 1, n-1
              do i = k+1, n
              m = A(i,k) / A(k,k)
              b(i) = b(i) - b(k)

              do j = k+1, n
              A(j,i) = A(j,i) - m * A(k,i)
              enddo
              enddo
              enddo

              gauss = remontee(A,b,n)

          end function gauss

          ! Méthode de remontée pour résoudre un système triangularisé
          function remontee ( U, b, n )

              implicit none

              double precision, dimension(n, n), intent(in) :: U
              double precision, dimension(n),    intent(in) :: b
              integer, intent(in) :: n

              double precision, dimension(n) :: remontee
              integer :: i, j

              remontee(n) = b(n) / U(n, n)

              do i = n-1, 1, -1
              do j = i, n
              remontee(i) = (b(i) - U(i, j) * remontee(j)) / U(i,i)
              enddo
              enddo

              return

          end function remontee

      end program gauss_elimination

