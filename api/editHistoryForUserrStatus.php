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
			
		$user_id = $_GET['user_id'];
		$circle_id = $_GET['circle_id'];
		$history_status = $_GET['history_status'];		
									
		$sql = "UPDATE history_for_user SET history_status = '$history_status' WHERE user_id = '$user_id' AND circle_id = '$circle_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>