module VueOnRails
  class Railtie < Rails::Railtie
    ActiveSupport.on_load(:action_view) do
      include ::VueOnRails::ViewHelper
    end
  end
end