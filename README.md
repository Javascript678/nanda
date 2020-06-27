# MA HIX - CVBF Framework

### I. Test Automation Framework Design

1.	CVBF is the source of truth

For each scenario `cvbf_id` in CVBF, one feature file is created which can run all scenarios.

![Screen shot](info/img/cvbf.png)

![Screen shot](info/img/feature-file.png)

2.	Page Object Model

Each module in the application process (Start Your Application, Family  And Household, Income, Additional Questions, Review  And Sign) will have a model that intelligently identifies which methods need to be ran.

![Screen shot](info/img/model.png)

Each page is a separate java class having attributes as `locators` and methods as `page behavior`.

![Screen shot](info/img/page.png)

Each page extends behavior of common pages, which has all common methods defied in it. i.e...

- clickOnElement
- enterText
- clearAndType
- selectDropDownElementByVisibleText

Page with similar functionalities are kept in separate packages. i.e..

- pages.eligibilityResult package 
- pages.familyHousehold package 
- pages.income package 
- pages.disability package 

Corresponding to each page, its steps are defined in separate java class.

![Screen shot](info/img/step-def.png)

Each stepdef class extends SuperStepDef Class which helps in has super constructor to pass common data defined in stepdefs package are again grouped as per pages.

Steps defined in stepdefs package are again grouped as per pages.

3. Test Data

Test Data is separated from java code.

Types of Test data

#### Scenario data

Data is randomized for each `cvbf_id` by running Cucumber Feature File.

![Screen shot](info/img/mysql-feature.png)

Demo can be found below and ran by replacing **table_name** with table to populate

Location:- `{PROJECT_LOCATION}/src/test/java/utils/GenerateTestData.java`

``` java

	public static void main(String args[]) throws Exception {
		System.out.println("Creating Test Data Table In MySQL Database ...");
		new GenerateTestData().generateTestData(Arrays.asList("hh_comp_evpd"));
	}

```

![Screen shot](info/img/generate-data.gif)

Once the data is created, it is exported and stored in a MySQL database.

![Screen shot](info/img/mysql-data.png)

The database is hosted by a Microservice, which gets called by the framework, through an API, in real time, during test execution.

![Screen shot](info/img/microservice-data.png)

#### Global data

Data which are common for all scenarios are kept in property file. It gets loaded before any scenario is executed.

Location:- `{PROJECT_LOCATION}/Test_Data/GlobalData.properties`

#### Environment Data

Data which differs from environment to environment are kept in this property file. It gets loaded as background of any scenario.

Location:- `{PROJECT_LOCATION}/src/main/resources/{env_name}.properties`

#### Temp Data

Data which can be used in subsequent scenario are stored at below location.

Location:- `{PROJECT_LOCATION}/Test_Data/.tempData/{feature_file_name}.properties`

4. Cucumber Hook File

Contains before and after tag of cucumber.

Helps in initializing the driver before loading any other stepdef classes.

5. SuperStepDef Class

This class is extended by all stepdef classes.

Its constructor helps in loading driver, global data, env data, feature file name, test case id, db connections to all stepdef classes.

6. Maintaining web driver session throughout test cases.

Ensures that the open browser step is called from the feature file before interacting with any webpages.

When the above steps is called, the driver session id from the Hook class is passed to the stepdef class when its loaded. The SuperStepDef class helps in assigning driver session id.

From the stepsdef class, the driver session id is passed from page to page with which interaction is required.

7. Rule Engine

Predefined rules are leveraged against the output presented on the browser. 

Rules Location:- `{PROJECT_LOCATION}/src/test/resources/rules/PDRules.xls`

![Screen shot](info/img/drools-rules.png)

The Drools Engine runs after the application process completes and determines which Aid Cat the respective customer is qualified for. Expected results, derived from the Rule Engine, are validated on the Eligibility Results and Medicaid Household pages. A demo for how the rule engine works, can be found below, by running the `Rule_Engine_Demo.java` file.

Rule Engine Demo Runner Location:- `{PROJECT_LOCATION}/Test_Features/PDRuleEngineDemo.feature`

![Screen shot](info/img/rule-engine-feature.png)

Rule Engine Demo Runner Location:- `{PROJECT_LOCATION}/src/test/main/java/runner/Rule_Engine_Demo.java`

![Screen shot](info/img/rule-engine-demo.gif)

8. Utilities class

MAHIX Framework has many utility classes. i.e...

- Browser Factory class helps initiate driver instances.
- DateUtil class helps in manipulating date as per need.
- ExcelUtil class helps in loading data from excel file..
- Screenshot classed helps in taking screenshot
- TestReport class helps in creating html report for each action performed.
- JenkinsStartExecution class is called from jenkins as Pre Step to ensure that atleast one line update is there in any file in .tempData folder
- JenkinsEnvironmentProperty class helps in updating environment data value before executing any test cases from Jenkins.
- JenkinsGlobalProperty class helps in updating global data values before executing any test cases from Jenkins 
- JenkinsTestSuite class is used by Jenkins to update Test Suite which will mark those test cases to execute as per data provided by Jenkins Build Parameter.
- Jenkins Dynamic runner class helps in creating runner file based on excel flag value in test suite excel file

### II. Test Automation Framework Execution

1. Test cases can be executed from runner classes defined in runner package.

2. Test Suite folder contains collections of test suites. Each test suite has collection of feature file name with Y/N flag whether to be executed or not.

![Screen shot](info/img/test-suite.png)

3. DynamicRunnerLocally class helps in creating runner classes at run time based on Y/N flag.

4. To execute test cases from jenkins, we need to feed below parameters.

![Screen shot](info/img/jenkins-build.png)

- Module Name: The Test Suite name which needs to be executed. This was created to cover EVPD, MMIS modules. For others please use DEFAULT module.

- Test Suite Name: The test suite excel file which need to get executed.

- Phase Parameter: Contains cucumber tag which will get triggered. Same phase names are updated in dynamic runner file.

- Github Branch: branch name is Github from which source code will be picked up to Jenkins server.

- Environment Name: Which environment execution will take place.

- Scenario to Execute: If not updated, all test cases marked as yes in test suite excel file will get executed. We can provide our own list of feature file name separated by commas to get executed.

- Sauce Tunnel Identifier: Can also be selected from Jenkins parameter.

5. Real time execution is performed in Saucelabs. Up to 1,000 test can run in parallel.

### III. Test Automation Framework Reporting

1. Test reports generate in the `Test_Report` folder, in the project level folder structure.

2. Test_Report folder contain separate folders for each test case id. They contain  a screenshot folder with all screenshots and test step.html report. They may also contain other files like, xml and pdf, if those types of files are downloaded.

![Screen shot](info/img/reports-folder.png)

3. The test step html file is, a detailed report, which contains one row entry, for every action.

![Screen shot](info/img/reports-html.png)

4. Test report can also be view from Jenkins if executed from there.

![Screen shot](info/img/jenkins-reports.png)

![Screen shot](info/img/jenkins-artifacts.png)

![Screen shot](info/img/jenkins-summary.png)

### Technologies used

- Java
- Cucumber
- Selenium Webdriver
- MySQL
- Maven
- Spring Boot
- Drools
- Jenkins
- Saucelabs

### Built With

* Jboss Dev Studio - IDE

### Copyright

MAHIX Automation Team © 2018. All Rights Reserved.