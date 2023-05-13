# michaelsasser89/vsftpd

## Quick reference

- Maintained by:<br />
  [Michael Sasser](https://github.com/MichaelSasser)

- Previously maintained by:<br />
  [Fer Uría](https://github.com/fauria), and
  [Mark Hobson](https://github.com/markhobson)

- Where to get help:<br />
  [the Docker Community Slack](https://dockr.ly/comm-slack),
  [Server Fault](https://serverfault.com/help/on-topic),
  [Unix & Linux](https://unix.stackexchange.com/help/on-topic), or
  [Stack Overflow](https://stackoverflow.com/help/on-topic)

## Supported tags and respective `Dockerfile` links

- [latest](https://github.com/MichaelSasser/docker-vsftpd/blob/main/Dockerfile)

## Quick Reference (cont.)

- Where to file issues:<br />
  [Create a new issue](https://github.com/MichaelSasser/docker-vsftpd/issues/new)

- Source of this description:<br />
  [Image repository - README.md](https://github.com/MichaelSasser/docker-vsftpd/blob/main/README.md)

## What's in this image?

The image is build from the [Debian image](https://hub.docker.com/_/debian)
using the
[stable-slim](https://github.com/debuerreotype/docker-debian-artifacts/blob/f7257ef5b83f6b64385edddeae2d2ba7d1b34935/stable/slim/Dockerfile)
tag and allows users to run a 
[vsftpd](https://security.appspot.com/vsftpd.html) 3.x server.

It has the following features:

- Passive mode
- FTPS support
- Logging to a file or STDOUT.
- Virtual users

## Installation from [Docker registry hub](https://registry.hub.docker.com/r/michaelsasser89/vsftpd/).

You can pull the image with the following command:

```shell
docker pull michaelsasser89/vsftpd
```

## Environment variables

With the following environment variables can be used to alter some of its 
functionality at runtime:

- **Variable name**: `FTP_USER`<br />
  **Default value**: admin<br />
  **Accepted values**: Any string. Avoid whitespaces and special chars.<br />
  **Description**: Username for the default FTP account. If you don't specify it
  through the `FTP_USER` environment variable at run time, `admin` will be used
  by default.


- **Variable name**: `FTP_PASS`<br />
  **Default value**: Random string.<br />
  **Accepted values**: Any string.<br />
  **Description**: If you don't specify a password for the default FTP account
  through `FTP_PASS`, a 16 character random string will be automatically
  generated. You can obtain this value through the
  [container logs](https://docs.docker.com/engine/reference/commandline/container_logs/).


- **Variable name**: `PASV_ADDRESS`<br />
  **Default value**: Docker host IP / Hostname.<br />
  **Accepted values**: Any IPv4 address or Hostname (see PASV_ADDRESS_RESOLVE).<br />
  **Description**: If you don't specify an IP address to be used in passive mode,
  the routed IP address of the Docker host will be used. Bear in mind that this
  could be a local address.


- **Variable name**: `PASV_ADDR_RESOLVE`<br />
  **Default value**: `"NO"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"YES"` if you want to use a hostname (as opposed to IP
  address) in the PASV_ADDRESS option.


- **Variable name**: `PASV_ENABLE`<br />
  **Default value**: `"YES"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"NO"` if you want to disallow the PASV method of obtaining a
  data connection.


- **Variable name**: `PASV_MIN_PORT`<br />
  **Default value**: 21100<br />
  **Accepted values**: Any valid port number.<br />
  **Description**: This will be used as the lower bound of the passive mode port
  range. Remember to publish your ports with `docker -p` parameter.


- **Variable name**: `PASV_MAX_PORT`<br />
  **Default value**: 21110<br />
  **Accepted values**: Any valid port number.<br />
  **Description**: This will be used as the upper bound of the passive mode port
  range. It will take longer to start a container with a high number of
  published ports.


- **Variable name**: `XFERLOG_STD_FORMAT`<br />
  **Default value**: `"NO"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"YES"` if you want the transfer log file to be written in
  standard xferlog format.


- **Variable name**: `LOG_STDOUT`<br />
  **Default value**: Empty string.<br />
  **Accepted values**: Any string to enable, empty string or not defined to
  disable.<br />
  **Description**: Output vsftpd log through STDOUT, so that it can be accessed
  through the
  [container logs](https://docs.docker.com/engine/reference/commandline/container_logs).


- **Variable name**: `FILE_OPEN_MODE`<br />
  **Default value**: 0666<br />
  **Accepted values**: File system permissions.<br />
  **Description**: The permissions with which uploaded files are created. Umasks
  are applied on top of this value. You may wish to change to 0777 if you want
  uploaded files to be executable.


- **Variable name**: `LOCAL_UMASK`<br />
  **Default value**: 077<br />
  **Accepted values**: File system permissions.<br />
  **Description**: The value that the umask for file creation is set to for local
  users. NOTE! If you want to specify octal values, remember the "0" prefix
  otherwise the value will be treated as a base 10 integer!


- **Variable name**: `REVERSE_LOOKUP_ENABLE`<br />
  **Default value**: `"YES"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"NO"` if you want to avoid performance issues where a name
  server doesn't respond to a reverse lookup.


- **Variable name**: `PASV_PROMISCUOUS`<br />
  **Default value**: `"NO"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"YES"` if you want to disable the PASV security check that
  ensures the data connection originates from the same IP address as the
  control connection. Only enable if you know what you are doing! The only
  legitimate use for this is in some form of secure tunnelling scheme, or
  perhaps to facilitate FXP support.


- **Variable name**: `PORT_PROMISCUOUS`<br />
  **Default value**: `"NO"`<br />
  **Accepted values**: `"YES"` | `"NO"`<br />
  **Description**: Set to `"YES"` if you want to disable the PORT security check that
  ensures that outgoing data connections can only connect to the client. Only
  enable if you know what you are doing! Legitimate use for this is to
  facilitate FXP support.


- **Variable name**: `SSL_ENABLE`<br />
  **Default value**: `"NO"`<br />
  **Accepted values**: `"YES"` | `"NO"`.<br />
  **Description**: Set to `"YES"` if you want to enable SSL encryption - make
  vsftpd a `FTPS` server.


- **Variable name**: `TLS_CERT`<br />
  **Default value**: cert.pem<br />
  **Accepted values**: Any string representing a filename with extension<br />
  **Description**: Certificate filename which should be located in
  `/etc/vsftpd/cert/` of container.


- **Variable name**: `TLS_KEY`<br />
  **Default value**: key.pem<br />
  **Accepted values**: Any string representing a filename with extension<br />
  **Description**: Key filename which should be located in `/etc/vsftpd/cert/` of
  container.

## Exposed ports and volumes

The image exposes ports `20` and `21`. Also, exports three volumes:

- `/home/vsftpd`: contains the users home directories
- `/var/log/vsftpd`: contains logs
- `/etc/vsftpd/cert`: provide SSL certificate to container

## Examples

1. Create a temporary container for testing purposes:

   ```shell
   $ docker run --rm michaelsasser89/vsftpd
   ```

2. Create a container in active mode using the default user account, with a
   binded data directory:

   ```shell
   $ docker logs vsftpd
   ```

3. Create a **production container** with a custom user account, SSL enabled,
   binding a data directory and enabling both active and passive mode:

   ```shell
   $ docker run -d -v /my/data/directory:/home/vsftpd \
     -p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
     -e FTP_USER=myuser -e FTP_PASS=mypass \
     -e SSL_ENABLE=YES -e TLS_CERT=ftps_localhost.crt -e TLS_KEY=ftps_localhost.key \
     -e PASV_ADDRESS=127.0.0.1 -e PASV_MIN_PORT=21100 -e PASV_MAX_PORT=21110 \
     --name vsftpd --restart=always michaelsasser89/vsftpd
   ```

4. Manually add a new FTP user to an existing container:
   ```shell
   $ docker exec -i -t vsftpd bash
   $ mkdir /home/vsftpd/myuser
   $ echo -e "myuser\nmypass" >> /etc/vsftpd/virtual_users.txt
   $ /usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
   $ exit
   $ docker restart vsftpd
   ```

## License

Copyright &copy; 2023 Michael Sasser \<Info@MichaelSasser.org\>,<br />
Copyright &copy; 2021 Mark Hobson  \<https://github.com/markhobson\>,<br />
Copyright &copy; 2015-2020 Fer Uría \<https://github.com/fauria\>.
Released under the Apache-2.0 license.
