<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<head>
    <script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
    <script type="text/javascript">
    </script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
    <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
</head>
<body>
    <form name="serForm" method="get" action="Search_Report.jsp">
        <input type="hidden" name="table" value="<%=request.getParameter("table")%>">
        <input type="hidden" name="page" value="<%=request.getParameter("page")%>">
        <input type="hidden" name="sentdataToshow" value="<%=request.getParameter("sentdataToshow")%>">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr>
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">��§ҹ&nbsp;</td>
                    <td width="7" class="ftopright"></td>
                </tr>
                <tr>
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="4"  class="blankspace"></td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right">���� :</td>
                                <td width="74%" align="left"><input type="text" name="searchid" value="" size="40"/>
                                    <input type="submit" class="cgcButton_6" id="submit" value="����"></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="left">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="header2"><div align="left">����</div></td>
                                <td colspan="3" class="header2"><div align="left">�ѹ���</div></td>
                                <%if (request.getParameter("table").equals("vd_product_receive_header")
                                    ||request.getParameter("table").equals("d_requisition_product_header")) {%>
                                <td colspan="3" class="header2"><div align="left">�Ţ�����駼�Ե</div></td>
                                <%}%>
                            </tr>
                            <%
                                String inputtable = request.getParameter("table");
                                String SQL, SQL2, Encode, strid, memtable, memID, memfillname, sentToshow;


                                int start, screen;
                                int row_page = 15;
                                int total = 0;
                                int count = 0;
                                sentToshow = (String) request.getParameter("sentdataToshow");
                                UtiDatabase objut = new UtiDatabase();
                                DBConnect db = new DBConnect();
                                Connection Conn = db.openNewConnection();
                                if (request.getParameter("searchid") == null) {
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y'"; //and complete_flag ='Y'
                                    total = objut.numRowdatabase(SQL);
                                } else if (request.getParameter("searchid") != null) {
                                    strid = new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620");
                                    //Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
                                    SQL = "Select Count(*) As num from  " + inputtable + " where delete_flag <> 'Y' and doc_id like '" + strid + "%'"; //and complete_flag ='Y'
                                    total = objut.numRowdatabase(SQL);
                                }

                                if (total == 0) {%>
                            <tr>
                                <td colspan="4" align="left">��辺��觷�����</td>

                            </tr></table>
                            <%}
                                int total_page = (int) Math.ceil((double) total / (double) row_page);
                                if (request.getParameter("screen") == null) {
                                    screen = 1;
                                } else {
                                    screen = Integer.parseInt(request.getParameter("screen"));
                                }
                                if (screen >= 1 && screen <= total) {
                                    start = (screen - 1) * row_page;
                                    //row_page=row_page*screen;


                            %>
                            <%!ResultSet rs2;
                                String getshowdata, data2, data3;
                            %>
                            <%
                                String sql2;
                                if (request.getParameter("searchid") == null) {
                                    sql2 = "select * from " + request.getParameter("table") + " where delete_flag <> 'Y'  order by runno desc limit " + row_page + " offset " + start;
                                    rs2 = Conn.createStatement().executeQuery(sql2);
                                } else if (request.getParameter("searchid") != null) {
                                    sql2 = "select * from " + request.getParameter("table") + " where delete_flag <> 'Y' and doc_id like '" + new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620") + "%' order by runno desc limit " + row_page + " offset " + start;
                                    rs2 = Conn.createStatement().executeQuery(sql2);
                                }

                                while (rs2.next()) {
                                    getshowdata = rs2.getString("doc_id");
                                    data2 = "  " + rs2.getString("doc_date");
                                    if (request.getParameter("table").equals("vd_product_receive_header")
                                      ||request.getParameter("table").equals("d_requisition_product_header")) {
                                        //if (!rs2.getString("job_id").equals("")){
                                        data3 = rs2.getString("job_id");
                                    } else {
                                        data3 = "";
                                    }

                            %>
                <tr>
                    <td colspan="3" align="left"><a  href="#" onClick="gettoShow('<%=getshowdata%>','<%=sentToshow%>')"><%=getshowdata%></a></td>
                    <td colspan="3" align="left"><%=data2%></td>
                    <%if (request.getParameter("table").equals("vd_product_receive_header")
                        ||request.getParameter("table").equals("d_requisition_product_header")) {%>
                    <td colspan="3" align="left"><%=data3%></td>
                    <%}%>
                </tr>
                <%


                    }

                %>
            </table>
            <div align="center">
                <%
                    if (screen > 1) {
                        if (request.getParameter("searchid") == null) {%>
                <a href="../JSP/Search_Report.jsp?screen=<%=screen - 1%>&table=<%=request.getParameter("table")%>&sentdataToshow=<%=sentToshow%>">��͹��Ѻ</a>
                <%
                } else if (request.getParameter("searchid") != null) {%>
                <a href="../JSP/Search_Report.jsp?screen=<%=screen - 1%>&table=<%=request.getParameter("table")%>&searchid=<%=new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620")%>&sentdataToshow=<%=sentToshow%>">��͹��Ѻ</a>
                <%
                        }

                    }
                    if ((screen % 10) != 0 && screen <= 10) {
                        for (int i = 1; i <= 10 && i <= total_page; i++) {

                            if (i == screen) {
                %>
                <%="[" + i + "]"%>
                <%
                } else {
                    if (request.getParameter("searchid") == null) {%>
                | <a href="../JSP/Search_Report.jsp?screen=<%=i%>&table=<%=request.getParameter("table")%>&sentdataToshow=<%=sentToshow%>"><%=i%></a> |
                <%
                } else if (request.getParameter("searchid") != null) {%>
                | <a href="../JSP/Search_Report.jsp?screen=<%=i%>&table=<%=request.getParameter("table")%>&searchid=<%=new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620")%>&sentdataToshow=<%=sentToshow%>"><%=i%></a> |
                <%
                            }
                        }

                    }
                } else {
                    for (int y = (screen - 5); y <= (screen + 5) && y <= total_page; y++) {
                        if (y == screen) {
                %>
                <%="[" + y + "]"%>
                <%
                } else {
                    if (request.getParameter("searchid") == null) {%>
                | <a href="../JSP/Search_Report.jsp?screen=<%=y%>&table=<%=request.getParameter("table")%>&sentdataToshow=<%=sentToshow%>"><%=y%></a> |
                <%
                } else if (request.getParameter("searchid") != null) {%>
                | <a href="../JSP/Search_Report.jsp?screen=<%=y%>&table=<%=request.getParameter("table")%>&searchid=<%=new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620")%>&sentdataToshow=<%=sentToshow%>"><%=y%></a> |
                <%
                                }
                            }
                        }
                    }
                    if (screen < total_page) {
                        if (request.getParameter("searchid") == null) {%>
                <a href="../JSP/Search_Report.jsp?screen=<%=screen + 1%>&table=<%=request.getParameter("table")%>&sentdataToshow=<%=sentToshow%>">仢�ҧ˹��</a>
                <%
                } else if (request.getParameter("searchid") != null && request.getParameter("searchtxt") != null) {%>
                <a href="../JSP/Search_Report.jsp?screen=<%=screen + 1%>&table=<%=request.getParameter("table")%>&searchid=<%=new String(request.getParameter("searchid").getBytes("ISO8859-1"), "TIS-620")%>&sentdataToshow=<%=sentToshow%>">仢�ҧ˹��</a>
                <%
                            }
                        } else {
                            ;

                        }
                        rs2.close();
                        Conn.close();
                    }
                %>
            </div></td>
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
