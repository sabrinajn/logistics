Feature: Create Map
  As the logistic system
  In order to add maps in the system
  I need a webservice to create maps

  Scenario: successful create
    When I send a POST request to "/maps" with valid map name and valid routes
    Then the status code response should be "201"
    And the map should be created with the routes

  Scenario: Failure when does not send params
    When I send a POST request to "/maps" without params
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    {
      "errors": {
                  "name": ["can't be blank"],
                  "file": ["can't be blank", "file is invalid"]
                }
    }
    """

  Scenario: Failure when does not send name
    When I send a POST request to "/maps" with valid routes and without name
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    {
      "errors": { "name": ["can't be blank"] }
    }
    """

  Scenario: Failure when does not send file
    When I send a POST request to "/maps" with valid map name and without valid routes
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    {
      "errors": { "file": ["can't be blank", "file is invalid"] }
    }
    """

  Scenario: Failure when map already exists
    Given exists map with name "SP"
    When I send a POST request to "/maps" with name "SP"
    Then the status code response should be "400"
    And the response should have error for "name" with "has already been taken"

  Scenario: Failure when there are duplicated routes
    When I send a POST request to "/maps" with valid routes and there are duplicated routes
    Then the status code response should be "400"
    And the response should have error for "routes" with "there are duplicate routes"

  Scenario: Failure when there are invalid distances
    When I send a POST request to "/maps" with valid routes and there are invalid routes
    Then the status code response should be "400"
    And the response should have error for "routes" with "is invalid"
