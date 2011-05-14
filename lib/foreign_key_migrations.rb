require 'redhillonrails_core'

module ForeignKeyMigrations
  module ActiveRecord
    extend ActiveSupport::Autoload

    autoload :Base
    autoload :Migration

    module ConnectionAdapters
      extend ActiveSupport::Autoload

      autoload :TableDefinition
      autoload :SchemaStatements
    end
  end

  # Default FK update action
  mattr_accessor :on_update
  @@on_update = :restrict

  # Default FK delete action
  mattr_accessor :on_delete
  @@on_delete = :restrict

  # Create an index after creating FK (default false)
  mattr_accessor :auto_index
  @@auto_index = nil

  # FIXME Not used by now
  def self.setup(&block)
    yield self
  end

  def self.options_for_index(index)
    index.is_a?(Hash) ? index : {}
  end

  def self.set_default_update_and_delete_actions!(options)
    options[:on_update] = options.fetch(:on_update, ForeignKeyMigrations.on_update)
    options[:on_delete] = options.fetch(:on_delete, ForeignKeyMigrations.on_delete)
  end
end

ActiveRecord::Base.send(:include, ForeignKeyMigrations::ActiveRecord::Base)
ActiveRecord::Migration.send(:include, ForeignKeyMigrations::ActiveRecord::Migration)
ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, ForeignKeyMigrations::ActiveRecord::ConnectionAdapters::TableDefinition)
ActiveRecord::ConnectionAdapters::SchemaStatements.send(:include, ForeignKeyMigrations::ActiveRecord::ConnectionAdapters::SchemaStatements)
