
import com.example.megacitycab.service.AdminService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class AdminServiceTest {

    private AdminService adminService;

    @BeforeEach
    void setUp() {
        adminService = new AdminService();
    }

    @Test
    void testAuthenticateAdmin_ValidCredentials() {
        String validUsername = "admin";
        String validPassword = "admin123";
        boolean isAuthenticated = adminService.authenticateAdmin(validUsername, validPassword);

        assertTrue(isAuthenticated, "Authentication should succeed for valid credentials.");
    }

    @Test
    void testAuthenticateAdmin_InvalidUsername() {
        String invalidUsername = "invalidUser";
        String validPassword = "password123";

        boolean isAuthenticated = adminService.authenticateAdmin(invalidUsername, validPassword);

        assertFalse(isAuthenticated, "Authentication should fail for invalid username.");
    }

    @Test
    void testAuthenticateAdmin_InvalidPassword() {
        String validUsername = "admin";
        String invalidPassword = "wrongPassword";

        boolean isAuthenticated = adminService.authenticateAdmin(validUsername, invalidPassword);

        assertFalse(isAuthenticated, "Authentication should fail for invalid password.");
    }

    @Test
    void testAuthenticateAdmin_EmptyCredentials() {
        String emptyUsername = "";
        String emptyPassword = "";

        boolean isAuthenticated = adminService.authenticateAdmin(emptyUsername, emptyPassword);

        assertFalse(isAuthenticated, "Authentication should fail for empty credentials.");
    }
}