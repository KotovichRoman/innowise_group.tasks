# frozen_string_literal: true

require_relative 'work_with_yaml'

# Class for receiving and storage information about product
class Product
  attr_accessor :name, :image, :prices, :weights

  def initialize(html)
    @name = get_information(html)[0]
    @image = get_information(html)[1]
    @prices = get_information(html)[2]
    @weights = get_information(html)[3]
  end

  def get_information(html)
    product_name = html.xpath(WorkWithYaml::GetParametr.getting_product_name).text.strip
    product_image = html.xpath(WorkWithYaml::GetParametr.getting_product_image)
    product_weight_variation = html.xpath(WorkWithYaml::GetParametr.getting_product_weight_variation)
    price_per_weight = html.xpath(WorkWithYaml::GetParametr.getting_price_per_weight)

    weights = transform_weight(product_weight_variation)
    prices = transform_price(price_per_weight)

    [product_name, product_image, prices, weights]
  end

  def transform_weight(product_weight_variation)
    weights = []
    product_weight_variation.each_with_index do |weight, index|
      weights[index] = weight.text.to_s
    end
    weights
  end

  def transform_price(price_per_weight)
    prices = []
    price_per_weight.each_with_index do |price, index|
      prices[index] = price.text.to_s
    end
    prices
  end
end
