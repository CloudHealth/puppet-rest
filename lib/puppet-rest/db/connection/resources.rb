module PuppetRestClient::DB
  class Connection
    module Resources
      def resources(options=Mash.new)
        get(api_path("resources/#{name}")).map {|resource|
          PuppetRestClient::DB::Resource.get_or_new resource
        }
      end
    end
  end
end