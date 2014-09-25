JBoss BPM-Suite V6.0 Docker Image
=================================

This image will provide you with a simple but fully functional Docker Image for
Red Hat JBoss BPM-Suite and is based on the [EAP](https://github.com/PatrickSteiner/DockerImages/tree/master/EAP_Image), as defined in the other folder of the repository.


Required external files
-----------------------

Before running the docker command to create the image, you will have to download Red Hat JBoss BPM-Suite V6.0.1 from the Red Hat support page or from http://www.jboss.org

The provided Dockerfile will work with other versions of Red Hat JBoss BPM V6 as well, you will just have to change one line in the Dockerfile.

Step-by-Step Instruction
------------------------
1. Clone this repository into some directory on your system
2. Copy the downloaded Red Hat JBoss BPM-Suite Zip-File into the same directory
3. If your BPM Version is not V6.0.1, please change the following line in the cloned Dockerfile

   ```
   RUN /usr/bin/unzip -qo $HOME/tmp/jboss-bpms-6.0.3.GA-redhat-1-deployable-eap6.x.zip -d $HOME/eap
   ```
4. Run the command to create the Docker image

   ```
   docker build --rm -t psteiner/bpm .
   ```

   Feel free to substitute `psteiner/bpm`with whatever you want to name your image.
5. After successful completion of the previous step, check if your image is now awailable by running the command `docker images` and look for your image-name in the list. 

   ```
   REPOSITORY                   TAG                   IMAGE ID            CREATED             VIRTUAL SIZE
   psteiner/bpm        latest              e72c4c4a2eca        16 seconds ago      1.91 GB
   psteiner/eap        latest              584ff662fdfe        15 minutes ago      1.045 GB
   ```
6. Run an instance of your image

   ```
   docker run -p 49160:8080 -p 49170:9990 -d psteiner/bpm
   ```

   Again with replacing the name of the image with your name.
7. Enjoy!

   There is a predefined user `psteiner` with the password `change12_me`
