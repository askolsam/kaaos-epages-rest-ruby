require 'spec_helper'

describe 'Epages::REST::Orders' do
  let(:token) { ENV['shop_token'] || IO.read('spec/fixtures/token.txt') }
  let(:shop_name) { ENV['shop_name'] || IO.read('spec/fixtures/shop_name.txt') }
  let(:shop_host) { ENV['shop_host'] || IO.read('spec/fixtures/shop_host.txt') }
  let(:shop) { Epages::REST::Shop.new(shop_host, shop_name, token) }
  let(:fail_shop) { Epages::REST::Shop.new(shop_host, 'non_existing_shop') }

  let(:json_orders) { JSON.parse(File.read('spec/fixtures/orders.json'))['items'] }
  let(:orders) { json_orders.collect { |p| Epages::Order.new(Epages::Utils.symbolize_keys!(p)) } }
  let(:order) { orders.last }

  let(:options) { {viewed_on: true, created_before: Date.today} }

  describe 'GET#orders' do
    let(:shop_orders) { shop.orders }
    let(:shop_orders_options) { shop.orders(options) }

    it 'get an array of orders if the shop exists' do
      shop_orders.each { |o| expect(o).to be_a Epages::Order }
    end

    it 'get the proper orders when options are passed' do
      shop_orders_options.each do |o|
        expect(o.viewed_on).to_not eq nil
        expect(o.creation_date).to be < Date.today
      end
    end
  end

  describe 'GET#order' do
    let(:shop_order) { shop.order(order) }
    it 'do the request passing product_id as String' do
      expect(shop_order.order_id).to eq order.order_id
    end
  end

  describe 'PATCH#update_customer' do
    let(:shop_order) { shop.order(order) }
    let(:note) { 'internal note' }
    it 'assigns attributes' do
      updated_order = shop.update_order(shop_order, 'internal_note' => note)
      expect(updated_order.internal_note).to eq note
    end

    it 'removes attributes' do
      updated_order = shop.update_order(shop_order, remove: 'internal_note')
      expect(updated_order.internal_note).to eq nil
    end
  end
end
