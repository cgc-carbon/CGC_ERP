<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<!--%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%-->
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.bean.UserBean"%>
<html>
    <%!    String path, lookup, doc_eff_date, doc_no;
    %>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="../JS/jscalendar/skins/aqua/aqua.css" title="Aua" />
        <script type="text/javascript" src="../JS/jscalendar/calendar.js"></script>
        <script type='text/javascript' src='../JS/jscalendar/lang/calendar-th.js'></script>
        <script type="text/javascript" src="../JS/jscalendar/calendar-setup.js"></script>
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/ui-lightness/jquery-ui-1.8.17.custom.css" />
        <link rel="stylesheet" media="all" type="text/css" href="../CSS/timepicker.css" />
        <script type="text/javascript" src="../JS/jquery/jquery-1.7.1.min.js"></script>        
        <script type="text/javascript" src="../JS/jquery/jquery-ui-1.8.17.custom.min.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-timepicker-addon.js"></script>
        <script type="text/javascript" src="../JS/jquery/jquery-ui-sliderAccess.js"></script>
        <script type="text/javascript" src="../JS/TimeFramwork.js"></script>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>CARBON OUT ANALYSIS</title>
        <script type="text/javascript">
            function getStatus(){
                if(document.getElementById("radio1").checked){
                    document.getElementById("approve_status").value = "N";
                    alert("��سҵ�Ǩ�ͺ�͡������º����"+document.getElementById("approve_status").value);
                }else if((document.getElementById("radio2").checked)){
                    document.getElementById("approve_status").value = "Y";
                    alert("��Ǩ�ͺ�͡������º�������� "+document.getElementById("approve_status").value);
                }
            }              
            function Chknull(){
                if(document.getElementById('doc_id').value == ''){
                    alert('��س����������Ţ����͡���');
                }else document.report.submit();
            }
            function goAddChild(URLSend)
            {
                var arryChk = new Array;
                arryChk[0] = "chkNull"
                if(ChkParameter(arryChk))
                {
                    window.open(URLSend[0]);
                }
                
            }
            function cancle()
            {
                location.replace("CS_D_carbon_out_analysis.jsp");
            }
            function ckall(Value)//�ӡ�á����� check ���������������
            {

                for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                {
                    document.getElementsByName("ckbox")[i].checked = Value;
                }
		
            }
            function goDelChild()
            {
                var Deleteflag ="";
                var SURL;
                if(getId("chk_all").checked)//�зӡ��ź�����Ţͧ Detail ������ ���ç�Ѻ����
                {
                    SURL = "../JSP/CS_Detail_D_carbon_out_analysis.jsp?status_d=3&chk_all=1&username="+getId("username").value;
                    SURL = SURL+"&doc_id="+getId("doc_id").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");
                    getId("chk_all").checked =false;
                }
                else//�зӡ��ź������੾�� Detail ���ӡ�����͡���
                {
                    SURL = "../JSP/CS_Detail_D_carbon_out_analysis.jsp?status_d=3&ckbox=";
                    for(var i=0;i<document.getElementsByName("ckbox").length;i++)
                    {
                        Deleteflag += (document.getElementsByName("ckbox")[i].checked)?(i+1).toString()+",":"";
                    }
                    
                    Deleteflag = Deleteflag.substring(0, Deleteflag.length -1);
                    SURL = SURL+Deleteflag+"&doc_id="+getId("doc_id").value+"&username="+getId("username").value;
                    Delete_Line_no(SURL);
                    showTableNonPopup("show", "doc_id", "../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=");
                    setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=")', 100);
                }
            }
            function OpenEdit(URLSend)
            {
                window.open(URLSend[0]);
            }
            function AddHeader()
            {
                var select_id = "";
                var r = confirm("�س��ͧ��úѹ�֡�������")
                if (approve_status==''){approve_status="N"}; 
                if(r)
                {
                    if(parseInt(getId("maxline").value, 10) != 0){
                        for(var i = 1;i<= parseInt(getId("maxline").value, 10);i++){
                            select_id += "c_type1_"+(i)+",bu1_"+(i)+",avg1_"+(i)+",c_type2_"+(i)+",bu2_"+(i)+",avg2_"+(i)+",c_type3_"+(i)+",bu3_"+(i)+",avg3_"+(i)+",";
                        }
                        select_id += select_id.substr(0, select_id.length -1);                                                 
                        getSave(URLsend('chkNull,doc_id,doc_date,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate2,tname3,ttime3,reporter_id,approve_id,approve_status,username,maxline,'+select_id,'../JSP/CS_D_carbon_out_analysis.jsp'));
                        getId("status_cancle").value = "";
                        getId("child_ck").value = "";
                        //getId("child_ck").value = "";
                        getId("maxline").value = "0";
                        getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner3\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    }
                    else{                        
                        getSave(URLsend('chkNull,doc_id,doc_date,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3,reporter_id,approve_id,approve_status,username,maxline','../JSP/CS_D_carbon_out_analysis.jsp'));
                        getId("status_cancle").value = "";
                        //getId("child_ck").value = "";
                        getId("child_ck").value = "";
                        getId("maxline").value = "0";
                        getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner3\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    }
                    
                }
            }
            function Delete()
            {
                var r = confirm("�س��ͧ���ź�����ŷ������������")
                if(r)
                {
                    getSave(URLsend('chkNull,doc_id,status_d,username','../JSP/CS_D_carbon_out_analysis.jsp'))
                    getId("status_cancle").value = "";
                    getId("child_ck").value = "";
                    getId("child_ck").value = "";
                    getId("maxline").value = "0";
                    getId("show").innerHTML = "<table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" class=\"inner3\"  name = \"tbdetail\" id = \"tbdetail\"></table>";
                    
                }
            }
            function Unload()
            {
            }
            function OpenDoc_id()
            {
                openBrWindow('vd_carbon_out_analysis_header&stadment=and+approve_status+<>+\'Y\'', 313, '../JSP/Search_Doc_id.jsp');
            }
            function OpenDoc_id_approve()
            {
                openBrWindow('vd_carbon_out_analysis_header&stadment=and+approve_status+=+\'Y\'', 313, '../JSP/Search_Doc_id.jsp');
            }
            
            function CreateNewRow()
            {
                var intLine = parseInt(getId("maxline").value);

                if(intLine == 0){
                    for(var i = 1; i <= 24;i++){
                        intLine++;
                        var theTable = document.getElementById("tbdetail");
                        var newRow = theTable.insertRow(theTable.rows.length);
                        newRow.id = newRow.uniqueID;
                        var newCell;
                        newCell = newRow.insertCell(0)
                        newCell.id = newCell.uniqueID
                        newCell.setAttribute("width", "6%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td ><input type = 'checkbox' id = 'ckbox_"+(intLine)+"' name = 'ckbox'></td>"
                        newCell = newRow.insertCell(1)
                        newCell.setAttribute("width", "11%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td>"+(intLine)+"&nbsp;</td>"
                        newCell = newRow.insertCell(2)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        //if (intLine==1||intLine==13){ 
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type1_"+(intLine)+"\" ID=\"c_type1_"+(intLine)+"\" VALUE="+(getId("ctype").value)+"></td>"
                        //} else {
                        //newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type1_"+(intLine)+"\" ID=\"c_type1_"+(intLine)+"\" VALUE=\"\" ></td>"    
                        //}    
                        newCell = newRow.insertCell(3)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu1_"+(intLine)+"\" ID=\"bu1_"+(intLine)+"\" VALUE=\"\" onkeypress=\"IsNuber(this.value, this)\"></td>"
                        newCell = newRow.insertCell(4)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg1_"+(intLine)+"\" ID=\"avg1_"+(intLine)+"\" VALUE=\"\" ></td>"
                        newCell = newRow.insertCell(5)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        //newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type2_"+(intLine)+"\" ID=\"c_type2_"+(intLine)+"\" VALUE=\"C\" ></td>"
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type2_"+(intLine)+"\" ID=\"c_type2_"+(intLine)+"\" VALUE="+(getId("ctype").value)+"></td>"
                        newCell = newRow.insertCell(6)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu2_"+(intLine)+"\" ID=\"bu2_"+(intLine)+"\" VALUE=\"\" onkeypress=\"IsNuber(this.value, this)\"></td>"
                        newCell = newRow.insertCell(7)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg2_"+(intLine)+"\" ID=\"avg2_"+(intLine)+"\" VALUE=\"\" ></td>"

                        newCell = newRow.insertCell(8)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        //newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type3_"+(intLine)+"\" ID=\"c_type3_"+(intLine)+"\" VALUE=\"C\" ></td>"
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type3_"+(intLine)+"\" ID=\"c_type3_"+(intLine)+"\" VALUE="+(getId("ctype").value)+"></td>"
                        newCell = newRow.insertCell(9)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu3_"+(intLine)+"\" ID=\"bu3_"+(intLine)+"\" VALUE=\"\" onkeypress=\"IsNuber(this.value, this)\"></td>"
                        newCell = newRow.insertCell(10)
                        newCell.setAttribute("width", "13%");
                        newCell.setAttribute("class", "forborder");
                        newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg3_"+(intLine)+"\" ID=\"avg3_"+(intLine)+"\" VALUE=\"\" ></td>"

                    }
                }else{
                    intLine++;
                    var theTable = document.getElementById("tbdetail");
                    var newRow = theTable.insertRow(theTable.rows.length);
                    newRow.id = newRow.uniqueID;
                    var newCell;
                    newCell = newRow.insertCell(0)
                    newCell.id = newCell.uniqueID
                    newCell.setAttribute("width", "6%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td ><input type = 'checkbox' id = 'ckbox_"+(intLine)+"' name = 'ckbox'></td>"
                    newCell = newRow.insertCell(1)
                    newCell.setAttribute("width", "11%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td>"+(intLine)+"&nbsp;</td>"
                    newCell = newRow.insertCell(2)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type1_"+(intLine)+"\" ID=\"c_type1_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(3)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu1_"+(intLine)+"\" ID=\"bu1_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(4)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg1_"+(intLine)+"\" ID=\"avg1_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(5)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type2_"+(intLine)+"\" ID=\"c_type2_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(6)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu2_"+(intLine)+"\" ID=\"bu2_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(7)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg2_"+(intLine)+"\" ID=\"avg2_"+(intLine)+"\" VALUE=\"\" ></td>"

                    newCell = newRow.insertCell(8)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"c_type3_"+(intLine)+"\" ID=\"c_type3_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(9)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"bu3_"+(intLine)+"\" ID=\"bu3_"+(intLine)+"\" VALUE=\"\" ></td>"
                    newCell = newRow.insertCell(10)
                    newCell.setAttribute("width", "13%");
                    newCell.setAttribute("class", "forborder");
                    newCell.innerHTML = "<td><INPUT TYPE=\"text\" SIZE=\"10\" NAME=\"avg3_"+(intLine)+"\" ID=\"avg3_"+(intLine)+"\" VALUE=\"\" ></td>"


            }
                
                getId("maxline").value = intLine;
                
            }
            function RemoveRow()
            {
                var intLine = parseInt(getId("maxline").value);
                if(parseInt(intLine) > 0)
                {
                    var theTable = (document.all) ? document.all.tbExp : document.getElementById("tbdetail");
                    var theTableBody = theTable.tBodies[0];
                    theTableBody.deleteRow(intLine-1);
                    intLine--;
                    getId("maxline").value = intLine;
                }
            }
            function showdetail(){
                setTimeout('showTableNonPopup("show", "doc_id", "../JSP/CS_ShowD_carbon_out_analysis.jsp?doc_id=")', 500);
            }
        </script>
    </head>

    <body onUnload="Unload()" >
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">

            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_D_carbon_out_analysis");

                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S808");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                //_______________________________________________________________report
%>
            <input name="username" type="hidden" id="username" value="<%=userbean.getUsername()%>" size="30" readonly/>
            <input type="hidden" id="chkNull" value="doc_date">
            <input type="hidden" id="date_ck" name="date_ck" value="">
            <input type="hidden" id="status_a" value="1"><!-- �繡����������������-->
            <input type="hidden" id="status_d" value="3"><!-- �繡�� Delete �����ŷ����� -->
            <input type="hidden" id="status_cancle" value=""><!-- status_cancle = 1 ��ͤ�ҷ����� Edit ���� ="" ���繡�� Insert -->
            <input type="hidden" id="child_ck" name="child_ck" value="">
            <input type="hidden" name="maxline" value="0" id="maxline">
            <!---------------------------------------------------report----------------------------->
            <input type="hidden" id="report_code" name="report_code"  value="<%=path%>">
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">
            <div align="center">
                <table  cellpadding="0"  cellspacing="0">
                    <tr >
                        <td class="ftopleft"></td>
                        <td  class="ftopcenter" colspan="2">����������س�Ҿ��ҹ�͡�ҡ�� 
                            (CS_D_carbon_out_analysis)&nbsp;</td>
                        <td class="ftopright"></td>
                    </tr>
                    <tr >
                        <td class="fcenterleft"></td>
                        <td  colspan="2" class="fcentercenter">
                            <div align="center">
                                <table  cellpadding="0" cellspacing="0" >
                                    <tr>
                                        <td colspan="2" align="right"><strong>�����Ţ�͡��� :<%=objs_p.getIso_no()%> </strong></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right"><strong>�ѹ����ռźѧ�Ѻ�� :<%=objs_p.getEffective_date()%></strong></td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">ʶҹС�õ�Ǩ�ͺ</td>
                                        <td class="columnobject">&nbsp;&nbsp;
                                            <input type="hidden" id="approve_status" >
                                            <input type="radio" name="radio" id="radio1" onClick="getStatus()" checked>
                                            �ѧ������Ǩ�ͺ 
                                            <input type="radio" name="radio" id="radio2" onClick="getStatus()">
                                            ��Ǩ�ͺ����</td>
                                    </tr>                                      
                                    <tr>
                                        <td width="150" class="columnlabel"><strong>�Ţ����͡���*</strong>&nbsp;</td>
                                        <td width="503" class="columnobject">
                                            <input name='doc_id' type='text' id="doc_id" value='' size='12'  />
                                            &nbsp;<a href='#' onClick="OpenDoc_id()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='����' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;�ѹ����͡���*&nbsp;
                                            <input name='doc_date' type='text' id="doc_date" value='' size='10' readonly="readonly" />
                                            &nbsp;<a id='date_1' ><img name='IMAGE2' src='../IMAGES/BUTTON/MAIN/CALENDAR20.gif' border='0' align='absmiddle'></a><script type='text/javascript'>Calendar.setup({inputField:'doc_date',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_1',singleClick:true,step:1});</script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="150" class="columnlabel"><strong>�Ţ����͡���(��Ǩ�ͺ����)</strong>&nbsp;</td>
                                        <td width="503" class="columnobject">
                                            <!--input name='doc_id' type='text' id="doc_id" value='' size='10' readonly/-->
                                            &nbsp;<a href='#' onClick="OpenDoc_id_approve()" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='����' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div style="width:100%;">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3">
                                                    <tr>
                                                        <td class="columnlabel"><strong>������</strong>&nbsp;</td>
                                                        <td class="columnobject">
                                                            <select name="ctype" id="ctype">
                                                                <option value="C" selected>C ��ҹ����</option>
                                                                <option value="P">P ��ҹ�����</option>
                                                                <option value="U">U ��ҹ����٤��</option>
                                                                <option value="B">B ��ҹ�����</option>
                                                            </select></td>
                                                    </tr>                                                      
                                                    <tr>
                                                        <td colspan="5" class="h_multi">�����š����������</td>
                                                        <td colspan="6" class="btn_multi">
                                                            <input type='button' class="cgcButton_4" name='but1' value='  ����  ' onClick="javascript:getId('status_cancle').value == '1'?goAddChild(URLsend('doc_id,username,status_a,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3','CS_Detail_D_carbon_out_analysis.jsp')):CreateNewRow();"/>
                                                            <input type='button' class="cgcButton_3" name='but2' value='   ź  ' onclick="javascript:getId('status_cancle').value == '1'?goDelChild():RemoveRow()"/>                                                </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="row3" width="3%">&nbsp;</td>
                                                        <td class="row3" width="7%"> </td>
                                                        <td class="row3" width="15%">�ѹ���<br><a id='date_2' ><input name="tdate1" type="text" id="tdate1" size="10" onmousedown="Calendar.setup({inputField:'tdate1',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_2',singleClick:true,step:1});"></a></td>
                                                        <td class="row3" width="15%">�����Ţ��<br><input name="tname1" type="text" id="tname1" size="10" maxlength="1" ></td>
                                                        <td class="row3" width="15%">���� (�.)<br><input name='ttime1' type='text' id="ttime1" value='' size='10' maxlength="5"  onkeypress="Time_picker(this.id)" /></td>                                                             
                                                        <td class="row3" width="15%">�ѹ���<br><a id='date_3' ><input name="tdate2" type="text" id="tdate2" size="10" onmouseover="Calendar.setup({inputField:'tdate2',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_3',singleClick:true,step:1});"></a></td>
                                                        <td class="row3" width="15%">�����Ţ��<br><input name="tname2" type="text" id="tname2" size="10" maxlength="1"></td>
                                                        <td class="row3" width="15%">���� (�.)<br><input name='ttime2' type='text' id="ttime2" value='' size='10' maxlength="5"  onkeypress="Time_picker(this.id)" /></td> 
                                                        <td class="row3" width="15%">�ѹ���<br><a id='date_4' ><input name="tdate3" type="text" id="tdate3" size="10" onmouseover="Calendar.setup({inputField:'tdate3',ifFormat:'%d-%m-%Y',showsTime:false,button:'date_4',singleClick:true,step:1});"></a></td>
                                                        <td class="row3" width="15%">�����Ţ��<br><input name="tname3" type="text" id="tname3" size="10" maxlength="1"></td>
                                                        <td class="row3" width="15%">���� (�.)<br><input name='ttime3' type='text' id="ttime3" value='' size='10' maxlength="5"  onkeypress="Time_picker(this.id)" /></td>                                                        
                                                    </tr>
                                                    <tr>
                                                        <td class="row3"><input type="checkbox" id="chk_all" name="chk_all" value="chk_all" onClick="javascript:ckall(this.checked);"/></td>
                                                        <td class="row3">�ӴѺ���</td>
                                                        <td class="row3">��Դ</td>
                                                        <td class="row3">���෹�</td>
                                                        <td class="row3">���� </td>
                                                        <td class="row3">��Դ</td>
                                                        <td class="row3">���෹</td>
                                                        <td class="row3">���� </td>
                                                        <td class="row3">��Դ</td>
                                                        <td class="row3">���෹</td>
                                                        <td class="row3">���� </td>                                                        
                                                    </tr>
                                                </table>
                                            </div>
                                            <div style="width:100%; height: 560px; overflow: auto;" id="show">
                                                <table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3"  name = "tbdetail" id = "tbdetail"></table>
                                            </div>                                </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">&nbsp;</td>
                                        <td class="columnobject">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">�����§ҹ</td>
                                        <td class="columnobject"><input name="reporter_id" type="text" id="reporter_id" size="15">
                                            <a href='#' onClick="openBrWindow('Vemployee', 313, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='����' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                            <input name="reporter_id_desc" type="text" id="reporter_id_desc" size="30">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="columnlabel">����Ǩ�ͺ</td>
                                        <td class="columnobject"><input name="approve_id" type="text" id="approve_id" size="15">
                                            <a href='#' onClick="openBrWindow('Vemployee1', 313, '../JSP/Search_Config2.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='����' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                            <input name="approve_id_desc" type="text" id="approve_id_desc" size="30">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class='blankspace'>
                                            <br>
                                            <div align="center">
                                                <a href="javascript:;" onClick="cancle()"><img alt=""  src="../IMAGES/BTN_CANCEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="AddHeader()"><img alt=""  src="../IMAGES/BTN_SAVE_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;" onClick="Delete()"><img alt=""  src="../IMAGES/BTN_DEL_90.png" width="80" height="30" border="0"></a>
                                                <a href="javascript:;"  onclick="Chknull()"><img alt="������͡���" src="../IMAGES/BTN_PRINT_90.png" width="80" height="30" border="0"></a></div>
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
            </div>
        </form>
    </body>
</html>
