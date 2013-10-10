module PuppetRestClient::PE
  class Node < PuppetRestClient::PE::Base
    attr_reader :name

    def initialize(attrs=Mash.new)
      super
    end
  end
end