/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import com.cgc.DB.DBConnect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author B
 */
public class Runer_Doc_id {

    public String Run_id(String Table_name_Header, String Table_name_Detail) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();

        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "", SQL2 = "";
        mem_date_now = Return_Date_Now();
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        SQL2 = "Select count(doc_id) as num from " + Table_name_Detail + " where doc_id like '" + mem_date_now + "%' and delete_flag = 'N' ";
        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header, Table_name_Detail, con);
                return_str = Return_Format_id(mem_rs);
            } else if (objuti.numRowdatabase(SQL2) != 0) {
                mem_rs = Return_Doc_id(Table_name_Header, Table_name_Detail, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            if (con != null) {
                con.close();
            }
        }
        return return_str;
    }
    public String Run_id_date(String Table_name_Header,String Date_Input) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String return_str = "", mem_rs = "", mem_date_now = "", SQL1 = "";
        mem_date_now = Format_Date_Thai(Date_Input);
        SQL1 = "Select count(doc_id) as num from " + Table_name_Header + " where doc_id like '" + mem_date_now + "%'  ";

        try {
            if (objuti.numRowdatabase(SQL1) != 0) {
                mem_rs = Return_Doc_id_date(Table_name_Header,mem_date_now, con);
                return_str = Return_Format_id(mem_rs);
            } else {
                return_str = mem_date_now + "-001";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            if (con != null) {
                con.close();
            }
        }
        return return_str;
    }
    public static String Return_Date_Now() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyMMdd");
        return format.format(date);
    }

    public static String Return_Format_id(String last_id) {
        DecimalFormat df = new DecimalFormat("000");
        String sub_str = last_id.substring(0, 7);
        int sub_runner = Integer.parseInt(last_id.substring(7, 10)) + 1;
        return sub_str + df.format(sub_runner);
    }

    public static String Return_Doc_id(String Table_name_header, String Table_name_detail, Connection con) throws Exception {
        String[] Retrun_header = new String[2];
        String[] Retrun_detail = new String[2];
        String SQL = "", Retrun = "";
        ResultSet rs = null;
        try {
            for (int i = 1; i <= 2; i++) {
                SQL = "Select to_number(doc_id,'999999-999') as doc_number,doc_id doc_id from ";
                SQL += i == 1 ? Table_name_header : Table_name_detail;
                SQL += " where delete_flag = 'N'  order by to_number(doc_id,'999999-999') desc";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if(rs.isFirst()){
                    if (i == 1) {
                        Retrun_header[0] = rs.getString("doc_number");
                        Retrun_header[1] = rs.getString("doc_id");
                        break;
                    } else {
                        Retrun_detail[0] = rs.getString("doc_number");
                        Retrun_detail[1] = rs.getString("doc_id");
                        break;
                    }
                    }
                }
                continue;
            }
            if (Integer.parseInt(Retrun_header[0]) >= Integer.parseInt(Retrun_detail[0])) {
                Retrun = Retrun_header[1];
            } else {
                Retrun = Retrun_detail[1];
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Retrun;
    }


    public static String Return_Doc_id_date(String Table_name_header,String Date_Input, Connection con) throws Exception {
        String[] Retrun_header = new String[2];
        String SQL = "", Retrun = "";
        ResultSet rs = null;
        try {
            SQL = "Select to_number(doc_id,'999999-9999') as doc_number,doc_id doc_id from ";
            SQL += Table_name_header;
            SQL += " Where doc_id like '"+Date_Input+"%' order by to_number(doc_id,'999999-9999') desc limit 1";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                Retrun = Retrun_header[1] = rs.getString("doc_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return Retrun;
    }
    //Date_input = วัน-เดือน-ปี exp=>12-01-2555
    public static String Format_Date_Thai(String Date_Input){
        return Date_Input.substring(8, 10)+Date_Input.substring(3, 5)+Date_Input.substring(0, 2);
    }
}
