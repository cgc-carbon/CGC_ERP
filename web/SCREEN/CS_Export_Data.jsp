<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js">
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="export_id,name_t,lookup_name,param_name,param_value">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">Export CSV (CS_EXPORT_DATA)</td>
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
                                <td class="columnlabel"><b>รหัสExport_id*</b>&nbsp;</td>
                                <td class="columnobject"><input type='text' name='export_id' size='10' value='' id="export_id" />
                                    &nbsp;<a href='javascript:;' onClick="openBrWindow('mdata_export&stadment=and+status+=+\'Y\'',204,'Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                    <input type='text' name='name_t' size='30' value='' id="name_t" />                              </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชื่อTable*</td>
                              <td class="columnobject"><input name="lookup_name" type="text" id="lookup_name" size="70"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชื่อที่ต้องการให้แสดง*</td>
                                <td class="columnobject"><input name="param_name" type="text" id="param_name" size="90" alt="ระบุชื่อที่ต้องการแสดงในไฟล์ CSV "></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ชื่อColoumของTable*</td>
                              <td class="columnobject"><input name="param_value" type="text" id="param_value" size="90" alt="ระบุชื่อColoumของTableให้ตรงกันกับชื่อที่ต้องการให้แสดง"></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ช่องค้นหารหัส/เลขที่เอกสาร</td>
                                <td class="columnobject"><select name="param_from" id="param_from">
                                        <option value="runno" selected>รหัส/เลขที่เอกสาร</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ช่องค้นหาวันที่เอกสาร</td>
                                <td class="columnobject"><select name="param_value_from" id="param_value_from">
                                        <option value="" selected>ไม่ต้องการ</option>
                                        <option value="doc_date">วันที่เอกสาร</option>
                                    </select>                              </td>
                            </tr>
                            <!--tr>
                                <td class="columnlabel">การเรียงลำดับเพื่อแสดงข้อมูล</td>
                                <td class="columnobject"><select name="order_by" id="order_by">
                                        <option value="" selected>ไม่ต้องการ</option>
                                        <option value="runno">เรียงตามลำดับเอกสาร น้อย->มาก</option>
                                        <option value="runno desc">เรียงตามลำดับเอกสาร มาก->น้อย</option>
                                    </select>
                                </td>
                            </tr-->
                            
                            <tr>
                                <td class="columnlabel">การเรียงลำดับเพื่อแสดงข้อมูล</td>
                              <td class="columnobject"><input name="order_by" type="text" id="order_by" size="90" alt="ระบุชื่อColoumของTableให้ตรงกันกับชื่อที่ต้องการให้แสดง"></td>
                            </tr>
                            
                            <tr>
                                <td class="columnlabel">Flag&nbsp;ต่างๆ</td>
                                <td class="columnobject"><select name="complete_flag" id="complete_flag">
                                        <option value="" selected>ไม่ต้องการ</option>
                                        <option value="Y">complete_flag = Y</option>
                                        <option value="N">complete_flag = N</option>
                                    </select><select name="retro_flag" id="retro_flag">
                                        <option value="" selected>ไม่ต้องการ</option>
                                        <option value="Y">retro_flag = Y</option>
                                        <option value="N">retro_flag = N</option>
                                    </select><select name="cancel_flag" id="cancel_flag">
                                        <option value="" selected>ไม่ต้องการ</option>
                                        <option value="Y">cancel_flag = Y</option>
                                        <option value="N">cancel_flag = N</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หมายเหตุ&nbsp;</td>
                                <td class="columnobject"><textarea name='remark' rows='5' cols='40' id="remark"></textarea></td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,export_id,name_t,lookup_name,param_name,param_value,param_from,param_value_from,order_by,complete_flag,retro_flag,cancel_flag,remark,username','../JSP/CS_Export_Data.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('export_id,name_t,lookup_name,param_name,param_value,param_from,param_value_from,order_by,complete_flag,retro_flag,cancel_flag,remark,status_d,username','../JSP/CS_Export_Data.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>                                    </div>
                                    <br>                                </td>
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
