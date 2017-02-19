require 'rails/generators'
require 'rails/generators/migration'
require 'active_record'
require 'rails/generators/active_record'
require 'generators/verified/migration'

module Verified
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend Verifed::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates an initializer to set required parameters"
      def copy_initializer
        print "Creating new initializer"
        template "initializer.rb", "config/initializers/verified.rb"
      end
      desc "Create migration for verification model"
      def copy_migration
        migration_template 'install.rb', 'db/migrate/CreateVerifications.rb'
      end

    end
  end
end
