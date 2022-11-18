
/**
 * 100Prisoners.cpp
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: g++ 100Prisoners.cpp -o 100Prisoners && ./100Prisoners
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */
#include <iostream>
#include <vector>
#include <algorithm>
#include <random>

int main() {
    int NUMBER_OF_TESTS = 10000; // the number of times to run the simulation
    int NUMBER_OF_PRISONERS = 100; // should be an even number for this problem

    // vars to keep track of our simulation wins and losses
    int totalWins = 0;
    int totalLosses = 0;

    // run each simulation
    for (int i = 0; i < NUMBER_OF_TESTS; i++) {
        // create the boxes
        std::vector<int> boxes(NUMBER_OF_PRISONERS);
        for (int boxNo = 1; boxNo <= NUMBER_OF_PRISONERS; boxNo++) {
            boxes[boxNo - 1] = boxNo;
        }

        // randomize the boxes
        unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();
        shuffle (boxes.begin(), boxes.end(), std::default_random_engine(seed));

        // have the prisoners lost yet?
        bool didPrisonersLose = false;

        // each prisoner takes their chance at opening boxes
        for (int prisonerNumber = 1; prisonerNumber <= NUMBER_OF_PRISONERS; prisonerNumber++) {
            // prisoner has not found their number yet
            bool hasPrisonerFoundNumber = false;

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

    printf("Wins/Losses: %d/%d (%f%% wins)\n", totalWins, totalLosses, (((float) totalWins / NUMBER_OF_TESTS) * 100));
}
