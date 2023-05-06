
      PROGRAM reduc
          USE mpi

          IMPLICIT NONE

          INTEGER, PARAMETER            :: arraySize = 1024*8 
          INTEGER, PARAMETER            :: nbIter = 50000000
          INTEGER, DIMENSION(arraySize) :: arrayBase, array

          INTEGER( KIND = 8)            :: recv, res
          INTEGER                       :: i, j, pid 
          INTEGER                       :: mpiRank, mpiSize, error
          DOUBLE PRECISION              :: begin, maxTime, elapsed

          CHARACTER( LEN =32 )          :: filename
          LOGICAL                       :: old


          CALL MPI_INIT(error)

          ! First measure
          begin = MPI_WTIME()

          CALL MPI_COMM_RANK(MPI_COMM_WORLD, mpiRank, error)
          CALL MPI_COMM_SIZE(MPI_COMM_WORLD, mpiSize, error)

          ! Filling of the array
          IF ( mpiRank == 0 ) THEN
              arrayBase(:) = 2 
          END IF

          CALL MPI_SCATTER(arrayBase, arraySize/mpiSize, MPI_INTEGER,
     &                     array, arraySize/mpiSize, MPI_INTEGER,
     &                     0, MPI_COMM_WORLD, error)

          res = 0

          ! Compute local reduction
          DO j = 1, nbIter 
            DO i = 1, arraySize/mpiSize
              res = res + array(i)
            END DO
          END DO
          
          CALL MPI_REDUCE(res, recv, 1, MPI_INTEGER, MPI_SUM, 
     &                    0, MPI_COMM_WORLD, error)

          IF ( mpiRank == 0 ) THEN
              print *, recv
          END IF

          ! Second measure and write to file
          elapsed = MPI_WTIME() - begin
          
          pid = GETPID()

          WRITE(UNIT = filename, FMT = *) pid, '.dat'

          INQUIRE(FILE = filename, EXIST = old)
          IF ( old ) THEN
              OPEN(1, FILE = filename, STATUS = 'old',
     &             POSITION = "append", ACTION = "write")
          ELSE
              OPEN(1, FILE = filename, STATUS = 'new',
     &             ACTION = "write")
          END IF
          WRITE(1, *)  elapsed
          CLOSE(1)

          CALL MPI_FINALIZE(error)

      END PROGRAM



