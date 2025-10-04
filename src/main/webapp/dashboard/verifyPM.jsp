<%@ page import="java.sql.*,java.util.*" %>
<%@ page session="true" %>
<%
    String raisedBy = (String) session.getAttribute("uname");
%>


<!DOCTYPE html>
<html>
<head>
    <title>Verify PM Records</title>
    <!-- Bootstrap CSS for better UI -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="container mt-5">

    <h2 class="text-center text-primary mb-4">&#x1F6E0; Verify Raised Preventive Maintenance</h2>

    <!-- Session Alert Messages -->
    <%
        String status = (String) session.getAttribute("verifyStatus");
        if ("success".equals(status)) {
    %>
        <div class="alert alert-success text-center">&#x2705; PM verified successfully!</div>
    <%
        } else if ("failed".equals(status)) {
    %>
        <div class="alert alert-warning text-center">&#10060; Failed to verify PM. Try again.</div>
    <%
        } else if ("error".equals(status)) {
    %>
        <div class="alert alert-danger text-center">&#10060; An error occurred while verifying PM.</div>
    <%
        }
        session.removeAttribute("verifyStatus");
    %>

    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance WHERE status='raised'");
    %>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Asset Number</th>
                <th>Checklist</th>
                <th>Remarks</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
    <%
        boolean hasRecords = false;
        while (rs.next()) {
            hasRecords = true;
    %>
        <tr>
            <td><%= rs.getInt("pm_id") %></td>
            <td><%= rs.getString("asset_number") %></td>
            <td><%= rs.getString("checklist") %></td>
            <td><%= rs.getString("remarks") %></td>
            <td>
                <form method="post" action="<%= request.getContextPath() %>/verifyPM">
                    <input type="hidden" name="pmId" value="<%= rs.getInt("pm_id") %>">
                    <input type="hidden" name="verifiedBy" value="<%= (raisedBy != null && !raisedBy.isEmpty()) ? raisedBy : "coordinator" %>">
                    <button type="submit" class="btn btn-success btn-sm"><i class="fa fa-check-circle"></i> Verify</button>
                </form>
            </td>
        </tr>
    <%
        }
        rs.close();
        stmt.close();
        con.close();

        if (!hasRecords) {
    %>
        <tr>
            <td colspan="5" class="text-center text-danger">No raised PMs available for verification.</td>
        </tr>
    <%
        }
    %>
        </tbody>
    </table>

</body>
</html>
