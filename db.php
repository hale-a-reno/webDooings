
<?php
$con=mysqli_connect("localhost","root","lampy","testOTTDelivery");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$result = mysqli_query($con,"SELECT * FROM Delivery");

echo "<table border=\"2\" class=\"table table-striped table-hover\">
<tr>
<th>Delivey</th>
<th>Supplier</th>
<th>Delivery_ID</th>
<th>Date</th>
</tr>";

while($row = mysqli_fetch_array($result))
  {
  echo "<tr>";
  echo "<td>" . $row['Delivery'] . "</td>";
  echo "<td>" . $row['Supplier'] . "</td>";
  echo "<td>" . $row['DeliveryID'] . "</td>";
  echo "<td>" . $row['Date'] . "</td>";
  echo "</tr>";
  }
echo "</table>";

mysqli_close($con);
?>

