<!DOCTYPE html>
<html>
<head>
    <title>Contract Cell Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="sidebar">
    <div class="profile">
        <h3>Welcome, Contract Cell</h3>
    </div>

    <h2>Menu</h2>
    <a href="dashboard/contractSummary.jsp" target="contentFrame">
        <span class="icon">&#128196;</span> Contract Summary
    </a>
    <a href="dashboard/raiseComplaint.jsp" target="contentFrame">
        <span class="icon">&#9993;</span> Raise Complaint
    </a>
    <a href="dashboard/viewpm.jsp" target="contentFrame">
        <span class="icon">&#128187;</span> All PMs
    </a>
    <a href="dashboard/viewcom.jsp" target="contentFrame">
        <span class="icon">&#128221;</span> All Complaints
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
