Puppet Ruby REST Client
========

Interact with Puppet and PuppetDB through their REST Apis

Configure PuppetDB
--------

* Change PuppetDB Listen Directive
    * If puppet is not managing puppetdb:
        * Reference: http://docs.puppetlabs.com/puppetdb/1.3/configure.html#host
        * Edit /etc/puppetlabs/puppetdb/conf.d/jetty.ini to listen on 0.0.0.0
        * /etc/init.d/pe-puppetdb restart
    * Otherwise, change through the puppet portal
        * Add `listen_host` to `pe_puppetdb` class with value of `0.0.0.0`
        * Force a puppet run to change in /etc/puppetlabs/puppetdb/conf.d/jetty.ini
* If PuppetDB is using its own certs, and not the Puppet Master's:
    * sudo /opt/puppet/sbin/puppetdb-ssl-setup -f
    * sudo /etc/init.d/pe-puppetdb restart
    * (Wait a few min for it to actually restart)
* Make sure your ec2 security groups have 8081 open between your internal instances 


About
---------

puppet-rest was inspired by [spice](https://github.com/danryan/spice) and follows its framework.

Copyright
---------

Copyright (c) 2013 CloudHealth Tech. See LICENSE.txt for further details.

Puppet, PuppetDB and related trademarks are Copyright (c) 2005-2013 Puppet Labs Inc. Puppet and PuppetDB are released under the Apache 2.0 license.
