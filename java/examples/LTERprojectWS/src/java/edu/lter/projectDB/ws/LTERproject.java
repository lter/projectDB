/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package edu.lter.projectDB.ws;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.xml.transform.OutputKeys;
import org.exist.xmldb.XQueryService;
import org.xmldb.api.DatabaseManager;
import org.xmldb.api.base.Collection;
import org.xmldb.api.base.Database;
import org.xmldb.api.base.ResourceIterator;
import org.xmldb.api.base.ResourceSet;
import org.xmldb.api.modules.XMLResource;

/**
 *
 * @author corinna
 */
@WebService()
public class LTERproject {
        String driver = "org.exist.xmldb.DatabaseImpl";
        String URI = "xmldb:exist://localhost:8080/exist/xmlrpc/db/";
        String query = "";
        String result = "";

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getProjectById")
    public String getProjectById(@WebParam(name = "projectId")
    String projectId) {
        try{
            Class cl = Class.forName(driver);
            Database database = (Database) cl.newInstance();
            DatabaseManager.registerDatabase(database);
            // get the collection for the eml document
            Collection col = DatabaseManager.getCollection(URI +"/cap_projects");
            col.setProperty(OutputKeys.INDENT, "no");

            //get the xml document and transform it
            XQueryService service = (XQueryService) col.getService("XQueryService", "1.0");
            service.setProperty("indent", "yes");
            query = "xquery version \"1.0\"; " +
                    "declare namespace eml=\"eml://ecoinformatics.org/project-2.1.0\"; " +
                    "let $id:= '" + projectId + "' " +
                    "for $researchProject in collection('/db/cap_projects')/eml:researchProject[@id = $id] " +
                    "let $xslt:= '/db/stylesheets/projectHTML.xsl' " +
                    "let $xml := $researchProject " +
                    "let $params := " +
                        "<parameters>" +
                        // insert code for parameters if desired
                        "</parameters> " +
                    "return " +
                    "transform:transform($xml, doc($xslt),$params)";

            System.out.println(query);

            ResourceSet titles = service.query(query);

            XMLResource rtitle = (XMLResource) titles.getResource(0);
            result = (String) rtitle.getContent();
            System.out.println(result);
            col.close();
        }
        catch (Exception e) {
            System.err.println("LTERproject webservice: getProjectById: "+ e.toString());
        }
        return result;
    }

}
