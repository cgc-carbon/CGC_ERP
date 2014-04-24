<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- calendar stylesheet -->
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <!-- main calendar program -->
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <!-- language for the calendar -->
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <!-- the following script defines the Calendar.setup helper function, which makes
               adding a calendar a matter of 1 or 2 lines of code. -->
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function cancal() {
                cancelAction();
                getId("show1").innerHTML = "";
                getId("show2").innerHTML = "";
            }
            function get_search() {
                showTableNonPopup("show1", "search_date", "../JSP/CS_Show_Report_d_carbon_analysis.jsp?select_case=1&search_date=");
                showTableNonPopup("show2", "search_date", "../JSP/CS_Show_Report_d_carbon_analysis.jsp?select_case=2&search_date=");
            }
            function send_print(doc_id,report_code) {
                getId("doc_id").value = doc_id;
                getId("report_code").value = report_code;
                document.report.submit();
            }
        </script>
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="report" name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="report_code" name="report_code" value=""/>
            <input type="hidden" id="type_report" name="type_report" value="2"/>
            <div align="center">
                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">รายงานการวิเคราะห์ถ่านออกจากเตา (CS_Report_d_carbon_analysis)&nbsp;</td>
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
                                        <td width="30%" align="right">วันที่*&nbsp;</td>
                                        <td class="columnobject"><input type="text" id="search_date" name="search_date" value="" size="10" ><a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField: 'search_date', ifFormat: '%d-%m-%Y', showsTime: false, button: 'date_1', singleClick: true, step: 1});</script>
                                            <input type='button' class="cgcButton_6" name='search' onClick="get_search();" value='ค้นหา'/>
                                            <input type="button" class="cgcButton_3" id="cancel" name="cancel" value="ยกเลิก" onclick="cancal()">
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
                                                        <td class="headergrid" colspan="14">รายงานถ่านออกจากเตา</td>

                                                    </tr>

                                                    <tr>
                                                        <td class="row5" width="6%">No.&nbsp;</td>
                                                        <td class="row5" width="15%">เลขที่เอกสาร&nbsp;</td>
                                                        <td class="row5" width="8%">ชื่อเตา&nbsp;</td>
                                                        <td class="row5" width="5%">เวลา&nbsp;</td>
                                                        <td class="row5" width="8%">ชื่อเตา&nbsp;</td>
                                                        <td class="row5" width="5%">เวลา&nbsp;</td>
                                                        <td class="row5" width="8%">ชื่อเตา&nbsp;</td>
                                                        <td class="row5" width="5%">เวลา&nbsp;</td>
                                                        <td class="row5" width="20%">ผู้รายงาน&nbsp;</td>
                                                        <td class="row5" width="20%">ผู้ตรวจสอบ&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show1"></div>
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
                                                        <td class="headergrid" colspan="14">รายงานการวิเคราะห์ถ่าน</td>

                                                    </tr>

                                                    <tr>
                                                        <td class="row5" width="5%">No.&nbsp;</td>
                                                        <td class="row5" width="20%">เลขที่เอกสาร&nbsp;</td>
                                                        <td class="row5" width="15%">วันที่&nbsp;</td>
                                                        <td class="row5" width="25%">ผู้รายงาน&nbsp;</td>
                                                        <td class="row5" width="25%">ผู้ตรวจสอบ&nbsp;</td>
                                                        <td class="row5" width="10%">สถานะการตรวจสอบ&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 150px; overflow: auto;" id="show2"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' align="right">

                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
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
            </div>
        </form>
    </body>
</html>
