
package edu.lter.projectdb.ws;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the edu.lter.projectdb.ws package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _GetProjectByIdResponse_QNAME = new QName("http://ws.projectDB.lter.edu/", "getProjectByIdResponse");
    private final static QName _GetProjectById_QNAME = new QName("http://ws.projectDB.lter.edu/", "getProjectById");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: edu.lter.projectdb.ws
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link GetProjectByIdResponse }
     * 
     */
    public GetProjectByIdResponse createGetProjectByIdResponse() {
        return new GetProjectByIdResponse();
    }

    /**
     * Create an instance of {@link GetProjectById }
     * 
     */
    public GetProjectById createGetProjectById() {
        return new GetProjectById();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProjectByIdResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.projectDB.lter.edu/", name = "getProjectByIdResponse")
    public JAXBElement<GetProjectByIdResponse> createGetProjectByIdResponse(GetProjectByIdResponse value) {
        return new JAXBElement<GetProjectByIdResponse>(_GetProjectByIdResponse_QNAME, GetProjectByIdResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link GetProjectById }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://ws.projectDB.lter.edu/", name = "getProjectById")
    public JAXBElement<GetProjectById> createGetProjectById(GetProjectById value) {
        return new JAXBElement<GetProjectById>(_GetProjectById_QNAME, GetProjectById.class, null, value);
    }

}
