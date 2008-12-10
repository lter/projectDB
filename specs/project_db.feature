# use case 1
# project creation and approval

Feature: creating a new project
  In order to know what is being proposed for a new project
  As a project manager
  I want the investigator to submit project info (title, short_title, funding sources, start/end dates, site locations, protocols, data management plan, cleanup plan)

	Scenario: As an investigator I submit a complete project application
	  Given I am logged in
	  When I click on new project
	  Then I should see a new empty project page
		And the project should have an ID
		When I fill in the "project_title" with "Tracking ants across the landscape"
		And	I fill in the "project_short_title" with "Tracking ants"
		And I fill in ...
		And I click submit
		Then I see the new project
		And the 'project_pubdate' should be the current date
		
	
	Scenario: an investigator submits an incomplete project application
  	Given I am logged in
  	When event
  	Then outcome
	
	Scenario: an investigator fills out the data access policy box
	  Given I am logged in
		And	I have a filled out the required fields
	  When I fill in the "project_data_access_policy" with "don't even think about it"
	  Then outcome
	
	Scenario: an investigator leaves the abstract empty
  	Given I am logged in
		And I have filled out the required fields	
  	When I fill in the 'project_abstract' with ''
		And	click 'submit'
  	Then I should get an error
	
	Scenario: an investigator leaves the short title empty
	  Given context
	  When event
	  Then outcome
	
	Scenario: an investigator provides keywords
	  Given context
	  When event
	  Then outcome
	
	Scenario: an investigator does not provide keywords
	  Given context
	  When event
	  Then outcome
	
	Scenario: an investigator fills in the funding source box
	  Given context
	  When event
	  Then outcome
	
	Scenario: an investigator provides personnel information
	  Given context
	  When event
	  Then outcome
	
	Scenario: an information selects a project type
	  Given context
	  When event
	  Then outcome

Feature: Finding a new study site
	In order to find a suitable study site
  As an investigator	
	I want know what disturbance has occurred on or near the site I want to study

	Scenario: check if a given area has been disturbed
		Given I have an area with a bounding box(a,b,c,d)
		When I query for area='a,b,c,d'?disturbances
		Then I should get a list of all the disturbances that have occured in this area

	Scenario: find an undisturbed area
		Given I have a list of disturbances to avoid
		When I query the system for disturbance free areas
		Then I should see the areas which are available and have not been disturbed
		
Feature: requesting research assistance
  In order to minimize my costs
  As an investigator
  I want the lter staff to do the work


# project management

Feature: project_approval
  In order to avoid having new research interfering with existing research
  As a project manager
  I want to know where new research is proposed and be notified if the proposed research is near or overlaps ongoing research

	Scenario: new research area overlaps between new and old research
	  Given a proposed project that overlaps an existing project in space
	  When I review the proposed project	
	  Then I should be notified of the overlap
	
Feature: project approval
  In order to expedite the approval of new project
  As a project manager
  I want see what parts of the application are missing or incomplete

Feature: approval_tracking
	In order to approve projects quickly
	As an information manager or site manager
	I want to be notified when a project needs approval

Feature: approval_tracking
	In order to know which projects are approved and need tracking
	As a site manager	
	I want to check off that the project is approved

Feature: progress_tracking
	In order to hound investigators for updates
	As an information manager
	I want to list projects which are past due on data or metadata updates

# annual report

Feature: report
  In order to get continued funding
  As an information manager
  I want to find the information required in the annual report

	Scenario: find recent activities and findings in all active projects
	  Given At least 1 active project
	  When i query for active projects
	  Then I should get the project and the last activities and findings from 1 or more projects
	
	Scenario: find the status of all projects
	  Given 1 active project 
		And 1 inactive project
	  When I list the projects
	  Then I should get 1 active project
		And 1 inactive project
	
	Scenario: find all projects run by students
	  Given 3 projects run by students
	  When I query for projects run by students
	  Then I get 3 projects
	
	Scenario: find all projects run by minorities
	  Given context
	  When event
	  Then outcome
	
	Scenario: find all high profile projects
	  Given context
	  When event
	  Then outcome
	
Feature: report
  In order to generate an annual report
  As an information manager
  I want the principal investigator to indicate if a project is high profile and which products are the most important


