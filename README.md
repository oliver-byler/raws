=======
RAWS
=======

Raws is an example of ~some~ best practices when interacting with cloud providers and their services. This tool has been tailored to work exclusively with AWS. Ideally, the providers class would be abstracted another layer down but for now this is just meant to solve a particular problem. I plan to continue work on this in my free time :)

------------
Local Installation
------------

The easiest way to install raws is via it's Gemfile that can be built within the project repo: https://github.com/oliver-byler/raws::

    $ Install Ruby for your user or system wide ( ruby and ruby-dev )
    $ Install Bundler Gem ( gem install bundler )
    $ git clone https://github.com/oliver-byler/raws
    $ gem build raws.gemspec

Once all setup, installation is done by simply executing the following::

    $ gem install raws-<version>.gem

---------------
Getting Started
---------------

Before using RAWS, you need to provide your AWS credentials.  You can do this in several ways:

* Environment variables
* Config file
* IAM Role ( if running within EC2 )

To use environment variables, do the following::

    $ export AWS_ACCESS_KEY_ID=<access_key>
    $ export AWS_SECRET_ACCESS_KEY=<secret_key>

To use the credentials file, create an JSON formatted file like this::

`{
      "demo": {
              "aws_access_key": "foo",
              "aws_secret_access_key": "bar",
              "region": "us-west-2"
      },
      "test": {
              "aws_access_key": "foo",
              "aws_secret_access_key": "bar",
              "region": "us-west-1"
      },
      "dev": {
              "aws_secret_access_key": "foo",
              "aws_access_key": "bar",
              "region": "eu-central-1"
      }
}`


and place it in `./.raws/credentials.json`.

----------------------------
Raws ec2
----------------------------

The Raws ec2 service acts as a wrapper around the AWS SDK for EC2, allowing for customization and extended functionality.

The `list` subcommand (which is the only subcommand instantiated) is used to demostrate the flexibility and customization capable with an architecture such as this.

   $ raws ec2 list < options >

The list subcommand can be called with the following options:

`--tags` - accepts a comma delimited string ( Name,Version,etc )

`--attributes` - accepts a comma delimited string ( instance_type,id,launch_time,etc )

`--region` - accepts a string of a valid AWS region ( us-west-2 )

`--credential_set` - accepts a string of a valid set of AWS credentials ( demo )

