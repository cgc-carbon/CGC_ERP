<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

            function add()
            {   
                confirmDialogSave(URLsend('chkNull,username,pgroup_id,iodine,price_year,price_month_1,price_month_2,price_month_3,price_month_4,price_month_5,price_month_6,price_month_7,price_month_8,price_month_9,price_month_10,price_month_11,price_month_12','../JSP/CS_059.jsp'));                
            }
            function cancle()
            {               
                cancelAction();
            }
           
            function OpenProduct_id(input)
            {
                switch(input){
                    case 1:
                        //alert(getId("price_year").value);
                        if(getId("price_year").value != "price_year"){                                      
                            openBrWindow("vmproduct_price&stadment=and+price_year+=+\'"+getId("price_year").value+"\'", 59, '../JSP/Search_Config2.jsp');
                        } else {
                            alert("กรุณาเลือกปี พ.ศ.");    
                        }                        
                        break;
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
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_059");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
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
            <input type="hidden" id="chkNull" value="price_year,pgroup_id">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <input type="hidden" id="chkstatus" value="1">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">บันทึกราคาต่อหน่วยสินค้า &nbsp;(CS_059)</td>
                    <td class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <div align="left">
                            <table  cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td colspan="4" align="right"><b>หมายเลขเอกสาร : - </b></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>วันที่มีผลบังคับใช้ : - </b></td>
                                </tr>
                                <tr>
                                    <td class="columnlabel"><b>ปี พ.ศ.*&nbsp;</b></td>                               
                                    <td colspan="3" class="columnobject">
                                        <%=objuti.ShowSelectBox("select price_year from vmproduct_price_year order by price_year desc", "price_year", "price_year", "price_year", "price_year", "-")%>

                                    </td>
                                </tr>
                                <tr>
                                    <td width="170" class="columnlabel"><b>กลุ่มสินค้า</b>&nbsp;</td>
                                    <td colspan="3" class="columnobject">
                                        <input name='pgroup_id' type='pgroup_id' id="pgroup_id" value='' size='25' readonly/>
                                        &nbsp;<a href='#' onClick="OpenProduct_id(1)"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;
                                        <!--input type='text' name='prod_name' id="prod_name" size='70' value='' /-->
                                </tr>
                                <tr>                                  
                                    <td class="columnlabel"><b>ช่วงค่า Iodine </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='iodine' type='text' id="iodine" value='' size='15'/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 1 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_1' type='text' id="price_month_1" value='' size='10'/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 2 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_2' type='text' id="price_month_2" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>          
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 3 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_3' type='text' id="price_month_3" value='' size='10'/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 4 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_4' type='text' id="price_month_4" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>     

                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 5 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_5' type='text' id="price_month_5" value='' size='10'/>                                       	          	
                                    </td>
                                </tr> 

                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 6 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_6' type='text' id="price_month_6" value='' size='10'/>                                       	          	
                                    </td>
                                </tr> 
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 7 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_7' type='text' id="price_month_7" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>                                  

                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 8 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_8' type='text' id="price_month_8" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>         
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 9 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_9' type='text' id="price_month_9" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>          

                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 10 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_10' type='text' id="price_month_10" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>         
                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 11 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_11' type='text' id="price_month_11" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>         

                                <tr>                                  
                                    <td class="columnlabel"><b>ราคา/หน่วย เดือนที่ 12 </b></td>
                                    <td colspan="3" class="columnobject">
                                        &nbsp;
                                        <input name='price_month_12' type='text' id="price_month_12" value='' size='10'/>                                       	          	
                                    </td>
                                </tr>                                   

                                <tr>
                                    <td colspan='4' class='blankspace'>
                                        <br>
                                        <div align="center">
                                            <a href="javascript:;" onClick="cancle();"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                            <a href="javascript:;" onClick="add();"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>                                            
                                            <!--a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a-->
                                            <!--a href="javascript:;"  onclick="Chknull()"><img alt="พิมพ์เอกสาร" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a-->
                                        </div>
                                        <br>      		  	
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
        </form>
    </body>
</html>