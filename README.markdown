#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with stagecoach](#setup)
    * [What stagecoach affects](#what-stagecoach-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with stagecoach](#beginning-with-stagecoach)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs [StageCoach](https://github.com/punkave/stagecoach), a simple framework for deploying node.js web applications to your servers that can run multiple apps on the same server, keep them running with forever, and restart them gracefully at reboot time.

## Module Description

The StageCoach module will download check out the StageCoach repository to your system and ensure that it is properly configured for use. If requested it will manage a user account for managing your application deployments, and it will add itself to the system's default path so that remote deployment becomes a breeze. The module has no service to manage itself, and does not handle the actual deployments itself, but allows you to easily add a system to your list of deployable servers.

StageCoach expects that Node.JS, nvm, and forever will be available on your system in order to operate, so you will need to ensure that those are present, but this module will function regardless of whether StageCoach's dependencies are in place. (Making it so that no ordering is necessary with other modules that install node/forever)

## Setup

### Requirements/Dependencies

This module depends on puppetlabs/vcsrepo and the git provider. Thus you must have git installed on the system for this module to work properly.

### What stagecoach affects

* By default, /opt/stagecoach will be a checked out git repository from the main github URL for the StageCoach project
* /opt/stagecoach/settings will be configured properly for deployments to work
* /opt/stagecoach/apps will be created as the root for deployments
* Optionally (on by default) the 'stagecoach' user will be created to handle file ownership and execution of the apps
* Optionally (on by default) the binaries will be added to the system path (using the /etc/profiles.d/*.sh model)

## Usage

Simply include the module as usual, using Hiera to adjust any parameters

```
include stagecoach
```

Or specify parameters in resource format to define them explicitly

## Testing

Unit tests:

```
bundle exec rake test
```

Acceptance tests:

```
bundle exec rake acceptance
bundle exec rake acceptance[centos6,onpass,yes]
```
Parameters to acceptance are: OS to test (see rakefile), BEAKER_destroy value, BEAKER_provision value

For initial test, you'd want [OS,no,yes]

For subsequent tests, you'd want [OS,no,no]

For normal cases, you can just pass [OS] and it'll only tear it down if it doesn't pass

## Reference

* ::stagecoach - Main entrypoint to the class
* ::stagecoach::params - Default parameter logic contained here
* ::stagecoach::install - Handles checkout of the repository and user creation
* ::stagecoach::configure - Handles defining the settings file and 'apps' folder

## Limitations

This module will only function on Linux (possibly Unix) based OS'es, and on Darwin (Mac) it will not automatically add
the binaries to the system's path.

## Development

Read the contributing file, but generally:

* Fork
* Write good code
* Write good tests for your code
* Get your tests to pass (both unit and acceptance)
* Commit/push
* Put in a pull request
* Recieve gratitude for your contribution :)