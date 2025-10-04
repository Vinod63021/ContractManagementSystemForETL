<!DOCTYPE html>
<html>
<head>
    <title>In-charge Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="sidebar">
    <div class="profile">
        <h3>Welcome, In-charge</h3>
    </div>

    <h2>Menu</h2>
    <a href="dashboard/approvePM.jsp" target="contentFrame">
        <span class="icon">&#9989;</span> Approve PM
    </a>
    <a href="dashboard/raiseComplaint.jsp" target="contentFrame">
        <span class="icon">&#9993;</span> Raise Complaint
    </a>
    <a href="dashboard/viewcomwod.jsp" target="contentFrame">
        <span class="icon">&#128221;</span> View Complaints
    </a>
    <a href="dashboard/viewpmwod.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> View PMs
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
