<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function Cancelvalue(){
                cancelAction();
                getId("product_id").value = "";
                getId("ch_from").value = "";
                getId("ch_to").value = "";
                getId("doc_id_run").value = "";
                getId("burn_no").value = "";
            }
            function Action_Export(){
                var value_count_date = 0;
                var count_loop =1;
                var Str_return = "";
                var loop_day = 0;
                var loop_month = 0;
                var loop_year = 0;
                var chk_doc_date = false;
                var arrayChk = new Array;
                arrayChk[0]  = "chkNull";
                if(ChkParameter(arrayChk))
                {
                    //******************check doc_date ***************************
                    if(getId("date_from").value != "" && getId("date_to").value == "" || getId("date_from").value == "" && getId("date_to").value != ""){
                        alert("กรุณาเลือกวันที่ให้ครบ");
                    }else if(getId("date_from").value != "" && getId("date_to").value != ""){
                        if(ChkDate(getId("date_from").value, getId("date_to").value)){
                            alert("คุณใส่วันที่ไม่ถูกต้อง...กรุณาตรวจสอบอีกครั้ง");
                        }else{
                            value_count_date =Count_Date(getId("date_from").value, getId("date_to").value);
                            if( value_count_date == 0 ){
                                //alert(value_count_date);
                                alert("จำนวนวันที่คุณเลือกนั้นอาจมีค่าผิดพลาดต่อระบบกรุณาเลือกวันใหม่");
                                chk_doc_date = false;
                            }else{
                                loop_day = parseInt(getId("date_from").value.substr(0, 2));
                                loop_month = parseInt(getId("date_from").value.substr(3, 2).indexOf("0") == 0 ? getId("date_from").value.substr(4, 1):getId("date_from").value.substr(3, 2));
                                //alert(getId("date_from").value.substr(3, 2).indexOf("0") == 0 ? getId("date_from").value.substr(4, 1):getId("date_from").value.substr(3, 2));
                                //alert(parseInt(getId("date_from").value.substr(3, 2)));
                                loop_year = parseInt(getId("date_from").value.substr(8, 2));
                                while(count_loop <= value_count_date){
                                    Str_return  += loop_year.toString();
                                    Str_return  += (loop_month < 10) ?"0"+loop_month :loop_month;
                                    Str_return  += (loop_day < 10) ?"0"+loop_day : loop_day;
                                    Str_return  +=",";
                                
                                    if(loop_month == 4 || loop_month == 6 || loop_month == 9 || loop_month == 11){
                                        if(loop_day == 30){
                                            loop_day = 1;
                                            loop_month +=1;
                                        }else{
                                            loop_day +=1;
                                        }
                                    }else if(loop_month == 2){
                                        if(((parseInt(getId("date_from").value.substr(6, 4))-543) % 4) == 0){
                                            if(loop_day == 29){
                                                loop_day = 1;
                                                loop_month +=1;
                                            }else{
                                                loop_day +=1;
                                            }
                                        }else{
                                            if(loop_day == 28){
                                                loop_day = 1;
                                                loop_month +=1;
                                            }else{
                                                loop_day +=1;
                                            }

                                        }
                                    }else{
                                        if(loop_day == 31){
                                            loop_day = 1;
                                            loop_month +=1;
                                            loop_year += 1;
                                        }else{
                                            loop_day +=1;
                                        }
                                    }
                                    count_loop++;
                                }
                                getId('doc_id_run').value = Str_return.substr(0, Str_return.length - 1);
                                chk_doc_date = true;
                            }
                        }
                    }
                    if(chk_doc_date){
                        document.exportfile.submit();
                    }
                }
            }
        </script>
    </head>
    <body onUnload="closepopup()">
        <input type="hidden" id="chkNull" name="chkNull" value="product_id,burn_no,ch_to,ch_from,date_from,date_to">
        <form name="exportfile" method="post" action="../JSP/CS_Printburn_out_split.jsp" >
            <% UtiDatabase objuti = new UtiDatabase(); %>
            <input type="hidden" id="doc_id_run" name="doc_id_run" value="">
            <input type="hidden" id="count_date" name="count_date" value="">
            <table  cellpadding="0"  cellspacing="0">
                <tr>
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงานถ่านออกจากเตาและร่อนแยกขนาด</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="4"  class="blankspace"></td>
                                </tr>
                                <tr>
                                    <td colspan='4'><b>กำหนดเงื่อนไข<span class="ftopcenter">รายงานถ่านออกจากเตาและร่อนแยกขนาด</span></b></td>
                                </tr>
                                <!--tr>
                                    <td width="158" class='columnlabel'>ชื่อชนิดถ่าน*</td>
                                    <td class='columnobject'><input type="text" id="product_id" name="product_id" size="10"></td>
                                <tr-->
                                
                                <!--td class="columnlabel">ชนิดถ่าน*&nbsp;</td>
                                <td class="columnobject"><label>
                                        <select name="product_id" size="1" id="product_id" style="width:158">
                                            <option value="C" selected>C</option>
                                            <option value="P">P</option>
                                            <option value="U">U</option>
                                        </select>
                                    </label></td>
                                </tr-->      
                                
                                <tr>
                                    <td class="columnlabel">ชนิดถ่าน*&nbsp;</td>
                                    <td colspan="3" class="columnobject">                                    
                                        <%=objuti.ShowSelectBox("select product_id,prodname,name_t from v_rawmaterial where pgroup_id = 'RAW' order by ptype_id,runno", "product_id", "prodname", "product_id")%></td>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td class='columnlabel'>เตาที่*</td>                                
                                    <td class='columnobject'><input name="burn_no" type="text" id="burn_no" size="7">
                                    </td>
                                </tr>
                                <tr>
                                    <td class='columnlabel'>ช่อง*</td>
                                    <td class='columnobject'><input name="ch_from" type="text" id="ch_from" size="7">ถึง*
                                        <input name="ch_to" type="text" id="ch_to" size="7">
                                    </td>
                                </tr>
                                <tr>
                                    <td class='columnlabel'>วันที่เอกสารเริ่มต้น&nbsp;</td><td width="182" class='columnobject'><input name='date_from' type='text' id="date_from" value='' size="20" />
                                        &nbsp;<a id='date_1' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a></td>
                                    <td width="150" class='columnlabel'><script type='text/javascript'>Calendar.setup({inputField:'date_from',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>
                                        วันที่เอกสารสิ้นสุด&nbsp;</td>
                                    <td width="267" class='columnobject'><input name='date_to' type='text' id="date_to" value='' size="20" />
                                        &nbsp;<a id='date_2' href="javascript:;"><img name='IMAGE4' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a>
                                        <script type='text/javascript'>Calendar.setup({inputField:'date_to',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});</script></td>
                                </tr>
                                <tr>
                                    <td colspan='4' class='blankspace' ></td>
                                </tr>

                                <tr>
                                    <td colspan='4' class='blankspace' align="right">
                                        <input type="button" class="cgcButton_11" name="myBut" value=" Export Data  " onClick="Action_Export()"/>
                                        <input type="button" class="cgcButton_11" name="myBut" value=" ยกเลิก  " onClick="Cancelvalue()"/>                                       </td>
                                </tr>
                                <tr>
                                    <td colspan='4' class='blankspace' ></td>
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
