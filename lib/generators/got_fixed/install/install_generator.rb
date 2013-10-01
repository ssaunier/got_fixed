module GotFixed
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      desc "Install GotFixed into your app (config + route)"

      source_root File.expand_path("../templates", __FILE__)

      def copy_default_config
        copy_file "got_fixed.yml", "config/got_fixed.yml"
      end

      def add_route
        route "mount GotFixed::Engine => '/got_fixed'"
      end

      def copy_views
        directory "views", "app/views"
      end

    end
  end
end