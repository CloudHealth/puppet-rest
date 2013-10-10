require 'faraday'
require 'multi_json'

module PuppetRestClient
  module PE; end
  module DB; end
end

require_relative 'puppet-rest/monkey_patches/mash'
require_relative 'puppet-rest/monkey_patches/hash'
require_relative 'puppet-rest/monkey_patches/array'
require_relative 'puppet-rest/monkey_patches/enumerable'

require_relative 'puppet-rest/version'
require_relative 'puppet-rest/error'

require_relative 'puppet-rest/identity_map'
require_relative 'puppet-rest/response/client_error'
require_relative 'puppet-rest/response/parse_json'

require_relative 'puppet-rest/pe/config'
require_relative 'puppet-rest/pe/request'
require_relative 'puppet-rest/pe/entities/base'
require_relative 'puppet-rest/pe/entities/node'
require_relative 'puppet-rest/pe/entities/catalog'
require_relative 'puppet-rest/pe/connection/node'
require_relative 'puppet-rest/pe/connection/catalog'
require_relative 'puppet-rest/pe/connection'
require_relative 'puppet-rest/pe/client'

require_relative 'puppet-rest/db/config'
require_relative 'puppet-rest/db/entities/base'
require_relative 'puppet-rest/db/entities/node'
require_relative 'puppet-rest/db/entities/fact'
require_relative 'puppet-rest/db/entities/resource'
require_relative 'puppet-rest/db/request'
require_relative 'puppet-rest/db/connection/nodes'
require_relative 'puppet-rest/db/connection/fact-names'
require_relative 'puppet-rest/db/connection/facts'
require_relative 'puppet-rest/db/connection/resources'
require_relative 'puppet-rest/db/connection'
require_relative 'puppet-rest/db/client'
