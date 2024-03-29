/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_burn_in_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author ball
 */
public class D_carbon_burn_in_detail_whDAO {
    private int Returnvalue;

    public int insert(DataBeanD_carbon_burn_in_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_burn_in_detail_wh (doc_id,line_no,product_id,tank_suite,weight,weight_tank,weight_tot,silo_no,location_id,create_date,create_by,channel,remark) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getTank_suite());
            p.setString(5, dataBean.getWeight());
            p.setString(6, dataBean.getWeight_tank());
            p.setString(7, dataBean.getWeight_tot());
            p.setString(8, dataBean.getSilo_no());
            p.setString(9, dataBean.getLocation_id());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getBy());
            p.setString(12, dataBean.getChannel());
            p.setString(13, dataBean.getRemark());
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

    public int update(DataBeanD_carbon_burn_in_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_burn_in_detail_wh set  product_id=?,tank_suite=?,weight=?,weight_tank=?,weight_tot=?,silo_no=?,location_id=?,update_date=?,update_by=?,channel=?,remark=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag ='N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getTank_suite());
            p.setString(3, dataBean.getWeight());
            p.setString(4, dataBean.getWeight_tank());
            p.setString(5, dataBean.getWeight_tot());
            p.setString(6, dataBean.getSilo_no());
            p.setString(7, dataBean.getLocation_id());
            p.setTimestamp(8, dataBean.getDate());
            p.setString(9, dataBean.getBy());
            p.setString(10, dataBean.getChannel());
            p.setString(11, dataBean.getRemark());
            p.setString(12, dataBean.getDoc_id());
            p.setString(13, dataBean.getLine_no());
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

    public DataBeanD_carbon_burn_in_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_burn_in_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select * from vd_carbon_burn_in_detail_wh where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and complete_flag ='N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setProduct_id(rs.getString("product_id"));
                bean.setProd_name(rs.getString("prod_name"));
                bean.setRemark(rs.getString("remark"));
                bean.setSilo_no(rs.getString("silo_no"));
                bean.setTank_suite(rs.getString("tank_suite"));
                bean.setWeight(rs.getString("weight"));
                bean.setWeight_tank(rs.getString("weight_tank"));
                bean.setWeight_tot(rs.getString("weight_tot"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setChannel(rs.getString("channel"));
                bean.setRemark(rs.getString("remark"));
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

    public int DeleteLine_no(String inputarry, DataBeanD_carbon_burn_in_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        boolean pclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        int total = 0;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_carbon_burn_in_detail_wh set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                pclose = true;
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_burn_in_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_carbon_burn_in_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_burn_in_detail_wh set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }
                        sql2 = "select weight from d_carbon_burn_in_detail_wh where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = null;
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            total = total + Integer.parseInt(rs.getString("weight"));
                        }
                        ckclose = true;
                    } else {
                        total = 0;
                    }
                }
            } else {
                total = -1;
            }

        } finally {
            try {
                if (ckclose) {
                    rs.close();
                }
                if (pclose) {
                    p.close();
                    con.close();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //JOptionPane.showConfirmDialog(null, total);
        return total;

    }

    public int Delete_line_no_All(DataBeanD_carbon_burn_in_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        int total = 0;
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_burn_in_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=?";
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
        return total;

    }

    public String showDetail(String doc_id) throws Exception {
//"+(rs.getString("complete_flag").equals("N")?"<input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\">":"&nbsp;")+"
        StringBuffer strOutput = new StringBuffer();
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1 = "";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        SQL = "Select runno,doc_id,line_no,tank_suite,silo_no,prod_name,location_id,weight_tot,weight_tank,weight,complete_flag from vd_carbon_burn_in_detail_wh where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag = 'N'  order by runno";
        SQL1 = "Select Count(doc_id) As num from  vd_carbon_burn_in_detail_wh where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N'  and complete_flag = 'Y'";
        int a = objuti.numRowdatabase(SQL1);
        try {
            strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>"+(rs.getString("complete_flag").equals("N") && a == 0?"<input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\">":"&nbsp;")+"</td>");
                strOutput.append("<td class='forborder' width='7%'>"+(rs.getString("complete_flag").equals("N")?"<a href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,total_weight,username','../SCREEN/CS_028_2.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a>":rs.getString("line_no"))+"</td>");
                strOutput.append("<td class='forborder' width='7%'>" + rs.getString("tank_suite") + "</td>");
                strOutput.append("<td class='forborder' width='10%'>" + rs.getString("silo_no") + "</td>");
                strOutput.append("<td class='forborder' width='25%'>" + rs.getString("prod_name") + "</td>");
                strOutput.append("<td class='forborder' width='15%'>" + rs.getString("location_id") + "</td>");
                strOutput.append("<td class='forborder' width='15%'>" + rs.getString("weight_tot") + "</td>");
                strOutput.append("<td class='forborder' width='10%'>" + rs.getString("weight_tank") + "</td>");
                strOutput.append("<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>");
                strOutput.append("</tr>");
            }
            strOutput.append("</table>");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            return strOutput.toString();
        }
    }
}
