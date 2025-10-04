<%@ page session="true" %>
<%
    String status = (String) request.getAttribute("status");
%>
<%
    String raisedBy = (String) session.getAttribute("uname");
%>


<!DOCTYPE html>
<html>
<head>
    <title>Preventive Maintenance Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0 text-center">&#128736; Preventive Maintenance Checklist</h4>
        </div>
        <div class="card-body p-4">

            <!-- Status Alerts -->
            <%
                if ("success".equals(status)) {
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    &#9989; Preventive Maintenance submitted successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                } else if ("failed".equals(status)) {
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    &#10060; Submission failed. Please try again.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                } else if ("error".equals(status)) {
            %>
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    ✘ An error occurred. Contact admin or try again later.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <!-- PM Form -->
            <form method="post" action="<%= request.getContextPath() %>/submitPM">
                <div class="mb-3">
                    <label class="form-label">ETL Asset Number</label>
                    <input type="text" name="assetNumber" class="form-control" placeholder="Enter Asset Number" required>
                </div>

                <label class="form-label">PM Checklist</label>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checklist" value="AC Input Voltage" id="acVoltage">
                    <label class="form-check-label" for="acVoltage">AC Input Voltage</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checklist" value="OS Functioning" id="osFunctioning">
                    <label class="form-check-label" for="osFunctioning">OS Functioning</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checklist" value="Antivirus Installed" id="antivirus">
                    <label class="form-check-label" for="antivirus">Antivirus Installed</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="checklist" value="Printer Check" id="printerCheck">
                    <label class="form-check-label" for="printerCheck">Printer Check</label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="checklist" value="Monitor Cleaned" id="monitorCleaned">
                    <label class="form-check-label" for="monitorCleaned">Monitor Cleaned</label>
                </div>

                <div class="mb-3">
                    <label class="form-label">Remarks</label>
                    <textarea name="remarks" class="form-control" rows="4" placeholder="Any observations or remarks..."></textarea>
                </div>
                
                <input type="hidden" name="raisedBy" value="<%= (raisedBy != null && !raisedBy.isEmpty()) ? raisedBy : "service engineer" %>"> 

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Submit PM Record</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS (for alerts) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
