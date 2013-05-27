<%@ page language="java" import="java.sql.*"%>
<html>
<head>
<title> Uni  Example: JSP, Postgres version</title>
</head>
<body bgcolor="white">
<%
        try {
 	    Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            out.println("<h1>Driver not found:" + e + e.getMessage() + "</h1>" );
        }
	try {
	    Connection conn = DriverManager.getConnection (
	    	"jdbc:postgresql://localhost/uni",
		"jdbc", "dbs2013" );

            Statement stmt = conn.createStatement();
            ResultSet rs;

            rs = stmt.executeQuery("SELECT * FROM zettel");
	    out.println( "<table border=1>" );
            while ( rs.next() ) {
	    	int zettel_id = rs.getInt("zettel_id");
                String modul = rs.getString("modul");
                int nr = rs.getInt("zettel_nr");
                String erreichte_pkt = rs.getString("erreichte_pkt");
                out.println("<tr><td>"+zettel_id+"</td><td>"+modul+"</td><td>"+nr+"</td><td>"+
			erreichte_pkt+"</td></tr>" );
            }
	    out.println( "</table>" );

            conn.close();
        } catch (Exception e) {
            out.println( "<h1>exception: "+e+e.getMessage()+"</h1>" );
        }
%>
</body>
</html>
