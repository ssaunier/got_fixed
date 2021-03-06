module GotFixed
  class Engine < ::Rails::Engine
    isolate_namespace GotFixed

    config.generators do |g|
      g.test_framework :rspec, :fixture => false, :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
