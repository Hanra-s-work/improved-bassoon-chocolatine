#!/bin/bash
# (c) Written by Henry Letellier

TRUE=1
FALSE=0

function yes_no_question {
    while true; do
        read -p "$1 [(Y)es/(n)o]: " yn
        case $yn in
        [Yy]*)
            return $TRUE
            break
            ;;
        [Nn]*)
            return $FALSE
            break
            ;;
        *)
            echo "Please enter yes or no."
            echo "You have entered: $yn"
            ;;
        esac
    done
}

function pause() {
    read -p "Pause... (Press enter to continue)"
}

function listify() {
    IFS=$2 read -r -a arr <<<"$1"
    echo "${arr[@]}"
}

function check_for_mac() {
    if command -v brew >/dev/null 2>&1; then
        brew install act
    elif command -v port >/dev/null 2>&1; then
        sudo port install act
    else
        echo "Unsupported macOS package manager"
        exit 1
    fi
    return 0
}

function check_for_linux() {
    if command -v yay >/dev/null 2>&1; then
        # AUR (Arch Linux)
        sudo yay -Syu act
    elif command -v dnf >/dev/null 2>&1; then
        # COPR (Fedora)
        sudo dnf install act
    elif command -v nix-env >/dev/null 2>&1; then
        # Nix (Linux/macOS)
        sudo nix-env -iA nixpkgs.act
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
    return 0
}

function check_for_windows() {
    if command -v choco >/dev/null 2>&1; then
        # Chocolatey (Windows)
        choco install act-cli
    elif command -v scoop >/dev/null 2>&1; then
        # Scoop (Windows)
        scoop install act
    elif command -v winget >/dev/null 2>&1; then
        # Winget (Windows)
        winget install nektos.act
    else
        echo "Unsupported Windows package manager"
        exit 1
    fi
    return 0
}

function check_system() {
    if [[ $(uname) == "Darwin" ]]; then
        # MacPorts (macOS)
        check_for_mac
    elif [[ $(uname) == "Linux" ]]; then
        check_for_linux
    elif [[ $(uname) == "MINGW"* ]]; then
        check_for_windows
    else
        echo "Unsupported operating system"
        exit 1
    fi
    return 0
}

function install_manually() {
    BIN=act_installer_data.sh
    echo "Installing act manually"
    echo "Fetching installer bash"
    curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh >$BIN
    echo "granting execution rights"
    chmod +x ./$BIN
    echo "Running installer"
    sudo ./$BIN
    echo "Moving act to /bin"
    cd bin
    BINARY=$(ls | grep act)
    mv $BINARY /usr/bin
    cd ..
    echo "Cleaning up"
    rm $BIN
    rm -rf bin
    return 0
}

function set_up_act() {
    echo "Setting up act"
    # first call is for the setup
    sudo act
}

function pull_required_images() {
    CONFIG_CONTENT="$(cat ~/.actrc -e)"
    FIRST_DOCKER="$(echo $CONFIG_CONTENT | cut -d '$' -f1 | cut -d '=' -f2)"
    echo "Pulling the first docker for act: '$FIRST_DOCKER'"
    sudo docker pull $FIRST_DOCKER
    yes_no_question "Do you wish to download the second image?"
    if [ $? -eq $TRUE ]; then
        SECOND_DOCKER="$(echo $CONFIG_CONTENT | cut -d '$' -f2 | cut -d '=' -f2)"
        echo "Pulling the first docker for act: '$SECOND_DOCKER'"
        sudo docker pull $SECOND_DOCKER
    fi
    yes_no_question "Do you wish to download the third image?"
    if [ $? -eq $TRUE ]; then
        THIRD_DOCKER="$(echo $CONFIG_CONTENT | cut -d '$' -f3 | cut -d '=' -f2)"
        echo "Pulling the first docker for act: '$THIRD_DOCKER'"
        sudo docker pull $THIRD_DOCKER
    fi
}

function pulling_required_images {
    echo "pulling_required_images"
    export DOCKER_HOST=$(docker context inspect --format '{{.Endpoints.docker.Host}}')
    sudo act
    pull_required_images
    # -P ubuntu-latest=catthehacker/ubuntu:full-latest
    # -P ubuntu-latest=catthehacker/ubuntu:full-20.04
    # -P ubuntu-18.04=catthehacker/ubuntu:full-18.04
}

function check_act() {
    if ! command -v act >/dev/null 2>&1; then
        echo "act is not installed"
        echo "Installing act"
        check_system
        yes_no_question "Did the act program install properly?"
        if [ $? -eq $FALSE ]; then
            echo "Installing act manually"
            install_manually
        fi
        set_up_act
        pulling_required_images
    fi
    return 0
}

function run_act() {
    echo "Running act"
    sudo act --help
    return 0
}

function before_we_start() {
    echo "Before we start"
    echo "Here are a few thing you need to know:"
    echo "* act requires docker to be up and running"
    echo ""
    echo "* Depending on the system, act may have difficulties downloading it's docker"
    echo "  this is why this program will download the docker for you"
    echo ""
    echo "* act queues up the yml files, regardless the location it is run in"
    echo ""
    echo "* If you need to pass any secrets to act, they need to be stored in a file name .secrets in the root of the folder"
    echo "  the file should be in the format of KEY=VALUE"
    echo ""
    pause
    return 0
}

function run_action() {
    echo "Running action"
    sudo act
}

before_we_start
check_act
run_action
