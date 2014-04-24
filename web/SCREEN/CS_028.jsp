<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_in_detail"%>
<%@page import="com.cgc.DB.D_carbon_burn_in_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function CalChang(){
                var ans;
                if(getId("weight_tot").value != "")
                    var num1 = parseFloat(getId("weight_tot").value);//(getId("weight_tot").value, 10);
                if(getId("weight_tank").value != "")
                    var num2 = parseFloat(getId("weight_tank").value);//(getId("weight_tank").value, 10);
                if(!isNaN(num1) && !isNaN(num2)){
                    if(num1<num2){
                        alert("ไม่สามารถทำการคำนวณได้กรุณากรอกข้อมูลใหม่");
                        getId("weight_tank").value ="";
                        getId("weight").value = "";
                    }
                    else{
                        ans = num1 - num2;
                        getId("weight").value = ans;
                    }
                }
            }
            function goAdd(){
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,line_no,tank_suite,product_id,location_id,silo_no,weight_tot,weight_tank,weight,status_a,username,channel,remark','../JSP/CS_028.jsp'));
                    opener.getId("doc_id").disabled = true;
                    opener.getId("child_ck").value = "1";
                    showTable("show","doc_id","../JSP/CS_Show028.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show028.jsp?doc_id=");',800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {                    
                    getSave(URLsend('doc_id,line_no,tank_suite,product_id,location_id,silo_no,weight_tot,weight_tank,weight,status_u,username,channel,remark','../JSP/CS_028.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show028.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show028.jsp?doc_id=");',800);                    
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
        <%!
            ThaiUtil en = new ThaiUtil();
            D_carbon_burn_in_detailDAO objDAO = new D_carbon_burn_in_detailDAO();
            DataBeanD_carbon_burn_in_detail objBean = new DataBeanD_carbon_burn_in_detail();
            String runno,doc_id, line_no, status_a, status_u, tank_suite,location_id, product_id, product_id_desc,silo_no, weight_tot, weight_tank, quantity, weight,total_weight,channel,remark;
            UtiDatabase objuti = new UtiDatabase();
        %>
        <%
                    doc_id = "";
                    line_no = "";
                    status_a = "";
                    status_u = "";
                    tank_suite= "";
                    location_id = "";
                    product_id = "";
                    product_id_desc = "";
                    weight_tot = "";
                    weight_tank = "";
                    quantity = "";
                    weight = "";
                    silo_no= "";
                    total_weight = "";
                    channel = "";
                    remark = "";
                    if (request.getQueryString().indexOf("line_no_") != -1) {
                        line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        runno = request.getQueryString().substring(request.getQueryString().indexOf("runno_") + 6, request.getQueryString().lastIndexOf("="));
                        objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
                        product_id = objBean.getProduct_id();
                        product_id_desc = objBean.getProd_name();
                        weight_tot = objBean.getWeight_tot();
                        weight_tank = objBean.getWeight_tank();
                        weight = objBean.getWeight();
                        tank_suite = objBean.getTank_suite();
                        location_id = objBean.getLocation_id();
                        silo_no = objBean.getSilo_no();
                        channel = objBean.getChannel();
                        remark = objBean.getRemark();
                        status_u = "2";
                        if(request.getParameter("total_weight")!=null)
                            total_weight = request.getParameter("total_weight");
                        
                    } else {
                        doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                        status_a = request.getParameter("status_a");
                        if(request.getParameter("total_weight")!=null)
                            total_weight = request.getParameter("total_weight");
                    }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="runno" value="<%=runno%>">
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="total_wightcal" value="<%=total_weight%>">
        <input type="hidden" id="weightedit" value="<%=weight%>">        
        <input type="hidden" id="chkNull" value="tank_suite,product_id,location_id,silo_no,weight_tot,weight_tank">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลถ่านเติมเตา&nbsp;</td>
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
                                <td class="columnlabel">เลขถัง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='tank_suite' type='text' id="tank_suite" value='<%=tank_suite%>' size='10' />                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel">ถ่าน*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='product_id' type='text' id="product_id" value='<%=product_id%>' size='10' readonly="readonly" />
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('mproduct&stadment=and+ptype_id+=+\'CF\'or+ptype_id+=+\'RAW\'', 35, '../JSP/Search_Config2.jsp');">
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input name='product_id_desc' type='text' id="product_id_desc" value='<%=product_id_desc%>' size='30' readonly="readonly" />                                
                                </td>
                            </tr>                            
                            
                            
                            <tr>
                              <td class="columnlabel">ช่องที่*</td>
                              <td class="columnobject"><span class="columnlabel">
                                      <input name="channel" type="text" id="channel" size="10" value="<%=channel%>">
                              </span></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เลขกอง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='location_id' type='text' id="location_id" value='<%=location_id%>' size='10' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ไซโล*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='silo_no' type='text' id="silo_no" value='<%=silo_no%>' size='10' readonly/>
                                    <a href='#' onClick="openBrWindow('Warehouse', 28, '../JSP/Search_Config2.jsp');" >
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>                              
                                    <input name='silo_desc' type='hidden' id="silo_desc" value='' size='30' />  </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนักถัง+ถ่าน*&nbsp;</td>
                                <td class="columnobject">

                                    <input name='weight_tot' type='text' id="weight_tot" onBlur="CalChang();" onKeyUp="IsNuber(this.value, this)" value='<%=weight_tot%>' size='10'/>                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนักถัง*&nbsp;</td>
                                <td class="columnobject">

                                    <input name='weight_tank' type='text' id="weight_tank"  onblur="CalChang()" onKeyUp="IsNuber(this.value, this)" value='<%=weight_tank%>' size='10'/>                                </td>
                            </tr>
                            <tr>
                              <td class="columnlabel">น้ำหนักถ่าน*</td>
                              <td class="columnobject"><input name='weight' type='text' id="weight"  value='<%=weight%>' size='10' readonly="readonly"/></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject"><textarea name="remark" id="remark" cols="45" rows="5"><%=remark%></textarea></td>
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
                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="goBack()"/>                                </td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>                                </td>
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