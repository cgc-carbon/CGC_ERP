/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_rawmatt_bigbag_withdraw_header;
import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.sql.*;

/**
 *
 * @author BALL
 */
public class D_rawmatt_bigbag_withdraw_headerDAO {

    private int Returnvalue;

    public int insert(DataBeanD_rawmatt_bigbag_withdraw_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_rawmatt_bigbag_withdraw_header (doc_id,remark,company_id,wh_in,wh_out,runner_id,p_type,doc_date,doc_time,create_date,update_date,create_by,rawmat_emp) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getRemark());
            p.setString(3, dataBean.getCompany_id());
            p.setString(4, dataBean.getWh_in());
            p.setString(5, dataBean.getWh_out());
            p.setString(6, dataBean.getRunner_id());
            p.setString(7, dataBean.getP_type());
            p.setString(8, dataBean.getDoc_date());
            p.setString(9, dataBean.getDoc_time());
            p.setTimestamp(10, dataBean.getDate());
            p.setTimestamp(11, dataBean.getDate());
            p.setString(12, dataBean.getBy());
            p.setString(13, dataBean.getRawmat_emp());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_rawmatt_bigbag_withdraw_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if(objuti.numRowdatabase(sql) != 0){
                //sql = "update d_rawmatt_bigbag_withdraw_detail set doc_date=?,wh_in=?,wh_out=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                sql = "update d_rawmatt_bigbag_withdraw_detail set doc_date=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                //p.setString(2, dataBean.getWh_in());
                //p.setString(3, dataBean.getWh_out());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_rawmatt_bigbag_withdraw_header dataBean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_rawmatt_bigbag_withdraw_header set  remark=?,company_id=?,wh_in=?,wh_out=?,runner_id=?,p_type=?,doc_date=?,doc_time=?,update_date=?,update_by=?,rawmat_emp=? where doc_id=?";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getRemark());
            p.setString(2, dataBean.getCompany_id());
            p.setString(3, dataBean.getWh_in());
            p.setString(4, dataBean.getWh_out());
            p.setString(5, dataBean.getRunner_id());
            p.setString(6, dataBean.getP_type());
            p.setString(7, dataBean.getDoc_date());
            p.setString(8, dataBean.getDoc_time());
            p.setTimestamp(9, dataBean.getDate());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getRawmat_emp());
            p.setString(12, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            sql = "select count(doc_id) as num from d_rawmatt_bigbag_withdraw_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if(objuti.numRowdatabase(sql) != 0){
                //sql = "update d_rawmatt_bigbag_withdraw_detail set doc_date=?,wh_in=?,wh_out=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                //sql = "update d_rawmatt_bigbag_withdraw_detail set doc_date=?,wh_in=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                sql = "update d_rawmatt_bigbag_withdraw_detail set doc_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";                
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                //p.setString(2, dataBean.getWh_in());
                //p.setString(3, dataBean.getWh_out());
                p.setString(2, dataBean.getBy());
                p.setString(3, dataBean.getDoc_id());
                p.executeUpdate();
            }
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_rawmatt_bigbag_withdraw_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_rawmatt_bigbag_withdraw_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_rawmatt_bigbag_withdraw_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
}
