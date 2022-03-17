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
				
		$name = $_GET['name'];
		$uid = $_GET['uid'];
		$profileImage = $_GET['profileImage'];
		$fname = $_GET['fname'];
		$lname = $_GET['lname'];
		$phone = $_GET['phone'];
		$birth = $_GET['birth'];
		$address = $_GET['address'];
		$personal = $_GET['ID'];
		$jobs = $_GET['jobs'];
		
							
		$sql = "INSERT INTO `user`(`id`, `uid`, `profileImage`, `fname`, `lname`, `phone`, `birth`, `address`, `personalID`, `jobs`) VALUES (Null,'$uid','$profileImage','$fname','$lname','$phone','$birth','$address','$personalID','$jobs')";

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