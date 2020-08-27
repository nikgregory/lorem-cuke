# frozen_string_literal: true

require 'faker'

require_relative 'lorem_feature'
# Generator class for cucumber scenarios.
# This will create lorem-ipsum named features and scenarios
# With a set of steps that have a strong likelyhood of passing.
class LoremCuke
  attr_reader :features, :scenarios
  def initialize(options = nil)
    @features = options[:features] || 20
    @scenarios = options[:scenarios] || 10
  end

  def generate
    features.times do
      lf = LoremFeature.new scenarios
      lf.write_features
    end
  end
end
