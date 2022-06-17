# frozen_string_literal: true

require 'yaml'

# Module for getting information from yaml file
module WorkWithYaml
  # Class for getting all parametrs from yaml file
  class Parametrs
    @parametrs = YAML.safe_load(File.open('parametrs.yaml'))

    class << self
      attr_accessor :parametrs
    end
  end

  # Module for getting a specific parametr
  module GetParametr
    def self.getting_url
      Parametrs.parametrs['url']
    end

    def self.getting_file_name
      Parametrs.parametrs['file_name']
    end

    def self.getting_all_products
      Parametrs.parametrs['all_products']
    end

    def self.getting_products_per_page
      Parametrs.parametrs['products_per_page']
    end

    def self.getting_page_url
      Parametrs.parametrs['page_url']
    end

    def self.getting_product_name
      Parametrs.parametrs['product_name']
    end

    def self.getting_product_image
      Parametrs.parametrs['product_image']
    end

    def self.getting_product_weight_variation
      Parametrs.parametrs['product_weight_variation']
    end

    def self.getting_price_per_weight
      Parametrs.parametrs['price_per_weight']
    end
  end
end
