Feature: js-mode expansions
  Background:
    Given there is no region selected
    And I turn on js-mode
    And I insert:
    """
    function doThings() {
        var x = 0;
        const y = 1.0;
        let z = my_function(x, y);

        var fun = function(x) {return x*x;};

        if(x > y) {
            console.log(x);
        }
        while(x < 50) {
            x++;
        }
        let i = 0;
        for(i; i < 10; i++) {
            doSomething (i);
        }
        const obj = {
            key:value,
            'other-key':value
        }
    
    }
   """


  Scenario: Mark function call (inside function name)
    When I place the cursor after "my_fun"
    And I press "C-@"
    Then the region should be "function"
    And I press "C-@"
    # Then the region should be "my_function"
    # And I press "C-@"
    # Then the region should be "my_function(x, y)"

  # Scenario: Mark function call (inside arguments)
  #   When I place the cursor after "my_function("
  #   And I press "C-@"
  #   Then the region should be "x"
  #   And I press "C-u 3 C-@"
  #   Then the region should be "my_function(x, y)"



  # Scenario: Mark object property value  (inside property name)
  #   When I place the cursor after "char t = ar"
  #   And I press "C-@"
  #   Then the region should be "argv"
  #   And I press "C-@"
  #   Then the region should be "argv [x + 3]"

  # Scenario: Mark vector access (inside argument)
  #   When I place the cursor after "argv ["
  #   And I press "C-@"
  #   Then the region should be "x"
  #   And I press "C-u 3 C-@"
  #   Then the region should be "argv [x + 3]"




  Scenario: Mark outer return (before)
    When I place the cursor after "function(x) {"
    And I press "C-@"
    Then the region should be "return"
    When I press "C-@"
    Then the region should be "return x*x;"
  Scenario: Mark inner return (inside)
    When I place the cursor after "x*"
    And I press "C-@"
    Then the region should be "x"
    When I press "C-@"
    Then the region should be "x*x"
  Scenario: Mark inner return (after)
    When I place the cursor after "x*x"
    And I press "C-@"
    Then the region should be "x"
    When I press "C-@"
    Then the region should be "x*x"


  Scenario: Mark inner return (before)
    When I place the cursor after "return "
    And I press "C-@"
    Then the region should be "x"
    When I press "C-@"
    Then the region should be "x*x"
  Scenario: Mark inner return (inside)
    When I place the cursor after "x*"
    And I press "C-@"
    Then the region should be "x"
    When I press "C-@"
    Then the region should be "x*x"
  Scenario: Mark inner return (after)
    When I place the cursor after "x*x"
    And I press "C-@"
    Then the region should be "x"
    When I press "C-@"
    Then the region should be "x*x"


  # Scenario: Mark simple statement (before)
  #   When I place the cursor after "double"
  #   And I press "C-@"
  #   Then the region should be "double"
  #   When I press "C-@"
  #   Then the region should be "double y = 1.;"
    
  # Scenario: Mark simple statement (inside)
  #   When I place the cursor before "double"
  #   And I press "C-@"
  #   Then the region should be "double"
  #   When I press "C-@"
  #   Then the region should be "double y = 1.;"

  # Scenario: Mark simple statement (at end)
  #   When I place the cursor after "y = 1."
  #   And I press "C-@"
  #   Then the region should be "1."
  #   When I press "C-@"
  #   Then the region should be "double y = 1.;"



  Scenario: Mark complex statement (before)
    When I place the cursor after "fo"
    And I press "C-@"
    Then the region should be "for"
    And I press "C-@"
    Then the region should be "for(i; i < 10; i++)"

  # Scenario: Mark complex statement (inside)
  #   When I place the cursor after "i <"
  #   And I press "C-@"
  #   Then the region should be "10"
  #   And I press "C-@"
  #   Then the region should be "i < 10;"
  #   And I press "C-u 3 C-@"
  #   Then the region should be "for(i; i < 10; i++)"
    
  Scenario: Mark complex statement (at end)
    When I place the cursor after "10; i"
    And I press "C-@"
    Then the region should be "i"
    And I press "C-u 3 C-@"
    Then the region should be "for(i; i < 10; i++)"



  Scenario: Mark statement-block (inside statement)
    When I place the cursor after "fo"
    And I press "C-u 2 C-@"
    Then the region should be "for(i; i < 10; i++)"
    # And I press "C-@"
    # Then the region should be:
    # """
    # for(i; i < 10; i++) {
    #     doSomething (i);
    #   }
    # """

  # Scenario: Mark statement-block (inside block)
  #   When I place the cursor after "some"
  #   And I press "C-u 5 C-@"
  #   Then the region should be:
  #   """
  #   for(i; i < 10; i++) {
  #       doSomething (i);
  #     }
  #   """


