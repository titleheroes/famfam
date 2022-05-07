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
				
		$history_pinpost_uid = $_GET['history_pinpost_uid'];
		$author_name = $_GET['author_name'];
		$history_isreply = $_GET['history_isreply'];
							
		$sql = "INSERT INTO `history_pinpost`(`history_pinpost_id`, `history_pinpost_uid`, `author_name`, `history_isreply`) VALUES (Null,'$history_pinpost_uid','$author_name','$history_isreply')";

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