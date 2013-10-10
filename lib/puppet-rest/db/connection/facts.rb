module PuppetRestClient::DB
  class Connection
    module Facts
      def facts(name)
        get(api_path("facts/#{name}")).map {|fact|
          PuppetRestClient::DB::Fact.get_or_new fact
        }
      end
    end
  end
end