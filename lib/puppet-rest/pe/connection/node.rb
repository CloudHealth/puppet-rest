module PuppetRestClient::PE
  class Connection
    module Node
      def node(name)
        attributes = get(api_path('node', name))
        PuppetRestClient::PE::Node.get_or_new(attributes)
      end
    end
  end
end