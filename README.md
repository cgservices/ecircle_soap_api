# e-Circle Api
A Client for e-Circle Api communication

## Installation
### In Gemfile
    gem 'ecircle_soap_api', :git => "git://github.com/cgservices/dcgw_api.git"

### Create config file
In your config/initializers create ecircle_soap_api.rb
    EcircleSoapApi.configure do |config|
      config.wsdl = URL_TO_YOUR_SOAP_API
      config.open_timeout = 30
      config.read_timeout = 30
      config.username = YOUR_USERNAME_
      config.password = YOUR_PASSWORD_
    end

## Usage
    See spec/user for usage
