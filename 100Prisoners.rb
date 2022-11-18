#!/usr/bin/ruby
# 100Prisoners.rb
#
# Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
# usage: ruby 100Prisoners.rb
#
# @author Maxamilian Demian
# @link https://www.maxodev.org
# @link https://github.com/Maxoplata/100-Prisoners

NUMBER_OF_TESTS = 10000 # the number of times to run the simulation
NUMBER_OF_PRISONERS = 100 # should be an even number for this problem

# vars to keep track of our simulation wins and losses
totalWins = 0
totalLosses = 0

# run each simulation
for _ in 1..NUMBER_OF_TESTS do
    # create the randomized boxes
    boxes = (1..NUMBER_OF_PRISONERS).to_a.shuffle()

    # have the prisoners lost yet?
    didPrisonersLose = false

    # each prisoner takes their chance at opening boxes
    for prisonerNumber in 1..NUMBER_OF_PRISONERS do
        # prisoner has not found their number yet
        hasPrisonerFoundNumber = false

        # prisoner will start by opening the box # matching their prisoner #
        boxToOpen = prisonerNumber

        # prisoner gets to open half of the boxes looking for their own number
        for _ in 1..(NUMBER_OF_PRISONERS / 2) do
            # if the box they opened has their prisoner number, success! onto the next prisoner
            if boxes[boxToOpen - 1] == prisonerNumber # - 1 because arrays are zero-indexed
                hasPrisonerFoundNumber = true

                break
            end

            # otherwise, open the box # correlating to the # found in the box that was just opened
            boxToOpen = boxes[boxToOpen - 1]
        end

        # prisoner didn't find their number, everybody loses
        if !hasPrisonerFoundNumber
            didPrisonersLose = true

            break
        end
    end

    if didPrisonersLose
        totalLosses += 1
    else
        totalWins += 1
    end
end

puts "Wins/Losses: #{totalWins}/#{totalLosses} (#{(totalWins.to_f / NUMBER_OF_TESTS) * 100}% wins)"
