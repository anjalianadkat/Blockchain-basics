
<%@page import="java.sql.*"%>
<%@page import=" java.security.*"%>
<%@page import="javax.crypto.*"%>
<%!
private static String algorithm = "DESede";
        private static Key key = null;
        private static Cipher cipher = null;
 private static byte[] encrypt(String input)throws Exception {
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] inputBytes = input.getBytes();
            return cipher.doFinal(inputBytes);
        }
%>
<%!
        private static String decrypt(byte[] encryptionBytes)throws Exception {
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] recoveredBytes =  cipher.doFinal(encryptionBytes);
            String recovered =  new String(recoveredBytes);
                       return recovered;
          }
          %>
<%
String name=request.getParameter("name");
String password=request.getParameter("pass");

StringBuffer buffer=new StringBuffer();
 key = KeyGenerator.getInstance(algorithm).generateKey();
            cipher = Cipher.getInstance(algorithm);
            String input = password;
            byte[] encryptionBytes = encrypt(input);
            String passw=new String(encryptionBytes);
            System.out.println("the password is:"+input);
            System.out.println("encrypted pass is:"+passw);
String connectionURL = "jdbc:mysql://localhost:3306/db";
Connection con=null;
ResultSet rs = null;
ResultSet rs1 = null;

try{
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(connectionURL, "root", "root");
PreparedStatement ps = con.prepareStatement("INSERT INTO user1(name,password) VALUES(?,?)");
ps.setString(1,name);
ps.setString(2,passw);

int i = ps.executeUpdate();
ps.close();
con.close();
}
catch(Exception ex){
System.out.println(ex);
}
%>
<h2 align="center"><font><strong>Retrieve data from database in jsp</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>

</tr>
<tr bgcolor="#A52A2A">
<td><b>user name</b></td>
<td><b>Password</b></td>
</tr>
<%
try{
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection(connectionURL, "root", "root");
	PreparedStatement ps1 = con.prepareStatement("select*from user1");
	rs1= ps1.executeQuery();
	while(rs1.next()){
		%>
		<tr bgcolor="#DEB887">
		<td><%=rs1.getString("name") %></td>
		<td><%=rs1.getString("password") %></td>
		</tr>
		<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
		
%>


