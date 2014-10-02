Addons
======

Much like Heroku, Vektra contains addons. These are prebuilt services that you can turn on and use easily.

The Alpha release comes with 3 addons:
* postgres
* redis
* memcache

The addons must be enabled using `vektra addons:enable <name>`, and they can then be bound to an app using `vektra addons:bind <name>`.

Addons advertise the information about themselves via config variables which are seen by our app as environment variables.

## Postgres

This runs a single postgres server that all apps bound to it use. Each app gets a different database automatically when bound.

It exports 2 config variables:

* __DATABASE\_URL__: A URI containing the username, password, host, and database name to use. This follows the traditional format, so your postgres driver should be able to use it directly.
* __POSTGRES\_URL__: The same value as DATABASE\_URL

## Redis

This runs a single redis server that all apps bounds to it use. Each app gets a different redis database to use.

It exports 1 config variable:

* __REDISURL__: This is in the format tcp://host:port/db. Some redis libraries support this format, some don't but you should be able to extract the data easily regardless.

## Memcache

This runs a single memcache server that all apps bound to it use. Each app gets a different namespace to use.

It exports 2 config variables:

* __MEMCACHE\_HOSTS__: A string with the host:port of the memcache server. (It's called hosts so future upgrades to many servers is seamless).
* __MEMCACHE\_NAMESPACE__: The memcache namespace to use for all keys. This keeps each app safe from accidentally using other apps keys.


