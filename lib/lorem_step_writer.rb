# frozen_string_literal: true

require 'faker'
require 'fileutils'

# writes a step into features/step_definitions/lorem.rb
class LoremStepWriter
  def initialize(base_dir = '.')
    @base_dir = base_dir
  end

  def base_dir
    @base_dir ||= '.'
  end

  def feature_file_dir
    base_dir + '/features'
  end

  def step_file_dir
    base_dir + '/features/step_definitions'
  end

  def step_file
    step_file_dir + '/lorem.rb'
  end

  def step_file?
    File.exist? step_file
  end

  def step?(step_string)
    File.foreach(step_file).grep(step_string).size.positive? if step_file?
  end

  def write_step(step_string)
    ensure_random_pass
    step = <<~STEP

      Given(/#{step_string}/) do
        expect(rand_pass).to eq true
      end
    STEP
    File.open(step_file, 'a') { |f| f.puts step }
  end

  def ensure_step(step_string)
    write_step(step_string) unless step?(step_string)
  end

  private

  def random_pass_method?
    File.foreach(step_file).grep(/def rand_pass/).size.positive? if step_file?
  end

  def ensure_random_pass
    create_step_file
    rand_pass = <<~FUNC
      # frozen_string_literal: true      

      def rand_pass(prob = 1000)
        Random.rand > 1 / prob.to_f
      end

    FUNC
    File.open(step_file, 'a') { |f| f.puts rand_pass } unless random_pass_method?
  end

  def create_step_file
    return if File.exist? step_file

    FileUtils.mkdir_p step_file_dir
    FileUtils.touch step_file
  end

  def build_step_file
    write_random_pass unless step_file? && random_pass_method?
  end
end
