<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cms.db.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        .suggestion-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String query = request.getParameter("query");

    try {
        conn = DBConnection.getConnection();
        
        // Prepare SQL query with LIKE to search name or phone number
        String sql = "SELECT id, name, phone FROM Contacts WHERE name LIKE ? OR phone LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + query + "%");
        pstmt.setString(2, "%" + query + "%");
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String phone = rs.getString("phone");
%>
            <div class="suggestion-item" onclick="fillInput('<%= name %>')">
                <strong><%= name %></strong><br>
                <%= phone %>
            </div>
<%
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { /* Handle close exception */ }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { /* Handle close exception */ }
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* Handle close exception */ }
    }
%>
</body>
</html>
