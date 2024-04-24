# new feature
# Tags: optional
@debug
Feature:

    Background:
        * url baseUrl
        * print baseUrl

    Scenario:
        * print 'Base URL:', baseUrl
        * print 'Environment:', env
        * print 'Operating System:', os
