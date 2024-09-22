@ConsoleTests

Feature: Tic Tac Toe should be playable in the console.


  Scenario Outline: make the first move
    Given the game has started
    And the player marks  <row>  <col>
    When the player views the board
    Then the location <row> <col> should be marked "<mark>"
    And the game should end

    Examples:
    | row | col | mark |
    |  0  |  0  |   X  |
    |  0  |  1  |   X  |
    |  0  |  2  |   X  |
    |  1  |  0  |   X  |
    |  1  |  1  |   X  |
    |  1  |  2  |   X  |
    |  2  |  0  |   X  |
    |  2  |  1  |   X  |
    |  2  |  2  |   X  |


  Scenario Outline: make the second move
    Given the game has started
    And the player marks  <xrow>  <xcol>
    And the player marks  <orow>  <ocol>
    When the player views the board
    Then the location <xrow> <xcol> should be marked "<xmark>"
    And the location <orow> <ocol> should be marked "<omark>"
    And the game should end

    Examples:
    | xrow | xcol | xmark | orow | ocol | omark |
    | 0    |  0   |  X    |  1   |  1   |  O    |
    | 0    |  1   |  X    |  0   |  1   |  X    |
    | 0    |  2   |  X    |  2   |  0   |  O    |
    | 1    |  0   |  X    |  1   |  1   |  O    |
    | 1    |  1   |  X    |  1   |  1   |  X    |
    | 1    |  2   |  X    |  0   |  0   |  O    |
    | 2    |  0   |  X    |  2   |  1   |  O    |
    | 2    |  1   |  X    |  1   |  2   |  O    |
    | 2    |  2   |  X    |  1   |  0   |  O    |


  Scenario: X wins across the first row
    Given the game has started
    And the player marks  0  1
    And the player marks  2  2
    And the player marks  0  2
    And the player marks  1  2
    And the player marks  0  0
    When the player views the board
    Then the game result should be "X wins"

  Scenario: O wins across the second row
    Given the game has started
    And the player marks  0  1
    And the player marks  1  2
    And the player marks  0  2
    And the player marks  1  0
    And the player marks  2  2
    And the player marks  1  1
    When the player views the board
    Then the game result should be "O wins"

  Scenario: X wins across the third row
    Given the game has started
    And the player marks  2  0
    And the player marks  0  0
    And the player marks  2  1
    And the player marks  1  2
    And the player marks  2  2
    When the player views the board
    Then the game result should be "X wins"

  Scenario: O wins across the first column
    Given the game has started
    And the player marks  1  1
    And the player marks  1  0
    And the player marks  0  2
    And the player marks  2  0
    And the player marks  2  2
    And the player marks  0  0
    When the player views the board
    Then the game result should be "O wins"

  Scenario: X wins across the second column
    Given the game has started
    And the player marks  1  1
    And the player marks  1  0
    And the player marks  0  1
    And the player marks  2  0
    And the player marks  2  1
    When the player views the board
    Then the game result should be "X wins"

  Scenario: O wins across the third column
    Given the game has started
    And the player marks  1  0
    And the player marks  0  2
    And the player marks  2  1
    And the player marks  2  2
    And the player marks  2  0
    And the player marks  1  2
    When the player views the board
    Then the game result should be "O wins"

  Scenario: X wins across the main diagonal
    Given the game has started
    And the player marks  0  0
    And the player marks  2  0
    And the player marks  1  1
    And the player marks  0  2
    And the player marks  2  2
    When the player views the board
    Then the game result should be "X wins"

  Scenario: O wins across the reverse diagonal
    Given the game has started
    And the player marks  0  0
    And the player marks  2  0
    And the player marks  2  1
    And the player marks  0  2
    And the player marks  2  2
    And the player marks  1  1
    When the player views the board
    Then the game result should be "O wins"

  Scenario: Tie when all spaces are filled without a winner
    Given the game has started
    And the player marks  1  1
    And the player marks  0  0
    And the player marks  0  2
    And the player marks  2  0
    And the player marks  1  0
    And the player marks  1  2
    And the player marks  0  1
    And the player marks  2  1
    And the player marks  2  2
    When the player views the board
    Then the game result should be "Tie"

  Scenario: X wins on filling the last space
    Given the game has started
    And the player marks  1  1
    And the player marks  0  0
    And the player marks  0  2
    And the player marks  2  0
    And the player marks  1  0
    And the player marks  1  2
    And the player marks  0  1
    And the player marks  2  2
    And the player marks  2  1
    When the player views the board
    Then the game result should be "X wins"