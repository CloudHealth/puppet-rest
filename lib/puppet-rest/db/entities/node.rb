module PuppetRestClient::DB
  class Node < PuppetRestClient::DB::Base
    attr_reader :name, :deactivated, :catalog_timestamp, :facts_timestamp, :report_timestamp
    attr_accessor :connection

    def initialize(attrs = Mash.new)
      attrs['name'] = attrs['certname'] if attrs['name'].nil? && !attrs['certname'].nil?
      super attrs
      @connection = nil
    end

    def facts
      return [] if @connection.nil?
      @connection.node_facts self.name
    end

    def resources
      return [] if @connection.nil?
      @connection.node_resources self.name
    end
  end
end