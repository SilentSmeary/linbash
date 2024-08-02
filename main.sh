sudo rm -rf temp-downloads
sudo mkdir temp-downloads
cd temp-downloads

pwd

# Function to check if nala is installed
check_nala() {
    if command -v nala &> /dev/null; then
        return 0
    else
        echo "Nala is required and will be installed"
        sudo apt install nala
        if [ $? -ne 0 ]; then
            echo "Nala installation failed. Exiting..."
            exit 1
        fi
    fi
}

# Function to display the main menu
main_menu() {
    echo "______________________________________"
    echo "[1] Initial Setup"
    echo "[2] Full System Update"
    echo "[3] Software Install"
    echo "[4] Software Setups"
    echo "[0] Exit"
}

# Function to display the software install menu
software_install_menu() {
    echo "______________________________________"
    echo "[1] Zed Code Editor"
    echo "[2] Visual Studio Code"
    echo "[3] Github Desktop"
    echo "[0] Back to Main Menu"
}

# Function to handle main menu user's choice
main_menu_read_choice() {
    local choice
    read -p "Enter choice: " choice
    case $choice in
        1)
            bash scripts/initial_software.sh
            ;;
        2)
            sudo nala update
            sudo nala upgrade -y
            ;;
        3)
            software_install_menu
            software_install_read_choice
            ;;
        4)
            echo "Current directory: $(pwd)"
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice, please select a valid option"
            ;;
    esac
}

# Function to handle software install menu user's choice
software_install_read_choice() {
    local software_choice
    read -p "Enter choice: " software_choice
    case $software_choice in
        1)
            curl -fsSL https://zed.dev/install.sh | sh
            ;;
        0)
            return
            ;;
        *)
            echo "Invalid choice, please select a valid option"
            ;;
    esac
}

# Main script execution
if check_nala; then
    while true; do
        main_menu
        main_menu_read_choice
        echo ""
    done
else
    echo "Nala is not installed and could not be installed. Exiting..."
    exit 1
fi
