
package edu.lter.projectDB.ws.jaxws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement(name = "getProjectById", namespace = "http://ws.projectDB.lter.edu/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getProjectById", namespace = "http://ws.projectDB.lter.edu/")
public class GetProjectById {

    @XmlElement(name = "projectId", namespace = "")
    private String projectId;

    /**
     * 
     * @return
     *     returns String
     */
    public String getProjectId() {
        return this.projectId;
    }

    /**
     * 
     * @param projectId
     *     the value for the projectId property
     */
    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

}
