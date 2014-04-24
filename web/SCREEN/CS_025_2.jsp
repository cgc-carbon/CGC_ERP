<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
        UtiDatabase objuti;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link type="text/css" href="../JS/jquery/css/ui-lightness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link type="text/css" href="../JS/jquery/css/ui-lightness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../JS/jquery/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-1.8.17.custom.min.js"></script>
        <title>Untitled Document</title>
        <script type="text/javascript">
            function Chknull() {
                if (document.getElementById('doc_id').value == '') {
                    alert('กรุณาใส่ข้อมูลเลขที่เอกสาร');
                } else
                    document.report.submit();
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull"
                //alert(URLSend);
                if (ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }

            }
            function cancle()
            {

                var SURL;
                var r = confirm("คุณต้องการยกเลิกข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    if (getId("status_cancle").value == "1" && getId("child_ck").value == "")
                    {
                        cancelAction();
                        getId("show").innerHTML = "";
                        getId("show2").innerHTML = "";
                        getId("show3").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("doc_id").disabled = false;
                    }
                    else if (getId("status_cancle").value == "1" && getId("child_ck").value == "1")
                    {
                        alert("มีการเปลี่ยนแปลงข้อมูลกรุณาบันทึกข้อมูล");
                    }
                    else {
                        SURL = "../JSP/CS_024.jsp?status_d=3&chk_all=1&username=" + getId("username").value;
                        SURL = SURL + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL)
                        cancelAction();
                        getId("show").innerHTML = "";
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        getId("doc_id").disabled = false;
                    }

                }

            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for (var i = 0; i < document.getElementsByName("ckbox").length; i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function goDelChild(URL, URL_Show, Check_all_id, ckbox_name, div_id_show)
            {
                var Deleteflag = "";
                var SURL;
                if (getId(Check_all_id).checked)//จะทำการลบข้อมูลของ Detail ทั้งหมด ทึ่ตรงกับรหัส
                {
                    SURL = "../JSP/" + URL + "?status_d=3&chk_all=1";
                    SURL = SURL + "&doc_id=" + getId("doc_id").value;
                    Delete_Line_no(SURL);
                    getId(div_id_show).innerHTML = "";
                    getId(Check_all_id).checked = false;
                }
                else//จะทำการลบข้อมูลเฉพาะ Datail ที่ทำการเลือกไว้
                {
                    SURL = "../JSP/" + URL + "?status_d=3&ckbox=";
                    for (var i = 0; i < document.getElementsByName(ckbox_name).length; i++)
                    {
                        Deleteflag += (document.getElementsByName(ckbox_name)[i].checked) ? (i + 1).toString() + "," : "";
                    }
                    if (Deleteflag == "") {
                        showTableNonPopup(div_id_show, "doc_id", "../JSP/" + URL_Show + "?doc_id=");
                    } else {
                        Deleteflag = Deleteflag.substring(0, Deleteflag.length - 1);
                        SURL = SURL + Deleteflag + "&doc_id=" + getId("doc_id").value;
                        Delete_Line_no(SURL);
                        showTableNonPopup(div_id_show, "doc_id", "../JSP/" + URL_Show + "?doc_id=");
                        setTimeout('showTableNonPopup(' + div_id_show + ', "doc_id", "../JSP/' + URL_Show + '?doc_id=")', 1000);
                    }
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var r = confirm("คุณต้องการบันทึกหรือไม่ ?")
                if (r)
                {
                    getSave(URLsend('chkNull,doc_id,doc_date,doc_time,report_id,remark,shift', '../JSP/CS_025_2.jsp'));
                    getId("show").innerHTML = "";
                    getId("show2").innerHTML = "";
                    getId("show3").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";

                }
            }
            function Delete()
            {
                var r = confirm("คุณต้องการลบข้อมูลทั้งหมดหรือไม่")
                if (r)
                {
                    getSave(URLsend('doc_id,doc_date,status_d,username', '../JSP/CS_025_2.jsp'));
                    getId("show").innerHTML = "";
                    getId("show2").innerHTML = "";
                    getId("show3").innerHTML = "";
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                }
            }
            function OpenDoc_id()
            {
                openBrWindow('vd_carbon_friction_header&stadment=and+complete_flag+<>+\'Y\'', 25, '../JSP/Search_Doc_id.jsp');
            }
            $(function() {
                $('#tabs').tabs();
            });
        </script>    
    </head>

    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objuti = new UtiDatabase();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_025");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S502");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_date,doc_time">
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="status_a" value="1"><!-- เป็นการเพิ่มข้อมูลเข้าไป-->
            <input type="hidden" id="status_d" value="3"><!-- เป็นการ Delete ข้อมูลทั้งหมด -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 คือค่าที่นำมา Edit แต่ถ้า ="" จะเป็นการ Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานการสีถ่าน(CS_025_2)&nbsp;</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right"><strong>หมายเลขเอกสาร :<%=objs_p.getIso_no()%> </strong></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><strong>วันที่มีผลบังคับใช้ :<%=objs_p.getEffective_date()%></strong></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel"><strong>เลขที่เอกสาร*</strong>&nbsp;</td>
                                    <td class="columnobject"><input name='doc_id' type='text' id="doc_id" value='' size='10'  />
                                        &nbsp;<a href='#' onClick="OpenDoc_id()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;วันที่เอกสาร*&nbsp;
                                        <input name='doc_date' type='text' id="doc_date" value='' size='10' readonly="readonly" />
                                        &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField: 'doc_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                        &nbsp;&nbsp;เวลา*&nbsp;
                                        <input name='doc_time' type='text' id="doc_time" value='' size='10' maxlength="5" onKeyUp="IsNumeric(this.value, this)"/>                          </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">กะ</td>
                                    <td class="columnobject"><%=objuti.ShowSelectBox("select shift_id,name_t from mshift  where shift_id in ('8','9')", "shift_id", "name_t", "shift")%>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ผู้รายงาน </td>
                                    <td class="columnobject"><input type='text' id="report_id" name='report_id' size='10' value='' />
                                        &nbsp;&nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee', 25, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <input type='text' name='report_id_desc' id="report_id_desc" size='30' value='' readonly="readonly"/>                          </td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">หมายเหตุ</td>
                                    <td class="columnobject"><textarea name='remark' cols='40' rows='5' id="remark"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">ยอดคงเหลือในไซโล(ตัน) </td>
                                    <td class="columnobject"><input type="text" id="sum_up_silo" name="sum_up_silo" value="" readonly></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">น้ำหนักรวมสุทธิ </td>
                                    <td class="columnobject"><input type="text" id="sum_to_jumbo" name="sum_to_jumbo" value="" readonly></td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <div id="tabs">
                                            <ul>
                                                <li><a href="#tabs-1" onclick="getId('status_cancle').value == 1 ? showTableNonPopup('show', 'doc_id', '../JSP/CS_DetailShow_025_1.jsp?doc_id=') : getId('show').innerHTML = '';">ถ่านเบิก</a></li>
                                                <li><a href="#tabs-2" onclick="getId('status_cancle').value == 1 ? showTableNonPopup('show2', 'doc_id', '../JSP/CS_DetailShow_025_2.jsp?doc_id=') : getId('show2').innerHTML = '';">ถ่านได้</a></li>
                                                <li><a href="#tabs-3" onclick="getId('status_cancle').value == 1 ? showTableNonPopup('show3', 'doc_id', '../JSP/CS_DetailShow_025_3.jsp?doc_id=') : getId('show3').innerHTML = '';">บรรจุถ่านวัตถุดิบ</a></li>
                                            </ul>
                                            <div id="tabs-1" align="center"><div style="width:100%;">
                                                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                        <tr>
                                                            <td colspan="5" class="h_multi">ข้อมูลถ่านเบิก</td>
                                                            <td colspan="7" class="btn_multi">
                                                                <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="(getId('status_cancle').value == 1) ? goAddChild(URLsend('doc_id,doc_date,shift,username,status_a', 'CS_Detail_025_1.jsp')) : alert('กรุณาเลือกรหัสเอกสารก่อน');"/>
                                                                <input type='button' class="cgcButton_3" name='but2' value='   ลบ  ' onClick='goDelChild("CS_Detail_025_1.jsp", "CS_DetailShow_025_1.jsp", "chk_all", "ckbox", "show");'/>                                  
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="row3" width="3px"><input type="checkbox" id="chk_all" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                            <td class="row3" width="7%">ลำดับที่ </td>
                                                            <td class="row3" width="10%">ชนิดถ่าน </td>
                                                            <td class="row3" width="10%">โรงสี </td>
                                                            <td class="row3" width="10%">เลขกอง </td>
                                                            <td class="row3" width="10%">สถานที่เก็บ </td>
                                                            <td class="row3" width="10%">จำนวนที่สี </td>
                                                            <td class="row3" width="10%">น้ำหนักถ่านเข้าสี </td>
                                                            <td class="row3" width="10%">สูญเสีย </td>
                                                            <td class="row3" width="10%">น้ำหนักถ่านเติมเตา</td>
                                                            <td class="row3" width="10%">น้ำหนักจากถุงจัมโบ้ </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="width:100%; height: 150px; overflow: auto;" id="show" align="center"></div>
                                            </div>
                                            <div id="tabs-2" align="center"><div style="width:100%;">
                                                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                        <tr>
                                                            <td colspan="5" class="h_multi">ข้อมูลถ่านได้</td>
                                                            <td colspan="7" class="btn_multi">                                                          
                                                                <!--input type='button' name='but1' value=' class="cgcButton_2" เพิ่ม  ' onClick="(getId('status_cancle').value == 1)?goAddChild(URLsend('doc_id,doc_date,shift,username,status_a','CS_Detail_025_2.jsp')):alert('กรุณาเลือกรหัสเอกสาร');"/>
                                                                <input type='button' name='but2' value=' class="cgcButton_2"  ลบ  ' onClick='goDelChild("CS_Detail_025_2.jsp", "CS_DetailShow_025_2.jsp", "chk_all2", "ckbox2", "show2");'/-->                                  
                                                                <!--a href="#" class="cgcButton_2" onClick="(getId('status_cancle').value == 1)?goAddChild(URLsend('doc_id,doc_date,shift,username,status_a','CS_Detail_025_2.jsp')):alert('กรุณาเลือกรหัสเอกสาร');">เพิ่ม</a>
                                                                <a href="#" class="cgcButton_3" onClick='goDelChild("CS_Detail_025_2.jsp", "CS_DetailShow_025_2.jsp", "chk_all2", "ckbox2", "show2");'>ลบ</a-->                                                                
                                                                <input type='button' name='but1' class="cgcButton_4" value='  เพิ่ม  ' onClick="(getId('status_cancle').value == 1) ? goAddChild(URLsend('doc_id,doc_date,shift,username,status_a', 'CS_Detail_025_2.jsp')) : alert('กรุณาเลือกรหัสเอกสาร');"/>
                                                                <input type='button' name='but2' class="cgcButton_3" value='  ลบ  ' onClick='goDelChild("CS_Detail_025_2.jsp", "CS_DetailShow_025_2.jsp", "chk_all2", "ckbox2", "show2");'/>                                 
                                                            </td>
                                                        </tr>



                                                        <tr>
                                                            <td class="row3" width="3px"><input type="checkbox" id="chk_all2" name="chk_all2" value="chk_all2" onClick="javascript:ckall(this.checked);"/></td>
                                                            <td class="row3" width="7%">ลำดับที่ </td>
                                                            <td class="row3" width="20%">ชนิดถ่าน </td>
                                                            <td class="row3" width="10%">โรงสี </td>
                                                            <td class="row3" width="10%">ไซโล </td>
                                                            <td class="row3" width="20%">กองที่ </td>
                                                            <td class="row3" width="10%">ยอดยกมา </td>
                                                            <td class="row3" width="20%">ยอดคงเหลือ</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="width:100%; height: 150px; overflow: auto;" id="show2" align="center"></div></div>
                                            <div id="tabs-3" align="center"><div style="width:100%;">
                                                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner">
                                                        <tr>
                                                            <td colspan="5" class="h_multi">บรรจุถ่านวัตถุดิบใส่ถุงจัมโบ้</td>
                                                            <td colspan="7" class="btn_multi">
                                                                <input type='button' class="cgcButton_4" name='but1' value='  เพิ่ม  ' onClick="(getId('status_cancle').value == 1) ? goAddChild(URLsend('doc_id,doc_date,username,status_a', 'CS_Detail_025_3.jsp')) : alert('กรุณาเลือกรหัสเอกสาร');"/>
                                                                <input type='button' class="cgcButton_3" name='but2' value='   ลบ  ' onClick='goDelChild("CS_Detail_025_3.jsp", "CS_DetailShow_025_3.jsp", "chk_all3", "ckbox3", "show3");'/>                                  
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="row3" width="3px"><input type="checkbox" id="chk_all3" name="chk_all3" value="chk_all3" onClick="javascript:ckall(this.checked);"/></td>
                                                            <td class="row3" width="7%">ลำดับที่ </td>
                                                            <td class="row3" width="10%">ชนิดถ่าน </td>
                                                            <td class="row3" width="10%">ถุงที่ </td>
                                                            <td class="row3" width="10%">กองที่ </td>
                                                            <td class="row3" width="10%">น้ำหนักบรรจุ </td>
                                                            <!--td class="row3" width="10%">จำนวน(ถุง) </td-->
                                                            <td class="row3" width="25%">น้ำหนักรวม(KG.) </td>
                                                            <td class="row3" width="15%">สถานที่จัดเก็บ </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="width:100%; height: 150px; overflow: auto;" id="show3" align="center"></div></div>
                                        </div>                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center"></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel"></td>
                                    <td class="columnobject">                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'><br>
                                        <div align="center"> 
                                            <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a> 
                                            <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a> 
                                            <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a> 
                                            <a href="javascript:;"  onClick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
                                        <br>                          </td>
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
