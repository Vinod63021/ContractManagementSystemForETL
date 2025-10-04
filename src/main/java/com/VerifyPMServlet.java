package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/verifyPM")
public class VerifyPMServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pmId = Integer.parseInt(request.getParameter("pmId"));
        
        // ✅ Fetching from request, not session
        String verifiedBy = request.getParameter("verifiedBy");

        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211"
            );

            PreparedStatement pst = con.prepareStatement(
                "UPDATE preventive_maintenance SET status='verified', verified_by=?, verified_date=NOW() WHERE pm_id=?"
            );
            pst.setString(1, verifiedBy);
            pst.setInt(2, pmId);

            int row = pst.executeUpdate();

            if (row > 0) {
                session.setAttribute("verifyStatus", "success");
            } else {
                session.setAttribute("verifyStatus", "failed");
            }

            response.sendRedirect("dashboard/verifyPM.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("verifyStatus", "error");
            response.sendRedirect("dashboard/verifyPM.jsp");
        }
    }
}
