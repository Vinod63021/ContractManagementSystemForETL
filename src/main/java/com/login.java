package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uemail = request.getParameter("username");
		String upwd = request.getParameter("password");
		String urole = request.getParameter("role");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
			PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE uemail = ? AND upwd = ? AND urole = ?");
			pst.setString(1, uemail);
			pst.setString(2, upwd);
			pst.setString(3, urole);// Consider hashing in future

			ResultSet rs = pst.executeQuery();
			
			System.out.println(urole);
			
			if (rs.next()) {
				
				String role = rs.getString("urole");
				session.setAttribute("role", role);
				
				if (role.equals("ELC")) {
					dispatcher = request.getRequestDispatcher("ELC.jsp");
				} 
				else if (role.equals("Cell")) {
					dispatcher = request.getRequestDispatcher("Cell.jsp");
				}
				else if (role.equals("Incharge")) {
					dispatcher = request.getRequestDispatcher("Incharge.jsp");
				}
				else if (role.equals("Coordinator")) {
					dispatcher = request.getRequestDispatcher("Coordinator.jsp");
				}
				else if (role.equals("Engineer")) {
					dispatcher = request.getRequestDispatcher("Engineer.jsp");
				}
				else {
					// Unknown role, redirect to login with error
					request.setAttribute("status", "invalid_role");
					dispatcher = request.getRequestDispatcher("login.jsp");
				}
			} else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}