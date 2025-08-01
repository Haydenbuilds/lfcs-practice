# LFCS Practice Exam 02 – Notes

## ✅ Task 1 – Create user `appuser` with /bin/bash and /opt/appuser

* Use `useradd -m -d /opt/appuser -s /bin/bash` to create the user with a custom home directory and shell.
* Set password using `echo 'appuser:password' | chpasswd`
* Verify with: `getent passwd appuser`

---

## ✅ Task 2 – Lock user and set account to expire in 15 days

* Use `usermod -e YYYY-MM-DD appuser` to set an expiration date (e.g. `date -d "+15 days" +%Y-%m-%d`)
* Use `passwd -l appuser` to lock the user account
* Verify with: `chage -l appuser` and `passwd -S appuser`

---

## ✅ Task 3 – Create group `webteam` and make it primary group for `appuser`

* Use `groupadd webteam` to create the group
* Change primary group using `usermod -g webteam appuser`
* Verify with: `id appuser`

---

## ✅ Task 4 – Create directory `/srv/webdata`, set owner to `appuser:webteam`, and permissions to `2755`

* Create directory with `mkdir -p /srv/webdata`
* Set ownership with `chown appuser:webteam /srv/webdata`
* Set permissions with `chmod 2755 /srv/webdata`
* `2` enables setgid so new files inherit group

---

## ✅ Task 5 – Create file `/srv/webdata/info.txt` owned by `appuser`, readable only by the owner

* Create file with `touch /srv/webdata/info.txt`
* Set ownership using `chown appuser /srv/webdata/info.txt`
* Set permissions with `chmod 400 /srv/webdata/info.txt`
* Verify with: `ls -l /srv/webdata/info.txt`

---

## ✅ Task 6 – Format `/dev/sdc1` as XFS and mount to `/mnt/archive` permanently

* Format with: `mkfs.xfs /dev/sdc1`
* Create mount point: `mkdir -p /mnt/archive`
* Mount it: `mount /dev/sdc1 /mnt/archive`
* Add entry to `/etc/fstab`:
/dev/sdc1 /mnt/archive xfs defaults 0 0

* Verify with: `mount | grep archive`

---

## ✅ Task 7 – Create 512MB swap file at `/swapfile`, enable and make permanent

* Allocate file: `fallocate -l 512M /swapfile`
* Set secure permissions: `chmod 600 /swapfile`
* Format as swap: `mkswap /swapfile`
* Enable: `swapon /swapfile`
* Make permanent in `/etc/fstab`:
/swapfile none swap sw 0 0
* Verify with: `free -h`

---

## ✅ Task 8 – Add `appuser` to `sudo` group

* Use `usermod -aG sudo appuser` to add `appuser` as a secondary member
* Verify with: `groups appuser`

---

## ✅ Task 9 – Create hard link from `info.txt` to `info_backup.txt`

* Run: `ln /srv/webdata/info.txt /srv/webdata/info_backup.txt`
* Do not create `info_backup.txt` beforehand
* Verify with: `ls -li /srv/webdata/info*.txt` → inode numbers must match

---

## ✅ Task 10 – Install `vsftpd`, enable and start the service

* Install with: `apt update && apt install -y vsftpd`
* Enable: `systemctl enable vsftpd`
* Start: `systemctl start vsftpd`
* Verify with: `systemctl status vsftpd`

---

