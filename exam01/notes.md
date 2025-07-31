# LFCS Practice Exam 01 – Notes

## ✅ Task 1 – Create user `devadmin` with /bin/bash and /home/devadmin

* Use `useradd` with the `-m` option to create the home directory and `-s` to set the login shell.
* Verify with: `getent passwd devadmin`

## ✅ Task 2 – Set password expiration (30 days) and warning (7 days) for devadmin

* Use `chage` to configure password aging:

  * `-M 30`: sets max password age to 30 days
  * `-W 7`: warning will be shown 7 days before password expires
* Verify with: `chage -l devadmin`

## ✅ Task 3 – Create group `devops`, add `devadmin` as a secondary member

* Create group with `groupadd devops`
* Use `usermod -aG devops devadmin` to add user without removing them from other groups

## ✅ Task 4 – Create shared dir `/opt/teamshare` for devops, enable setgid

* Create the directory and set group ownership: `chown :devops /opt/teamshare`
* Set permission to `2770`:

  * `2`: setgid bit ensures files created inherit the group
  * `770`: full access for owner/group, none for others

## ✅ Task 5 – Create file `project.txt` only readable/writable by devadmin

* Use `touch` to create the file.
* Set ownership with `chown devadmin:devops project.txt`
* Set permission to `600`: owner read/write only

## ✅ Task 6 – Format and mount `/dev/sdb1` to `/mnt/data` with ext4

* Format disk: `mkfs.ext4 /dev/sdb1`
* Create mount point: `mkdir -p /mnt/data`
* Mount temporarily: `mount /dev/sdb1 /mnt/data`

## ✅ Task 7 – Add entry to `/etc/fstab` for `/dev/sdb1`

* Get UUID with `blkid /dev/sdb1`
* Add to `/etc/fstab`:

  ```
  UUID=xxxx-xxxx /mnt/data ext4 defaults 0 2
  ```
* Test with: `mount -a`

## ✅ Task 8 – Create symbolic link `/home/devadmin/data_link` to `/mnt/data/reports`

* Make sure `/mnt/data/reports` exists: `mkdir -p /mnt/data/reports`
* Create symlink: `ln -s /mnt/data/reports /home/devadmin/data_link`

## ✅ Task 9 – Install and start nginx

* Install: `apt install -y nginx`
* Enable and start service:

  ```
  systemctl enable nginx
  systemctl start nginx
  ```

## ✅ Task 10 – Remove telnet if installed

* Remove with:

  ```
  apt remove -y telnet
  apt purge -y telnet
  ```

## ✅ Task 11 – Set static IP address on `ens33`

* Edit `/etc/netplan/*.yaml` with static config (replace with actual file):

  ```yaml
  network:
    version: 2
    ethernets:
      ens33:
        dhcp4: no
        addresses: [192.168.56.20/24]
        gateway4: 192.168.56.1
        nameservers:
          addresses: [8.8.8.8, 1.1.1.1]
  ```
* Apply changes: `netplan apply`

## ✅ Task 12 – Change hostname to `lfcs-host.localdomain`

* Use: `hostnamectl set-hostname lfcs-host.localdomain`

## ✅ Task 13 – Schedule cron job to log time every 15 min

* Open devadmin's crontab: `crontab -u devadmin -e`
* Add line:

  ```
  */15 * * * * date >> /home/devadmin/time.log
  ```

## ✅ Task 14 – Restart nginx and get PID

* Restart service: `systemctl restart nginx`
* Get PID: `pgrep nginx`

## ✅ Task 15 – Save last 100 nginx logs to file

* Use: `journalctl -u nginx -n 100 > /home/devadmin/nginx.log`

## ✅ Task 16 – Check nginx logrotate config

* Confirm file `/etc/logrotate.d/nginx` exists and has valid configuration

## ✅ Task 17 – Disable root login in SSH

* Edit `/etc/ssh/sshd_config`, set: `PermitRootLogin no`
* Reload SSH: `systemctl reload sshd`

## ✅ Task 18 – Configure firewall to allow SSH and HTTP only

* Commands:

  ```
  ufw allow ssh
  ufw allow http
  ufw default deny incoming
  ufw enable
  ```

## ✅ Task 19 – Set system to boot in multi-user (CLI) mode

* Use: `systemctl set-default multi-user.target`

## ✅ Task 20 – Kill heavy memory processes and clean `/var`

* Kill processes >100MB RAM:

  ```bash
  ps -eo pid,cmd,%mem,rss --sort=-rss | awk '$4 > 102400 {print $1}' | xargs -r kill -9
  ```
* Clean up:

  ```bash
  apt clean
  journalctl --vacuum-time=3d
  rm -rf /var/tmp/*
  ```

