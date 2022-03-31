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
				
		$pin_id = $_GET['pin_id'];

		$result = mysqli_query($link, " SELECT pinpost.pin_id, pinpost.author_id, pinpost.pin_text, COUNT(pin_reply.pin_reply_id) as 'number_of_reply'
        from pinpost INNER join pin_reply
        ON pinpost.pin_id = pin_reply.pin_id
        WHERE pinpost.pin_id = $pin_id ");

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} else echo "Welcome";	// if2
   
}	// if1


	mysqli_close($link);
?>