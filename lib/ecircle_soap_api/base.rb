module EcircleSoapApi
  class Base
    extend ::Savon::Model
    
    client wsdl: EcircleSoapApi.wsdl
    global :open_timeout, EcircleSoapApi.open_timeout
    global :read_timeout, EcircleSoapApi.read_timeout
    global :basic_auth, EcircleSoapApi.username, EcircleSoapApi.password
  end
end