<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_withdraw_detail"%>
<%@page import="com.cgc.DB.D_carbon_friction_withdraw_detailDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
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
                arrayChk[0] = "chkNull";
                alert(arrayChk[0]);
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,doc_date,line_no,product_id,friction_house,location_id,friction_dust_amount,friction_dust_weight,friction_dust_bag,pan_dust_amount,pan_dust_weight,pan_dust_bag,sucker_dust_amount,sucker_dust_weight,sucker_dust_bag,magnet1,magnet2,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,wh_in,laps_weight,laps_total,status_a', '../JSP/CS_Detail_025_1.jsp'));
                    //showTable("show","doc_id","../JSP/CS_ShowDetail_025_1.jsp?doc_id=");
                    showTable("show", "doc_id", "../JSP/CS_DetailShow_025_1.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_DetailShow_025_1.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                //alert(laps_total);
                if (ChkParameter(arrayChk))
                {
                    //alert("friction_carbon_in_weight = " +  getId(friction_carbon_in_weight).value);
                    getSave(URLsend('doc_id,doc_date,line_no,product_id,friction_house,location_id,friction_dust_amount,friction_dust_weight,friction_dust_bag,pan_dust_amount,pan_dust_weight,pan_dust_bag,sucker_dust_amount,sucker_dust_weight,sucker_dust_bag,magnet1,magnet2,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,wh_in,laps_weight,laps_total,status_u', '../JSP/CS_Detail_025_1.jsp'));
                    //showTable("show","doc_id","../JSP/CS_ShowDetail_025_1.jsp?doc_id=");
                    showTable("show", "doc_id", "../JSP/CS_DetailShow_025_1.jsp?doc_id=");
                    setTimeout('showTable("show","doc_id","../JSP/CS_DetailShow_025_1.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 2000);
                }
            }
            function goBack()
            {
                window.close();
            }
            function sum_totalvalue(bag, amount, weight) {
                getId(weight).value = parseInt(getId(bag).value, 10) * parseInt(getId(amount).value, 10);
            }
        </script>
    </head>
    <body onLoad="select_value()">
        <%!            ThaiUtil en = new ThaiUtil();
            UtiDatabase objuti = new UtiDatabase();
            D_carbon_friction_withdraw_detailDAO objDAO = new D_carbon_friction_withdraw_detailDAO();
            DataBeanD_carbon_friction_withdraw_detail objBean = new DataBeanD_carbon_friction_withdraw_detail();
            String doc_date, status_a, status_u, runno, doc_id, line_no, product_id, friction_house, location_id, friction_dust_amount, friction_dust_weight, friction_dust_bag, pan_dust_amount, pan_dust_weight, pan_dust_bag, sucker_dust_amount, sucker_dust_weight, sucker_dust_bag, magnet1, magnet2, laps_amount, friction_carbon_in_weight, lost_weight, carbon_burn_in_weight, jumbo_weight, wh_in, laps_weight, laps_total, weight_friction_recieve_total;
        %>
        <%
            doc_id = "";
            line_no = "";
            status_a = "";
            status_u = "";
            doc_id = "";
            line_no = "";
            product_id = "C";
            friction_house = "";
            location_id = "";
            friction_dust_amount = "0";
            friction_dust_weight = "0";
            friction_dust_bag = "0";
            pan_dust_amount = "0";
            pan_dust_weight = "0";
            pan_dust_bag = "0";
            sucker_dust_amount = "0";
            sucker_dust_weight = "0";
            sucker_dust_bag = "0";
            magnet1 = "0";
            magnet2 = "0";
            laps_amount = "0";
            friction_carbon_in_weight = "0";
            lost_weight = "0";
            carbon_burn_in_weight = "0";
            jumbo_weight = "0";
            wh_in = "0";
            laps_weight = "0";
            laps_total = "0";
            weight_friction_recieve_total = "0";
            doc_date = request.getParameter("doc_date");
            if (request.getQueryString().indexOf("line_no_") != -1) {
                line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
                doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
                objBean = objDAO.ReturnEdit(doc_id, line_no);
                product_id = objBean.getProduct_id();
                friction_house = objBean.getFriction_house();
                location_id = objBean.getLocation_id();
                friction_dust_amount = objBean.getFriction_dust_amount();
                friction_dust_weight = objBean.getFriction_dust_weight();
                friction_dust_bag = objBean.getFriction_dust_bag();
                pan_dust_amount = objBean.getPan_dust_amount();
                pan_dust_weight = objBean.getPan_dust_weight();
                pan_dust_bag = objBean.getPan_dust_bag();
                sucker_dust_amount = objBean.getSucker_dust_amount();
                sucker_dust_weight = objBean.getSucker_dust_weight();
                sucker_dust_bag = objBean.getSucker_dust_bag();
                magnet1 = objBean.getMagnet1();
                magnet2 = objBean.getMagnet2();
                laps_amount = objBean.getLaps_amount();
                friction_carbon_in_weight = objBean.getFriction_carbon_in_weight();
                lost_weight = objBean.getLost_weight();
                carbon_burn_in_weight = objBean.getCarbon_burn_in_weight();
                jumbo_weight = objBean.getJumbo_weight();
                wh_in = objBean.getWh_in();
                laps_weight = objBean.getLaps_weight();
                laps_total = objBean.getLaps_total();
                status_u = "2";
                doc_date = objBean.getDoc_date();
                weight_friction_recieve_total = objBean.getWeight_friction_recieve_total();
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
        <input type="hidden" id="chkNull" value="product_id,laps_amount,laps_weight,laps_total">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">ข้อมูลถ่านเบิก&nbsp;</td>
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

                            <!--tr>
                                <td class="columnlabel">ชนิดถ่าน*&nbsp;</td>
                                <td class="columnobject"><input type="text" name="product_id" id="product_id" value="<%=product_id%>"></td>
                            </tr-->
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
                                <td class="columnlabel">โรงสี*&nbsp;</td>
                                <td class="columnobject"><input type="text" name="friction_house" id="friction_house" value="<%=friction_house%>"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">เลขกอง*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='location_id' type='text' id="location_id" value='<%=location_id%>' size='10' />                                </td>
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
                                <td class="columnlabel">ฝุ่น</td>
                                <td class="columnobject"><table width="100%" border="0">
                                        <tr>
                                            <td class="row3" >ประเภทฝุ่น</td>
                                            <td class="row3" >น้ำหนักบรรจุ</td>
                                            <td class="row3" >จำนวน</td>
                                            <td class="row3" >น้ำหนักรวม</td>
                                        </tr>
                                        <tr>
                                            <td w>ฝุ่นสี</td>
                                            <td><input type="text" name="friction_dust_bag" id="friction_dust_bag" value="<%=friction_dust_bag%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('friction_dust_bag', 'friction_dust_amount', 'friction_dust_weight')"></td>
                                            <td><input type="text" name="friction_dust_amount" id="friction_dust_amount" value="<%=friction_dust_amount%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('friction_dust_bag', 'friction_dust_amount', 'friction_dust_weight')"></td>
                                            <td><input type="text" name="friction_dust_weight" id="friction_dust_weight" value="<%=friction_dust_weight%>" readonly onblur="sum_totalvalue('friction_dust_bag', 'friction_dust_amount', 'friction_dust_weight')"></td>
                                        </tr>
                                        <tr>
                                            <td w>ฝุ่นร่อน</td>
                                            <td><input type="text" name="pan_dust_bag" id="pan_dust_bag" value="<%=pan_dust_bag%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('pan_dust_bag', 'pan_dust_amount', 'pan_dust_weight')"></td>
                                            <td><input type="text" name="pan_dust_amount" id="pan_dust_amount" value="<%=pan_dust_amount%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('pan_dust_bag', 'pan_dust_amount', 'pan_dust_weight')"></td>
                                            <td><input type="text" name="pan_dust_weight" id="pan_dust_weight" value="<%=pan_dust_weight%>" readonly onblur="sum_totalvalue('pan_dust_bag', 'pan_dust_amount', 'pan_dust_weight')"></td>
                                        </tr>
                                        <tr>
                                            <td w>ฝุ่นเครื่องดูดฝุ่น</td>
                                            <td><input type="text" name="sucker_dust_bag" id="sucker_dust_bag" value="<%=sucker_dust_bag%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('sucker_dust_bag', 'sucker_dust_amount', 'sucker_dust_weight')"></td>
                                            <td><input type="text" name="sucker_dust_amount" id="sucker_dust_amount" value="<%=sucker_dust_amount%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('sucker_dust_bag', 'sucker_dust_amount', 'sucker_dust_weight')"></td>
                                            <td><input type="text" name="sucker_dust_weight" id="sucker_dust_weight" value="<%=sucker_dust_weight%>" readonly onblur="sum_totalvalue('sucker_dust_bag', 'sucker_dust_amount', 'sucker_dust_weight')"></td>
                                        </tr>

                                    </table></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">แม่เหล็กตัวที่1</td>
                                <td class="columnobject"><input type="text" name="magnet1" id="magnet1" value="<%=magnet1%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">แม่เหล็กตัวที่2</td>
                                <td class="columnobject"><input type="text" name="magnet2" id="magnet2" value="<%=magnet2%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">จำนวนที่สี</td>
                                <td class="columnobject"><input type="text" name="laps_amount" id="laps_amount" value="<%=laps_amount%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('laps_amount', 'laps_weight', 'laps_total')">
                                    (ตัก)&nbsp;x&nbsp;
                                    <input type="text" name="laps_weight" id="laps_weight" value="<%=laps_weight%>" onkeyup="IsNuber(this.value, this)" onblur="sum_totalvalue('laps_amount', 'laps_weight', 'laps_total')">
                                    (KG.)=
                                    <input type="text" name="laps_total" id="laps_total" value="<%=laps_total%>" readonly onblur="sum_totalvalue('laps_amount', 'laps_weight', 'laps_total')"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนักถ่านเข้าสี</td>
                                <td class="columnobject">
                                    <input type="text" name="friction_carbon_in_weight" id="friction_carbon_in_weight" value="<%=friction_carbon_in_weight%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">สูญเสีย</td>
                                <td class="columnobject"><input type="text" name="lost_weight" id="lost_weight" value="<%=lost_weight%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">นน.ถ่านเติมเตา</td>
                                <td class="columnobject"><input type="text" name="carbon_burn_in_weight" id="carbon_burn_in_weight" value="<%=carbon_burn_in_weight%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">นน.จากถุงจัมโบ้</td>
                                <td class="columnobject"><input type="text" name="jumbo_weight" id="jumbo_weight" value="<%=jumbo_weight%>" onkeyup="IsNuber(this.value, this)"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel"><b>นน.ถ่านได้สุทธิ</b></td>
                                <td class="columnobject"><input type="text" name="weight_friction_recieve_total" id="weight_friction_recieve_total" value="<%=weight_friction_recieve_total%>"></td>
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