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
				
		$host_id = $_GET['host_id'];
		$host_profile = $_GET['host_profile'];
		$circle_id = $_GET['circle_id'];
		$vote_uid = $_GET['vote_uid'];
		$vote_topic = $_GET['vote_topic'];
		
							
		$sql = "INSERT INTO `vote`(`host_id`, `host_profile`, `circle_id`, `vote_id`, `vote_uid`, `vote_topic`, `vote_final`) VALUES ('$host_id','$host_profile','$circle_id',Null,'$vote_uid','$vote_topic',Null)";

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