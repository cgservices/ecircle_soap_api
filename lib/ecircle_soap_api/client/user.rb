module EcircleSoapApi
  module Client
    class User < EcircleSoapApi::Client::Base
      # Fields used for user response
      attr_accessor :id, :email, :mobile_number, :attributes

      def initialize(data)
        @id = data[:id] || nil
        @email = data[:email] || nil
        @mobile_number = data[:mobile_number] || nil
        @attributes = data[:attributes] || ActiveSupport::HashWithIndifferentAccess.new
      rescue => e
        EcircleSoapApi::ResponseException.new(e)
      end

      def attributes=(data)
        data.each do |d|
          @attributes[d[:name].split('.').last.underscore] = d[:value]
        end
        @attributes.with_indifferent_access
      end

      # Fields and functions used for Api connection
      operations :user_get, :user_get_by_email, :user_get_profile, :user_create, :user_delete
      class << self
        def find(id)
          initialize_connection
          if response = user_get(message: { 'userId' => id })
            self.new(response.to_hash[:user_get_response][:user])
          end
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def find_by_email(email)
          initialize_connection
          if response = user_get_by_email(message: { 'email' => email })
            self.new(response.to_hash[:user_get_by_email_response][:user])
          end
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def find_user_with_attributes(id)
          initialize_connection
          if response = user_get(message: { 'userId' => id })
            user = self.new(response.to_hash[:user_get_response][:user])
            if user_attributes = user_get_profile(message: { 'userId' => id })
              user.attributes = user_attributes.to_hash[:user_get_profile_response][:attributes]
            end
          end
          user
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def create(email, *attributes)
          initialize_connection
          if response = user_create(message: { 'email' => email, 'attributes' => attributes.flatten })
            self.new(response.to_hash[:user_create_response][:user])
          end
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def delete(id)
          initialize_connection
          user_delete(message: { 'userId' => id })
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def find_or_create_by_email(email, *attributes)
          find_by_email(email)
        rescue EcircleSoapApi::ObjectNotFound
          create(email, attributes)
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end
      end
    end
  end
end
