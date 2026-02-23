# 🚀 DevOps Task 1: System Monitoring & Nginx Deployment

## 📋 Project Overview

This project automates system resource monitoring and web server deployment using Bash scripting. The script checks CPU, RAM, and disk usage, installs and configures Nginx, deploys HTML/CSS/JS files, and verifies the web server is running correctly.

---

## 📁 Project Structure

```
Devops-Tasks/
├── system_monitor.sh          # Main Bash automation script
├── web-files/                 # Web content directory
│   ├── index.html            # HTML5 page with canvas
│   └── script.js             # Spider web animation (VerletJS)
└── README.md                 # This file
```

---

## ✅ Prerequisites

- **Operating System:** Linux (Ubuntu/Debian recommended)
- **Permissions:** Root or sudo access
- **Network:** Internet connection (for package installation)
- **Tools:** Bash, curl, git

---

## 🎯 Execution Steps Explanation

### Step 1: Clone or Download the Repository

```bash
# Clone the repository (if using Git)
git clone <your-repository-url>
cd Devops-Tasks

# Or navigate to your project directory
cd /path/to/Devops-Tasks
```

**Explanation:** This step gets the project files onto your system and moves into the project directory.

---

### Step 2: Make the Script Executable

```bash
chmod +x system_monitor.sh
```

**Explanation:** The `chmod +x` command adds execute permissions to the script, allowing it to be run as a program.

---

### Step 3: Verify Web Files Exist

```bash
# Check if web-files directory exists
ls -la web-files/

# Should show:
# index.html
# script.js
```

**Explanation:** Ensures your HTML and JavaScript files are in place before deployment. The script will fail if this directory is missing.

---

### Step 4: Run the Script with Root Privileges

```bash
sudo ./system_monitor.sh
```

**Explanation:** 
- `sudo` - Runs the script with root (administrator) privileges
- `./` - Executes the file in the current directory
- The script requires root access to:
  - Install packages (apt-get)
  - Manage services (systemctl)
  - Write to /var/www/html

---

### Step 5: Verify the Script Execution

The script will automatically:

1. ✅ Display system information (CPU, RAM, Disk)
2. ✅ Check if Nginx is installed
3. ✅ Install Nginx if not present
4. ✅ Deploy web files to `/var/www/html`
5. ✅ Set correct file permissions
6. ✅ Start and enable Nginx service
7. ✅ Perform health check
8. ✅ Show access URLs

---

### Step 6: Access Your Website

After successful execution, you'll see output like:

```
[SUCCESS] ==============================================
[SUCCESS] All Tasks Completed Successfully!
[SUCCESS] ==============================================
[INFO] 🌐 Access your website:
[INFO]    Local:  http://localhost
[INFO]    Remote: http://192.168.1.100
```

**Open in browser:**
- From server: `http://localhost`
- From another computer: `http://<your-server-ip>`

---

### Step 7: Verify Deployment (Optional Commands)

```bash
# Check if Nginx is running
systemctl status nginx

# Check if files were deployed
ls -la /var/www/html/

# Test web server response
curl -I http://localhost

# View Nginx logs (if issues)
sudo tail -20 /var/log/nginx/access.log
sudo tail -20 /var/log/nginx/error.log
```

---

## 📸 Screenshots of Command Execution

### Screenshot 1: System Information (CPU, RAM, Disk)

**Location:** `./screenshots/system-info.png`

**What to capture:**
- CPU model and core count from `lscpu`
- CPU usage percentages from `top`
- RAM usage from `free -h`
- Disk space from `df -h`

**Command to generate:**
```bash
sudo ./system_monitor.sh | tee output.log
```

---

### Screenshot 2: Nginx Installation Process

**Location:** `./screenshots/nginx-install.png`

**What to capture:**
- "Nginx is not installed. Starting installation..." message
- apt-get update and install output
- "Nginx installed successfully" message
- Nginx version display

**Expected output:**
```
[INFO] Nginx is not installed. Starting installation...
Reading package lists... Done
Building dependency tree...
Setting up nginx...
[SUCCESS] Nginx installed successfully.
```

---

### Screenshot 3: Web Files Deployment

**Location:** `./screenshots/web-deployment.png`

**What to capture:**
- "Deploying Web Files" section
- Backup creation (if applicable)
- File copy confirmation
- Permission settings

**Expected output:**
```
[INFO] =============== Deploying Web Files ===============
[INFO] Backing up existing web files...
[INFO] Backup created: /var/www/html.backup.20250215_143022
[INFO] Copying web files to /var/www/html...
[SUCCESS] index.html deployed successfully.
[SUCCESS] script.js deployed successfully.
[SUCCESS] Permissions set correctly.
```

