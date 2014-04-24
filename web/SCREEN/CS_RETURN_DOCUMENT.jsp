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
    </head>
    <body onUnload="closepopup()">
        <%UserBean userbean = (UserBean) session.getAttribute("user");%>
        <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
        <input type="hidden" id="chkNull" value="name_t">
        <input type="hidden" id="status_u" value ="2">
        <input type = "hidden" id ="status_d" value ="3">
        <table  cellpadding="0"  cellspacing="0">
            <tr >
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2">คืนเอกสาร (CS_RETURN_DOCUMENT)</td>
                <td class="ftopright"></td>
            </tr>
            <tr >
                <td class="fcenterleft"></td>
                <td  colspan="2" class="fcentercenter">
                    <div align="left">
                        <table  cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="2"  class="blankspace"></td>
                            </tr>
                            <br>
                            <a href='CS_RETURN_RAWMAT_REC.jsp'>คืนเอกสารการรับถ่านวัตถุดิบ : data_rawmat_rec.txt</a>                            
                            <br>
                            <a href='CS_RETURN_PRODUCT.jsp'>คืนเอกสารการผลิตถ่านกัมมันต์ : data_prod_rec.txt</a>                            
                            <br>
                            <a href='CS_RETURN_CARBON_IN.jsp'>คืนเอกสารถ่านเติมเตา กลับไป ฝ่ายผลิต : data_carbon_in.txt</a>    
                            <br>                            
                            <a href='CS_RETURN_CARBON_IN_WH.jsp'>คืนเอกสารถ่านเติมเตา (ฝ่ายรับวัตถุดิบ) : data_carbon_in_wh.txt</a>    
                            <br>                                                        
                            <a href='CS_RETURN_CARBON_OUT.jsp'>คืนเอกสารรายงานถ่านออกจากเตา : data_carbon_out.txt</a>    
                            <br>
                            <a href='CS_RETURN_CARBON_WITHDRAW.jsp'>คืนเอกสารการเบิกถ่านเพื่อผลิต : data_carbon_withdraw.txt</a>
                            <br>
                            <a href='CS_RETURN_PACKING_PRODUCT.jsp'>คืนเอกสารการบรรจุถ่านกัมมันต์ : data_packing_product.txt</a>
                            <br>
                            <a href='return_doc.pdf'>วิธีการใช้งาน</a>    
                            <br>                                                        
                            <tr>
                                <td colspan='2' class='blankspace'>
                                    <!--br>
                                    <div align="center">
                                        <a href="javascript:;" onClick="cancelAction()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogSave(URLsend('chkNull,size_id,name_t,remark,username','../JSP/CS_202.jsp'))"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                        <a href="javascript:;" onClick="confirmDialogDelete(URLsend('size_id,name_t,remark,status_d,username','../JSP/CS_202.jsp'))"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                    </div>
                                    <br-->
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
