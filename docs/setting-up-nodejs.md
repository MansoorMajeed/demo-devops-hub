# Setting up NodeJS on Debian 12

## To APT or not to APT

There are several ways you can install NodeJS on your environment. Which method you should choose depends on what you want to do with this environment.

### Simple demo app, don't care about long term

If you are just setting the application for demo purposes and are not going to be using it for anything production, the easiest way would be to just use the `nodejs` and `npm` packages that comes with Debian 12.

```bash
sudo apt update
sudo apt install nodejs npm
```

### Local, cares about different versions of Node

If you plan to use this for longer term and cares about which version of node, `npm` etc you are using, I recommend you use `NVM`.

Go check it out [HERE](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)

### Production, Fixed Node Version

If you are setting it up in production, you usually care about a single version of NodeJS. The same can be said about using in Docker.

Go and install the specific version from Nodesource. Check out [HERE](https://github.com/nodesource/distributions?tab=readme-ov-file#installation-instructions)

