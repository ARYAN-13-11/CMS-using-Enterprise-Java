<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cms.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Contact</title>
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
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
        }
        input[type="text"], input[type="email"] {
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="checkbox"] {
            margin-top: 10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            margin-top: 20px;
            font-size: 16px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a {
            text-decoration: none;
            color: #4CAF50;
            font-size: 14px;
        }
    </style>
    <script>
        function validateForm() {
            // Validate the phone number field to ensure it contains exactly 10 digits
            var phone = document.getElementById("phone").value;
            var phonePattern = /^[0-9]{10}$/;  // Only 10 digits

            if (!phonePattern.test(phone)) {
                alert("Please enter a valid 10-digit phone number.");
                return false; // Prevent form submission
            }
            return true; // Allow form submission if valid
        }
    </script>
</head>
<body>

<header>
    <h1>Contact Management System</h1>
</header>

<div class="container">
    <h2>Add New Contact</h2>

    <!-- Contact form with required "name" field and validation for phone number -->
    <form method="post" action="addContact.jsp" onsubmit="return validateForm()">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email">

        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" required pattern="[0-9]{10}" 
               title="Phone number must be 10 digits">

        <label for="emergency">Is Emergency Contact:</label>
        <input type="checkbox" id="emergency" name="emergency">

        <input type="submit" value="Add Contact">
    </form>

    <%
        // Only process form submission if the request method is POST and name is not null
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");

            // Back-end validation for phone number: exactly 10 digits
            if (name != null && !name.trim().isEmpty()) {
                if (phone == null || !phone.matches("\\d{10}")) {
                    out.println("<p>Error: Phone number must be exactly 10 digits.</p>");
                } else {
                    String email = request.getParameter("email");
                    boolean isEmergency = request.getParameter("emergency") != null;

                    Connection conn = null;
                    PreparedStatement stmt = null;

                    try {
                        // Establish database connection
                        conn = DBConnection.getConnection();

                        // SQL Insert Query
                        String sql = "INSERT INTO Contacts (name, email, phone, emergency) VALUES (?, ?, ?, ?)";

                        // Prepare statement
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, name);
                        stmt.setString(2, email);
                        stmt.setString(3, phone);
                        stmt.setBoolean(4, isEmergency);

                        // Execute the statement
                        int rowsAffected = stmt.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<p>Contact added successfully!</p>");
                        } else {
                            out.println("<p>Error adding contact.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        // Clean up resources
                        if (stmt != null) {
                            try { stmt.close(); } catch (SQLException e) { /* Handle close exception */ }
                        }
                        if (conn != null) {
                            try { conn.close(); } catch (SQLException e) { /* Handle close exception */ }
                        }
                    }
                }
            } else {
                out.println("<p>Error: Name field cannot be empty. Please enter a valid name.</p>");
            }
        }
    %>
    <br>
    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
