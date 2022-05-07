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
		$owner_id = $_GET['owner_id'];
		$owner_fname = $_GET['owner_fname'];
		$employee_id = $_GET['employee_id'];
		$employee_profile = $_GET['employee_profile'];
		$employee_fname = $_GET['employee_fname'];
		$my_order_id = $_GET['my_order_id'];
		$my_order_topic = $_GET['my_order_topic'];
		$my_order_desc = $_GET['my_order_desc'];
		$my_order_status = $_GET['my_order_status'];

							
		$sql = "INSERT INTO `my_order`(`circle_id`, `owner_id`, `owner_fname`, `employee_id`, `employee_profile`, `employee_fname`, `my_order_id`, `my_order_topic`, `my_order_desc`, `my_order_status`) VALUES ('$circle_id', '$owner_id', '$owner_fname', '$employee_id', '$employee_profile', '$employee_fname', Null, '$my_order_topic', '$my_order_desc', '$my_order_status')";

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