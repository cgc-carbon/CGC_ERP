/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Calculator.Cal_Total;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_requisition_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author B
 */
public class D_requisition_product_header_whDAO {

    private int Returnvalue;

    public int update(DataBeanD_requisition_product_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        PreparedStatement p = null;
        String sql = "update d_requisition_product_header_wh set  "
                + "update_by=?,update_date=?,doc_type=?"
                + " where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        p = con.prepareCall(sql);
        p.setString(1, dataBean.getBy());
        p.setTimestamp(2, dataBean.getDate());
        p.setString(3, dataBean.getDoc_type());
        p.setString(4, dataBean.getDoc_id());
        p.executeUpdate();
        try {
            if (dataBean.getComplete_flag().equalsIgnoreCase("N")) {
                sql = "select count(doc_id) as num from d_requisition_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";

                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_requisition_product_detail_wh set doc_date=?,wh_in=?,wh_out=?,create_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getWh_in());
                    p.setString(3, dataBean.getWh_out());
                    p.setString(4, dataBean.getBy());
                    p.setString(5, dataBean.getDoc_id());
                    p.executeUpdate();
                    //**************************Header*************************
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_requisition_product_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'Y'") == 0) {
                        Cal_Total cal = new Cal_Total("d_requisition_product_detail_wh", "weight", dataBean.getDoc_id(), " and complete_flag <> 'Y'");
                        sql = "update d_requisition_product_header_wh set net_weight_wh=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                        p = null;
                        p = con.prepareStatement(sql);
                        p.setString(1, cal.Return_Total());
                        p.setString(2, dataBean.getDoc_id());
                        p.executeUpdate();
                    }
                }
            } else {
                Returnvalue = Return_Document("d_requisition_product", dataBean.getDoc_id(), con, p, objuti);
            }
        } finally {
            try {
                if(p != null){
                    p.close();
                }
                if(con != null){
                    con.close();
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return Returnvalue;

    }

    public int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
        String SQLDetail = "";
        int status_return = 0;
        try {
            //SQLHeader = "Select count(doc_id) as num from "+Table_name+"_header_wh where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail = "Select count(doc_id) as num from " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            if (Objuti.numRowdatabase(SQLDetail) == 0) {
                //***************Delete Warehouse********************************
                p = con.prepareStatement("DELETE FROM " + Table_name + "_header_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                p.clearParameters();
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                status_return = 1;
            } else {
                status_return = -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }
}
