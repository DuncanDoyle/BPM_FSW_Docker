JBoss EAP V6.1 Docker Image
===========================

This image will provide you with a simple but fully functional Docker Image for
Red Hat JBoss EAP.


Required external files
-----------------------

Before running the docker command to create the image, you will have to download Red Hat JBoss EAP V6.1.0 from the Red Hat support page or from http://www.jboss.org

The provided Dockerfile will work with other versions of Red Hat JBoss EAP as well, but as I want to use it as a base for Red Hat JBoss BPM-Suite V6, we will remain on this Version of EAP.

Step-by-Step Instruction
------------------------
1. Clone this repository into some directory on your system
2. Copy the downloaded Red Hat JBoss EAP Zip-File into the same directory
3. If your EAP Version is not V6.1.1, please change the following lines in the cloned Dockerfile

   ```
   RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-6.1.1.zip -d $HOME/eap
   ```

   and

   ```
   CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
   ```
4. Run the command to create the Docker image

   ```
   docker build --rm -t psteiner/eap .
   ```

   Feel free to substitute `psteiner/eap`with whatever you want to name your image.
5. After successful completion of the previous step, check if your image is now awailable by running the command `docker images` and look for your image-name in the list. 

   ```
   REPOSITORY                   TAG                   IMAGE ID            CREATED             VIRTUAL SIZE
   psteiner/eap                 latest                74d2e9be2605        6 hours ago         1.044 GB
   ```
6. Run an instance of your image

   ```
   docker run -p 49160:8080 -p 49170:9990 -d psteiner/eap
   ```

   Again with replacing the name of the image with your name.
7. Enjoy!

   There is a predefined user `psteiner` with the password `change12_me`
