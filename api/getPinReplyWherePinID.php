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

		$result = mysqli_query($link, " SELECT pinpost.pin_id, pinpost.circle_id, pin_reply.pin_reply_id, pin_reply.author_id as reply_user_id, pin_reply.pin_reply_text, pin_reply.date, user.fname, user.lname, user.profileImage
        FROM pinpost INNER JOIN pin_reply 
        on pinpost.pin_id = pin_reply.pin_id
        INNER JOIN user
        ON pin_reply.author_id = user.id
        WHERE pinpost.pin_id = $pin_id
        order by pin_reply.date ASC
		");

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