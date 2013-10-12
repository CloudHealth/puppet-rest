module PuppetRestClient::PE
  class Catalog < PuppetRestClient::PE::Base
    attr_accessor :document_type, :metadata, :tags, :name, :version, :environment, :resources, :edges, :classes

    def initialize(attrs=Mash.new)
      super
      @tags = attrs['data']['tags']
      @name = attrs['data']['name']
      @version = attrs['data']['version']
      @environment = attrs['data']['environment']
      @resources = attrs['data']['resources']
      @edges = attrs['data']['edges']
      @classes = attrs['data']['classes']
    end
  end
end