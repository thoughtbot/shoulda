require_relative 'helpers/active_model_helpers'
require_relative 'helpers/base_helpers'
require_relative 'helpers/command_helpers'
require_relative 'helpers/gem_helpers'
require_relative 'helpers/step_helpers'

module AcceptanceTests
  module Helpers
    include ActiveModelHelpers
    include BaseHelpers
    include CommandHelpers
    include GemHelpers
    include StepHelpers

    def setup
      fs.clean
    end
  end
end
