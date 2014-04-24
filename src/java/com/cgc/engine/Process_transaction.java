/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.engine;

import com.cgc.DB.Process_transactionDB;
import java.util.Random;

/**
 *
 * @author ball
 */
public class Process_transaction {

    /**
     * @param args the command line arguments
     */
    public String main_check(String date_from, String date_to) throws Exception {
        StringBuffer String_return = new StringBuffer();
        // TODO code application logic here
        try {
            Random r = new Random();
            Process_transactionDB obj = new Process_transactionDB();
            String r_create = Long.toString(Math.abs(r.nextLong()), 36);
            //เรียกใช้งานให้ส่ง Parameter ตามนี้ obj.generater_transaction_process(date_from, date_to,process_id,table,doc_type); 
            
            obj.generater_transaction_process("24-12-2556", date_to,"PR_022","vd_rawmatt_receive","+",r_create);            
            obj.generater_transaction_process("21-12-2556", date_to,"PR_029","vd_carbon_burn_out_detail_wh_complete","+",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_034","vd_carbon_withdraw_detail_wh","-",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_036","vd_product_receive_detail_prod_wh_report","+",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_040","vd_packing_product_detail_wh","-",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_040","vd_packing_product_detail_prod_wh","+",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_042","vd_requisition_product_detail_wh","-",r_create);
            obj.generater_transaction_process(date_from, date_to,"PR_114","vd_carbon_return_detail_wh","+",r_create);            
            obj.generater_transaction_process(date_from, date_to,"PR_115","vd_adjust_product_detail","+",r_create);    
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        //String_return.append(" ");
        String_return.append("ประมวลผลเสร็จสิ้น");
        return String_return.toString();

    }
}
