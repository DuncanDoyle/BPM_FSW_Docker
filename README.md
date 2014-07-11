# Docker Images

This is a set of Docker images which together form a Red Hat BPM-Suite and Red Hat Fuse ServiceWorks demo environment.
I personally use this setup whenever I have to present these topics to some audience.

# About the images

The demo requires two Docker-Images (Heise_BPM_Image and Heise_FSW_Image). As you can probably guess Heise_BPM_Image hosts the Red Hat JBoss BPM-Suite and Heise_FSW_Image hosts Red Hat JBoss Fuse ServiceWorks. All required images are built automatically. During the built process the base images (EAP_Image, BPM_Image, and FSW_Image) are built as well. These are plain base Images which can be re-used for your custom demos as well.

## Control Script

The `demo.sh` control script provides several actions from *building* the images to *running*, and *removing* the images. The following section describes how to use the `demo.sh script.

### demo.sh usage

The `demo.sh` script accepts the following parameters:

- **build** - the build parameter triggers an image build and accepts the following parameters  
  - **bpm** - build the bpm image
  - **eap** - build the eap image
  - **fsw** - build the fsw image
  - **heise\_bpm** - build the heise_bpm image which in turn requires the bpm image (see above), which in turn requires the eap image. 
  - **heise\_fsw** - build the heise_fsw image which in turn requires the fsw image (see above)
  - **all** - build all required images in one go
- **start** - Creates and runs the fsw and bpms containers and names it accordingly. If an existing fsw container is present, but not running it is started. By default the containers are started in detached mode. If you want to see what is going on you need to add an additional _attached_ parameter.
  - **attached** - Starts the bpms container attached and removes it after you terminate the jboss process.
- **remove** - removes images from the docker registry. Needed for rebuilding parts of the demo environment.
  - **bpm** - remove the bpm image and all intermediary images
  - **eap** - remove the eap image and all intermediary images
  - **fsw** - remove the fsw image and all intermediary images
  - **heise\_bpm** - remove the heise_bpm image and all intermediary images 
  - **heise\_fsw** - remove the heise_fsw image and all intermediary images
- **status** - runs `docker ps`. Can be used to see what instances are running and how the ports are mapped.


## Heise BPM image
This image is made out of 3 layers

   1. Red Hat JBoss EAP ( image-name psteiner/eap )
   2. Red Hat JBoss BPM Suite ( image-name psteiner/bpm )
   3. WebService consumer deployed into layer 2 ( image-name psteiner/heise_bpm )

Heise Fuse ServiceWorks image
-----------------------------
This image is made out of 2 layers

   1. Red Hat JBoss Fuse ServiceWorks ( image-name psteiner/fsw )
   2. WebService provider deployed into layer 1 ( image-name psteiner/heise_fsw )

Postgres image
--------------
This image is not yet used for the demo, but in preparation for so!

It will be used for the Business Activity Monitoring of the demo and
probably later also for showcasing data virtualization.

Creating the images
===================
After successfully cloning this image with `git clone https://github.com/PatrickSteiner/BPM_FSW_Docker.git` you will have one directory per image.

Please download the following Red Hat JBoss products:
* [Red Hat JBoss EAP](http://www.jboss.org/download-manager/file/jboss-eap-6.1.0.GA.zip)
* [Red Hat JBoss BPM-Suite](https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=30853&product=bpm.suite)
* [Red Hat JBoss FSW](http://www.jboss.org/download-manager/file/jboss-fsw-6.0.0.GA.zip)

Please copy the downloaded products as follows:
* jboss-eap-6.1.0.GA.zip into the folder `EAP_Image`
* jboss-bpms-6.0.2.GA-redhat-5-deployable-eap6.x.zip into the folder `BPM_Image`
* jboss-fsw-installer-6.0.0.GA-redhat-4.jar into the `FSW_Image`

After the files are downloaded, run `demo.sh build all` 

If you prefer to see all this in a video, here we go:
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/9aKRDL1sWuM/0.jpg)](https://www.youtube.com/watch?v=9aKRDL1sWuM)

Starting the images
===================

As the two images depend on each other, via a Link, we need to run them in the right order. For this purpose you can simply run `demo.sh start` which will run the demo in detached mode on fixed ports (49160) or you can run `demo.sh start attached` which will run the fsw image in detached mode and the bpms image in attached mode and remove the image after the jboss process is terminated. 

Of course you can run the images manually using:

1. `docker run -p 49260:8080 -p 49270:9990 -h fsw --name fsw -d psteiner/heise_fsw` for the Fuse ServiceWorks Image
2. `docker run -p 49160:8080 -p 49170:9990 --link fsw:fsw --name bpms -d psteiner/heise_bpm` for the BPMS Image

Running the demo
==================

A first video on how to start and run the environment is here:

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/aB8e0gcXkUw/0.jpg)](https://www.youtube.com/watch?v=aB8e0gcXkUw)

Have fun and feel free to comment, come up with ideas for improvement, etc.

Patrick and Buddy

psteiner at redhat.com
buddy at redhat.com
