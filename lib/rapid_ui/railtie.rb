# frozen_string_literal: true

module RapidUi
  class Railtie < Rails::Railtie
    initializer "rapid_ui.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include RapidUi::ViewHelpers
      end
    end

    rake_tasks do
      load "tasks/rapid_ui.rake"
    end
  end
end
