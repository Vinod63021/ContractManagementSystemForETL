package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RaiseComplaintServlet
 */
@WebServlet("/raiseComplaint")
public class RaiseComplaintServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String raisedBy = request.getParameter("raisedBy");
        int assetId = Integer.parseInt(request.getParameter("assetId"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");

            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO complaints (asset_id, category, title, description, raised_by, status, raised_date) VALUES (?, ?, ?, ?, ?, 'opened', NOW())"
            );
            pst.setInt(1, assetId);
            pst.setString(2, category);
            pst.setString(3, title);
            pst.setString(4, description);
            pst.setString(5, raisedBy);
            pst.executeUpdate();

            request.setAttribute("status", "complaint_success");
            request.getRequestDispatcher("dashboard/raiseComplaint.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.getRequestDispatcher("dashboard/raiseComplaint.jsp").forward(request, response);
        }
    }
}
