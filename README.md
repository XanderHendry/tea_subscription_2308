<a name="readme-top"></a>
# Tea Subscription
### Take Home Challenge 2308
<!-- TABLE OF CONTENTS -->
## Table of Contents
  1. [About The Project](#about-the-project)
      - [Built With](#built-with)
      - [Gems](#gems)
  2. [Getting Started](#getting-started)
      - [Installation](#installation)
      - [Testing](#testing)
  3. [Database](#database)
  4. [Endpoints](#endpoints)
      - [Subscribe](#subscribe)
      - [Customer Subscriptions](#customer-subscriptions)
      - [Cancel Subscription](#cancel-subscription)
  5. [Contributors](#contributors)



<!-- ABOUT THE PROJECT -->
## About The Project
### Built With
* [![Ruby on Rails][Rails-shield]][Rails-url]
* [![PostgreSQL][PostgreSQL-shield]][PostgreSQL-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Gems

#### Deployment
* [![faraday][gem-faraday]][gem-faraday-url]
* [![jsonapi-serializer][gem-jsonapi-serializer]][gem-jsonapi-serializer-url]

#### Testing
* [![debug][gem-debug]][gem-debug-url]
* [![rspec-rails][gem-rspec-rails]][gem-rspec-rails-url]
* [![simplecov][gem-simplecov]][gem-simplecov-url]
* [![factory_bot_rails][gem-factory_bot_rails]][gem-factory_bot_rails-url]
* [![faker][gem-faker]][gem-faker-url]
* [![pry][gem-pry]][gem-pry-url]
* [![shoulda-matchers][gem-shoulda-matchers]][gem-shoulda-matchers-url]
* [![capybara][gem-capybara]][gem-capybara-url]
* [![webmock][gem-webmock]][gem-webmock-url]
* [![vcr][gem-vcr]][gem-vcr-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Database 
```
ActiveRecord::Schema[7.1].define(version: 2024_01_27_165904) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.integer "status", default: 0, null: false
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "temperature"
    t.string "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "teas"
end
```

### Installation


1. Clone the repo
   ```sh
   git clone https://git@github.com:XanderHendry/tea_subscription_2308.git
   ```
2. Gem Bundle
   ```sh
    bundle
   ```
3. Rake
   ```sh
    rails db:{drop,create,migrate,seed}
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Testing
1. Run Test Suite
  ```sh
   bundle exec rspec -fd
  ``` 
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ENDPOINTS -->
## Endpoints

### [Endpoints](#endpoints)

### [Subscribe](#subscribe)

##### Example Successful Enrollment
```
post /api/v0/subscriptions
```
##### Query Parameters
- In Body of JSON
```json
{
  "customer_id": 55,
  "tea_id": 24,
  "frequency": "Monthly"
}
```
##### Example Response
```json
{
    "data": {
        "id": "7",
        "type": "subscriptions",
        "attributes": {
            "title": "Jungjak",
            "price": 17.43,
            "status": "Active",
            "frequency": "Monthly",
            "tea": {
                "title": "Jungjak",
                "description": "When evening in the Shire was grey",
                "temperature": 604,
                "brew_time": "6 Minutes"
            },
            "customer": {
                "first_name": "Willard",
                "last_name": "Morissette",
                "email": "talisha_larson@bayer-jerde.test",
                "address": "Suite 964 3869 Schimmel Curve, South Sueannland, OK 43202"
            }
        }
    }
}
```
#### Error Handling
##### `"title": "Couldn't find Customer without an ID"` NO/INVALID CUSTOMER ID
##### `"title": "Couldn't find Tea without an ID"` NO/INVALID TEA ID
##### `"title": "param is missing or the value is empty: frequency"` NO/INVALID ORDER FREQUENCY PROVIDED

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### [Customer Subscriptions](#customer-subscriptions)

##### Example Customer Subscriptions Index
```
GET /api/v0/customers
```
##### Query Parameters
- In Body of JSON
```json
{
  "customer_id": 1
}
```
##### Example Response
```json
"data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": "Willard",
            "last_name": "Morissette",
            "email": "talisha_larson@bayer-jerde.test",
            "address": "Suite 964 3869 Schimmel Curve, South Sueannland, OK 43202",
            "subscriptions": [
                {
                    "id": "1",
                    "title": "Alishan",
                    "price": 45.61,
                    "status": "Active",
                    "frequency": "Weekly"
                },
                {
                    "id": "2",
                    "title": "Essiac",
                    "price": 90.99,
                    "status": "Cancelled",
                    "frequency": "Monthly"
                },
                {
                    "id": "7",
                    "title": "Jungjak",
                    "price": 17.43,
                    "status": "Active",
                    "frequency": "Monthly"
                }
            ]
        }
    }
}
```
#### Error Handling
##### `"title": "Couldn't find Customer without an ID"` NO/INVALID CUSTOMER ID

### [Cancel Subscription](#cancel-subscription)

##### Example Query
```
http://[::1]:3000/api/v0/subscriptions/1
```
##### Example Response
```json
{
    "data": {
        "id": "1",
        "type": "subscriptions",
        "attributes": {
            "title": "Alishan",
            "price": 45.61,
            "status": "Cancelled",
            "frequency": "Weekly",
            "tea": {
                "title": "Alishan",
                "description": "Out of doubt, out of dark, to the day’s rising",
                "temperature": 119,
                "brew_time": "4 Minutes"
            },
            "customer": {
                "first_name": "Willard",
                "last_name": "Morissette",
                "email": "talisha_larson@bayer-jerde.test",
                "address": "Suite 964 3869 Schimmel Curve, South Sueannland, OK 43202"
            }
        }
    }
}
```
#### Error Handling
##### `"title": "Couldn't find Subscription with 'id=x'` NO/INVALID SUBSCRIPTION ID PROVIDED


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributors

Xander Hendry 

[![LinkedIn][linkedin-shield]][linkedin-url-zh]
[![GitHub][github-shield-zh]][github-url-zh]

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

<!-- BUILD WITH SHIELDS -->
[Rails-shield]: https://img.shields.io/badge/Ruby%20on%20Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/

[PostgreSQL-shield]: https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white
[PostgreSQL-url]: https://www.postgresql.org/

<!-- GEM SHIELDS -->
[gem-debug]: https://img.shields.io/badge/debug-1.9.1-brightgreen?style=flat-square
[gem-debug-url]: https://rubygems.org/gems/debug

[gem-rspec-rails]: https://img.shields.io/badge/rspec--rails-6.1.0-green?style=flat-square
[gem-rspec-rails-url]: https://github.com/rspec/rspec-rails

[gem-simplecov]: https://img.shields.io/badge/simplecov-0.22.0-yellow?style=flat-square
[gem-simplecov-url]: https://github.com/simplecov-ruby/simplecov

[gem-factory_bot_rails]: https://img.shields.io/badge/factory_bot_rails-6.4.0-success?style=flat-square
[gem-factory_bot_rails-url]: https://github.com/thoughtbot/factory_bot_rails

[gem-faker]: https://img.shields.io/badge/faker-3.2.2-red?style=flat-square
[gem-faker-url]: https://github.com/faker-ruby/faker

[gem-pry]: https://img.shields.io/badge/pry-0.14.2-yellow?style=flat-square
[gem-pry-url]: https://github.com/pry/pry

[gem-shoulda-matchers]: https://img.shields.io/badge/shoulda--matchers-6.0.0-orange?style=flat-square
[gem-shoulda-matchers-url]: https://github.com/thoughtbot/shoulda-matchers

[gem-faraday]: https://img.shields.io/badge/faraday-2.8.1-yellowgreen?style=flat-square
[gem-faraday-url]: https://github.com/lostisland/faraday

[gem-figaro]: https://img.shields.io/badge/figaro-1.2.0-critical?style=flat-square
[gem-figaro-url]: https://github.com/laserlemon/figaro

[gem-jsonapi-serializer]: https://img.shields.io/badge/jsonapi--serializer-2.2.0-blue?style=flat-square
[gem-jsonapi-serializer-url]: https://github.com/jsonapi-serializer/jsonapi-serializer

[gem-capybara]: https://img.shields.io/badge/capybara-3.39.2-brightgreen?style=flat-square
[gem-capybara-url]: https://github.com/teamcapybara/capybara

[gem-webmock]: https://img.shields.io/badge/webmock-3.19.1-yellowgreen?style=flat-square
[gem-webmock-url]: https://github.com/bblimke/webmock

[gem-vcr]: https://img.shields.io/badge/vcr-6.2.0-orange?style=flat-square
[gem-vcr-url]: https://github.com/vcr/vcr


<!-- CONTRIBUTOR SHIELDS AND URLS -->
[github-shield-zh]: https://img.shields.io/badge/GitHub-XanderHendry-success?style=for-the-badge&logo=github
[github-url-zh]: https://github.com/xanderhendry

<!-- LINKEDIN SHIELDS AND URLS-->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url-zh]: https://www.linkedin.com/in/xander-hendry-70b804289
