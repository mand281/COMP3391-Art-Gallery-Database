<?php
// Procedural mysqli

require('connect.php');
include('admin_staff_query.php');

$staff_member = $_POST['staff_member'];

//SQL query
$sql = "select distinct e.Exhibition_Date_Start, e.Exhibition_Date_End, e.Exhibition_Desc as 'Event_Name', es.Exhibition_ID AS 'Exhibition_ID',concat_ws(' ', st.Staff_First_Name,st.Staff_Last_Name) AS 'Staff_Name', sr.Staff_Role_Desc AS `Role` 
from staff st
inner join exhibition_staff es on st.Staff_ID  = es.Staff_ID
INNER JOIN exhibition e on es.Exhibition_ID = e.Exhibition_ID
inner join staff_role sr on st.Staff_Role_ID = sr.Staff_Role_ID 
WHERE es.Exhibition_ID = '$staff_member'
order by es.Exhibition_ID asc
";

// Run query
$result = mysqli_query($conn, $sql);


echo "<table border=1>
<tr>
			<th> Event ID</th>
			<th> Event Name </th>
			<th> Event Start Title </th>
			<th> Event End </th>
			<th> Staff name </th>
			<th> Staff role </th>
			
		</tr></br>";


//Output results
if (mysqli_num_rows($result) > 0)
{
	while($row = mysqli_fetch_assoc($result))
	{						
echo "<tr>";
echo "<td>" . $row['Exhibition_ID'] . "</td>";
echo "<td>" . $row['Event_Name']  . "</td>";
echo "<td>" . $row['Exhibition_Date_Start'] . "</td>";
echo "<td>" . $row['Exhibition_Date_End'] . "</td>";
echo "<td>" . $row['Staff_Name'] . "</td>";
echo "<td>" . $row['Role'] . "</td>";
		
echo "</tr>";
	}
echo "</table>";	
}
else {
echo "No results found";
}

mysqli_close($conn)
?>