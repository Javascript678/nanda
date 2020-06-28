Feature: This Feature file will ensure that MySQL Queries are Executed.

  #Paul
  @runBatchJobs
  Scenario: Run_Batch_Job
    Given Get Feature File For "MicroserviceDemo"
    Then Clean Temporary Data if Exist In Previous Run
    And Using Microservice, Run Batch Job Sequences On Given Environment
      | Cvbf        | Phase |
      | ccaRenewals |     1 |

  @checkStatus
  Scenario: Ensure_Batch_Job_Completed
    Given Get Feature File For "MicroserviceDemo"
    Then Using Microservice, Ensure WorkFlow is Completed Successfully

  @select
  Scenario: Select
    Given Get Feature File For "MicroserviceDemo"
    Then Using Microservice, Send Request To Run Select Query On Given Env

  @update
  Scenario: Update
    Given Get Feature File For "MicroserviceDemo"
    Then Using Microservice, Send Request To Run Update Query On Given Env

  @xml
  Scenario: XML
    Given Get Feature File For "MicroserviceDemo"
    Then Using Microservice, Send Request To Get XML From "REQUEST_XML_CLOB" On Given Env

  @sysDate
  Scenario: Sys_Date
    Given Get Feature File For "MicroserviceDemo"
    Then Using Microservice, Send Request To Get System Date From Given Env

  @shellScript
  Scenario: Select
    Given Get Feature File For "MicroserviceDemo"
    Then Load Environment Data
    Then Using Microservice, Send Request To Run "RrvGeneration" Shell Script On Given Env
