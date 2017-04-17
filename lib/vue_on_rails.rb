require "rails"
require "vue_on_rails/version"

module VueOnRails
  if defined?(::Rails) and Gem::Requirement.new('>= 4.0').satisfied_by?(Gem::Version.new ::Rails.version)
    require 'vue_on_rails/engine'
    require 'vue_on_rails/view_helper'
    require 'vue_on_rails/railtie'
  end
end
