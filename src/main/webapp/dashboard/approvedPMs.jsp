<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Approved Preventive Maintenances</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="container mt-5">

    <h2 class="mb-4 text-center text-success"><i class="fa fa-check-circle" style="font-size:48px;color:green"></i> Approved Preventive Maintenance Records</h2>

    <table class="table table-bordered table-hover table-striped">
        <thead class="table-success">
            <tr>
                <th>ID</th>
                <th>Asset Number</th>
                <th>Checklist</th>
                <th>Remarks</th>
                <th>Raised By</th>
                <th>Verified By</th>
                <th>Approved By</th>
                <th>Approved Date</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance WHERE status='approved'");

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("pm_id") %></td>
                <td><%= rs.getString("asset_number") %></td>
                <td><%= rs.getString("checklist") %></td>
                <td><%= rs.getString("remarks") %></td>
                <td><%= rs.getString("raised_by") %></td>
                <td><%= rs.getString("verified_by") %></td>
                <td><%= rs.getString("approved_by") %></td>
                <td><%= rs.getString("approved_date") %></td>
            </tr>
        <%
                }
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='8' class='text-danger'>Error loading data</td></tr>");
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/dashboard/viewpm.jsp" class="btn btn-secondary">&#x1F519; Back to All PMs</a>
    </div>

</body>
</html>
