First, create the container (add --nvidia if using nvidia card)

```
distrobox create -n epitech-dev -i ubuntu:24.04 --hostname epitech-dev
```

Then, enter it, and install fzf and zoxide.
```
sudo apt install fzf zoxide
```

After that, exit the container, stop it, and re-enter it to finalize the initialization.

Then, update the container and install software-properties-common.
```
sudo apt update
sudo apt-get install software-properties-common
```

Finally, set up the dev environment by executing the distrobox-epitech.sh script as root inside of the container.