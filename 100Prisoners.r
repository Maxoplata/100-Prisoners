# 100Prisoners.r
#
# Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
# usage: rscript 100Prisoners.r
#
# @author Maxamilian Demian
# @link https://www.maxodev.org
# @link https://github.com/Maxoplata/100-Prisoners

NUMBER_OF_TESTS <- 10000 # the number of times to run the simulation
NUMBER_OF_PRISONERS <- 100 # should be an even number for this problem

# vars to keep track of our simulation wins and losses
totalWins <- 0
totalLosses <- 0

for (i in 1:NUMBER_OF_TESTS) {
    # create the randomized boxes
    boxes <- sample(1:NUMBER_OF_PRISONERS)

    # have the prisoners lost yet?
    didPrisonersLose = FALSE

    # each prisoner takes their chance at opening boxes
    for (prisonerNumber in 1:NUMBER_OF_PRISONERS) {
        # prisoner has not found their number yet
        hasPrisonerFoundNumber = FALSE

        # prisoner will start by opening the box # matching their prisoner #
        boxToOpen = prisonerNumber

        # prisoner gets to open half of the boxes looking for their own number
        for (openedBoxCount in 1:(NUMBER_OF_PRISONERS / 2)) {
            # if the box they opened has their prisoner number, success! onto the next prisoner
            if (boxes[boxToOpen] == prisonerNumber) {
                hasPrisonerFoundNumber = TRUE

                break
            }

            # otherwise, open the box # correlating to the # found in the box that was just opened
            boxToOpen = boxes[boxToOpen]
        }

        # prisoner didn't find their number, everybody loses
        if (!hasPrisonerFoundNumber) {
            didPrisonersLose = TRUE

            break
        }
    }

    if (didPrisonersLose) {
        totalLosses <- totalLosses + 1
    } else {
        totalWins <- totalWins + 1
    }
}

message(paste("Wins/Losses: ", totalWins, "/", totalLosses, " (", ((totalWins / NUMBER_OF_TESTS) * 100), "% wins)", sep = ""))
