@GuiTests

Feature: Tic Tac Toe should be playable in the GUI.


  Scenario Outline: make the first move
    Given the window is open
    And the player clicks  <row>  <col>
    When the player views the window
    Then the button <row> <col> should be marked "<mark>"
    And the window should close

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
    Given the window is open
    And the player clicks  <xrow>  <xcol>
    And the player clicks  <orow>  <ocol>
    When the player views the window
    Then the button <xrow> <xcol> should be marked "<xmark>"
    And the button <orow> <ocol> should be marked "<omark>"
    And the window should close

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
    Given the window is open
    And the player clicks  0  1
    And the player clicks  2  2
    And the player clicks  0  2
    And the player clicks  1  2
    And the player clicks  0  0
    When the player views the window
    Then the result label should say "X wins"
    And the window should close

  Scenario: O wins across the second row
    Given the window is open
    And the player clicks  0  1
    And the player clicks  1  2
    And the player clicks  0  2
    And the player clicks  1  0
    And the player clicks  2  2
    And the player clicks  1  1
    When the player views the window
    Then the result label should say "O wins"
    And the window should close

  Scenario: X wins across the third row
    Given the window is open
    And the player clicks  2  0
    And the player clicks  0  0
    And the player clicks  2  1
    And the player clicks  1  2
    And the player clicks  2  2
    When the player views the window
    Then the result label should say "X wins"
    And the window should close

  Scenario: O wins across the first column
    Given the window is open
    And the player clicks  1  1
    And the player clicks  1  0
    And the player clicks  0  2
    And the player clicks  2  0
    And the player clicks  2  2
    And the player clicks  0  0
    When the player views the window
    Then the result label should say "O wins"
    And the window should close

  Scenario: X wins across the second column
    Given the window is open
    And the player clicks  1  1
    And the player clicks  1  0
    And the player clicks  0  1
    And the player clicks  2  0
    And the player clicks  2  1
    When the player views the window
    Then the result label should say "X wins"
    And the window should close

  Scenario: O wins across the third column
    Given the window is open
    And the player clicks  1  0
    And the player clicks  0  2
    And the player clicks  2  1
    And the player clicks  2  2
    And the player clicks  2  0
    And the player clicks  1  2
    When the player views the window
    Then the result label should say "O wins"
    And the window should close

  Scenario: X wins across the main diagonal
    Given the window is open
    And the player clicks  0  0
    And the player clicks  2  0
    And the player clicks  1  1
    And the player clicks  0  2
    And the player clicks  2  2
    When the player views the window
    Then the result label should say "X wins"
    And the window should close

  Scenario: O wins across the reverse diagonal
    Given the window is open
    And the player clicks  0  0
    And the player clicks  2  0
    And the player clicks  2  1
    And the player clicks  0  2
    And the player clicks  2  2
    And the player clicks  1  1
    When the player views the window
    Then the result label should say "O wins"
    And the window should close

  Scenario: Tie when all spaces are filled without a winner
    Given the window is open
    And the player clicks  1  1
    And the player clicks  0  0
    And the player clicks  0  2
    And the player clicks  2  0
    And the player clicks  1  0
    And the player clicks  1  2
    And the player clicks  0  1
    And the player clicks  2  1
    And the player clicks  2  2
    When the player views the window
    Then the result label should say "Tie"
    And the window should close

  Scenario: X wins on filling the last space
    Given the window is open
    And the player clicks  1  1
    And the player clicks  0  0
    And the player clicks  0  2
    And the player clicks  2  0
    And the player clicks  1  0
    And the player clicks  1  2
    And the player clicks  0  1
    And the player clicks  2  2
    And the player clicks  2  1
    When the player views the window
    Then the result label should say "X wins"
    And the window should close
