<a href="https://github.com/TryGhost/Ghost"><img src="https://cloud.githubusercontent.com/assets/120485/6622822/c4c639fe-c8e7-11e4-9e64-5bec06c8b4c3.png" alt="Ghost" /></a>
<a href="https://travis-ci.org/TryGhost/Ghost"><img align="right" src="https://travis-ci.org/TryGhost/Ghost.svg?branch=master" alt="Build status" /></a>

![Ghost Screenshot](https://cloud.githubusercontent.com/assets/120485/6626466/6dae46b2-c8ff-11e4-8c7c-8dd63b215f7b.jpg)

![Ghost is a simple, powerful publishing platform that allows you to share your stories with the world.](https://cloud.githubusercontent.com/assets/120485/6626501/b2bb072c-c8ff-11e4-8e1a-2e78e68fd5c3.png)

The project is maintained by a non-profit organisation called the **Ghost Foundation**, along with an amazing group of independent [contributors](https://github.com/TryGhost/Ghost/contributors). We're trying to make publishing software that changes the shape of online journalism.

- [Ghost.org](https://ghost.org)
- [Latest Release](https://ghost.org/download/)
- [Support](http://support.ghost.org/)
- [Theme Docs](http://themes.ghost.org)
- [Contributing Guide](https://github.com/TryGhost/Ghost/blob/master/CONTRIBUTING.md)
- [Feature Requests](http://ideas.ghost.org/)
- [Dev Blog](http://dev.ghost.org)



## Running Ghost on OpenShift

This is a basic quickstart to get Ghost running on OpenShift.  

If you have already created an application with this, and are having issues with it not working when you do a restart,
run this command, then issue a restart and it should be fixed.

	rhc set-env NODE_ENV=production --app $appname

Where $appname is the name of your application.  This was due to the pre_start_nodejs script not running on a restart.

The easiest way is to use the following command, make sure that you run 'gem update rhc' first so that you have the newest version:

	rhc app create ghost nodejs-0.10 mysql-5.1 --env NODE_ENV=production --from-code https://github.com/openshift-quickstart/openshift-ghost-quickstart.git

'ghost' will be the name of your application.  

Note these OpenShift specific changes:

1. The content/data and content/images directories have been removed.  They are created on the server and symlinked to your $OPENSHIFT\_DATA\_DIR so that posts and uploaded images will persist across 'git pushes'
2. Even though the node.js cartridge itself is scalable, this application will not play nice with scaling right now because it is using sqlite3 as the database (which is a file store), and the images are stored on disk, and since OpenShift does not currently support shared physical disk storage across scaled gears, this cartridge will not scale.  We are working on a solution for this.
3. If you use a custom domain, modify the production url field in config.js file.



# Quick Start Install

Make sure you've installed Node.js - We recommend the latest **Node v0.10.x** release.

Ghost is also compatible with **Node v0.12** and **io.js v1.2**, but please note that these versions are more likely to run into installation problems. May contain nuts. Please use the [forum](https://ghost.org/forum/installation/) for help.

1. Download the [latest release](https://ghost.org/download/) of Ghost
1. Unzip in the location you want to install
1. Fire up a terminal
1. `npm install --production`
1. Start Ghost!
    - Local environment: `npm start`
    - On a server: `npm start --production`
1. `http://localhost:2368/ghost` :tada:

More [install docs](http://support.ghost.org/installation/) here in case you got stuck.


# Developer Install (from git)

Install Node.js.

```bash
# Node v0.10.x - full support
# Node v0.12.x and io.js v1.2 - partial support
#
# Choose wisely
```

Clone :ghost:

```bash
git clone git://github.com/tryghost/ghost.git
cd ghost
```

Install grunt. No prizes here.

```bash
npm install -g grunt-cli
```

Install Ghost. If you're running locally, use [master](https://github.com/TryGhost/Ghost/tree/master). For production, use [stable](https://github.com/TryGhost/Ghost/tree/stable). :no_entry_sign::rocket::microscope:

```bash
npm install
```

Build the things!

```bash
grunt init
```

Minify that shit for production?

```bash
grunt prod
```

Start your engines.

```bash
npm start

## running production? Add --production
```

Congrats! You made it. BTW you can also just `npm install ghost` if you're into that sort of thing. NPM afficionados can also read up on using [Ghost as an NPM module](https://github.com/TryGhost/Ghost/wiki/Using-Ghost-as-an-npm-module).

More general [install docs](http://support.ghost.org/installation/) here in case you got stuck.


# Deploying Ghost

The easiest way to deploy Ghost is on our official <strong><a href="https://ghost.org/pricing/">Ghost(Pro)</a></strong> hosted platform. This service funds the Ghost Foundation, which makes actively maintaining this project possible.

Also, you get to save yourself a lot of wasted time and headaches by deploying a new instance of Ghost to a managed server with a global content delivery network in just a few clicks.

[Other options](http://support.ghost.org/deploying-ghost/) are available if you prefer playing around with servers by yourself.


# Staying Up to Date

When a new version of Ghost comes out, you'll want to look over these [upgrade instructions](http://support.ghost.org/how-to-upgrade/) for what to do next.

You can talk to other Ghost users on [our forums](https://ghost.org/forum) or chat with Ghost developers on IRC. We're on `irc.freenode.net`, in the `#Ghost` channel. We have a public meeting every Tuesday at 5:30pm London time.

New releases are announced on the [dev blog](http://dev.ghost.org/tag/releases/). You can subscribe by email or follow [@TryGhost_Dev](https://twitter.com/tryghost_dev) on Twitter, if you prefer your updates bite-sized and facetious.

:saxophone::turtle:


# Copyright & License

Copyright (c) 2013-2015 Ghost Foundation - Released under the [MIT license](LICENSE).
