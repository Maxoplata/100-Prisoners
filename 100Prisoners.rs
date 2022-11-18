/**
 * 100Prisoners.rs
 *
 * Implementation of the loop strategy for the 100 prisoners problem (~31% win ratio).
 * usage: cargo build && ./100Prisoners
 *
 * @author Maxamilian Demian
 * @link https://www.maxodev.org
 * @link https://github.com/Maxoplata/100-Prisoners
 */
use rand::seq::SliceRandom;

const NUMBER_OF_TESTS: i32 = 10000; // the number of times to run the simulation
const NUMBER_OF_PRISONERS: i32 = 100; // should be an even number for this problem

fn main() {
	// vars to keep track of our simulation wins and losses
	let mut total_wins = 0;
	let mut total_losses = 0;

	// seed the rng
	let mut rng = rand::thread_rng();

	// run each simulation
	for _ in 0..NUMBER_OF_TESTS {
		// create the boxes
		let mut boxes: Vec<i32> = (1..(NUMBER_OF_PRISONERS + 1)).collect();

		// randomize the boxes
		boxes.shuffle(&mut rng);

		// have the prisoners lost yet?
		let mut did_prisoner_lose = false;

		// each prisoner takes their chance at opening boxes
		for prisoner_number in 1..(NUMBER_OF_PRISONERS + 1) {
			// prisoner has not found their number yet
			let mut has_prisoner_found_number = false;

			// prisoner will start by opening the box # matching their prisoner #
			let mut box_to_open = prisoner_number;

			// prisoner gets to open half of the boxes looking for their own number
			for _ in 0..(NUMBER_OF_PRISONERS / 2) {
				has_prisoner_found_number = false;

				// if the box they opened has their prisoner number, success! onto the next prisoner
				if boxes[(box_to_open - 1) as usize] == prisoner_number { // - 1 because array is zero-indexed
					has_prisoner_found_number = true;

					break;
				}

				// otherwise, open the box # correlating to the # found in the box that was just opened
				box_to_open = boxes[(box_to_open - 1) as usize];
			}

			// prisoner didn't find their number, everybody loses
			if !has_prisoner_found_number {
				did_prisoner_lose = true;

				break;
			}
		}

		if did_prisoner_lose {
			total_losses = total_losses + 1;
		} else {
			total_wins = total_wins + 1;
		}
	}

	println!("Wins/Losses: {}/{} ({}% wins)", total_wins, total_losses, (total_wins as f32 / NUMBER_OF_TESTS as f32) * 100.0);
}
