<%@page import="com.cgc.DB.D_adjust_product_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_adjust_product_detail"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_adjust_product_detail objdb = new DataBeanD_adjust_product_detail();
    D_adjust_product_detailDAO objex = new D_adjust_product_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_product_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_adjust_product_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                    objdb.setLine_no(Integer.toString(statusnum + 1));
                }
            } else if (request.getParameter("status_u") != null) {
                statusck = 2;
                objdb.setLine_no(request.getParameter("line_no"));

            } else if (request.getParameter("status_d") != null) {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            } else {
                statusck = -1;
            }
            if (request.getParameter("doc_id") != null) {
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            }
            if (request.getParameter("product_id") != null) {
                objdb.setProduct_id(en.EncodeTexttoTIS(request.getParameter("product_id")));

            }
            if (request.getParameter("location_id") != null) {
                objdb.setLocation_id(en.EncodeTexttoTIS(request.getParameter("location_id")));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(request.getParameter("weight"));

            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            if (request.getParameter("username") != null) {
                objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            }
            switch (statusck) {
                case -1:
                    out.print("�������ö�ѹ�֡�����Ź�������ͧ�ҡ���Ţ����͡��÷������ó�����");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("�ѹ�֡�����");
                    } else {
                        out.print("�������ö�ѹ�֡��");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("��������");
                    } else {
                        out.print("�������ö�ѹ�֡��");
                    }
                    break;
                case 3:

                    if (request.getParameter("chk_all") != null) {
                        objex.Delete_line_no_All(objdb);
                    } else {
                        objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>