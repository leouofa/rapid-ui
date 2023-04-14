# frozen_string_literal: true

module RapidUi
  module ViewHelpers
    # Shortcut for accessing the ui method
    # We are calling it UX for a number of reasons.
    # 1. To avoid name collisions during the recursion.
    # 2. It looks better then 'ui' on the front end.

    def ux
      Ui::Display.instance
    end
  end
end
