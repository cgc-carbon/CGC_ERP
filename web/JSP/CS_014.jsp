<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.EmpDAO"%>
<%@page import="com.cgc.bean.EmpBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    EmpDAO empDAO = new EmpDAO();
    EmpBean empBean, selectEmpBean;
    Timestamp ts;
    String name, id, rm, lname, status, empId;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            empId = (String) request.getParameter("emp_id");
            name = (String) request.getParameter("name");
            lname = (String) request.getParameter("lname");
            id = (String) request.getParameter("dept_id");
            status = (String) request.getParameter("status");
            if (status.equals("1")) {
                status = "N";
            } else {
                status = "Y";
            }
            rm = (String) request.getParameter("remark_emp");
            empBean = new EmpBean();
            empBean.setEmp_id(empId);
            empBean.setFname(tu.EncodeTexttoTIS(name));
            empBean.setLname(tu.EncodeTexttoTIS(lname));
            empBean.setDept_id(id);
            empBean.setRemark(tu.EncodeTexttoTIS(rm));
            empBean.setStatus(status);
            ts = new Timestamp(new java.util.Date().getTime());
            empBean.setCreate_date(ts);
            
            if (request.getParameter("chkstatus") == null) {
                selectEmpBean = empDAO.selectData(empId);
                if (selectEmpBean != null && selectEmpBean.getDelete_flag().equals("N")) {
                    empBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        empDAO.update(empBean);
                        empDAO.update_MADB(empBean);
                        
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (empDAO.insert(empBean) && empDAO.insert_MADB(empBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                empDAO.updateDel(empBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>