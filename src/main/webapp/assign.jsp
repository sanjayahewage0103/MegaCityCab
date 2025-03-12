<%--
  Created by IntelliJ IDEA.
  User: pethu
  Date: 3/12/2025
  Time: 5:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title><%@ page contentType="text/html;charset=UTF-8" language="java" %>
      <!DOCTYPE html>
      <html>
      <head>
      <title>Assign Driver and Vehicle</title>
  </head>
  <body>
  <h1>Assign Driver and Vehicle</h1>
  <p>Booking ID: <%= request.getAttribute("bookingId") %></p>
  <form method="post" action="/admin/assign-booking">
    <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") %>">

    <label for="driverId">Driver:</label>
    <select name="driverId" id="driverId" required>
      <option value="">Select a driver</option>
      <%
        // Retrieve the list of drivers from the request attribute
        java.util.List<?> drivers = (java.util.List<?>) request.getAttribute("drivers");
        if (drivers != null) {
          for (Object obj : drivers) {
            com.example.megacitycab.model.Driver driver = (com.example.megacitycab.model.Driver) obj;
      %>
      <option value="<%= driver.getDriverId() %>"><%= driver.getFirstName() %> <%= driver.getLastName() %> (<%= driver.getLicenseNumber() %>)</option>
      <%
          }
        }
      %>
    </select><br>

    <label for="vehicleId">Vehicle:</label>
    <select name="vehicleId" id="vehicleId" required>
      <option value="">Select a vehicle</option>
      <%
        // Retrieve the list of vehicles from the request attribute
        java.util.List<?> vehicles = (java.util.List<?>) request.getAttribute("vehicles");
        if (vehicles != null) {
          for (Object obj : vehicles) {
            com.example.megacitycab.model.Vehicle vehicle = (com.example.megacitycab.model.Vehicle) obj;
      %>
      <option value="<%= vehicle.getVehicleId() %>"><%= vehicle.getVehicleNumber() %> (<%= vehicle.getType() %>)</option>
      <%
          }
        }
      %>
    </select><br>

    <button type="submit">Assign</button>
  </form>
  </body>
</html></title>
  </head>
  <body>
  
  </body>
</html>
