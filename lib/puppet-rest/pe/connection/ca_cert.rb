module PuppetRestClient::PE
  class Connection
    module CaCert
      def ca_cert
        self.accept = 's'
        get(api_path('certificate', 'ca'), nil, {:raw => 1}).body.strip
      end
    end
  end
end
