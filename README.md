# ActiveRecord::Missing

By [ActiveBridge](https://active-bridge.com/).

[![Build Status](https://travis-ci.org/Surzhko/activerecord-missing.svg?branch=master)](https://travis-ci.org/Surzhko/activerecord-missing)
[![Dependency Status](https://gemnasium.com/badges/github.com/Surzhko/activerecord-missing.svg)](https://gemnasium.com/github.com/Surzhko/activerecord-missing)
[![Code Climate](https://codeclimate.com/github/Surzhko/activerecord-missing/badges/gpa.svg?branch=master)](https://codeclimate.com/github/Surzhko/activerecord-missing)
[![Inline docs](http://inch-ci.org/github/Surzhko/activerecord-missing.svg?branch=master)](http://inch-ci.org/github/Surzhko/activerecord-missing)
[![security](https://hakiri.io/github/Surzhko/activerecord-missing/master.svg)](https://hakiri.io/github/Surzhko/activerecord-missing/master)

ActiveRecord::Missing is a solution for Rails based applications. Allows easily find and support missing foreign keys (, unique and some other validations). It:

* Is a solution based on ActiveRecord;
* Is based on a modularity concept: use only what you really need.

At the moment it's composed of 1 module:

* Missing Foreign Keys

## Getting started

For setup ActiveRecord::Missing 0.1.0 add this line to your application's Gemfile:

```ruby
gem 'activerecord-missing'
```

And then execute:

    $ bundle install

## Usage

After you bundle install ActiveRecord::Missing, you need to run the generator:

    $ rails g active_record:missing:install

The generator will install an initializer which describes all of ActiveRecord::Missing's configuration options.

Migration with missed foreign keys will created after run generator:

    $ rails g active_record:missing:foreign_keys add_missing_fks

`add_missing_fks` is a name of migration, and it can be different.

Perhaps you want to know all missing data before make migration.
Run this task and it will print missing data for you:

    $ rake db:missing:foreign_keys

## Configuration

The ActiveRecord::Missing provide configure gem functionality in initializer `config/initializers/activerecord_missing.rb`

```ruby
ActiveRecord::Missing.configure do |config|
  config.foreign_keys do |fk|                   # configuration foreign keys module
    fk.ignore "users"                           # ignore the entire table
    fk.ignore "posts", "all"                    # also ignore the entire table
    fk.ignore "photos", "user_id", "post_id"    # ignore columns wrote after table name
  end
end
```

## License

Copyright 2016 ActiveBridge. https://active-bridge.com
