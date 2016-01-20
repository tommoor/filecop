[![Gem Version](https://badge.fury.io/rb/filecop.svg)](https://badge.fury.io/rb/filecop)

# Filecop

Filecop is designed to find sensitive files in a provided list. Ideally this would be integrated into something like a git pre-commit hook or post commit check to reduce instances of leaked credentials.

The base list of sensitive files is from [jandre/safe-commit-hook](https://github.com/jandre/safe-commit-hook/blob/master/git-deny-patterns.json) - I hope to add to this and contribute back over time.

Filecop is one of the many behaviors automatically run against your code by [Pushbit](https://www.pushbit.co), check it out!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'filecop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filecop

## Usage

Using filecop is easy, pass no arguments to check all files in the current directory from the command line:

    $ filecop

or pass a list of individual files to check:

    $ filecop private.key README.md .bashrc

Output will look something like this:

```
Checking 3 files

Issues:

private.key: Potential cryptographic private key
.bashrc: Shell configuration file

3 files checked, 2 potential problems
```

Or pass the `--json` flag to get a machine parseable output

```
[
  {"file": "private.key", "message": "Potential cryptographic private key"},
  {"file": ".bashrc", "message": "Shell configuration file"}
]
```

You can also require filecop to use within a Ruby script like so:

```
require('filecop')
filecop = Filecop::Runner(['private.key', '.bashrc'])
result = filecop.run
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tommoor/filecop.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

