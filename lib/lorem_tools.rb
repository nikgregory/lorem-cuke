# frozen_string_literal: true

require 'faker'

require_relative 'lorem_step_writer'

# Common hodge-podge things needed for cukes
class LoremTools
  def initialize(base_dir = '.')
    @lsw = LoremStepWriter.new base_dir
  end

  def step_words
    lorem_words 4..8
  end

  def feature_words
    lorem_words 2..5
  end

  def scenario_words
    lorem_words 3..8
  end

  def lorem_words(range = 4..8)
    Faker::Lorem.words(supplemental: true, number: Random.rand(range)).join ' '
  end

  def scenario_indent
    '  '
  end

  def step_indent
    '    '
  end

  def example_table_indent
    '      '
  end

  def background_step_name
    ['And']
  end

  def scenario_step_name
    %w[When And]
  end

  def scenario_after_step_name
    %w[Then And]
  end

  def ensure_step(step_string)
    @lsw.ensure_step step_string
  end
end
