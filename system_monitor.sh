#!/bin/bash
echo -e "Fetching System Information...............\n" 



# --- Color Codes for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

print_info "=============== CPU and RAM Information ==========="
lscpu | head -20
echo "" 
print_info "=============== Process Status Report =========="
echo ""
top -bn1 | grep "Cpu(s)"
echo ""
