package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/submitPM")
public class SubmitPMServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String assetNumber = request.getParameter("assetNumber");
		String[] checklistItems = request.getParameterValues("checklist");
		String remarks = request.getParameter("remarks");
		String raisedBy = request.getParameter("raisedBy");

		String checklist = String.join(", ", checklistItems);
		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

			PreparedStatement pst = con.prepareStatement(
				"INSERT INTO preventive_maintenance (asset_number, checklist, remarks, raised_by) VALUES (?, ?, ?, ?)"
			);
			pst.setString(1, assetNumber);
			pst.setString(2, checklist);
			pst.setString(3, remarks);
			pst.setString(4, raisedBy);

			int row = pst.executeUpdate();

			if (row > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
			}

			dispatcher = request.getRequestDispatcher("dashboard/raisePM.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("status", "error");
			dispatcher = request.getRequestDispatcher("dashboard/raisePM.jsp");
			dispatcher.forward(request, response);
		}
	}
}
