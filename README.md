## libimobiledevice-docker

### What's in it?
Added libimobiledevice and ideviceinstall into a ruby dev docker image, to create an environment for accessing iOS device from docker container.

### How?
You have to use docker toolkit instead of docker for Mac, since by now I can only mount iOS usb to docker container which is created with docker2ios. 

Add iOS usb port to docker default machine: 

VirtualBox -> default -> Settings -> Ports -> Usb -> Add(Choose 'Apple Inc. iPhone xxxx') -> OK, start default

Then start container with docker run
```
docker run -t -i --privileged -v /dev/tty.usbmodemXXXXXXX image_name bash
``` 

or with docker-compose:

ex: docker-compose.yml
```
  idevice:
    build: .
    image: 'idevice'
    devices:
      - '/dev/tty.usbmodemXXXXXXX'
    privileged: true
```

Then you can use 
```
docker-compose exec idevice idevice_id -l
```

to get all connected iOS devices' id