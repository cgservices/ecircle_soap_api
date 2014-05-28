module EcircleSoapApi
  class ResponseException < RuntimeError
    def initialize(e)
      raise ApiResponseException.new e unless e.is_a?(Savon::SOAPFault)

      error_code = e.to_hash[:fault][:detail].keys.first.to_sym
      case error_code
        when :no_such_object_exception
          raise ObjectNotFound.new error_code
        when :object_already_exists_exception
          raise ObjectAlreadyExists.new error_code
        when :invalid_parameter_exception
          raise InvalidParameter.new error_code
        else
          raise UnmappedResponse.new error_code
      end
    end
  end
end