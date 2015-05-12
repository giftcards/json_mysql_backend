## Synopsis

This is a simple hiera backend for use with puppet to pull json encoded data out of a MySQL/MariaDB database.

## Example

This backend is intended to be used primarily with parameterized classes, it has not been tested with hiera functions though they should work normally. Extended hiera option support is not installed, the lookups are intended to be simple with the backend doing the work to figure out of we have a string, a list, or an array.

## Motivation

This backend is intended to replace our current mysql_backend and add support for hashes.

## Installation

All installation happens on the puppetmaster.
json_mysql_backend.rb should be placed in the ruby path under hiera/backends. Under CentOS 6 this is typically /usr/lib/ruby/site_ruby/hiera/backend/json_mysql_backend.rb.
The example hiera.yml should be placed at /etc/puppet/hiera.yml and modified to match your environment.
The sql statements are processed in order with the first result of the first hit being returned. The backend will respond properly to --debug.
An example.sql is included which will create a schema that works with the included hiera.yml.

## Tests

On CentOS 6 you can test with the 'hiera' command by linking hiera.yml to /etc/hiera.yml.

## Contributors

Ryan Munz for Giftcards.com - May 2015
