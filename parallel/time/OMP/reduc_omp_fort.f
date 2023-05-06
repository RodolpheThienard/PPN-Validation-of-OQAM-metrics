
      PROGRAM reduc
          USE omp_lib 
          IMPLICIT NONE

          INTEGER, PARAMETER            :: arraySize = 1024*8 
          INTEGER                       :: nbIter = 500000
          INTEGER, DIMENSION(arraySize) :: array

          INTEGER( KIND = 8 )           :: res 
          INTEGER                       :: i, j, argc, numThreads
          DOUBLE PRECISION              :: begin, elapsed

          CHARACTER( LEN = 32)          :: param
          LOGICAL                       :: old


          argc = IARGC()

          IF ( argc > 1 ) THEN
          CALL GETARG(0, param)
          print *, "USAGE: ", param,  "  [nombre_itérations]"
          ERROR STOP 1
          END IF

          IF( argc .EQ. 1 ) THEN
          CALL GETARG(1, param)
          READ(UNIT = param, FMT = *) nbIter 
          END IF

          ! First measure
          begin = OMP_GET_WTIME()

          ! Filling of the array
!$OMP PARALLEL 

!$OMP MASTER
          numThreads = OMP_GET_NUM_THREADS()
!$OMP END MASTER

          array(:) = 2 

          res = 0

          ! Compute local reduction
!$OMP DO SCHEDULE(runtime) REDUCTION(+:res)
          DO j = 1, nbIter 
!$OMP PARALLEL DO SCHEDULE(runtime) REDUCTION(+:res)
          DO i = 1, arraySize 
          res = res + array(i)
          END DO
!$OMP END PARALLEL DO
          END DO
!$OMP END DO

!$OMP END PARALLEL

          print *, res

          ! Second measure and write to file
          elapsed = OMP_GET_WTIME() - begin

          INQUIRE(FILE = 'resultats.dat', EXIST = old)
          IF ( old ) THEN
              OPEN(1, FILE = 'resultats.dat', STATUS = 'old',
     &           POSITION = "append", ACTION = "write")
          ELSE
              OPEN(1, FILE = 'resultats.dat', STATUS = 'new',
     &           ACTION = "write")
          END IF
          WRITE(1, *) numThreads, elapsed 
          CLOSE(1)

      END PROGRAM



