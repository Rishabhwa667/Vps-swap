#!/bin/bash

# Swap File Path
SWAP_FILE="/swapfile"

# Function to display options
display_menu() {
    echo "Select Swap Size:"
    echo "1) 128MB"
    echo "2) 256MB"
    echo "3) 512MB"
    echo "4) 1GB"
    echo "5) 2GB"
    echo "6) 4GB"
    echo "7) 8GB"
    echo "8) 16GB"
    echo "9) 32GB"
    echo "10) 64GB"
    echo "0) Exit"
}

# Get user choice
while true; do
    display_menu
    read -p "Enter choice (0-10): " choice

    case $choice in
        1) SWAP_SIZE_MB=128 ;;
        2) SWAP_SIZE_MB=256 ;;
        3) SWAP_SIZE_MB=512 ;;
        4) SWAP_SIZE_MB=1024 ;;
        5) SWAP_SIZE_MB=2048 ;;
        6) SWAP_SIZE_MB=4096 ;;
        7) SWAP_SIZE_MB=8192 ;;
        8) SWAP_SIZE_MB=16384 ;;
        9) SWAP_SIZE_MB=32768 ;;
        10) SWAP_SIZE_MB=65536 ;;
        0) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice, please enter a valid option."; continue ;;
    esac
    break
done

# Check if swap already exists
if sudo swapon --show | grep -q "$SWAP_FILE"; then
    echo "Swap file already exists. Removing existing swap..."
    sudo swapoff $SWAP_FILE
    sudo rm -f $SWAP_FILE
fi

echo "Creating a ${SWAP_SIZE_MB}MB swap file..."

# Create swap file
if ! sudo fallocate -l ${SWAP_SIZE_MB}M $SWAP_FILE; then
    echo "fallocate failed, using dd instead..."
    sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=$SWAP_SIZE_MB status=progress
fi

# Set correct permissions
sudo chmod 600 $SWAP_FILE

# Format as swap
sudo mkswap $SWAP_FILE

# Enable swap
sudo swapon $SWAP_FILE

# Make it persistent
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab
fi

# Optimize swap usage
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swap.conf
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.d/99-swap.conf
sudo sysctl --system

echo "Swap setup complete! By ArialNodes Team!"
free -h
