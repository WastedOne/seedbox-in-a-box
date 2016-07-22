This is a test harness to see if a given build of WM2 builds. It is not intended to be used as such.

To get this to work, one needs to edit the 3 settings.py files with the relevant info/logins/tracker stuffs before building the container.

To get this to work you need to modify wm2settings.py, edit the four lines inside the comment block at the top:
```
#---------------- EDIT THESE 
WHAT_USER_ID = 123456
WHAT_USERNAME = 'your what.cd username'
WHAT_PASSWORD = 'your what.cd password'
WHAT_ANNOUNCE = 'http://tracker.what.cd:34000/SET THIS TO YOUR ANNOUNCE/announce'
#----------------
```
To then access the container, you can point your browser to port 8089 on the host and login with whatwmuser/whatwmpass as credentials.

DO NOT USE THIS IN PRODUCTION AS NO DATASTORES EXIST.

My recommended way to start this container is with:

```
sudo docker run -it --rm -p 8089:80 --name wm2test fedora-23-whatmanager2-testharness 
```

This gives you a port forward from the host port 8089 to port 80 inside the container.

You can also get a shell inside the container for testing/debugging the running container  with:

```
sudo docker exec -it wm2test bash
```
