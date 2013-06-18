<%@ page language="java" import="java.sql.*"%>
<html>
	<head><title> Stadtwetter: JSP, Postgres version</title></head>
<body bgcolor="white">
	<h1> Stadtwetter </h1>
	<% String searchCondition = request.getParameter("cond"); 
	   if (searchCondition != null) { %>
	         <H3> Search results for  <I> <%= searchCondition %> </I> </H3>
		       <B> <%= runQuery(searchCondition) %> </B> <HR><BR>
		       <% }  %>
		       <B>Enter a search condition:</B>
		       <FORM METHOD="get"> 
			       <INPUT TYPE="text" NAME="cond" SIZE=30>
			       <INPUT TYPE="submit" VALUE="Submit">
		       </FORM>
</body>
</html>
<%-- Declare and define the runQuery() method. --%>
<%! private String runQuery(String cond) throws SQLException {
	String erg="";

	// query string
	String query;
	query = "select loc.plz,loc.name, sd.wetterstationsid, ws.standort as  Stationsstandort from locations loc join shortest_distance sd on loc.id = sd.locationid join wetterstation ws on ws.s_id = sd.wetterstationsid where name='"+cond+"' or plz='"+cond+"' limit 1;";
	
	try {
 	    Class.forName("org.postgresql.Driver");
	    Connection conn = DriverManager.getConnection (
	    	"jdbc:postgresql://localhost/stadtwetter",
		"jdbc", "dbs2013" );

            Statement stmt = conn.createStatement();
            ResultSet rs;
	    rs = stmt.executeQuery(query);
	    //rs  = stmt.executeQuery(cond);
	    conn.close();
	    return (formatResult(rs));
        } catch (Exception e) {
	return "<h1>exception: "+e+e.getMessage()+"</h1>" ;
	    
	}
}
	private String formatResult(ResultSet rset) throws SQLException {
	StringBuffer sb = new StringBuffer();
	ResultSetMetaData rsmd = rset.getMetaData();
	int columnsNumber = rsmd.getColumnCount();
	if (!rset.next())
	sb.append("<P> No matching rows.<P>\n");
	else {  sb.append("<table border=1><tr>"); 
			
			for (int i=1; i <= columnsNumber; i++) {
			sb.append("<td><b> " +rsmd.getColumnName(i) + " </b></td> ");
			}
			sb.append("</tr><tr>");

		do {  
			for (int i=1; i <= columnsNumber; i++) {
			sb.append("<td>" +rset.getString(i) +  "</td> ");
			
			}
			sb.append("</tr><tr>");
		} while (rset.next());
		sb.append("</td></tr></table>"); 
	}
	return sb.toString();
	}
%>
