<?php

include('manager_staff_query.php');
require('connect.php');

//Get the form value
$Event_Month = $_GET["Event_Month"];


//SQL query
$sql =  	
"SELECT 
DATE_FORMAT(Exhibition_Date_Start, '%d-%m-%Y') as Event_Start, Exhibition_Desc,MONTHNAME(Exhibition_Date_Start) AS Month,	 DATE_FORMAT(Exhibition_Date_End, '%d-%m-%Y') as Event_End
FROM exhibition 
WHERE  MONTHNAME(Exhibition_Date_Start) = '$Event_Month'             
";

$result = mysqli_query($conn,$sql);

if(mysqli_num_rows($result) >0)
{ 
echo "<table border='1'>
<tr>
<th>Event Title</th>
<th>Start Date</th>
<th>End Date</th>
</tr>";

 
while($row = mysqli_fetch_assoc($result)){
		
						
echo "<tr>";
echo "<td>" . $row['Exhibition_Desc'] . "</td>";
echo "<td>" . $row['Event_Start'] . "</td>";
echo "<td>" . $row['Event_End'] . "</td>";
echo "</tr>";
	}
	
echo "</table>";
}
else {
	echo "No results found";
}
mysqli_close($conn);

?>