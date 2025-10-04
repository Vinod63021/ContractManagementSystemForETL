package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/approvePM")
public class ApprovePMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pmId = Integer.parseInt(request.getParameter("pmId"));
		HttpSession session = request.getSession();
		String approvedBy = request.getParameter("raisedBy");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

			PreparedStatement pst = con.prepareStatement(
				"UPDATE preventive_maintenance SET status='approved', approved_by=?, approved_date=NOW() WHERE pm_id=?"
			);
			pst.setString(1, approvedBy); // this will now be stored in DB
			pst.setInt(2, pmId);

			int row = pst.executeUpdate();

			if (row > 0) {
				session.setAttribute("approveStatus", "success");
			} else {
				session.setAttribute("approveStatus", "failed");
			}

			response.sendRedirect("dashboard/approvePM.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("approveStatus", "error");
			response.sendRedirect("dashboard/approvePM.jsp");
		}
	}
}
