#!/bin/bash
add_private_ssh_key() {
  # Check if the user is signed in to 1Password
  if ! op whoami >/dev/null 2>&1; then
    echo "User is not signed in to 1Password."
    # Sign in to 1Password
    eval $(op signin)
    if [ $? -ne 0 ]; then
      echo "Failed to sign in to 1Password."
      return 1
    fi
  fi

  # Add 1Password account if not already added
  if ! op account list | grep -q "my"; then
    op account add
  fi

  # Retrieve private key and save it to file
  op read "op://private/github ssh key/private key" > ~/.ssh/github_private_key
  if [ $? -ne 0 ]; then
    echo "Failed to retrieve the private key."
    return 1
  fi

  # Set appropriate permissions on the private key file
  chmod 600 ~/.ssh/github_private_key

  # Add the private key to SSH agent
  ssh-add ~/.ssh/github_private_key
  if [ $? -ne 0 ]; then
    echo "Failed to add the private key to SSH agent."
    return 1
  fi

  echo "Private SSH key added successfully."
}
