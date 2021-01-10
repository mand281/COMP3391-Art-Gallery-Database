
<font=arial>
	<h1>
		Welcome to Blue Horizons Art Gallery
	</h1>
	<h2>Find upcoming events 2021</h2>
</font>

<h3>Search by month</h3>

<form method="get" 	  
	  action="event_query_output.php">
	<select name="Event_Month">
		<?php
			require('connect.php');
			
			//Query to populate month dropdown
			$get_month = "SELECT DISTINCT MONTHNAME(Exhibition_Date_Start) as month
              FROM exhibition 
              WHERE Exhibition_Date_Start < CURRENT_TIMESTAMP
              ORDER BY Exhibition_Date_Start ASC;";
			
			$dropdown = mysqli_query($conn,$get_month);
			
			if(mysqli_num_rows($dropdown) > 0){
				while($row=mysqli_fetch_assoc($dropdown)){
					?>
						<option value = 
							<?php echo $row["month"]; ?>>
							<?php echo $row["month"]; ?>
						</option>
					<?php
				}
			}
			?>
	</select>
	<input type="submit" value="Search">
</form>

	