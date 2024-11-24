<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cms.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Added</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #4CAF50;
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
        a {
            text-decoration: none;
            color: #4CAF50;
            font-size: 14px;
        }
    </style>
</head>
<body>

<header>
    <h1>Contact Management System</h1>
</header>

<div class="container">
    <h2>Contact Added Successfully</h2>

    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String emergency = request.getParameter("emergency") != null ? "Yes" : "No";

        if (name == null || name.trim().isEmpty()) {
            out.println("<p>Error: Name cannot be empty.</p>");
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Connect to the database
                conn = DBConnection.getConnection();

                // SQL Query to insert new contact
                String sql = "INSERT INTO Contacts (name, email, phone, emergency) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, phone);
                pstmt.setString(4, emergency);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Contact added successfully!</p>");
                    out.println("<p><strong>Name:</strong> " + name + "</p>");
                    out.println("<p><strong>Email:</strong> " + email + "</p>");
                    out.println("<p><strong>Phone Number:</strong> " + phone + "</p>");
                    out.println("<p><strong>Emergency Contact:</strong> " + emergency + "</p>");
                } else {
                    out.println("<p>Error adding contact. Please try again.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>An error occurred: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <br>
    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
