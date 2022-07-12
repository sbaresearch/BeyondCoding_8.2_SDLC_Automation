# automation_demo

This is an amazing command line tool which prints a very secure military grade random number on your screen

## Requirements

The tool has only been tested on Ubuntu 20.04 x86-64

You need to install the following packages:

    sudo apt-get install maven docker.io

## Usage

### Local

Build the software with

    mvn package assembly:single -Dmaven.test.skip=true

Then you can run it by using

    java -jar target/automation-demo-1.0-SNAPSHOT-jar-with-dependencies.jar 

### Docker

To build a docker image execute

    sudo docker build . -t automation_demo

and then run it with

    sudo docker run --rm automation_demo