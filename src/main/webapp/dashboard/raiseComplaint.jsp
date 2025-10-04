<%@ page session="true" %>
<%
    String raisedBy = (String) session.getAttribute("uname");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Raise Complaint</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow border-0">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0 text-center"><i class="fas fa-exclamation-circle me-2"></i>Raise a New Complaint</h4>
        </div>
        <div class="card-body p-4">

            <!-- ALERT MESSAGES -->
            <%
                String status = (String) request.getAttribute("status");
                if ("complaint_success".equals(status)) {
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    &#x2705; Complaint raised successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                } else if ("error".equals(status)) {
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    &#10060; Error while raising complaint. Please try again.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <!-- FORM -->
            <div class="mb-3">
    <label class="form-label">Service name</label>
    <select class="form-select">
        <option>SERVC. PENTIUM PC</option>
        <option>SERVC. OTHER PRGM.</option>
        <option>SERVC. PRR.</option>
        <option>SERVC. PG675 SIEMENS PRGM G.U</option>
        <option>SERVC. OTHER MONR.</option>
    </select>
</div>
            <form method="post" action="<%= request.getContextPath() %>/raiseComplaint">
                <div class="mb-3">
                    <label class="form-label">Asset ID</label>
                    <input name="assetId" type="number" class="form-control" placeholder="Enter Asset ID" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <input name="category" class="form-control" placeholder="Enter complaint category" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Complaint Title</label>
                    <input type="text" name="title" class="form-control" placeholder="Enter complaint title" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Describe the issue..." required></textarea>
                </div>

                <input type="hidden" name="raisedBy" value="<%= (raisedBy != null && !raisedBy.isEmpty()) ? raisedBy : "cordinator" %>">
				<input type="hidden" name="raisedBy" value="<%= (raisedBy != null && !raisedBy.isEmpty()) ? raisedBy : "service enginner" %>">

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-paper-plane me-1"></i>Submit Complaint
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS for alert -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
