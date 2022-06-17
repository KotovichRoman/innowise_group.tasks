require_relative "Product"
require_relative "WorkWithUrl"
require_relative "WorkWithFile"
require_relative "WorkWithData"
require_relative "WorkWithYaml"

module Parse
    def self.parse (url, file_name)
        html = WorkWithUrl.get_html(url)
    
        WorkWithFile.create_csv(file_name)
    
        all_products = html.xpath(WorkWithYaml::GetParametr.get_all_products).text.to_i
        products_per_page = html.xpath(WorkWithYaml::GetParametr.get_products_per_page).size;
        all_pages = (all_products / products_per_page.to_f).ceil

        (1..all_pages).each do |page_num|
            html = WorkWithUrl.get_html(url + "?p=" + "#{page_num}");
            Parse.parse_page(html, file_name, products_per_page, all_products)

            all_products -= products_per_page
        end
    end

    def self.parse_page(html, file_name, products_per_page, all_products)
        threads = Array.new

        if all_products >= 25
            (0...products_per_page).each do |product_num|
                threads << Thread.new {parse_product(html, file_name, product_num)}
            end
        else
            (0...all_products).each do |product_num|
                threads << Thread.new {parse_product(html, file_name, product_num)}
            end
        end

        threads.each(&:join)
    end

    def self.parse_product(html, file_name, product_num)
        page_url = html.xpath(WorkWithYaml::GetParametr.get_page_url)[product_num]
        page_html = WorkWithUrl.get_html(page_url)

        product = Product.new(page_html)
    
        WorkWithData.show_data(product, file_name)
    end
end