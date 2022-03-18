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
				
		$circle_id = $_GET['circle_id'];
		$circle_code = $_GET['circle_code'];
		$circle_name = $_GET['circle_name'];
		$host_id = $_GET['host_id'];
		$member_id = $_GET['member_id'];
		
							
		$sql = "INSERT INTO `circle`(`circle_id`, `circle_code`, `circle_name`, `host_id`,`member_id`) VALUES ('$circle_id','$circle_code','$circle_name','$host_id','$member_id')";
		

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