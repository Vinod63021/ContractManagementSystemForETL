<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    String selectedStatus = request.getParameter("status");
    String keyword = request.getParameter("keyword");

    if (selectedStatus == null) selectedStatus = "";
    if (keyword == null) keyword = "";
%>

<!DOCTYPE html>
<html>
<head>
    <title>All PM Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body class="container mt-5">

    <h2 class="text-center mb-4">All Preventive Maintenance Records</h2>

    <!-- Filter & Search Form -->
    <form method="get" class="row g-3 mb-4">
        <div class="col-md-3">
            <select name="status" class="form-select">
                <option value="">-- All Status --</option>
                <option value="raised" <%= "raised".equals(selectedStatus) ? "selected" : "" %>>Raised</option>
                <option value="verified" <%= "verified".equals(selectedStatus) ? "selected" : "" %>>Verified</option>
                <option value="approved" <%= "approved".equals(selectedStatus) ? "selected" : "" %>>Approved</option>
            </select>
        </div>
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control" placeholder="Search by Asset No or Raised By" value="<%= keyword %>">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <!-- PM Records Table -->
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Asset No</th>
                <th>Checklist</th>
                <th>Remarks</th>
                <th>Raised By</th>
                <th>Status</th>
                <th>Verified By</th>
                <th>Verified Date</th>
                <th>Approved By</th>
                <th>Approved Date</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

        String query = "SELECT * FROM preventive_maintenance WHERE 1=1";
        if (!selectedStatus.isEmpty()) {
            query += " AND status='" + selectedStatus + "'";
        }
        if (!keyword.isEmpty()) {
            query += " AND (asset_number LIKE '%" + keyword + "%' OR raised_by LIKE '%" + keyword + "%')";
        }

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("pm_id") %></td>
                <td><%= rs.getString("asset_number") %></td>
                <td><%= rs.getString("checklist") %></td>
                <td><%= rs.getString("remarks") %></td>
                <td><%= rs.getString("raised_by") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= rs.getString("verified_by") %></td>
                <td><%= rs.getString("verified_date") %></td>
                <td><%= rs.getString("approved_by") %></td>
                <td><%= rs.getString("approved_date") %></td>
            </tr>                 
<%
        }
        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
        </tbody>
    </table>

</body>
</html>
