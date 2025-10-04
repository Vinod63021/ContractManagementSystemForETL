package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/downloadPMCSV")
public class DownloadPMCSV extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String fileName = "Preventive_Maintenance_" + date + ".csv";

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance");
            PrintWriter out = response.getWriter();
        ) {
            out.println("ID,Asset Number,Checklist,Remarks,Raised By,Status,Verified By,Verified Date,Approved By,Approved Date");

            while (rs.next()) {
                out.println(rs.getInt("pm_id") + "," +
                            rs.getString("asset_number") + "," +
                            rs.getString("checklist") + "," +
                            rs.getString("remarks") + "," +
                            rs.getString("raised_by") + "," +
                            rs.getString("status") + "," +
                            rs.getString("verified_by") + "," +
                            rs.getString("verified_date") + "," +
                            rs.getString("approved_by") + "," +
                            rs.getString("approved_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
