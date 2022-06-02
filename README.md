# Fountain PAPI Ruby Client

[Fountain Partners API (PAPI)](https://partners.fountain.com/) ruby client. Helps get started quickly interfacing with PAPI. Today, the library allows for creating partner statuses for an applicant.

In the future, this library is intended be at feature-parity with PAPI operation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fountain-papi'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fountain-papi

## Configuration

Create an initializer in `config/initializers/fountain-papi.rb` with your Partner ID and API Key:

```ruby
Fountain::Papi.configure do |config|
  config.api_key = "db516773-4615-4bfa-bce8-94fe9bb951b2" # YOUR API KEY HERE
  config.partner_id = "3870fc40-d0f7-449e-8152-2a741ef3b301" # YOUR PARTNER ID HERE

  # Additional options:
  config.sandbox = true
  config.version = 1
end
```

If you do not have either of those keys, please reach out to your Fountain partner representative. When you're ready to update your partner to production, set `config.sandbox = false` in the above configuration.

## Usage

Today the Ruby client supports [creating Applicant statuses](https://partners.fountain.com/reference/post_v1-partners-id-applicants-applicant-id-status).

```ruby
result = Fountain::Papi.create_status(
  applicant_id: "231ea206-4d6e-4d7c-80d0-81dff956a197",
  status: "in_progress",
)

# => #<Fountain::Papi::Applicant::Status status="in_progress" applicant_id="231ea206-4d6e-4d7c-80d0-81dff956a197" account_option=nil link_title=nil title=nil url=nil category=nil color="green" display_status="[Partner Name] In Progress" display_title="[Partner Name] In Progress" external_id="b87ab326-ee84-40aa-a28e-9d520cfeaca8" show_redo=false status_type=nil>

result.status
# => "in_progress"

result.applicant_id
# => "231ea206-4d6e-4d7c-80d0-81dff956a197"

result.display_status
# => "[Partner Name] In Progress"

result.url
# => nil
```

options for `status` param are:
 - `incomplete
 - `in_progress`
 - `pending_action`
 - `completed`
 - `error`

### Additional options when creating an applicant status:

```ruby
Fountain::Papi.create_status(
  applicant_id: "231ea206-4d6e-4d7c-80d0-81dff956a197",
  status: "completed",
  account_option: "report_type_1",
  category: "string"
  link_title: "Our report results",
  status_type: "foobar",
  title: "Great Title",
  url: "http://fountain.com/our_link",
)

# => #<Fountain::Papi::Applicant::Status status="completed" applicant_id="231ea206-4d6e-4d7c-80d0-81dff956a197" account_option=nil link_title="Fountain.com" title="Our new title" url="https://www.fountain.com/our_link" category=nil color="green" display_status="[Partner Name] Completed" display_title="[Partner Name] Great Title" external_id="b87ab326-ee84-40aa-a28e-9d520cfeaca8" show_redo=false status_type=nil>
```

##### `title`

Title that will show on the applicant's profile on Fountain. Useful for labeling the applicant with quick details (i.e. "Score: 85%") that are viewed on the Applicant Table.

##### `category`

TODO:

##### `link_title`

(presumably) The title that is shown for the URL link.

##### `url`

URL that can be clicked on from the applicant's status label. Useful for viewing additional details -- i.e. a report, partner website, etc -- that might be useful to the recruiter using Fountain.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [onboardiq/fountain-papi](https://github.com/onboardiq/fountain-papi).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
