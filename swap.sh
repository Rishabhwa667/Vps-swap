#!/bin/bash

set -e
SCRIPT_VERSION="V 0.1"

clear
echo
echo "**********************************************"
echo "* Swap File Creation Script @ $SCRIPT_VERSION *"
echo "* Project by ArialNodes Development          *"
echo "**********************************************"
echo
echo "1. 128 MB SWAP"
echo "2. 256 MB SWAP"
echo "3. 512 MB SWAP"
echo "4. 1 GB SWAP"
echo "5. 2 GB SWAP"
echo "6. 4 GB SWAP"
echo "7. 8 GB SWAP"
echo "8. 16 GB SWAP"
echo "9. 32 GB SWAP"
echo "10. 64 GB SWAP"
echo "11. 128 GB SWAP"
echo "12. 256 GB SWAP"
echo "13. Close / Cancel"
echo
read -p "Please enter a number (1-13): " choice

# Define swap size options
declare -A swap_sizes=(
    ["1"]="128M"
    ["2"]="256M"
    ["3"]="512M"
    ["4"]="1G"
    ["5"]="2G"
    ["6"]="4G"
    ["7"]="8G"
    ["8"]="16G"
    ["9"]="32G"
    ["10"]="64G"
    ["11"]="128G"
    ["12"]="256G"
)

# Function to create swap
create_swap() {
    local SIZE=$1
    echo "Creating $SIZE swap file..."
    
    # Remove existing swap
    sudo swapoff -a
    sudo rm -f /swapfile

    # Create and enable new swap
    sudo fallocate -l "$SIZE" /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    # Make swap permanent
    sudo cp /etc/fstab /etc/fstab.bak
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null

    echo "Swap of $SIZE successfully created and enabled!"
    cat /proc/sys/vm/swappiness
}

# Process user input
if [[ $choice =~ ^[1-12]$ ]]; then
    create_swap "${swap_sizes[$choice]}"
elif [[ $choice == "13" ]]; then
    echo "Canceling..."
    exit 0
else
    echo "Invalid input. Please enter a number between 1 and 13."
    exit 1
fi
