Feature: Access Pet Store Orders

    Background:
        * url 'https://petstore.swagger.io/v2'
        * def orderId = null

    Scenario: Get pet inventories by status
        Given path '/store/inventory'
        When method GET
        Then status 200
        And match response contains { available: '#number'}
        And print response

    Scenario: Place an order for purchasing the pet
        Given path '/store/order'
        * def requestBody =
    """
    {
      "id": 0,
      "petId": 0,
      "quantity": 0,
      "shipDate": "2024-04-23T05:23:10.501Z",
      "status": "placed",
      "complete": true
    }
    """
        And request requestBody
        When method POST
        Then status 200
        And match response ==
    """{
            "id": "#number",
            "petId": "#number",
            "quantity": "#number",
            "shipDate": "#string",
            "status": "#string",
            "complete": "#boolean"
        }
    """
        And print response
        And def orderId = response.id
        And karate.set('orderId', orderId)
        And print 'orderId:', orderId
        And assert responseTime < 2000

    Scenario: Find purchase order by ID
        * def orderId = karate.get('orderId')
        * print 'orderId:', orderId
        Given path '/store/order'
        And param orderId = orderId
        When method GET
        Then status 200

