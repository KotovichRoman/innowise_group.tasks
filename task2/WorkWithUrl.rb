module WorkWithUrl
    def self.get_html(url)
        http = URI.open(url)
        Nokogiri::HTML(http)
    end
end