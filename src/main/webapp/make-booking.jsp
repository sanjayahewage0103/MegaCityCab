<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Make a Booking</title>
</head>
<body>
<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp?error=You must log in to make a booking.");
        return;
    }
    String email = (String) session.getAttribute("email");
%>
<h1>Book a Ride</h1>

<% if (request.getAttribute("error") != null) { %>
<div class="error"><%= request.getAttribute("error") %></div>
<% } %>

<form method="post" action="booking-servlet">
    <input type="hidden" name="action" value="calculate-fare">

    <!-- Vehicle Type -->
    Vehicle Type:
    <select name="vehicleType" required>
        <option value="Sedan">Sedan</option>
        <option value="SUV">SUV</option>
        <option value="Van">Van</option>
    </select><br>

    <!-- Pickup Location -->
    Pickup Location:
    <select name="pickupLocation" required>
        <option value="Colombo 1">Colombo 1</option>
        <option value="Colombo 2">Colombo 2</option>
        <option value="Colombo 3">Colombo 3</option>
        <option value="Colombo 4">Colombo 4</option>
    </select><br>

    <!-- Drop Location -->
    Drop Location:
    <select name="dropLocation" required>
        <option value="Colombo 1">Colombo 1</option>
        <option value="Colombo 2">Colombo 2</option>
        <option value="Colombo 3">Colombo 3</option>
        <option value="Colombo 4">Colombo 4</option>
    </select><br>

    <!-- Date and Time -->
    Date: <input type="date" name="date" required><br>
    Time: <input type="time" name="time" required><br>

    <!-- Number of Passengers -->
    Number of Passengers: <input type="number" name="numPassengers" required><br>

    <!-- Promo Code -->
    Promo Code (Optional): <input type="text" name="promoCode"><br>

    <!-- Submit Button -->
    <button type="submit">Calculate Fare</button>
</form>
</body>
</html>


