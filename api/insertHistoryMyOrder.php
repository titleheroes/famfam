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
				
		$history_my_order_uid = $_GET['history_my_order_uid'];
		$owner_fname = $_GET['owner_fname'];
		$my_order_topic = $_GET['my_order_topic'];
		$my_order_status = $_GET['my_order_status'];
							
		$sql = "INSERT INTO `history_my_order`(`history_my_order_id`, `history_my_order_uid`, `owner_fname`, `my_order_topic`, `my_order_status`) VALUES (Null ,'$history_my_order_uid','$owner_fname','$my_order_topic','$my_order_status')";

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