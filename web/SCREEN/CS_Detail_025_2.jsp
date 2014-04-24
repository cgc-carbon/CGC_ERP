<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail_1"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_1DAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function get_balance(){
                var URL = "../JSP/CS_Detail_025_2.jsp?get_balance=4&doc_date="+getId('doc_date').value+"&shift="+(getId("shift").value == 8 ? "9" : "8");
                //alert(URL);
                //AjaxRun_id('balance_weight', URL);
            }
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,status_a','../JSP/CS_Detail_025_2.jsp'));
                    showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=")', 800);

                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,line_no,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,status_u','../JSP/CS_Detail_025_2.jsp'));
                    showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_DetailShow_025_2.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
                }
            }
            function goBack()
            {
                window.close();
            }
            
            function select(){
                select_value();                   
            }
            
        </script>
    </head>
    <body onLoad="select()" >
        <%!            ThaiUtil en = new ThaiUtil();
            D_carbon_friction_receive_detail_1DAO objDAO = new D_carbon_friction_receive_detail_1DAO();
            DataBeanD_carbon_friction_receive_detail_1 objBean = new DataBeanD_carbon_friction_receive_detail_1();
            String runno, doc_id, doc_date, line_no, product_id, friction_house, silo_no, location_id, balance_weight, remain_weight, status_a, status_u;
        %>
        <%
            doc_id = "";
            line_no = "";
            product_id = "";
            friction_house = "";
            silo_no = "";
            location_id = "";
            balance_weight = "0";
            remain_weight = "0";
            doc_date = request.getParameter("doc_date");
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no);
                product_id = objBean.getProduct_id();
                friction_house = objBean.getFriction_house();
                silo_no = objBean.getSilo_no();
                location_id = objBean.getLocation_id();
                balance_weight = objBean.getBalance_weight();
                remain_weight = objBean.getRemain_weight();
                doc_date = objBean.getDoc_date();
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
        <input type="hidden" id="chkNull" value="product_id,remain_weight">
        <input type="hidden" id="shift" value="<%=request.getParameter("shift")%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลถ่านได้&nbsp;</td>
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
                                <td class="columnlabel">ถ่าน*</td>
                                <td class="columnobject"><select name="product_id_select" id="product_id_select" onclick="click_value()">
                                        <option value="CF" selected>CF ถ่านกะลาที่สีแล้ว</option>
                                        <option value="UF">UF ถ่านยูคาฯที่สีแล้ว</option>
                                        <option value="KF">KF ถ่านไม้โกงกางที่สีแล้ว</option>
                                        <option value="PF">PF ถ่านปาล์มที่สีแล้ว</option>
                                        <option value="BF">BF ถ่านไม้ไผ่ที่สีแล้ว</option>
                                        <option value="C">C ถ่านกะลามะพร้าว</option>
                                        <option value="CB">CB ฝุ่นถ่านดิบ</option>
                                        <option value="CP">CP กะลาปาล์มดิบ</option>
                                        <option value="CU">CU กะลา+ยูคา</option>
                                        <option value="K">K ถ่านไม้โกงกาง</option>
                                        <option value="P">P ถ่านกะลาปาล์ม</option>
                                        <option value="PA">PA ปาล์มดิบ</option>
                                        <option value="U">U ถ่านยูคา</option>
                                        <option value="B">B ถ่านไม้ไผ่</option>
                                    </select>
                                    <input name='product_id' type='hidden' id="product_id" value='<%=product_id%>' size='10' /></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">โรงสี*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='friction_house' type='text' id="friction_house" value='<%=friction_house%>' size='10' />                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ไซโล*&nbsp;</td>
                                <td class="columnobject"><input type="text" name="silo_no" id="silo_no" value="<%=silo_no%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">กองที่</td>
                                <td class="columnobject"><input type="text" name="location_id" id="location_id" value="<%=location_id%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><input type="button" class="cgcButton_2" value="ยอดยกมา" id="get_balance" onclick="get_balance()"></td>
                                <td class="columnobject"><input type="text" name="balance_weight" id="balance_weight" value="<%=balance_weight%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ยอดคงเหลือ*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='remain_weight' type='text' id="remain_weight" value='<%=remain_weight%>' size='10'  onkeyup="IsNuber(this.value, this)"/>                                </td>
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