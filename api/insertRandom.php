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
				
		$user_id = $_GET['user_id'];
		$user_profile = $_GET['user_profile'];
		$circle_id = $_GET['circle_id'];
		$random_topic = $_GET['random_topic'];
		$random_final = $_GET['random_final'];
		
							
		$sql = "INSERT INTO `random`(`user_id`, `user_profile`,`circle_id`,`random_id`, `random_topic`, `random_final`) VALUES ('$user_id', '$user_profile','$circle_id', Null, '$random_topic', '$random_final')";

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