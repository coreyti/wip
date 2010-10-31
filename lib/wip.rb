require 'rubygems'
require 'rbconfig'
require 'fileutils'
require 'pathname'
require 'yaml'
require 'wip/version'

module WIP
  autoload :UI,    'wip/ui'

  class WIPError < StandardError
    def self.status_code(code = nil)
      define_method(:status_code) { code }
    end
  end

  class << self
    attr_writer :ui

    def ui
      @ui ||= UI.new
    end

    def home
      @home ||= ENV['HOME'].strip
    end

    def here
      @here ||= Dir.pwd
    end

    def index
      @index ||= Index.new
    end
  end
end
