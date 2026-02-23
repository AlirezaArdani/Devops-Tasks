#!/bin/bash
echo -e "Fetching System Information...............\n" 



# --- Color Codes for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


# Function to print status messages
print_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}
print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}
print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}
# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "Please run as root (use sudo)"
    exit 1
fi

print_info "${PURPLE}=============== CPU Information ===============${NC}\n"
lscpu | head -20
echo "" 
print_info "${PURPLE}=============== Process Status Report ===============${NC}\n"
echo ""
top -bn1 | grep "Cpu(s)"
echo ""
# --- Display CPU Metrics Explanation Table ---
print_info "${CYAN}=============== CPU Metrics Explanation ===============${NC}\n"
printf "%-10s %-15s %-40s\n" "Metric" "Full Name" "Description"
printf "%-10s %-15s %-40s\n" "------" "---------" "-----------"
printf "%-10s %-15s %-40s\n" "us" "User" "Time spent on user applications"
printf "%-10s %-15s %-40s\n" "sy" "System" "Time spent on kernel processes"
printf "%-10s %-15s %-40s\n" "ni" "Nice" "Time on processes with altered priority"
printf "%-10s %-15s %-40s\n" "id" "Idle" "Time spent idle (doing nothing)"
printf "%-10s %-15s %-40s\n" "wa" "IO Wait" "Time waiting for I/O operations"
printf "%-10s %-15s %-40s\n" "hi" "Hardware IRQ" "Time servicing hardware interrupts"
printf "%-10s %-15s %-40s\n" "si" "Software IRQ" "Time servicing software interrupts"
printf "%-10s %-15s %-40s\n" "st" "Steal" "Time stolen by hypervisor (VMs only)"
echo ""
print_info "${PURPLE}===============RAM Usage Information ===============${NC}\n"
free -h
echo ""
print_info "${PURPLE}=============== DISK Space Information ===============${NC}\n"
lsblk 
echo "------------------------------------------------------------------"
df -h
echo ""
print_success "${GREEN}=============== System Resources Checked ===============${NC}\n"

echo -e "Starting NginX Service...............\n" 
print_info "${PURPLE}=============== Nginx Installation Check ===============${NC}"

# check id nginx installed or not
if command -v nginx $> /dev/null; then
    print_success "NginX is already installed!"
    NGINX_VERSION=$(nginx -v 2>&1)
    print_info "${CYAN}Version: $NGINX_VERSION${NC}"
else
    print_info "NginX is not installed. Starting installation..."
    apt-get update > /dev/null 
    
    if apt-get install -y nginx; then
    	nginx -v
    	print_success "${GREEN}NginX installed successfully.${NC}" 	
    else
    	print_error "${RED} Failed to install NginX${NC}"
    	exit 1
    fi
fi
# --- Create Simple HTML Page ---
print_info "${PURPLE}=============== Deploying HTML Page ===============${NC}"







