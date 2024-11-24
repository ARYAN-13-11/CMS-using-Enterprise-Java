<%@ page import="java.sql.*, com.cms.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Contact</title>
</head>
<body>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String emergencyParam = request.getParameter("emergency");
    boolean emergency = (emergencyParam != null && emergencyParam.equals("on"));

    if (id == null || name == null || email == null || phone == null) {
        out.println("<p>Invalid contact information. <a href='contactList.jsp'>Back to Contact List</a></p>");
    } else {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE Contacts SET name = ?, email = ?, phone = ?, EMERGENCY = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setBoolean(4, emergency);
            pstmt.setInt(5, Integer.parseInt(id));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<p>Contact updated successfully! <a href='contactList.jsp'>Back to Contact List</a></p>");
            } else {
                out.println("<p>Error updating contact. <a href='contactList.jsp'>Back to Contact List</a></p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error updating contact: " + e.getMessage() + ". <a href='contactList.jsp'>Back to Contact List</a></p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
</body>
</html>
