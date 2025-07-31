#!/bin/bash

# Task 1 – Create user devadmin
sudo useradd -m -s /bin/bash devadmin

# Task 2 – Set password expiration and warning
sudo chage -M 30 -W 7 devadmin

# Task 3 – Create devops group and add devadmin
sudo groupadd devops
sudo usermod -aG devops devadmin

# Task 4 – Create shared directory with setgid
sudo mkdir -p /opt/teamshare
sudo chown :devops /opt/teamshare
sudo chmod 2770 /opt/teamshare

# Task 5 – Create secure project.txt
sudo touch /opt/teamshare/project.txt
sudo chown devadmin:devops /opt/teamshare/project.txt
sudo chmod 600 /opt/teamshare/project.txt

# Task 6 – Format and mount /dev/sdb1
sudo mkfs.ext4 -F /dev/sdb1
sudo mkdir -p /mnt/data
sudo mount /dev/sdb1 /mnt/data

# Task 7 – Add fstab entry for /mnt/data
UUID=$(sudo blkid -s UUID -o value /dev/sdb1)
echo "UUID=$UUID /mnt/data ext4 defaults 0 2" | sudo tee -a /etc/fstab
sudo mount -a

# Task 8 – Create symbolic link to /mnt/data/reports
sudo mkdir -p /mnt/data/reports
sudo ln -s /mnt/data/reports /home/devadmin/data_link

# Task 9 – Install and start nginx
sudo apt update && sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Task 10 – Remove telnet if installed
sudo apt remove -y telnet || true
sudo apt purge -y telnet || true

# Task 11 – Configure static IP for ens33
sudo cp /etc/netplan/*.yaml /etc/netplan/backup.yaml
cat <<EOF | sudo tee /etc/netplan/50-cloud-init.yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: no
      addresses:
        - 192.168.56.20/24
      routes:
        - to: default
          via: 192.168.56.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
EOF
sudo netplan apply

# Task 12 – Set hostname
sudo hostnamectl set-hostname lfcs-host.localdomain

# Task 13 – Cron job: log time every 15 min
( sudo crontab -u devadmin -l 2>/dev/null; echo "*/15 * * * * date >> /home/devadmin/time.log" ) | sudo crontab -u devadmin -

# Task 14 – Stop and restart nginx, get PID
sudo systemctl stop nginx
sleep 2
sudo systemctl start nginx
pgrep nginx

# Task 15 – Log last 100 nginx lines to file
sudo journalctl -u nginx -n 100 > /home/devadmin/nginx.log

# Task 16 – Configure logrotate for nginx (already exists)
# No action needed unless you want to review with: sudo nano /etc/logrotate.d/nginx

# Task 17 – Disable root SSH login
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

# Task 18 – Configure firewall to allow SSH & HTTP, deny others
sudo ufw allow ssh
sudo ufw allow http
sudo ufw enable
sudo ufw default deny incoming

# Task 19 – Change boot target to multi-user
sudo systemctl set-default multi-user.target

# Task 20 – Kill processes using >100MB RAM & clean /var
ps -eo pid,rss,cmd --sort=-rss | awk '$2 > 102400 {print $1}' | xargs -r sudo kill -9
sudo apt clean
sudo journalctl --vacuum-time=3d
sudo rm -rf /var/tmp/*

