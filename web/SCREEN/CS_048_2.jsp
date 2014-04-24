<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script language="javascript">
            function cancal(){
                cancelAction();
                getId("show").innerHTML = "";
            }
            function showTable(){
                //getId("show").innerHTML = "";
                (getId("process_id").value == "")?alert("กรุณาเลือกโปรเซสที่ต้องการ"):
                    (getId("doc_id").value == "")?alert("กรุณาเลือกรหัสเอกสาร"):
                    showTableNonPopupApprove('show','process_id','table_s1','doc_id', '../JSP/CS_Show048.jsp');
            }
            function Send_to_Approve(){
                var IDsend = "";
                var Nochk = true;
                var overweight = false;
                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {

                    if(document.getElementsByName("ckbox")[i].checked ==true){
                        var value_ckbox = document.getElementsByName("ckbox")[i].value;
                        if(getId("location_id_"+value_ckbox).value == ""){
                            getId("location_id_"+value_ckbox).value = "-";
                        }
                        if(parseInt(getId("weight_"+value_ckbox).value) > parseInt(getId("weight_doc_id_"+value_ckbox).value)){
                            getId("line_no").value = "";
                            getId("weight_"+value_ckbox).select();
                            IDsend ="";
                            Nochk = false;
                            overweight = true;
                            break;
                        }
                        else if(getId("product_id_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("product_id_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("warehouse_id_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("warehouse_id_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else if(getId("weight_"+value_ckbox).value == ""){
                            getId("line_no").value = "";
                            getId("weight_"+value_ckbox).focus();
                            IDsend ="";
                            Nochk = false;
                            break;
                        }
                        else{
                            getId("line_no").value += value_ckbox+",";
                            IDsend += "product_id_"+value_ckbox+","+"location_id_"+value_ckbox+","+"warehouse_id_"+value_ckbox+","+"weight_"+value_ckbox+","+"job_id_"+value_ckbox+","+"weight_doc_id_"+value_ckbox+","
                            IDsend += (getId("process_id").value == "PR_022")?"total_price_"+value_ckbox+",":"warehouse_in_"+value_ckbox+","+"location_doc_id_"+value_ckbox+",";
                            IDsend += getId("process_id").value == "PR_115"?"doc_type_"+value_ckbox+",":"";
                            Nochk = false;
                        }
                    }
                }
                if(Nochk != true && IDsend != ""){
                    getId("line_no").value = getId("line_no").value.substr(0, getId("line_no").value.length-1);
                    IDsend = IDsend.substr(0, IDsend.length-1);
                    IDsend = "process_id,table_h,table_s1,table_s2,doc_id,doc_date,line_no,"+IDsend;
                    //alert(IDsend);
                    if(getId("doc_date").value == ""){
                        alert("กรุณาระบุวันที่ของเอกสาร");
                    }else{
                        getsaveApprove(URLsend(IDsend, "../JSP/CS_048_2.jsp"), "calreport");//(URLsend(IDsend, "../JSP/CS_048_2.jsp"));
                        getId("doc_id").value = "";
                        getId("doc_date").value = "";
                        getId("line_no").value = "";
                        getId("show").innerHTML = "";
                        getId("chk_all").checked = false;
                    }
                }else if(Nochk != true && IDsend == ""){
                    overweight?alert("น้ำหนักที่รับเข้าคลังมีค่ามากกว่าน้ำหนักจริง กรุณากรอกน้ำหนักให้ถูกต้อง"):alert("กรุณากรอกข้อมูลให้ครบ");
                    overweight = false;
                }
                else{
                    alert("กรุณาเลือกข้อมูลที่จะบันทึก");
                }

            }
            function BrownDoc_id(){
                //opengetId("table_h").value
                if(getId("table_h").value != ""){
                    if(getId("table_h").value == "d_requisition_product_header_wh"){
                        openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+net_weight+=+net_weight_wh', 482, 'Search_Config2.jsp');
                    }else if(getId("table_h").value == "d_rawmatt_receive"){
                        //openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+price_flag+=+\'Y\'', 482, 'Search_Config2.jsp');
                        openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+(doc_type+=+\'Y\'+or+lab_not_check+=+\'Y\')', 482, 'Search_Config2.jsp');
                    }else if(getId("table_h").value == "d_carbon_burn_in_header_wh"){
                        //openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+price_flag+=+\'Y\'', 482, 'Search_Config2.jsp');
                        openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'+and+doc_type+<>+\'N\'', 482, 'Search_Config2.jsp');
              
                    }else{
                        openBrWindow(getId("table_h").value+'&stadment=and+complete_flag+<>+\'Y\'', 482, 'Search_Config2.jsp');
                    }
                }
            }
            function ckall(Value)//ทำการกดปุ้ม check ทั้งหมดใช้หรือไม่
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }

            }
            //-->
        </script>
    </head>

    <body onUnload="closepopup()">
        <div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
        <form name="btform" method="post" action="CS_048.jsp">
            <input type="hidden" name="table_h" id="table_h" >
            <input type="hidden" name="table_s1" id="table_s1" >
            <input type="hidden" name="table_s2" id="table_s2" >
            <input type="hidden" name="line_no" id="line_no">
            <div align="center">

                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">อนุมัติรับ-จ่าย (คลังสินค้า)&nbsp;(CS_048_2)</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><b>หมายเลขเอกสาร : </b></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><b>วันที่มีผลบังคับใช้ : </b></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><span class="columnobject">รหัส process*</span></td>
                                        <td class="columnobject"><input type='text' name='process_id' id="process_id" size='10' value='' />
                                            &nbsp;<a href='javascript:;' onClick="getId('doc_id').value='';getId('doc_date').value='';openBrWindow('vmprocess&stadment=and+doc_type+<>+\'N\'', 482, 'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input type='text' name='process_name' id="process_name" size='30' value='' /></td>
                                    </tr>
                                    <tr>
                                        <td width="30%" align="right"><span class="columnobject">เลขที่เอกสาร*</span></td>
                                        <td class="columnobject"><input name="doc_id" type="text" id="doc_id" size="10">&nbsp;<a href='javascript:;' onClick="BrownDoc_id()"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                            <input name="doc_date" type="text" id="doc_date" size="30">
                                            <input type='button' class="cgcButton_6" name='search' onClick="showTable()" value='ค้นหา'/></td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div width="100%">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">

                                                    <tr>
                                                        <td class="headergrid" colspan="7">เอกสาร</td>
                                                        <td class="headergrid" colspan="4">คลังสินค้า</td>
                                                    </tr>

                                                    <tr>
                                                        <td class="row3" width="3%"><input type="checkbox" name="chk_all" value="chk_all" onClick="ckall(this.checked);"/></td>
                                                        <td class="row3" width="3%">No.&nbsp;</td>
                                                        <td class="row3" width="14%">เลขที่เอกสาร&nbsp;</td>
                                                        <td class="row3" width="10%">วันที่เอกสาร&nbsp;</td>
                                                        <td class="row3" width="10%">ใบแจ้งผลิต&nbsp;</td>
                                                        <td class="row3" width="10%">ถ่าน&nbsp;</td>
                                                        <td class="row3" width="10%">น้ำหนัก (Kg)&nbsp;</td>
                                                        <td class="row3" width="13%">รหัสถ่าน&nbsp;</td>
                                                        <td class="row3" width="7%">เลขกอง/เลทที่&nbsp;</td>
                                                        <td class="row3" width="10%">คลัง&nbsp;</td>
                                                        <td class="row3" width="10%">น้ำหนัก (Kg)&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show">                                            </div>                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' align="right">
                                            <input type='button' class="cgcButton_4" name='but1' value='  บันทึก  ' onclick='javascript:Send_to_Approve();'/>
                                            <input type='button' class="cgcButton_3" name='but2' value='  ยกเลิก  ' onclick='cancal()'/>  
                                            <!--a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onclick="javascript:Send_to_Approve();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a-->

                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                </table>
                                <textarea name="calreport" id="calreport" cols="100" rows="7"></textarea>
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
        </form>
    </body>
</html>
