/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.upload;

import com.cgc.DB.DBConnect;
import com.cgc.FileManagement.Read_Excel_POI;
import com.cgc.FileManagement.Writer_Excel_POI;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_data_import_from_excel;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

/**
 *
 * @author ball
 */
public class Uploadfile {
StringBuffer String_return = new StringBuffer();
    public String Uploadfile_Excel_To_DataBase(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Random r = new Random();
        String token = "", output = "";
        Connection con = new DBConnect().openNewConnection();
        Read_Excel_POI obj_read = new Read_Excel_POI();
        MultipartFormDataRequest mul = new MultipartFormDataRequest(request);
        System.out.println("1 : "+ request);
        System.out.println("2 : "+ mul.getFiles().get("myfile"));        
        ArrayList<DataBeanD_data_import_from_excel> objAL = new ArrayList<DataBeanD_data_import_from_excel>();
        UploadBean uploadBean = new UploadBean();
        UploadFile objfile = (UploadFile) mul.getFiles().get("myfile");
        //token = Long.toString(Math.abs(r.nextLong()), 36) + new SimpleDateFormat("ddMMyy_hhmmssS").format(new Date());
        token = "CGC_ERP_FILE_" + new SimpleDateFormat("ddMMyy_hhmmssS").format(new Date());
        //System.out.print(objfile.getFileName() + "\t\t" + objfile.getContentType() + "\t\t" + objfile.getInpuStream());
        //objfile.setFileName(token + ".xls");
        objfile.setFileName(token + ".xls");        
        uploadBean.setFolderstore("D:\\Temp_Upload\\File_Excel");
        uploadBean.store(mul);
        FileInputStream file = new FileInputStream(new File("D:\\Temp_Upload\\File_Excel\\" + token + ".xls"));
        try {
            objAL = obj_read.Read_XLS(file, objAL);//ทำการอ่าน File ทั้งหมดใน Excel
            if (Insert_Data_To_D_data_import_from_excel(con, objAL)) {//นำข้อมูลทั้งหมดใน Excel import เข้าใน D_data_import_from_excel และ ทำการตรวจสอบว่ามีรัหสสินค้า และ โกดังหรือยัง ถ้าครบแล้วจะเป็น flase ยังไม่ครบเป็น true
                Writer_Excel_POI objwriter = new Writer_Excel_POI();
                objwriter.Writer_XLS_D_data_import_from_excel(response, con);//ทำการเขียน File Excel
            } else {
                Generate_Insert_to_d_adjust_product(con);//Gen รหัสลง d_adjust_product
                //output = "นำเข้าข้อมูลสำเร็จ";
                String_return.append("นำเข้าข้อมูลสำเร็จ");
            }
        } catch (Exception e) {
            //return "เกิดการผิดพลาด";
            return String_return.toString();  
        } finally {
            //file.close();
            
            con.close();
            objAL.clear();
            //return output;
            return String_return.toString();  
        }

    }
    public String getResult() {
    return String_return.toString();
  }     

