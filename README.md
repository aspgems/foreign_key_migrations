[![Build Status](https://secure.travis-ci.org/aspgems/foreign_key_migrations.png)](http://travis-ci.org/aspgems/foreign_key_migrations)

Foreign Key Migrations
======================

Foreign Key Migrations is a plugin that automatically generates foreign-key
constraints when creating tables. It uses SQL-92 syntax and as such should be
compatible with most databases that support foreign-key constraints.

In the simplest case, the plugin assumes that if you have a column named
<tt>customer_id</tt> that you want a foreign-key constraint generated that references
the <tt>id</tt> column in the <tt>customers</tt> table:

```ruby
    create_table :orders do |t|
      t.column :customer_id, :integer, :null => false
      ...
    end
```

If you have multiple columns referencing a table or for whatever reason, your
column name isn't the same as the referenced table name, you can use the
`:references` option:

```ruby
    create_table :orders do |t|
      t.column :ordered_by_id, :integer, :null => false, :references => :customers
      ...
    end
```

If you have a column with a name ending in <tt>_id</tt> for which you do not wish a
foreign-key to be generated, you can use `:references => nil`:

```ruby
    create_table :orders do |t|
      t.column :external_id, :integer, :null => false, :references => nil
      ...
    end
```

Sometimes you may (for legacy reasons) need to reference a primary key column that is
named something other than <tt>id</tt>. In this case you can specify the name of the column:

```ruby
    create_table :orders do |t|
      t.column :ordered_by_pk, :integer, :null => false, :references => [:customers, :pk]
      ...
    end
```

You also have the option of specifying what to do on delete/update using
`:on_delete`/`:on_update`, respectively to one of:
`:cascade`; `:restrict`; and `:set_null`:

```ruby
    create_table :orders do |t|
      t.column :customer_id, :integer, :on_delete => :set_null, :on_update => :cascade
      ...
    end
```

If your database supports it (for example PostgreSQL) you can also mark the constraint as deferrable:

```ruby
    create_table :orders do |t|
      t.column :customer_id, :integer, :deferrable => true
      ...
    end
```

By convention, if a column is named <tt>parent_id</tt> it will be treated as a circular reference to
the table in which it is defined.

Sometimes you may (for legacy reasons) need to name your primary key column such that it
would be misinterpreted as a foreign-key (say for example if you named the primary key
<tt>order_id</tt>). In this case you can manually create the primary key as follows:

```ruby
    create_table :orders, :id => false do |t|
      ...
      t.primary_key :order_id, :references => nil
    end
```

There is also a generator for creating foreign keys on a database that currently has none:

    ruby script/generate foreign_key_migration

The plugin fully supports and understands the following active-record
configuration properties:

* `config.active_record.pluralize_table_names`
* `config.active_record.table_name_prefix`
* `config.active_record.table_name_suffix`

Install
-------

Put this line in your Gemfile:

    gem 'aspgems-foreign_key_migrations', '~> 2.0.0.beta1', :require => 'foreign_key_migrations'

Then bundle:

    % bundle

Dependencies
------------

* RedHill on Rails Core (redhillonrails_core) aspgems version.

NOTE
----

* Code was created by harukizaemon(http://github.com/harukizaemon) but is not supported currently by him.

License
-------

This plugin is copyright 2006 by RedHill Consulting, Pty. Ltd. and is released
under the MIT license.
