module PuppetRestClient::DB
  class Resource < PuppetRestClient::DB::Base
    attr_reader :parameters, :sourceline, :sourcefile, :exported, :tags, :title, :type, :resource, :certname

    def initialize(attrs=Mash.new)
      super
      @attrs['parameters'] ||= Mash.new
      @attrs['tags'] ||= Mash.new
    end

  end
end