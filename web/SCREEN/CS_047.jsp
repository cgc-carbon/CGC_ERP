<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBeanD_rawmatt_analyze_detail"%>
<%@page import="com.cgc.DB.D_rawmatt_analyze_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Calculator.D_rawmatt_receive_Calculat" %>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<html>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script type="text/javascript">
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent,remark,status_a,username','../JSP/CS_047.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show047.jsp?doc_id=");
                    for(var i=0;i<=5;i++){
                        setTimeout('showTable("show","doc_id","../JSP/CS_Show047.jsp?doc_id=")',300);
                    }
                    setTimeout('window.close()', 800);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent,remark,line_no,status_u,username','../JSP/CS_047.jsp'));
                    //showTable('opener.getId("show")', 'opener.getId("doc_id")', 'JSP/CS_Show024.jsp');
                    opener.getId("doc_id").disabled = true;
                    for(var i=0;i<=5;i++){
                        setTimeout('showTable("show","doc_id","../JSP/CS_Show047.jsp?doc_id=")',300);
                    }
                    //window.close();
                    setTimeout('window.close()', 800);
                }
            }
            function goBack()
            {
                window.close();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">    
        <title>Insert title here</title>
    </head>
    <body>
        <%!        UtiDatabase objuti;
            D_rawmatt_receive_Calculat objcalweight;
            ThaiUtil en = new ThaiUtil();
            D_rawmatt_analyze_detailDAO objDAO = new D_rawmatt_analyze_detailDAO();
            DataBeanD_rawmatt_analyze_detail objBean = new DataBeanD_rawmatt_analyze_detail();
            String doc_id, weight, line_no, moisture_percent, ashes_percent, dust_percent, volatile_percent, mixed_percent, remark, status_u, status_a, doc_date, SQL;
        %>
        <%
                    SQL = "Select Count(doc_id) As num from  vd_rawmatt_receive where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and complete_flag <> 'Y'";
                    objcalweight = new D_rawmatt_receive_Calculat();
                    objuti = new UtiDatabase();
                    if (objuti.numRowdatabase(SQL) != 0) {
                        doc_id = "";
                        moisture_percent = "";
                        ashes_percent = "";
                        dust_percent = "";
                        line_no = "";
                        volatile_percent = "";
                        status_u = "";
                        mixed_percent = "";
                        remark = "";
                        status_a = "";
                        weight = "";
                        if (request.getQueryString().indexOf("line_no_") != -1) {
                            line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                            objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                            moisture_percent = objBean.getMoisture_percent();
                            ashes_percent = objBean.getAshes_percent();
                            doc_date = objBean.getDoc_date();
                            dust_percent = objBean.getDust_percent();
                            volatile_percent = objBean.getVolatile_percent();
                            mixed_percent = objBean.getMixed_percent();
                            remark = objBean.getRemark();
                            weight = objBean.getWeight();
                            status_u = "2";
                        } else if (request.getParameter("status_a") != null && objuti.numRowdatabase("Select Count(*) As num from  d_rawmatt_analyze_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y'") > 0) {
                            //line_no = "1";
                            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                            objBean = objDAO.ReturnEdit(doc_id, "1", objBean);
                            moisture_percent = "0";//objBean.getMoisture_percent();
                            ashes_percent = "0";
                            doc_date = objBean.getDoc_date();
                            dust_percent = "0";
                            volatile_percent = "0";
                            mixed_percent = "0";
                            remark = "";
                            weight = "0";
                            //status_u = "2";
                            status_a = request.getParameter("status_a");
                        } else {
                            weight = objcalweight.Weight_Calculat(en.EncodeTexttoTIS(request.getParameter("doc_id")));
                            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                            doc_date = request.getParameter("doc_date");
                            status_a = request.getParameter("status_a");
                        }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">�š����������&nbsp;</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="left">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">���˹ѡ (Kg.)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight'  type='text' id="weight" value='<%=weight%>' size='10' readonly="readonly"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">������� (%)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='moisture_percent' type='text' id="moisture_percent" value='<%=moisture_percent%>' size='10' onKeyUp="IsNumeric(this.value, this)" />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">������ (%)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='ashes_percent' type='text' id="ashes_percent" value='<%=ashes_percent%>' size='10' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">��� (%)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='dust_percent' type='text' id="dust_percent" value='<%=dust_percent%>' size='10' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">�������� (%)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='volatile_percent' type='text' id="volatile_percent" value='<%=volatile_percent%>' size='10' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">�����ͻ� (%)*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='mixed_percent' type='text' id="mixed_percent" value='<%=mixed_percent%>' size='10' onKeyUp="IsNumeric(this.value, this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">�����˵�&nbsp;</td>
                          <td class="columnobject">
                                    <textarea name='remark' cols='40' rows='5' id="remark"  ><%=remark%></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                                            if (status_a != "") {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="��ŧ" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="���" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>

                                    <input type="button" class="cgcButton_5" name="button2" value="¡��ԡ" onClick="javascript:goBack();"/>
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
    <%} else {%>
    <table  cellpadding="0"  cellspacing="0" align="center">
        <tr >
            <td class="ftopleft"></td>
            <td  class="ftopcenter" colspan="2">�š����������&nbsp;</td>
            <td class="ftopright"></td>
        </tr>
        <tr >
            <td class="fcenterleft"></td>
            <td  colspan="2" class="fcentercenter">
                <div align="left">
                    <table  cellpadding="0" cellspacing="0" >
                        <tr>
                            <td colspan="2"  class="blankspace"></td>
                        </tr>
                        <tr>
                        <br>
                        <br>
                        <div align="center"><a href="#" onClick="javascript:window.close();">������Ţ���㺪�駶�ҹ��سҵ�Ǩ�ͺ�Ţ���㺪�觶�ҹ�ա����</a></div>
                        <br>
                        <br>
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
    <%}
    %>
</html>