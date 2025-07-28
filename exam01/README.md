# LFCS Practice Exam 01

This is a full practice exam for the Linux Foundation Certified System Administrator (LFCS) certification.  
It consists of 20 practical tasks that cover core Linux system administration topics.

## 📋 Exam Overview

- 20 hands-on tasks
- Covers: User management, File permissions, Filesystems, Networking, Services, Logging, and Security
- Designed to be completed in a live Linux environment (Ubuntu or CentOS/RHEL)

## 🧪 Exam Tasks

1. Create user `devadmin` with `/bin/bash` and `/home/devadmin`
2. Set password expiration (30 days) and warning (7 days) for `devadmin`
3. Create group `devops`, add `devadmin` as a secondary member
4. Create shared dir `/opt/teamshare` for `devops`, enable setgid
5. Create file `project.txt` only readable/writable by `devadmin`
6. Format and mount `/dev/sdb1` to `/mnt/data` with ext4
7. Add entry to `/etc/fstab` for `/dev/sdb1`
8. Create symbolic link `/home/devadmin/data_link` → `/mnt/data/reports`
9. Install and start nginx (or httpd)
10. Remove `telnet` package if installed
11. Configure static IP `192.168.56.20` on `eth0/ens33`
12. Set hostname to `lfcs-host.localdomain`
13. Create cron job for `devadmin` to log time every 15 minutes
14. Stop and restart nginx, observe PID
15. Use journalctl to log last 100 nginx lines to `/home/devadmin/nginx.log`
16. Create logrotate rule for `/var/log/nginx/access.log`
17. Disable root SSH login
18. Configure firewall to allow SSH & HTTP, block others
19. Change default boot target to `multi-user.target`
20. Find and kill processes >100MB RAM; clean up `/var` if full

