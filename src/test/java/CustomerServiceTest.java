
import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.service.CustomerService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class CustomerServiceTest {

    private CustomerService customerService;
    private CustomerDAO mockCustomerDAO;

    @BeforeEach
    void setUp() {
        // Simulate a CustomerDAO without using Mockito
        mockCustomerDAO = new CustomerDAO() {

            @Override
            public boolean isNicExists(String nic) {
                // Simulate NIC existence check
                return "123456789V".equals(nic);
            }

            @Override
            public int getTotalRides(int customerId) throws SQLException {
                return 5; // Simulated total rides
            }

            @Override
            public double getTotalDistance(int customerId) throws SQLException {
                return 120.5; // Simulated total distance
            }

            @Override
            public double getTotalSavings(int customerId) throws SQLException {
                return 25.75; // Simulated total savings
            }

            @Override
            public List<Map<String, Object>> getRecentBookings(int customerId) throws SQLException {
                // Simulated recent bookings
                Map<String, Object> booking = new HashMap<>();
                booking.put("booking_id", 1);
                booking.put("destination", "Colombo");
                booking.put("distance", 10.5);
                return List.of(booking);
            }
        };

        customerService = new CustomerService(mockCustomerDAO); // Inject the simulated DAO
    }



    @Test
    void testRegisterCustomer_InvalidEmail() {
        // Arrange
        String name = "John Doe";
        String email = "invalid-email"; // Invalid email format
        String address = "Colombo";
        String contact = "0771234567";
        String nic = "987654321V";
        String password = "password123";

        // Act
        String result = customerService.registerCustomer(name, email, address, contact, nic, password);

        // Assert
        assertEquals("Invalid email format.", result, "Invalid email should fail registration.");
    }

    @Test
    void testRegisterCustomer_NicAlreadyExists() {
        // Arrange
        String name = "John Doe";
        String email = "john.doe@example.com";
        String address = "Colombo";
        String contact = "0771234567";
        String nic = "123456789V"; // Already exists in the simulated DAO
        String password = "password123";

        // Act
        String result = customerService.registerCustomer(name, email, address, contact, nic, password);

        // Assert
        assertEquals("NIC already registered.", result, "Duplicate NIC should fail registration.");
    }

    @Test
    void testGetTotalRides() throws SQLException {
        // Arrange
        int customerId = 1;

        // Act
        int totalRides = customerService.getTotalRides(customerId);

        // Assert
        assertEquals(5, totalRides, "Total rides should match the simulated DAO response.");
    }

    @Test
    void testGetTotalDistance() throws SQLException {
        // Arrange
        int customerId = 1;

        // Act
        double totalDistance = customerService.getTotalDistance(customerId);

        // Assert
        assertEquals(120.5, totalDistance, 0.001, "Total distance should match the simulated DAO response.");
    }

    @Test
    void testGetTotalSavings() throws SQLException {
        // Arrange
        int customerId = 1;

        // Act
        double totalSavings = customerService.getTotalSavings(customerId);

        // Assert
        assertEquals(25.75, totalSavings, 0.001, "Total savings should match the simulated DAO response.");
    }

    @Test
    void testGetRecentBookings() throws SQLException {
        // Arrange
        int customerId = 1;

        // Act
        List<Map<String, Object>> recentBookings = customerService.getRecentBookings(customerId);

        // Assert
        assertNotNull(recentBookings, "Recent bookings list should not be null.");
        assertEquals(1, recentBookings.size(), "There should be one recent booking in the simulated DAO response.");
        assertEquals("Colombo", recentBookings.get(0).get("destination"), "Destination should match the simulated DAO response.");
    }
}