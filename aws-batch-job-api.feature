Feature: This feature file will run all CCA Renewal scenarios

  Background: Run Before Every Scenarios, Ensure Test Data Name is Same as Name in Test Data File
    Given Get Feature File For "aws_apis"
    Then Load Environment Data

  @Job_Sequence_1
  Scenario: Job_Sequence_1#Run Job 40a
    Given Using Microservice, Run Batch Job Sequences On Given Environment
      | Cvbf        | Sequence |
      | ccaRenewals |        1 |
      