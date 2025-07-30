# LFCS Practice Exam 01 – Notes

## ✅ Task 1 – Create user `devadmin` with /bin/bash and /home/devadmin
- Use `useradd` with the `-m` option to create the home directory and `-s` to set the default shell to `/bin/bash`.
- Verify with: `getent passwd devadmin`.

## ✅ Task 2 – Set password expiration (30 days) and warning (7 days) for devadmin
- Use `chage` to configure password aging:
  - `-M 30`: maximum password age is 30 days
  - `-W 7`: warning will be shown 7 days before expiration
- Verify with: `chage -l devadmin`.

## ✅ Task 3 – Create group `devops`, add `devadmin` as a secondary member
- Use `groupadd` to create the `devops` group.
- Use `usermod -aG` to append `devadmin` to the group as a secondary member (preserving primary group).

## ✅ Task 4 – Create shared dir /opt/teamshare for devops, enable setgid
- Create the directory and change its group to `devops`.
- Use `chmod 2770`:
  - `2`: enables setgid, so new files inherit the `devops` group
  - `770`: full access for owner and group, none for others

## ✅ Task 5 – Create file project.txt only readable/writable by devadmin
- Use `touch` to create the file.
- Set ownership to `devadmin:devops`.
- Set permissions to `600`: only `devadmin` (the owner) can read/write; no access for others.

## ✅ Task 6 – Format and mount /dev/sdb1 to /mnt/data with ext4
- Use `mkfs.ext4` to format `/dev/sdb1` with the ext4 filesystem.
- Create mount point `/mnt/data` using `mkdir -p`.
- Mount the partition temporarily using `mount /dev/sdb1 /mnt/data`.

## ✅ Task 7 – Add entry to /etc/fstab for /dev/sdb1
- Append a line to `/etc/fstab` so that `/dev/sdb1` is mounted automatically at boot:
  `/dev/sdb1 /mnt/data ext4 defaults 0 2`
- Run `mount -a` to test that the syntax is correct and the mount works.

## ✅ Task 8 – Create symbolic link /home/devadmin/data_link → /mnt/data/reports
- Ensure the target directory `/mnt/data/reports` exists.
- Create a symbolic link using `ln -s /mnt/data/reports /home/devadmin/data_link`.

## ✅ Task 9 – Install and start nginx (or httpd)
- On Ubuntu: install `nginx` using `apt`, then enable and start it with `systemctl`.
- On CentOS: install `httpd` using `yum`, then enable and start it.
- Verify the service is running with `systemctl status`.

## ✅ Task 10 – Remove telnet package if installed
- Use `apt remove -y telnet` (Ubuntu) or `yum remove -y telnet` (CentOS) to uninstall telnet.
- Telnet is insecure and should not be installed on production systems.