Feature: discover collaboration opportunities
  In order to find projects to collaborate with
  As an investigator
  I want to find projects with similar or contrasting subjects, measurements, habitats, biomes or research themes

	Scenario: basic querying with 1 project returned
	  Given 1 project with the title 'Carbon flux'
	  When I query for title = 'flux'
	  Then I should get 1 project
	
	Scenario: basic querying with 100 projects returned
	  Given 100 projects with the title 'Carbon flux'
	  When I query for title='flux'
	  Then I should get a list of 100 project titles, ids, short abstracts and keywords_by_type
	
	Scenario: query for habitat or biome
	  Given 3 projects with the habitat keyword = 'boreal'
	  When I query for habitat = 'boreal'
	  Then I should get a list of 3 project titles, ids, short abstracts and keywords_by_type
	
	Scenario: failing query for habitat or biome
	  Given 0 projects with the habitat keyword = 'borea
	  When I query for habitat = 'boreal'
	  Then I should get no projects
	
	Scenario: query for research theme
	  Given 1 project with the research theme = 'Hydrology'
	  When I query for research_theme = 'hydrology'
	  Then I should get 1 project
	
	Scenario: query for projects in an area
	  Given 1 project in the area of interest
	  When I select the area on the google map
	  Then I should get 1 project		

Feature: field_personnel
  In order to find my field locations and helpful hints
  As a field technician
  I want feature

Feature: browsing the project database
  In order to look for new ideas
  As a investigator
  I want to see what projects have been done

	Scenario: viewing the home page
	  Given a number of projects
	  When visiting the browse page
	  Then I see a list of keywords to click on and a search box
	
	Scenario: selecting a keyword link
	  Given a number of projects and keywords
	  When I click on a keyword link
	  Then I get a list of project titles and abstracts matching the keyword sorted by age
	
Feature: discovery
  In order to find projects that where funded by my organization
  As a program manager
  I want to check on projects that were funded by my organization

	Scenario: get progress reports on the projects funded by my organization
  	Given 1 project from mine organization
	  When 1 query for organization='mine'
	  Then I get 1 project 
		And	the project has a tag funding_source = 'mine'
	
Feature: monitoring
  In order to review a projects progress
  As a information manager
  I want to receive a notification when a project is updated

Feature: uploading a project to the project db
  In order keep the network database up to date
  As a site manager
  I want to upload my projects to the network project database

	Scenario: upload a new valid project
	  Given 1 valid project schema file on my hard disk
	  When I upload the file to the network project db
	  Then 1 more project will be in the network database
	
	Scenario: upload a new invalid project
	  Given 1 invalid project schema file on my hard disk
	  When I upload the file to the network project db
	  Then I receive an error
		And the number of projects does not change
	
	Scenario: overwrite an existing project with a modified valid project
	  Given 1 valid project file on my hard disk
	  When I upload the file to the network project db
	  Then the number of projects does not change
		And	the project.version_number will be incremented
		And I will see the modified project
	
	Scenario: overwrite an existing project with a modified invalid project
	  Given 1 invalid project file on my hard disk
	  When I upload the file to the project db
	  Then I receive and error
		And	the project is not updated
		And the number of projects does not change
	
Feature: harvesting projects
  In order to keep the network database up to date
  As a lter network manager
  I want to pull projects from the sites

	Scenario: harvest 2 valid projects and overwrite the current projects
	  Given a harvest document
		And 2 new projects
		And the 2 old projects
	  When the harvester runs
	  Then the harvester should get 1 harvest  document
		And  2 projects
		And	the projects should be valid
		And	the projects should overwrite the old versions
		
	Scenario: harvest 1 invalid project
	  Given a valid harvest document
		And	1 invalid project
	  When the harvest runs
	  Then the harvester should get 1 harvest document
		And	1 project
		And	the project should be invalid
		And the project should not be saved
		And	the site manager should be notified
	
 
Feature: updating project information
  In order to keep the information up to date
  As an investigator or information  manager
  I want to update the project information for the projects that I am responsible for

	Scenario: changing the objectives or scope of the project
	  Given I am logged in
		And I have at least 1 project
	  When I edit the project.objectives
	  Then the project.version_number is increased by 1
		And the 'project_pubdate' should be the current date
		And the project.objectives are saved
	
		
	Scenario: I want to update the recent findings
	  Given context
	  When event
	  Then outcome
		And the 'project_pubdate' should be the current date
	
	
	Scenario: I want to add a new dataset/report/publication to the project
	  Given context
	  When event
	  Then outcome
		And the 'project_pubdate' should be the current date
		
	Scenario: I want to remove a dataset/report/publication from the project
	  Given context
	  When event
	  Then outcome 
		And the 'project_pubdate' should be the current date
		

Feature: export to eml 2.1
  In order to add the project description to datasets 
  As an information manager
  I want to have the project returned as eml by mapping the project_db schema to the eml schema



  
