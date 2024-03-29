/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_quality_rawmatt_receive_rate_detail;
import com.cgc.bean.DataBeanD_quality_rawmatt_receive_rate_header;
import com.cgc.bean.DataBeanM_quality_rawmatt_receive;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class D_quality_rawmatt_receive_rateDAO {

    public void main_summary_quality(DataBeanD_quality_rawmatt_receive_rate_header obj_Bean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        PreparedStatement p = null;
        ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail> ALobj_bean_detail = new ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail>();
        DataBeanM_quality_rawmatt_receive objm_quality = new DataBeanM_quality_rawmatt_receive();
        try {
            obj_Bean.setDoc_id(obj_Bean.getSupplier_id() + "-" + obj_Bean.getRate_text() + "/" + obj_Bean.getYear());
            objm_quality.setQuality_id(obj_Bean.getQuality_id());
            objm_quality = Return_M_quality_rawmatt(objm_quality, con, rs);
            delete(con, p, obj_Bean.getDoc_id());
            obj_Bean = Return_Header(obj_Bean, con, rs);
            ALobj_bean_detail = Return_Detail(objm_quality, ALobj_bean_detail, Integer.toString(Integer.parseInt(obj_Bean.getYear()) - 543), Integer.parseInt(obj_Bean.getRate_text()), obj_Bean.getSupplier_id(), obj_Bean.getProduct_id(), con, rs);
            obj_Bean = Total_Quality_value(obj_Bean, ALobj_bean_detail);
            insert(obj_Bean, ALobj_bean_detail, con, p);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.close();
            }
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    //<editor-fold desc="ทำการค้นหาจำนวนรถที่เข้ามาส่งวัตถุดิบของแต่ละsupplier">

    public DataBeanD_quality_rawmatt_receive_rate_header Return_Header(DataBeanD_quality_rawmatt_receive_rate_header obj_Bean, Connection con, ResultSet rs) throws Exception {
        String SQL = null;
        int select_rate = 0;
        select_rate = Integer.parseInt(obj_Bean.getRate_text());
        try {
            switch (select_rate) {
                case 1:
                    SQL = "select "
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '01-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value1,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '02-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value2,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '03-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value3,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '04-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value4,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as total_value,"
                            + "(select sum(to_number(carbon_net,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as car_in_weight,"
                            + "(select sum((to_number(carbon_net,'9999990.00')-to_number(net_weight_ch,'9999990.00'))) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as cut_weight,"
                            + "(select sum(to_number(net_weight_ch,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as net_weight"
                            + " from vd_rawmatt_receive  where delete_flag = 'N' and doc_type = 'Y' group by value1,value2,value3,value4,total_value ";
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        obj_Bean.setM01(rs.getString("value1"));
                        obj_Bean.setM02(rs.getString("value2"));
                        obj_Bean.setM03(rs.getString("value3"));
                        obj_Bean.setM04(rs.getString("value4"));
                        obj_Bean.setM_total(rs.getString("total_value"));
                        obj_Bean.setCar_in_weight(rs.getString("car_in_weight"));
                        obj_Bean.setCut_weight(rs.getString("cut_weight"));
                        obj_Bean.setNet_weight(rs.getString("net_weight"));
                    }
                    break;
                case 2:
                    SQL = "select "
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '01-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value1,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '02-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value2,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '03-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value3,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '04-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value4,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as total_value,"
                            + "(select sum(to_number(carbon_net,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as car_in_weight,"
                            + "(select sum((to_number(carbon_net,'9999990.00')-to_number(net_weight_ch,'9999990.00'))) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as cut_weight,"
                            + "(select sum(to_number(net_weight_ch,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as net_weight"
                            + " from vd_rawmatt_receive  where delete_flag = 'N' and doc_type = 'Y' group by value1,value2,value3,value4,total_value ";
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        obj_Bean.setM05(rs.getString("value1"));
                        obj_Bean.setM06(rs.getString("value2"));
                        obj_Bean.setM07(rs.getString("value3"));
                        obj_Bean.setM08(rs.getString("value4"));
                        obj_Bean.setM_total(rs.getString("total_value"));
                        obj_Bean.setCar_in_weight(rs.getString("car_in_weight"));
                        obj_Bean.setCut_weight(rs.getString("cut_weight"));
                        obj_Bean.setNet_weight(rs.getString("net_weight"));
                    }
                    break;
                case 3:
                    SQL = "select "
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '01-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value1,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '02-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value2,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '03-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value3,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') = '04-" + obj_Bean.getYear() + "' and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as value4,"
                            + "(select trim(to_char(count(supplier_id),'990')) :: character varying from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as total_value,"
                            + "(select sum(to_number(carbon_net,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-" + obj_Bean.getYear() + "','02-" + obj_Bean.getYear() + "','03-" + obj_Bean.getYear() + "','04-" + obj_Bean.getYear() + "') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as car_in_weight,"
                            + "(select sum((to_number(carbon_net,'9999990.00')-to_number(net_weight_ch,'9999990.00'))) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as cut_weight,"
                            + "(select sum(to_number(net_weight_ch,'9999990.00')) from vd_rawmatt_receive where supplier_id = '" + obj_Bean.getSupplier_id() + "' and to_char(to_date(doc_date,'DD-MM-YYYY'),'MM-YYYY') in ('01-2555','02-2555','03-2555','04-2555') and product_id ='" + obj_Bean.getProduct_id() + "' and delete_flag = 'N' and doc_type = 'Y') as net_weight"
                            + " from vd_rawmatt_receive  where delete_flag = 'N' and doc_type = 'Y' group by value1,value2,value3,value4,total_value ";
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        obj_Bean.setM09(rs.getString("value1"));
                        obj_Bean.setM10(rs.getString("value2"));
                        obj_Bean.setM11(rs.getString("value3"));
                        obj_Bean.setM12(rs.getString("value4"));
                        obj_Bean.setM_total(rs.getString("total_value"));
                        obj_Bean.setCar_in_weight(rs.getString("car_in_weight"));
                        obj_Bean.setCut_weight(rs.getString("cut_weight"));
                        obj_Bean.setNet_weight(rs.getString("net_weight"));
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return obj_Bean;
        }
    }
    //</editor-fold>
    //<editor-fold desc="ทำการค้นหาข้อมูลด้านคุณภาพของแต่ละ Supplier">

    public ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail> Return_Detail(DataBeanM_quality_rawmatt_receive Bean_m_quality,
            ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail> ALobj_bean, String year, int select_rate, String supplier_id, String product_id, Connection con, ResultSet rs) throws Exception {
        String SQL = null;
        try {
            SQL = "select "
                    + "(select trim(to_char(count(ashes_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(ashes_percent,'990.00') <= " + Bean_m_quality.getAshes_value1() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as ashes_percent_count1,"//ขี้เถ่า
                    + "(select trim(to_char(count(ashes_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(ashes_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getAshes_value2() + "'),'90.00') and  to_number(ashes_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getAshes_value2() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as ashes_percent_count2,"
                    + "(select trim(to_char(count(ashes_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(ashes_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getAshes_value3() + "'),'90.00') and  to_number(ashes_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getAshes_value3() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as ashes_percent_count3,"
                    + "(select trim(to_char(count(ashes_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(ashes_percent,'990.00') > " + Bean_m_quality.getAshes_value4() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as ashes_percent_count4,  "
                    + "(select trim(to_char(count(dust_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(dust_percent,'990.00') <= " + Bean_m_quality.getDust_value1() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as dust_percent_count1,"//--ฝุ่น
                    + "(select trim(to_char(count(dust_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(dust_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getDust_value2() + "'),'90.00') and  to_number(dust_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getDust_value2() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as dust_percent_count2,"
                    + "(select trim(to_char(count(dust_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(dust_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getDust_value3() + "'),'90.00') and  to_number(dust_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getDust_value3() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as dust_percent_count3,"
                    + "(select trim(to_char(count(dust_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(dust_percent,'990.00') > " + Bean_m_quality.getDust_value4() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as dust_percent_count4,  "
                    + "(select trim(to_char(count(volatile_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(volatile_percent,'990.00') <= " + Bean_m_quality.getVolatile_value1() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as volatile_percent_count1,"//--การระเหย
                    + "(select trim(to_char(count(volatile_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(volatile_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getVolatile_value2() + "'),'90.00') and  to_number(volatile_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getVolatile_value2() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as volatile_percent_count2,"
                    + "(select trim(to_char(count(volatile_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(volatile_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getVolatile_value3() + "'),'90.00') and  to_number(volatile_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getVolatile_value3() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as volatile_percent_count3,"
                    + "(select trim(to_char(count(volatile_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(volatile_percent,'990.00') > " + Bean_m_quality.getVolatile_value4() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as volatile_percent_count4, "
                    + "(select trim(to_char(count(moise_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(moise_percent,'990.00') <= " + Bean_m_quality.getMoise_value1() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as moise_percent_count1,"//--ความชื้น
                    + "(select trim(to_char(count(moise_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(moise_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getMoise_value2() + "'),'90.00') and  to_number(moise_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getMoise_score2() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as moise_percent_count2,"
                    + "(select trim(to_char(count(moise_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(moise_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getMoise_value3() + "'),'90.00') and  to_number(moise_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getMoise_score3() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as moise_percent_count3,"
                    + "(select trim(to_char(count(moise_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(moise_percent,'990.00') > " + Bean_m_quality.getMoise_value4() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as moise_percent_count4,  "
                    + "(select trim(to_char(count(contamination_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(contamination_percent,'990.00') <= " + Bean_m_quality.getContamination_value1() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as contamination_percent_count1,"//--สิ่งเจอปน
                    + "(select trim(to_char(count(contamination_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(contamination_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getContamination_value2() + "'),'90.00') and  to_number(contamination_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getContamination_score2() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as contamination_percent_count2,"
                    + "(select trim(to_char(count(contamination_percent),'990')) :: character varying from vd_rawmatt_receive where (to_number(contamination_percent,'990.00') >= to_number(substring_begin('" + Bean_m_quality.getContamination_value3() + "'),'90.00') and  to_number(contamination_percent,'990.00') <= to_number(substring_end('" + Bean_m_quality.getContamination_score3() + "'),'90.00')) and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as contamination_percent_count3,"
                    + "(select trim(to_char(count(contamination_percent),'990')) :: character varying from vd_rawmatt_receive where to_number(contamination_percent,'990.00') > " + Bean_m_quality.getContamination_value4() + " and supplier_id = '" + supplier_id + "' and (to_date(format_date(doc_date),'YYYY-MM-DD') between '" + (select_rate == 1 ? year + "-01-01" : select_rate == 2 ? year + "-05-01" : year + "-09-01") + "' and '" + (select_rate == 1 ? year + "-04-30" : select_rate == 2 ? year + "-08-31" : year + "-12-31") + "') and product_id = '" + product_id + "' and delete_flag = 'N' and doc_type = 'Y') as contamination_percent_count4  "
                    + "from vd_rawmatt_receive  where product_id = '" + product_id + "' and  delete_flag = 'N' and doc_type = 'Y' "
                    + "group by "
                    + "ashes_percent_count1,ashes_percent_count2,ashes_percent_count3,ashes_percent_count4"
                    + ",dust_percent_count1,dust_percent_count2,dust_percent_count3,dust_percent_count4"
                    + ",moise_percent_count1,moise_percent_count2,moise_percent_count3,moise_percent_count4"
                    + ",contamination_percent_count1,contamination_percent_count2,contamination_percent_count3,contamination_percent_count4"
                    + ",volatile_percent_count1,volatile_percent_count2,volatile_percent_count3,volatile_percent_count4";

            for (int i = 1; i <= 2; i++) {
                DataBeanD_quality_rawmatt_receive_rate_detail bean = new DataBeanD_quality_rawmatt_receive_rate_detail();
                bean.setLine_no(Integer.toString(i));
                bean.setAshes1(i == 1 ? Bean_m_quality.getAshes_value1() : Bean_m_quality.getAshes_score1());
                bean.setAshes2(i == 1 ? Bean_m_quality.getAshes_value2() : Bean_m_quality.getAshes_score2());
                bean.setAshes3(i == 1 ? Bean_m_quality.getAshes_value3() : Bean_m_quality.getAshes_score3());
                bean.setAshes4(i == 1 ? Bean_m_quality.getAshes_value4() : Bean_m_quality.getAshes_score4());
                bean.setDust1(i == 1 ? Bean_m_quality.getDust_value1() : Bean_m_quality.getDust_score1());
                bean.setDust2(i == 1 ? Bean_m_quality.getDust_value2() : Bean_m_quality.getDust_score2());
                bean.setDust3(i == 1 ? Bean_m_quality.getDust_value3() : Bean_m_quality.getDust_score3());
                bean.setDust4(i == 1 ? Bean_m_quality.getDust_value4() : Bean_m_quality.getDust_score4());
                bean.setVolatile1(i == 1 ? Bean_m_quality.getVolatile_value1() : Bean_m_quality.getVolatile_score1());
                bean.setVolatile2(i == 1 ? Bean_m_quality.getVolatile_value2() : Bean_m_quality.getVolatile_score2());
                bean.setVolatile3(i == 1 ? Bean_m_quality.getVolatile_value3() : Bean_m_quality.getVolatile_score3());
                bean.setVolatile4(i == 1 ? Bean_m_quality.getVolatile_value4() : Bean_m_quality.getVolatile_score4());
                bean.setMoise1(i == 1 ? Bean_m_quality.getMoise_value1() : Bean_m_quality.getMoise_score1());
                bean.setMoise2(i == 1 ? Bean_m_quality.getMoise_value2() : Bean_m_quality.getMoise_score2());
                bean.setMoise3(i == 1 ? Bean_m_quality.getMoise_value3() : Bean_m_quality.getMoise_score3());
                bean.setMoise4(i == 1 ? Bean_m_quality.getMoise_value4() : Bean_m_quality.getMoise_score4());
                bean.setContamination1(i == 1 ? Bean_m_quality.getContamination_value1() : Bean_m_quality.getContamination_score1());
                bean.setContamination2(i == 1 ? Bean_m_quality.getContamination_value2() : Bean_m_quality.getContamination_score2());
                bean.setContamination3(i == 1 ? Bean_m_quality.getContamination_value3() : Bean_m_quality.getContamination_score3());
                bean.setContamination4(i == 1 ? Bean_m_quality.getContamination_value4() : Bean_m_quality.getContamination_score4());
                ALobj_bean.add(bean);
            }
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                for (int i = 1; i <= 2; i++) {
                    DataBeanD_quality_rawmatt_receive_rate_detail bean = new DataBeanD_quality_rawmatt_receive_rate_detail();
                    bean.setLine_no(Integer.toString(ALobj_bean.size() + 1));
                    bean.setAshes1(i == 1 ? rs.getString("ashes_percent_count1") : Multiple_value(rs.getString("ashes_percent_count1"), Bean_m_quality.getAshes_score1()));
                    bean.setAshes2(i == 1 ? rs.getString("ashes_percent_count2") : Multiple_value(rs.getString("ashes_percent_count2"), Bean_m_quality.getAshes_score2()));
                    bean.setAshes3(i == 1 ? rs.getString("ashes_percent_count3") : Multiple_value(rs.getString("ashes_percent_count3"), Bean_m_quality.getAshes_score3()));
                    bean.setAshes4(i == 1 ? rs.getString("ashes_percent_count4") : Multiple_value(rs.getString("ashes_percent_count4"), Bean_m_quality.getAshes_score4()));
                    bean.setDust1(i == 1 ? rs.getString("dust_percent_count1") : Multiple_value(rs.getString("dust_percent_count1"), Bean_m_quality.getDust_score1()));
                    bean.setDust2(i == 1 ? rs.getString("dust_percent_count2") : Multiple_value(rs.getString("dust_percent_count2"), Bean_m_quality.getDust_score2()));
                    bean.setDust3(i == 1 ? rs.getString("dust_percent_count3") : Multiple_value(rs.getString("dust_percent_count3"), Bean_m_quality.getDust_score3()));
                    bean.setDust4(i == 1 ? rs.getString("dust_percent_count4") : Multiple_value(rs.getString("dust_percent_count4"), Bean_m_quality.getDust_score4()));
                    bean.setVolatile1(i == 1 ? rs.getString("volatile_percent_count1") : Multiple_value(rs.getString("volatile_percent_count1"), Bean_m_quality.getVolatile_score1()));
                    bean.setVolatile2(i == 1 ? rs.getString("volatile_percent_count2") : Multiple_value(rs.getString("volatile_percent_count2"), Bean_m_quality.getVolatile_score2()));
                    bean.setVolatile3(i == 1 ? rs.getString("volatile_percent_count3") : Multiple_value(rs.getString("volatile_percent_count3"), Bean_m_quality.getVolatile_score3()));
                    bean.setVolatile4(i == 1 ? rs.getString("volatile_percent_count4") : Multiple_value(rs.getString("volatile_percent_count4"), Bean_m_quality.getVolatile_score4()));
                    bean.setMoise1(i == 1 ? rs.getString("moise_percent_count1") : Multiple_value(rs.getString("moise_percent_count1"), Bean_m_quality.getMoise_score1()));
                    bean.setMoise2(i == 1 ? rs.getString("moise_percent_count2") : Multiple_value(rs.getString("moise_percent_count2"), Bean_m_quality.getMoise_score2()));
                    bean.setMoise3(i == 1 ? rs.getString("moise_percent_count3") : Multiple_value(rs.getString("moise_percent_count3"), Bean_m_quality.getMoise_score3()));
                    bean.setMoise4(i == 1 ? rs.getString("moise_percent_count4") : Multiple_value(rs.getString("moise_percent_count4"), Bean_m_quality.getMoise_score4()));
                    bean.setContamination1(i == 1 ? rs.getString("contamination_percent_count1") : Multiple_value(rs.getString("contamination_percent_count1"), Bean_m_quality.getContamination_score1()));
                    bean.setContamination2(i == 1 ? rs.getString("contamination_percent_count2") : Multiple_value(rs.getString("contamination_percent_count2"), Bean_m_quality.getContamination_score2()));
                    bean.setContamination3(i == 1 ? rs.getString("contamination_percent_count3") : Multiple_value(rs.getString("contamination_percent_count3"), Bean_m_quality.getContamination_score3()));
                    bean.setContamination4(i == 1 ? rs.getString("contamination_percent_count4") : Multiple_value(rs.getString("contamination_percent_count4"), Bean_m_quality.getContamination_score4()));
                    ALobj_bean.add(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return ALobj_bean;
        }

    }
    //</editor-fold>
    //<editor-fold desc="ทำการดึงข้อมูลมาสเตอร์จากด้านคุณภาพ">

    public DataBeanM_quality_rawmatt_receive Return_M_quality_rawmatt(DataBeanM_quality_rawmatt_receive DataBean, Connection con, ResultSet rs) throws Exception {
        try {
            rs = con.createStatement().executeQuery("SELECT ashes_value1, ashes_value2, ashes_value3,ashes_value4,"
                    + "ashes_score1, ashes_score2, ashes_score3, ashes_score4, "
                    + "dust_value1, dust_value2, dust_value3, dust_value4,"
                    + "dust_score1, dust_score2, dust_score3, dust_score4,"
                    + "volatile_value1, volatile_value2,volatile_value3, volatile_value4,"
                    + "volatile_score1, volatile_score2, volatile_score3, volatile_score4,"
                    + "moise_value1, moise_value2, moise_value3, moise_value4,"
                    + "moise_score1, moise_score2, moise_score3, moise_score4, "
                    + "contamination_value1, contamination_value2, contamination_value3, contamination_value4,"
                    + "contamination_score1, contamination_score2, contamination_score3, contamination_score4  "
                    + "FROM m_quality_rawmatt_receive where quality_id = '" + DataBean.getQuality_id() + "' and delete_flag = 'N';");
            while (rs.next()) {
                DataBean.setAshes_value1(rs.getString("ashes_value1"));
                DataBean.setAshes_value2(rs.getString("ashes_value2"));
                DataBean.setAshes_value3(rs.getString("ashes_value3"));
                DataBean.setAshes_value4(rs.getString("ashes_value4"));
                DataBean.setAshes_score1(rs.getString("ashes_score1"));
                DataBean.setAshes_score2(rs.getString("ashes_score2"));
                DataBean.setAshes_score3(rs.getString("ashes_score3"));
                DataBean.setAshes_score4(rs.getString("ashes_score4"));
                DataBean.setDust_value1(rs.getString("dust_value1"));
                DataBean.setDust_value2(rs.getString("dust_value2"));
                DataBean.setDust_value3(rs.getString("dust_value3"));
                DataBean.setDust_value4(rs.getString("dust_value4"));
                DataBean.setDust_score1(rs.getString("dust_score1"));
                DataBean.setDust_score2(rs.getString("dust_score2"));
                DataBean.setDust_score3(rs.getString("dust_score3"));
                DataBean.setDust_score4(rs.getString("dust_score4"));
                DataBean.setVolatile_value1(rs.getString("volatile_value1"));
                DataBean.setVolatile_value2(rs.getString("volatile_value2"));
                DataBean.setVolatile_value3(rs.getString("volatile_value3"));
                DataBean.setVolatile_value4(rs.getString("volatile_value4"));
                DataBean.setVolatile_score1(rs.getString("volatile_score1"));
                DataBean.setVolatile_score2(rs.getString("volatile_score2"));
                DataBean.setVolatile_score3(rs.getString("volatile_score3"));
                DataBean.setVolatile_score4(rs.getString("volatile_score4"));
                DataBean.setMoise_value1(rs.getString("moise_value1"));
                DataBean.setMoise_value2(rs.getString("moise_value2"));
                DataBean.setMoise_value3(rs.getString("moise_value3"));
                DataBean.setMoise_value4(rs.getString("moise_value4"));
                DataBean.setMoise_score1(rs.getString("moise_score1"));
                DataBean.setMoise_score2(rs.getString("moise_score2"));
                DataBean.setMoise_score3(rs.getString("moise_score3"));
                DataBean.setMoise_score4(rs.getString("moise_score4"));
                DataBean.setContamination_value1(rs.getString("contamination_value1"));
                DataBean.setContamination_value2(rs.getString("contamination_value2"));
                DataBean.setContamination_value3(rs.getString("contamination_value3"));
                DataBean.setContamination_value4(rs.getString("contamination_value4"));
                DataBean.setContamination_score1(rs.getString("contamination_score1"));
                DataBean.setContamination_score2(rs.getString("contamination_score2"));
                DataBean.setContamination_score3(rs.getString("contamination_score3"));
                DataBean.setContamination_score4(rs.getString("contamination_score4"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            return DataBean;
        }
    }
    //</editor-fold>
    //<editor-fold desc="ทำการ insertHeader,Detail">

    public void insert(DataBeanD_quality_rawmatt_receive_rate_header objBean_header,
            ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail> ALBean_detail, Connection con, PreparedStatement p) throws Exception {
        try {
            p = con.prepareStatement("INSERT INTO d_quality_rawmatt_receive_rate_header("
                    + "doc_id, rate_text, product_id, supplier_id, m01, m02, "
                    + "m03, m04, m05, m06, m07, m08, m09, m10, m11, m12, m_total, year_text, "
                    + "car_in_weight, cut_weight, net_weight, ashes_total, dust_total, "
                    + "volatile_total, moise_total, contamination_total, dividend, denominator, "
                    + "quality_value, remark, assessor_id, approve_id,quality_id )"
                    + " VALUES ( ?, ?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?)");
            p.setString(1, objBean_header.getDoc_id());
            p.setString(2, objBean_header.getRate_text());
            p.setString(3, objBean_header.getProduct_id());
            p.setString(4, objBean_header.getSupplier_id());
            p.setString(5, objBean_header.getM01());
            p.setString(6, objBean_header.getM02());
            p.setString(7, objBean_header.getM03());
            p.setString(8, objBean_header.getM04());
            p.setString(9, objBean_header.getM05());
            p.setString(10, objBean_header.getM06());
            p.setString(11, objBean_header.getM07());
            p.setString(12, objBean_header.getM08());
            p.setString(13, objBean_header.getM09());
            p.setString(14, objBean_header.getM10());
            p.setString(15, objBean_header.getM11());
            p.setString(16, objBean_header.getM12());
            p.setString(17, objBean_header.getM_total());
            p.setString(18, objBean_header.getYear());
            p.setString(19, objBean_header.getCar_in_weight());
            p.setString(20, objBean_header.getCut_weight());
            p.setString(21, objBean_header.getNet_weight());
            p.setString(22, objBean_header.getAshes_total());
            p.setString(23, objBean_header.getDust_total());
            p.setString(24, objBean_header.getVolatile_total());
            p.setString(25, objBean_header.getMoise_total());
            p.setString(26, objBean_header.getContamination_total());
            p.setString(27, objBean_header.getDividend());
            p.setString(28, objBean_header.getDenominator());
            p.setString(29, objBean_header.getQuality_value());
            p.setString(30, objBean_header.getRemark());
            p.setString(31, objBean_header.getAssessor_id());
            p.setString(32, objBean_header.getApprove_id());
            p.setString(33, objBean_header.getQuality_id());
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("INSERT INTO d_quality_rawmatt_receive_rate_detail("
                    + "doc_id,line_no, ashes1, ashes2, ashes3, ashes4, "
                    + "dust1, dust2, dust3, dust4,"
                    + "volatile1, volatile2, volatile3, volatile4, "
                    + "moise1, moise2, moise3, moise4, "
                    + "contamination1, contamination2, contamination3, contamination4)"
                    + "VALUES ("
                    + "?,?, ?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?, ?, ?, "
                    + "?, ?, ?, ?, ?, ?, "
                    + "?, ?)");
            for (int i = 0; i < ALBean_detail.size(); i++) {
                p.setString(1, objBean_header.getDoc_id());
                p.setString(2, ALBean_detail.get(i).getLine_no());
                p.setString(3, ALBean_detail.get(i).getAshes1());
                p.setString(4, ALBean_detail.get(i).getAshes2());
                p.setString(5, ALBean_detail.get(i).getAshes3());
                p.setString(6, ALBean_detail.get(i).getAshes4());
                p.setString(7, ALBean_detail.get(i).getDust1());
                p.setString(8, ALBean_detail.get(i).getDust2());
                p.setString(9, ALBean_detail.get(i).getDust3());
                p.setString(10, ALBean_detail.get(i).getDust4());
                p.setString(11, ALBean_detail.get(i).getVolatile1());
                p.setString(12, ALBean_detail.get(i).getVolatile2());
                p.setString(13, ALBean_detail.get(i).getVolatile3());
                p.setString(14, ALBean_detail.get(i).getVolatile4());
                p.setString(15, ALBean_detail.get(i).getMoise1());
                p.setString(16, ALBean_detail.get(i).getMoise2());
                p.setString(17, ALBean_detail.get(i).getMoise3());
                p.setString(18, ALBean_detail.get(i).getMoise4());
                p.setString(19, ALBean_detail.get(i).getContamination1());
                p.setString(20, ALBean_detail.get(i).getContamination2());
                p.setString(21, ALBean_detail.get(i).getContamination3());
                p.setString(22, ALBean_detail.get(i).getContamination4());
                p.addBatch();
            }
            p.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.clearParameters();
            }
        }
    }
    //</editor-fold>
    //<editor-fold desc="ลบข้อมูล">

    public void delete(Connection con, PreparedStatement p, String doc_id) throws Exception {
        try {
            p = con.prepareStatement("DELETE FROM d_quality_rawmatt_receive_rate_header where doc_id = '" + doc_id + "'");
            p.executeUpdate();
            p.clearParameters();
            p = con.prepareStatement("DELETE FROM d_quality_rawmatt_receive_rate_detail where doc_id = '" + doc_id + "'");
            p.executeUpdate();
            p.clearParameters();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (p != null) {
                p.clearParameters();
            }
        }
    }
    //</editor-fold>

    public DataBeanD_quality_rawmatt_receive_rate_header Total_Quality_value(DataBeanD_quality_rawmatt_receive_rate_header Bean_header, ArrayList<DataBeanD_quality_rawmatt_receive_rate_detail> AL_bean) throws Exception {
        int select_value = AL_bean.size() - 1;
        double quality_value = 0.00;
        try {
            Bean_header.setAshes_total(Sum_value(AL_bean.get(select_value).getAshes1(), AL_bean.get(select_value).getAshes2(), AL_bean.get(select_value).getAshes3(), AL_bean.get(select_value).getAshes4(),"0"));
            Bean_header.setDust_total(Sum_value(AL_bean.get(select_value).getDust1(), AL_bean.get(select_value).getDust2(), AL_bean.get(select_value).getDust3(), AL_bean.get(select_value).getDust4(),"0"));
            Bean_header.setVolatile_total(Sum_value(AL_bean.get(select_value).getVolatile1(), AL_bean.get(select_value).getVolatile2(), AL_bean.get(select_value).getVolatile3(), AL_bean.get(select_value).getVolatile4(),"0"));
            Bean_header.setMoise_total(Sum_value(AL_bean.get(select_value).getMoise1(), AL_bean.get(select_value).getMoise2(), AL_bean.get(select_value).getMoise3(), AL_bean.get(select_value).getMoise4(),"0"));
            Bean_header.setContamination_total(Sum_value(AL_bean.get(select_value).getContamination1(), AL_bean.get(select_value).getContamination2(), AL_bean.get(select_value).getContamination3(), AL_bean.get(select_value).getContamination4(),"0"));
            Bean_header.setDividend(Sum_value(Bean_header.getAshes_total(), Bean_header.getDust_total(), Bean_header.getVolatile_total(), Bean_header.getMoise_total(),Bean_header.getContamination_total()));
            Bean_header.setDenominator(Multiple_value(Bean_header.getM_total(), "50"));
            Bean_header.setQuality_value(Double.toString((Integer.parseInt(Bean_header.getDividend()) / Integer.parseInt(Bean_header.getDenominator())) * 100));
            quality_value = Double.parseDouble(Bean_header.getQuality_value());
            Bean_header.setRemark(
                    quality_value < 50.00 ? "ต้องแก้ไข"
                    : quality_value >= 50.00 && quality_value <= 64.99 ? "พอใช้"
                    : quality_value >= 65.00 && quality_value <= 79.99 ? "ดี"
                    : "ดีมาก");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return Bean_header;
        }
    }

    public String Multiple_value(String quality_value, String score) {
        return Integer.toString((Integer.parseInt(quality_value, 10) * Integer.parseInt(score, 10)));
    }

    public String Sum_value(String value1, String value2, String value3, String value4,String value5) {
        return Integer.toString((Integer.parseInt(value1, 10) + Integer.parseInt(value2, 10) + Integer.parseInt(value3, 10) + Integer.parseInt(value4, 10) + Integer.parseInt(value5, 10)));
    }
}
