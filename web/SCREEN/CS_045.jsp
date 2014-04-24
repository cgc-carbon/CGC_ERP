<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBeanD_product_receive_detail_prod"%>
<%@page import="com.cgc.DB.D_product_receive_detail_prodDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <META Http-Equiv="Cache-Control" Content="no-cache">
        <META Http-Equiv="Pragma" Content="no-cache">
        <title></title>
        <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
        <script type="text/javascript">
            function goAdd()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,doc_date,machine,shift,size,weight,complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,status_a,username,palate_chk,unit_id,job_type_id,job_type_desc,size_by', '../JSP/CS_045.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show2", "doc_id", "../JSP/CS_Show045.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show045.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 800);
                }
            }
            function goEdit()
            {
                var arrayChk = new Array;
                arrayChk[0] = "chkNull";
                if (ChkParameter(arrayChk))
                {
                    getSave(URLsend('doc_id,wh_in,wh_out,line_no,doc_date,machine,shift,size,weight,complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,status_u,username,palate_chk,unit_id,job_type_id,job_type_desc,size_by', '../JSP/CS_045.jsp'));
                    opener.getId("doc_id").disabled = true;
                    showTable("show2", "doc_id", "../JSP/CS_Show045.jsp?doc_id=");
                    setTimeout('showTable("show2","doc_id","../JSP/CS_Show045.jsp?doc_id=")', 800);
                    setTimeout('window.close()', 800);
                }
            }
            function goBack()
            {
                window.close();
            }
            function select() {
                getId("palate_chk").checked = (getId("palate_chk").value == "Y") ? true : false;
                getId("shift").value = (getId("status_u").value != "") ? getId("selectshift").value : "";
                getId("size_by").value = (getId("status_u").value != "") ? getId("select_size_by").value : "";
                getId("job_type_id").value = (getId("status_u").value != "") ? getId("job_type_id_sel").value : "";


                /*
                 if(getId("status_u").value != "")
                 getId("shift").value = getId("selectshift").value;*/
            }
            function Palate_Status_Chk(invalue) {
                if (invalue) {
                    getId("palate_chk").value = "Y";
                    getId("palate_complete").value = "ครบ"
                } else {
                    getId("palate_chk").value = "N";
                    getId("palate_complete").value = "ไม่ครบ"
                }
            }
            function getStatus() {
                if (getId("radio1").checked) {
                    getId("size_by").value = "S";
                } else if ((getId("radio2").checked)) {
                    getId("size_by").value = "P";
                }
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">        
    </head>
    <%!
        UtiDatabase objuti = new UtiDatabase();
        ThaiUtil en = new ThaiUtil();
        D_product_receive_detail_prodDAO objDAO = new D_product_receive_detail_prodDAO();
        DataBeanD_product_receive_detail_prod objBean = new DataBeanD_product_receive_detail_prod();
        String doc_id, wh_in, wh_out, doc_date, line_no, status_a, status_u, machine, shift, size, weight, complete_code, palate_no, palate_complete, ctc_i2, bag, emp_id, emp_id_desc, palate_chk, unit_id, unit_id_desc, job_type_id, job_type_desc, size_by;
    %>
    <%
        doc_id = "";
        wh_in = "";
        wh_out = "";
        doc_date = "";
        line_no = "";
        status_a = "";
        status_u = "";
        machine = "";
        shift = "";
        size = "";
        weight = "";
        complete_code = "";
        palate_no = "";
        palate_complete = "ไม่ครบ";
        ctc_i2 = "0";
        bag = "";
        emp_id = "";
        emp_id_desc = "";
        palate_chk = "N";
        unit_id = "001";
        unit_id_desc = "กิโลกรัม";
        job_type_id = "";
        job_type_desc = "";
        size_by = "P";
        if (request.getQueryString().indexOf("line_no_") != -1) {
            line_no = request.getQueryString().substring(8, request.getQueryString().indexOf("="));
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            objBean = objDAO.ReturnEdit(doc_id, line_no, objBean);
            wh_in = objBean.getWh_in();
            wh_out = objBean.getWh_out();
            doc_date = request.getParameter("doc_date");
            machine = objBean.getMachine();
            shift = objBean.getShift();
            size = objBean.getSize();
            weight = objBean.getWeight();
            complete_code = objBean.getPalate_complete_code();
            palate_no = objBean.getPalate_no();
            palate_complete = objBean.getPalate_complete();
            ctc_i2 = objBean.getCtc_i2();
            bag = objBean.getBag();
            emp_id = objBean.getEmp_id();
            emp_id_desc = objBean.getEmp_name();
            palate_chk = objBean.getPalate_chk();
            unit_id = objBean.getUnit_id();
            unit_id_desc = objBean.getUnit_name();
            job_type_id = objBean.getJob_type_id();
            job_type_desc = objBean.getJob_type_desc();
            status_u = "2";
            size_by = objBean.getSize_by();
            System.out.println("size_by = " + size_by);
        } else {
            doc_id = en.EncodeTexttoTIS(request.getParameter("doc_id"));
            wh_in = request.getParameter("wh_in");
            wh_out = request.getParameter("wh_out");
            doc_date = request.getParameter("doc_date");
            status_a = request.getParameter("status_a");
        }
    %>

    <body onLoad="select()">
        <input name="username" type="hidden" id="username" value="<%=request.getParameter("username")%>" size="30" readonly/>
        <input type="hidden" id="doc_id" value="<%=doc_id%>">
        <input type="hidden" id="wh_in" value="<%=wh_in%>">
        <input type="hidden" id="wh_out" value="<%=wh_out%>">
        <input type="hidden" id="doc_date" value="<%=doc_date%>">
        <input type="hidden" id="line_no" value="<%=line_no%>">
        <input type="hidden" id="status_a" value="<%=status_a%>">
        <input type="hidden" id="status_u" value="<%=status_u%>">
        <input type="hidden" id="selectshift" value="<%=shift%>">
        <input type="hidden" id="job_type_id_sel" value="<%=job_type_id%>">
        <input type="hidden" id="chkNull" value="machine,shift,size,weight,complete_code,palate_no,palate_complete,ctc_i2,bag,emp_id,job_type_id,job_type_desc">
        <table  cellpadding="0"  cellspacing="0" align="center">
            <tr >
                <td class="ftopleft"></td> 
                <td  class="ftopcenter" colspan="2">ถ่านได้&nbsp;</td>
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
                            <!--tr>
                                   <td class="columnlabel">เครื่องผลิต*&nbsp;</td>
                                   <td class="columnobject">
                                           
                                           <input name='machine' type='text' id="machine" value='<%=machine%>' size='10' />	          	</td>
                            </tr-->
                            <tr>
                                <td class="columnlabel">เครื่องผลิต*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='machine' type='text' id="machine" value='<%=machine%>' size='10' readonly/>	
                                    <a href='#' onClick="openBrWindow('mmachine&textinput=machine', 32, '../JSP/Search_Detail.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>          	</td>
                            </tr>         

                            <tr>
                                <td class="columnlabel">ช่วงเวลาทำงาน(กะ)&nbsp;</td>
                                <td class="columnobject">
                                    <%=objuti.ShowSelectBox("select shift_id,name_t from mshift where shift_grp = '2' order by runno", "shift_id", "name_t", "shift")%><input type="hidden" id="selectshift" value="<%=shift%>">
                                    <!--<select name='shift' id="shift">
                                        <option value='1'>เช้า</option><option value='2'>บ่าย</option><option value='3'>ดึก</option></select>-->&nbsp;&nbsp;                                          	</td>
                            </tr>

                            <tr>
                                <td class="columnlabel">ขนาด*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='size' type='text' id="size" value='<%=size%>' size='10' readonly/> <a href='#' onClick="openBrWindow('m_carbon_size&textinput=size', 32, '../JSP/Search_Detail.jsp');" ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE3' width='20' height='20' border='0' align='middle' ></a>          	
                                </td>
                            </tr>

                            <tr>
                                <td class="columnlabel"></td>
                                <td class="columnobject">
                                    <%=objuti.ShowSelectBox("select size_by,name_t from msize_by order by size_by desc ", "size_by", "name_t", "size_by")%><input type="hidden" id="select_size_by" value="<%=size_by%>">
                                </td>
                            </tr>                        

                            <tr>
                                <td class="columnlabel">หน่วยนับ*</td>
                                <td class="columnobject"><input name="unit_id" type="text" id="unit_id" size="10" value="<%=unit_id%>" readonly>
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('munit_code', 45, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>
                                    <input type="text" name="unit_id_desc" id="unit_id_desc" value="<%=unit_id_desc%>" readonly></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">น้ำหนัก*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='weight' type='text' id="weight" value='<%=weight%>' size='10' onBlur="IsNuber(this.value, this)"/>	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">รหัสครบพาเลท&nbsp;</td>
                                <td class="columnobject">
                                    <input name='complete_code' type='text' id="complete_code" value='<%=complete_code%>' size='30' />	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">พาเลท/ถุงที่*&nbsp;</td>
                                <td class="columnobject">
                                    <input name='palate_no' type='text' id="palate_no" value='<%=palate_no%>' size='10' />	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ครบพาเลท&nbsp;</td>
                                <td class="columnobject">
                                    <input name='palate_complete' type='text' id="palate_complete" value='<%=palate_complete%>' size='10' readonly/>
                                    <input type="checkbox" name="palate_chk" id="palate_chk" value="<%=palate_chk%>" onClick="Palate_Status_Chk(this.checked)">	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">I2&nbsp;</td>
                                <td class="columnobject">
                                    <input name='ctc_i2' type='text' id="ctc_i2" value='<%=ctc_i2%>' size='10'  readonly/><a href='#' onclick="openBrWindow('m_iodine&textinput=ctc_i2', 0, '../JSP/Search_Detail.jsp')"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a></td>
                            </tr>
                            <tr>
                                <td class="columnlabel">หน่วยบรรจุ&nbsp;</td>
                                <td class="columnobject">
                                    <input name='bag' type='text' id="bag" value='<%=bag%>' size='10' onBlur="IsNuber(this.value, this)"/>	          	</td>
                            </tr>
                            <tr>
                                <td class="columnlabel">พนักงานคุมเครื่อง*&nbsp;</td>
                                <td class="columnobject"><input name='emp_id' type='text' id="emp_id" value='<%=emp_id%>' size='10' readonly="readonly" />
                                    &nbsp;<a href='#' onClick="javascript:openBrWindow('Vemployee', 45, '../JSP/Search_Config2.jsp');"><img src='../IMAGES/BUTTON/MAIN/SEARCH20.gif' alt='ค้นหา' name='IMAGE1' width='20' height='20' border='0' align='middle' ></a>&nbsp;&nbsp;&nbsp;
                                    <input name='emp_id_desc' type='text' id="emp_id_desc" value='<%=emp_id_desc%>' size='30' readonly="readonly" />
                                </td>
                            </tr>
                            <tr>
                                <td class="columnlabel">ประเภทงาน*</td>
                                <td class="columnobject"><%=objuti.ShowSelectBox("select job_type_id,name_t from vmjob_type order by runno", "job_type_id", "name_t", "job_type_id")%>&nbsp;<input id="job_type_desc" name="job_type_desc" value="<%=job_type_desc%>" size="30"></td>
                            </tr>

                            <tr>
                                <td colspan='2'  align="right">
                                    <%
                                        if (request.getParameter("status_a") != null) {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="ตกลง" onClick="javascript:goAdd();"/>&nbsp;&nbsp;
                                    <%} else {
                                    %>
                                    <input type="button" class="cgcButton_5" name="button1" value="แก้ไข" onClick="javascript:goEdit();"/>&nbsp;&nbsp;
                                    <%}
                                    %>
                                    <input type="button" class="cgcButton_5" name="button2" value="ยกเลิก" onClick="javascript:goBack();"/>      		  	</td>
                            </tr>

                            <tr>
                                <td colspan='2' class='blankspace'>      		  	</td>
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