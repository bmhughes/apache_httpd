#
# Cookbook:: apache_httpd
# Library:: template
#
# Copyright:: Ben Hughes, All Rights Reserved.

module ApacheHttpd
  module Cookbook
    module TemplateHelpers
      include ::TestNetHelpers::GeneralHelpers

      DEFAULT_TEMPLATE_VARIABLES ||= %i(
        @_extension_modules
        @node
        @template_finder
        @cookbook_name
        @recipe_name
        @recipe_line_string
        @recipe_path
        @recipe_line
        @template_name
        @template_path
      ).freeze

      def template_variables
        instance_variables.reject { |iv| ::ApacheHttpd::Cookbook::TemplateHelpers::DEFAULT_TEMPLATE_VARIABLES.include?(iv) }.sort
      end

      def template_render_option_values(values)
        case values
        when Array
          values.join(' ')
        when Hash
          values.map { |k, v| [k, template_render_option_values(v)] }.join(' ')
        else
          values
        end
      end

      def template_partial_indent(output, level, spaces = 2)
        raise ArgumentError, 'Spaces must be greater than 0' unless spaces > 0

        output.split("\n").each { |l| l.prepend(' ' * (level * spaces)) }.join("\n")
      end
    end
  end
end
