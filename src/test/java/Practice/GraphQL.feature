# new feature
# Tags: optional
Feature:

    Background:
        * url baseUrl
        * print baseUrl

    Scenario:
        * print 'Base URL:', baseUrl
        * print 'Environment:', env
        * print 'Operating System:', os
