<%@page import="com.cgc.bean.DataBeanD_packing_product_detail_prod"%>
<%@page import="com.cgc.DB.D_packing_product_detail_prod_whDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">

        </script>
        <script type="text/javascript">
            function goAdd(){
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    /*var cal;
                            var num1 =0;
                            if(getId("total_wightcal").value != ""){
                            var num1 = parseInt(getId("total_wightcal").value, 10);
                            }
                            var num2 = parseInt(getId("weight").value, 10);
                            cal = num1+num2;
                            senddataPopup("total_weight").value = cal;
                            if(getId("bag_weightcal").value != ""){
                            var num1 = parseInt(getId("bag_weightcal").value, 10);
                            }
                            var num2 = parseInt(getId("bag").value, 10);
                            cal = num1+num2;
                            senddataPopup("total_bag").value = cal;*/
                    getSave(URLsend('doc_id,wh_id,product_id,size,i2,bag,weight,remark,status_a,username,product_no,weight_unit','../JSP/CS_308.jsp'));
                    showTable("show2","doc_id","../JSP/CS_Show308.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show308.jsp?doc_id=")',800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goEdit()
            {

                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    //alert(message)
                    //var cal;
                    /*var total_weightcal=0
                            var bag_weightcal = 0;
                            if(getId("total_wightcal").value != ""){
                                total_weightcal = parseInt(getId("total_wightcal").value, 10);
                            }
                            if(getId("bag_weightcal").value != ""){
                                bag_weightcal = parseInt(getId("bag_weightcal").value, 10);
                            }
                            var weightedit = parseInt(getId("weightedit").value, 10);
                            var bagedit = parseInt(getId("bagedit").value, 10);
                            senddataPopup("total_weight").value = CalEdit(total_weightcal,weightedit,"weight");
                            senddataPopup("total_bag").value = CalEdit(bag_weightcal, bagedit, "bag");*/
                    getSave(URLsend('doc_id,line_no,wh_id,product_id,size,i2,bag,weight,remark,status_u,username,product_no,weight_unit','../JSP/CS_308.jsp'));
                    showTable("show2","doc_id","../JSP/CS_Show308.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show308.jsp?doc_id=")',800);
                    setTimeout('window.close()', 1000);
                }
            }
            function goBack()
            {
                window.close();
            }
            function  CalEdit(total_cal,weightedit,weightnew)
            {
                var cal;
                cal = total_cal-weightedit;
                cal = cal+parseInt(getId(weightnew).value, 10, 10);
                return cal;
            }

            function select(){
                select_value();      
                getId("pack_repacking_status").checked = (getId("pack_repacking_status").value == "Y")?true:false;
                getId("carbon_trap_status").checked = (getId("carbon_trap_status").value == "Y")?true:false;
            }            
            function Chk_insert_value(checkbox_name){
                if(getId(checkbox_name).checked){
                    getId(checkbox_name).value = "Y";
                    //getId(text_name).disabled = false;
                }else{
                    getId(checkbox_name).value = "N";
                    //getId(text_name).disabled = true;
                    //getId(text_name).value = "";
                }
            }  

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
    </head><%!    ThaiUtil en = new ThaiUtil();
        D_packing_product_detail_prod_whDAO objDAO = new D_packing_product_detail_prod_whDAO();
        DataBeanD_packing_product_detail_prod objBean = new DataBeanD_packing_product_detail_prod();
        String doc_id, line_no, status_a, status_u, wh_id, product_id, size, i2, bag, weight, remark, total_bag, total_weight, weight_unit, product_no, size_name, wh_id_desc, pack_repacking_status, carbon_trap_status;
    %>
    <%
        doc_id = "";
        line_no = "";
        status_a = "";
        status_u = "";
        wh_id = "";
        product_id = "";
        size = "";
        bag = "";
        i2 = "";
        weight = "";
        remark = "";
        total_bag = "";
        total_weight = "";
        weight_unit = "";
        product_no = "";
        size_name = "";
        wh_id_desc = "";
        pack_repacking_status = "";
        carbon_trap_status = "";
        if (request.getQueryString().indexOf("line_no_") != -1) {
            line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
            wh_id = objBean.getWh_id();
            product_id = objBean.getProduct_id();
            size = objBean.getSize();
            bag = objBean.getBag();
            i2 = objBean.getI2();
            weight = objBean.getWeight();
            remark = objBean.getRemark();
            total_bag = request.getParameter("total_bag");
            total_weight = request.getParameter("total_weight");
            weight_unit = objBean.getWeight_unit();
            product_no = objBean.getProduct_no();
            size_name = objBean.getSize_name();
            wh_id_desc = objBean.getWh_name();
            pack_repacking_status = objBean.getPack_repacking_status();
            carbon_trap_status = objBean.getCarbon_trap_status();
            status_u = "2";
        } else {
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            status_a = request.getParameter("status_a");
            total_bag = request.getParameter("total_bag");
            total_weight = request.getParameter("total_weight");
        }
    %>
    <body onLoad="select()">
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="total_wightcal" value="<%=total_weight%>">
        <input type="hidden" id="bag_weightcal" value="<%=total_bag%>">
        <input type="hidden" id="weightedit" value="<%=weight%>">
        <input type="hidden" id="bagedit" value="<%=bag%>">
        <input type="hidden" id="chkNull" value="wh_id,product_id,size,bag,weight">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ถ่านได้&nbsp;</td>
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
                                <td class="columnlabel">รหัสคลัง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='wh_id' type='text' id="wh_id" value='<%=wh_id%>' size='10' readonly/>
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('Mwarehouse', 44, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_id_desc' type='text' id="wh_id_desc" value='<%=wh_id_desc%>' size='30' readonly/>	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสผลิต*</td>
                                <td class="columnobject"><input name="product_no" type="text" id="product_no" size="25" value="<%=product_no%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสสินค้า*&nbsp;</td>
                                <td class="columnobject">
                                    <select name="product_id_select" id="product_id_select" onclick="click_value()">
                                        <option value="C" selected>ถ่านกะลา</option>
                                        <option value="P">ถ่านปาล์ม</option>
                                        <option value="U">ถ่านไม้ยูคาฯ</option>
                                        <option value="D">ฝุ่น</option>
                                        <option value="K">ถ่านไม้โกงกาง</option>
                                    </select>
                                    <input type='hidden' name='product_id' size='10' value='<%=product_id%>' id="product_id" />
                                </td>        
                            </tr>
                            <tr>
                                <td class="columnlabel">ขนาด*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='size' type='text' id="size" value='<%=size%>' size='10' readonly/>	 &nbsp;<a href='#' onClick="javascript:openBrWindow('m_carbon_size', 44, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name="size_desc" type="text" id="size_desc" size="30" value="<%=size_name%>" readonly></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">I2&nbsp;</td>
                                <td class="columnobject">
                                    <input name='i2' type='text' id="i2" value='<%=i2%>' size='10' readonly/><a href='#' onclick="openBrWindow('m_iodine&stadment=and+iod_ctype+=+\''+getId('product_id_select').value+'\'&textinput=i2', 0, '../JSP/Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">จำนวนถุง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='bag' type='text' id="bag" value='<%=bag%>' size='10' onblur="IsNuber(this.value, this)"/>	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนัก*</td>
                                <td class="columnobject"><input name='weight' type='text' id="weight" value='<%=weight%>' size='10' onblur="IsNuber(this.value, this)"/>
                                    &nbsp;(กิโลกรัม) </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนัก/หน่วย</td>
                                <td class="columnobject"><input name="weight_unit" type="text" id="weight_unit" size="10" value="<%=weight_unit%>" onblur="IsNuber(this.value, this)">
                                    &nbsp;(กิโลกรัม) </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">แก้ไข Repack (บรรจุ)&nbsp;</td>
                                <td class="columnobject">
                                    <input name="pack_repacking_status" type="checkbox" id="pack_repacking_status" value="<%=pack_repacking_status%>" onClick="Chk_insert_value(this.name)" disabled="disabled">
                                </td>                                              
                            </tr>
                            <tr>
                                <td class="columnlabel">ถ่านดักได้&nbsp;</td>
                                <td class="columnobject">
                                    <input name="carbon_trap_status" type="checkbox" id="carbon_trap_status" value="<%=carbon_trap_status%>" onClick="Chk_insert_value(this.name)" disabled="disabled">
                                </td>                                              
                            </tr>                               
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject">
                                    <textarea name='remark' cols='40' rows='5' id="remark"><%=remark%></textarea>	          	</td>
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
                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>      		  	</td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>      		  	</td>
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