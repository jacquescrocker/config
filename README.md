# Config

## Summary

Config helps you easily manage environment specific settings in an easy and usable manner

## Features

* simple YAML config files
* config files support ERB
* config files support inheritance
* access config information via convenient object member notation

## Compatibility

* Rails 3.0
* Padrino
* Sinatra

For older versions of Rails and other Ruby apps, use [AppConfig](http://github.com/fredwu/app_config).

## Installing on Rails 3

Add this to your `Gemfile`:

    gem "config"

## Installing on Padrino

Add this to your `Gemfile`:

    gem "config"

in your app.rb, you'll also want to register Config

    register Config


## Installing on Sinatra

Add this to your `Gemfile`:

    gem "config"

in your app, you'll need to register RailsConfig. You'll also need to give it a root so it can find the config files.

    set :root, File.dirname(__FILE__)
    register Config

It's also possible to initialize it manually within your configure block if you want to just give it some yml paths to load from.

    Config.sources("/path/to/yaml1", "/path/to/yaml2", ...)


## Customizing Config

    config/config.yml
    config/environments/development.yml
    config/environments/production.yml
    config/environments/test.yml

## Accessing the Config object

After installing this plugin, the `Config` object will be available globally. Entries are accessed via object member notation:

    Config.my_config_entry

Nested entries are supported:

    Config.my_section.some_entry

If you have set a different constant name for the object in the initializer file, use that instead.

## Common config file

Config entries are compiled from:

    config/config.yml
    config/environments/#{environment}.yml
    config/settings.yml
    config/settings/#{environment}.yml

Settings defined in files that are lower in the list override settings higher.

### Reloading settings

You can reload the Config object at any time by running `Config.reload!`.

### Environment specific config files

You can have environment specific config files. Environment specific config entries take precedence over common config entries.

Example development environment config file:

    #{Config.root}/config/environments/development.yml

Example production environment config file:

    #{Config.root}/config/environments/production.yml

### Adding sources at Runtime

You can add new YAML config files at runtime. Just use:

    Config.add_source!("/path/to/source.yml")
    Config.reload!

This will use the given source.yml file and use its settings to overwrite any previous ones.

One thing I like to do for my Rails projects is provide a local.yml config file that is .gitignored (so its independent per developer). Then I create a new initializer in `config/initializers/add_local_config.rb` with the contents

    Config.add_source!("#{Config.root}/config/environments/local.yml")
    Config.reload!

## Embedded Ruby (ERB)

Embedded Ruby is allowed in the configuration files. See examples below.

## Accessing Configuration Settings

Consider the two following config files.

 #{Config.root}/config/config.yml:

    size: 1
    server: google.com

 #{Config.root}/config/environments/development.yml:

    size: 2
    computed: <%= 1 + 2 + 3 %>
    section:
      size: 3
      servers: [ {name: yahoo.com}, {name: amazon.com} ]

Notice that the environment specific config entries overwrite the common entries.

    Config.size   # => 2
    Config.server # => google.com

Notice the embedded Ruby.

    Config.computed # => 6

Notice that object member notation is maintained even in nested entries.

    Config.section.size # => 3

Notice array notation and object member notation is maintained.

    Config.section.servers[0].name # => yahoo.com
    Config.section.servers[1].name # => amazon.com

## Authors

* [Jacques Crocker](http://github.com/railsjedi)
* [Fred Wu](http://github.com/fredwu)
* Inherited from [AppConfig](http://github.com/cjbottaro/app_config) by [Christopher J. Bottaro](http://github.com/cjbottaro)