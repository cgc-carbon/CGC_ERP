/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import java.io.*;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author B
 */
public class PrintCSV_WAREHOUSE {

    static DataBean_MData_export objMdata_export;
    UtiDatabase objuti;

    public void ExportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String[] Return_param_value = new String[]{};
        int count = 1;
        String SQL = "", Statement_where = "", rq_date_from = "", rq_date_to = "", Str_Writer = "";
        rq_date_from = request.getParameter("date_from_format");
        rq_date_to = request.getParameter("date_to_format");
        
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        Return_Fill_MData_Export(request.getParameter("export_id"), con, rs);        
        
        if (request.getParameter("export_id").equals("EXP008")) {
            SQL = "Select "
                    + objMdata_export.getParam_value() + " FROM "
                    + objMdata_export.getLookup_name();
            
            if (rq_date_from != null || rq_date_to != null) {

                Statement_where += !rq_date_from.equals("") && !rq_date_to.equals("") && !objMdata_export.getParam_value_from().equals("")
                        ? Statement_where.indexOf("WHERE") != -1
                        ? " AND to_date(format_date(" + objMdata_export.getParam_value_from() + "),'YYYY-MM-DD') BETWEEN to_date(format_date2('" + rq_date_from + "'),'YYYY-MM-DD') AND to_date(format_date2('" + rq_date_to + "'),'YYYY-MM-DD') "
                        : " WHERE to_date(format_date(" + objMdata_export.getParam_value_from() + "),'YYYY-MM-DD') BETWEEN to_date(format_date2('" + rq_date_from + "'),'YYYY-MM-DD') AND to_date(format_date2('" + rq_date_to + "'),'YYYY-MM-DD') "
                        : "";
                SQL += Statement_where;


            }
            System.out.println(SQL);
            //if (request.getParameter("product_group") != null && !request.getParameter("product_group").equals("")) {
            //    SQL += SQL.indexOf("WHERE") != -1 ? " AND product_group = '" + request.getParameter("product_group") + "' " : " WHERE product_group = '" + request.getParameter("product_group") + "' ";
           // }
            
            SQL = SQL + " Group By product_id,pname_t,pgroup_id,pgroup_name,pcat_id,pcat_name,ptype_id,ptype_name,unit_name,weight_per_unit ";
            System.out.println(SQL);
            if (!objMdata_export.getOrder_by().equals("")) {
                SQL += !objMdata_export.getOrder_by().equals("") ? " ORDER BY " + objMdata_export.getOrder_by() : "";
            }
        }

        System.out.println(SQL);

        objuti = new UtiDatabase();
        response.setContentType("application/csv");
        java.util.Date date = new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));
        response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");

        //response.setHeader( "Content-Disposition", "attachment;filename=" + new Timestamp(date.getTime())+".csv\"" );
        response.setBufferSize(1024);
        //ServletOutputStream out = response.getOutputStream();
        try {

            rs = con.createStatement().executeQuery(SQL);
            PrintWriter pw = response.getWriter();
            pw.println(objMdata_export.getParam_name());
            Return_param_value = String_sprit(objMdata_export.getParam_value());
            //System.out.println(Return_param_value);
            while (rs.next()) {
                for (int i = 0; i < Return_param_value.length; i++) {
                    if (Return_param_value[i].equals("channel") || Return_param_value[i].equals("time_from") || Return_param_value[i].equals("time_to")) {
                        Str_Writer += "'" + objuti.NotNull(rs.getString(Return_param_value[i])) + ",";
                    } else {

                        Str_Writer += objuti.NotNull(rs.getString(Return_param_value[i])) + ",";

                    }
                    if (i == 10 && request.getParameter("export_id").equals("EXP001")) {
                        Str_Writer += "=J" + Integer.toString(count + 2) + "/K" + Integer.toString(count + 1) + ",";
                    }

                }

                //System.out.println(Str_Writer);

                count++;
                Str_Writer = Str_Writer.substring(0, Str_Writer.length() - 1);
                //Str_Writer += "\n";
                pw.println(Str_Writer);
                Str_Writer = "";
            }
            //byte[] byte_str = Str_Writer.getBytes();//outputStram
            //out.write(byte_str, 0, byte_str.length);//outputStram
            //out.flush();
            pw.close();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private void Return_Fill_MData_Export(String export_id, Connection con, ResultSet rs) throws Exception {
        String SQL_export = "select * from mdata_export where export_id = '" + export_id + "' and delete_flag = 'N'";
        objMdata_export = new DataBean_MData_export();
        objuti = new UtiDatabase();
        try {
            rs = con.createStatement().executeQuery(SQL_export);
            while (rs.next()) {
                objMdata_export.setParam_value(objuti.NotNull(rs.getString("param_value")));//จะได้ชื่อColoumภายในDataBaseเพื่อทำการดึงข้อมูลออกมา
                objMdata_export.setParam_name(objuti.NotNull(rs.getString("param_name")));//จะทำการระบุชื่อหัวของColoum
                objMdata_export.setParam_from(objuti.NotNull(rs.getString("param_from")));//จะเป็นช่องของ Doc_id
                objMdata_export.setParam_value_from(objuti.NotNull(rs.getString("param_value_from")));//จะเป็นชื่อของ Doc_date
                objMdata_export.setLookup_name(objuti.NotNull(rs.getString("lookup_name")));//ชื่อของTableที่จะExport
                objMdata_export.setStatus(objuti.NotNull(rs.getString("status")));
                objMdata_export.setName_t(objuti.NotNull(rs.getString("name_t")));//ชื่อของ Process นั้น
                objMdata_export.setOrder_by(objuti.NotNull(rs.getString("order_by")));//เป็น Statement ในการเรียงลำดับข้อมูล
                objMdata_export.setComplete_flag(objuti.NotNull(rs.getString("complete_flag")));
                objMdata_export.setDelete_flag(objuti.NotNull(rs.getString("delete_flag")));
                objMdata_export.setRetro_flag(objuti.NotNull(rs.getString("retro_flag")));
                objMdata_export.setCancel_flag(objuti.NotNull(rs.getString("cancel_flag")));
                //objMdata_export.setParam_type(objuti.NotNull(rs.getString("param_type")));//จะเป็นการระบุ flag ต่างๆๆ
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String[] String_sprit(String input) {
        return input.split(",");
    }
}
