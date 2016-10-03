require "forwardable"

module Alchemy
  module Tasks
    class DbUrlParser
      extend Forwardable
      def_delegators :url, :host, :port, :user, :password

      attr_reader :url

      def initialize(url)
        @url = URI.parse url
      end

      def database
        url.path.gsub(%r{\A/}, "")
      end

      def adapter
        case url.scheme.to_s
        when /postgres/i
          "postgresql"
        when /mysql/i
          "mysql"
        else
          raise ArgumentError.new "Invalid DB adapter: #{url.scheme.inspect}"
        end
      end

      def to_config
        {adapter: adapter, host: host, username: user, password: password, database: database }.
          with_indifferent_access
      end
    end
  end
end
