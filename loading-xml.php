<?php
	$hash = $_POST["hash"];				//hash 
	$action = $_POST["action"];			//action
	$filename = $_POST["filename"];     //filename

	$foldername = "xmls/temp" ;
		
	if ($action == "base")
		$foldername = "xmls/base" ;
	if ($action == "finish")
		$foldername = "xmls/finish" ;
		
	$f = fopen("log_loading.txt", "a");
	
	fwrite($f, "\n\n++++++++++++++INICIO\n");
	fwrite($f, "\nhash: " . 					$hash);
	fwrite($f, "\nfolder/filename: " . 			$foldername . "/". $filename);
	fwrite($f, "\naction: " . 					$action);
	fwrite($f, "\n++++++++++++++FIM\n");
	
	$exists = "exists=true"; 
	
	if (!is_file($foldername . "/". $filename)) {
		$exists = "exists=false";
		fwrite($f, $exists);
		fclose($f);
		die("Can't open file"); 
	}
	
	fclose($f); 
		
	header("Content-type: text/xml");
		
    $xml_output =file_get_contents($foldername . "/". $filename);
	echo $xml_output;
?>