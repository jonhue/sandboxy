# Sandboxy

Sandboxy allows you to use virtual data-oriented environments inside a Rails application while being able to switch between them at runtime. It achieves that by using a combination of Rack Middleware and ActiveRecord.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Setup](#setup)
  * [`sandboxy` methods](#sandboxy-methods)
  * [Switching environments](#switching-environments)
    * [Sandbox & APIs](#sandbox--apis)
* [Configuration](#configuration)
* [Testing](#testing)
  * [Test Coverage](#test-coverage)
* [Release](#release)
* [Contributing](#contributing)
  * [Semantic versioning](#semantic-versioning)

---

## Installation

Sandboxy works with Rails 5 onwards. You can add it to your `Gemfile` with:

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
  self.abstract_class = true
  sandboxy
end

class Foo < SharedSandbox
end
```

### `sandboxy` methods

By default you can only access records belonging to the current environment (defined by `Sandboxy.environment`):

```ruby
Sandboxy.environment = 'test'
Foo.all # => returns all test foo's
Sandboxy.environment = 'sandbox'
Foo.all # => returns all sandbox foo's
```

Now to access the records belonging to a certain environment regardless of your current environment, you can use:

```ruby
Foo.live_environment # => returns all live foo's
Foo.sandbox_environment # => returns all sandbox foo's
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

### Switching environments

At runtime you can always switch environments anywhere in your application by setting `Sandboxy.environment`. You can set it to any string you like. That makes Sandboxy super flexible.

```ruby
Sandboxy.environment = 'live'
Sandboxy.live_environment? # => true
Sandboxy.sandbox_environment? # => false
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
  config.default = 'sandbox'
end
```

**`default`** Set your environment default. This is the environment that your app boots with. By default it gets refreshed with every new request to your server. Takes a string. Defaults to `'live'`.

**`retain`** Retain your current app environment on new requests. If set to `false`, your app will return to your default environment on every new request. Takes a boolean. Defaults to `false`.

---

## Testing

Tests are written with Shoulda on top of `Test::Unit` with Factory Girl being used instead of fixtures. Tests are run using rake.

1. Fork this repository
2. Clone your forked git locally
3. Install dependencies

    ```
    $ bundle install
    ```

4. Run tests

    ```
    $ bundle exec rake test
    ```

### Test Coverage

Test coverage can be calculated using SimpleCov. Make sure you have the [simplecov gem](https://github.com/colszowka/simplecov) installed.

1. Add SimpleCov to the Gemfile
2. Uncomment the relevant section in `test/test_helper.rb`
3. Run tests

    $ rake test

---

## Release

1. Review breaking changes and deprecations in `CHANGELOG.md`
2. Change the gem version in `lib/sandboxy/version.rb`
3. Reset `CHANGELOG.md`
4. Create a pull request to merge the changes into `master`
5. After the pull request was merged, create a new release listing the breaking changes and commits on `master` since the last release.
6. The release workflow will publish the gems to RubyGems and the GitHub Package Registry

---

## Contributing

We hope that you will consider contributing to Sandboxy. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](CONTRIBUTING.md), [Code of Conduct](CODE_OF_CONDUCT.md)

### Semantic Versioning

Sandboxy follows Semantic Versioning 2.0 as defined at http://semver.org.