    private boolean Insert_Data_To_D_data_import_from_excel(Connection con, ArrayList<DataBeanD_data_import_from_excel> ObjAL) throws Exception {
        String SQL = "insert into d_data_import_from_excel(product_id,wh_in,location_id,weight,doc_type,name_t,pgroup_id,ptype_id,pcat_id,iodine,unit_id,unit_name,weight_bag,doc_date) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        UtiDatabase objuti = new UtiDatabase();
        try {
            //ALTER SEQUENCE serial RESTART WITH 105
            p = con.prepareStatement("DELETE FROM  d_data_import_from_excel");
            p.executeUpdate();
            p.clearBatch();
            p.clearParameters();
            p = con.prepareStatement("ALTER SEQUENCE seq_d_data_import_from_excel RESTART WITH 1");
            p.executeUpdate();
            p.clearBatch();
            p.clearParameters();
            p = con.prepareStatement(SQL);
            for (int count = 1; count < ObjAL.size(); count++) {
                p.setString(1, ObjAL.get(count).getProduct_id());
                p.setString(2, ObjAL.get(count).getWarehouse());
                p.setString(3, ObjAL.get(count).getLocation_id());
                p.setString(4, ObjAL.get(count).getWeight());
                p.setString(5, ObjAL.get(count).getDoc_type());
                p.setString(6, ObjAL.get(count).getName_t());
                p.setString(7, ObjAL.get(count).getPgroup_id());
                p.setString(8, ObjAL.get(count).getPtype_id());
                p.setString(9, ObjAL.get(count).getPcat_id());
                p.setString(10, ObjAL.get(count).getIodine());
                p.setString(11, ObjAL.get(count).getUnit_id());
                p.setString(12, ObjAL.get(count).getUnit_name());
                p.setString(13, ObjAL.get(count).getWeight_bag());
                p.setString(14, ObjAL.get(count).getDoc_date());
                p.addBatch();
            }
            p.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.close();
            }
            //con.close();
            return objuti.numRowdatabase("select count(product_id) as num from d_data_import_from_excel where (select mproduct.name_t from mproduct where  mproduct.product_id = d_data_import_from_excel.product_id and mproduct.delete_flag = 'N') is null") != 0 || objuti.numRowdatabase("select count(wh_in) as num from d_data_import_from_excel where (select mwarehouse.name_t from mwarehouse where  mwarehouse.warehouse_id = d_data_import_from_excel.wh_in and mwarehouse.delete_flag = 'N') is  null") != 0 ? true : false;
        }
    }

    private void Generate_Insert_to_d_adjust_product(Connection con) throws Exception {
        PreparedStatement p = null;
        ResultSet rs = null;
        int total_in = new UtiDatabase().numRowdatabase("select count(*) as num from d_data_import_from_excel where doc_type = '+'");
        int total_out = new UtiDatabase().numRowdatabase("select count(*) as num from d_data_import_from_excel where doc_type = '-'");
        int start = 0, row_page = 19, total_page;

        try {
            if (total_in != 0) {
                total_page = (int) Math.ceil((double) total_in / (double) row_page);
                for (int i = 1; i <= total_page; i++) {
                    start = (i - 1) * row_page;
                    Insert_d_adjust_product(con, p, rs, start, row_page, "+");
                }
            }
            if (total_out != 0) {
                total_page = (int) Math.ceil((double) total_out / (double) row_page);
                for (int i = 1; i <= total_page; i++) {
                    start = (i - 1) * row_page;
                    Insert_d_adjust_product(con, p, rs, start, row_page, "-");
                }
            }
            p = con.prepareStatement("DELETE FROM  d_data_import_from_excel");
            p.executeUpdate();
        } catch (Exception e) {
        } finally {

            if (p != null) {
                p.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
    }

    private void Insert_d_adjust_product(Connection con, PreparedStatement p, ResultSet rs, int start, int row_page, String doc_type) throws Exception {
        String Str_doc_id,
                Str_doc_date,
                Str_doc_time,
                SQL_Doc_Period = "select start_period from mperiod where doc_type = 'S'",
                SQL = "select runno,doc_date,product_id,wh_in,location_id,weight,doc_type from d_data_import_from_excel where doc_type = '" + doc_type + "' order by runno limit " + row_page + " offset " + start + "",
                SQL_Insert_header = "insert into d_adjust_product_header(doc_id,doc_date,doc_time,doc_type) values(?,?,?,?)",
                SQL_Insert_detail = "insert into d_adjust_product_detail(doc_id,doc_date,line_no,product_id,wh_in,location_id,weight,doc_type) values(?,?,?,?,?,?,?,?)";
                
        SimpleDateFormat doc_idformat = new SimpleDateFormat("yyMMdd_HHmm"),
                doc_dateformat = new SimpleDateFormat("dd-MM-yyyy"),
                doc_timeformat = new SimpleDateFormat("HH.ss");
                Date date_now = new Date();
        //Str_doc_id = (doc_type.equals("+") ? "IN" : "OUT") + doc_idformat.format(date_now) + "-" + (start + 1);
        
        String doc_date = "";
        rs = con.createStatement().executeQuery(SQL_Doc_Period);        
        
        while (rs.next()) {
            doc_date = rs.getString("start_period");
        }
        System.out.println("doc_date = "+doc_date);
        rs = null;
        //Str_doc_id = (doc_type.equals("+") ? "IN" : "OUT") + doc_idformat.format(date_now) + "-" + (start + 1);
        
        if (doc_date==null||doc_date.equals("")){
            Str_doc_id = (doc_type.equals("+") ? "IN" : "OUT") + "_" + doc_idformat.format(date_now) + "-" + (start + 1);            
            Str_doc_date = doc_dateformat.format(date_now);    
        } else {
            Str_doc_id = (doc_type.equals("+") ? "IN" : "OUT") + "_" + doc_date + "-" + (start + 1);            
            Str_doc_date = doc_date;
        }
        
        //Str_doc_date = doc_dateformat.format(date_now);        
        
        Str_doc_time = doc_timeformat.format(date_now);
        int line_no = 1;
        try {
            p = con.prepareStatement(SQL_Insert_header);
            p.setString(1, Str_doc_id);
            p.setString(2, Str_doc_date);
            p.setString(3, Str_doc_time);
            p.setString(4, doc_type);
            p.executeUpdate();
            p.clearBatch();
            p.clearParameters();
            rs = con.createStatement().executeQuery(SQL);
            p = con.prepareStatement(SQL_Insert_detail);
            while (rs.next()) {
                p.setString(1, Str_doc_id);
                p.setString(2, Str_doc_date);
                p.setString(3, "" + line_no);
                p.setString(4, rs.getString("product_id"));
                p.setString(5, rs.getString("wh_in"));
                p.setString(6, rs.getString("location_id"));
                p.setString(7, rs.getString("weight"));
                p.setString(8, rs.getString("doc_type"));
                p.addBatch();
                line_no += 1;
            }
            p.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            p = null;
            rs = null;
        }
    }
}
