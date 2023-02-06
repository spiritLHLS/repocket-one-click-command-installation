# repocket-one-click-command-installation

## Language

[English](README.md) | [中文文档](README_zh.md)

## **Introduction**

The repocket is an option that allows users to earn money by sharing your traffic.

You'll receive $0.10 for the 1G traffic you share, and this script supports data center network or home bandwidth.

**This platform is suspected to be faulty, I have a server flagged with automatic advertising behavior, deploy with caution, never on a production machine!**

This is the **first one-click installation script of the whole network** to automatically install dependencies and pull and install the latest docker, and the script will continue to be improved according to the platform update.

It has below features:

1. Automatically install docker based on the system, and if docker are already installed, it will not installed again.

2. Automatically select and build the pulled docker image according to the architecture, without the need for you to manually modify the official case.

3. Use Watchtower for automatic mirror update without manual update and re-entry of parameters.

(Watchtower is a utility that automates the updating of Docker images and containers. It monitors all running containers and related images, and automatically pulls the latest image and uses parameters when initially deployed to restart the corresponding container.)

## Notes

- Verified on AMD64 and ARM64
- Try it if you are interested via my --> [referrals](https://link.repocket.co/PBaK) <--, you will get 5 dollar.

## Install

### Interactive installation

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/repocket-one-click-command-installation/main/repocket.sh -o repocket.sh && chmod +x repocket.sh && bash repocket.sh
```

After the registration link is registered, remember the email and password, run this script, paste the email and password, and press Enter to start the installation.

### One command installation

```shell
curl -L https://raw.githubusercontent.com/spiritLHLS/repocket-one-click-command-installation/main/repocket.sh -o repocket.sh && chmod +x repocket.sh && bash repocket.sh -m youremail -p yourpassword
```

Change to your email and password of this command


## Uninstall

```shell
bash repocket.sh -u
```

uninstall service

## Experience

The IP type is home bandwidth and the income in Europe and the United States is relatively high, but it is still not very high. Currently, the sharing per day does not exceed 100M per 1 device.

## Disclaimer

This program is for learning purposes only, not for profit, please delete it within 24 hours after downloading, not for any commercial use. The text, data and images are copyrighted, if reproduced, please indicate the source.

Use of this program is subject to the deployment disclaimer. Use of this program is subject to the laws and regulations of the country where the server is deployed, the country where it is located, and the country where the user is located, and the author of the program is not responsible for any misconduct of the user.
