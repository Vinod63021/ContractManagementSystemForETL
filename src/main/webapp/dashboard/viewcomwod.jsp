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
    <title>All Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body class="container mt-5">

    <h2 class="text-center mb-4">All Complaints</h2>

    <form method="get" class="row g-3 mb-4">
        <div class="col-md-3">
            <select name="status" class="form-select">
                <option value="">-- All Status --</option>
                <option value="opened" <%= "opened".equals(selectedStatus) ? "selected" : "" %>>Opened</option>
                <option value="closed" <%= "closed".equals(selectedStatus) ? "selected" : "" %>>Closed</option>
            </select>
        </div>
        <div class="col-md-4">
            <input type="text" name="keyword" class="form-control" placeholder="Search by asset or raised by" value="<%= keyword %>">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Asset ID</th><th>Category</th><th>Title</th><th>Description</th>
                <th>Raised By</th><th>Status</th><th>Closed By</th><th>Feedback</th><th>Raised Date</th><th>Closed Date</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

        String query = "SELECT * FROM complaints WHERE 1=1";
        if (!selectedStatus.isEmpty()) {
            query += " AND status='" + selectedStatus + "'";
        }
        if (!keyword.isEmpty()) {
            query += " AND (asset_id LIKE '%" + keyword + "%' OR raised_by LIKE '%" + keyword + "%')";
        }

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("complaint_id") %></td>
                <td><%= rs.getInt("asset_id") %></td>
                <td><%= rs.getString("category") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("raised_by") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= rs.getString("closed_by") %></td>
                <td><%= rs.getString("feedback") %></td>
                <td><%= rs.getString("raised_date") %></td>
                <td><%= rs.getString("closed_date") %></td>
            </tr>
<%
        }
        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
        </tbody>
    </table>

</body>
</html>
