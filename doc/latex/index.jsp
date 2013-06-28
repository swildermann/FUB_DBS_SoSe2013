<%--
Webanwendung Stadwetter
- ermoeglicht eine einfache Datenbankabfrage der StadtwetterDb
- genutzte Technologien: 
    - JSP (JSTL, EL) 
    - CSS, JavaScript (nur Kosmetik)

- Authoren: Christoph van Heteren-Frese, Sven Wildermann
- Erstellt in Berlin am 19.06.2013
- dokumentierter Stand vom 24. Juni 2013
--%>

<%-- Expression language einschalten  --%>
<%@ page isELIgnored="false" %>

<%-- JSTL einbinden --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 

<%-- Beans einbinden --%>
<jsp:useBean id="date" class="java.util.Date" /> 

<!DOCTYPE html>
<html>
  <head>
	<%-- Design und Titel einbinden --%>
    <link href="design.css" type="text/css" rel="stylesheet">
    <title>DBS 2013 Stadtwetter Web-App</title>
  </head>
  <body>
    <h1>Stadtwetter Wep-App</h1>

    <%-- Formularfelder fuer die Nutzereigabe erzeugen--%>
    <form method="get"> 
      <h4>Bitte Auswahl treffen:</h4>
      <input type="text" name="cond" value="Plz, Ort oder Ortsteil" size=30 
      onFocus="if(this.value=='Plz, Ort oder Ortsteil') this.value=''"><br>
      Datum festlegen:<br> 
      <input type="date" name="date" id="date" value="2013-01-01"><br>
      Zeitraum angeben &nbsp; <input onclick="document.getElementById('auswahl').disabled = false;" 
      type="checkbox" name="type"><br>
      <input type="date" name="date2" id="auswahl" value="2013-02-01" disabled="disabled"><br>
      Optionen:<br>
      Detailierte Darstellung &nbsp; <input type="checkbox" name="details"><br>
      <input type="submit" value="Suchen">
    </form>

    <%-- Falls eine Eingabe gemacht wurde, zeige das Ergebnis --%>
    <c:if test="${not empty param.cond}">
    <c:set var="date2" value="${param.date}" />
    <c:if test="${not empty param.date2}">
    <c:set var="date2" value="${param.date2}" />
    </c:if>

    <%-- Datenbank einbinden --%>
    <sql:setDataSource  driver="org.postgresql.Driver" 
                        url="jdbc:postgresql://localhost/stadtwetter"
                        user="jdbc"
                        password="dbs2013" 
                        scope="request"/>

    <%-- Datenbankabfrage --%>
    <sql:query var="ablage"   sql="SELECT DISTINCT wm.datum, wm.sonnenscheindauer, 
                              wm.mittel_windstaerke, wm.mittel_bedeckungsgrad, 
                              wm.niederschlagshoehe, wm.mittel_2m
                              FROM (SELECT * FROM locations WHERE name like '${param.cond}' OR  
							  plz='${param.cond}' LIMIT 1) AS loc
                              JOIN shortest_distance sd ON (loc.id = sd.locationid)  
                              JOIN wetterstation ws ON (ws.s_id = sd.wetterstationsid) 
                              JOIN fuehrt_durch fd ON (ws.s_id = fd.s_id )
                              JOIN (SELECT DISTINCT * FROM wettermessung) AS wm 
                              ON (fd.s_id = wm.stations_id) WHERE wm.datum BETWEEN '${param.date}' 
							  AND '${date2}' ORDER BY wm.datum;"/>
	<%-- ueberschrift erzeugen --%>
    <h2>Ergebnisse f&uuml;r ${param.cond}:</h2>

    <%-- Konstruktion einer einfachen Tabelle inklusive Werte--%>
	<%-- die ueberschriften werden direkt aus der Datenbank geholt --%>

    <c:forEach items="${ablage.rows}" var="currRow">
    <div class="CSSTableGenerator"> 
      <table cellspacing="0" cellpadding="0" >
        <tr>
          <td>Wetter in ${param.cond} am ${currRow[ablage.columnNames[0]]}</td><td></td>
          </tr><tr>
          <td>Sonnenscheindauer</td>
          <td>${currRow[ablage.columnNames[1]]} h</td>
          </tr><tr>
          <td>Mittlere Windst&auml;rke</td>
          <td>${currRow[ablage.columnNames[2]]} bfa</td>
          </tr><tr>
          <td>Mittlerer Bedeckungsgrad</td>
          <td>${currRow[ablage.columnNames[3]]} Achtel</td>
          </tr><tr>
          <td>Mittlere Temperatur</td>
          <td>${currRow[ablage.columnNames[5]]} &deg;C</td>
        </tr>
        <c:if test="${not empty param.details}">
        <tr>
          <td>Niederschlagsh&ouml;he</td>
          <td>${currRow[ablage.columnNames[4]]} mm</td>
        </tr>
        </c:if>
      </table>
    </div>
    </c:forEach>

    </c:if>
  </body>
</html>
