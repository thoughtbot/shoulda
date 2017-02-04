require_relative '../../tests/bundle'
require_relative '../../tests/filesystem'

module AcceptanceTests
  module BaseHelpers
    def fs
      @_fs ||= Tests::Filesystem.new
    end

    def bundle
      @_bundle ||= Tests::Bundle.new
    end
  end
end
