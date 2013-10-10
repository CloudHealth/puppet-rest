module PuppetRestClient::DB
  class Connection
    module FactNames
      def fact_names
        get api_path('fact-names')
      end
    end
  end
end