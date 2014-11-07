module EcircleSoapApi
  module Client
    class Base
      extend ::Savon::Model

      class << self
        def initialize_connection
          client  wsdl: EcircleSoapApi.config.wsdl,
                  open_timeout: EcircleSoapApi.config.open_timeout,
                  read_timeout: EcircleSoapApi.config.read_timeout,
                  basic_auth: [EcircleSoapApi.config.username, EcircleSoapApi.config.password],
                  ssl_version: :TLSv1
        end
      end
    end
  end
end