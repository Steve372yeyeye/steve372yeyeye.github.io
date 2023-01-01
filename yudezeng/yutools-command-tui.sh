#!/bin/bash
tui_api=2
menu(){
       input=$(whiptail --clear --title "Tyu Program Menu" --menu "选择你想干的事" 15 30 5 "1" "Proot 容器" "10" "退出"  3>&1 1>&2 2>&3)
       case $input in 
       1)proot_choose_auto_ui ;;
       10)exit 1;;
       *)exit 1;;
       esac
}
proot_choose_auto_ui(){
    input=$(whiptail --clear --title "Tyu Proot containers" --menu "选择你想安装的容器" 17 40 8 "1" "debian (auto)" "2" "ubuntu (auto)" "3" "Arch (auto)" "4" "Centos (auto)"  "5" "fedora (auto)" "6" "更多" "10" "退出"  3>&1 1>&2 2>&3)
case $input in
     1)echo Use Tyu Program;  echo "" ;tyu sinstall --system=debian --version=sid ;;
     2)echo Use Tyu Program;  echo "" ;tyu sinstall --system=ubuntu --version=kinetic ;;
     3)echo Use Tyu Program;  echo "" ;tyu sinstall --system=arch ;;
     4)echo Use Tyu Program;  echo "" ;tyu sinstall --system=centos --version=9-Stream ;;
     5)echo Use Tyu Program;  echo "" ;tyu sinstall --system=fedora --version=35;;
     6)proot_choose_more_ui;;
     10) exit 1 ;;
     esac
}
proot_choose_more_ui(){
    input=$(whiptail --clear --title "Tyu Proot containers" --menu "选择你想安装的容器" 18 40 8 "sid" "debian sid" "bookworm" "debian 12" "bullseye" "debian 11" "buster" "debian 10" "kinetic" "ubuntu 22.10 dev" "jammy" "ubuntu 22.04 " "impish" "ubuntu 21.10" "focal" "ubuntu 20.04" "bionic" "ubuntu 18.04" "xenial" "ubuntu 16.04" "exit" "退出"  3>&1 1>&2 2>&3)
    if [ $input = exit ];then exit 1;fi
    case $input in
    sid|bookworm|bullseye|buster)
    echo Use tyu Program
    tyu sinstall --system=debian --version=$input
    ;;
    *)
    echo Use tyu Program
    tyu sinstall --system=ubuntu --version=$input
    ;;
    esac
}
main(){
    case $1 in
    *)menu;;
    1)proot_choose_auto_ui;;
    2)proot_choose_more_ui;;
    3)linux_tools;;
    esac
}
main"$@"
