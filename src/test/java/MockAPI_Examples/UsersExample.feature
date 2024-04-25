Feature: CRUD Operations with Users API

  Background:
    * def data = read('Util/globalVariables.json')
    * url data.Url.baseURL

  Scenario: Get all users
    Given path 'users'
    When method GET
    Then status 200
    Then match response == $[*]
    * def UsersData = read('Util/CreateUser.json')
    Then match response[0] == UsersData.expectedResponse
    Then print response[0]

  Scenario: Create a user
    Given path 'users'
    * def UsersData = read('Util/CreateUser.json')
    And request UsersData.user
    When method POST
    And print UsersData.user
    Then status 201
    And match response == { id: '#notnull', name: '#string', avatar: '#string', createdAt: '#string' }
    And print response
    * karate.write(response, 'Response/CreatedUser.json')
    And match response.name == UsersData.user.name

  Scenario: Get the Specific user
    * def data = read('file:target/Response/CreatedUser.json')
    * print data
    Given path 'users/', data.id
    When method GET
    Then status 200
    And match response == '#object'
    And match response.id == data.id
    And print response
    * def UsersData = read('Util/CreateUser.json')
    And match response == UsersData.expectedResponse

  Scenario Outline: Delete Users
    Given path 'users/', <UserID>
    When method DELETE
    Then print response
    * eval
    """
    if (responseStatus == 200) {
        print('User with ID <UserID> deleted successfully.');
    } else {
        print('User with ID <UserID> not found or already deleted.');
    }
    """

    Examples:
      | UserID |
      | 1      |
      | 2      |
      | 3      |
      | 4      |

  @run
  Scenario: Update User 12
    Given path 'users/12'
    * def UpdatedUserDetails =
    """
    {
      "createdAt": "2024-04-25T03:45:56.065Z",
      "name": "Levi McCullough",
      "avatar": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/502.jpg",
      "id": "12"
    }
    """
    And request UpdatedUserDetails
    When method PUT
    Then status 200
    And match response == UpdatedUserDetails
