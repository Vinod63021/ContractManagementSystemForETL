<!DOCTYPE html>
<html>
<head>
    <title>Coordinator Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="profile">
        <h3>Welcome, Coordinator</h3>
    </div>

    <h2>Menu</h2>
    <a href="dashboard/verifyPM.jsp" target="contentFrame">
        <span class="icon">&#9881;</span> Verify PM
    </a>
    <a href="dashboard/raiseComplaint.jsp" target="contentFrame">
        <span class="icon">&#9993;</span> Raise Complaint
    </a>
    <a href="dashboard/viewcomwod.jsp" target="contentFrame">
        <span class="icon">&#128221;</span> View Complaints Reports
    </a>
    <a href="dashboard/viewpmwod.jsp" target="contentFrame">
        <span class="icon">&#128202;</span> View PM Reports
    </a>

    <a href="login.jsp" class="logout">
        <span class="icon">&#128682;</span> Logout
    </a>
</div>


<!-- Main Content Area -->
<div class="main-content">
    <div class="top-title">ETL Contract Maintenance System</div>

    <!-- Iframe to Load Content Pages -->
    <iframe name="contentFrame" class="content-frame" src="" frameborder="0"></iframe>
</div>

</body>
</html>
