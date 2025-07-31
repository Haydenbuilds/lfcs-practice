# ✅ LFCS ractice Exam 02

This is the second practice exam for the **Linux Foundation Certified System Administrator (LFCS)** certification.

---

## 📋 Exam Overview

* **20 hands-on tasks**
* Focus Areas: User and Group Management, Storage, Process Management, Networking, System Services, Logging, and System Boot
* Compatible with both Ubuntu and CentOS/RHEL systems

---

## 🧪 Exam Tasks

1. Create user `appuser` with home directory `/opt/appuser` and shell `/bin/bash`
2. Lock the user `appuser` and set an expiry date 15 days from today
3. Create group `webteam` and make it the primary group for `appuser`
4. Create directory `/srv/webdata`, set owner to `appuser:webteam`, permissions to `2755`
5. Create a file `/srv/webdata/info.txt` owned by `appuser`, readable only by the owner
6. Format `/dev/sdc1` as `xfs` and mount it permanently to `/mnt/archive`
7. Create a swap file of 512MB at `/swapfile`, enable it and make it permanent
8. Add the group `sudo` (Ubuntu) or `wheel` (CentOS) to `appuser`
9. Create hard link from `/srv/webdata/info.txt` to `/srv/webdata/info_backup.txt`
10. Install `vsftpd` (FTP server), enable and start the service
11. Create custom systemd service `/etc/systemd/system/helloservice.service` that echoes "Hello LFCS" every boot
12. Configure static IP `192.168.100.50/24`, gateway `192.168.100.1`, DNS `8.8.8.8`
13. Configure hostname to `exam02-host.local`
14. Set a cron job for `appuser` to back up `/srv/webdata` to `/mnt/archive` every day at 2AM
15. Find the top 3 memory-consuming processes and save to `/home/appuser/mem_report.txt`
16. Limit max number of processes for `appuser` to 100 using `ulimit` or PAM limits
17. Set default target to graphical on boot, then switch to command-line (multi-user) on demand
18. Enable automatic security updates using unattended-upgrades (Ubuntu) or `yum-cron` (CentOS)
19. Configure rsyslog to store auth logs in `/var/log/custom_auth.log`
20. Create user `audit` and configure auditd to monitor changes to `/etc/passwd`

