package com.example.app;

import java.security.SecureRandom;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Secure Number Generator
 *
 */
public class App {
    private static final Logger logger = LogManager.getLogger(App.class);

    public static void main(String[] args) {
        logger.info("Generating a secure random number...");
        int number = new SecureRandom().nextInt();
        System.out.println("Secure random number: " + number);
    }
}
