package com.cms.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // URL of the Derby database you want to connect to
    private static final String DB_URL = "jdbc:derby://localhost:1527/ContactsDB";
    
    // Database credentials
    private static final String USER = "root"; // Replace with your database username
    private static final String PASSWORD = "root"; // Replace with your database password

    // Method to establish and return a connection to the database
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load the Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        
        // Return the connection object using DriverManager
        return DriverManager.getConnection(DB_URL, USER, PASSWORD);
    }
}
