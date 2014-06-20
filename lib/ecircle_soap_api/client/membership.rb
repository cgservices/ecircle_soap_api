module EcircleSoapApi
  module Client
    class Membership < EcircleSoapApi::Client::Base
      # Fields used for user response
      attr_accessor :user_id, :group_id, :attributes

      def initialize(data)
        @user_id = data[:user_id] || nil
        @group_id = data[:group_id] || nil
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

      operations :membership_create, :membership_delete, :membership_find_all
      class << self
        def create(user_id, group_id)
          initialize_connection
          if response = membership_create(message: { 'userId' => user_id, 'groupId' => group_id })
            self.new(response.to_hash[:membership_create_response][:membership])
          end
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def find_by_user_id(user_id)
          initialize_connection
          memberships = []
          if response = membership_find_all(message: { 'userId' => user_id })
            response_hash = response.to_hash[:membership_find_all_response][:memberships]
            response_hash.is_a?(Hash) ? memberships << self.new(response_hash) : memberships = response_hash.map{|m| self.new(m)}
          end
          memberships
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def delete(user_id, group_id)
          initialize_connection
          membership_delete(message: { 'userId' => user_id, 'groupId' => group_id })
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end
      end
    end
  end
end