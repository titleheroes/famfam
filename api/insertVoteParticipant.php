<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$vote_id = $_GET['vote_id'];
		$participant_id = $_GET['participant_id'];
		$vote_option_id = $_GET['vote_option_id'];
							
		$sql = "INSERT INTO `vote_participant`(`vote_participant_id`, `vote_id`, `participant_id`, `vote_option_id`) VALUES (Null, $vote_id, $participant_id, $vote_option_id)";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>