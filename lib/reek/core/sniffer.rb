require 'reek/core/code_parser'
require 'reek/core/smell_repository'
require 'reek/source/config_file'
require 'yaml'

module Reek
  module Core

    #
    # Configures all available smell detectors and applies them to a source.
    #
    class Sniffer

      # FIXME: Pass ConfigFile objects instead of file names
      # FIXME: Demand SmellRepository to always be passed
      def initialize(src, config_files = [], smell_repository=Core::SmellRepository.new(src.desc))
        @smell_repository = smell_repository
        # FIXME: We want to configure the @smell_repostory here, pass that to configure
        config_files.each{ |cf| Reek::Source::ConfigFile.new(cf).configure(self) }
        @source = src
        src.configure(self)
      end

      def configure(klass, config)
        @smell_repository.configure klass, config
      end

      def report_on(listener)
        CodeParser.new(@smell_repository).process(@source.syntax_tree)
        @smell_repository.report_on(listener)
      end

      def examine(scope, node_type)
        @smell_repository.examine scope, node_type
      end
    end
  end
end
