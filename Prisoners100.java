
/**
 * Prisoners100.java
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: javac Prisoners100.java && java Prisoners100
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */
import java.util.Arrays;
import java.util.Random;
import java.util.stream.IntStream;

class Prisoners100 {
    public static void main(String[] args) {
        int NUMBER_OF_TESTS = 10000; // the number of times to run the simulation
        int NUMBER_OF_PRISONERS = 100; // should be an even number for this problem

        // vars to keep track of our simulation wins and losses
        int totalWins = 0;
        int totalLosses = 0;

        // run each simulation
        for (int i = 0; i < NUMBER_OF_TESTS; i++) {
            // create the boxes
            int[] boxes = IntStream.rangeClosed(1, NUMBER_OF_PRISONERS).toArray();

            // randomize the boxes
            Random rand = new Random();

            for (int j = 0; j < boxes.length; j++) {
    			int randomIndexToSwap = rand.nextInt(boxes.length);
    			int tmp = boxes[randomIndexToSwap];

    			boxes[randomIndexToSwap] = boxes[j];
    			boxes[j] = tmp;
    		}

            // have the prisoners lost yet?
            boolean didPrisonersLose = false;

            // each prisoner takes their chance at opening boxes
            for (int prisonerNumber = 1; prisonerNumber <= NUMBER_OF_PRISONERS; prisonerNumber++) {
                // prisoner has not found their number yet
                boolean hasPrisonerFoundNumber = false;

                // prisoner will start by opening the box # matching their prisoner #
                int boxToOpen = prisonerNumber;

                // prisoner gets to open half of the boxes looking for their own number
                for (int openedBoxCount = 1; openedBoxCount <= (NUMBER_OF_PRISONERS / 2); openedBoxCount++) {
                    // if the box they opened has their prisoner number, success! onto the next prisoner
                    if (boxes[boxToOpen - 1] == prisonerNumber) { // - 1 because vector is zero-indexed
                        hasPrisonerFoundNumber = true;

                        break;
                    }

                    // otherwise, open the box # correlating to the # found in the box that was just opened
                    boxToOpen = boxes[boxToOpen - 1];
                }

                // prisoner didn't find their number, everybody loses
                if (!hasPrisonerFoundNumber) {
                    didPrisonersLose = true;

                    break;
                }
            }

            if (didPrisonersLose) {
                totalLosses++;
            } else {
                totalWins++;
            }
        }

        System.out.printf("Wins/Losses: %d/%d (%f%% wins)\n", totalWins, totalLosses, (((float) totalWins / NUMBER_OF_TESTS) * 100));
    }
}
