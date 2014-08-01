JBoss BPM-Suite V6.0 Docker Image with WebService-Client
========================================================

Step-by-Step Instruction
------------------------
1. Clone this repository into some directory on your system
2. Run the command to create the Docker image

   ```
   docker build --rm -t psteiner/heise_bpm .
   ```

   Feel free to substitute `psteiner/heise_bpm`with whatever you want to name your image.
3. After successful completion of the previous step, check if your image is now awailable by running the command `docker images` and look for your image-name in the list. 

   ```
   REPOSITORY           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
     psteiner/heise_bpm   latest              cae5f3bc4444        30 hours ago        1.821 GB
     psteiner/bpm         latest              5e5103f7ac0d        30 hours ago        1.817 GB
     psteiner/eap         latest              8b121fb6e5fe        31 hours ago        793.5 MB
   ```
4. Run an instance of your image

   ```
   docker run -p 49160:8080 -p 49170:9990 -d psteiner/heise_bpm
   ```

   Again with replacing the name of the image with your name.
5. Enjoy!
