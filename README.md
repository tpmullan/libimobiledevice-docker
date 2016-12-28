## libimobiledevice-docker

### What's in it?
Added libimobiledevice and ideviceinstaller into a ruby dev docker image, to create an environment for accessing iOS device from docker container.
List of tools:
 - idevice_id
 - idevicebackup2
 - idevicedate
 - idevicedebugserverproxy
 - ideviceenterrecovery
 - ideviceinfo
 - idevicename
 - idevicepair
 - idevicescreenshot
 - idevicebackup
 - idevicecrashreport
 - idevicedebug
 - idevicediagnostics
 - ideviceimagemounter
 - ideviceinstaller 
 - idevicenotificationproxy
 - ideviceprovision
 - idevicesyslog

### How?
You have to use docker toolkit instead of docker for Mac, since by now I can only mount iOS usb to docker container which is created with boot2docker.ios. 

Add iOS usb port to docker default machine: 

VirtualBox -> default -> Settings -> Ports -> Usb -> Add(Choose 'Apple Inc. iPhone xxxx') -> OK, start default

1. Then start container with docker run
  ```
  docker run -t -i --privileged image_name bash
  ``` 
  But you have to run 2 command to start connection to your iOS device, 
  ```
  ldconfig
  usbmuxd
  ```
  Then there is accees dialog displayed on your iOS device, choose "Trust".

2. Start with docker-compose:

ex: docker-compose.yml
```
services:
  idevice:
    build: .
    image: 'idevice'
    command: bash -c "/sbin/ldconfig && sleep 3 && /usr/sbin/usbmuxd"
    privileged: true
```

Then you can use 
```
docker-compose exec idevice idevice_id -l
```
You will get all connected iOS devices' id