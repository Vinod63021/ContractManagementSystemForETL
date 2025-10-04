<!DOCTYPE html>
<html>
<head>
    <title>Service Engineer Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="sidebar">
    <div class="profile">
        <h3>Welcome, Service Engineer</h3>
    </div>

    <h2>Menu</h2>
    <a href="dashboard/raisePM.jsp" target="contentFrame">
        <span class="icon">&#128295;</span> Raise PM
    </a>
    <a href="dashboard/closeComplaint.jsp" target="contentFrame">
        <span class="icon">&#9989;</span> Close Complaints
    </a>
    <a href="dashboard/viewpmwod.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> PM Reports
    </a>
    <a href="dashboard/viewcomwod.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> Complaint Reports
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
