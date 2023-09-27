# Windows Script Readme

## [Battery Charge Limiter](<battery limiter/readme.md>)

**Description:** This script lets you set the maximum battery charge level on your Windows machine, enhancing battery lifespan. It offers two options: using a .bat or .ps1 file.

**How It Works:** The script uses Windows PowerShell commands to adjust battery charge settings based on your input percentage.

**How to Use:**
- For .bat: Run as administrator.
- For .ps1: Run in PowerShell with admin privileges.

---

## [Firewall Rule Management](<firewall manager/readme.md>)

**Overview:** Manage Windows Firewall rules for .exe files. Choose to block or remove rules for .exe files in the script's directory, improving system security.

**Prerequisites:** Windows OS, admin privileges, basic script usage knowledge.

**How It Works:** Two scripts available: .bat (simple) and .ps1 (advanced). They detect .exe files in the script's directory and allow you to block or remove firewall rules.

**How to Use:**
- For .bat: Save in the directory with .exe files and run.
- For .ps1: Run in PowerShell with admin privileges, navigate to the script's directory, and execute.

---

## [TTL Setting Scripts](<ttl set/readme.md>)

**Description:** These scripts enable you to set the TTL (Time to Live) value on your Windows machine, affecting data packet lifetimes.

**How They Work:** Both scripts have a similar process: run as administrator, choose TTL (64, 128, or Custom), and set the chosen TTL value in the Windows Registry.

**How to Use:**
- For set_ttl.bat: Run as administrator and follow on-screen prompts.
- For set_ttl.ps1: Open PowerShell with admin rights, navigate to the script's folder, run with `.\set_ttl.ps1`, and follow on-screen prompts.

---

These scripts provide straightforward solutions to customize your Windows system settings.