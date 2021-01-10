<?php
require('connect.php');
include('curator_artist_query.php');

$artist_surname = $_POST["artist_surname"];

$artist_surname2 = $_POST["artist_surname2"];
$artist_surname = mysqli_real_escape_string($conn,$artist_surname);


// SQL query
$sql = "SELECT * FROM artist ar  
INNER JOIN artwork aw ON ar.Artist_ID = aw.Artwork_Artist_ID
WHERE (ar.Artist_Last_Name like '$artist_surname%' OR ar.Artist_Last_Name = '$artist_surname2')
ORDER BY ar.Artist_Last_Name  ASC;
";

// Run query and Output results from inputted data
$result = mysqli_query($conn, $sql);


if (mysqli_num_rows($result) > 0) {
echo "<table border=1>
		<tr>
			<th> Artwork ID</th>
			<th> Artist Name </th>
			<th> Artwork Title </th>
			<th> Price </th>
			<th> Sold </th>
		</tr></br>";

	while($row = mysqli_fetch_assoc($result)){						
echo "<tr>";
echo "<td>" . $row['Artist_ID'] . "</td>";
echo "<td>" . $row['Artist_Last_Name']  . "</td>";
echo "<td>" . $row['Artwork_Title'] . "</td>";
echo "<td>" . $row['Artwork_Price_GBP'] . "</td>";
echo "<td>" . $row['Artwork_Sold'] . "</td>";
echo "</tr>";
	}
echo "</table>";	
}
	
else {
echo "No results found";
}

mysqli_close($conn)
?>

