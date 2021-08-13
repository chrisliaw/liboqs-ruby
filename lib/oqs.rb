# frozen_string_literal: true

require_relative "oqs/version"
require_relative "oqs/struct"
require_relative "oqs/global"
require_relative "oqs/kem"
require_relative "oqs/sig"

module Oqs
  class Error < StandardError; end
  # Your code goes here...

  # OQS_STATUS
  OQS_ERROR = -1
  OQS_SUCCESS = 0
  OQS_EXTERNAL_LIB_ERROR_OPENSSL = 50

end
