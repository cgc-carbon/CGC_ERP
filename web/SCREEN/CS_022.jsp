<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
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
            function ckvalue()
            {
                document.getElementById("Type").value = document.getElementById("type_prod").value;
                //document.getElementById("Type").value = document.getElementById("type_prod").options[document.getElementById("type_prod").selectedIndex].text;
            }
            function add()
            {
                if (getId("select_mbranch").value == "not") {
                    alert("กรุณาเลือกสถานที่ชำระเงิน");
                } else {
                    getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                    confirmDialogSave(URLsend('chkNull,doc_id,doc_date,wh_in,wh_name,supplier_id,position_no,scale_no,car_no,driver_name,type_prod,product_id,total_weight,bag_total,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,username,car_date_in,bag_total,ashes_percent_ch,ashes_weight_ch,dust_percent_ch,dust_weight_ch,volatile_percent_ch,volatile_weight_ch,moise_percent_ch,moise_weight_ch,contamination_percent_ch,contamination_weight_ch,net_weight_ch,bag_weight,car_cbag_weight,car_weight,bag_net,carbon_net,select_mbranch,price_unit,lab_not_check', '../JSP/CS_022.jsp'));
                }
            }
            function cancle()
            {
                //ResetParameter('doc_id,doc_date,wh_in,wh_name,supplier_id,supplier_id_desc,sup_tel_desc,sup_address_desc,position_no,scale_no,car_no,driver_name,type_prod,product_id,product_id_desc,total_weight,bag_weight,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,total_price,username');
                cancelAction();
            }
            function Openproduct()
            {
                openBrWindow('Vproduct&stadment=and+pgroup_id+=+\'G001\'', 22, '../JSP/Search_Config2.jsp');
            }
            function Opendoc_id(input)
            {
                switch (input) {
                    case 1:
                        if (getId("select_mbranch").value == "not")
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'N\'', 22, '../JSP/Search_Config2.jsp');
                        else
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'N\'+and+location_id2+=+\'' + getId("select_mbranch").value + '\'', 22, '../JSP/Search_Config2.jsp');
                        break;
                    case 2:
                        if (getId("select_mbranch").value == "not")
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'', 22, '../JSP/Search_Config2.jsp');
                        else
                            openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+=+\'Y\'+and+location_id2+=+\'' + getId("select_mbranch").value + '\'', 22, '../JSP/Search_Config2.jsp');
                        break;
                    default:
                        break;
                }
                //openBrWindow('Vd_rawmatt_receive&stadment=and+complete_flag+<>+\'Y\'', 22, '../JSP/Search_Config2.jsp');
            }
            /*function Calcultor()
             {
             var URL = "../JSP/CS_022.jsp?scale_no="+getId("scale_no").value+"&product_id="+getId("product_id").value+"&status_cal="+getId("status_cal").value;
             getData_d_rawmatt_receive(URL,'ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent,ashes_weight,dust_weight,volatile_weight,moise_weight,contamination_weight,net_weight,remark');
             }*/
            function check_percent(input, input_ch) {
                var output = parseFloat(getId(input).value) - parseFloat(getId(input_ch).value);
                if (output >= 0) {
                    return true;
                }
                else {
                    return false;
                }
            }
            function Calculator_ch(input, input_ch, input_wight_ch, total_weight, bag_weight) {
                var output_weight = parseFloat(getId(total_weight).value) - (parseFloat(getId(bag_weight).value) * parseFloat(getId("bag_total").value));
                if (check_percent(input, input_ch)) {
                    var output_percent = parseFloat(getId(input).value) - parseFloat(getId(input_ch).value);
                    output_weight = output_weight * (output_percent / 100);
                    getId(input_wight_ch).value = output_weight.toFixed(2);
                } else {

                    getId(input_wight_ch).value = "0.00";
                }
                calTotal_wight_ch();
            }

            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function calTotal_wight_ch() {
                var output_weight = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                if (getId("ashes_percent_ch").value != "" && getId("dust_percent_ch").value != "" && getId("volatile_percent_ch").value != "" && getId("moise_percent_ch").value != "" && getId("contamination_percent_ch").value != "") {
                    var lose_wight = parseFloat(getId("ashes_weight_ch").value) + parseFloat(getId("dust_weight_ch").value) + parseFloat(getId("volatile_weight_ch").value) + parseFloat(getId("moise_weight_ch").value) + parseFloat(getId("contamination_weight_ch").value);
                    var output_weight = output_weight - lose_wight;
                    getId("net_weight_ch").value = output_weight.toFixed(2);
                }
                else {
                    getId("net_weight_ch").value = "";
                }
            }
            function cal_total_weight() {
                if (isNaN((parseFloat(getId("car_cbag_weight").value) - parseFloat(getId("car_weight").value).toFixed(2)))) {
                    getId("total_weight").value = 0;
                } else {
                    getId("total_weight").value = (parseFloat(getId("car_cbag_weight").value) - parseFloat(getId("car_weight").value)).toFixed(2);
                }

            }
            function cal_bag_net() {
                if (isNaN((parseFloat(getId("bag_total").value) * parseFloat(getId("bag_weight").value).toFixed(2)))) {
                    getId("bag_net").value = 0;
                } else {
                    getId("bag_net").value = (parseFloat(getId("bag_total").value) * parseFloat(getId("bag_weight").value)).toFixed(2);
                    getId("carbon_net").value = parseFloat(getId("total_weight").value) - (parseFloat(getId("bag_weight").value) * parseFloat(getId("bag_total").value));
                }

            }
            function New_Cal(inputValue) {
                var input = ("ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent").split(",");
                var output = ("ashes_weight_ch,dust_weight_ch,volatile_weight_ch,moise_weight_ch,contamination_weight_ch").split(",");
                //alert(input.valueOf());
                if (inputValue) {
                    for (var i = 0; i < input.length; i++) {
                        if (i == 2) {
                            //alert(parseFloat(getId(input[i]).value)+parseFloat(getId(input[i+1]).value));
                            if ((parseFloat(getId(input[i]).value) + parseFloat(getId(input[i + 1]).value)).toFixed(2) > 24.00) {
                                getId(input[i] + "_ch").value = ((parseFloat(getId(input[i]).value) + parseFloat(getId(input[i + 1]).value)).toFixed(2) - 24.00).toFixed(2);
                                getId(output[i]).value = parseFloat((parseFloat(getId("total_weight").value) * (parseFloat(getId(input[i] + "_ch").value) / 100)).toFixed(3)).toFixed(2);
                                getId(input[i + 1] + "_ch").value = "0";
                                getId(output[i + 1]).value = "0.00";
                                i++;
                            } else {
                                getId(input[i] + "_ch").value = "0";
                                getId(output[i]).value = "0.00";
                                getId(input[i + 1] + "_ch").value = "0";
                                getId(output[i + 1]).value = "0.00";
                                i++;
                            }
                        } else {
                            Calculator_ch(input[i], input[i] + "_ch", output[i], "total_weight", "bag_weight");
                        }
                    }
                } else {
                    for (var i = 0; i < input.length; i++) {
                        getId(input[i] + "_ch").value = "0";
                        getId(output[i]).value = "0.00";
                    }
                    getId("net_weight_ch").value = "0.00";
                }
            }

            function Lab_Not_Check(inValue) {
                //alert(inValue);
                if (inValue==true) {
                    var input = ("ashes_percent,dust_percent,volatile_percent,moise_percent,contamination_percent").split(",");
                    var input2 = ("ashes_weight,dust_weight,volatile_weight,moise_weight,contamination_weight").split(",");
                    for (var i = 0; i < input.length; i++) {
                        getId(input[i]).value = "0.00";
                        getId(input[i] + "_ch").value = "0.00";
                        getId(input2[i]).value = "0.00";
                        getId(input2[i] + "_ch").value = "0.00";
                        //alert("Check = " + getId(input[i]).value);
                    }
                    getId("net_weight").value = getId("carbon_net").value;
                    getId("net_weight_ch").value = getId("carbon_net").value;
                    getId("lab_not_check").value = "Y";
                    //alert("Check = " + getId("lab_not_check").value);
                } else {
                    getId("lab_not_check").value = "N";
                    //alert("Check = " + getId("lab_not_check").value);
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <title>Insert title here</title>
    </head>
    <body onUnload="closepopup();">
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                UtiDatabase objuti = new UtiDatabase();
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_022");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                DataBean_Screen_Report objscreen = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objscreen = r_p.Fn_Report(objscreen, request.getParameter("submenu_id"));
                objr_p = r_p.Fn_Report(objr_p, "S501");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report

            %>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cal" value="4" >
            <input type="hidden" id="chkNull" value="doc_id,doc_date,wh_in,supplier_id,position_no,scale_no,type_prod,product_id,total_weight,bag_weight">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2"><%=objscreen.getName_t() + "(" + objscreen.getPath() + ")"%></td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="4" align="right"><b>หมายเลขเอกสาร :<%=objscreen.getDoc_no()%> </b></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ :<%=objscreen.getDoc_eff_date()%></b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">สถานที่ชำระเงิน*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select branch_id,name_t from mbranch order by runno", "branch_id", "name_t", "select_mbranch", "not", "ทั้งหมด")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170" class="columnlabel"><b>เลขที่เอกสาร*</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='doc_id' type='text' id="doc_id" value='' size='10' />
                                        <!--<select id="select_brown" name="select_brown">
                                            <option  value="1"selected>ค้นหาข้อมูลวัตถุดิบที่ยังไม่ได้วิเคราะห์</option>
                                            <option value="2">ค้นหาข้อมูลวัตถุดิบวิเคราะห์เรียบร้อย</option>
                                        </select>-->
                                        &nbsp;<a href='#' onClick="Opendoc_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;
                                        วันที่เอกสาร*&nbsp<input name='doc_date' type='text' id="doc_date" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>	          	
                                        &nbsp<a href='#' onClick="Opendoc_id(2)" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหาข้อมูลรับวัตถุดิบที่ได้วิเคราะห์' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a> เอกสารที่ LAB วิเคราะห์ฯแล้ว&nbsp;&nbsp;
                                        &nbsp;
                                    </td>
                                </tr>
                                <!--<tr>
                                    <td class="columnlabel">คลังจัดเก็บ&nbsp;</td>
                                    <td class="columnobject">

                                        <select name='wh_in' id="wh_in">
                                            <option value='' selected></option></select>	        	</td>
                                </tr>-->

                                <tr>
                                    <td class="columnlabel">ชื่อ Supplier*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='supplier_id' type='text' id="supplier_id" value='' size='10' readonly="readonly"/>
                                        &nbsp;<a href='#' onClick="openBrWindow('Vsupplier', 22, '../JSP/Serch_Config.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='supplier_id_desc' type='text' id="supplier_id_desc" value='' size='20' readonly="readonly" />
                                        โทรศัพท์<input name='sup_tel_desc' type='text' id="sup_tel_desc" value='' size='15'  readonly="readonly"/>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ที่อยู่&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <textarea name='sup_address_desc' cols='40' rows='5' id="sup_address_desc" readonly="readonly"></textarea>	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">เลขกอง*&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='position_no' type='text' id="position_no" value='' size='10' />	          	</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">โกดัง&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='wh_in' type='text' id="wh_in" value='<%=objs_p.getWarehouse_begin_id()%>' size='10' readonly="readonly"/>
                                        <!--a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+warehouse_id+=+\'<%=objs_p.getWarehouse_begin_id()%>\'', 22, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' id="wh_name" value='<%=objs_p.getWarehouse_begin_name()%>' size='30' readonly="readonly" />                                </td-->
                                        <a href='#' onClick="openBrWindow('Mwarehouse&stadment=and+wh_type+=+\'R\'', 22, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;<input name='wh_name' type='text' id="wh_name" value='<%=objs_p.getWarehouse_begin_name()%>' size='30' readonly="readonly" />                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">วันที่รถถ่านเข้า*</td>
                                    <td colspan="3" class="columnobject"><input name="car_date_in" type="text" id="car_date_in" size="10" readonly><a id='date_2'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'car_date_in', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_2', singleClick: true, step: 1});</script>
                                        เลขที่ใบชั่งถ่าน*&nbsp;
                                        <input name='scale_no' type='text' id="scale_no" value='' size='10' /></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel"><span class="columnobject">เลขทะเบียนรถ*</span></td>
                                    <td colspan="3" class="columnobject"><input name='car_no' type='text' id="car_no" value='' size='10' />
                                        &nbsp;&nbsp;
                                        ชื่อคนขับ*&nbsp;
                                        <input name='driver_name' type='text' id="driver_name" value='' size='20' /></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ประเภท&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select type_id,name_t from mtype order by runno", "type_id", "name_t", "type_prod")%>                                </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ชื่อสินค้า*&nbsp;</td>
                                    <td colspan="3" class="columnobject">                                    
                                        <%=objuti.ShowSelectBox("select product_id,name_t from mproduct where ptype_id = 'RAW' order by runno", "product_id", "name_t", "product_id")%>                                </td>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">น.นถ่าน+น.น.รถ+น.น.กระสอบ</td>
                                    <td colspan="3" class="columnobject"><input name="car_cbag_weight" type="text" id="car_cbag_weight" size="10" onKeyUp="IsNuber(this.value, this)" onBlur="cal_total_weight()">
                                        &nbsp;กิโลกรัม                            </tr>
                                <tr>
                                    <td class="columnlabel">น.น.รถ</td>
                                    <td colspan="3" class="columnobject"><input name="car_weight" type="text" id="car_weight" size="10" onKeyUp="IsNuber(this.value, this)" onBlur="cal_total_weight()">
                                        &nbsp;กิโลกรัม                             </tr>
                                <tr>
                                    <td class="columnlabel">น.น.กระสอบ</td>
                                    <td colspan="3" class="columnobject"><input name='bag_weight' type='text' id="bag_weight" value='' size='10' onKeyUp="IsNuber(this.value, this)" onBlur="cal_bag_net()"/>
                                        &nbsp;น.น.กระสอบ/ใบ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;จำนวนกระสอบ&nbsp;
                                        <input name="bag_total" type="text" id="bag_total" size="10" onKeyUp="IsNumber2(this.value, this)" onBlur="cal_bag_net()">
                                        ใบ</tr>
                                <tr>
                                    <td class="columnlabel">น.น.ถ่าน+น.น.กระสอบ&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='total_weight' type='text' id="total_weight" value='' size='10' readonly/>
                                        &nbsp;กิโลกรัม<!--<input type="button" value="คำนวณ" onclick="Calcultor()"></td>-->                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;น.น.&nbsp;กระสอบทั้งหมด
                                        <input name="bag_net" type="text" id="bag_net" size="10" readonly>
                                        กิโลกรัม</tr>
                                <tr>
                                    <td class="columnlabel"></td>
                                    <td colspan="3" class="columnobject">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(น.น.ถ่าน+น.น.กระสอบ)&nbsp;-&nbsp;น.น.&nbsp;กระสอบทั้งหมด<input name="carbon_net" type="text" id="carbon_net" size="10" readonly>
                                        กิโลกรัม</td></tr>
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td width="182" class="columnobject"><b>ไม่ต้องวิเคราะห์ผล LAB</b>&nbsp;<input type="checkbox" id="lab_not_check" name="lab_not_check" onclick="Lab_Not_Check(this.checked)"></td>
                                </tr>    
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td width="182" class="columnobject">ผลจากการวิเคราะห์</td>

                                    <td width="91" class="columnobject">&nbsp;</td>
                                    <td width="314" class="columnobject">%ตามข้อกำหนด&nbsp;คำนวณ(ความชื้น+การระเหย<24)&nbsp;
                                        <input type="checkbox" id="new_cal" name="new_cal" value="N" onclick="New_Cal(this.checked)"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ขี้เถ้า%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='ashes_percent' type='text' id="ashes_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='ashes_weight' type='text' id="ashes_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel">ขี้เถ้า%</span></div></td>
                                    <td class="columnobject"><input name='ashes_percent_ch' type='text' id="ashes_percent_ch" value='' size='5' onkeyup="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('ashes_percent', 'ashes_percent_ch', 'ashes_weight_ch', 'total_weight', 'bag_weight');" />
                                        &nbsp;&nbsp;
                                        <input name='ashes_weight_ch' type='text' id="ashes_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ฝุ่น%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='dust_percent' type='text' id="dust_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='dust_weight' type='text' id="dust_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel">ฝุ่น%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='dust_percent_ch' type='text' id="dust_percent_ch" value='' size='5' onkeyup="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('dust_percent', 'dust_percent_ch', 'dust_weight_ch', 'total_weight', 'bag_weight');"/>
                                        &nbsp;&nbsp;
                                        <input name='dust_weight_ch' type='text' id="dust_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">การระเหย%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='volatile_percent' type='text' id="volatile_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='volatile_weight' type='text' id="volatile_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel">การระเหย%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='volatile_percent_ch' type='text' id="volatile_percent_ch" value='' size='5' onkeyup="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('volatile_percent', 'volatile_percent_ch', 'volatile_weight_ch', 'total_weight', 'bag_weight');"/>
                                        &nbsp;&nbsp;
                                        <input name='volatile_weight_ch' type='text' id="volatile_weight_ch" value='' size='10' readonly ="readonly"/>                                    &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ความชื้นเฉลี่ย%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='moise_percent' type='text' id="moise_percent" value='' size='5' readonly ="readonly"/>
                                        &nbsp;&nbsp;
                                        <input name='moise_weight' type='text' id="moise_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel">ความชื้นเฉลี่ย%&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='moise_percent_ch' type='text' id="moise_percent_ch" value='' size='5' onkeyup="IsNuber(this.value, this)" onBlur="javascript:Calculator_ch('moise_percent', 'moise_percent_ch', 'moise_weight_ch', 'total_weight', 'bag_weight');"/>
                                        &nbsp;&nbsp;
                                        <input name='moise_weight_ch' type='text' id="moise_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">สิ่งเจือปน%&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='contamination_percent' type='text' id="contamination_percent" value='' size='5' readonly ="readonly" />
                                        &nbsp;&nbsp;
                                        <input name='contamination_weight' type='text' id="contamination_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right">สิ่งเจือปน%</div></td>
                                    <td class="columnobject"><input name='contamination_percent_ch' type='text' id="contamination_percent_ch" value='' size='5' onkeyup="IsNuber(this.value, this)"  onBlur="javascript:Calculator_ch('contamination_percent', 'contamination_percent_ch', 'contamination_weight_ch', 'total_weight', 'bag_weight');"/>
                                        &nbsp;&nbsp;
                                        <input name='contamination_weight_ch' type='text' id="contamination_weight_ch" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">น้ำหนักสุทธิ&nbsp;</td>
                                    <td class="columnobject">
                                        <input name='net_weight' type='text' id="net_weight" value='' size='10' readonly ="readonly"/>
                                        &nbsp;กิโลกรัม	          	</td>
                                    <td class="columnobject"><div align="right"><span class="columnlabel">น้ำหนักสุทธิ&nbsp;</span></div></td>
                                    <td class="columnobject"><input name='net_weight_ch' type='text' id="net_weight_ch" value='' size='10' />
                                        &nbsp;กิโลกรัม <!--<input type="checkbox" id="new_cal" name="new_cal" value="N" onclick="New_Cal(this.checked)">--></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                    <td colspan="3" class="columnobject"><textarea name='remark' cols='40' rows='5' id="remark" readonly ="readonly"></textarea></td>
                                </tr>

                                <tr>
                                    <td class="columnlabel">ราคา/หน่วย&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='price_unit' type='text' id="price_unit" value='' size='10' onKeyUp="IsNuber(this.value, this)" />
                                        &nbsp;บาท	          	</td>
                                </tr>           

                                <!--tr>
                                    <td class="columnlabel">รวมราคา&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='total_price' type='text' id="total_price" value='0' size='10' onKeyUp="IsNuber(this.value, this)" />
                                        &nbsp;บาท	          	</td>
                                </tr-->                                

                                <tr>
                                    <td colspan='4' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle();"><img alt="" class="imgtransparent"  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="add();"><img alt="" class="imgtransparent"  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="confirmDialogDelete(URLsend('doc_id,doc_date,wh_in,wh_name,supplier_id,supplier_id_desc,sup_tel_desc,sup_address_desc,position_no,scale_no,car_no,driver_name,type_prod,product_id,total_weight,bag_weight,ashes_percent,ashes_weight,dust_percent,dust_weight,volatile_percent,volatile_weight,moise_percent,moise_weight,contamination_percent,contamination_weight,net_weight,remark,price_unit,status_d,username,select_mbranch', '../JSP/CS_022.jsp'));"><img alt="" class="imgtransparent"  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" class="imgtransparent" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                        <br>      		  	</td>
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
        </form>
    </body>
</html>