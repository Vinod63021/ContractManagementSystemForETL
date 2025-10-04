package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/downloadComplaintCSV")
public class DownloadComplaintCSV extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String fileName = "Complaints_" + date + ".csv";

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM complaints");
            PrintWriter out = response.getWriter();
        ) {
            out.println("ID,Asset ID,Category,Title,Description,Raised By,Status,Feedback,Closed By,Raised Date,Closed Date");

            while (rs.next()) {
                out.println(rs.getInt("complaint_id") + "," +
                            rs.getInt("asset_id") + "," +
                            rs.getString("category") + "," +
                            rs.getString("title") + "," +
                            rs.getString("description") + "," +
                            rs.getString("raised_by") + "," +
                            rs.getString("status") + "," +
                            rs.getString("feedback") + "," +
                            rs.getString("closed_by") + "," +
                            rs.getString("raised_date") + "," +
                            rs.getString("closed_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
