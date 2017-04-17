module VueOnRails
  module ViewHelper
    def vue_component(component_name, props = {}, html_options = {})
      html_options = html_options.reverse_merge(data: {})
      props = VueOnRails::ViewHelper.format_props(props)
      html_options[:data].tap do |data|
        data[:vue_component] = component_name
        data[:vue_props] = props.to_json
      end
      html_tag = html_options[:tag] || :div
      html_options.except!(:tag)
      content_tag(html_tag, '', html_options)
    end

    def self.format_props(props)
      case props
        when Hash
          props.each_with_object({}) do |(key, value), new_props|
            new_key = key.to_s.dasherize
            new_props[new_key] = VueOnRails::ViewHelper.camelize_props(value)
          end
        else
          props
      end
    end

    def self.camelize_props(props)
      case props
        when Hash
          props.each_with_object({}) do |(key, value), new_props|
            new_key = key.to_s.camelize(:lower)
            new_props[new_key] = VueOnRails::ViewHelper.camelize_props(value)
          end
        else
          props
      end
    end
  end
end