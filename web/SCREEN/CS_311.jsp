<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
            function cancal(){
                cancelAction();
                getId("show").innerHTML = "";
            }
            function Send_to_Approve(){
                var value_ckbox = "";
                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    //alert(document.getElementsByName("ckbox")[i].checked);
                    if(document.getElementsByName("ckbox")[i].checked ==true){
                        value_ckbox += document.getElementsByName("ckbox")[i].value+",";
                    }
                }
                if(value_ckbox != ""){
                    getId("line_no").value = value_ckbox.substr(0, value_ckbox.length-1);
                    IDsend = "line_no";
                    alert(getId("line_no").value);
                    getsaveApprove(URLsend(IDsend, "../JSP/CS_311.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                    getId("doc_id").value = "";
                    getId("line_no").value = "";
                    getId("show").innerHTML = "";
                    getId("chk_all").checked = false;
                }
                else{
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }
            
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            function showTablePage(){
                showTableNonPopup('show', 'doc_id', '../JSP/CS_Show311.jsp?doc_id=');
            }
        </script>
    </head>
    <body onUnload="closepopup()">
        <input type="hidden" id="line_no" name="line_no" value="">
        <div align="center">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">อนุมัติข้อมูลเพื่อทำการส่งให้โปรแกรมบัญชี (การส่งออก)&nbsp;(CS_311)</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="center">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="2" align="right">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td width="45%" align="right">ค้นหาเอกสารที่ทำการอนุมัติจากคลังสินค้า*&nbsp;</td>
                              <td class="columnobject">
                                  <input type='hidden' name='doc_id' id="doc_id" size='10' value='' /><!--&nbsp;<a href='javascript:;' onClick="javascript:openBrWindow('vd_carbon_burn_out_header_wh&stadment=and+complete_flag+<>+\'Y\'',49,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                        <input type="text" name="doc_date" id="doc_date">-->
                                        <input type='button' class="cgcButton_6" name='search' onClick="showTablePage()" value='ค้นหา'/>
                              </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <div width="100%">
                                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                <tr>
                                                    <td class="headergrid" colspan="6">เอกสารที่จะส่งออก</td>
                                                    <td class="headergrid" colspan="7"></td>
                                                </tr>

                                                <tr>
                                                    <td class="row5" width="3%"><input type="checkbox" name="chk_all" id="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                    <td class="row5" width="7%">No.&nbsp;</td>
                                                    <td class="row5" width="15%">รหัสเอกสาร&nbsp;</td>
                                                  <td class="row5" width="15%">วันที่บันทึกเอกสาร&nbsp;</td>
                                                  <td class="row5" width="15%">ใบแจ้งการผลิต&nbsp;</td>
                                                  <td class="row5" width="15%">ใบสั่งซื้อ&nbsp;</td>
                                                  <td class="row5" width="30%">น้ำหนักรวม&nbsp;</td>
                                                  <!--<td class="row5" width="12%">Prod.code&nbsp;</td>
                                                    <td class="row5" width="12%">เก็บโกดัง&nbsp;</td>
                                                    <td class="row5" width="7%">เลขกอง&nbsp;</td>
                                                    <td class="row5" width="10%">น้ำหนัก<br>รับเข้าคลัง&nbsp;</td>
                                                    <td class="row5" width="10%" colspan="2">&nbsp;</td>-->
                                              </tr>
                                            </table>
                                        </div>
                                        <div style="width:100%; height: 150px; overflow: auto;" id="show">                                        </div>                                    </td>
                                </tr>
                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                                <tr>
                                    <td colspan='2' align="right">
                                        <input type="hidden" name="chkNull" id="chkNull" value="doc_id"/>
                                        <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='Send_to_Approve();'/>
                                        <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='javascript:cancal();'/>                                    </td>
                                </tr>

                                <tr>
                                    <td colspan='2' class='blankspace'></td>
                                </tr>
                            </table>
                            <textarea name="calreport" id="calreport" cols="90" rows="7"></textarea>

                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3">
                    <td class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2"></td>
                    <td class="ffootright"></td>
                </tr>
            </table>
        </div>
    </body>
</html>
