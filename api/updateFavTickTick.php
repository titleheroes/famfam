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
			
		$tick_id = $_GET['tick_id'];		
		$fav_topic = $_GET['fav_topic'];

		$sql = "UPDATE `ticktick` SET `fav_topic`='$fav_topic' WHERE `tick_id` = '$tick_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "True";
		} else {
			echo "False";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>