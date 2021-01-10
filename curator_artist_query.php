// Display header

<font=arial>
	<h1>
		Welcome to Blue Horizons Art Gallery
	</h1>
	<h2>Search artworks by Artist</h2></font>

	// Get user input whole or part of a surname

	<form method="post" action="curator_artist_output.php">
		<h4>Enter all or part of an surname below:</h4>
		
		<input name="artist_surname" type="search">
		<input type="submit" value="search">
	</form>


//Alternatively give the user the option to choose an artist from a dropdown menu

	<form method="get" action="curator_artist_output.php">
		<select name="artist_surname2">
			<?php
			require('connect.php');
			
			$get_artist = "SELECT Distinct ar.Artist_Last_Name FROM artist ar ORDER BY ar.Artist_Last_Name  ASC;";
			
			$dropdown = mysqli_query($conn,$get_artist);
			if(mysqli_num_rows($dropdown) > 0){
				while($row=mysqli_fetch_assoc($dropdown)){
					?>
			<option value=<?php echo $row["Artist_Last_Name"]; ?>>
				<?php echo $row["Artist_Last_Name"]; ?>
			</option>
			<?php
				}
			}
			?>
		</select>
		<input type="submit" value="Search">

	</form>
