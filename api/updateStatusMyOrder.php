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


		$my_order_id = $_GET['my_order_id'];
		$my_order_status = $_GET['my_order_status'];


		$sql = "UPDATE my_order SET my_order_status = '$my_order_status'  WHERE my_order_id = '$my_order_id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
            echo "true";

        } else {
            echo "false";
        }


	} else echo "Welcome Master UNG";	// if2
   
}	// if1


	mysqli_close($link);
?>