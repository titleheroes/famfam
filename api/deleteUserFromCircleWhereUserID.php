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
		$member_id = $_GET['member_id'];

		//calendar

		$sql = "DELETE FROM `calendar_att` WHERE circle_id = '$circle_id' AND user_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Calendar\n";
		} else {
			echo "False";
		}

		//my order employee

		$sql = "DELETE FROM `my_order` WHERE circle_id = '$circle_id' AND employee_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete My Order Employee\n";
		} else {
			echo "False";
		}

		//my order owner

		$sql = "DELETE FROM `my_order` WHERE circle_id = '$circle_id' AND owner_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete My Order Owner\n";
		} else {
			echo "False";
		}

		//pin reply

		$sql = "DELETE FROM `pin_reply` WHERE EXISTS ( SELECT * FROM `pin_reply` LEFT JOIN `pinpost` ON pin_reply.pin_id = pinpost.pin_id WHERE circle_id = '$circle_id') AND author_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Pin Reply\n";
		} else {
			echo "False";
		}

		//pinpost

		$sql = "DELETE FROM `pinpost` WHERE circle_id = '$circle_id' AND author_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Pinpost\n";
		} else {
			echo "False";
		}

		//random

		$sql = "DELETE FROM `random` WHERE circle_id = '$circle_id' AND user_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Random\n";
		} else {
			echo "False";
		}

		//ticktick

		$sql = "DELETE FROM `ticktick` WHERE circle_id = '$circle_id' AND user_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete TickTick\n";
		} else {
			echo "False";
		}

		//vote participant

		$sql = "DELETE FROM `vote_participant` WHERE EXISTS ( SELECT * FROM `vote_participant` LEFT JOIN `vote` ON vote_participant.vote_id = vote.vote_id WHERE circle_id = '$circle_id' AND participant_id = '$member_id')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Vote Participant\n";
		} else {
			echo "False";
		}

		//vote
									
		$sql = "DELETE FROM `vote` WHERE circle_id = '$circle_id' AND host_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete Vote\n";
		} else {
			echo "False";
		}

		//SET FOREIGN_KEY_CHECKS = 0	
									
		$sql = "SET FOREIGN_KEY_CHECKS = 0;";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "SET FOREIGN_KEY_CHECKS = 0\n";
		} else {
			echo "False";
		}

		//delete user from circle		
									
		$sql = "DELETE FROM `circle` WHERE circle_id = '$circle_id' AND member_id = '$member_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "Delete User from Circle\n";
		} else {
			echo "False";
		}

		//SET FOREIGN_KEY_CHECKS = 1
									
		$sql = "SET FOREIGN_KEY_CHECKS = 1;";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "SET FOREIGN_KEY_CHECKS = 1";
		} else {
			echo "False";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>