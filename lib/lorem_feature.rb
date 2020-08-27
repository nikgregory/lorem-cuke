# frozen_string_literal: true

require 'faker'

require_relative 'lorem_scenario'
require_relative 'lorem_scenario_outline'
require_relative 'lorem_step_writer'
require_relative 'lorem_tools'

# Generates a feature file with a number of scenarios
# and outlines
class LoremFeature
  def initialize(scenarios = 10)
    @lt = LoremTools.new
    @lsw = LoremStepWriter.new
    @ls = LoremScenario.new
    @scenario_count = Random.rand 3..scenarios
  end

  def scenario_fuzz
    Random.rand 1..5
  end

  def feature_name
    @feature_name ||= @lt.feature_words
  end

  def feature_file_name
    @feature_file_name ||= feature_name.gsub(' ', '_') + '.feature'
  end

  def feature_file_path
    @lsw.feature_file_dir + '/' + feature_file_name
  end

  def feature_preamble
    "Feature: #{feature_name}\n\n"
  end

  def write_features
    FileUtils.mkdir_p @lsw.feature_file_dir
    FileUtils.touch feature_file_path

    File.open(feature_file_path, 'a') do |f|
      f.puts feature_preamble
      f.puts background
      f.puts "\n"
    end

    File.open(feature_file_path, 'a') do |f|
      @scenario_count.times do
        f.puts @ls.scenario
      end
    end
  end

  def background
    step_count = Random.rand 1..4
    background_string = "#{@lt.scenario_indent}Background:\n"
    given_steps = @lt.step_words
    @lt.ensure_step given_steps
    background_string += "#{@lt.step_indent}Given #{given_steps} \n"
    step_count.times do
      step_str = @lt.step_words
      @lt.ensure_step step_str
      background_string += "#{@lt.step_indent}#{@lt.background_step_name.sample} #{step_str} \n"
    end
    background_string
  end
end
