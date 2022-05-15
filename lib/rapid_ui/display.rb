# frozen_string_literal: true

module Ui
  class Display < ActionView::Base
    include Singleton
    include ViewComponent

    def initialize
      RapidUi.configuration.ui_yml['ui'].each do |ui_element|
        define_singleton_method ui_element[0].to_s do |args = {}|
          # for convenience we allow people to only pass a class string
          # it is the same as setting a class
          args = { class: args } if args.is_a?(String)

          WrapperComponent.new(ui_element[0].to_sym, args)
        end
      end
    end
  end
end
