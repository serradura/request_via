# frozen_string_literal: true

module RequestVia
  module SemanticVersion
    def self.call(major, minor, patch)
      [ major, minor, patch ]
        .join('.')
        .freeze
    end
  end

  VERSION = SemanticVersion.(0, 5, 1)
end
