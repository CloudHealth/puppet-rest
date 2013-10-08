module PuppetDbRestClient
  class Connection
    module Resources
      def resources(options=Mash.new)
        get(api_path("resources/#{name}")).map {|resource|
          PuppetDbRestClient::Resource.get_or_new resource
        }
      end
    end
  end
end