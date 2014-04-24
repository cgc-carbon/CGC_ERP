/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_productionDB;
import java.util.Random;

/**
 *
 * @author ball
 */
public class Process_production {

    /**
     * @param args the command line arguments
     */
    public String main_check(String job_id) throws Exception {
        StringBuffer String_return = new StringBuffer();
        // TODO code application logic here
        try {
            Random r = new Random();
            Process_productionDB obj = new Process_productionDB();
            String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(job_id);             
            obj.generater_transaction_process(job_id);            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        //String_return.append(" ");
        String_return.append("ประมวลผลเสร็จสิ้น");
        return String_return.toString();

    }
}
