/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.bean.DataBeanD_job_order_header;
import com.cgc.bean.DataBeanD_job_order_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.ResultSet;
import com.cgc.Util.UtiDatabase;
import com.cgc.Util.SendMail;
import com.cgc.bean.DataBeanSendMail;
import javax.swing.JOptionPane;
//import com.cgc.Util.SendMultipartMail;
/**
 *
 * @author BALL
 */
public class D_job_order_headerDAO {

    private int Returnvalue, count;

    public int insert(DataBeanD_job_order_header dataBean, ArrayList<DataBeanD_job_order_detail> ArrayBean) throws Exception {
        Returnvalue = 0;
        count = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_job_order_header "
                + "(doc_id,doc_date,cust_id,po_no,contain_date,iso_no,country_id,lot_no,mark_sign,base_plate,base_plate_desc,base_plate_qty,detail,approve,mark_sign_desc,create_date,update_date,create_by,quality_dep,prod_dep,wh_dep,sale_confirm,quality_confirm,prod_confirm,wh_confirm,i2,deadline,stock_prod) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getCompany_id());
            p.setString(4, dataBean.getPo_no());
            p.setString(5, dataBean.getContain_date());
            p.setString(6, dataBean.getIso_no());
            p.setString(7, dataBean.getCountry_id());
            p.setString(8, dataBean.getLot_no());
            p.setString(9, dataBean.getMark_sign());
            p.setString(10, dataBean.getBase_plate());
            p.setString(11, dataBean.getBase_plate_desc());
            p.setString(12, dataBean.getBase_plate_qty());
            p.setString(13, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(14, dataBean.getApprove());
            p.setString(15, dataBean.getMark_sign_desc());
            p.setTimestamp(16, dataBean.getDate());
            p.setTimestamp(17, dataBean.getDate());
            p.setString(18, dataBean.getBy());
            p.setString(19, dataBean.getQuality_dep());
            p.setString(20, dataBean.getProd_dep());
            p.setString(21, dataBean.getWh_dep());
            p.setString(22, dataBean.getSale_confirm());
            p.setString(23, dataBean.getQuality_confirm());
            p.setString(24, dataBean.getProd_confirm());
            p.setString(25, dataBean.getWh_confirm());
            p.setString(26, dataBean.getI2());
            p.setString(27, dataBean.getDeadline());
            p.setString(28, dataBean.getStock_prod());
            Returnvalue = p.executeUpdate();

            String sql2 = "insert into d_job_order_detail (doc_id,line_no,param,method,spec,add_desc) values(?,?,?,?,?,?)";
            p = con.prepareStatement(sql2);
            while (count < ArrayBean.size()) {
                //JOptionPane.showConfirmDialog(null,ArrayBean.get(count).getParam());
                p.setString(1, dataBean.getDoc_id());
                p.setString(2, ArrayBean.get(count).getLine_no());
                p.setString(3, ArrayBean.get(count).getParam());
                p.setString(4, ArrayBean.get(count).getMethod());
                p.setString(5, ArrayBean.get(count).getSpec());
                p.setString(6, ArrayBean.get(count).getAdd_desc());
                p.addBatch();
                count++;
            }
            p.executeBatch();
            sql = "update d_job_order_detail set doc_date=?,create_date=?,create_by=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
            p.clearBatch();
            p.clearParameters();
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

            /**
            * * Send Mail **
            */
            //String from = "office_ko@cgc-carbon.com";
            //String to = "product@cgc-carbon.com;sale@cgc-carbon.com;warehouse@cgc-carbon.com;lab@cgc-carbon.com;it@cgc-carbon.com";
            //String to = "it@cgc-carbon.com;@cgc-carbon.com;it@cgc-carbon.com";
            //SendMail objquerybean = 
            DataBeanSendMail dataBeansendmail = new SendMail(con, dataBean.getScreen_id()).Return_DataBeanSendMail();
            
            if (dataBeansendmail.getEmail_from() != null || dataBeansendmail.getEmail_to() != null || dataBeansendmail.getEmail_server() != null || dataBeansendmail.getEmail_port() != null) {
                //String from = email_from == null ? "office_ko@cgc-carbon.com" : email_from;
                //String to = email_to == null ? "it@cgc-carbon.com;" : email_to;
                String subject = "CGC ERP System : มีเอกสารมาใหม่ ใบแจ้งการผลิต เลขที่ : " + dataBean.getDoc_id() + " วันที่ : " + dataBean.getDoc_date();
                String message = "CGC ERP System : ใบแจ้งการผลิต เลขที่ : " + dataBean.getDoc_id() + " วันที่ : " + dataBean.getDoc_date();
                
                message = message + "<br>" + Return_Detail(dataBean, ArrayBean);
                message = message + "<br>";
                message = message + "<br>" + "-------------------------------------------------------------------------------------------------";
                message = message + "<br>" + "เพื่อความถูกต้องสมบูรณ์ โปรดตรวจสอบเอกสารใบแจ้งการผลิตในระบบ และเอกสารตัวจริง";
                
                
                //message = message + "<br>" + "<a href=\"http://202.183.167.6:8089/CGC_ERP\">CGC ERP LOGIN กรุณาล๊อคอิน</a>";  
                
                String[] array_to = dataBeansendmail.getEmail_to().split(";");
                for (int i = 0; i < array_to.length; i++) {
                    SendMail sendMail = new SendMail(dataBeansendmail.getEmail_from(), array_to[i], subject, message);
                    sendMail.send(dataBeansendmail.getEmail_server(), dataBeansendmail.getEmail_port());
                    System.out.println(array_to[i]);
                    System.out.println(subject);
                    System.out.println(sendMail);
                }
            }else{
                Returnvalue = -1;
            }


            //JOptionPane.showConfirmDialog(null, sendMail);
             

            /**
             * * Send Mail **
             */
            
            //SendMultipartMail obj_mmail = new SendMultipartMail();
            //obj_mmail.sendmail();
            
            //Chack_SaleorderProduct(dataBean.getPo_no_befor(), dataBean.getPo_no_befor(), con, p);
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

    public int update(DataBeanD_job_order_header dataBean, ArrayList<DataBeanD_job_order_detail> ArrayBean) throws Exception {
        Returnvalue = 0;
        count = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String sql =
                "update d_job_order_header set  doc_date=?,cust_id=?,po_no=?,contain_date=?,iso_no=?,country_id=?,lot_no=?,mark_sign=?,base_plate=?,base_plate_desc=?,base_plate_qty=?,detail=?,approve=?,mark_sign_desc=?,update_date=?,update_by=?,quality_dep=?,prod_dep=?,wh_dep=?,sale_confirm=?,quality_confirm=?,prod_confirm=?,wh_confirm=?,i2=?,deadline=?,stock_prod=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getCompany_id());
            p.setString(3, dataBean.getPo_no());
            p.setString(4, dataBean.getContain_date());
            p.setString(5, dataBean.getIso_no());
            p.setString(6, dataBean.getCountry_id());
            p.setString(7, dataBean.getLot_no());
            p.setString(8, dataBean.getMark_sign());
            p.setString(9, dataBean.getBase_plate());
            p.setString(10, dataBean.getBase_plate_desc());
            p.setString(11, dataBean.getBase_plate_qty());
            p.setString(12, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(13, dataBean.getApprove());
            p.setString(14, dataBean.getMark_sign_desc());
            p.setTimestamp(15, dataBean.getDate());
            p.setString(16, dataBean.getBy());
            p.setString(17, dataBean.getQuality_dep());
            p.setString(18, dataBean.getProd_dep());
            p.setString(19, dataBean.getWh_dep());
            p.setString(20, dataBean.getSale_confirm());
            p.setString(21, dataBean.getQuality_confirm());
            p.setString(22, dataBean.getProd_confirm());
            p.setString(23, dataBean.getWh_confirm());
            p.setString(24, dataBean.getI2());
            p.setString(25, dataBean.getDeadline());
            p.setString(26, dataBean.getStock_prod());
            p.setString(27, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
            

            
            String sql2 = "update  d_job_order_detail  set "
                    + "param=?,method=?,spec=?,add_desc=? "
                    + "where doc_id = ? and line_no =? and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(sql2);
            while (count < ArrayBean.size()) {
                p.setString(1, ArrayBean.get(count).getParam());
                p.setString(2, ArrayBean.get(count).getMethod());
                p.setString(3, ArrayBean.get(count).getSpec());
                p.setString(4, ArrayBean.get(count).getAdd_desc());
                p.setString(5, dataBean.getDoc_id());
                p.setString(6, ArrayBean.get(count).getLine_no());
                p.addBatch();
                count++;
            }
            p.executeBatch();
            p.clearBatch();
            sql = "update d_job_order_detail set doc_date=?,update_date=?,update_by=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
            p = null;
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
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
        return Returnvalue;

    }

    public int update_confirm(DataBeanD_job_order_header dataBean) throws Exception {
        Returnvalue = 0;
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = "";
        try {
            SQL = "update d_job_order_header SET "
                    + "approve=?,quality_dep=?,prod_dep=?,wh_dep=?,sale_confirm=?,quality_confirm=?,prod_confirm=?,wh_confirm=?,update_by=?,update_date=?,stock_prod=? "
                    + "WHERE doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(SQL);
            p.setString(1, dataBean.getApprove());
            p.setString(2, dataBean.getQuality_dep());
            p.setString(3, dataBean.getProd_dep());
            p.setString(4, dataBean.getWh_dep());
            p.setString(5, dataBean.getSale_confirm());
            p.setString(6, dataBean.getQuality_confirm());
            p.setString(7, dataBean.getProd_confirm());
            p.setString(8, dataBean.getWh_confirm());
            p.setString(9, dataBean.getBy());
            p.setTimestamp(10, dataBean.getDate());
            p.setString(11, dataBean.getStock_prod());
            p.setString(12, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return Returnvalue;
        }
    }

    public void UpDel(DataBeanD_job_order_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_job_order_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_job_order_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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

    public String showDetail(String doc_id) throws Exception {
        //JOptionPane.showConfirmDialog(null, "test");
        int i = 1;
        int loopstr = 0;
        String[] strInputtxt = new String[]{"ชนิด/ขนาด", "จำนวน(ตัน)", "รหัสสินค้า(CGC)", "การบรรจุ(กระสอบ)", "น้ำหนักบรรจุ", "Butane", "CTC", "I2", "Methvlene Blue", "Moisture Content", "Ash", "pH", "Bulk Density", "Hardness"};
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuffer strOutput = new StringBuffer();
        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");


        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'99') <=14 and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
            DBConnect objcon = new DBConnect();
            Connection con = objcon.openNewConnection();
            ResultSet rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>" + rs.getString("line_no") + "</td>");//<a href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_033.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a>
                strOutput.append("<td class='forborder' width='25%'><input name='param" + rs.getString("line_no") + "' type='text' id='param" + rs.getString("line_no") + "' value='" + rs.getString("param") + "' size=20 readonly='readonly'/></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + rs.getString("line_no") + "' type='text' id='method" + rs.getString("line_no") + "' value='" + rs.getString("method") + "' size=20 /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + rs.getString("line_no") + "' type='text' id='spec" + rs.getString("line_no") + "' value='" + rs.getString("spec") + "' size=20  " + (rs.getString("line_no").equals("1") ? "onclick=\"openBrWindow('m_carbon_size&textinput=spec1', 32, '../JSP/Search_Detail.jsp')\" readonly" : "") + "/></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + rs.getString("line_no") + "' type='text' id='add_desc" + rs.getString("line_no") + "' value='" + rs.getString("add_desc") + "' size=20  /></td>");
                strOutput.append("</tr>");
                //}
                i++;
                /*
                 * switch (Integer.parseInt(rs.getString("line_no"))) { case 3:
                 * strOutput.append("<tr>"); strOutput.append("<td
                 * class='forborder'
                 * width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                 * strOutput.append("<td class='forborder' width='7%'>" +
                 * rs.getString("line_no") + "</td>");//<a href=\"#\"
                 * onclick=\"OpenEdit(URLsend('line_no_" +
                 * rs.getString("line_no") +
                 * ",doc_id,username','../SCREEN/CS_033.jsp'))\"><input
                 * type='hidden' id='line_no_" + rs.getString("line_no") + "'
                 * value=\"" + rs.getString("line_no") + "\"><input
                 * type='hidden' id='doc_id' value=\"" + rs.getString("doc_id")
                 * + "\">" + rs.getString("line_no") + "</a>
                 * strOutput.append("<td class='forborder' width='25%'><input
                 * name='param" + rs.getString("line_no") + "' type='text'
                 * id='param" + rs.getString("line_no") + "' value='" +
                 * rs.getString("param") + "' size=20 readonly='readonly'
                 * />&nbsp;<a href='javascript:;'
                 * onClick=\"openBrWindow(\'d_saleorderproduct_detail&stadment=and+doc_id+=+\\''+getId('po_no').value+'\\'',32,
                 * 'Search_Config2.jsp')\"><img
                 * src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา'
                 * name='IMAGE3' width='20' height='20' border='0'
                 * align='middle' ></a></td>"); strOutput.append("<td
                 * class='forborder' width='25%'><input name='method" +
                 * rs.getString("line_no") + "' type='text' id='method" +
                 * rs.getString("line_no") + "' value='" +
                 * rs.getString("method") + "' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='spec" + rs.getString("line_no") + "' type='text'
                 * id='spec" + rs.getString("line_no") + "' value='" +
                 * rs.getString("spec") + "' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='add_desc" + rs.getString("line_no") + "' type='text'
                 * id='add_desc" + rs.getString("line_no") + "' value='" +
                 * rs.getString("add_desc") + "' size=20 /></td>");
                 * strOutput.append("</tr>"); //} i++; break; default:
                 * strOutput.append("<tr>"); strOutput.append("<td
                 * class='forborder'
                 * width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                 * strOutput.append("<td class='forborder' width='7%'>" +
                 * rs.getString("line_no") + "</td>");//<a href=\"#\"
                 * onclick=\"OpenEdit(URLsend('line_no_" +
                 * rs.getString("line_no") +
                 * ",doc_id,username','../SCREEN/CS_033.jsp'))\"><input
                 * type='hidden' id='line_no_" + rs.getString("line_no") + "'
                 * value=\"" + rs.getString("line_no") + "\"><input
                 * type='hidden' id='doc_id' value=\"" + rs.getString("doc_id")
                 * + "\">" + rs.getString("line_no") + "</a>
                 * strOutput.append("<td class='forborder' width='25%'><input
                 * name='param" + rs.getString("line_no") + "' type='text'
                 * id='param" + rs.getString("line_no") + "' value='" +
                 * rs.getString("param") + "' size=20
                 * readonly='readonly'/></td>"); strOutput.append("<td
                 * class='forborder' width='25%'><input name='method" +
                 * rs.getString("line_no") + "' type='text' id='method" +
                 * rs.getString("line_no") + "' value='" +
                 * rs.getString("method") + "' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='spec" + rs.getString("line_no") + "' type='text'
                 * id='spec" + rs.getString("line_no") + "' value='" +
                 * rs.getString("spec") + "' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='add_desc" + rs.getString("line_no") + "' type='text'
                 * id='add_desc" + rs.getString("line_no") + "' value='" +
                 * rs.getString("add_desc") + "' size=20 /></td>");
                 * strOutput.append("</tr>"); //} i++; break; }
                 */
                //if (Integer.parseInt(rs.getString("line_no")) >= 1 && Integer.parseInt(rs.getString("line_no")) <= 14) {
            }
            rs.close();
            con.close();
            strOutput.append("</table>");
        } else {
            //JOptionPane.showConfirmDialog(null, "test");

            while (i <= 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>&nbsp;&nbsp;" + Integer.toString(i) + "&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%'><input name='param" + Integer.toString(i) + "' type='text' id='param" + Integer.toString(i) + "' value='" + strInputtxt[loopstr] + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + Integer.toString(i) + "' type='text' id='method" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + Integer.toString(i) + "' type='text' id='spec" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + Integer.toString(i) + "' type='text' id='add_desc" + Integer.toString(i) + "' value='' size=20 /></td>");
                strOutput.append("</tr>");
                i++;
                loopstr++;
                /*
                 * switch (i) { case 3: strOutput.append("<tr>");
                 * strOutput.append("<td class='forborder'
                 * width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                 * strOutput.append("<td class='forborder'
                 * width='7%'>&nbsp;&nbsp;" + Integer.toString(i) +
                 * "&nbsp;&nbsp;</td>"); strOutput.append("<td class='forborder'
                 * width='25%'><input name='param" + Integer.toString(i) + "'
                 * type='text' id='param" + Integer.toString(i) + "' value='" +
                 * strInputtxt[loopstr] + "' size=20 readonly='readonly'
                 * />&nbsp;<a href='javascript:;'
                 * onClick=\"openBrWindow('d_saleorderproduct_detail&stadment=and+doc_id+=+\\''+getId('po_no').value+'\\'',32,
                 * 'Search_Config2.jsp')\"><img
                 * src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา'
                 * name='IMAGE3' width='20' height='20' border='0'
                 * align='middle' ></a></td>"); strOutput.append("<td
                 * class='forborder' width='25%'><input name='method" +
                 * Integer.toString(i) + "' type='text' id='method" +
                 * Integer.toString(i) + "' value='' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='spec" + Integer.toString(i) + "' type='text' id='spec"
                 * + Integer.toString(i) + "' value='' size=20 /></td>");
                 * strOutput.append("<td class='forborder' width='20%'><input
                 * name='add_desc" + Integer.toString(i) + "' type='text'
                 * id='add_desc" + Integer.toString(i) + "' value='' size=20
                 * /></td>"); strOutput.append("</tr>"); i++; loopstr++; break;
                 * default: strOutput.append("<tr>"); strOutput.append("<td
                 * class='forborder'
                 * width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                 * strOutput.append("<td class='forborder'
                 * width='7%'>&nbsp;&nbsp;" + Integer.toString(i) +
                 * "&nbsp;&nbsp;</td>"); strOutput.append("<td class='forborder'
                 * width='25%'><input name='param" + Integer.toString(i) + "'
                 * type='text' id='param" + Integer.toString(i) + "' value='" +
                 * strInputtxt[loopstr] + "' size=20 readonly='readonly'
                 * /></td>"); strOutput.append("<td class='forborder'
                 * width='25%'><input name='method" + Integer.toString(i) + "'
                 * type='text' id='method" + Integer.toString(i) + "' value=''
                 * size=20 /></td>"); strOutput.append("<td class='forborder'
                 * width='20%'><input name='spec" + Integer.toString(i) + "'
                 * type='text' id='spec" + Integer.toString(i) + "' value=''
                 * size=20 /></td>"); strOutput.append("<td class='forborder'
                 * width='20%'><input name='add_desc" + Integer.toString(i) + "'
                 * type='text' id='add_desc" + Integer.toString(i) + "' value=''
                 * size=20 /></td>"); strOutput.append("</tr>"); i++; loopstr++;
                 * break; }
                 */
            }
            strOutput.append("</table>");
        }
        return strOutput.toString();
    }

    public String showDetail2(String doc_id) throws Exception {
        //JOptionPane.showConfirmDialog(null, "test");
        int i = 1;
        int loopstr = 0;
        String[] strInputtxt = new String[]{"ชนิด/ขนาด", "จำนวน(ตัน)", "รหัสสินค้า(CGC)", "การบรรจุ(กระสอบ)", "น้ำหนักบรรจุ", "Butane", "CTC", "I2", "Methvlene Blue", "Moisture Content", "Ash", "pH", "Bulk Density", "Hardness"};
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL;
        StringBuffer strOutput = new StringBuffer();
        strOutput.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");


        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
        SQL1 = "Select Count(doc_id) As num from  vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        a = objuti.numRowdatabase(SQL1);
        if (a != 0) {
            SQL = "Select doc_id,line_no,param,method,spec,add_desc from vd_job_order_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and to_number(line_no,'999') <=14 and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
            DBConnect objcon = new DBConnect();
            Connection con = objcon.openNewConnection();
            ResultSet rs = null;
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                //if (Integer.parseInt(rs.getString("line_no")) >= 1 && Integer.parseInt(rs.getString("line_no")) <= 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>" + rs.getString("line_no") + "</td>");
                strOutput.append("<td class='forborder' width='25%'><input name='param" + rs.getString("line_no") + "' type='text' id='param" + rs.getString("line_no") + "' value='" + rs.getString("param") + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + rs.getString("line_no") + "' type='text' id='method" + rs.getString("line_no") + "' value='" + rs.getString("method") + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + rs.getString("line_no") + "' type='text' id='spec" + rs.getString("line_no") + "' value='" + rs.getString("spec") + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + rs.getString("line_no") + "' type='text' id='add_desc" + rs.getString("line_no") + "' value='" + rs.getString("add_desc") + "' size=20 readonly='readonly' /></td>");
                strOutput.append("</tr>");
                //}

            }
            rs.close();
            con.close();
            strOutput.append("</table>");
        } else {
            //JOptionPane.showConfirmDialog(null, "test");

            while (i <= 14) {
                strOutput.append("<tr>");
                strOutput.append("<td class='forborder' width='3px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='7%'>&nbsp;&nbsp;" + Integer.toString(i) + "&nbsp;&nbsp;</td>");
                strOutput.append("<td class='forborder' width='25%'><input name='param" + Integer.toString(i) + "' type='text' id='param" + Integer.toString(i) + "' value='" + strInputtxt[loopstr] + "' size=20 readonly='readonly' /></td>");
                strOutput.append("<td class='forborder' width='25%'><input name='method" + Integer.toString(i) + "' type='text' id='method" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='spec" + Integer.toString(i) + "' type='text' id='spec" + Integer.toString(i) + "' value='' size=20  /></td>");
                strOutput.append("<td class='forborder' width='20%'><input name='add_desc" + Integer.toString(i) + "' type='text' id='add_desc" + Integer.toString(i) + "' value='' size=20 /></td>");
                strOutput.append("</tr>");
                i++;
                loopstr++;
            }
            strOutput.append("</table>");
        }
        return strOutput.toString();

    }

    public void Chack_SaleorderProduct(String befor_doc_id, String after_doc_id, Connection con, PreparedStatement p) throws Exception {
        String SQL = null;
        try {
            if (new UtiDatabase().numRowdatabase("select count(doc_id) as num "
                    + "from d_summary_product_master "
                    + "where doc_id ='" + befor_doc_id + "' and delete_flag = 'N' and complete_flag = 'N' and doc_type = 'Y'") != 0) {
                for (int i = 0; i <= 1; i++) {
                    SQL = "update d_summary_product_master set doc_type = '" + (i == 0 ? "N" : "Y") + "' where doc_id = " + (i == 0 ? "'" + befor_doc_id + "'" : "'" + after_doc_id + "'") + " and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareCall(SQL);
                    p.executeUpdate();
                    p.clearParameters();
                }
            } else {
                SQL = "update d_summary_product_master set doc_type ='Y'where doc_id  = '" + after_doc_id + "' and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareCall(SQL);
                p.executeUpdate();
                p.clearParameters();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.clearParameters();
            }
        }
    }

    public void Close_Job_Order(DataBeanD_job_order_header dataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            p = con.prepareStatement("UPDATE d_job_order_header SET "
                    + "close_job_type=?,remark_close_job_order=?,complete_flag=?,update_by=?,update_date=? "
                    + "WHERE doc_id=? AND delete_flag ='N' AND complete_flag ='N' ");
            p.setString(1, dataBean.getDoc_type());
            p.setString(2, dataBean.getRemark());
            p.setString(3, dataBean.getApprove());
            p.setString(4, dataBean.getBy());
            p.setTimestamp(5, dataBean.getDate());
            p.setString(6, dataBean.getDoc_id());
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    public static String Return_Detail(DataBeanD_job_order_header beanheader,ArrayList<DataBeanD_job_order_detail> array_deatil){
        StringBuffer  return_str = new StringBuffer();
        try{
            return_str.append("รหัสเอกสาร : "+beanheader.getDoc_id()+"<br>");
            return_str.append("ชื่อลูกค้า : "+beanheader.getCust_id_desc()+"<br>");
            for(int i = 0;i<array_deatil.size();i++){
                return_str.append(array_deatil.get(i).getParam() +" : " + array_deatil.get(i).getMethod() + " : "+ array_deatil.get(i).getSpec()+ " : "+ array_deatil.get(i).getAdd_desc()+"<br>");
                //return_str.append("<td>"+array_deatil.get(i).getParam() +"</td><td>" + array_deatil.get(i).getMethod() + "</td><td>"+ array_deatil.get(i).getSpec()+ "</td><td>"+ array_deatil.get(i).getAdd_desc()+"</td><br>");
            }
        }catch(Exception e){
            
        }finally{
            return return_str.toString();
        }
    }

    
}
