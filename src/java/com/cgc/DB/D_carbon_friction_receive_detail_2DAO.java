/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_friction_receive_detail_2;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Administrator
 */
public class D_carbon_friction_receive_detail_2DAO {
    public void insert(DataBeanD_carbon_friction_receive_detail_2 DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try{
            p = con.prepareStatement("insert into d_carbon_friction_receive_detail_2(doc_id,line_no,product_id,bag_no,location_id,amount_bag,weight,total_weight,wh_in,create_by,create_date,update_date,doc_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            p.setString(i, DataBean.getDoc_id());i += 1;
            p.setString(i, DataBean.getLine_no());i += 1;
            p.setString(i, DataBean.getProduct_id());i += 1;
            p.setString(i, DataBean.getBag_no());i += 1;
            p.setString(i, DataBean.getLocation_id());i += 1;
            p.setString(i, DataBean.getAmount_bag());i += 1;
            p.setString(i, DataBean.getWeight());i += 1;
            p.setString(i, DataBean.getTotal_weight());i += 1;
            p.setString(i, DataBean.getWh_in());i += 1;
            p.setString(i, DataBean.getBy());i += 1;
            p.setTimestamp(i, DataBean.getData());i += 1;
            p.setTimestamp(i, DataBean.getData());i += 1;
            p.setString(i, DataBean.getDoc_date());i += 1;
            p.executeUpdate();
            
            UtiDatabase objuti = new UtiDatabase();
            String sql = "select count(location_id) as num from mlocation where location_id ='" + DataBean.getLocation_id() + "' and delete_flag <> 'Y' ";
            if(objuti.numRowdatabase(sql) == 0){
                sql = "insert into mlocation (location_id) "
                        + "values (?)";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, DataBean.getLocation_id());
                p.executeUpdate();
            }            
            
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(p != null){
                p.close();
            }
            con.close();
        }
    }
    public void update(DataBeanD_carbon_friction_receive_detail_2 DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try{
            p = con.prepareStatement("update d_carbon_friction_receive_detail_2 set "
                    + "product_id=?,bag_no=?,location_id=?,amount_bag=?,weight=?,total_weight=?,wh_in=?,update_by=?,update_date=?,doc_date=? "
                    + " where doc_id = '"+DataBean.getDoc_id()+"' and line_no = '"+DataBean.getLine_no()+"' and delete_flag = 'N' and complete_flag = 'N'");//insert into d_carbon_friction_receive_detail_2(doc_id,line_no,product_id,location_id,amount_bag,weight,total_weight,wh_in,create_by,create_date,update_date) ""values(?,?,?,?,?,?,?,?,?,?)
            p.setString(i, DataBean.getProduct_id());i += 1;
            p.setString(i, DataBean.getBag_no());i += 1;
            p.setString(i, DataBean.getLocation_id());i += 1;
            p.setString(i, DataBean.getAmount_bag());i += 1;
            p.setString(i, DataBean.getWeight());i += 1;
            p.setString(i, DataBean.getTotal_weight());i += 1;
            p.setString(i, DataBean.getWh_in());i += 1;
            p.setString(i, DataBean.getBy());i += 1;
            p.setTimestamp(i, DataBean.getData());i += 1;
            p.setString(i, DataBean.getDoc_date());i += 1;
            p.executeUpdate();
            
            UtiDatabase objuti = new UtiDatabase();
            String sql = "select count(location_id) as num from mlocation where location_id ='" + DataBean.getLocation_id() + "' and delete_flag <> 'Y' ";
            if(objuti.numRowdatabase(sql) == 0){
                sql = "insert into mlocation (location_id) "
                        + "values (?)";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, DataBean.getLocation_id());
                p.executeUpdate();
            }              
            
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(p != null){
                p.close();
            }
            con.close();
        }
    }
    public DataBeanD_carbon_friction_receive_detail_2 ReturnEdit(String doc_id,String line_no)throws Exception{
        DataBeanD_carbon_friction_receive_detail_2 obj_return = new DataBeanD_carbon_friction_receive_detail_2();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL = "Select product_id,doc_date,bag_no,location_id,amount_bag,weight,total_weight,wh_in from d_carbon_friction_receive_detail_2 where doc_id ='"+doc_id+"' and line_no = '"+line_no+"' and delete_flag = 'N' and complete_flag = 'N'";
        try{
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                obj_return.setProduct_id(rs.getString("product_id"));
                obj_return.setBag_no(rs.getString("bag_no"));
                obj_return.setLocation_id(rs.getString("location_id"));
                obj_return.setAmount_bag(rs.getString("amount_bag"));
                obj_return.setWeight(rs.getString("weight"));
                obj_return.setTotal_weight(rs.getString("total_weight"));
                obj_return.setWh_in(rs.getString("wh_in"));
                obj_return.setDoc_date(rs.getString("doc_date"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(rs != null){
                rs.close();
            }
            con.close();
            return obj_return;
        }
    }
    public void DeleteLine_no(String inputarry, DataBeanD_carbon_friction_receive_detail_2 bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        Connection con = new DBConnect().openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_carbon_friction_receive_detail_2 set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getData());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_friction_receive_detail_2 where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_carbon_friction_receive_detail_2 where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_friction_receive_detail_2 set line_no=? where doc_id=? and line_no=?";
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

    public void Delete_line_no_All(DataBeanD_carbon_friction_receive_detail_2 dataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        String sqldetail = "update d_carbon_friction_receive_detail_2 set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getData());
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
    public String ShowDetail(String doc_id)throws Exception{
        StringBuffer str_return = new StringBuffer();
        UtiDatabase objuti = new UtiDatabase();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL = "select count(doc_id) as num from d_carbon_friction_receive_detail_2 where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N'";
        try{
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
            if(objuti.numRowdatabase(SQL) == 0){
                str_return.append("<tr ><td align='center'>ไม่พบข้อมูลที่ต้องการ</td></tr>");
            }else{
                SQL = "select runno,doc_date,doc_id,line_no,product_id,bag_no,location_id,amount_bag,weight,total_weight,wh_in from d_carbon_friction_receive_detail_2 where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                rs = con.createStatement().executeQuery(SQL);
                while(rs.next()){
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox3' name='ckbox3' onclick=\"cancle_chkboxAll('chk_all3',this.checked)\"></td>");
                    str_return.append("<td class='forborder' width='7%'><a href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id','../SCREEN/CS_Detail_025_3.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='doc_date' value=\"" + rs.getString("doc_date") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("product_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("bag_no") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("location_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("amount_bag") + "</td>");
                    //str_return.append("<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>");
                    str_return.append("<td class='forborder' width='25%'>" + rs.getString("total_weight") + "</td>");
                    str_return.append("<td class='forborder' width='15%'>" + rs.getString("wh_in") + "</td>");
                     str_return.append("</tr>");
                }
            }
            str_return.append("</table>");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if(rs != null){
                rs.close();
            }
            con.close();
           return str_return.toString();
        }
    }
}
