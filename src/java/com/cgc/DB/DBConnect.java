/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;
import java.sql.*;
import java.io.*;

public class DBConnect {
    public static  String CONNECTION_URL = "";
    public static  String CONNECTION_URL_MA = "";
    //public static  String CONNECTION_URL = "jdbc:postgresql://localhost:5432/CGCDB_PRODUCT";
    public static final String USERNAME = "postgres";
    public static final String PASSWORD = "Systemadmin007";   

    //Connect Mysql For Weight Scale System
    public static final String MYSQL_CONNECTION_URL = "jdbc:mysql://bw-rv016.dyndns-web.com:3306/genius_data";
    public static final String MYSQL_USERNAME = "cgc";
    public static final String MYSQL_PASSWORD = "systemadmin";       

    public DBConnect() {
    }    
        
    public Connection openNewConnection() throws Exception {
        Connection conn = null;
        Class.forName("org.postgresql.Driver");
        
        conn = DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
        if (conn == null) {
            throw new SQLException("Cannot initial database connection, because it's NULL.");
        }
        //System.out.println("#: PostgreSQL connection opened := "+conn);
        return conn;
    }

    public Connection openNewConnectionMA() throws Exception {
        Connection conn = null;
        Class.forName("org.postgresql.Driver");
        
        conn = DriverManager.getConnection(CONNECTION_URL_MA, USERNAME, PASSWORD);
        if (conn == null) {
            throw new SQLException("Cannot initial database connection, because it's NULL.");
        }
        //System.out.println("#: PostgreSQL connection opened := "+conn);
        return conn;
    }    

    public Connection openNewConnectionMySQL() throws Exception {
        Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver");       

        conn = DriverManager.getConnection(MYSQL_CONNECTION_URL, MYSQL_USERNAME, MYSQL_PASSWORD);
        if (conn == null) {
            throw new SQLException("Cannot initial database connection, because it's NULL.");
        }
        //System.out.print("DATABASE Connect to : "+MYSQL_CONNECTION_URL);
        //System.out.println("#: mysql connection opened := "+conn);
        return conn;
    }
       

    public void closeConnection(Connection conn) throws Exception {
        if (conn != null) {
            //System.out.println("#: PostgreSQL connection {"+conn+"} has been droped.");
            conn.close();
        }
    }
}