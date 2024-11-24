<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cms.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Contact</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #F44336;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        p {
            font-size: 16px;
        }
        a {
            text-decoration: none;
            color: #F44336;
            font-size: 14px;
        }
    </style>
</head>
<body>

<header>
    <h1>Contact Management System</h1>
</header>

<div class="container">
    <h2>Delete Contact</h2>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        String id = request.getParameter("id");

        try {
            // Establish database connection
            conn = DBConnection.getConnection();

            // Prepare SQL query to delete the contact
            String sql = "DELETE FROM Contacts WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
    %>
    <p>Contact with ID <%= id %> has been successfully deleted.</p>
    <%
            } else {
    %>
    <p>No contact found with ID <%= id %>.</p>
    <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Clean up resources
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { /* Handle close exception */ }
            }
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { /* Handle close exception */ }
            }
        }
    %>
    <br>
    <a href="deleteContact.jsp">Go Back to Delete Another Contact</a>
    <br>
    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
