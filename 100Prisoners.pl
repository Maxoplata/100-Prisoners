
#!/usr/bin/perl
#
# 100Prisoners.pl
#
# Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
# usage: perl 100Prisoners.pl
#
# Author: Maxamilian Demian
#
# https://www.maxodev.org
# https://github.com/Maxoplata/100-Prisoners

use strict;
use warnings;

use List::Util qw/shuffle/;

my $NUMBER_OF_TESTS = 10000; # the number of times to run the simulation
my $NUMBER_OF_PRISONERS = 100; # should be an even number for this problem

# vars to keep track of our simulation wins and losses
my $totalWins = 0;
my $totalLosses = 0;

# run each simulation
for (my $i = 0; $i < $NUMBER_OF_TESTS; $i++) {
    # create the randomized boxes
    my @boxes = shuffle map $_, 1..$NUMBER_OF_PRISONERS;

    # have the prisoners lost yet?
    my $didPrisonersLose = 0;

    # each prisoner takes their chance at opening boxes
    for (my $prisonerNumber = 1; $prisonerNumber <= $NUMBER_OF_PRISONERS; $prisonerNumber++) {
        # prisoner has not found their number yet
        my $hasPrisonerFoundNumber = 0;

        # prisoner will start by opening the box # matching their prisoner #
        my $boxToOpen = $prisonerNumber;

        # prisoner gets to open half of the boxes looking for their own number
        for (my $openedBoxCount = 1; $openedBoxCount <= ($NUMBER_OF_PRISONERS / 2); $openedBoxCount++) {
            # if the box they opened has their prisoner number, success! onto the next prisoner
            if ($boxes[$boxToOpen - 1] == $prisonerNumber) { # - 1 because arrays are zero-indexed
                $hasPrisonerFoundNumber = 1;

                last;
            }

            # otherwise, open the box # correlating to the # found in the box that was just opened
            $boxToOpen = $boxes[$boxToOpen - 1];
        }

        # prisoner didn't find their number, everybody loses
        if (!$hasPrisonerFoundNumber) {
            $didPrisonersLose = 1;

            last;
        }
    }

    if ($didPrisonersLose) {
        $totalLosses++;
    } else {
        $totalWins++;
    }
}

print "Wins/Losses: ${totalWins}/${totalLosses} (@{[($totalWins / $NUMBER_OF_TESTS) * 100]}% wins)\n";
