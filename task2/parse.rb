# frozen_string_literal: true

require_relative 'product'
require_relative 'work_with_url'
require_relative 'work_with_file'
require_relative 'work_with_data'
require_relative 'work_with_yaml'

# Module for parsing all pages
module Parse
  def self.parse(url, file_name)
    html = WorkWithUrl.get_html(url)

    WorkWithFile.create_csv(file_name)

    all_products = html.xpath(WorkWithYaml::GetParametr.getting_all_products).text.to_i
    products_per_page = html.xpath(WorkWithYaml::GetParametr.getting_products_per_page).size
    all_pages = (all_products / products_per_page.to_f).ceil

    (1..all_pages).each do |page_num|
      html = WorkWithUrl.get_html("#{url}?p=#{page_num}")
      Parse.parse_page(html, file_name, products_per_page, all_products)

      all_products -= products_per_page
    end
  end

  def self.parse_page(html, file_name, products_per_page, all_products)
    threads = []

    if all_products >= 25
      put_threads(threads, products_per_page, html, file_name)
    else
      put_threads(threads, all_products, html, file_name)
    end

    threads.each(&:join)
  end

  def self.put_threads(threads, products, html, file_name)
    (0...products).each do |product_num|
      threads << Thread.new { parse_product(html, file_name, product_num) }
    end
  end

  def self.parse_product(html, file_name, product_num)
    page_url = html.xpath(WorkWithYaml::GetParametr.getting_page_url)[product_num]
    page_html = WorkWithUrl.get_html(page_url)

    product = Product.new(page_html)

    WorkWithData.show_data(product, file_name)
  end
end
