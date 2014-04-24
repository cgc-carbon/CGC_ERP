<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>  
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>        
        <script type="text/javascript">  
            function check_file(){
                str=document.getElementById('fileToUpload').value.toUpperCase();
                suffix=".XLS";
                suffix2=".xls";
                if(!(str.indexOf(suffix, str.length - suffix.length) !== -1||
                    str.indexOf(suffix2, str.length - suffix2.length) !== -1)){
                    alert('File type not allowed,\nAllowed file: *.XLS,*.xls');
                    document.getElementById('fileToUpload').value='';
                }
            }
        </script>  
    </head>
    <body onunload="closepopup()">
        <form action="../JSP/CS_Upload_Excel.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
            <table  cellpadding="0"  cellspacing="0">
                <tr >
                    <td class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">Import Data&nbsp;(CS_Upload_Excel)</td>
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
                                    <td class="columnlabel"><b>Excel File Name*</b>&nbsp;</td>
                                    <td class="columnobject">
                                        <input type="file" name="myfile" id="myfile" size='45' onchange="check_file(myfile)" >
                                    </td>
                                </tr>
                                <!--tr>
                                    <td class='columnlabel'><b>วันที่เอกสาร</b></td>
                                    <td class='columnobject'><input name='doc_date_from' type='text' id="doc_date_from" value='' />
                                        &nbsp;<a id='date_1'><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date_from',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>&nbsp;&nbsp;
                                    </td>
                                </tr-->                                
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="columnlabel">&nbsp;</td>
                                    <td class="columnobject"><!--input type="submit" name="Submit" value="Submit files"/-->
                                        <input TYPE="image" SRC="../IMAGES/upload-btn.png" width="150" height="47" border="0" ALT="SUBMIT"> 
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
        </form>
    </body>
</html>
