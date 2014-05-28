require 'socket'
require 'json'
require 'savon'
require 'i18n'
require 'rack'

module EcircleSoapApi
  class Config
    attr_accessor :wsdl, :open_timeout, :read_timeout, :username, :password
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end
end

require 'ecircle_soap_api/engine'
require 'ecircle_soap_api/railtie' if defined? ::Rails::Railtie

require 'ecircle_soap_api/command_exception'
require 'ecircle_soap_api/connection_exception'
require 'ecircle_soap_api/api_response_exception'
require 'ecircle_soap_api/client'