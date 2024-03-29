package com.cgc.DB;

import com.cgc.bean.LoginlogBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Login_Log_DAO {

    public void insert(LoginlogBean logBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO mlogin_log(logid, user_name,session_id, remote_ip, create_date, login_time,login_status) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, logBean.getLogid());
            p.setString(2, logBean.getUser_name());
            p.setString(3, logBean.getSession_id());
            p.setString(4, logBean.getRemort_ip());
            p.setTimestamp(5, logBean.getCreate_date());
            p.setTimestamp(6, logBean.getLogin_time());
            p.setString(7, "Y");
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void update(LoginlogBean logBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mlogin_log SET logout_time=?,login_status=? WHERE session_id=? and logid=?";
        System.out.println("Update SQL = " + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setTimestamp(1, logBean.getLogout_time());
            p.setString(2, "N");
            p.setString(3, logBean.getSession_id());
            p.setString(4, logBean.getLogid());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public LoginlogBean selectChk(String session_id) throws Exception {
        LoginlogBean loginBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From mlogin_log where session_id = '" + session_id + "'";
        System.out.println("sql = " + sql + " -> " + session_id);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            //p.setString(1, loginBean.getSession_id());
            rs = p.executeQuery();
            while (rs.next()) {
                loginBean.setSession_id(rs.getString("session_id"));
                loginBean.setUser_name(rs.getString("username"));
                loginBean.setLogin_time(rs.getTimestamp("login_time"));
                System.out.println("DB Session : " + rs.getString("session_id"));
                System.out.println("DB username : " + rs.getString("username"));
                System.out.println("DB login_time : " + rs.getTimestamp("login_time"));
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return loginBean;
        }
    }

    public void clear_login(LoginlogBean logBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE mlogin_log SET login_status = ? , logout_time = ? WHERE user_name = ? and login_status <> 'N'";
        System.out.println("Check Logout And Update SQL = " + sql);
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "N");
            p.setTimestamp(2, logBean.getLogin_time());
            p.setString(3, logBean.getUser_name());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
