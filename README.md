# Sandboxy - virtual data-based environments for Rails

<img src="https://travis-ci.org/slooob/sandboxy.svg?branch=master" /> [![Gem Version](https://badge.fury.io/rb/sandboxy.svg)](https://badge.fury.io/rb/sandboxy)

Sandboxy allows to run two virtual data-based environments inside a Rails application while being able to switch in between at runtime.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Setup](#setup)
    * [Sandboxed methods](#sandboxed-methods)
    * [Switching environments](#switching-environments)
        * [Sandbox & APIs](#sandbox-&-apis)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
* [License](#license)

---

## Installation

Sandboxy works with Rails 4.0 onwards. You can add it to your `Gemfile` with:

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

You can specify that your application should use the sandbox by default by passing `--default true`. Learn more about switching environments [here](#switching-environments).

To wrap things up, migrate the changes into your database:

    $ rails db:migrate

**Note:** Use `rake db:migrate` instead if you run Rails < 5.

This will create an initializer as well as a migration file and the `Sandbox` model.

## Usage

### Setup

Add Sandboxy to the models where you want to separate live & sandbox reocrds:

```ruby
class Foo < ApplicationRecord
    sandboxy
end
```

In most use cases you would want to add sandboxy to a lot of ActiveRecord models if not all. To simplify that you could create a new class and let all your models inherit from it:

```ruby
class Sandboxy < ApplicationRecord
    sandboxy
end

class Foo < Sandboxy
end
```

### Sandboxed methods

By default you can only access records belonging to the current environment (`live` or `sandbox`):

```ruby
$sandbox = true
Foo.all # => returns all sandbox foo's
```

Now to access the records belonging to a certain group regardless of your current environment, you can use:

```ruby
Foo.live # => returns all live foo's
Foo.sandboxed # => returns all sandbox foo's
Foo.desandbox # => returns all foo's
```

Let's check to which environment this `Foo` belongs:

```ruby
foo = Foo.create!
foo.live? # => false
foo.sandboxed? # => true
```

You should keep in mind that when you create a new record, it will automatically belong to your app's current environment.

Don't worry, you can move records between environments:

```ruby
foo.make_live
foo.live? # => true
foo.make_sandboxed
foo.sandboxed? # => true
```

### Switching environments

In `config/initializers/sandboxy.rb` you define your app's default environment by setting the `$sandbox` variable.

You can override that variable anywhere in your application. That makes Sandboxy super flexible.

#### Sandbox & APIs

It's flexibility allows Sandboxy to work really well with APIs.

Typically an API provides two sets of authentication credentials for a consumer - one for live access and one for sandbox/testing.

Whenever you authenticate your API's consumer, just make sure to set the `$sandbox` variable accordingly to the credential the consumer used. From thereon, Sandboxy will make sure that your consumer only reads & updates data from the environment he is in.

---

## To Do

* Automatically add `sandbox` column to new database tables

---

## Contributing

We hope that you will consider contributing to Sandboxy. Please read this short overview for some information about how to get started:

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
