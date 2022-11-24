require 'net/http'
require 'net/https'

class HomeController < ApplicationController
  def index
    make_abstract_request()
  end


  def make_abstract_request
      url = 'https://ipgeolocation.abstractapi.com/v1/?api_key=' + ENV['ABSTRACT_API_KEY']
      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request =  Net::HTTP::Get.new(uri)

      response = http.request(request)
      puts "Status code: #{ response.code }"
      puts "Response body: #{ response.body }"
  rescue StandardError => error
      puts "Error (#{ error.message })"
  end
end
