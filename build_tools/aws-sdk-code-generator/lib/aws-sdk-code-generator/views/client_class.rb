module AwsSdkCodeGenerator
  module Views
    class ClientClass < View

      # @option options [required, String] :service_identifier
      # @option options [required, String] :service_name
      # @option options [required, String] :module_name
      # @option options [required, String] :gem_name
      # @option options [required, String] :gem_version
      # @option options [required, String] :aws_sdk_core_lib_path
      # @option options [required, String] :protocol
      # @option options [required, String] :signature_version
      # @option options [required, Hash] :add_plugins
      # @option options [required, Array] :remove_plugins
      # @option options [required, Hash] :api
      # @option options [Hash] :waiters
      # @option options [Hash] :client_examples
      def initialize(options)
        @service_identifier = options.fetch(:service_identifier)
        @service_name = options.fetch(:service_name)
        @module_name = options.fetch(:module_name)
        @gem_name = options.fetch(:gem_name)
        @gem_version = options.fetch(:gem_version)
        @plugins = PluginList.new(options)
        @client_constructor = ClientConstructor.new(plugins: @plugins)
        @operations = ClientOperationList.new(options).to_a
        @waiters = Waiter.build_list(options[:waiters])
      end

      # @return [String]
      attr_reader :service_identifier

      # @return [String]
      attr_reader :service_name

      # @return [String]
      attr_reader :module_name

      # @return [String]
      attr_reader :gem_name

      # @return [String]
      attr_reader :gem_version

      # @return [ClientConstructor]
      attr_reader :client_constructor

      # @return [Array<Operation>]
      attr_reader :operations

      # @return [Array<String>]
      def plugin_requires
        @plugins.map(&:require_path)
      end

      # @return [Array<String>]
      def plugin_class_names
        @plugins.map(&:class_name)
      end

      # @return [Array<Waiter>]
      def waiters
        @waiters
      end

      # @return [Boolean]
      def waiters?
        @waiters.size > 0
      end

      # @return [String<Markdown>]
      def waiters_markdown_table
        Waiter.markdown_table(@waiters)
      end

    end
  end
end
