#!/bin/bash
echo "Installations"

UPDATED="Update"
CLEANER="Cleaning"
INSTALL="Install"
CHMOD="Access Permissions"
INFORMATION="Ports | Networking"
UFW="Uncomplicated Firewall"
LOGOUT="Reboot"
CHECK="Package Dependencies to Install"

accessPermission() {
    sleep 2
    echo -e "\n###### ${CHMOD} ######  "
    read -p "Do you want to set file permissions? (y/n) " permissionResult
    if [[ $permissionResult == "y" || $permissionResult == "Y" ]]; then
        echo -e "File permissions are being set... "
        
        ls -al
        ls -l countdown.sh

        sudo chmod +x ./countdown.sh
        sudo chmod +x ./docker_tomcat.sh

        sudo ./countdown.sh
    else
        echo -e "File permissions were not set..."
    fi
}
accessPermission

updated() {
    sleep 2
    echo -e "\n###### ${UPDATED} ######  "
    
    echo -e "Please choose an update option:\n1-) update\n2-) upgrade\n3-) dist-upgrade\n4-) Exit "
    read choice

    case $choice in
        1)
            read -p "Do you want to update the system list? (y/n) " listUpdatedResult
            if [[ $listUpdatedResult == "y" || $listUpdatedResult == "Y" ]]; then
                echo -e "Updating list... "
                sudo ./countdown.sh
                sudo apt-get update
            else
                echo -e "System list update was not performed"
            fi
            ;; 
        2)
            read -p "Do you want to upgrade the system packages? (y/n) " systemListUpdatedResult
            if [[ $systemListUpdatedResult == "y" || $systemListUpdatedResult == "Y" ]]; then
                echo -e "Upgrading system packages... "
                sudo ./countdown.sh
                sudo apt-get update && sudo apt-get upgrade -y
            else
                echo -e "System package upgrade was not performed... "
            fi
            ;; 
        3)
            read -p "Do you want to update the kernel? (y/n) " kernelUpdatedResult
            if [[ $kernelUpdatedResult == "y" || $kernelUpdatedResult == "Y" ]]; then
                echo -e "Updating kernel... "
                sudo ./countdown.sh
                sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
                sudo apt list --upgradable | grep linux-image
            else
                echo -e "Kernel update was not performed... "
            fi
            ;;
        *)
            echo -e "Please select one of the provided options"
            ;;
    esac
}
updated

logout() {
    sleep 2
    echo -e "\n###### ${LOGOUT} ######  "
    read -p "Do you want to reboot the system? (y/n) " logoutResult
    if [[ $logoutResult == "y" || $logoutResult == "Y" ]]; then
        echo -e "Rebooting system... "
        sudo ./countdown.sh
        sudo apt update
        clean
        sudo reboot
    else
        echo -e "System was not rebooted..."
    fi
}
logout

theFirewallInstall() {
    sleep 2
    echo -e "\n###### ${UFW} ######  "
    read -p "Do you want to install the firewall? (y/n) " ufwResult
    if [[ $ufwResult == "y" || $ufwResult == "Y" ]]; then
        echo -e "Installing firewall rules, port permissions, and IP address permissions... "
        sudo ./countdown.sh
        netstat -nlptu
        sleep 3
        echo -e "######### UFW (Uncomplicated Firewall) #########\n"
        sudo apt install ufw -y
        sudo ufw status
        sudo ufw default allow outgoing
        sudo ufw allow ssh
        sudo ufw allow 22
        sudo ufw allow 80
        sudo ufw allow 443
        sudo ufw allow 1111
        sudo ufw allow 2222
        sudo ufw allow 8000
        sudo ufw allow 3333
        sudo ufw allow 8080
        sudo ufw allow 9000
        sudo ufw allow from 127.0.0.1 to any port 8080
        sudo ufw enable
        sudo ufw status
    else
        echo -e "Firewall was not enabled... "
    fi
}
theFirewallInstall

theFirewallDelete() {
    sleep 2
    echo -e "\n###### ${UFW} ######  "
    read -p "Do you want to disable the firewall? (y/n) " ufwCloseResult
    if [[ $ufwCloseResult == "y" || $ufwCloseResult == "Y" ]]; then
        echo -e "Disabling firewall, closing ports, and network access... "
        sudo ./countdown.sh
        netstat -nlptu
        sleep 3
        echo -e "######### UFW (Uncomplicated Firewall) #########\n"
        sudo ufw status
        sudo ufw default deny incoming
        sudo ufw delete allow ssh
        sudo ufw delete allow 22
        sudo ufw delete allow 80
        sudo ufw delete allow 443
        sudo ufw delete allow 1111
        sudo ufw delete allow 2222
        sudo ufw delete allow 8000
        sudo ufw delete allow 3333
        sudo ufw delete allow 8080
        sudo ufw delete allow 9000
        sudo ufw delete allow from 127.0.0.1 to any port 8080
        sudo ufw disable
        sudo ufw status
    else
        echo -e "Firewall settings were not disabled... "
    fi
}
theFirewallDelete

