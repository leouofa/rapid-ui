# frozen_string_literal: true

require 'hashie'
require "view_component"

# require 'byebug'

require_relative "rapid_ui/version"
require_relative "rapid_ui/configuration"

require_relative "rapid_ui/display"
require_relative "rapid_ui/utilities"
require_relative "rapid_ui/component"

require_relative "rapid_ui/helpers"
require_relative "rapid_ui/railtie"

module RapidUi
  class Error < StandardError; end
end
