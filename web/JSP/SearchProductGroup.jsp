<%@page import="com.cgc.DB.PGroupDAO"%>
<%@page import="com.cgc.bean.PgroupBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <script type=""  language="javascript" src="../JS/myAjaxFramework.js"></script>
    <%!        PGroupDAO pgDAO = new PGroupDAO();
        ArrayList<PgroupBean> pgList;
        String n,id;
        int chk;
        ThaiUtil tu;
    %>
    <%
                tu = new ThaiUtil();
                n = request.getParameter("by_name");
                id = request.getParameter("by_id");
                chk = Integer.parseInt(request.getParameter("chk"));
                if (chk == 0) {
                    pgList = pgDAO.selectDataAll();
                } else {
                    if (n.equals("")){
                        n = "-";
                    }if (id.equals("")){
                        id = "-";
                    }
                    pgList = pgDAO.selectDataSerBy(tu.EncodeTexttoTIS(n),id);
                }
    %>
</head>
<body>
    <form name="serForm" method="post" action="SearchProductGroup.jsp">
        <input type="hidden" name="chk" value="0">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr >
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">��§ҹ&nbsp;</td>
                    <td width="7" class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <table width="100%" cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="4"  class="blankspace"></td>
                            </tr>

                            <tr>
                              <td height="22" align="right" valign="middle">���� :&nbsp;</td>
                              <td colspan="2" align="left"><input type="text" name="by_name" value="" size="40"/>
                                  <a href="javascript:;" ><img src="../IMAGES/BUTTON/MAIN/SEARCH24.gif" width="17" height="17" border="0" onClick="chkDataSer()"></a></td>
                          </tr>
                            <tr>
                              <td width="10%" align="right" valign="middle">ID :&nbsp;</td>
                            <td colspan="2" align="left"><label>
                                <input type="text" name="by_id" value="" size="40"/>
                                </label></td>
                          </tr>

                            <tr>
                                <td colspan="4" align="center">&nbsp;</td>
                            </tr>

                            <tr>
                              <td class="header2">&nbsp;</td>
                                <td width="27%" class="header2"><div align="left">���ʡ�����Թ���</div></td>
                              <td width="63%" class="header2"><div align="center">���͡�����Թ���</div></td>
                          </tr>

                            <%
                            if(pgList.size()==0){
                            %>
                            <tr>
                                <td colspan="2"> ��辺������ </td>
                                <td></td>
                            </tr>
                            <%
                            }
                            for (PgroupBean empBean : pgList) {
                            %>
                            <tr>
                              <td colspan="2" align="left"><a href="javascript:;" onclick="gettoShow('<%=empBean.getPgroup_id()%>|<%=empBean.getName_t()%>|<%=empBean.getRemark()%>', 'pgroup_id|name_t_pgroup|remark_pgroup')"><%=empBean.getPgroup_id()%></a></td>
                                <td align="left"><%=empBean.getName_t()%></td>
                            </tr>
                            <%}%>
                        </table>
                    </td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3" style="height: 5px">
                    <td width="20" class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2" ></td>
                    <td width="7" class="ffootright"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
<script language="javascript">
    function chkDataSer(){
        document.serForm.chk.value = 1;
        document.serForm.submit();
    }
</script>
</html>
