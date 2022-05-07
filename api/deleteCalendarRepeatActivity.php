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
			
		$id = $_GET['id'];
        $circle_id = $_GET['circle_id'];
        $title = $_GET['title'];
        $location = $_GET['location'];
        $note = $_GET['note'];

									
		$sql = " DELETE FROM calendar_att
                    WHERE circle_id = '$circle_id' AND
                    repeating = '1' AND
                    title = '$title' AND
                    note = '$note' AND
                    location = '$location' ";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "True";
		} else {
			echo "False";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>