# Chagelog

## Alpha 2

Release Date: **Oct 29th, 2014**

### New Features

* Ability to boot an instance on EC2: `vektra boot:aws`
* Ability to boot an instance on DigitalOcean: `vektra boot:digitalocean`
* Ability to convert an Ubuntu 14.04 instance into a vektra node: `vektra apply:to`
* Addon to send logs to logstash: `vektra addons:enable logstash`
* Addon to send logs to logentries.com: `vektra addons:enable logentries`
* Addon to send logs to papertrail.com: `vektra addons:enable papertrail`
* Volts can specify routing to a path instead of a subdomain

See [ADDONS.md](https://github.com/vektra/docs/blob/master/ADDONS.md) for info about using the new addons!


### Notable Bugfixes

* `vektra logs` won't go empty occasionally
* Volts restart on machine start
