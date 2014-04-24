package com.cgc.report;

import com.cgc.DB.DBConnect;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

public class PrintReport {

    private static String company_code = "10";
    private static String sub_menu_id = "";
    private static String employee_id_s = "";
    private static String date_form_send = "";
    private static String date_to_send = "";

    public void printReport_1(HttpServletRequest request, HttpServletResponse response, InputStream path,String sql)
            throws Exception {
        Connection connection;
        connection = new DBConnect().openNewConnection();
        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("SQL_CODE", sql);
        hashMap.put("fileName", report_code);
        hashMap.put("company_name", Mcompany(connection));
        ServletOutputStream servletOutputStream = response.getOutputStream();
        InputStream reportStream = path;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_2(HttpServletRequest request, HttpServletResponse response, InputStream path, String docId, String employee_id)
            throws Exception {
        Connection connection = new DBConnect().openNewConnection();
        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        String doc_no = (String) request.getParameter("doc_no");
        String doc_eff_date = (String) request.getParameter("doc_eff_date");
        sub_menu_id = (String) request.getParameter("sub_menu_id");
        employee_id_s = employee_id;

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        hashMap.put("fileName", report_code);
        hashMap.put("DOC_ID", docId);
        hashMap.put("REPORT_UNAME", Memployee(connection));
        if (sub_menu_id == "" || sub_menu_id == null) {
            hashMap.put("iso_doc_ref", doc_no);
        } else {
            hashMap.put("iso_doc_ref", Msub_docno(connection));
        }
        hashMap.put("iso_doc_date", doc_eff_date);
        hashMap.put("company_name", Mcompany(connection));
        hashMap.put("SUB_DOC_ID", docId);
        System.out.println("report_code : " + report_code);
        System.out.println("DOC_ID : " + docId);
        System.out.println("doc_eff_date : " + doc_eff_date);
        System.out.println("Memployee(connection) : " + Memployee(connection));
        System.out.println("sub_menu_id : " + sub_menu_id);
        System.out.println("Msub_docno(connection) : " + Msub_docno(connection));

        hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());


        ServletOutputStream servletOutputStream = response.getOutputStream();

        InputStream reportStream = path;


        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        System.out.println(servletOutputStream);

        System.out.println("print out = ");
        System.out.println("reportStream = " + reportStream);
        System.out.println("servletOutputStream = " + servletOutputStream);
        System.out.println("hashMap = " + hashMap);
        System.out.println("connection = " + connection);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        System.out.println("print out final");

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_3(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {
        String report_code = (String) request.getParameter("report_code");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");
        String size_id = (String) request.getParameter("spec_size");
        String iodine_id = (String) request.getParameter("iod_value");

        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        //String report_code = (String) request.getParameter("report_code");
        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        //hashMap.put("SUB_DOC_ID", docId);
        Connection connection = new DBConnect().openNewConnection();
        hashMap.put("fileName", report_code);
        hashMap.put("company_name", Mcompany(connection));
        hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
        hashMap.put("SQL_CODE", sql);
        hashMap.put("DATE_FORM", date_form);
        hashMap.put("DATE_TO", date_to);

        System.out.print(sql);
        System.out.print("-----");
        System.out.print(report_code);

        ServletOutputStream servletOutputStream = response.getOutputStream();
        InputStream reportStream = path;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_4(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {


        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        //String date_form = (String) request.getParameter("date_form");
        String date_form = "";
        String doc_date_form ;
        String doc_date_to = "";
        String date_to = (String) request.getParameter("date_to");
        String location_id = (String) request.getParameter("location_id");

        //if (report_code.equals("RP_014") || report_code.equals("RP_014_1")) {
        //    date_form = "2556-12-22";
        //} else {
            date_form = (String) request.getParameter("date_form");
        //}


        System.out.println("date_form = " + date_form);

        String month_form = "";
        String year_form = "";
        String month_to = "";
        String year_to = "";



        System.out.println("DF : " + request.getParameter("date_form"));
        System.out.println("DT : " + request.getParameter("date_to"));

        if ((date_form != null) && (!date_form.trim().equals(""))) {
            doc_date_form = (String) date_form.substring(8, 10);
            month_form = (String) date_form.substring(5, 7);
            year_form = (String) date_form.substring(0, 4);
        }
        if ((date_to != null) && (!date_to.trim().equals(""))) {
            doc_date_to = (String) date_to.substring(8, 10);
            month_to = (String) date_to.substring(5, 7);
            year_to = (String) date_to.substring(0, 4);
        }
        
        System.out.println("--> report_code = " + report_code);
        
        if (report_code.equals("RP_022_D")) {
            if (location_id.equals("-")) {
                sql = " where month = '" + month_form + "'";
            } else {
                sql = " where month = '" + month_form + "' and location_id = '" + location_id + "'" ;
            }
        }
        
        if (report_code.equals("RP_023_A")) {
            if (!location_id.equals("-") && !(sql.equals(null))) {
                sql = sql + " and location_id = '" + location_id + "'" ;
            }
        }        
        
        
        String year_document = (String) request.getParameter("year_document");
        System.out.println("date_to = " + date_to);
        System.out.println("date_form = " + date_form);
        System.out.println("month_form = " + month_form);
        System.out.println("month_to = " + month_to);
        System.out.println("year_to = " + year_to);
        
        System.out.println("--> sql = " + sql);
        
        Connection connection = new DBConnect().openNewConnection();

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        //hashMap.put("SUB_DOC_ID", docId);
        hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
        hashMap.put("SQL_CODE", sql);
        hashMap.put("fileName", report_code);
        hashMap.put("DATE_FORM", date_form);
        hashMap.put("DATE_TO", date_to);        
        hashMap.put("DOC_DATE_TO", doc_date_to);
        hashMap.put("MONTH_FORM", month_form);
        hashMap.put("YEAR_FORM", year_form);
        hashMap.put("MONTH_TO", month_to);
        hashMap.put("YEAR_TO", year_to);
        hashMap.put("YEAR_DOC", year_document);
        hashMap.put("company_name", Mcompany(connection));

        //JOptionPane.showConfirmDialog(null, sql);

        ServletOutputStream servletOutputStream = response.getOutputStream();

        InputStream reportStream = path;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_5(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {


        //InputStream path = (InputStream) request.getSession().getAttribute("path");
        String report_code = (String) request.getParameter("report_code");
        String date_to = (String) request.getParameter("date_to");
        String date_form = (String) request.getParameter("date_form");
        String year_document = (String) request.getParameter("year_document");
        Integer year_from, year_to;

        if ((date_form != null) && (!date_form.trim().equals(""))) {
            year_from = Integer.parseInt(date_form.substring(0, 4)) - 543;
            date_form_send = date_form.substring(8, 10) + "-" + date_form.substring(5, 7) + "-" + year_from.toString();
        }

        if ((date_to != null) && (!date_to.trim().equals(""))) {
            year_to = Integer.parseInt(date_to.substring(0, 4)) - 543;
            date_to_send = date_to.substring(8, 10) + "-" + date_to.substring(5, 7) + "-" + year_to.toString();
        }

        Connection connection = new DBConnect().openNewConnectionMySQL();

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        //hashMap.put("SUB_DOC_ID", docId);
        hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
        hashMap.put("SQL_CODE", sql);
        hashMap.put("fileName", report_code);
        hashMap.put("DATE_FORM", date_form_send);
        hashMap.put("DATE_TO", date_to_send);
        hashMap.put("YEAR_DOC", year_document);
        //hashMap.put("company_name", Mcompany(connection));

        //JOptionPane.showConfirmDialog(null, sql);

        ServletOutputStream servletOutputStream = response.getOutputStream();

        InputStream reportStream = path;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public void printReport_6(HttpServletRequest request, HttpServletResponse response, InputStream path, String sql)
            throws Exception {


        String report_code = (String) request.getParameter("report_code");
        String date_form = (String) request.getParameter("date_form");
        String date_to = (String) request.getParameter("date_to");
        String year_document = (String) request.getParameter("year_document");

        Connection connection = new DBConnect().openNewConnection();

        HashMap<String, Object> hashMap = new HashMap<String, Object>();
        //hashMap.put("SUB_DOC_ID", docId);
        hashMap.put("SUBREPORT_DIR", (new StringBuilder(String.valueOf(request.getSession().getServletContext().getRealPath("REPORT/")))).append("/").toString());
        hashMap.put("SQL_CODE", sql);
        hashMap.put("fileName", report_code);
        hashMap.put("DATE_FORM", date_form);
        hashMap.put("DATE_TO", date_to);
        hashMap.put("YEAR_DOC", year_document);
        hashMap.put("company_name", Mcompany(connection));

        ServletOutputStream servletOutputStream = response.getOutputStream();

        InputStream reportStream = path;

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"filename.pdf\"");
        response.setBufferSize(1024);

        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, hashMap, connection);

        connection.close();
        servletOutputStream.flush();
        servletOutputStream.close();

    }

    public static String Msub_docno(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery("select doc_no from mmenu_sub where sub_menu_id = '" + sub_menu_id + "'");
            while (rs.next()) {
                str_return = rs.getString("doc_no");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }

    }

    public static String Mcompany(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery("select name_t from mcompany where company_id = '" + company_code + "'");
            while (rs.next()) {
                str_return = rs.getString("name_t");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }

    }

    public static String Memployee(Connection con) throws Exception {
        String str_return = "";
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery("select fullname from vemployee_fullname where emp_id = '" + employee_id_s + "'");
            while (rs.next()) {
                str_return = rs.getString("fullname");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }

    }
}
