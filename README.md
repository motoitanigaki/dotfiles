# git

```
git --version will encourage you to install git
```

# brew

- add brew
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- Add Homebrew to your PATH in /Users/motoitanigaki/.zprofile:
  ```
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/motoitanigaki/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  ```

# install from brew file

```
cd install
brew bundle
```

# install from cask file

```
brew bundle --file=Caskfile
```

# docker

```
softwareupdate --install-rosetta
install from docker hp
```

# macos

```
sh macos/defaults
```

# shell

```
sudo cat `which fish` >> /etc/shells
chsh -s `which fish`
```
