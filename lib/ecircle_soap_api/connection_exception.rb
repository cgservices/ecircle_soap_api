module EcircleSoapApi
  class ApiResponseException < RuntimeError
    attr_accessor :text
    def initialize(e)
      @text = e.to_s
    end
  end
end