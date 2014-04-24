/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_adjust_product_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author BALL
 */
public class D_adjust_product_detailDAO {

    private int Returnvalue;

    public int insert(DataBeanD_adjust_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_adjust_product_detail (doc_id,line_no,product_id,location_id,weight,create_date,create_by,wh_in) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getLocation_id());
            p.setString(5, dataBean.getWeight());
            p.setTimestamp(6, dataBean.getDate());
            p.setString(7, dataBean.getBy());
            p.setString(8, dataBean.getWh_in());
            Returnvalue = p.executeUpdate();
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

    public int update(DataBeanD_adjust_product_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_adjust_product_detail set  product_id=?,location_id=?,weight=?,update_date=?,update_by=?,wh_in=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getLocation_id());
            p.setString(3, dataBean.getWeight());
            p.setTimestamp(4, dataBean.getDate());
            p.setString(5, dataBean.getBy());
            p.setString(6, dataBean.getWh_in());
            p.setString(7, dataBean.getDoc_id());
            p.setString(8, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

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

    public DataBeanD_adjust_product_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_adjust_product_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String SQL = "select d_adjust_product_detail.runno,d_adjust_product_detail.doc_id,d_adjust_product_detail.line_no,d_adjust_product_detail.product_id,d_adjust_product_detail.wh_in,"
                + "(select vproduct.name_t from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as prod_name,"
                + "(select vproduct.pgroup_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as pgroup_name,"
                + "(select vproduct.pcat_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as  pcat_name,"
                + "(select mwarehouse.name_t from mwarehouse where mwarehouse.warehouse_id = d_adjust_product_detail.wh_in) as warehouse_name,"
                + "d_adjust_product_detail.location_id,d_adjust_product_detail.weight,"
                + "d_adjust_product_detail.delete_flag,d_adjust_product_detail.cancel_flag,d_adjust_product_detail.complete_flag,d_adjust_product_detail.retro_flag"
                + " from d_adjust_product_detail  where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag = 'N' and complete_flag = 'N' ";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setProd_name(rs.getString("prod_name"));
                bean.setPgroup_name(rs.getString("pgroup_name"));
                bean.setPcat_name(rs.getString("pcat_name"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setWeight(rs.getString("weight"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("warehouse_name"));
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_adjust_product_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_adjust_product_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_adjust_product_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_adjust_product_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_adjust_product_detail set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }

                        ckclose = true;
                    }
                }
            }
        } finally {
            try {
                if (ckclose) {
                    rs.close();
                    p.close();
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_adjust_product_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_adjust_product_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  d_adjust_product_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "select d_adjust_product_detail.runno,d_adjust_product_detail.doc_id,d_adjust_product_detail.line_no,d_adjust_product_detail.product_id,d_adjust_product_detail.wh_in,"
                + "(select vproduct.name_t from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as prod_name,"
                + "(select vproduct.pgroup_name from vproduct where vproduct.product_id = d_adjust_product_detail.product_id) as pgroup_name,"
                + "(select mwarehouse.name_t from mwarehouse where mwarehouse.warehouse_id = d_adjust_product_detail.wh_in) as warehouse_name ,d_adjust_product_detail.location_id,d_adjust_product_detail.weight,"
                + "d_adjust_product_detail.delete_flag,d_adjust_product_detail.cancel_flag,d_adjust_product_detail.complete_flag,d_adjust_product_detail.retro_flag"
                + " from d_adjust_product_detail  where doc_id = '" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='forborder' width='7%'><a href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id','../SCREEN/CS_116.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("product_id") + "</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("prod_name") + "</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("pgroup_name") + "</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("warehouse_name") + "</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("location_id") + "</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("weight") + "</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
}
