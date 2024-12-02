# What is the purpose of this script?

This script is designed to automate the process of switching between different SSH keys for **GitHub** accounts on your macOS machine. It simplifies the process of managing multiple SSH keys by providing a single command to switch between them.

---

# How to use it

### 1. Clone this repository with the following command:

```bash
git clone https://github.com/alex-xtomas/change_ssh_key.git
```

---

### 2. Open the file change_ssh_key.sh and add the name of the SSH's key you want to use as work or personal.

```bash
WORK_KEY="id_rsa_my_work_key"
PERSONAL_KEY="id_rsa_my_personal_key"
```

---

### 3. ** Make the script executable **

Run the following command to make the script executable::

```bash
chmod +x change_ssh_key.sh
```

---

### 4. **Create an Alias**

Add the alias to your shell configuration file (`~/.bashrc`, `~/.zshrc`, or equivalent):

```bash
alias change_ssh_key="/path/to/change_ssh_key.sh"
```

Reload the shell configuration:

```bash
source ~/.bashrc  # or ~/.zshrc
```

---

### 5. **Usage**

Run the command with the appropriate key argument:

- To switch to your work key:
  ```bash
  change_ssh_key --key work
  ```
- To switch to your personal key:
  ```bash
  change_ssh_key --key personal
  ```

---

### How It Works:

1. The script accepts the `--key` or `-k` argument to determine which key to use.
2. Based on the argument, it:
   - Adds the correct SSH key to the macOS keychain using `ssh-add`.
   - Updates the `~/.ssh/config` file to set the `IdentityFile` to the chosen key.
3. It ensures the configuration is updated correctly and confirms the change.