---

### Screenshot 4: Server Health Check & Access URLs

**Location:** `./screenshots/health-check.png`

**What to capture:**
- "Verifying Server" section
- HTTP 200 OK response
- Local and remote access URLs

**Expected output:**
```
[INFO] =============== Verifying Server ===============
[SUCCESS] ✓ Server is responding (HTTP 200)
[SUCCESS] ==============================================
[SUCCESS] All Tasks Completed Successfully!
[INFO] 🌐 Access your website:
[INFO]    Local:  http://localhost
[INFO]    Remote: http://192.168.1.100
```

---

### Screenshot 5: Website in Browser

**Location:** `./screenshots/website-browser.png`

**What to capture:**
- Browser showing the spider web animation
- Canvas filling the viewport
- Smooth animation running

**How to capture:**
1. Open browser
2. Navigate to `http://localhost` or `http://<server-ip>`
3. Press F12 (Developer Tools) to verify no errors in Console
4. Take screenshot showing the full page

---

## 🔧 Challenges and Solutions

### Challenge 1: Bash Syntax Error - `unexpected end of file`

**Problem:**
```bash
./system_monitor.sh: line 31: syntax error: unexpected end of file
```

**Root Cause:**
Missing closing bracket `}` for a function or `fi` for an if statement.

**Solution:**
- Carefully checked all function definitions
- Ensured every `if` has a matching `fi`
- Verified all `{` have matching `}`
- Used `bash -n script.sh` to check syntax before running

**Learning:**
Always validate bash syntax with `bash -n script.sh` before execution.

---

### Challenge 2: Invalid Redirect Syntax `$>`

**Problem:**
```bash
if command -v nginx $> /dev/null; then
# Error: $>: command not found
```

**Root Cause:**
`$>` is not valid bash syntax. The correct operator is `&>`.

**Solution:**
```bash
# ❌ Wrong
if command -v nginx $> /dev/null; then

# ✅ Correct
if command -v nginx &> /dev/null; then
```

**Learning:**
- `>` redirects stdout only
- `2>` redirects stderr only  
- `&>` redirects both stdout and stderr

---

### Challenge 3: Canvas Not Displaying (0x0 pixels)

**Problem:**
HTML page loaded but canvas was invisible.

**Root Cause:**
Canvas element had no CSS width/height, defaulting to 0x0 pixels.

**Solution:**
Added CSS to `index.html`:
```css
canvas#web {
    display: block;
    width: 100vw;
    height: 100vh;
}
```

**Learning:**
HTML5 canvas requires explicit dimensions via CSS or attributes.

---

### Challenge 4: JavaScript Not Loading (404 Error)

**Problem:**
Browser console showed: `GET http://localhost/script.js 404 (Not Found)`

**Root Cause:**
- script.js file not copied to `/var/www/html/`
- Or incorrect file path in HTML

**Solution:**
1. Verified file exists: `ls -la /var/www/html/script.js`
2. Checked HTML has correct path: `<script src="script.js">`
3. Ensured script copies files: `cp -r "$WEB_SOURCE_DIR"/* "$WEB_DEST_DIR/"`

**Learning:**
Always verify file deployment with `ls` and check browser DevTools Network tab.

---

### Challenge 5: Permission Denied (403 Forbidden)

**Problem:**
Website showed "403 Forbidden" error.

**Root Cause:**
Nginx (www-data user) couldn't read files due to incorrect permissions.

**Solution:**
```bash
# Set correct ownership
chown -R www-www-data /var/www/html

# Set correct permissions
chmod -R 755 /var/www/html
find /var/www/html -name "*.js" -o -name "*.css" -o -name "*.html" | xargs chmod 644
```

**Learning:**
- Web server user (www-data) needs read access
- Folders: 755 (rwxr-xr-x)
- Files: 644 (rw-r--r--)

---

### Challenge 6: Nginx Service Not Starting

**Problem:**
```bash
Job for nginx.service failed because the control process exited with error code.
```

**Root Cause:**
- Port 80 already in use by another service
- Configuration syntax error

**Solution:**
```bash
# Check what's using port 80
sudo netstat -tulpn | grep :80

# Check Nginx config syntax
sudo nginx -t

# View detailed error logs
sudo journalctl -xeu nginx.service
```

**Learning:**
Always check `nginx -t` before restarting and review logs with `journalctl`.

---

### Challenge 7: Minified JavaScript Errors

**Problem:**
Spider animation not working, browser console showed syntax errors.

