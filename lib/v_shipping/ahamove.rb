require 'httparty'

module VShipping
  class Ahamove
    extend ActiveSupport::Concern
    include HTTParty
    
    def initialize(api_key, config_url)
      @api_key = api_key
      @config = load_yaml(config_url)
    end

    def retrieved_token(params)
      get(
        'register_endpoint',
        params.merge({
          api_key: api_key
        })
      )
    end

    def create_order(params)
      get('create_order_endpoint', params)
    end

    def retrieved_orders(params)
      get('orders_endpoint', params)
    end

    def retrieved_order(params)
      get('order_endpoint', params)
    end

    def retrieved_city(params)
      get('city_endpoint', params)
    end

    def retrieved_services(params)
      get('services_endpoint', params)
    end

    def retrieved_tracking_link(params)
      get('order_tracking_endpoint', params)
    end

    def notify_supplier(params)
      get('notify_supplier_endpoint', params)
    end

    def order_statuses
      [
        mapping_status('IDLE', 'confirmed'),
        mapping_status('ASSIGNING', 'assigning'),
        mapping_status('ACCEPTED', 'accepted'),
        mapping_status('IN PROCESS', 'in_progress'),
        mapping_status('COMPLETED', 'completed'),
        mapping_status('CANCELLED', 'cancelled')
      ]
    end

    private

    attr_reader :config, :api_key

    def mapping_url(name)
      base_url + config.try(:fetch, 'register_endpoint').to_s
    end

    def base_url
      config.try(:fetch, 'base_api_url').to_s
    end

    def load_yaml(url)
      YAML::load(
        ERB.new(
          File.read(config_url)
        ).result
      )
    end

    def formmated(response)
      [response.try(:status), response.try(:body)]
    end

    def get(endpoint, params)
      response = self.class.get(
        mapping_url(endpoint),
        { query: params }
      )

      formmated(response)
    end

    def mapping_status(name, value)
      {
        name: name,
        value: value
      }
    end
  end
end