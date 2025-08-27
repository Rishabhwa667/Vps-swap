
# 🌀 VPS Swap Script

Easily add **swap memory** to your VPS with a single command!  
This script is lightweight, reliable, and works on most Linux distributions.

---

## 🚀 Quick Install

Run the following command on your VPS terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/Rishabhwa667/Vps-swap/refs/heads/main/swap.sh)
````

That’s it! 🎉 The script will handle everything automatically.

---

## 📖 What is Swap?

Swap is a portion of your storage (disk/SSD) that acts as **virtual RAM**.
It helps your server handle memory-intensive tasks when physical RAM is fully used.

✅ Prevents crashes due to low RAM
✅ Improves stability on small VPS instances
✅ Useful for Minecraft servers, databases, and apps

---

## ⚙️ Features

* 🔧 Automatically creates a **swap file**
* 📏 Supports **custom swap size** (script will ask during setup)
* 🔒 Secures the swap file with proper permissions
* 🔄 Adds swap permanently (works after reboot)
* ⚡ Fast and simple — only **one command required**

---

## 📌 Requirements

* Linux-based VPS (Ubuntu, Debian, CentOS, etc.)
* `curl` installed (usually pre-installed)

Install `curl` if missing:

```bash
sudo apt install curl -y   # Ubuntu/Debian
sudo yum install curl -y   # CentOS/RHEL
```

---

## 🔍 Verify Swap After Installation

Run the following to check swap memory:

```bash
swapon --show
free -h
```

You should see the new swap space listed. 🎯

---

## 🛠 Uninstall / Remove Swap

If you ever want to remove the swap file:

```bash
sudo swapoff /swapfile
sudo rm -f /swapfile
```

Also edit `/etc/fstab` and remove the swap entry.

---
