# frozen_string_literal: true

module RequestVia
  module SemVer
    MAJOR = 0
    MINOR = 5
    PATCH = 1
  end

  VERSION = [
    SemVer::MAJOR,
    SemVer::MINOR,
    SemVer::PATCH,
  ].join('.').freeze
end
