<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head>
        <title>Question & Answer Page</title>
    </head>
    <body>        
        <h2><center>Return Document คืนเอกสารถ่านเติมเตา กลับไป ฝ่ายผลิต</center></h2>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ page import = "java.lang.*,java.io.*,java.util.*" %>
        <%

        // variables for connecting to the flat file data source
        // Note: this is set up to look in the same directory as the jsp file.
            String fileName = "data_carbon_in.txt";
            BufferedReader br = null;
            FileReader fr;

        //String inputPath = application.getRealPath("/") + File.separatorChar;
            String inputPath = "D:\\CGC_FILE\\";

            System.out.println("inputPath = " + inputPath);

            try {

        // open a bufferedreader to read the file
        // get the current path of the jsp under the application server.
        // 'application' is a freebie from the parent servlet.
                fr = new FileReader(new File(inputPath + fileName));
                br = new BufferedReader(fr);
                String line = br.readLine();

                while (line != null) {
                    out.println("update d_carbon_burn_in_header set complete_flag = 'N' where doc_id = '" + line + "' ;");
                    out.println("<BR>");
                    out.println("update d_carbon_burn_in_detail set complete_flag = 'N' where doc_id = '" + line + "' ;");
                    out.println("<BR>");
                    out.println("delete from d_carbon_burn_in_detail_wh  where doc_id = '" + line + "' ;");
                    out.println("<BR>");
                    out.println("delete from d_carbon_burn_in_header_wh  where doc_id = '" + line + "' ;");
                    out.println("<BR>");
        %>
        <%
                    line = br.readLine();
                }

                br.close();

            } catch (Exception e) {

            }


        %>


    </body>
</html>
