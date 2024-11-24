<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cms.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Contacts</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #673AB7;
            color: white;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 2.5em;
            margin: 0;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #673AB7;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            background-color: #673AB7;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1.2em;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #5E35B1;
        }
    </style>
</head>
<body>

<header>
    <h1>Contact Management System</h1>
</header>

<div class="container">
    <h2>View Contacts</h2>

    <!-- Table to Display Contacts -->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Emergency Contact</th>
        </tr>
        <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                conn = DBConnection.getConnection();

                // Create a statement
                stmt = conn.createStatement();

                // Execute SQL query to fetch specific columns
                String sql = "SELECT id, name, email, phone, emergency FROM Contacts";
                rs = stmt.executeQuery(sql);

                // Process the result set and display each contact
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    boolean isEmergency = rs.getBoolean("emergency");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= phone %></td>
            <td><%= isEmergency ? "Yes" : "No" %></td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                // Clean up resources
                if (rs != null) {
                    try { rs.close(); } catch (SQLException e) { /* Handle close exception */ }
                }
                if (stmt != null) {
                    try { stmt.close(); } catch (SQLException e) { /* Handle close exception */ }
                }
                if (conn != null) {
                    try { conn.close(); } catch (SQLException e) { /* Handle close exception */ }
                }
            }
        %>
    </table>

    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
