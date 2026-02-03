# Security Best Practices

## Checksums Verification

When downloading scripts from the internet, it's important to verify their integrity using checksums.

### How to Generate Checksums

```bash
# Download and generate checksum
curl -fsSL <url> | shasum -a 256

# Example for NVM
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | shasum -a 256
```

### Using Checksums in Scripts

The `download_and_verify` function in `common-functions.sh` supports checksum verification:

```bash
# Load checksums
source_versions

# Download and verify
download_and_verify \
    "https://example.com/install.sh" \
    "$SOME_INSTALL_CHECKSUM" \
    "temp_install.sh"

# Run if verification passed
bash temp_install.sh
rm temp_install.sh
```

### Maintaining Checksums

1. Update `checksums.env` when updating versions in `versions.env`
2. Generate new checksums for new installation sources
3. Document the command used to generate each checksum

### Example: Secure NVM Installation

```bash
#!/bin/bash
source common-functions.sh
source_versions

# Download with verification
download_and_verify \
    "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" \
    "$NVM_INSTALL_CHECKSUM" \
    "nvm_install.sh"

# Execute verified script
bash nvm_install.sh
rm nvm_install.sh
```

## Other Security Considerations

### Sensitive Files

The following are automatically ignored by `.gitignore`:
- `*.log` - Installation and runtime logs
- `.env*` - Environment files with secrets
- `secrets/` - Directory for sensitive data
- `*.key`, `*.pem` - Private keys

### GitHub Tokens

Never commit GitHub tokens or API keys. Use environment variables:

```bash
# In your shell profile
export GITHUB_TOKEN="your-token-here"

# In scripts, check if set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN not set"
    exit 1
fi
```

### SSH Keys

Generate separate SSH keys for different services:

```bash
# GitHub
ssh-keygen -t rsa -b 4096 -C "github@example.com" -f ~/.ssh/github_rsa

# Add to SSH config
cat >> ~/.ssh/config <<EOF
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa
EOF
```

## Audit Trail

All installation scripts create logs in `~/.workstation-logs/`:
- Timestamped log files for each run
- Includes success, skip, and error messages
- Helps troubleshoot installation issues
- Can be reviewed to verify what was installed

View logs:
```bash
ls -lh ~/.workstation-logs/
tail -f ~/.workstation-logs/install-*.log
```
