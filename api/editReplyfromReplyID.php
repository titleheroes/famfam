<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");
	error_reporting(E_ERROR | E_PARSE);

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}else {

	if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$pin_reply_id = $_GET['pin_reply_id'];
        $pin_reply_text = $_GET['pin_reply_text'];			
									
		$sql = "update pin_reply 
        set pin_reply_text = '$pin_reply_text'
        WHERE pin_reply_id = '$pin_reply_id' ";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>