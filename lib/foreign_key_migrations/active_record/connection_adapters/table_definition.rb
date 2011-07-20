module ForeignKeyMigrations::ActiveRecord::ConnectionAdapters
  module TableDefinition
    def self.included(base)
      base.class_eval do
        alias_method_chain :column, :foreign_key_migrations
        alias_method_chain :primary_key, :foreign_key_migrations
      end
    end

    def primary_key_with_foreign_key_migrations(name, options = {})
      column(name, :primary_key, options)
    end

    def indices
      @indices ||= []
    end

    def column_with_foreign_key_migrations(name, type, options = {})
      column_without_foreign_key_migrations(name, type, options)
      unless ForeignKeyMigrations.disable
        references = ActiveRecord::Base.references(self.name, name, options)
        if references
          ForeignKeyMigrations.set_default_update_and_delete_actions!(options)
          foreign_key(name, references.first, references.last, options)
          if index = fkm_index_options(options)
            # append [column_name, index_options] pair
            self.indices << [name, ForeignKeyMigrations.options_for_index(index)]
          end
        elsif options[:index]
          self.indices << [name, ForeignKeyMigrations.options_for_index(options[:index])]
        end
      end
      self
    end

    # Some people liked this; personally I've decided against using it but I'll keep it nonetheless
    def belongs_to(table, options = {})
      options = options.merge(:references => table)
      options[:on_delete] = options.delete(:dependent) if options.has_key?(:dependent)
      column("#{table.to_s.singularize}_id".to_sym, :integer, options)
    end

    protected
    def fkm_index_options(options)
      options.fetch(:index, fkm_use_auto_index?)
    end

    def fkm_use_auto_index?
      ForeignKeyMigrations.auto_index && !ActiveRecord::Schema.defining?
    end
  end
end
