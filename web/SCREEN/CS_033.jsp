<%@page import="com.cgc.bean.DataBeanD_job_order_detail"%>
<%@page import="com.cgc.DB.D_job_order_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">

            function goAdd()
            {
                //
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,param,method,spec,add_desc,status_a,username','../JSP/CS_033.jsp'));
                    opener.getId("child_ck").value = "1";
                    //opener.getId("doc_id").disabled = true;
                    showTable("show2","doc_id","../JSP/CS_Show033.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show033.jsp?doc_id=")',800);
                       
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,line_no,param,method,spec,add_desc,status_u,username','../JSP/CS_033.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    /*for(var i=0;i<=5;i++){
                       showTable("show","doc_id","../JSP/CS_Show032.jsp?doc_id=");
                        showTable("show2","doc_id","../JSP/CS_Show033.jsp?doc_id=");
                    }*/
                    showTable("show","doc_id","../JSP/CS_Show032.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show032.jsp?doc_id=")',800);
                    showTable("show2","doc_id","../JSP/CS_Show033.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show033.jsp?doc_id=")',800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%!            ThaiUtil en = new ThaiUtil();
            D_job_order_detailDAO objDAO = new D_job_order_detailDAO();
            DataBeanD_job_order_detail objBean = new DataBeanD_job_order_detail();
            String doc_id, param, line_no, status_a, status_u, method, spec, add_desc;
        %>
        <%
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    param = "";
                    method = "";
                    spec = "";
                    add_desc = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        param = objBean.getParam();
                        method = objBean.getMethod();
                        spec = objBean.getSpec();
                        add_desc = objBean.getAdd_desc();
                        status_u = "2";
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        status_a = request.getParameter("status_a");
                    }

        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="param,method">

        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลการผลิต&nbsp;</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="center">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">Parameter*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='param' type='text' id="param" value='<%=param%>' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">Test Method*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='method' type='text' id="method" value='<%=method%>' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">Specification&nbsp;</td>
                                <td class="columnobject">
                                    <input name='spec' type='text' id="spec" value='<%=spec%>' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เพิ่มเติม&nbsp;</td>
                                <td class="columnobject">
                                    <input name='add_desc' type='text' id="add_desc" value='<%=add_desc%>' size='30' />
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                                if (request.getParameter("status_a") != null) {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>
                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                </td>
                            </tr>
                        </table>
                    </div></td>
                <td class="fcenterright"></td>
            </tr>
            <tr bordercolor="0069B3">
                <td class="ffootleft"></td>
                <td  class="ffootcenter" colspan="2"></td>
                <td class="ffootright"></td>
            </tr>
        </table>

    </body>
</html>

