<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.Login_Log_DAO"%>
<%@page import="com.cgc.bean.LoginlogBean"%>
<%@page import="com.cgc.DB.ReportParamDAO"%>
<%@page import="com.cgc.bean.ReportParamBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.DB.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.McompanyDAO"%>
<%@page import="com.cgc.bean.DataBean_Mcompany"%>
<%@page import="com.cgc.bean.MenuBean"%>
<%@page import="com.cgc.DB.MenuDAO"%>
<%@page import="com.cgc.DB.MessageDAO"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%!    UserDAO useDAO = new UserDAO();
       McompanyDAO McompanyDAO = new McompanyDAO();
    UserBean userBean, selectData;
    DataBean_Mcompany DataBean_Mcompany,selectData_chk;
    String user , pass , year_data;
    ThaiUtil tu;
    MenuDAO menuDAO = new MenuDAO();
    MenuBean subBean, priviledge, mainBean;
    String m, s = new String();
    ArrayList<String> mainList;
    ArrayList<String> subList;
    String menu = new String();

    MessageDAO messageDAO = new MessageDAO();
%>
<%
    selectData = new UserBean();
    selectData_chk = new DataBean_Mcompany();
    tu = new ThaiUtil();
    user = (String) request.getParameter("user");
    pass = (String) request.getParameter("pass");
    year_data = (String) request.getParameter("year_data");
    
    DBConnect.CONNECTION_URL = "jdbc:postgresql://localhost:5432/CGCDB_PRODUCT_" + year_data;
    DBConnect.CONNECTION_URL_MA = "jdbc:postgresql://localhost:5432/MADB_PRODUCT_" + year_data;
    //DBConnect.CONNECTION_URL = "jdbc:postgresql://202.183.167.55:5432/CGCDB_PRODUCT_" + year_data;
    

    //byte[] pass_encode = Base64.encodeBase64(pass.getBytes());
    //byte[] pass_decode = Base64.decodeBase64(pass_encode);

    System.out.println("pass before encode 64 Bit = " + pass);
    //System.out.println("pass_encode encode 64 Bit = " + new String(pass_encode));
    //System.out.println("pass_encode decode 64 Bit = " + new String(pass_decode));

    selectData.setUsername(tu.EncodeTexttoTIS(user));
    selectData.setPassword(tu.EncodeTexttoTIS(pass));
    //selectData.setPassword(new String(pass_encode));
    userBean = useDAO.selectData(selectData);    
    DataBean_Mcompany = McompanyDAO.selectData_chk(selectData_chk);       
    
    if (userBean == null) {
        out.print("Username หรือ Password ไม่ถูกต้อง!!!");
    } else {
        //if(userBean.getUse_status().equals("Y")){
        userBean.setSelect_database("CGCDB_PRODUCT_"+year_data);
        userBean.setMessage_disp(messageDAO.selectData_MSG());        
        out.print("LOGIN");
        session.removeAttribute("menu");
        menu = "";
        m = "";
        s = "";
        mainList = new ArrayList<String>();
        subList = new ArrayList<String>();
        subBean = new MenuBean();
        priviledge = menuDAO.selectPriviledge(userBean.getPriviledge_id());
        m = priviledge.getMain_menu_id();
        s = priviledge.getSub_menu_id();

        do {
            mainList.add(m.substring(0, m.indexOf(",")));
            m = m.substring(m.indexOf(",") + 1, m.length());
        } while (m.length() > 0);
        do {
            subList.add(s.substring(0, s.indexOf(",")));
            s = s.substring(s.indexOf(",") + 1, s.length());
        } while (s.length() > 0);
        mainBean = new MenuBean();
        ReportParamBean rpBean = new ReportParamBean();
        ReportParamDAO rpDAO = new ReportParamDAO();
        String x;
        for (String list : mainList) {
            mainBean = menuDAO.selectMainMenu(list);
            if (menu.equals("")) {
                menu = menu + "[\"+" + mainBean.getName_t() + "\",\"\", path+\"deluxe-tree.files/xpicon1_s.gif\", \"\", \"\", \"XP Title Tip\", \"\", \"0\", \"\", \"\", ],";
            } else {
                menu = menu + "[\"" + mainBean.getName_t() + "\",\"\", \"\", \"\", \"\", \"XP Title Tip\", \"\", \"1\", \"0\", \"\", ],";
            }

            for (String s_list : subList) {
                if (s_list.charAt(1) == list.charAt(3)) {
                    subBean = menuDAO.selectSubMenu(s_list);
                    if (subBean.getMain_menu_id().equals(list)) {
                        if (list.charAt(3) == '4' || list.charAt(3) == '7' || list.charAt(3) == '9') {
                            if (list.charAt(3) == '7') {
                                rpBean = rpDAO.selectData(subBean.getScreen_id());
                                menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('CS_REPORT.jsp?report_code=" + subBean.getScreen_id() + "&lookup=" + rpBean.getLookup_name() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                            } else if (list.charAt(3) == '9') {
                                //rpBean = rpDAO.selectData(subBean.getScreen_id());
                                menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('CS_REPORT_4.jsp?report_code=" + subBean.getScreen_id() + "&lookup=" + rpBean.getLookup_name() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                            } else {
                                menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('CS_REPORT.jsp?report_code=" + subBean.getScreen_id() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                            }
                        } else if (list.charAt(3) == '5' || list.charAt(3) == '8') {
                            rpBean = rpDAO.selectData(subBean.getScreen_id());
                            menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('CS_REPORT_2.jsp?report_code=" + subBean.getScreen_id() + "&lookup=" + rpBean.getLookup_name() + "&doc_no=" + subBean.getDoc_no() + "&eff_date=" + subBean.getDoc_eff_date() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                        } else if (list.charAt(3) == '6') {
                            menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('CS_REPORT_3.jsp?report_code=" + subBean.getScreen_id() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                        } else {
                            menu = menu + "[\"|" + subBean.getName_t() + "\",\"javascript:linkpage('" + subBean.getScreen_id() + "." + subBean.getPage_type() + "?submenu_id=" + subBean.getSub_menu_id() + "');\", \"" + subBean.getImg() + "\", \"" + subBean.getImg_swap() + "\", \"\", \"\", \"\", \"\", \"\", \"\", ],";
                        }
                    }
                }
            }
        }
        
        session.setAttribute("menu", menu);
        session.setAttribute("user", userBean);
        session.setAttribute("name_t", DataBean_Mcompany);
        session.setMaxInactiveInterval(3600);

        System.out.println("User Bean = " + userBean);
        System.out.println("getFullname Bean = " + userBean.getFullname());
        System.out.println("getEmp_id Bean = " + userBean.getEmp_id());
        System.out.println("Print Count = " + userBean.getPrint_count());

        //HttpServletRequest request = (HttpServletRequest)mc.get(MessageContext.SERVLET_REQUEST);
        LoginlogBean logBean = new LoginlogBean();
        Login_Log_DAO logDAO = new Login_Log_DAO();
        Timestamp ts = new Timestamp(new java.util.Date().getTime());
        logBean.setLogid(ts.toString());
        logBean.setUser_name(userBean.getUsername());
        logBean.setSession_id(request.getSession().getId());
        logBean.setRemort_ip((String) request.getRemoteAddr());
        logBean.setCreate_date(ts);
        logBean.setLogin_time(ts);
        logDAO.clear_login(logBean);
        logDAO.insert(logBean);
        session.setAttribute("logid", ts.toString());    
        session.setAttribute("session_id", request.getSession().getId()); 
        //}else out.print("Username หรือ Password ไม่ถูกต้อง!!!");
    }
%>