# `sandboxy` - Add a Sandbox to your Rails app

<img src="https://travis-ci.org/slooob/sandboxy.svg?branch=master" /> [![Gem Version](https://badge.fury.io/rb/sandboxy.svg)](https://badge.fury.io/rb/sandboxy)

Sandboxy adds a layer to specified ActiveRecord models to use live & sandbox data in the same environment & database. When the sandbox is enabled, your app will only use sandbox data for all ActiveRecord models `sandboxy` has been enabled on. The other way around, if the sandbox is enabled, your app will exclude any sandbox data.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Database](#Database)
    * [ActiveRecord Models](#activerecord-models)
        * [Adding sandbox functionality to all models](#adding-sandbox-functionality-to-all-models)
    * [Controllers](#contributors)
        * [Grape](#grape)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
* [License](#license)

---

## Installation

`sandboxy` works with Rails 4.0 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'sandboxy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sandboxy

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'sandboxy', github: 'slooob/sandboxy'
```

Now run the generator:

    $ rails g sandboxy

You can set your default `$sandbox` indicator by adding `--default true`. Learn more about usage [here](#usage).

Additionally you are able to specify to which database tables `sandboxy` should be added by passing an array of tables with the `--tables` option. Learn more about databases with `sandboxy` [here](#database).

To wrap things up, migrate the changes into your database:

    $ rails db:migrate

**Note:** You might want to read more about `sandboxy` [Databases](#database) before migrating your database. Use `rake db:migrate` instead if you run Rails < 5.

This will create an initializer as well as a migration file.

## Usage

Sandboxy is separated into three main parts, allowing the app to enter and leave sandbox mode at runtime.

### Database

After running the `sandboxy` generator, a migration file has been added. Running it adds a column named `sandbox` to every table existing. Now the `sandbox` database column is needed to differentiate between records created in sandbox or live mode.

If you only want to use `sandboxy` for specific ActiveRecord models you might want to consider updating the migration file to only add the column to their related tables.

Also make sure that all future tables added to your database contain a `sandbox` column if you are using `sandboxy` for their related models.

**Note:** You should not use `sandbox` columns in your database for any other purpose that might result in duplicating the column or later removing at accidentally.

### ActiveRecord Models

Within all ActiveRecord models of your application, you are able to add sandbox functionality by adding:

```ruby
sandboxy
```

#### Adding sandbox functionality to all models

If you are running Rails > 5, you could just add `sandboxy` into your `application_record.rb` file located in `app/models`.

For Rails < 5, you have to create a separate model, which inherits from the `ActiveRecord::Base` class:

```ruby
class Sandboxy < ActiveRecord::Base
    sandboxy
end
```

Now all models you want to add `sandboxy` to, can just inherit from the `Sandboxy` class instead.

**Note:** This method applies to Rails > 5 as well.

### Controllers

While the `config/initializers/sandboxy.rb` file indicates whether or not the sandbox is currently active, you are also able to change the mode on the fly at runtime.

For that just override the global `$sandbox` variable and set it to either `true` or `false`. You can do that from anywhere in your app, but it makes sense to do it in your controllers. Especially for APIs that is useful, because you can now provide separate credentials for live & sandbox and set `$sandbox` on authentication accordingly.

---

## To Do

* Create new records with `sandbox: true` if the sandbox is currently enabled!
* Automatically add `sandbox` column to new database tables

---

## Contributing

We hope that you will consider contributing to `sandboxy`. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/slooob/sandboxy/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/slooob/sandboxy/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/slooob/sandboxy/graphs/contributors

## License

MIT License

Copyright (c) 2017 Slooob

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
