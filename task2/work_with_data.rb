# frozen_string_literal: true

require_relative 'work_with_file'

# Module for work with data
module WorkWithData
  def self.show_data(product, file_name)
    (0...product.weights.size).each do |i|
      product_name = product_name(product.name, product.weights[i])

      current_product = [product_name, product.prices[i], product.image]
      WorkWithFile.write_to_csv(file_name, current_product)

      puts "Write #{product_name} in file"
    end
  end

  def self.product_name(name, weight)
    "#{name} - #{weight}"
  end
end
