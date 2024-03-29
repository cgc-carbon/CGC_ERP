<%@page import="com.cgc.bean.DataBeanD_rawmatt_withdraw_detail"%>
<%@page import="com.cgc.DB.D_rawmatt_withdraw_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
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
                    getSave(URLsend('doc_id,product_id,location_id,car_no,cust_id,quantity,wh_in,weight,status_a,username,supplier_id','../JSP/CS_024.jsp'));
                    opener.getId("child_ck").value = "1";
                    showTable("show","doc_id","../JSP/CS_Show024.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show024.jsp?doc_id=");', 800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,product_id,location_id,car_no,cust_id,quantity,wh_in,weight,line_no,runno,status_u,username,supplier_id','../JSP/CS_024.jsp'));
                    //opener.getId("doc_id").disabled = true;
                    showTable("show","doc_id","../JSP/CS_Show024.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_Show024.jsp?doc_id=");', 800);
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
    <body onLoad="select_value()">
        <%!            ThaiUtil en = new ThaiUtil();
            UtiDatabase objuti = new UtiDatabase();
            D_rawmatt_withdraw_detailDAO objDAO = new D_rawmatt_withdraw_detailDAO();
            DataBeanD_rawmatt_withdraw_detail objBean = new DataBeanD_rawmatt_withdraw_detail();
            String runno, car_no, doc_id, wh_in, line_no, status_a, status_u, location_id, product_id, cust_id, cust_id_desc, quantity, weight, supplier_id, supplier_name;
        %>
        <%
            doc_id = "";
            line_no = "";
            status_a = "";
            status_u = "";
            location_id = "";
            product_id = "C";
            //product_id_desc = "";
            cust_id = "";
            cust_id_desc = "";
            quantity = "";
            weight = "";
            wh_in = "";
            car_no = "";
            supplier_id = "";
            supplier_name = "";
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                runno = request.getQueryString().substring(request.getQueryString().indexOf("runno_") + 6, request.getQueryString().lastIndexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(runno, objBean);
                location_id = objBean.getLocation_id();
                product_id = objBean.getProduct_id();
                //product_id_desc = objBean.getProduct_name();
                cust_id = objBean.getCust_id();
                cust_id_desc = objBean.getCust_name();
                quantity = objBean.getQuantity();
                weight = objBean.getWeight();
                wh_in = objBean.getWh_in();
                car_no = objBean.getCar_no();
                status_u = "2";
                supplier_id = objBean.getSupplier_id();
                supplier_name = objBean.getSupplier_name();
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                status_a = request.getParameter("status_a");
                wh_in = request.getParameter("wh_in");
            }
        %>
        <input type="hidden" id="wh_in" value ="<%=wh_in%>">
        <input type="hidden" id="runno" value="<%=runno%>">
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="product_id,location_id,quantity,weight,supplier_id">
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td class="ftopcenter" colspan="2">ข้อมูลการเบิก&nbsp;</td>                
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
                                <td class="columnlabel">ชนิดถ่าน*</td>
                                <td class="columnobject"><select name="product_id_select" id="product_id_select" onclick="click_value()"> 
                                        <option value="C" selected>C ถ่านกะลามะพร้าว</option>
                                        <option value="CB">CB ฝุ่นถ่านดิบ</option>
                                        <option value="CP">CP กะลาปาล์มดิบ</option>                                        
                                        <option value="CU">CU กะลา+ยูคา</option>
                                        <option value="K">K ถ่านไม้โกงกาง</option>
                                        <option value="P">P ถ่านกะลาปาล์ม</option>
                                        <option value="PA">PA ปาล์มดิบ</option>
                                        <option value="U">U ถ่านยูคา</option>
                                        <option value="B">B ถ่านไม้ไผ่</option>
                                        <option value="CF">CF ถ่านกะลาที่สีแล้ว</option>
                                        <option value="UF">UF ถ่านยูคาฯที่สีแล้ว</option>
                                        <option value="KF">KF ถ่านไม้โกงกางที่สีแล้ว</option>
                                        <option value="PF">PF ถ่านปาล์มที่สีแล้ว</option>
                                        <option value="BF">BF ถ่านไม้ไผ่ที่สีแล้ว</option>
                                    </select>
                                    <input name='product_id' type='hidden' id="product_id" value='<%=product_id%>' size='10' /></td>
                            </tr>                            

                            <tr>
                                <td class="columnlabel">เลขกอง*&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='location_id' size='10' value='<%=location_id%>' id="location_id"/>                                </td>
                            </tr>

                            <input type='hidden' name='cust_id' size='10' value='<%=cust_id%>' id="cust_id"/>


                            <tr>
                                <td class="columnlabel">ชื่อSupplier*</td>
                                <td class="columnobject"><input type='text' name='supplier_id' size='10' value='<%=supplier_id%>' id="supplier_id" readonly="readonly"/>
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('msupplier', 24, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE2' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' name='supplier_id_desc' size='30' value='<%=supplier_name%>' id="supplier_id_desc" readonly="readonly"/>
                                    &nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ทะเบียนรถ&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='car_no' size='10' value='<%=car_no%>' id="car_no"/>                                </td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel">จำนวน (กระสอบ)*&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='quantity' size='10' value='<%=quantity%>' id="quantity" onKeyUp="IsNuber(this.value, this)"/>                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนัก (Kg)*&nbsp;</td>
                                <td class="columnobject">
                                    <input type='text' name='weight' size='10' value='<%=weight%>' id="weight" onKeyUp="IsNuber(this.value, this)" />                                </td>
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

                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>                                </td>
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
