# frozen_string_literal: true

module Ui
  class Utilities
    include Singleton

    def initialize
      @config = RapidUi.configuration.ui_hash
    end

    def defaults(component:)
      @config["ui"][component.to_s]
    end
  end
end
