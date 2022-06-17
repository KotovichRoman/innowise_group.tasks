# frozen_string_literal: true

require 'csv'
require 'nokogiri'
require 'open-uri'

url = 'https://www.petsonic.com/farmacia-para-gatos/'
file_name = 'file.csv'

def parse(url, file_name)
  html = get_html(url)

  create_csv(file_name)

  all_products = html.xpath('//input[@name = "n"]/@value').text.to_i
  products_per_page = html.xpath('//a[@class = "product-name"]').size
  all_pages = (all_products / products_per_page.to_f).ceil

  (1..all_pages).each do |page_num|
    html = get_html(get_page_url(url, page_num))

    parse_page(html, file_name, products_per_page, all_products)

    all_products -= products_per_page
  end
end

def get_html(url)
  http = URI.open(url)
  Nokogiri::HTML(http)
end

def get_page_url(url, page_num)
  "#{url}?p=#{page_num}"
end

def parse_page(html, file_name, products_per_page, all_products)
  if all_products >= 25
    (0...products_per_page).each do |product_num|
      parse_product(html, file_name, product_num)
    end
  else
    (0...all_products).each do |product_num|
      parse_product(html, file_name, product_num)
    end
  end
end

def parse_product(html, file_name, product_num)
  page_url = html.xpath('//div[@class = "product-desc display_sd"]//@href')[product_num]

  page_html = get_html(page_url)

  product = get_info(page_html)

  show_data(product, file_name)
end

def get_info(html)
  product_name = html.xpath('//h1[@class = "product_main_name"]').text.strip
  product_img = html.xpath('//img[@id = "bigpic"]/@src')
  product_weight_variation = html.xpath('//span[@class = "radio_label"]')
  price_per_weight = html.xpath('//span[@class = "price_comb"]')

  weights = transform_weight(product_weight_variation)
  prices = transform_price(price_per_weight)

  [product_name, product_img, weights, prices]
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

def show_data(product, file_name)
  (0...product[2].size).each do |i|
    product_weight = product[2][i]
    product_price = product[3][i]
    product_image = product[1]
    product_name = product_name(product[0], product_weight)

    write_to_csv(file_name, [product_name, product_price, product_image])

    puts "Write #{product_name} in file"
  end
end

def product_name(name, weight)
  "#{name} - #{weight}"
end

def create_csv(file_name)
  headers = %w[name price image]
  CSV.open(file_name, 'w+') do |row|
    row << headers
  end
end

def write_to_csv(file_name, product)
  CSV.open(file_name, 'a+') do |row|
    row << product
  end
end

parse(url, file_name)