check_package() {
    sleep 2
    echo -e "\n###### ${CHECK} ######  "
    read -p "Do you want to install package dependencies for the system? (y/n) " checkResult
    if [[ $checkResult == "y" || $checkResult == "Y" ]]; then
        echo -e "Installing package dependencies... "
        sudo ./countdown.sh
        echo -e "Current directory => $(pwd)\n"
        sleep 1
        echo -e "######### Package Dependencies #########\n"
        read -p "Please enter the package name you want to install (e.g., nginx): " user_input
        dependency "$user_input"
    else
        echo -e "Package dependencies were not installed... "
    fi
}

dependency() {
    local packagename=$1
    sudo apt-get check
    sudo apt-cache depends $packagename
    sudo apt-get install $packagename
}

install() {
    sleep 2
    echo -e "\n###### ${INSTALL} ######  "
    read -p "Do you want to install general packages for the system? (e.g., vim, curl, etc.) (y/n) " commonInstallResult
    if [[ $commonInstallResult == "y" || $commonInstallResult == "Y" ]]; then
        echo -e "Starting general installation... "
        sudo ./countdown.sh
        echo -e "Current directory => $(pwd)\n"
        sleep 1
        sudo apt-get install vim -y
        sudo apt-get install curl -y
        sudo apt-get install openssh-server -y
        sudo apt install build-essential wget zip unzip -y
        theFirewallInstall
        theFirewallDelete
    else
        echo -e "General installation was not performed..."
    fi
}
install

packageInstall() {
    sleep 2
    echo -e "\n###### ${INSTALL} ######  "
    read -p "Do you want to install packages for nginx, monitoring, etc.? (y/n) " packageInstallResult
    if [[ $packageInstallResult == "y" || $packageInstallResult == "Y" ]]; then
        echo -e "Starting package installation... "
        sudo ./countdown.sh
        echo -e "Current directory => $(pwd)\n"
        sleep 1
        echo -e "######### Nginx #########\n"
        check_package
        sudo apt-get install nginx -y
        sudo systemctl start nginx
        sudo systemctl enable nginx
        curl localhost:80
        sudo ./countdown.sh
        echo -e "######### Monitoring #########\n"
        sudo apt install htop iftop net-tools -y
    else
        echo -e "Nginx and monitoring packages were not installed... "
    fi
}
packageInstall

information() {
    sleep 2
    echo -e "\n###### ${INFORMATION} ######  "
    read -p "Do you want to view system information? (y/n) " informationResult
    if [[ $informationResult == "y" || $informationResult == "Y" ]]; then
        echo -e "Displaying system information..."
        sudo ./countdown.sh
        echo -e "Who am I? => $(whoami)\n"
        sleep 1
        echo -e "Network Information => $(ifconfig)\n"
        sleep 1
        echo -e "Port Information => $(netstat -nlptu)\n"
        sleep 1
        echo -e "Linux Information => $(uname -a)\n"
        sleep 1
        echo -e "Distribution Information => $(lsb_release -a)\n"
        sleep 1
        echo -e "Disk Information => $(df -m)\n"
        sleep 1
        echo -e "CPU Information => $(cat /proc/cpuinfo)\n"
        sleep 1
        echo -e "RAM Information => $(free -m)\n"
        sleep 1
    else
        echo -e "System information was not displayed"
    fi
}
information

clean() {
    sleep 2
    echo -e "\n###### ${CLEANER} ######  "
    read -p "Do you want to clean unnecessary packages from the system? (y/n) " cleanResult
    if [[ $cleanResult == "y" || $cleanResult == "Y" ]]; then
        echo -e "Cleaning unnecessary packages... "
        sudo ./countdown.sh
        echo -e "######### Clean #########\n"
        sudo apt-get autoremove -y
        sudo apt autoclean
        echo -e "Installing broken dependencies... "
        sudo apt install -f
    else
        echo -e "Cleaning was not performed..."
    fi
}
clean

portVersion() {
    zip -v
    unzip -v+
    gcc --version
    g++ --version
    make --version
}
portVersion
