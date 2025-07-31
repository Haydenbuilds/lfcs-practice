#!/bin/bash
# reset_env.sh – Clean Linux environment between LFCS exams

echo "[*] Removing common users and groups..."
for user in devadmin alice bob testuser; do
  sudo userdel -r "$user" 2>/dev/null
done

for group in devops engineers team1; do
  sudo groupdel "$group" 2>/dev/null
done

echo "[*] Unmounting and removing common mount points..."
sudo umount /mnt/data 2>/dev/null
sudo rm -rf /mnt/data /mnt/backup

echo "[*] Cleaning fstab entries..."
sudo sed -i '/\/mnt\/data/d' /etc/fstab
sudo sed -i '/\/mnt\/backup/d' /etc/fstab

echo "[*] Resetting hostname..."
sudo hostnamectl set-hostname lfcs-default

echo "[*] Stopping services..."
for svc in nginx httpd apache2; do
  sudo systemctl stop "$svc" 2>/dev/null
  sudo systemctl disable "$svc" 2>/dev/null
done

echo "[*] Cleaning logrotate config..."
sudo rm -f /etc/logrotate.d/nginx_access /etc/logrotate.d/custom_log

echo "[*] Cleaning symlinks and test logs..."
sudo rm -f /home/*/data_link /home/*/nginx.log /var/log/nginx/access.log

echo "[*] Cleaning crontabs..."
for user in devadmin alice; do
  sudo crontab -r -u "$user" 2>/dev/null
done

echo "[*] Resetting SSH config (if backup exists)..."
[ -f /etc/ssh/sshd_config.bak ] && sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config && sudo systemctl restart sshd

echo "[*] Resetting boot target to multi-user..."
sudo systemctl set-default multi-user.target

echo "[✓] Environment cleaned and ready for next exam."

