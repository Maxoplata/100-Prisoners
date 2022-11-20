#!/usr/bin/env bash

###################################################################
# Script Name : 100Prisoners.sh
# Description : Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
# Usage       : bash 100Prisoners.sh
# Author      : Maxamilian Demian
# Link        : https://www.maxodev.org
# Link        : https://github.com/Maxoplata/100-Prisoners
###################################################################

NUMBER_OF_TESTS=100 # the number of times to run the simulation
NUMBER_OF_PRISONERS=100 # should be an even number for this problem

# vars to keep track of our simulation wins and losses
totalWins=0
totalLosses=0

# run each simulation
for _ in $(seq 1 $NUMBER_OF_TESTS)
do
    # create the boxes
    boxes=()

    for boxNo in $(seq 1 $NUMBER_OF_PRISONERS)
    do
        boxes+=($boxNo)
    done

    # randomize the boxes (if shuf doesn't work, you may need to use gshuf)
    boxes=($(shuf -e "${boxes[@]}"))

    # have the prisoners lost yet?
    didPrisonersLose=false

    # each prisoner takes their chance at opening boxes
    for prisonerNumber in $(seq 1 $NUMBER_OF_PRISONERS)
    do
        # prisoner has not found their number yet
        hasPrisonerFoundNumber=false

        # prisoner will start by opening the box # matching their prisoner #
        boxToOpen=$prisonerNumber

        # prisoner gets to open half of the boxes looking for their own number
        halfPrisonersCount=$(echo "($NUMBER_OF_PRISONERS / 2)" | bc)

        for _ in $(seq 1 $halfPrisonersCount)
        do
            # if the box they opened has their prisoner number, success! onto the next prisoner
            if [ ${boxes[$boxToOpen - 1]} == $prisonerNumber ] # - 1 because arrays are zero-indexed
            then
                hasPrisonerFoundNumber=true

                break
            fi

            # otherwise, open the box # correlating to the # found in the box that was just opened
            boxToOpen=${boxes[$boxToOpen - 1]}
        done

        # prisoner didn't find their number, everybody loses
        if [ $hasPrisonerFoundNumber == false ]
        then
            didPrisonersLose=true

            break
        fi
    done

    if [ $didPrisonersLose == true ]
    then
        ((totalLosses++))
    else
        ((totalWins++))
    fi
done

winPercent=$(echo "scale=5 ; ($totalWins / $NUMBER_OF_TESTS) * 100" | bc)

echo "Wins/Losses: $totalWins/$totalLosses ($winPercent% wins)"
