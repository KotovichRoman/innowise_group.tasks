# frozen_string_literal: true

# Module for get html from website
module WorkWithUrl
  def self.get_html(url)
    http = URI.open(url)
    Nokogiri::HTML(http)
  end
end
