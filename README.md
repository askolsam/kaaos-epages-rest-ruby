# The ePages REST Ruby Gem

A Ruby interface to the ePages REST API.

## Installation

```
gem install epages-rest
```

You can require it in the Ruby Interpreter using:
```
require 'epages-rest'
```
or add it to your Rails application adding the gem to your Gemfile.

## Usage

This gem is used to connect any Ruby application with any [ePages](http://www.epages.com/en/) shop.
You can get any public information of any shop indicating only the name of the shop.
But for security reasons, to modify content from your shop, you need the token you will get in the developer environment of your test shop.

# Usage examples

The first thing is create your REST shop.
`shop = Epages::REST::Shop.new(shop_host, shop_name)` or `shop = Epages::REST::Shop.new(shop_host, shop_name, token)`

Additionally, you can indicate if your shop uses https or not (default true) `shop = Epages::REST::Shop.new(shop_host, shop_name, token, https: false)`

Once this is done, you can use the API calls.

#### [Get products](https://developer.epages.com/apps/api-reference/get-shops-shopid-products.html)
`products = shop.products`
`sorted_products = shop.products(sort: name)`

#### [Get Categories](https://developer.epages.com/apps/api-reference/get-shops-shopid-categories.html)
`categories = shop.categories`

### Full collection of examples [here](https://github.com/ePages-de/epages-rest-ruby/tree/master/examples)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ePages-de/epages-rest-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
