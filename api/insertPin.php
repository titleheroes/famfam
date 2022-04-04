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
		$date = $_GET['date'];
		$author_id = $_GET['author_id'];
		$pin_text = $_GET['pin_text'];
		
							
		$sql = "INSERT INTO `pinpost`(`pin_id`, `circle_id`, `author_id`, `pin_text`) VALUES (NULL,$circle_id,$author_id,'$pin_text')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
			/*
			echo $date;
			echo "\n";
			echo $author_id;
			echo "\n";
			echo $pin_text;
			*/
		} else {
			echo "false";
		}

	} else echo "Ready to Insert Pinpost";
   
}
	mysqli_close($link);
?>