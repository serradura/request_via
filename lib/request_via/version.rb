# frozen_string_literal: true

module RequestVia
  module SemVer
    MAJOR = 0
    MINOR = 3
    PATCH = 0
  end

  VERSION = [
    SemVer::MAJOR,
    SemVer::MINOR,
    SemVer::PATCH,
  ].join('.').freeze
end
