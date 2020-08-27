#!/bin/env ruby
# frozen_string_literal: true

require 'thor'
require_relative '../lib/lorem_cuke'

# Executes the a cucumber feature generation
class LoremCukeThor < Thor
  desc 'generate', 'creates feature files that can always execute'
  option :root_dir, type: :string, default: '.'
  option :features, type: :numeric, default: 20
  option :scenarios, type: :numeric, default: 10
  def generate
    puts 'Generating'
    LoremCuke.new(options).generate
  end
end

LoremCukeThor.start(ARGV)
