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
            width: 80%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #F44336;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        form {
            display: inline;
        }
        input[type="submit"] {
            background-color: #F44336;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #D32F2F;
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
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    conn = DBConnection.getConnection();

                    // Fetch all contacts from the database
                    String sql = "SELECT id, name, email, phone FROM Contacts";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    // Display each contact in a table row with a delete button
                    while (rs.next()) {
                        int contactId = rs.getInt("id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
            %>
            <tr>
                <td><%= contactId %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
                <td>
                    <form action="deleteContactAction.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this contact?');">
                        <input type="hidden" name="id" value="<%= contactId %>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) { try { rs.close(); } catch (SQLException e) { /* Handle close exception */ } }
                    if (pstmt != null) { try { pstmt.close(); } catch (SQLException e) { /* Handle close exception */ } }
                    if (conn != null) { try { conn.close(); } catch (SQLException e) { /* Handle close exception */ } }
                }
            %>
        </tbody>
    </table>
    <br>
    <a href="index.html">Go Back to Home</a>
</div>

</body>
</html>
