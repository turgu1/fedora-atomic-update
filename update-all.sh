#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "====== Starting Unified System Update ======"

# 1. Update Flatpak Applications and Runtimes
if command -v flatpak &> /dev/null; then
    echo -e "\n📦 Updating Flatpaks (System & User)..."
    flatpak update -y
else
    echo -e "\n⚠️ Flatpak not found. Skipping."
fi

# 2. Update Toolbox Containers
if command -v toolbox &> /dev/null; then
    echo -e "\n------ Detecting and updating Toolbox containers... ------"
    
    # Get a list of all existing toolbox container names
    # Skips the header line from 'toolbox list'
    containers=$(toolbox list -c | awk 'NR>1 {print $2}')

    if [ -z "$containers" ]; then
        echo "No Toolbox containers found."
    else
        for container in $containers; do
            echo "-> Updating container: $container"
            # Runs 'dnf update' inside the container without manual intervention
            toolbox run -c "$container" sudo dnf update -y
        done
    fi
else
    echo -e "\n⚠️ Toolbox not found. Skipping."
fi

# 3. Update the Base Atomic OS and Layered Packages
if command -v rpm-ostree &> /dev/null; then
    echo -e "\n------ Checking for rpm-ostree updates... ------"
    # Fetches changes and stages them if updates are available
    rpm-ostree upgrade
else
    echo -e "\n⚠️ rpm-ostree not found. Skipping."
fi

echo -e "\n====== Update Process Complete ======"
echo "Note: If rpm-ostree staged a new deployment, please reboot your system to apply it."
