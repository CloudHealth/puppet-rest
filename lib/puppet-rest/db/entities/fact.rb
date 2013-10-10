module PuppetRestClient::DB
  class Fact < PuppetRestClient::DB::Base
    attr_reader :name, :value, :certname

    def initialize(attrs=Mash.new)
      super
    end
  end
end