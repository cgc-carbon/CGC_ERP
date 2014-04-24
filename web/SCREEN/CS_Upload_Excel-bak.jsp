
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="../JSP/CS_Upload_Excel.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">
            <table border="2">
                <tr>
                    <td>
                        Specify file:<input name="myfile" type="file" id="myfile">
                    <td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="submit" name="Submit" value="Submit files"/>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
