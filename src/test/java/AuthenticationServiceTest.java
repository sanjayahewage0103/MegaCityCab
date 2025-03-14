
import com.example.megacitycab.dao.CustomerDAO;
import com.example.megacitycab.service.AuthenticationService;
import com.example.megacitycab.util.PasswordHasher;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.lang.reflect.Field;

import static org.junit.jupiter.api.Assertions.*;

class AuthenticationServiceTest {

    private AuthenticationService authenticationService;
    private CustomerDAO mockCustomerDAO;


    @BeforeEach
    void setUp() throws Exception {
        // Simulate a CustomerDAO without using Mockito
        mockCustomerDAO = new CustomerDAO() {
            @Override
            public String getHashedPasswordByEmail(String email) {
                if ("pethumhewage667@gmail.com".equals(email)) {
                    return PasswordHasher.hashPassword("12345");
                }
                return null; // Invalid email
            }
        };

        authenticationService = new AuthenticationService();

        // Use reflection to set the private customerDAO field
        Field customerDAOField = AuthenticationService.class.getDeclaredField("customerDAO");
        customerDAOField.setAccessible(true);
        customerDAOField.set(authenticationService, mockCustomerDAO);
    }

    @Test
    void testAuthenticateCustomer_ValidCredentials() {
        // Arrange
        String validEmail = "pethumhewage667@gmail.com";
        String validPassword = "12345";

        // Act
        boolean isAuthenticated = authenticationService.authenticateCustomer(validEmail, validPassword);

        // Assert
        assertTrue(isAuthenticated, "Authentication should succeed for valid credentials.");
    }

    @Test
    void testAuthenticateCustomer_InvalidEmail() {
        // Arrange
        String invalidEmail = "invalid.customer@example.com";
        String validPassword = "correctPassword";

        // Act
        boolean isAuthenticated = authenticationService.authenticateCustomer(invalidEmail, validPassword);

        // Assert
        assertFalse(isAuthenticated, "Authentication should fail for an invalid email.");
    }

    @Test
    void testAuthenticateCustomer_InvalidPassword() {
        // Arrange
        String validEmail = "valid.customer@example.com";
        String invalidPassword = "wrongPassword";

        // Act
        boolean isAuthenticated = authenticationService.authenticateCustomer(validEmail, invalidPassword);

        // Assert
        assertFalse(isAuthenticated, "Authentication should fail for an invalid password.");
    }

    @Test
    void testAuthenticateCustomer_EmptyCredentials() {
        // Arrange
        String emptyEmail = "";
        String emptyPassword = "";

        // Act
        boolean isAuthenticated = authenticationService.authenticateCustomer(emptyEmail, emptyPassword);

        // Assert
        assertFalse(isAuthenticated, "Authentication should fail for empty credentials.");
    }
}