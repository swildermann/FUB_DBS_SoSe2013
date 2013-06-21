/*
 * first approach to get access to stadtwetter db
 *
 * author: 	Christoph van Heteren-Frese
 * mail:	c.vhf@fu-berlin.de
 *
 */

package test;

import java.sql.*;

public class ExampleBean implements java.io.Serializable
{
	private String test;
	//private String searchCondition;
	private ResultSet rs;
	public ExampleBean() {

	}
	// getter an setter methods
	public void setTest(String s) {
		this.test = s;
	}

	public String getTest() {
		return this.test;
	}

	// Declare and define the runQuery() method 
	private String runQuery(String cond) throws SQLException {
		String erg="";

		// simple query string
		String query;
		query = "select loc.plz,loc.name, sd.wetterstationsid, ws.standort as  Stationsstandort from locations loc join shortest_distance sd on loc.id = sd.locationid join wetterstation ws on ws.s_id = sd.wetterstationsid where name='"+cond+"' or plz='"+cond+"' limit 1;";

		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = DriverManager.getConnection (
					"jdbc:postgresql://localhost/stadtwetter",
					"jdbc", "dbs2013" );

			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			//rs  = stmt.executeQuery(cond);
			conn.close();
			return (formatResult(rs));
		} catch (Exception e) {
			return "<h1>exception: "+e+e.getMessage()+"</h1>" ;
		}
	}

	// format resultset
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
}

