module EcircleSoapApi
  class CommandException < RuntimeError
    attr_accessor :text

    def initialize(message)
      @text = message
    end
  end

  class ObjectNotFound < CommandException; end
  class ObjectAlreadyExists < CommandException; end
  class InvalidParameter < CommandException; end
  class UnmappedResponse < CommandException; end
end

