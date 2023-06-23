      ******************************************************************
      * Author: Maxamilian Demian
      * Purpose: Implementation of the loop strategy for the 100
      *          prisoners problem (~31% win ratio).
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 100-PRISONERS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *    the number of times to run the simulation
           01 NUMBER-OF-TESTS PIC 9(5) VALUE 10000.
      *    should be an even number for this problem
           01 NUMBER-OF-PRISONERS PIC 9(3) VALUE 100.

      *    vars to keep track of our simulation wins and losses
           01 TOTAL-WINS PIC 9(5) VALUE 0.
           01 TOTAL-LOSSES PIC 9(5) VALUE 0.
           01 WIN-PERCENT PIC 999V99.

           01 SIM-I PIC 9(5).
           01 I PIC 9(3).
           01 J PIC 9(3).

           01 RANDOM-NUMBER PIC 999V99.
           01 RANDOM-INDEX PIC 9(3).
           01 TEMP-VALUE PIC 9(3).

           01 BOXES.
               05 BOX OCCURS 100 TIMES.
                   10 BOX-VALUE PIC 9(3).

           01 DID-PRISONERS-LOSE PIC 1(1) VALUE 0.
           01 HAS-PRISONER-FOUND-NUMBER PIC 1(1) VALUE 0.
           01 BOX-TO-OPEN PIC 9(3).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
      *    run each simulation
           PERFORM VARYING SIM-I FROM 0 BY 1
           UNTIL SIM-I >= NUMBER-OF-TESTS
      *        create the boxes
               PERFORM VARYING I FROM 1 BY 1
               UNTIL I > NUMBER-OF-PRISONERS
                   MOVE I TO BOX-VALUE(I)
               END-PERFORM

      *        randomize the boxes
               PERFORM VARYING I FROM 1 BY 1
               UNTIL I > NUMBER-OF-PRISONERS
                   COMPUTE RANDOM-NUMBER = FUNCTION RANDOM
                   MULTIPLY NUMBER-OF-PRISONERS BY RANDOM-NUMBER
                   ADD 1 TO RANDOM-NUMBER

                   MOVE RANDOM-NUMBER TO RANDOM-INDEX

                   MOVE BOX-VALUE(I) TO TEMP-VALUE
                   MOVE BOX-VALUE(RANDOM-INDEX) TO BOX-VALUE(I)
                   MOVE TEMP-VALUE TO BOX-VALUE(RANDOM-INDEX)
               END-PERFORM

      *        have the prisoners lost yet?
               MOVE 0 TO DID-PRISONERS-LOSE

      *        each prisoner takes their chance at opening boxes
               PERFORM VARYING I FROM 1 BY 1
               UNTIL I > NUMBER-OF-PRISONERS
      *            prisoner has not found their number yet
                   MOVE 0 TO HAS-PRISONER-FOUND-NUMBER

      *            prisoner will start by opening the box # matching
      *            their prisoner #
                   MOVE I TO BOX-TO-OPEN

      *            prisoner gets to open half of the boxes looking for
      *            their own number
                   PERFORM VARYING J FROM 1 BY 1
                   UNTIL J > (NUMBER-OF-PRISONERS / 2)
      *                if the box they opened has their prisoner number,
      *                    success! onto the next prisoner
                       IF BOX-VALUE(BOX-TO-OPEN) = I
                           MOVE 1 TO HAS-PRISONER-FOUND-NUMBER

                           EXIT PERFORM
                       END-IF

      *                otherwise, open the box # correlating to the #
      *                found in the box that was just opened
                       MOVE BOX-VALUE(BOX-TO-OPEN) TO BOX-TO-OPEN
                   END-PERFORM

      *            if prisoner didn't find their number, everybody loses
                   IF HAS-PRISONER-FOUND-NUMBER = 0
                       MOVE 1 TO DID-PRISONERS-LOSE

                       EXIT PERFORM
                   END-IF
               END-PERFORM

               IF DID-PRISONERS-LOSE = 1
                   ADD 1 TO TOTAL-LOSSES
               ELSE
                   ADD 1 TO TOTAL-WINS
               END-IF
           END-PERFORM

           COMPUTE WIN-PERCENT = (TOTAL-WINS / NUMBER-OF-TESTS) * 100

           DISPLAY "Wins/Losses: " TOTAL-WINS "/" TOTAL-LOSSES " ("
               WIN-PERCENT "% wins)".

           STOP RUN.
       END PROGRAM 100-PRISONERS.
