# new feature
# Tags: optional
Feature: File Upload

    Background: Set Url
        * url 'https://filebin.net'

    Scenario: File upload test case
        Given path '/'
        And header Content-type = 'image/png'
        And header Filename = 'image.png'
        And request karate.read('file:src/test/resourses/image.png')
        When method POST
        Then status 201
        And match response.bin.expired_at_relative == '6 days from now'