// Display header

<font=arial>
	<h1>
		Welcome to Blue Horizons Art Gallery
	</h1>
	<h2>
		Choose an event to display allocated staff
	</h2>
</font>

	// Get Event from dropdown menu

	<form method="post" action="admin_staff_output.php">
		<h4>Pick an event ID from the menu below:</h4>


		<select name="staff_member">
			<?php
			require('connect.php');
			
			//Query to populate dropdown
			$get_make = "SELECT * FROM exhibition";
			
			$dropdown = mysqli_query($conn,$get_make);
			
			if(mysqli_num_rows($dropdown) > 0){
				while($row=mysqli_fetch_assoc($dropdown)){
					?>
			<option value=<?php echo $row["Exhibition_ID"]; ?>>
				<?php echo $row["Exhibition_ID"]; ?>
			</option>
			<?php
				}
			}
			?>
		</select>
	
		<input type="submit" value="Search">
		</form>
