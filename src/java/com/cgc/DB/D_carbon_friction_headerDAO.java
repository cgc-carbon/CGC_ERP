/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanD_carbon_friction_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author Administrator
 */
public class D_carbon_friction_headerDAO {
    public void insert(DataBeanD_carbon_friction_header DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = null;
        int i = 1;
        try{
            SQL = "INSERT INTO d_carbon_friction_header(doc_id,doc_date,doc_time,shift,report_id,create_by,create_date,update_date) "
                    + "VALUES(?,?,?,?,?,?,?,?)";
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getDoc_id());i+=1;
            p.setString(i, DataBean.getDoc_date());i+=1;
            p.setString(i, DataBean.getDoc_time());i+=1;
            p.setString(i, DataBean.getShift());i+=1;
            p.setString(i, DataBean.getReport_id());i+=1;
            p.setString(i, DataBean.getBy());i+=1;
            p.setTimestamp(i, DataBean.getDate());i+=1;
            p.setTimestamp(i, DataBean.getDate());i+=1;
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(p!=null){
                p.close();
            }
            con.close();
        }
    }
    public void update(DataBeanD_carbon_friction_header DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = null;
        int i = 1;
        try{
            SQL = "UPDATE d_carbon_friction_header SET "
                    + "report_id = ?,update_by=?,update_date=?"
                    + " WHERE doc_id = '"+DataBean.getDoc_id()+"' and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getReport_id());i+=1;
            p.setString(i, DataBean.getBy());i+=1;
            p.setTimestamp(i, DataBean.getDate());i+=1;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(p!=null){
                p.close();
            }
            con.close();
        }
    }
    public void delete(DataBeanD_carbon_friction_header DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try{
            p = con.prepareStatement("update d_carbon_friction_header set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_withdraw_detail set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_receive_detail_1 set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("update d_carbon_friction_receive_detail_2 set delete_flag = 'Y',delete_by=?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N' ");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(p!=null){
                p.close();
            }
            con.close();
        }
    }
    

}
