# cfskeleton

A utility project to get you up and running quickly with a simple Lucee based website running:

- Lucee 5.2
- Tomcat
- nginx
- Web pack
- bootstrap 4.3

## Getting the code

Check out the project from https://github.com/icf-mrankin/cfskeleton.git using your git tools of choice to a good working directory

## Prerequisites

In order to use this project you need to have the following applications installed and running:

- [nodejs](https://nodejs.org/en/)
- [npm](https://www.npmjs.com)
- [docker](https://www.docker.com/get-started)

## Starting the network

Included in the download are the files necessary to start a small local network with Docker with:

- The application initialized on a Lucee web server.
- A mysql database
- a mailcatcher instance to work with mail locally

Open a bash terminal and run:

```bash
docker-compose up
```

That will start your machines.

## Initialize the javascript and css

Open another bash terminal (or reuse the previous one) and install node.js and/or npm if needed.

run:

```bash
npm install
```

after that, you can build your local css with:

```bash
npm run watch
```

That will get npm running for development and watch your sass files and javascript files and update them as you change them.  The files you want to work with are in the **src** directory in the root of the project.

You can also run:

```bash
npm run build-win 
OR
npm run build-mac
```

to create a war file for distribution to hosting environements like AWS or any other jee server that Lucee supports.  We've included Lucee in the project and the build, so you don't have to do any sort of installation on the host, just drop in the war file and you should be up and running.  Granted, this is a simple setup and you may have to tweak things if you intend to go to production.