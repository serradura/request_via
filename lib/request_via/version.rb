# frozen_string_literal: true

module RequestVia
  VERSION = (-> (major, minor, patch) {
    [ major, minor, patch ]
      .join('.')
      .freeze
  }).(0, 5, 1)
end
