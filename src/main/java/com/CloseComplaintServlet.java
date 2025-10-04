package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/closeComplaint")
public class CloseComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            String feedback = request.getParameter("feedback");

            // Use static value "Service Engineer"
            String closedBy = "Service Engineer";

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

            PreparedStatement pst = con.prepareStatement(
                "UPDATE complaints SET status = 'closed', feedback = ?, closed_by = ?, closed_date = NOW() WHERE complaint_id = ?"
            );
            pst.setString(1, feedback);
            pst.setString(2, closedBy);
            pst.setInt(3, complaintId);

            int row = pst.executeUpdate();

            HttpSession session = request.getSession();
            if (row > 0) {
                session.setAttribute("closeStatus", "success");
            } else {
                session.setAttribute("closeStatus", "fail");
            }

            response.sendRedirect("dashboard/closeComplaint.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("closeStatus", "error");
            response.sendRedirect("dashboard/closeComplaint.jsp");
        }
    }
}
