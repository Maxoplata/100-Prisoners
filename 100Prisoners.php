<?php
/**
 * 100Prisoners.php
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: php 100Prisoners.php
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */

const NUMBER_OF_TESTS = 10000; // the number of times to run the simulation
const NUMBER_OF_PRISONERS = 100; // should be an even number for this problem

// vars to keep track of our simulation wins and losses
$totalWins = 0;
$totalLosses = 0;

// run each simulation
for ($i = 0; $i < NUMBER_OF_TESTS; $i++) {
    // create the boxes
    $boxes = range(1, NUMBER_OF_PRISONERS);

    // randomize the boxes
    shuffle($boxes);

    // have the prisoners lost yet?
    $didPrisonersLose = false;

    // each prisoner takes their chance at opening boxes
    for ($prisonerNumber = 1; $prisonerNumber <= NUMBER_OF_PRISONERS; $prisonerNumber++) {
        // prisoner has not found their number yet
        $hasPrisonerFoundNumber = false;

        // prisoner will start by opening the box # matching their prisoner #
        $boxToOpen = $prisonerNumber;

        // prisoner gets to open half of the boxes looking for their own number
        for ($openedBoxCount = 1; $openedBoxCount <= (NUMBER_OF_PRISONERS / 2); $openedBoxCount++) {
            // if the box they opened has their prisoner number, success! onto the next prisoner
            if ($boxes[$boxToOpen - 1] === $prisonerNumber) { // - 1 because arrays are zero-indexed
                $hasPrisonerFoundNumber = true;

                break;
            }

            // otherwise, open the box # correlating to the # found in the box that was just opened
            $boxToOpen = $boxes[$boxToOpen - 1];
        }

        // prisoner didn't find their number, everybody loses
        if (!$hasPrisonerFoundNumber) {
            $didPrisonersLose = true;

            break;
        }
    }

    if ($didPrisonersLose) {
        $totalLosses++;
    } else {
        $totalWins++;
    }
}

print "Wins/Losses: {$totalWins}/{$totalLosses} (" . (($totalWins / NUMBER_OF_TESTS) * 100) . "% wins)" . PHP_EOL;
