#!/bin/bash
sudo tar -cvWf /var/backups/home.tar /home*
sudo mv /var/backups/home.tar /var/backups/home.09232021.tar
sudo ls -lah /var/backups >> /var/backups/file_report.txt
free -h >> /var/backups/disk_report.txt
