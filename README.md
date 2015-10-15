Puppet Ruby REST Client
========

Interact with Puppet and PuppetDB through their REST Apis

Certificates
---------

* On Puppet Master: `sudo puppet cert --generate learning.puppetlabs.vm`
* Copy the 3 files to a remote computer:
    * /etc/puppetlabs/puppet/ssl/private_keys/learning.puppetlabs.vm.pem
    * /etc/puppetlabs/puppet/ssl/certs/learning.puppetlabs.vm.pem
    * /etc/puppetlabs/puppet/ssl/certs/ca.pem
* Test 2015.02+
    * Puppet Enterprise
        * `curl -X GET --cacert ca.pem --cert learning.puppetlabs.vm.cert.pem --key learning.puppetlabs.vm.priv-key.pem -H 'Accept: pson' 'https://learning.puppetlabs.vm:8140/puppet/v3/node/learning.puppetlabs.vm?environment=production'`
    * PuppetDB
        * `curl -X GET -H 'Accept: application/json' --cacert ca.pem --cert learning.puppetlabs.vm.cert.pem --key learning.puppetlabs.vm.priv-key.pem 'https://learning.puppetlabs.vm:8081/pdb/query/v4/facts'`
* Test Legacy
    * Puppet Enterprise
        * `curl -X GET --cacert ca.pem --cert learning.puppetlabs.vm.cert.pem --key learning.puppetlabs.vm.priv-key.pem 'https://learning.puppetlabs.vm:8140/v2/catalogs/learning.puppetlabs.vm'`
    * PuppetDB
        * `curl -X GET --cacert ca.pem --cert learning.puppetlabs.vm.cert.pem --key learning.puppetlabs.vm.priv-key.pem 'https://learning.puppetlabs.vm:8081/v2/facts'`

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

Configure Puppet Master
--------

* Edit /etc/puppetlabs/puppet/auth.conf, and change:

```
path ~ ^/catalog/([^/]+)$
method find
auth yes
allow $1
```

to

<pre>
path ~ ^/catalog/([^/]+)$
method find
auth yes
allow $1<b>, aggregator</b>
</pre>

Useful Links
---------

* http://docs.puppetlabs.com/puppetdb/latest/install_from_source.html
* http://docs.puppetlabs.com/puppetdb/latest/configure.html#certificate-whitelist
* http://docs.puppetlabs.com/puppetdb/1.5/api/query/curl.html
* http://docs.puppetlabs.com/guides/inventory_service.html

About
---------

puppet-rest was inspired by [spice](https://github.com/danryan/spice) and follows its framework.

Copyright
---------

Copyright (c) 2013 CloudHealth Tech. See LICENSE.txt for further details.

Puppet, PuppetDB and related trademarks are Copyright (c) 2005-2013 Puppet Labs Inc. Puppet and PuppetDB are released under the Apache 2.0 license.
