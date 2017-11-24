# frozen_string_literal: true

require 'request_via/version'

module RequestVia

  Freeze = -> object { object.freeze }

  DEFAULT_HEADERS = Freeze.({
    'User-Agent' => "RequestVia v#{RequestVia::VERSION}"
  })

end
