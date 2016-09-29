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

      def to_config
        {host: host, username: user, password: password, database: database }
      end
    end
  end
end
