<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.megacitycab.dao.BookingDAO" %>
<%@ page import="com.example.megacitycab.model.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bookings</title>
</head>
<body>
<h1>Your Bookings</h1>

<table border="1">
    <tr>
        <th>Booking ID</th>
        <th>Vehicle Type</th>
        <th>Pickup Location</th>
        <th>Drop Location</th>
        <th>Distance (km)</th>
        <th>Date</th>
        <th>Time</th>
        <th>Status</th>
    </tr>
    <%
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookingsByCustomerId(1); // Assuming customer ID is 1
        for (Booking booking : bookings) {
    %>
    <tr>
        <td><%= booking.getBookingId() %></td>
        <td><%= booking.getVehicleType() %></td>
        <td><%= booking.getPickupLocation() %></td>
        <td><%= booking.getDropLocation() %></td>
        <td><%= booking.getTotalDistance() %></td>
        <td><%= booking.getDate() %></td>
        <td><%= booking.getTime() %></td>
        <td><%= booking.getStatus() %></td>
    </tr>
    <% } %>
</table>
</body>
</html>