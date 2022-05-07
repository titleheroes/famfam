<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");
	error_reporting(E_ERROR | E_PARSE);

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}else {

	if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$circle_id = $_GET['circle_id'];

		//calendar

		$sql = "DELETE FROM `calendar_att` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Calendar\n";
		} else {
			echo "False";
		}	

		//my order

		$sql = "DELETE FROM `my_order` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete My Order\n";
		} else {
			echo "False";
		}	

		//pin reply

		$sql = "DELETE FROM `pin_reply` WHERE EXISTS ( SELECT * FROM `pin_reply` LEFT JOIN `pinpost` ON pin_reply.pin_id = pinpost.pin_id WHERE circle_id = '$circle_id')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Pin Reply\n";
		} else {
			echo "False";
		}

		//pinpost

		$sql = "DELETE FROM `pinpost` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Pinpost\n";
		} else {
			echo "False";
		}

		//random

		$sql = "DELETE FROM `random` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Random\n";
		} else {
			echo "False";
		}

		//ticktick

		$sql = "DELETE FROM `ticktick` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete TickTick\n";
		} else {
			echo "False";
		}

		//vote participant

		$sql = "DELETE FROM `vote_participant` WHERE EXISTS ( SELECT * FROM `vote_participant` LEFT JOIN `vote` ON vote_participant.vote_id = vote.vote_id WHERE circle_id = '$circle_id')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Vote Participant\n";
		} else {
			echo "False";
		}

		//vote option

		$sql = "DELETE FROM `vote_option` WHERE EXISTS ( SELECT * FROM `vote_option` LEFT JOIN `vote` ON vote_option.vote_id = vote.vote_id WHERE circle_id = '$circle_id')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Vote Option\n";
		} else {
			echo "False";
		}

		//vote
									
		$sql = "DELETE FROM `vote` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Vote\n";
		} else {
			echo "False";
		}

		//circle
									
		$sql = "DELETE FROM `circle` WHERE circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Circle\n";
		} else {
			echo "False";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>