Feature: Search best route
  As the logistic system
  In order to find best route
  I need a webservice to respond to find the route

  Background:
    Given there are map with name 'SP' and the following routes:
    | source | target | distance |
    | A      | B      | 10       |
    | B      | D      | 15       |
    | A      | C      | 20       |
    | C      | D      | 30       |
    | B      | E      | 50       |
    | D      | E      | 30       |

  Scenario: Failure when does not send params
    When I send a GET request to "/search"
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    {
      "errors": {
                   "name": ["can't be blank"],
                   "source": ["can't be blank"],
                   "target": ["can't be blank"],
                   "price": ["can't be blank", "is not a number"],
                   "autonomy": ["can't be blank", "is not a number"]
                }
    }
    """

  Scenario Outline: failure when invalid params
    When I send a GET request to "/search?name=<name>&source=<source>&target=<target>&autonomy=<autonomy>&price=<price>"
    Then the status code response should be "400"
    And  the response should have error for "<field>" with "<message_error>"

    Examples:
      | name | source | target | autonomy | price | field    | message_error   |
      |      | A      | B      | 10       | 1.5   | name     | can't be blank  |
      | SP   |        | B      | 10       | 1.5   | source   | can't be blank  |
      | SP   | A      |        | 10       | 1.5   | target   | can't be blank  |
      | SP   | A      | B      |          | 1.5   | autonomy | can't be blank  |
      | SP   | A      | B      |          | A     | autonomy | is not a number |
      | SP   | A      | B      | 10       |       | price    | can't be blank  |
      | SP   | A      | B      | 10       | A     | price    | is not a number |

  Scenario Outline: Failure when source or target are invalid
    When I send a GET request to "/search?name=SP&source=<source>&target=<target>&autonomy=10&price=1.5"
    Then the status code response should be "400"
    And the response body with the following JSON:
    """
    {
      "errors": "<message>"
    }
    """

    Examples:
      | source | target | message                   |
      | A      | A      | source is equal to target |
      | A      | J      | path not found            |
      | J      | I      | path not found            |

  Scenario: failure when map not found
    When I send a GET request to "/search?name=RJ&source=A&target=B&autonomy=10&price=2.5"
    Then the status code response should be "404"
    And the response body with the following JSON:
    """
    {
      "errors": "Map not found"
    }
    """

  Scenario: successful search path
    When I send a GET request to "/search?name=SP&source=A&target=D&autonomy=10&price=2.5"
    Then the status code response should be "200"
    And the response body with the following JSON:
    """
    {
      "route": "A B D",
      "cost": 6.25
    }
    """
