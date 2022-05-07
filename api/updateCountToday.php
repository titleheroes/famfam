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
			
		$user_id = $_GET['user_id'];
        $today_i_do_text = $_GET['today_i_do_text'];
        $count = $_GET['count'];			
									
		$sql = " UPDATE count_today_i_do
                SET count = $count 
                where user_id = '$user_id' AND
                today_i_do_text = '$today_i_do_text' ";

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