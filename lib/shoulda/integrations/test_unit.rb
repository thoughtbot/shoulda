require 'test/unit'

require 'shoulda/context'
require 'shoulda/proc_extensions'
require 'shoulda/assertions'
require 'shoulda/macros'
require 'shoulda/helpers'
require 'shoulda/autoload_macros'
require 'shoulda/rails' if defined? RAILS_ROOT
require 'shoulda/defect_localization_extension'

module Test # :nodoc: all
  module Unit
    class TestCase
      include Shoulda::InstanceMethods
      extend Shoulda::ClassMethods
      include Shoulda::Assertions
      extend Shoulda::Macros
      include Shoulda::Helpers
      include Shoulda::DefectLocalizationExtension
    end
  end
end

