require "v_shipping/configuration"

module VShipping
  class Setup
    include VShipping::Configuration

    class << self
      def ahamove
        puts "Ahamove status: #{status}"

        return unless ahamove_api_key

        VShipping::Ahamove.new(ahamove_api_key, ahamove_config_path)
      end

      private

      def status
        ahamove_api_key.nil? ? 'is missing api key' : 'available'
      end
    end
  end
end


require 'v_shipping/ahamove'