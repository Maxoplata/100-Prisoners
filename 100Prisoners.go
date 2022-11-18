/**
 * 100Prisoners.go
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: go build 100Prisoners.go && ./100Prisoners
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/MontyHall
 */
package main

import (
    "fmt"
    "math/rand"
    "time"
)

func main() {
    const NUMBER_OF_TESTS = 10000 // the number of times to run the simulation
    const NUMBER_OF_PRISONERS = 100 // should be an even number for this problem

    // vars to keep track of our simulation wins and losses
    totalWins := 0
    totalLosses := 0

    // run each simulation
    for i := 1; i <= NUMBER_OF_TESTS; i++ {
        // create the boxes
        boxes := make([]int, NUMBER_OF_PRISONERS)

        for boxNo := 1; boxNo <= NUMBER_OF_PRISONERS; boxNo++ {
            boxes[boxNo - 1] = boxNo
        }

        // randomize the boxes
        rand.Seed(time.Now().UnixNano())
        rand.Shuffle(len(boxes), func(a, b int) {
            boxes[a], boxes[b] = boxes[b], boxes[a]
        })

        // have the prisoners lost yet?
        didPrisonersLose := false

        // each prisoner takes their chance at opening boxes
        for prisonerNumber := 1; prisonerNumber <= NUMBER_OF_PRISONERS; prisonerNumber++ {
            // prisoner has not found their number yet
            hasPrisonerFoundNumber := false

            // prisoner will start by opening the box # matching their prisoner #
            boxToOpen := prisonerNumber

            // prisoner gets to open half of the boxes looking for their own number
            for openedBoxCount := 1; openedBoxCount <= (NUMBER_OF_PRISONERS / 2); openedBoxCount++ {
                // if the box they opened has their prisoner number, success! onto the next prisoner
                if boxes[boxToOpen - 1] == prisonerNumber { // - 1 because array is zero-indexed
                    hasPrisonerFoundNumber = true

                    break
                }

                // otherwise, open the box # correlating to the # found in the box that was just opened
                boxToOpen = boxes[boxToOpen - 1]
            }

            // prisoner didn't find their number, everybody loses
            if !hasPrisonerFoundNumber {
                didPrisonersLose = true

                break
            }
        }

        if didPrisonersLose {
            totalLosses++
        } else {
            totalWins++
        }
    }

    fmt.Printf("Wins/Losses: %d/%d (%f%% wins)\n", totalWins, totalLosses, ((float64(totalWins) / float64(NUMBER_OF_TESTS)) * 100))
}
