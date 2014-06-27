Docker Images
============

This is a set of Docker images which together form a Red Hat BPM-Suite and Red Hat Fuse ServiceWorks demo environment.
I personally use this setup whenever I have to present these topics to some audiance.

About the images
================
For the demo we will need two Docker-Images one hosting Red Hat JBoss BPM-Suite and the other Red Hat JBoss Fuse ServiceWorks.

BPM image
---------
This image is made out of 3 layers
1. Red Hat JBoss EAP ( image-name psteiner/eap )
2. Red Hat JBoss BPM Suite ( image-name psteiner/bpm )
3. WebService consumer deployed into layer 2 ( image-name psteiner/heise_bpm )

Each of the images can be used for other purposes as well.

Fuse ServiceWorks image
-----------------------
This image is made out of 2 layers
1. Red Hat JBoss Fuse ServiceWorks ( image-name psteiner/fsw )
2. WebService provider deployed into layer 1 ( image-name psteiner/heise_fsw )

Each of the images can be used for other purposes as well.

Creating the images
===================
You will have to create the images in the order as they are listed above.

After successfully cloning this image with `git clone https://github.com/PatrickSteiner/BPM_FSW_Docker.git` you will have one directory per image.

Please download the following Red Hat JBoss products:
* [Red Hat JBoss EAP](http://www.jboss.org/download-manager/file/jboss-eap-6.1.0.GA.zip)
* [Red Hat JBoss BPM-Suite](https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=28913)
* [Red Hat JBoss EAP](http://www.jboss.org/download-manager/file/jboss-fsw-6.0.0.GA.zip)

Please copy the downloaded products as follows:
* jboss-eap-6.1.0.GA.zip into the folder EAP_Image
* jboss-bpms-6.0.1.GA-redhat-4-deployable-eap6.x into the folder BPM_Image
* jboss-fsw-6-0.0.GA.zip into the FSW_Image

Details on creating the images is documented in the Readme's of the subdirectories.

If you prefer to see all this in a video, here we go:
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/Ku1-UpeW3qI/0.jpg)](http://youtu.be/9aKRDL1sWuM)

Starting the images
==================

As the two images depend on each other, via a Link, we need to run them in the right order.
1. the Fuse ServiceWorks image  with the command `docker run -p 49260:8080 -p 49270:9990 -h fsw --name fsw -d psteiner/fsw_heise`
2. the BPM-Suite image  with the command `docker run -p 49160:8080 -p 49170:9990 --link fsw:fsw --name bpms -d psteiner/heise_bpm`

You can do this manually or by running the provided script `start.sh`.

Running the images
==================

A first video on how to start and run the environment is here:

[![IMAGE ALT TEXT HERE]()](http://youtu.be/aB8e0gcXkUw)

http://youtu.be/aB8e0gcXkUw

Have fun and feel free to comment me with questions, improvment ideas, et. al

Patrick

psteiner at redhat.com