**Root Cause:**
Minified JS code was corrupted during copy/paste (missing characters, line breaks).

**Solution:**
- Used original source code from GitHub instead of minified version
- Validated JS with JSHint (https://jshint.com/)
- Ensured proper file encoding (UTF-8)

**Learning:**
Avoid minified code for learning projects. Use readable source code and validate syntax.

---

## 📊 Script Features Summary

| Feature | Command/Technique | Purpose |
|---------|------------------|---------|
| **Color Output** | ANSI escape codes | Readable, colored terminal output |
| **Root Check** | `$EUID -ne 0` | Ensure script runs with sudo |
| **System Info** | `lscpu`, `free -h`, `df -h` | Display hardware resources |
| **CPU Usage** | `top -bn1 \| grep "Cpu(s)"` | Real-time CPU metrics |
| **Idempotency** | `command -v nginx` | Check before install (safe re-run) |
| **Backup** | `cp -r` with timestamp | Protect existing files |
| **Permissions** | `chown`, `chmod`, `find` | Security for web files |
| **Health Check** | `curl -w "%{http_code}"` | Verify server responds |
| **Error Handling** | `if/else`, `exit 1` | Graceful failure handling |

---

## 🛠️ Troubleshooting Guide

### Issue: Script won't run
```bash
# Check if file is executable
ls -l system_monitor.sh

# Make executable if needed
chmod +x system_monitor.sh
```

### Issue: "Permission denied" errors
```bash
# Always use sudo
sudo ./system_monitor.sh
```

### Issue: Website shows default Nginx page
```bash
# Check if files were copied
ls -la /var/www/html/

# Check file ownership
ls -la /var/www/html/index.html

# Reload Nginx
sudo systemctl reload nginx
```

### Issue: Blank page in browser
```bash
# Check browser console (F12 → Console tab)
# Look for 404 errors or JavaScript errors

# Verify files exist
cat /var/www/html/index.html
cat /var/www/html/script.js
```

### Issue: Animation not smooth
```bash
# Check browser performance (F12 → Performance tab)
# Ensure JavaScript is loading correctly
# Check for console errors
```

---

## 📝 Git Workflow

### Initialize Git Repository (if not done)
```bash
git init
git add .
git commit -m "Initial commit: System monitor script with Nginx deployment"
```

### After Making Changes
```bash
# Check what changed
git status

# Stage changes
git add system_monitor.sh web-files/ README.md

# Commit with descriptive message
git commit -m "Add CPU metrics table and fix nginx installation check"

# Push to remote (if configured)
git push origin main
```

### Create Screenshots Directory
```bash
mkdir -p screenshots
# Add your screenshots here
git add screenshots/
git commit -m "Add execution screenshots"
git push
```

---

## 🎓 Key Learnings

1. **Bash Scripting:**
   - Functions, conditionals, loops
   - File operations (cp, chmod, chown)
   - Output redirection (`>`, `&>`, `2>&1`)

2. **Linux System Administration:**
   - Package management (apt-get)
   - Service management (systemctl)
   - User permissions and ownership

3. **Web Server Deployment:**
   - Nginx installation and configuration
   - Virtual hosts and document roots
   - HTTP status codes and debugging

4. **DevOps Best Practices:**
   - Idempotent scripts (safe to re-run)
   - Backup before deployment
   - Health checks and monitoring
   - Error handling and logging

5. **Troubleshooting:**
   - Reading logs (`journalctl`, `/var/log/nginx/`)
   - Browser DevTools (Console, Network tabs)
   - Command-line diagnostics (`curl`, `netstat`, `nginx -t`)

---

## 📚 References

- **Bash Guide:** https://www.gnu.org/software/bash/manual/
- **Nginx Documentation:** https://nginx.org/en/docs/
- **VerletJS Library:** https://github.com/subprotocol/verlet-js
- **Linux Permissions:** https://www.linux.com/training-tutorials/understanding-linux-file-permissions/

---

## 👨‍ Author

**Alireza Ardani**  
DevOps Engineer in Training  
alireza.ardani.01@gmail.com  
https://github.com/AlirezaArdani

---

## 📄 License

This project is created for educational purposes as part of DevOps training.

---

## ✅ Checklist for Submission

- [x] Script runs without errors
- [x] Nginx installs and starts successfully
- [x] Web files deploy to correct location
- [x] Website accessible via browser
- [x] Screenshots captured for all stages
- [x] README.md completed with all sections
- [x] Git repository initialized and committed
- [x] Challenges documented with solutions

---

**Last Updated:** February 2026  
**Status:** ✅ Complete and Tested
