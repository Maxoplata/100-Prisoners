#!/usr/bin/swift
/**
 * 100Prisoners.swift
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: swift 100Prisoners.swift
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */

let NUMBER_OF_TESTS = 10000 // the number of times to run the simulation
let NUMBER_OF_PRISONERS = 100 // should be an even number for this problem

// vars to keep track of our simulation wins and losses
var totalWins = 0
var totalLosses = 0

// run each simulation
for _ in 1...NUMBER_OF_TESTS {
    // create the boxes
    var boxes = Array(1...NUMBER_OF_PRISONERS)

    // randomize the boxes
    boxes.shuffle()

    // have the prisoners lost yet?
    var didPrisonersLose = false

    // each prisoner takes their chance at opening boxes
    for prisonerNumber in 1...NUMBER_OF_PRISONERS {
        // prisoner has not found their number yet
        var hasPrisonerFoundNumber = false

        // prisoner will start by opening the box # matching their prisoner #
        var boxToOpen = prisonerNumber

        // prisoner gets to open half of the boxes looking for their own number
        for _ in 1...(NUMBER_OF_PRISONERS / 2) {
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
        totalLosses += 1
    } else {
        totalWins += 1
    }
}

print("Wins/Losses: \(totalWins)/\(totalLosses) (\((Float(totalWins) / Float(NUMBER_OF_TESTS)) * 100)% wins)")
