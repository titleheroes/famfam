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
			$tick_id = $_GET['tick_id'];
		$tick_uid = $_GET['tick_uid'];
		$circle_id = $_GET['circle_id'];
		$user_id = $_GET['user_id'];
        $tick_topic = $_GET['tick_topic'];
		$ticklist_list = $_GET['ticklist_list'];
		$fav_topic = $_GET['fav_topic'];

		$sql = "INSERT INTO `ticktick`(`tick_id`, `tick_uid`, `circle_id`, `user_id`, `tick_topic`, `ticklist_list`, `fav_topic`) VALUES ('$tick_id','$tick_uid','$circle_id','$user_id','$tick_topic','$ticklist_list','$fav_topic')";

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