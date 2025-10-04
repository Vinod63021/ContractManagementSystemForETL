<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String closeStatus = (String) session.getAttribute("closeStatus");
    if (closeStatus != null) {
%>
    <%-- ALERT MESSAGES --%>
    <div class="container mt-3">
    <%
        if ("success".equals(closeStatus)) {
    %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            &#x2705; Complaint closed successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%
        } else if ("fail".equals(closeStatus)) {
    %>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            &#x26A0; Failed to close the complaint. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%
        } else if ("error".equals(closeStatus)) {
    %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            &#10060; An error occurred while closing the complaint.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <%
        }
        session.removeAttribute("closeStatus"); // Clear status after showing
    %>
    </div>
<%
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Close Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="mb-4">Open Complaints to be Closed</h2>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM complaints WHERE status='opened'");
%>

<table class="table table-bordered">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Raised By</th>
            <th>Feedback & Action</th>
        </tr>
    </thead>
    <tbody>
<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("complaint_id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getString("raised_by") %></td>
        <td>
            <form method="post" action="<%= request.getContextPath() %>/closeComplaint">
                <input type="hidden" name="complaintId" value="<%= rs.getInt("complaint_id") %>">
                <textarea name="feedback" class="form-control mb-2" rows="2" required placeholder="Enter feedback"></textarea>
                <button type="submit" class="btn btn-primary btn-sm">Close Complaint</button>
            </form>
        </td>
    </tr>
<%
    }
    rs.close();
    stmt.close();
    con.close();
%>
    </tbody>
</table>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
