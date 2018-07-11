#!/bin/bash

if [ $(id -u) != "0" ]; then
    echo "[ERROR] You need to be root to run this script"
    exit -1
fi

function check_directory {
    dir=$1
    if [ ! -d "${dir}" ]; then
        echo "Create directory ${dir}"
        mkdir -p ${dir}
        if [ $? -ne 0 ]; then
            echo "[ERROR] error mkdir ${dir}"
            exit -1
        fi
    fi
}

function install {
    src=$1
    dst=$2
    dir=`dirname ${dst}`
    check_directory ${dir}
    cp ${src} ${dst}
    if [ $? -ne 0 ]; then
        echo "[ERROR] error install"
        exit -1
    fi
}

function link_install {
    src=$1
    dst=$2
    if [ "$(readlink ${dst})" == "${src}" ]; then
        return
    else
        rm -f ${dst}
    fi
    ln -s ${src} ${dst}
    if [ $? -ne 0 ]; then
        echo "[ERROR] error link_install"
        exit -1
    fi
}

app_name="forward_ctl"
hook_path="/etc/libvirt/hooks/qemu"
install_path="/usr/bin/${app_name}"

echo "Install ${app_name}..."

install forward_ctl ${install_path}
install qemu-hook ${hook_path}

echo "Done"
