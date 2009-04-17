<?php
$base         = 'http://localhost:8080/exist/rest/db/xqueries/getProjectById.xql';
$query_string = 'knb-lter-cap.8.1';

$url = $base."?id=".$query_string;


$xml = file_get_contents($url);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<?php
	echo $xml;
?>  </body>
</html>


