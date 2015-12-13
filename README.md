# splunk

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with splunk](#setup)
    * [What splunk affects](#what-splunk-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with splunk](#beginning-with-splunk)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Splunk tries to install and configure a Splunk environment by installing and configuring Splunk Enterprise and Splunk Universal Forwarder instances.

The module was originally written with a dual purpose: to help manage a fairly large (2TB/day) instance and to help quickly bring up virtual instances for testing Splunk apps, basically configuration bundles for use within a Splunk environment.

## Setup

### What splunk affects

Splunk will install in a default default location (`/opt/splunk`, `/opt/splunkforwarder`, or `C:\Program Files\Splunk`)

(TODO: implemented but not commited)You can then configure Splunk assigning it roles such as a search head, indexer, deployment client, deployment server, deployer.  The Splunk puppet module can also configure index clustering.

Typically the module will leave `$SPLUNK_HOME/etc/system/local` only preferring to create apps for all of its configuration.

In the future it may affect syslog and log rotate in order to facilitate Splunk having read access to the logs.

```{r echo=FALSE, eval=FALSE}
I'm not sure what our requirements are so commenting out for now; leaving as a reminder to figure out
### Setup Requirements

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.
```

### Beginning with splunk

You will need to download Splunk Enterprise or the Splunk Universal Forwarder from Splunk.  

Typically the downloaded file will be provided by copying it into this modules files directory (although alternatives like configuring a yum repository are also possible).

You will then need to configure the module to know the version and build number.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
