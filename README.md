# Sandboxy

[![Gem Version](https://badge.fury.io/rb/sandboxy.svg)](https://badge.fury.io/rb/sandboxy) <img src="https://travis-ci.org/jonhue/sandboxy.svg?branch=master" />

Sandboxy allows you to use virtual data-oriented environments inside a Rails application while being able to switch between them at runtime. It achieves that by using a combination of Rack Middleware and ActiveRecord.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Setup](#setup)
    * [`sandboxy` methods](#sandboxy-methods)
    * [`Sandboxy` class methods](#sandboxy-class-methods)
    * [Switching environments](#switching-environments)
        * [Sandbox & APIs](#sandbox--apis)
* [Configuration](#configuration)
* [Testing](#testing)
    * [Test Coverage](#test-coverage)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

Sandboxy works with Rails 5.0 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'sandboxy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sandboxy

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'sandboxy', github: 'jonhue/sandboxy'
```

Now run the generator:

    $ rails g sandboxy

To wrap things up, migrate the changes into your database:

    $ rails db:migrate

## Usage

### Setup

Add Sandboxy to the models where you want to separate records depending on their environments:

```ruby
class Foo < ApplicationRecord
    sandboxy
end
```

In most use cases you would want to add `sandboxy` to a lot of ActiveRecord models if not all. To simplify that you could create a new class and let all your models inherit from it:

```ruby
class SharedSandbox < ApplicationRecord
    sandboxy
end

class Foo < SharedSandbox
end
```

### `sandboxy` methods

By default you can only access records belonging to the current environment (defined by `Sandboxy.environment`):

```ruby
Sandboxy.environment = 'sandbox'
Foo.all # => returns all sandbox foo's
```

Now to access the records belonging to a certain environment regardless of your current environment, you can use:

```ruby
Foo.live_environment # => returns all live foo's
Foo.sandboxed_environment # => returns all sandbox foo's
Foo.desandbox # => returns all foo's
```

Let's check to which environment this `Foo` belongs:

```ruby
foo = Foo.create!
foo.live_environment? # => false
foo.sandbox_environment? # => true
```

You should keep in mind that when you create a new record, it will automatically belong to your app's current environment.

Don't worry, you can move records between environments:

```ruby
foo.move_environment_live
foo.live_environment? # => true
foo.move_environment_sandbox
foo.sandbox_environment? # => true
```

### `Sandboxy` class methods

To access your default environment setting:

```ruby
Sandboxy.configuration.environment # => 'live' / 'sandbox'
Sandboxy.configuration.sandbox_environment? # => true / false
Sandboxy.configuration.live_environment? # => true / false
```

**Note:** `Sandboxy.configuration.environment` does *NOT* return the apps current environment. For that use [`Sandboxy.environment` variable](#switching-environments) instead.

You can also access whether your app retains your environment throughout requests:

```ruby
Sandboxy.configuration.retain_environment # => true / false
```

If `retain_environment` is set to `false` your app will return to your default environment on every new request.

### Switching environments

At runtime you can always switch environments anywhere in your application by setting `Sandboxy.environment`. You can set it to any string you like. That makes Sandboxy super flexible.

```ruby
Sandboxy.environment = 'live'
Sandboxy.live_environment? # => true
Sandboxy.sandboxy_environment? # => true
```

#### Sandbox & APIs

It's flexibility allows Sandboxy to work really well with APIs.

Typically an API provides two sets of authentication credentials for a consumer - one for live access and one for sandbox/testing.

Whenever you authenticate your API's consumer, just make sure to set `Sandboxy.environment` accordingly to the credential the consumer used. From thereon, Sandboxy will make sure that your consumer only reads & updates data from the environment he is in.

---

## Configuration

You can configure Sandboxy by passing a block to `configure`. This can be done in `config/initializers/sandboxy.rb`:

```ruby
Sandboxy.configure do |config|
    config.environment = 'sandbox'
end
```

**`environment`** Set your environment default. This is the environment that your app boots with. By default it gets refreshed with every new request to your server. Defaults to `'live'`.

**`retain_environment`** Specify whether to retain your current app environment on new requests. If set to `true`, your app will only load your environment default when starting. Every additional switch of your environment at runtime will then not be automatically resolved to your environment default on a new request. Takes a boolean. Defaults to `false`.

---

## Testing

Tests are written with Shoulda on top of `Test::Unit` with Factory Girl being used instead of fixtures. Tests are run using rake.

1. Fork this repository
2. Clone your forked git locally
3. Install dependencies

    `$ bundle install`

4. Run tests

    `$ rake test`

### Test Coverage

Test coverage can be calculated using SimpleCov. Make sure you have the [simplecov gem](https://github.com/colszowka/simplecov) installed.

1. Uncomment SimpleCov in the Gemfile
2. Uncomment the relevant section in `test/test_helper.rb`
3. Run tests

    `$ rake test`

---

## To Do

[Here](https://github.com/jonhue/sandboxy/projects/1) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/sandboxy/issues/new).

---

## Contributing

We hope that you will consider contributing to Sandboxy. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/sandboxy/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/sandboxy/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/sandboxy/graphs/contributors

### Semantic Versioning

Sandboxy follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2017 Jonas Hübotter

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
