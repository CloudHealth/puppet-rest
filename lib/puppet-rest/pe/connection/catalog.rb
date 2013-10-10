module PuppetRestClient::PE
  class Connection
    module Catalog
      def catalog(name)
        attributes = get(api_path('catalog', name))
        PuppetRestClient::PE::Catalog.get_or_new(attributes)
      end
    end
  end
end