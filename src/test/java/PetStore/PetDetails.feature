Feature: Petstore API Tests

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Add a new pet to the store
    Given path '/pet'
    And request
        """
        {
            "id": 0,
            "category": {
                "id": 0,
                "name": "German Shepard"
            },
            "name": "Wisky",
            "photoUrls": [
                "https://www.youtube.com/watch?v=5KPOi9B3bHQ&list=PL8VbCbavWfeGGVl-82ZU1aLNDuN0MNgxh&index=5"
            ],
            "tags": [
                {
                    "id": 0,
                    "name": "Cute"
                }
            ],
            "status": "available"
        }
        """
    When method POST
    Then status 200
    And match response == { id: '#number', category: '#object', name: 'Wisky', photoUrls: '#array', tags: '#array', status: 'available' }
    And assert response.id >= 0
    And assert response.category.id >= 0
    And match response.category.name == 'German Shepard'
    And match response.photoUrls contains '#string'
    And assert response.tags[0].id >= 0
    And match response.tags[0].name == '#string'
    And match response.status == 'available'
    And def prettyResponse = karate.pretty(response)
    And karate.log('Response: ', prettyResponse)



  Scenario: Update an existing pet
    Given path '/pet'
    And request
    """
     {
      "id": 9223372036854756439,
      "category": {
        "id": 0,
        "name": "German Shepard"
      },
      "name": "Wisky-Tody",
      "photoUrls": [
        "https://www.youtube.com/watch?v=5KPOi9B3bHQ&list=PL8VbCbavWfeGGVl-82ZU1aLNDuN0MNgxh&index=5"
      ],
      "tags": [
        {
          "id": 0,
          "name": "Cute"
        }
      ],
      "status": "available"
    }
    """
    When method PUT
    Then status 200
    And match response == { id: '#number', category: '#object', name: 'Wisky-Tody', photoUrls: '#array', tags: '#array', status: 'available' }

  Scenario: Find pets by status
    Given path '/pet/findByStatus'
    And param status = 'available,pending,sold'
    When method GET
    Then status 200
    And match response == $[?(@.id != null && @.category != null && @.name != null && @.photoUrls != null && @.tags != null && @.status != null)]

  Scenario: Find pets by status
    Given path '/pet/findByStatus'
    And param status = 'available'
    When method get
    Then status 200
    # Ensure the response is an array
    * match response == '#[]'
    And match response ==$[?(@.id != null && @.category != null && @.name != null && @.photoUrls != null && @.tags != null && @.status != 'avilable')]
    And match each response contains { status: 'available' }



  Scenario: Upload an image for a pet
    Given path '/pet/12345/uploadImage'
    And request multipart petImage = { file: 'C:\\Users\\LENOVO YOGA\\Pictures\\Screenshots\\Screenshot (1).png', filename: 'Screenshot (1).png' }
    When method post
    Then status 200
    And match response.headers['Content-Type'] == 'application/json'
    And match response contains { code: '#number', type: 'success' }


  Scenario: Find pet by ID
    Given path '/pet/1'
    When method get
    Then status 200
    And match response contains { id: 1, name: '#string', status: '#string' }

  Scenario: Update a pet with form data
    Given path '/pet/1'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field name = 'Fido'
    And form field status = 'available'
    When method post
    Then status 200
    And print response
    And match response == { id: 1, name: 'Fido', status: 'available' }

  Scenario: Delete a pet
    Given path '/pet/1'
    When method delete
    Then status 200
    And match response contains { code: 200, type: 'success' }


