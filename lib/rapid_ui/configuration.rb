# frozen_string_literal: true

# handles loading and serving of the configuration files
module RapidUi
  # contains the configuration itself
  class Configuration
    attr_accessor :ui_file, :ui_yml, :ui_hash

    def initialize
      @ui_file = nil

      @ui_hash = nil
      @ui_yml = nil
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.boot
    raise "No ui file provided!" if configuration.ui_file.nil?

    configuration.ui_hash = YAML.load_file(configuration.ui_file)
  end
end
