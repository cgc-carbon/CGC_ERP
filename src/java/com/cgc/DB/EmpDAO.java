/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.EmpBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author com02
 */
public class EmpDAO {

    public boolean insert(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "INSERT INTO memployee(emp_id, fname,lname,dept_id,status,remark,create_date) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
            p.setString(2, empBean.getFname());
            p.setString(3, empBean.getLname());
            p.setString(4, empBean.getDept_id());
            p.setString(5, empBean.getStatus());
            p.setString(6, empBean.getRemark());
            p.setTimestamp(7, empBean.getCreate_date());
            p.executeUpdate();
            
            return true;

        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public boolean insert_MADB(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "INSERT INTO memployee(emp_id, fname,lname,dept_id,status,remark,create_date) values(?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
            p.setString(2, empBean.getFname());
            p.setString(3, empBean.getLname());
            p.setString(4, empBean.getDept_id());
            p.setString(5, empBean.getStatus());
            p.setString(6, empBean.getRemark());
            p.setTimestamp(7, empBean.getCreate_date());
            p.executeUpdate();
            
            return true;

        } catch (Exception e) {
            return false;
        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public ArrayList<EmpBean> selectDataAll() throws Exception {
        EmpBean empBean = null;
        ArrayList<EmpBean> list = new ArrayList<EmpBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vemployee_fullname where delete_flag <> 'Y' order by runno";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            rs = p.executeQuery();

            while (rs.next()) {
                empBean = new EmpBean();
                empBean.setEmp_id(rs.getString("emp_id"));
                empBean.setFullname(rs.getString("fullname"));
                empBean.setFname(rs.getString("fname"));
                empBean.setLname(rs.getString("lname"));
                empBean.setDept_id(rs.getString("dept_id"));
                empBean.setStatus(rs.getString("status"));
                empBean.setDept_name(rs.getString("depart_name"));
                list.add(empBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }
    }

    public ArrayList<EmpBean> selectDataSerBy(String name, String id) throws Exception {
        EmpBean empBean = null;
        ArrayList<EmpBean> list = new ArrayList<EmpBean>();
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "select * from vemployee_fullname where fname like ? or emp_id like ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, name + "%");
            p.setString(2, id + "%");
            rs = p.executeQuery();

            while (rs.next()) {
                empBean = new EmpBean();
                empBean.setEmp_id(rs.getString("emp_id"));
                empBean.setFullname(rs.getString("fullname"));
                empBean.setFname(rs.getString("fname"));
                empBean.setLname(rs.getString("lname"));
                empBean.setDept_id(rs.getString("dept_id"));
                empBean.setStatus(rs.getString("status"));
                list.add(empBean);
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }

    }
    public EmpBean selectData(String id) throws Exception {
        EmpBean empBean = null;
        DBConnect dbConnect = new DBConnect();
        ResultSet rs = null;
        Connection con = dbConnect.openNewConnection();
        String sql = "SELECT * From vemployee_fullname where emp_id = ? AND delete_flag <> 'Y'";
        PreparedStatement p = null;
            try {
                p = con.prepareStatement(sql);
                p.setString(1, id);
                rs = p.executeQuery();
                while (rs.next()) {
                    empBean = new EmpBean();
                    empBean.setEmp_id(rs.getString("emp_id"));
                    empBean.setFullname(rs.getString("fullname"));
                    empBean.setFname(rs.getString("fname"));
                    empBean.setLname(rs.getString("lname"));
                    empBean.setDept_id(rs.getString("dept_id"));
                    empBean.setStatus(rs.getString("status"));
                    empBean.setDelete_flag(rs.getString("delete_flag"));
                }

        }finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
             return empBean ;
        }
    }
    public void  update(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE memployee SET fname=?,lname=?,dept_id=?,status=?,remark=?,update_date=? where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getFname());
            p.setString(2, empBean.getLname());
            p.setString(3, empBean.getDept_id());
            p.setString(4, empBean.getStatus());
            p.setString(5, empBean.getRemark());
            p.setTimestamp(6, empBean.getUpdate_date());
            p.setString(7, empBean.getEmp_id());


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

    public void  update_MADB(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnectionMA();
        String sql = "UPDATE memployee SET fname=?,lname=?,dept_id=?,status=?,remark=?,update_date=? where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getFname());
            p.setString(2, empBean.getLname());
            p.setString(3, empBean.getDept_id());
            p.setString(4, empBean.getStatus());
            p.setString(5, empBean.getRemark());
            p.setTimestamp(6, empBean.getUpdate_date());
            p.setString(7, empBean.getEmp_id());


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
    
    public void  updateDel(EmpBean empBean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "UPDATE  memployee set delete_flag = 'Y' where emp_id = ?";
        PreparedStatement p = null;

        try {
            p = con.prepareStatement(sql);
            p.setString(1, empBean.getEmp_id());
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
