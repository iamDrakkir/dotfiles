# Dotfiles

This repository contains my personal configuration files (dotfiles) for various tools and applications. These dotfiles help to set up a consistent development environment across different machines.


## Installation

To install the dotfiles, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/iamDrakkir/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ```

2. **Run the installation script**:
    ```bash
    ./install.sh
    ```

### install TODO:
- [ ] switch to eza

### wifi 6e to swedish:
- [ ] echo "options cfg80211 ieee80211_regdom=SE"|sudo tee /etc/modprobe.d/cfg80211.conf

## Usage

After installation, the dotfiles will be symlinked to the appropriate locations in your home directory. You can customize them further by editing the files directly.
