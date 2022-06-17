require "yaml"

module WorkWithYaml
    class Parametrs
        @@parametrs = YAML.safe_load(File.open("parametrs.yaml"))

        def self.parametrs
            @@parametrs
        end
    end

    module GetParametr
        def self.get_url
            return Parametrs.parametrs["url"];
        end

        def self.get_file_name
            return Parametrs.parametrs["file_name"]
        end

        def self.get_all_products
            return Parametrs.parametrs["all_products"]
        end

        def self.get_products_per_page
            return Parametrs.parametrs["products_per_page"]
        end

        def self.get_page_url
            return Parametrs.parametrs["page_url"]
        end

        def self.get_product_name
            return Parametrs.parametrs["product_name"]
        end

        def self.get_product_image
            return Parametrs.parametrs["product_image"]
        end

        def self.get_product_weight_variation
            return Parametrs.parametrs["product_weight_variation"]
        end

        def self.get_price_per_weight
            return Parametrs.parametrs["price_per_weight"]
        end
    end
end