# frozen_string_literal: true

require_relative 'lorem_step_writer'

# Creates a scenario
class LoremScenario
  def initialize
    @lt = LoremTools.new
    @lsw = LoremStepWriter.new
  end

  def scenario
    scenario_string = "\n#{@lt.scenario_indent}@lorem\n#{@lt.scenario_indent}Scenario: #{@lt.step_words}\n"
    given_steps = @lt.step_words
    @lt.ensure_step given_steps
    scenario_string += "#{@lt.step_indent}Given #{given_steps}\n"
    scenario_base_size.times do
      step_str = @lt.step_words
      @lt.ensure_step step_str
      scenario_string += "#{@lt.step_indent}#{@lt.scenario_step_name.sample} #{step_str}\n"
    end
    scenario_fuzz.times do
      step_str = @lt.step_words
      @lt.ensure_step step_str
      scenario_string += "#{@lt.step_indent}#{@lt.scenario_after_step_name.sample} #{step_str} \n"
    end
    scenario_string
  end

  def scenario_base_size
    Random.rand 5..10
  end

  def scenario_fuzz
    Random.rand 1..5
  end
end
