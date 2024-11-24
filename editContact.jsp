<%@ page import="java.sql.*, com.cms.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Contact</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        label, input[type="text"], input[type="submit"], input[type="checkbox"] {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 10px;
        }
        input[type="submit"] {
            background-color: #2196F3;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Contact</h2>
<%
    String id = request.getParameter("id");
    if (id == null || id.isEmpty()) {
        out.println("<a href='contactList.jsp'>Back to Contact List</a>");
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT name, email, phone, EMERGENCY FROM Contacts WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                boolean emergency = rs.getBoolean("EMERGENCY");
%>
                <form action="updateContact.jsp" method="post">
                    <input type="hidden" name="id" value="<%= id %>">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" required>
                    <label for="email">Email:</label>
                    <input type="text" id="email" name="email" value="<%= email %>" required>
                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="<%= phone %>" required>
                    <label for="emergency">Emergency Contact:</label>
                    <input type="checkbox" id="emergency" name="emergency" <% if (emergency) { %> checked <% } %> >
                    <input type="submit" value="Update Contact">
                </form>
<%
            } else {
                out.println("<p>Contact not found. <a href='contactList.jsp'>Back to Contact List</a></p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching contact details: " + e.getMessage() + ". <a href='contactList.jsp'>Back to Contact List</a></p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
</div>
</body>
</html>
