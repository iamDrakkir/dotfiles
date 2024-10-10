#!/bin/bash
# ------------------------------------------------------
# Function to detect package manager
# ------------------------------------------------------
_detectPackageManager() {
    if command -v yay &> /dev/null; then
        echo "yay"
    elif command -v nala &> /dev/null; then
        echo "nala"
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    else
        echo "none"
    fi
}

# ------------------------------------------------------
# Function to prompt for confirmation
# ------------------------------------------------------
_confirm() {
    read -p "$1 [y/N]: " response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# ------------------------------------------------------
# Function to prompt for input
# ------------------------------------------------------
_input() {
    read -p "$1: " response
    echo "$response"
}

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
if _confirm "DO YOU WANT TO START THE UPDATE NOW?"; then
    echo
    echo ":: Update started."
else
    echo
    echo ":: Update canceled."
    exit
fi

package_manager=$(_detectPackageManager)

# ------------------------------------------------------
# Create a snapshot if timeshift is installed
# ------------------------------------------------------
if command -v timeshift &> /dev/null; then
    if _confirm "DO YOU WANT TO CREATE A SNAPSHOT?"; then
        echo
        c=$(_input "Enter a comment for the snapshot")
        sudo timeshift --create --comments "$c"
        sudo timeshift --list
        case "$package_manager" in
            "yay"|"apt")
                sudo grub-mkconfig -o /boot/grub/grub.cfg
                ;;
            "dnf")
                sudo grub2-mkconfig -o /boot/grub2/grub.cfg
                ;;
        esac
        echo ":: DONE. Snapshot $c created!"
        echo
    else
        echo ":: Snapshot canceled."
    fi
else
  echo "Timeshift is not installed. Skipping snapshot creation."
fi

# ------------------------------------------------------
# Perform the system update
# ------------------------------------------------------
case "$package_manager" in
    "yay")
        yay
        ;;
    "nala")
        sudo nala update && sudo nala upgrade -y
        ;;
    "apt")
        sudo apt update && sudo apt upgrade -y
        ;;
    "dnf")
        sudo dnf update -y
        ;;
    *)
        echo "Unsupported package manager."
        exit 1
        ;;
esac

notify-send "Update complete"
echo
echo ":: Update complete"
sleep 2

