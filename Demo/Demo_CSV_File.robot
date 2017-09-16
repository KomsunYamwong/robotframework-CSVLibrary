*** Settings ***
Library           CSVLibrary

*** Test Cases ***
Demo01 - write report
    LOG    Test Pass
    [Teardown]    Updated Test Result To Csv File    ${CURDIR}${/}test-report.csv    ${TEST_NAME}    ${TEST_STATUS}

Demo02 - read test data
    &{test data} =    Get Test Datas From Csv File    ${CURDIR}${/}test-report.csv    ${TEST_NAME}
    LOG    Hello ${test data.first_name} - ${test data.last_name}
