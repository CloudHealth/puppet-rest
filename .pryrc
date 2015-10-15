require 'listen'

listener = Listen.to('./lib', only: /\.rb$/) do |modified, added, removed|
  modified.each do |m|
    puts "[modified] [code] Reloading: #{m} - #{load(m)}"
  end
  added.each do |a|
    puts "[added] [code] Loading: #{a} - #{load(a)}"
  end
  puts "[removed] #{removed}" unless removed.empty?
end

listener.start # not blocking
#listener.only /\.(rb|yml)$/

require 'rake'

load 'Rakefile'

cert_folder = File.dirname(__FILE__) + '/spec/certificates/'
$key     = OpenSSL::PKey::RSA.new(IO.binread(cert_folder + 'pk.pem'))
$cert    = OpenSSL::X509::Certificate.new(IO.binread(cert_folder + 'cert.pem'))
$ca_cert = cert_folder + 'ca.pem'

def get_pe_api
  PuppetRestClient::PE::Connection.new(
    :server_url => 'https://learning.puppetlabs.vm:8140',
    :connection_options => {
      :request => {
        :open_timeout => 30
      },
      :ssl => {
        :client_key  => $key,
        :client_cert => $cert,
        :ca_file     => $ca_cert,
        :verify      => true,
        #Additional options: vendor/jruby/1.9/gems/faraday-0.8.8/lib/faraday/adapter/net_http.rb
      }
    }
  )
end

def get_db_api
  PuppetRestClient::DB::Connection.new(
    :server_url => 'https://learning.puppetlabs.vm:8081',
    :connection_options => {
      :request => {
        :open_timeout => 30
      },
      :ssl => {
        :client_key  => $key,
        :client_cert => $cert,
        :ca_file     => $ca_cert,
        :verify      => true
      }
    }
  )
end
