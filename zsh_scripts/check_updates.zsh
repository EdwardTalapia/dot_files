#!/bin/zsh
# note for EDAN : If you edit $PATH privs, you can get the files inside of a dir to work anywhere, hence not neeeding to switch users' pwd! NEAT-O

# TODO , make a function at somepoint that makes the color change easier to read :(
check_updates() {
    echo -n -e "\e[36mDo you want to check for updates? (y/N):\e[0m] "
    read answer
    answer="${answer:-n}" # Default to "n" if no input

    if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
        echo -e "\e[36mChecking for updates...\e[0m]"
        sudo apt update

        if apt list --upgradable 2>/dev/null | grep -q "upgradable"; then
            echo -e "\e[32mUpgrades are available for the following packages:\e[0m"
            apt list --upgradable
            echo -n "\e[36mWould you like to upgrade the packages? (y/N):\e[0m"
            read upgrade_answer
            upgrade_answer="${upgrade_answer:-n}" # Default to "n" if no input

            if [[ "$upgrade_answer" == "yes" || "$upgrade_answer" == "y" ]]; then
                echo "\e[32mUpgrading packages...\e[0m"
                sudo apt upgrade -y
            else
                echo -e "\e[31mUpgrade skipped.\e[0m"
            fi
        else
            echo "\e[32mNo upgrades available.\e[0m"
        fi
    else
        echo "\e[33mUpdate check skipped.\e[0m"
    fi
}
check_updates
