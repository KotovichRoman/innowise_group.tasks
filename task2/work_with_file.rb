# frozen_string_literal: true

# Module for create or write csv file
module WorkWithFile
  def self.create_csv(file_name)
    headers = %w[name price image]
    CSV.open(file_name, 'w+') do |row|
      row << headers
    end
  end

  def self.write_to_csv(file_name, product)
    CSV.open(file_name, 'a+') do |row|
      row << product
    end
  end
end
