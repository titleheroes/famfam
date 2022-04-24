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
				
		$id = $_GET['id'];
		$title = $_GET['title'];
		$note = $_GET['note'];
		$location = $_GET['location'];
		$date = $_GET['date'];
        $time_start = $_GET['time_start'];
        $time_end = $_GET['time_end'];
        $repeating = $_GET['repeating'];
		$repeat_end_date = $_GET['repeat_end_date'];
        $user_id = $_GET['user_id'];
        $circle_id = $_GET['circle_id'];
        

		
							
		$sql = "INSERT INTO `calendar_att`(`id`, `title`, `note`, `location`, `date`, `time_start`, `time_end`, `repeating`,`repeat_end_date`, `user_id`, `circle_id`) VALUES (Null,'$title','$note','$location','$date','$time_start','$time_end','$repeating',$repeat_end_date,'$user_id','$circle_id')";
		

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