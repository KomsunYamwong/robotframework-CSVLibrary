*** Settings ***
Documentation     CSV examples for Robot Framework.
Library           Collections
Library           ${CURDIR}${/}..${/}CSVLibrary

*** Variables ***
# Example data generated with: https://www.mockaroo.com/
@{template_list}    1    Douglas    Morris    dmorris0@mozilla.org    Male    205.4.212.229
&{template_dict}    id=1    first_name=Douglas    last_name=Morris    email=dmorris0@mozilla.org    gender=Male    ip_address=205.4.212.229
&{template_dict_quoting}    id=1    first_name=Douglas    last_name=Morris    email=dmorris0@mozilla.org    gender="Male    ip_address=205.4.212.229

*** Test Cases ***
Read csv file to a list example test
    @{list}=    read csv file to list    ${CURDIR}${/}data.csv
    lists should be equal    ${template_list}    ${list[1]}

Read csv file to a dict example test
    @{dict}=    read csv file to associative    ${CURDIR}${/}data.csv
    dictionaries should be equal    ${template_dict}    ${dict[0]}

Read csv file without quoting to associative
    @{dict}=    read csv file to associative    ${CURDIR}${/}data_quoting.csv    delimiter=,    quoting=${3}
    dictionaries should be equal    ${template_dict_quoting}    ${dict[0]}

Update data to specific row example test
    @{fieldnames}=    Create List    id    test_result    first_name    last_name
    @{list}=    read_csv_file_to_associative    ${CURDIR}${/}test-data-template.csv
    &{test result}=    Create Dictionary    id=1    test_result=pass    first_name=test    last_name=test
    Set List Value    ${list}    0    ${test result}
    Log Many    ${list}
    csv_file_from_associative    ${CURDIR}${/}test-data-template.csv    ${list}    ${fieldnames}

Test list
    @{scalar} =    Create List    a    b    c
    Set List Value    ${scalar}    1    xxx
    Log Many    ${scalar}

Update csv file test result data
    Update test template result by index    ${CURDIR}${/}test-data-template.csv    0    Pass
    Update test template result by index    ${CURDIR}${/}test-data-template.csv    1    Fail
    Update test template result by index    ${CURDIR}${/}test-data-template.csv    2    Pass

Demo update test result
    LOG    Please see the Teardown
    [Teardown]    Updated Test Result To Csv File    ${CURDIR}${/}demo-test-report.csv    Demo update test result    ${TEST_STATUS}    # Updated Test Result To Csv File | ${CURDIR}${/}demo-test-report.csv | ${TEST_NAME} | ${TEST_STATUS}

Demo read test data from csv
    &{test data} =     Get Test Datas From Csv File    ${CURDIR}${/}demo-test-report.csv    ${TEST_NAME}
    LOG    Hello ${test data.first_name} \ ${test data.last_name}

*** Keywords ***
Update test template result by index
    [Arguments]    ${file name}    ${index}    ${result}
    @{fieldnames}=    Create List    id    test_result    first_name    last_name
    @{list}=    read_csv_file_to_associative    ${file name}
    &{test result}=    Convert To Dictionary    ${list[${index}]}
    Set To Dictionary    ${test result}    test_result    ${result}
    Set List Value    ${list}    ${index}    ${test result}
    csv_file_from_associative    ${file name}    ${list}    ${fieldnames}
