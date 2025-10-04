<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String approveBy = (String) session.getAttribute("uname");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Approve Verified PMs</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="container mt-5">

    <h2 class="text-center mb-4 text-primary">&#x2705; Approve Verified Preventive Maintenance</h2>

    <!-- Status Message -->
    <%
        String approveStatus = (String) session.getAttribute("approveStatus");
        if ("success".equals(approveStatus)) {
    %>
        <div class="alert alert-success text-center">&#9989; PM approved successfully!</div>
    <%
        } else if ("failed".equals(approveStatus)) {
    %>
        <div class="alert alert-danger text-center">&#10060;  Failed to approve PM. Try again.</div>
    <%
        } else if ("error".equals(approveStatus)) {
    %>
        <div class="alert alert-danger text-center">&#10060;  An error occurred while approving PM.</div>
    <%
        }
        session.removeAttribute("approveStatus");
    %>

    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance WHERE status='verified'");
    %>

    <!-- PM Table -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Asset No</th>
                <th>Checklist</th>
                <th>Verified By</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
    <%
        boolean found = false;
        while (rs.next()) {
            found = true;
    %>
        <tr>
            <td><%= rs.getInt("pm_id") %></td>
            <td><%= rs.getString("asset_number") %></td>
            <td><%= rs.getString("checklist") %></td>
            <td><%= rs.getString("verified_by") %></td>
            <td>
                <form method="post" action="<%= request.getContextPath() %>/approvePM">
                    <input type="hidden" name="pmId" value="<%= rs.getInt("pm_id") %>">
                    <input type="hidden" name="raisedBy" value="<%= (approveBy != null && !approveBy.isEmpty()) ? approveBy : "incharge" %>">
                    <button type="submit" class="btn btn-success btn-sm"><i class="fa fa-check-circle"></i> Approve</button>
                </form>
            </td>
        </tr>
    <%
        }
        rs.close();
        stmt.close();
        con.close();

        if (!found) {
    %>
        <tr>
            <td colspan="5" class="text-center text-danger">No verified PMs available for approval.</td>
        </tr>
    <%
        }
    %>
        </tbody>
    </table>

</body>
</html>
