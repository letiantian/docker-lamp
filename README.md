# docker-lamp
It's used to test php applications.


## Build

```
$ git clone https://github.com/someus/docker-lamp.git

$ cd docker-lamp

$ sudo docker build -t letian/lamp:v1 .
......
......
Successfully built 2ed6bc3a0de8

$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
letian/lamp         v1                  2ed6bc3a0de8        31 minutes ago      458.7 MB
ubuntu              14.04               89d5d8e8bafb        2 weeks ago         187.9 MB
```


## Use

```
$ mkdir ~/html

$ echo "<?php phpinfo();"  > ~/html/index.php

$ sudo docker run -d -p 9876:80 -p 8022:22 -v ~/html:/var/www/html letian/lamp:v1
487defda99d54523d2e0fd966a2d1e3e5be12405a94b15749b5095eb571d9373
```

`http://127.0.0.1:9876/` will show the result of `phpinfo()`.

Use ssh: 
```
$ ssh root@127.0.0.1 -p 8022
```

Show log:
```
$ sudo docker logs -f 487def
```

Stop:
```
$ sudo docker stop 487def
```

Restart:
```
$ sudo docker start 487def
```

Remove:
```
$ sudo docker rm 487def
```


## Precautions

For security's sake, the password in Dockerfile should be changed. 

The default password of root account is `weakpass`. And the default of MySQL's root account is `mysqlpass`.


## References

How to config ssh server:  

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/V2V_Guide/Preperation_Before_the_P2V_Migration-Enable_Root_Login_over_SSH.html

http://superuser.com/questions/908179/ubuntu-plesk-ssh-issues-permitrootlogin

> !! The config file is `sshd_config`, not `ssh_config`.


How to install LAMP:

http://ubuntuserverguide.com/2014/06/how-to-install-lamp-in-ubuntu-server-14-04-lts.html

Others:

http://my.oschina.net/letiantian/blog/521540  
http://www.letiantian.me/2015-12-06-docker-ghost/  
http://blog.delgurth.com/2009/01/19/pre-loading-debconf-values-for-easy-installation/  
https://serversforhackers.com/video/installing-mysql-with-debconf  
http://askubuntu.com/questions/79257/how-do-i-install-mysql-without-a-password-prompt  
http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/  
https://docs.docker.com/engine/examples/running_ssh_service/  