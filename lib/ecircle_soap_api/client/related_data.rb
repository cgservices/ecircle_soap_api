module EcircleSoapApi
  module Client
    class RelatedData < EcircleSoapApi::Client::Base
      operations :related_data_create_record, :related_data_delete_records
      class << self
        def create(dataset, key, *attributes)
          initialize_connection
          related_data_create_record(message: { 'record' => {'datasetName' => dataset, 'key' => key, 'data' => attributes.flatten} })
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end

        def delete(dataset, key, *attributes)
          initialize_connection
          if response = related_data_delete_records(message: { 'filter' => {'datasetName' => dataset, 'key' => key, 'filter' => attributes.flatten} })
            response.to_hash[:related_data_delete_records_response][:delete_count].to_i
          end
        rescue => e
          EcircleSoapApi::ResponseException.new(e)
        end
      end
    end
  end
end