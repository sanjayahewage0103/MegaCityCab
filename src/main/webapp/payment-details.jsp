<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Details</title>
</head>
<body>
<h1>Payment Details</h1>

<p><strong>Pickup Location:</strong> ${pickupLocation}</p>
<p><strong>Drop Location:</strong> ${dropLocation}</p>
<p><strong>Date:</strong> ${date}</p>
<p><strong>Time:</strong> ${time}</p>
<p><strong>Total Distance:</strong> ${totalDistance} km</p>
<p><strong>Vehicle Type:</strong> ${vehicleType}</p>
<p><strong>Number of Passengers:</strong> ${numPassengers}</p>

<p><strong>Base Price:</strong> $${basePrice}</p>
<p><strong>Tax Amount:</strong> $${taxAmount}</p>
<p><strong>Discount Applied:</strong> $${discountAmount}</p>
<p><strong>Final Fare:</strong> $${finalFare}</p>

<form method="post" action="confirm-booking">
    <!-- Hidden Fields -->
    <input type="hidden" name="customerId" value="${customerId}">
    <input type="hidden" name="pickupLocation" value="${pickupLocation}">
    <input type="hidden" name="dropLocation" value="${dropLocation}">
    <input type="hidden" name="date" value="${date}">
    <input type="hidden" name="time" value="${time}">
    <input type="hidden" name="numPassengers" value="${numPassengers}">
    <input type="hidden" name="vehicleType" value="${vehicleType}">
    <input type="hidden" name="totalDistance" value="${totalDistance}">
    <input type="hidden" name="basePrice" value="${basePrice}">
    <input type="hidden" name="taxAmount" value="${taxAmount}">
    <input type="hidden" name="discountAmount" value="${discountAmount}">
    <input type="hidden" name="finalFare" value="${finalFare}">

    <!-- Payment Method Selection -->
    <label for="paymentMethod">Payment Method:</label>
    <select id="paymentMethod" name="paymentMethod" required>
        <option value="Cash">Cash</option>
        <option value="Card">Card</option>
    </select><br><br>

    <!-- Submit Button -->
    <button type="submit">Confirm Booking</button>
</form>
</body>
</html>