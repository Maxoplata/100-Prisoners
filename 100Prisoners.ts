/**
 * 100Prisoners.ts
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: ts-node 100Prisoners.ts
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */

const NUMBER_OF_TESTS: number = 10000; // the number of times to run the simulation
const NUMBER_OF_PRISONERS: number = 100; // should be an even number for this problem

// vars to keep track of our simulation wins and losses
let totalWins: number = 0;
let totalLosses: number = 0;

// run each simulation
for (let i: number = 0; i < NUMBER_OF_TESTS; i++) {
    // create the randomized boxes
    const boxes: number[] = Array.from({length: 100}, (_, i) => i + 1).sort((a, b) => 0.5 - Math.random());

    // have the prisoners lost yet?
    let didPrisonersLose: boolean = false;

    // each prisoner takes their chance at opening boxes
    for (let prisonerNumber: number = 1; prisonerNumber <= NUMBER_OF_PRISONERS; prisonerNumber++) {
        // prisoner has not found their number yet
        let hasPrisonerFoundNumber: boolean = false;

        // prisoner will start by opening the box # matching their prisoner #
        let boxToOpen: number = prisonerNumber;

        // prisoner gets to open half of the boxes looking for their own number
        for (let openedBoxCount: number = 1; openedBoxCount <= (NUMBER_OF_PRISONERS / 2); openedBoxCount++) {
            // if the box they opened has their prisoner number, success! onto the next prisoner
            if (boxes[boxToOpen - 1] === prisonerNumber) { // - 1 because arrays are zero-indexed
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

console.log(`Wins/Losses: ${totalWins}/${totalLosses} (${(totalWins / NUMBER_OF_TESTS) * 100}% wins)`);
