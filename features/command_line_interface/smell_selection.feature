Feature: Smell selection
  In order to focus on particular code smells
  As a developer
  I want to be able to selectively activate smell detectors

  Scenario: --smell selects a smell to detect
    When I run reek --no-line-numbers --only DuplicateMethodCall spec/samples/two_smelly_files
    Then the exit status indicates smells
    And it reports:
      """
      spec/samples/two_smelly_files/dirty_one.rb -- 2 warnings:
        Dirty#a calls @s.title twice (DuplicateMethodCall)
        Dirty#a calls puts(@s.title) twice (DuplicateMethodCall)
      spec/samples/two_smelly_files/dirty_two.rb -- 2 warnings:
        Dirty#a calls @s.title twice (DuplicateMethodCall)
        Dirty#a calls puts(@s.title) twice (DuplicateMethodCall)

      """
