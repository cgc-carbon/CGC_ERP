<%@page import="com.cgc.bean.ProductPriceBean"%>
<%@page import="com.cgc.DB.ProductPriceDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    ProductPriceDAO ppDAO = new ProductPriceDAO();
    ProductPriceBean ppBean, selectPpBean;
    Timestamp ts;
    ThaiUtil tu;
    String pgroup_id,price_year,iodine ;
%>
<%
            tu = new ThaiUtil();
            ppBean = new ProductPriceBean();
            
            pgroup_id = request.getParameter("pgroup_id") ;
            price_year = request.getParameter("price_year") ;
            iodine = request.getParameter("iodine") ;
            
            ppBean.setPgroup_id(request.getParameter("pgroup_id"));
            ppBean.setPrice_year(request.getParameter("price_year"));
            ppBean.setIodine(request.getParameter("iodine"));
            ppBean.setPrice_month_1(request.getParameter("price_month_1"));
            ppBean.setPrice_month_2(request.getParameter("price_month_2"));
            ppBean.setPrice_month_3(request.getParameter("price_month_3"));
            ppBean.setPrice_month_4(request.getParameter("price_month_4"));
            ppBean.setPrice_month_5(request.getParameter("price_month_5"));
            ppBean.setPrice_month_6(request.getParameter("price_month_6"));
            ppBean.setPrice_month_7(request.getParameter("price_month_7"));
            ppBean.setPrice_month_8(request.getParameter("price_month_8"));
            ppBean.setPrice_month_9(request.getParameter("price_month_9"));
            ppBean.setPrice_month_10(request.getParameter("price_month_10"));
            ppBean.setPrice_month_11(request.getParameter("price_month_11"));
            ppBean.setPrice_month_12(request.getParameter("price_month_12"));            
            ts = new Timestamp(new java.util.Date().getTime());
            ppBean.setCreate_date(ts);
            ppBean.setUpdate_date(ts);
            
            System.out.println("Price Month 1 = " + request.getParameter("price_month_1"));
            System.out.println("chkstatus = " + request.getParameter("chkstatus"));
            
            if (request.getParameter("chkstatus") == null) {
                System.out.println("BSEL pgroup_id = " + pgroup_id);
                System.out.println("BSEL price_year = " + price_year);
                selectPpBean = ppDAO.selectData(pgroup_id,price_year,iodine);
                System.out.println("selectPpBean = " + selectPpBean);
                
                if (selectPpBean != null && selectPpBean.getDelete_flag().equals("N")) {
                    ppBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        ppDAO.update(ppBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (ppDAO.insert(ppBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                ppDAO.updateDel(ppBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>