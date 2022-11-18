#!/usr/bin/env python
"""
100Prisoners.py
Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
usage: python 100Prisoners.py
https://www.maxodev.org
https://github.com/Maxoplata/100-Prisoners
"""

import random

__author__ = "Maxamilian Demian"
__email__ = "max@maxdemian.com"

NUMBER_OF_TESTS = 10000; # the number of times to run the simulation
NUMBER_OF_PRISONERS = 100; # should be an even number for this problem

# vars to keep track of our simulation wins and losses
totalWins = 0
totalLosses = 0

# run each simulation
for i in range(0, NUMBER_OF_TESTS):
    # create the boxes
    boxes = list(range(1, NUMBER_OF_PRISONERS + 1))

    # randomize the boxes
    random.shuffle(boxes)

    # have the prisoners lost yet?
    didPrisonersLose = False

    # each prisoner takes their chance at opening boxes
    for prisonerNumber in range(1, NUMBER_OF_PRISONERS + 1):
        # prisoner has not found their number yet
        hasPrisonerFoundNumber = False

        # prisoner will start by opening the box # matching their prisoner #
        boxToOpen = prisonerNumber

        # prisoner gets to open half of the boxes looking for their own number
        for openedBoxCount in range(1, int(NUMBER_OF_PRISONERS / 2) + 1):
            # if the box they opened has their prisoner number, success! onto the next prisoner
            if boxes[boxToOpen - 1] == prisonerNumber: # - 1 because arrays are zero-indexed
                hasPrisonerFoundNumber = True

                break

            # otherwise, open the box # correlating to the # found in the box that was just opened
            boxToOpen = boxes[boxToOpen - 1]

        # prisoner didn't find their number, everybody loses
        if not hasPrisonerFoundNumber:
            didPrisonersLose = True

            break

    if didPrisonersLose:
        totalLosses += 1
    else:
        totalWins += 1

print('Wins/Losses: {}/{} {}% wins)'.format(totalWins, totalLosses, ((float(totalWins) / NUMBER_OF_TESTS) * 100)))
