package com.pharmacy.util;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class PasswordUtilTest {

    @Test
    public void testHashAndPasswordCheck() {
        String password = "superSecretPassword123";
        String hash = PasswordUtil.hashPassword(password);
        
        assertNotNull(hash);
        assertTrue(hash.startsWith("$2a$"));
        assertTrue(PasswordUtil.checkPassword(password, hash));
        assertFalse(PasswordUtil.checkPassword("wrongPassword", hash));
    }

    @Test
    public void testCheckPasswordWithNullOrInvalidHash() {
        assertFalse(PasswordUtil.checkPassword("password", null));
        assertFalse(PasswordUtil.checkPassword("password", "invalidHash"));
        assertFalse(PasswordUtil.checkPassword("password", ""));
    }
}
