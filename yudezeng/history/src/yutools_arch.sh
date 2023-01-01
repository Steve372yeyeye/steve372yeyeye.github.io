#!/bin/bash
updated_(){
echo 检查软件更新
pacman -Syy
pacman -Syu git neofetch curl 
     menui
}
menui(){
opt=$(whiptail --clear --backtitle "It's running on GNU/Linux for Arch " --title "主菜单" --menu "请选择你要执行的功能" 18 48 8 "0" "安装yay(针对没有yay的arch rootfs)" "01" "小白模式(只用输入安装的程序包名)" "1" "换源" "2" "安装桌面(当前仅支持xfce4)(仅安装)" "3" "新建用户" "4" "containers工具(没有适配)" "5" "下载脚本到本地" "6" "检查更新" "7"  "切换默认语言为中文(set language)" "8" "仅配置VNC(暂未适配）"  "10" "退出"  3>&1 1>&2 2>&3)
case $opt in
1)
echo reset app software ..
archd=$(file /bin/bash)
if (whiptail --backtitle "yutools for arch" --title "set app software" --yes-button "x86_64" --no-button "arm64"  --yesno "请选择你的架构" 10 60)
then
sudo pacman -S pacman-mirrorlist
sudo pacman -Syy
else
sudo pacman -S pacman-mirrorlist
sudo pacman -Syy
fi
exit 1
;;
3)
echo 请输入用户名
read -p " " name
useradd -r -m $name
echo 输入新用户的密码
sudo passwd $name
echo 现在您可以输入su -l $name 进入$name用户了
exit 1
;;
2)
echo 如果出现选择按回车即可
pacman -Syu xfce4 xfce4-goodies dbus-x11 xfonts-100dpi 
pacman -Rsu xfce4-power-manager
exit 1
;;
4)
echo 暂时不支持此功能
#sudo apt install -y proot zstd pulseaudio
#main_
exit 1
;;
5)
dti
;;
6)
updated
;;
8)echo 暂时不支持此功能
exit 1
;;
7)
pacman -Syu noto-fonts-cjk
sed -i '/zh_CN.UTF/s/#//' /etc/locale.gen
locale-gen || /usr/sbin/locale-gen
sed -i '/^export LANG/d' /etc/profile
sed -i '1i\export LANG=zh_CN.UTF-8' /etc/profile
source /etc/profile
export LANG=zh_CN.UTF-8
exit 1
;;
10)
echo 退出
exit 1
;;
0)git clone https://gitee.com/yudezeng/proot_proc/
pacman -Syu pv
pv ./proot_proc/src/yay.tar.xz >>./yay.tar.xz
pacman -U ./yay.tar.xz
rm -rf yay.tar.xz
rm -rf proot_proc
exit 1
;;
01)
if (whiptail --backtitle "yutools for arch" --title "install or uninstall" --yes-button "安装软件包" --no-button "卸载软件包"  --yesno "你想要做什么？" 10 60) then 
PET=$(whiptail --title "安装软件包" --inputbox "请输入软件包名" 10 60 3>&1 1>&2 2>&3)
pacman -Syu $PET
else
PETR=$(whiptail --title "卸载软件包" --inputbox "请输入软件包名" 10 60 3>&1 1>&2 2>&3)
pacman -Rsu $PETR
fi
exit 1
;;
esac
}
#####
updated_ "$@"