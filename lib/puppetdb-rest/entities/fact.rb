module PuppetDbRestClient
  class Fact < Base
    attr_reader :name, :value, :certname

    def initialize(attrs=Mash.new)
      super
    end
  end
end