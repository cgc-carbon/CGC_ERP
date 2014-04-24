<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_receive_detail_2"%>
<%@page import="com.cgc.DB.D_carbon_friction_receive_detail_2DAO"%>
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
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,product_id,bag_no,location_id,wh_in,bag,amount,weight,status_a','../JSP/CS_Detail_025_3.jsp'));
                    showTable("show3","doc_id","../JSP/CS_DetailShow_025_3.jsp?doc_id=");
                    setTimeout('showTable("show3","doc_id","../JSP/CS_DetailShow_025_3.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,product_id,location_id,wh_in,bag,amount,weight,status_u,line_no,bag_no','../JSP/CS_Detail_025_3.jsp'));
                    showTable("show3","doc_id","../JSP/CS_DetailShow_025_3.jsp?doc_id=");
                    setTimeout('showTable("show3","doc_id","../JSP/CS_DetailShow_025_3.jsp?doc_id=")', 800);
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
            D_carbon_friction_receive_detail_2DAO objDAO = new D_carbon_friction_receive_detail_2DAO();
            DataBeanD_carbon_friction_receive_detail_2 objBean = new DataBeanD_carbon_friction_receive_detail_2();
            String doc_id,doc_date,line_no, product_id, bag_no, location_id, amount_bag, weight, total_weight, wh_in, status_a, status_u;
        %>
        <%
            doc_id = "";
            line_no = "";
            status_a = "";
            status_u = "";
            product_id = "C";
            bag_no = "0";
            location_id = "";
            amount_bag = "0";
            weight = "0";
            total_weight = "0";
            wh_in = "";
            doc_date = request.getParameter("doc_date"); 
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no);
                product_id = objBean.getProduct_id();
                bag_no = objBean.getBag_no();
                location_id = objBean.getLocation_id();
                amount_bag = objBean.getAmount_bag();
                weight = objBean.getWeight();
                total_weight = objBean.getTotal_weight();
                wh_in = objBean.getWh_in();
                doc_date =objBean.getDoc_date();
                status_u = "2";
            } else {
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                status_a = request.getParameter("status_a");
            }
        %>
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="chkNull" value="product_id">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลบรรจุถ่านวัตถุดิบจากไซโลใส่ถุงจัมโบ้&nbsp;</td>
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
                                <td class="columnlabel">ถุงที่&nbsp;</td>
                                <td class="columnobject">
                                    <input type="text" name="bag_no" id="bag_no" value="<%=bag_no%>"></td>
                            </tr>                            
                            <tr>
                                <td class="columnlabel">เลขกอง*&nbsp;</td>
                                <td class="columnobject"><input name='location_id' type='text' id="location_id" value='<%=location_id%>' size='10' />
                                </td>
                            </tr>
                            
                            <!--tr>
                                <td class="columnlabel">สถานที่เก็บ</td>
                                <td class="columnobject"><input type="text" name="wh_in" id="wh_in" value="<%=wh_in%>"></td>
                            </tr--> 
                            
                            <tr>
                                <td class="columnlabel">สถานที่เก็บ&nbsp;</td>
                                <td colspan="3" class="columnobject">
                                    <input name='wh_in' type='text' id="wh_in" value='<%=wh_in%>' size='10' readonly="readonly"/>                                        
                                    <a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'R\'', 22, '../JSP/Search_Config2.jsp');" >
                                        <img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' >
                                    </a>
                                    <input name='wh_in' type='hidden' id="wh_name" value='' size='10' readonly="readonly"/> 
                                </td>
                            </tr>                               
                            
                            <tr>
                                <td class="columnlabel">น้ำหนักบรรจุ</td>
                                <td class="columnobject"><input type="text" name="bag" id="bag" value="<%=amount_bag%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <!--tr>
                                <td class="columnlabel">จำนวนถุง</td>
                                <td class="columnobject"--><input type="hidden" name="amount" id="amount" value="<%=weight%>" onkeyup="IsNuber(this.value, this)"><!--/td>
                            </tr-->
                            <tr>
                                <td class="columnlabel">น้ำหนักรวม*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight' type='text' id="weight" value='<%=total_weight%>' size='10' onkeyup="IsNuber(this.value, this)"/>                                </td>
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