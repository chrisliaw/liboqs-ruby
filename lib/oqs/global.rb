
require 'tlogger'
require 'singleton'

module Oqs
  class Global
    include Singleton

    attr_accessor :logger
    def initialize
      logPath = ENV['OQS_LOG_PATH']
      if not (logPath.nil? or logPath.empty?)
        @logger = Tlogger.new(logPath,10,1024*1024*10)
      else
        @logger = Tlogger.new
      end
    end
  end
end
