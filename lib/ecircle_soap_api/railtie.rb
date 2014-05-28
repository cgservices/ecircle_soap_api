class EcircleSoapApi::Railtie < ::Rails::Railtie
  config.ecircle_soap_api = ActiveSupport::OrderedOptions.new

  initializer "ecircle_soap_api.configure" do |app|
    ::EcircleSoapApi.configure do |config|
      config.wsdl = app.config.ecircle_soap_api[:wsdl]
      config.open_timeout = app.config.ecircle_soap_api[:open_timeout]
      config.read_timeout = app.config.ecircle_soap_api[:read_timeout]
      config.username = app.config.ecircle_soap_api[:username]
      config.password = app.config.ecircle_soap_api[:password]
    end
  end
end