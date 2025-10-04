<%@ page import="java.sql.*, java.time.LocalDate" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>PM Billing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

    <h2 class="text-center text-primary mb-4">&#x1F9FE; Preventive Maintenance Billing Report</h2>

    <form method="get" action="billingPMs.jsp" class="row g-3 mb-4">
        <div class="col-md-4">
            <label>Year</label>
            <select name="year" class="form-select" required>
                <%
                    int currentYear = LocalDate.now().getYear();
                    for (int y = currentYear; y >= currentYear - 5; y--) {
                %>
                <option value="<%= y %>" <%= (request.getParameter("year") != null && request.getParameter("year").equals(String.valueOf(y))) ? "selected" : "" %>><%= y %></option>
                <% } %>
            </select>
        </div>

        <div class="col-md-4">
            <label>Quarter</label>
            <select name="quarter" class="form-select" required>
                <option value="Q1" <%= "Q1".equals(request.getParameter("quarter")) ? "selected" : "" %>>Q1 (Jan - Mar)</option>
                <option value="Q2" <%= "Q2".equals(request.getParameter("quarter")) ? "selected" : "" %>>Q2 (Apr - Jun)</option>
                <option value="Q3" <%= "Q3".equals(request.getParameter("quarter")) ? "selected" : "" %>>Q3 (Jul - Sep)</option>
                <option value="Q4" <%= "Q4".equals(request.getParameter("quarter")) ? "selected" : "" %>>Q4 (Oct - Dec)</option>
            </select>
        </div>

        <div class="col-md-4 d-grid align-self-end">
            <button class="btn btn-success">&#x1F50D; View Billing</button>
        </div>
    </form>

<%
    String year = request.getParameter("year");
    String quarter = request.getParameter("quarter");

    if (year != null && quarter != null) {
        String[] months = {};

        switch (quarter) {
            case "Q1": months = new String[]{"01", "02", "03"}; break;
            case "Q2": months = new String[]{"04", "05", "06"}; break;
            case "Q3": months = new String[]{"07", "08", "09"}; break;
            case "Q4": months = new String[]{"10", "11", "12"}; break;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance WHERE status='approved'");

            boolean hasResults = false;
%>

    <h5 class="text-success mt-3">Approved PMs in <%= quarter %> <%= year %>:</h5>
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-info">
            <tr>
                <th>ID</th>
                <th>Asset Number</th>
                <th>Checklist</th>
                <th>Remarks</th>
                <th>Approved By</th>
                <th>Approved Date</th>
            </tr>
        </thead>
        <tbody>
<%
            while (rs.next()) {
                String approvedDate = rs.getString("approved_date");
                if (approvedDate != null && approvedDate.startsWith(year + "-")) {
                    String month = approvedDate.substring(5, 7); // MM

                    for (String qMonth : months) {
                        if (month.equals(qMonth)) {
                            hasResults = true;
%>
            <tr>
                <td><%= rs.getInt("pm_id") %></td>
                <td><%= rs.getString("asset_number") %></td>
                <td><%= rs.getString("checklist") %></td>
                <td><%= rs.getString("remarks") %></td>
                <td><%= rs.getString("approved_by") %></td>
                <td><%= approvedDate %></td>
            </tr>
<%
                            break;
                        }
                    }
                }
            }

            if (!hasResults) {
%>
            <tr><td colspan="6" class="text-center text-danger">No PMs found for this quarter.</td></tr>
<%
            }

            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='6'>Error fetching data</td></tr>");
            e.printStackTrace();
        }
    }
%>
        </tbody>
    </table>

<%
    // Only show download button if quarter and year are selected
    if (year != null && quarter != null) {
%>
    <form method="post" action="<%= request.getContextPath() %>/downloadPMBillCSV">
        <input type="hidden" name="year" value="<%= year %>">
        <input type="hidden" name="quarter" value="<%= quarter %>">
        <button class="btn btn-primary">&#x1f4e5; Download Bill as Excel</button>
    </form>
<% } %>

</body>
</html>
