package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/downloadPMBillCSV")
public class DownloadPMBillCSV extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String year = request.getParameter("year");
        String quarter = request.getParameter("quarter");

        String[] months = switch (quarter) {
            case "Q1" -> new String[]{"01", "02", "03"};
            case "Q2" -> new String[]{"04", "05", "06"};
            case "Q3" -> new String[]{"07", "08", "09"};
            case "Q4" -> new String[]{"10", "11", "12"};
            default -> new String[]{};
        };

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=PM_Bill_" + quarter + "_" + year + ".csv");

        try (PrintWriter out = response.getWriter()) {
            out.println("PM ID,Asset Number,Checklist,Remarks,Approved By,Approved Date");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/steelplant", "root", "Vinod@630211");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM preventive_maintenance WHERE status='approved'");

            while (rs.next()) {
                String date = rs.getString("approved_date");
                if (date != null && date.startsWith(year + "-")) {
                    String month = date.substring(5, 7);
                    for (String m : months) {
                        if (m.equals(month)) {
                            out.println(rs.getInt("pm_id") + "," +
                                    rs.getString("asset_number") + "," +
                                    rs.getString("checklist") + "," +
                                    rs.getString("remarks") + "," +
                                    rs.getString("approved_by") + "," +
                                    date);
                            break;
                        }
                    }
                }
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
