<!DOCTYPE html>
<html>
<head>
    <title>ELC Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="sidebar">
    <div class="profile">
        <h3>Welcome, ELC</h3>
    </div>

    <h2>Menu</h2>
    <a href="dashboard/approvedPMs.jsp" target="contentFrame">
        <span class="icon">&#128190;</span> View Approved PMs
    </a>
    <a href="dashboard/raiseComplaint.jsp" target="contentFrame">
        <span class="icon">&#9993;</span> Raise Complaint
    </a>
    <a href="dashboard/billingPMs.jsp" target="contentFrame">
        <span class="icon">&#128179;</span> Billing (Quarterly)
    </a>
    <a href="dashboard/viewpm.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> All PM Reports
    </a>
    <a href="dashboard/viewcom.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> All Complaint Reports
    </a>

    <a href="login.jsp" class="logout">
        <span class="icon">&#128682;</span> Logout
    </a>
</div>

<div class="main-content">
    <div class="top-title">ETL Contract Maintenance System</div>
    <iframe name="contentFrame" class="content-frame" src="" frameborder="0"></iframe>
</div>

</body>
</html>