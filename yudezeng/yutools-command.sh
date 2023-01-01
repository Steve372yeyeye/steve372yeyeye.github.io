#!/usr/bin/bash
api=6
version="v0.1.5"
date=$(date)
if ! [ $(uname -o) = Android ];then
syscoden=$(cat /etc/os-release | grep VERSION_CODENAME |awk -F'=' '{print $2}' )
info_sys=$(cat /etc/os-release | grep PRETTY_NAME |awk -F'=' '{print $2}')
export tyu_lib_path=/usr/local/lib/tyu
export tyu_path=/usr/local/bin/tyu
else
info_sys=Android
syscoden=termux
export tyu_lib_path=/data/data/com.termux/files/usr/lib/tyu
export tyu_path=/data/data/com.termux/files/usr/bin/tyu
fi
ui_lib_path=$tyu_lib_path/libtyutui.so
export tyu_conf_path=$tyu_lib_path/conf
if ! [ -e $tyu_conf_path ];then mkdir -pv $tyu_conf_path ;fi
DEF="https://mirrors.bfsu.edu.cn/lxc-images/images"
mirrors_1="https://mirrors.bfsu.edu.cn/"
mirrors_2="http://mirrors.bfsu.edu.cn/"
####
install_app(){
    if [ $packages_manager = failed ]
    then
    echo 您的软件包安装器本脚本不支持
    echo "请手动安装$packages_name"
    echo 再重新打开此脚本
    exit 1
    else
    echo "installing $packages_name"
    echo "using $packages_manager (system default)"
    echo
    $packages_manager $update_usage
    $packages_manager $install_usage $packages_name
    fi
}
remove_app(){
      if [ $packages_manager = failed ]
    then
    echo 您的软件包安装器本脚本不支持
    echo "请手动卸载$packages_name"
    echo 再重新打开此脚本
    exit 1
    else
    echo "removing $packages_name"
    echo "using $packages_manager (system default)"
    echo
    $packages_manager $remove_usage $packages_name
    fi
}
rechmod_(){
    input=$(whiptail --title "Tyu File Manager" --menu "请选择要对此文件(文件夹)赋予的权限\n当前文件(文件夹):$dir_or_file" 25 65 15 "1" "取消操作,并返回到上一级" "100" "仅允许所有者可执行" "200" "仅允许所有者可写" "300" "仅允许所有者可写、执行" "400" "仅允许文件所有 者可读" "500" "仅允许文件所有者可读、执行" "600" "仅允许文件所有者可读写" "700" "仅允许文件所有者对此文件拥有完整权限" "010" "仅允许用户组可执行" "020" "仅允许用户组可写" "030" "仅允许用户组可写、执行" "040" " 仅允许用户组可读" "050" "仅允许用户组可读、执行" "060" "仅允许用户组可读写" "070" "仅允许用户组对此文件拥有完整权限" "001" "仅允许其他用户可执行" "002" "仅允许其他用户可写" "003" "仅允许其他用户可写、执行" "004" "仅允许其他用户可读" "005" "仅允许其他用户可读、执行" "006" "仅允许其它用户可读写" "007" "仅允许其他用 户对此文件拥有完整权限" "111" "仅允许所有用户可执行" "222" "仅允许所有用户可写" "333" "所有用户不可读" "444" "仅允许所有用户可读" "555" "所有用户不可写" "666" "仅允许所有用户可读写" "777" "所有用户拥有完整权限" "740" "允许用户组拥有可读权限(文件所有者拥有完整权限)" "760" "允许用户组有拥可读写权限(文件所有者拥有完 整权限)" "770" "文件所有者和用户组拥有完整权限" "774" "允许其他用户拥有可读权限(文件所有者和用户组拥有完 整权限)" "776" "允许其他用户拥有可读写权限(文所有者和用户组拥有完整权限)" "000" "禁止所有用户对此文件进行操作" "0" "找不到你想要的? 手动输入吧" 3>&1 1>&2 2>&3 )
	 case $input in
	 1)
	 file_tool
	 ;;
	 0)
	 PET=$(whiptail --title "tyu File Manager" --inputbox "请输入你想更改权限的数字" 10 50 3>&1 1>&2 2>&3)
	 if [ -d "${file_name}" ];then
	 if (whiptail --title "Xbtool File Manager" --yes-button "是" --no-button "否"  --yesno "你是否要将此权限应用到子文件夹" 10 60) then    
chmod -R $PET $dir_or_file
else    
chmod -v $PET $dir_or_file
fi
else
chmod -v $PET $dir_or_file
fi
	 ;;
	 *)
	 if [ -d "${file_name}" ];then
	 if (whiptail --title "tyu File Manager" --yes-button "是" --no-button "否"  --yesno "你是否要将此权限应用到子文件夹" 10 60) then    
chmod -R $input $dir_or_file
else    
chmod -v $input $dir_or_file
fi
else
chmod -v $input $dir_or_file
fi
	 ;;
	 esac
}
rechown_(){
    input=$(whiptail --title "tyu File Manager" --menu "请选择要对此文件(文件夹)更改的所有者\n当前文件(文件夹):$dir_or_file" 25 65 15\
    "$(whoami)" "当前用户" "root" "超级用户" "0" "手动输入" "1" "取消操作,并返回到上一级" 3>&1 1>&2 2>&3 )
    case $input in
    0)
    PET=$(whiptail --title "Xbtool File Manager" --inputbox "请输入你想更改为所有者的用户名" 10 50 3>&1 1>&2 2>&3)
    chown -v $PET $dir_or_file
    ;;
    1)
    file_tool
    ;;
    *)
    chown -v $input $dir_or_file
    ;;
    esac
}
file_tool(){
    input=$(whiptail --title "Tyu File Manager" --menu "选择对此文件执行的操作\n当前文件：$dir_or_file" 20 50 9 \
	 "1" "改变此文件权限"\
	 "2" "编辑此文件(使用nano编辑器打开)"\
	 "3" "执行此文件(Shell脚本)"\
	 "4" "重命名此文件"\
	 "5" "移动此文件到指定目录"\
	 "6" "复制此文件到指定目录"\
	 "7" "改变此文件所有者"\
	 "8" "执行此文件(python)"\
	 "9" "执行此文件(二进制模式)"\
	 "10" "删除此文件"\
	 "0" "取消操作" \
     3>&1 1>&2 2>&3)
     case $input in
     1)
     rechmod_
     sleep 3s
     file_tool
     ;;
     2)
     if ! command -v nano ;then
     echo 请先安装nano
     echo 按回车继续
     read enter
     file_tool
     else
     nano $dir_or_file
     file_tool
     fi
     ;;
     3)
     bash $dir_or_file
     echo 已执行完毕
     sleep 4s
     file_tool
     ;;
     4)
     new_name=$(whiptail --title "Tyu File Manager" --inputbox "请输入你想更改文件的新名字" 10 50 3>&1 1>&2 2>&3)
     mv -v $dir_or_file ./$new_name
     echo 已执行完毕
     echo 按回车选择新文件
     read enter
     file_choose
     	dir_or_file=$file_path
		file_tool
     ;;
     5)
     echo "在接下来的界面输入你要移动到的文件夹(2秒后)"
     sleep 2s
     folder_choose
     mv -v $dir_or_file $folder_path
     sleep 1s
     file_choose
     	dir_or_file=$file_path
		file_tool
     ;;
     6)
       echo "在接下来的界面输入你要移动到的文件夹(2秒后)"
     sleep 2s
     folder_choose
     cp -v $dir_or_file $folder_path
     echo 执行完毕，请重新选择文件
     echo 2秒后继续
     sleep 2s
     file_choose
     	dir_or_file=$file_path
		file_tool
     ;;
     7)
     rechown_
     file_tool
     ;;
     8)
     if ! command -v python ;then
     echo 请先安装python
     echo 按回车键继续
     read enter
     file_tool
     else
     python ${file_path}
     echo 已执行完毕
     sleep 2s
     file_tool
     fi
     ;;
     9)
     chmod -v 777 ${file_path}
     ${file_path}
     echo 执行完毕
     sleep 4s
     file_tool
     ;;
     10)
     rm -rfv $file_path
     echo 已删除完毕
     read enter
     file_choose	
     dir_or_file=$file_path
		file_tool
     ;;
     0)
     echo 取消对此文件的操作
     file_choose
     	dir_or_file=$file_path
		file_tool
     ;;
     *)
     echo 您没有进行任何操作
     echo 将视为您的操作为退出
     ;;
     esac
}
update_tyu(){
    sleep 2s
    echo 从服务器获取版本信息
    api_s=$(curl https://steve372yeyeye.github.io/yudezeng/api)
    version_s=$(curl https://steve372yeyeye.github.io/yudezeng/version)
    sleep 2s
    echo
    echo 版本信息
    echo "#########################"
    echo "本地API：$api"
    echo "云端API ：$api_s"
    echo "本地版本号：$version"
    echo "云端版本号：$version_s"
    echo "#########################"
    echo
    echo 比对版本
    echo
    if [ $api_s -gt $api ]
    then
    echo "检测到您的版本较旧"
    echo
    echo "API从$api => $api_s"
    echo "版本号从$version => $version_s"
    echo
   #echo "正在尝试拉取更新日志"
   #echo $(curl https://steve372yeyeye.github.io/yudezeng/update_logs)
   #echo
    echo "您是否要更新？"
    echo "按回车键更新,Ctrl+C取消"
    read enter
    echo
    echo update this program to your system
    echo
    if ! command -v curl ;then
    echo "couldn't find curl program"
    echo will install it
    packages_name=curl
    echo
    install_app
    echo
    else
    echo "found program curl [OK]"
    fi
    echo get sources
    echo "==>curl -o tyu https://steve372yeyeye.github.io/yudezeng/yutools-command.sh"
    curl -o tyu https://steve372yeyeye.github.io/yudezeng/yutools-command.sh
    echo Generate file
    chmod 777 tyu
    if [ $(uname -o) = Android ] ;then
    mv -v tyu /data/data/com.termux/files/usr/bin/tyu
    chmod -v 777 /data/data/com.termux/files/usr/bin/tyu
    else
    mv -v tyu /usr/local/bin/tyu
    chmod -v 777 /usr/local/bin/tyu
    fi
    echo Update complete!
    echo Please execute tyu to run this program.
    else
    echo "您当前使用的版本是最新的"
    echo "已经获取到了新特性🙏"
    echo "即将退出"
    fi
}
Proot_command(){
    if ! command -v proot ;then
    packages_name=proot
    install_app
    fi
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name/tmp:/dev/shm --bind=$sys_name/etc/proc/vmstat:/proc/vmstat --bind=$sys_name/etc/proc/version:/proc/version --bind=$sys_name/etc/proc/uptime:/proc/uptime --bind=$sys_name/etc/proc/stat:/proc/stat --bind=$sys_name/etc/proc/loadavg:/proc/loadavg  --bind=$sys_name/etc/proc/bus/pci/00:/proc/bus/pci/00 --bind=$sys_name/etc/proc/devices:/proc/bus/devices --bind=$sys_name/etc/proc/bus/input/devices:/proc/bus/input/devices --bind=$sys_name/etc/proc/modules:/proc/modules   --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/data/data/com.termux/files/usr/tmp:/tmp --bind=/data/data/com.termux/files:$sys_name/termux --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin $command
}
new_folder(){
    echo 此功能暂未开放
    echo "结束执行自$(date)"
    exit 1
}
folder_choose(){
    folder_path=$(whiptail --title "tyu File Manager" --inputbox "请输入你想移动到的位置" 10 50 3>&1 1>&2 2>&3)
}
set_language(){
    echo 设置语言为中文
    echo "sed -i '/zh_CN.UTF/s/#//' /etc/locale.gen
locale-gen || /usr/sbin/locale-gen
sed -i '/^export LANG/d' /etc/profile
sed -i '1i\export LANG=zh_CN.UTF-8' /etc/profile
source /etc/profile">>setlang
 proot -0 mv -v setlang $sys_name/bin/setlang
    command="bash /bin/setlang"
    Proot_command
    unset command
   proot -0 rm $sys_name/bin/setlang
    proot -0 cp $tyu_path $sys_name/bin/tyu
    
    
}
set_sources_http(){
        mirror_dir1=" $version"
    mirror_dir2=" $version-updates"
    mirror_dir3=" $version-backports"
    if [ $version = buster ];then mirror_dir4=" $version/updates" ;else mirror_dir4=" $version-security" ;fi
    mirrors1="${mirrors_2}${mirror_path}/${mirror_dir1}${mirror_end}"
    mirrors2="${mirrors_2}${mirror_path}/${mirror_dir2}${mirror_end}"
    mirrors3="${mirrors_2}${mirror_path}/${mirror_dir3}${mirror_end}"
    mirrors4="${mirrors_2}${mirror_path}${opt}/${mirror_dir4}${mirror_end}"
     if [ $version = sid ];then echo "deb $mirrors1">>./sources.list ;else
    echo "deb $mirrors1
    deb $mirrors2
    deb $mirrors3
    deb $mirrors4">>./sources.list
    fi
    mv -v ./sources.list $sys_name/etc/apt/sources.list
}
set_sources_https(){
    mirror_dir1=" $version"
    mirror_dir2=" $version-updates"
    mirror_dir3=" $version-backports"
    if [ $version = buster ];then mirror_dir4=" $version/updates" ;else mirror_dir4=" $version-security" ;fi
    mirrors1="${mirrors_1}${mirror_path}/${mirror_dir1}${mirror_end}"
    mirrors2="${mirrors_1}${mirror_path}/${mirror_dir2}${mirror_end}"
    mirrors3="${mirrors_1}${mirror_path}/${mirror_dir3}${mirror_end}"
    mirrors4="${mirrors_1}${mirror_path}${opt}/${mirror_dir4}${mirror_end}"
    if [ $version = sid ];then echo "deb $mirrors1">>./sources.list ;else
    echo "deb $mirrors1
    deb $mirrors2
    deb $mirrors3
    deb $mirrors4">>./sources.list
    fi
    mv -v ./sources.list $sys_name/etc/apt/sources.list
}
set_sources_arch(){
    echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/'$mirror_path'/$arch/$repo
Server = https://mirrors.bfsu.edu.cn/'$mirror_path'/$arch/$repo'>>./mirrorlist
    mv -v ./mirrorlist $sys_name/etc/pacman.d/mirrorlist
    echo '[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
[arch4edu]
Server = https://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch'>>$sys_name/etc/pacman.conf
}
ARCH_(){
	case $(uname -m) in
		arm64|aarch*)
			echo "arm64"
			ARCH=arm64 ;;
		x86_64|amd64) 
			echo "amd64"
			ARCH=amd64 
			;;
		i*86|x86)
			echo "i386"
			ARCH=i386 
			;;
		armv7*|armv8l|arm|armhf)
			echo "armhf"
			ARCH=armhf ;;
		armv6*|armv5*|armel)
			echo "armel"
			ARCH=armel ;;
		ppc*)
			echo "ppc64el"
			ARCH=ppc64el ;;
		s390*)
			echo "s390x"
			ARCH=s390x ;;
		*)echo
esac
}
ARCH=$(ARCH_)
start_container(){
      echo starting your container
      echo 'mounting rootfs to /'
      echo 'mounting sysfs to /sys'
      echo 'mounting proc to /proc'
      echo 'mounting udev to /dev'
       bash $tyu_conf_path/start/proot/$2
}
list_container(){
    list=$(ls $tyu_conf_path/proot/ | sed 's/ //g' | cat -n | sed ":a;N;s/\n//g;ta")
    input=$(whiptail --clear --title "Tyu container list Menu" --menu "以下是您安装的容器" 15 30 5 "start" $list "end" 3>&1 1>&2 2>&3)
    start=$(cat $tyu_conf_path/proot/$input |grep 'start='|awk -F'=' '{ print $2 }')
    system_dir=$(cat $tyu_conf_path/proot/$input |grep 'system_dir='|awk -F'=' '{ print $2 }')
    pr_
}
pr_(){
    inputy=$(whiptail --clear --title "Tyu container tool" --menu "当前容器：$input" 15 30 5 "1" "启动此容器" "2" "删除此容器" "3" "查看启动脚本" "0" "退出"  3>&1 1>&2 2>&3)
       case $inputy in 
      1)bash $start
      pr_
       ;;
       2)proot -0 rm -rfv $system_dir $start ~/$input.sh $tyu_conf_path/proot/$input;rm -rfv $system_dir
       ;;
       3)nano $start 
       pr_;;
       10)exit 1;;
       *)exit 1;;
       esac
}
AUTOFIN(){
proot -0 rm $sys_name/etc/localtime
    proot -0 ln -s $sys_name/usr/share/zoneinfo/Asia/Shanghai $sys_name/etc/localtime
    case $system in
    ubuntu)
    case $ARCH in
    amd64|i386)
    mirror_path=ubuntu
    ;;
    *)
    mirror_path=ubuntu-ports
    ;;
    esac
   
    mirror_end=" main restricted universe multiverse"
    set_sources_http
    command='apt update'
    Proot_command
    unset command
    command='apt install -y wget curl nano apt-utils perl'
    Proot_command
    unset command
     if ! [ -e $sys_name/usr/bin/perl ];then  ln -s $sys_name/usr/bin/perl5.36.0 $sys_name/usr/bin/perl ;fi
    set_language
    echo 切换到https源
    set_sources_https
    command='apt update'
    Proot_command
    unset command
    ;;
    debian)
    mirror_path=debian
    opt='-security'
    mirror_end=" main contrib non-free"
    set_sources_http
    command='apt update'
    Proot_command
    unset command
    command='apt install -y wget curl nano apt-utils perl neofetch aria2 perl-base'
    Proot_command
    unset command
     if ! [ -e $sys_name/usr/bin/perl ];then proot -0 ln -s $sys_name/usr/bin/perl5.36.0 $sys_name/usr/bin/perl ;fi
    set_language
    echo 切换到https源
    command='apt install apt-transport-https ca-certificates -y'
    Proot_command
    unset command
    set_sources_https
    command='apt update'
    Proot_command
    unset command
    ;;
    arch* |archlinux |Arch*)
    case $ARCH in
    amd64 | i386)
    mirror_path=archlinux
    ;;
    arm*)
    mirror_path=archlinuxarm
    ;;
    esac
    set_sources_arch
    command='pacman -Syy'
    Proot_command
    unset command
    command='pacman --needed --noconfirm -Syu wget curl nano'
    Proot_command
    unset command
    set_language
    echo '设置文件系统目录权限(为保证pacman不会报错)'
    command='chmod -R 755 /usr /var /etc '
    Proot_command
    unset command
    command='chomd -R 440 /etc/sudoers'
    Proot_command
    unset command
    command='pacman --noconfirm -S sudo '
    Proot_command
    unset command
    ;;
    *)
    set_language
    ;;
    esac
}
SYS_DOWN() {
    input=$(whiptail --clear --title "create container menu" --menu "请选择您想要把容器存储在的目录" 15 30 5 "1" "当前用户目录" "2" "本工具的lib目录" "3" "本工具的配置目录" "4" "手动输入" "10" "退出"  3>&1 1>&2 2>&3)
       case $input in 
       1)sys=${HOME} ;;
       2) sys=${tyu_lib_path} ;;
       3) sys=${tyu_conf_path} ;;
       4) sys=$(whiptail --title "create container menu" --inputbox "请手动输入存储容器的目录" 10 50 "/data/data/com.termux/" 3>&1 1>&2 2>&3) ;;
       10)exit 1;;
       *)exit 1;;
       esac
    sleep 0.5s
    name=$(whiptail --title "create container menu" --inputbox "请输入容器名称" 10 50 "$version" 3>&1 1>&2 2>&3)
    sys_name="$sys/$name"
    echo "您的容器存储路径为${sys_name}"
    echo 
    DEF_CUR="${DEF}/${system}/${version}/${ARCH}/default/"
BAGNAME="rootfs.tar.xz"
echo 获取下载链接
sleep 0.5s
        if [ -e ${BAGNAME} ]; then
                rm -rf ${BAGNAME}
	fi
	if ! command -v curl ;then
	packages_name='curl command'
	install_app
	fi
	if ! command -v pv ;then
	packages_name='pv axel'
	install_app
	fi
	curl -o ${BAGNAME} ${DEF_CUR}
		VERSION=`cat ${BAGNAME} | grep href | tail -n 2 | cut -d '"' -f 4 | head -n 1`
		rm rootfs.tar.xz
		sleep 0.5s
		echo 
		if [[ ${VERSION} = "" ]];then
      whiptail --ok-button '检查命令是否有误' --title "错误" --msgbox "未找到rootfs!" 10 40 3>&2 2>&1 1>&3
      exit 1
    else
	echo "下载链接为 $DEF_CUR${VERSION}${BAGNAME}"
	fi
	echo 
		if ! command -v axel ;then
		sleep 0.5s
		echo "Couldn't find program axel"
		sleep 0.5s
		echo "Will install it"
		packages_name=axel
		install_app
		else
		sleep 1s
	echo "Found program axel [OK]"
	fi
	sleep 1s
		#aria2c -o ${BAGNAME} -x 4 -s 16 ${DEF_CUR}${VERSION}${BAGNAME}
		echo -e "下载rootfs"|pv -qL 40
		axel -o ${BAGNAME}  -n16  ${DEF_CUR}${VERSION}${BAGNAME}
		if [ $? -ne 0 ]; then
			echo -e "下载失败"
			echo 清理缓存即将退出
			rm rootfs.tar.xz*
			exit 1
		fi
		mkdir -pv $sys_name
#tar xvf rootfs.tar.xz -C ${BAGNAME}
if ! command -v xz ;then
packages_name=xz-utils
install_app
fi
echo "正在解压系统包"
	#tar xf ${BAGNAME} -C $sys_name 2>/dev/null
	pv ${BAGNAME} |tar xJf - -C $sys_name 2>/dev/null
                echo "$system系统已下载，文件夹名为$name"
                
                rm rootfs.tar.xz*
}
SYS_SET() {
    if ! command -v neofetch ;then
    packages_name=neofetch
    install_app
    fi
    neofetch >>./systeminfo.log
    hostinfo=$(cat ./systeminfo.log |grep Host |awk -F':' '{print $2}')
    rm ./systeminfo.log
	echo "更新DNS"
	sleep 1
	echo "127.0.0.1 localhost" > $sys_name/etc/hosts
	rm $sys_name/etc/hostname
	echo "$hostinfo" > $sys_name/etc/hostname
	echo "127.0.0.1 $hostinfo" > $sys_name/etc/hosts
	rm -rf $sys_name/etc/resolv.conf &&
	echo "nameserver 223.5.5.5
nameserver 223.6.6.6
nameserver 114.114.114.114" >$sys_name/etc/resolv.conf
echo "设置时区"
sleep 1
	echo "export  TZ='Asia/Shanghai'" >> $sys_name/root/.bashrc
	echo "export  TZ='Asia/Shanghai'" >> $sys_name/etc/profile
	echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name/etc/profile
	echo "export PULSE_SERVER=tcp:127.0.0.1:4173" >> $sys_name/root/bashrc
	echo "系统基础配置已完成,准备设置软件源"
	#echo 检测到你没有权限读取/proc内的所有文件
	#echo 将自动伪造新文件
	mkdir proot_proc
	wget  -O ./proot_proc/proc.tar.xz -o tmp https://steve372yeyeye.github.io/yudezeng/proot_proc/proc.tar.xz
	rm tmp
	sleep 1
	mkdir tmp
	#echo 正在解压伪造文件
	tar xJf proot_proc/proc.tar.xz -C tmp 
	cp -r tmp/usr/local/etc/tmoe-linux/proot_proc tmp/
	sleep 1
	#echo 复制文件
	cp -r tmp/proot_proc $sys_name/etc/proc
	sleep 1
	#echo 删除缓存
	rm proot_proc tmp -rf
	if grep -q 'ubuntu' "$sys_name/etc/os-release" ; then
        touch "$sys_name/root/.hushlogin"
fi
}
FIN(){
if ! [ -e $tyu_conf_path/proot ];then mkdir $tyu_conf_path/proot ;fi
echo "system_dir=$sys_name" > $tyu_conf_path/proot/$name
echo "system_name=$name" > $tyu_conf_path/proot/$name
echo "写入启动脚本"
#echo "为了兼容性考虑已将内核信息伪造成5.17.18-perf"
sleep 1
echo '#!/usr/bin/env bash
unset LD_PRELOAD
set -- "${@}" "--bind=/vendor"
set -- "${@}" "--bind=/system" 
set -- "${@}" "--bind=/data/data/com.termux/files:/media/termux"
set -- "${@}" "--bind=/storage"
set -- "${@}" "--bind=/storage/self/primary:/sdcard"
set -- "${@}" "--bind=/proc:/proc"
set -- "${@}" "--mount='$sys_name'/etc/proc/stat:/proc/stat"
        set -- "${@}" "--mount='$sys_name'/etc/proc/version:/proc/version"
            set -- "${@}" "--mount='$sys_name'/etc/proc/bus:/proc/bus"
            set -- "${@}" "--mount='$sys_name'/etc/proc/buddyinfo:/proc/buddyinfo"
            set -- "${@}" "--mount='$sys_name'/etc/proc/cgroups:/proc/cgroups"
            set -- "${@}" "--mount='$sys_name'/etc/proc/consoles:/proc/consoles"
            set -- "${@}" "--mount='$sys_name'/etc/proc/crypto:/proc/crypto"
            set -- "${@}" "--mount='$sys_name'/etc/proc/devices:/proc/devices"
            set -- "${@}" "--mount='$sys_name'/etc/proc/diskstats:/proc/diskstats"
            set -- "${@}" "--mount='$sys_name'/etc/proc/execdomains:/proc/execdomains"
            set -- "${@}" "--mount='$sys_name'/etc/proc/fb:/proc/fb"
            set -- "${@}" "--mount='$sys_name'/etc/proc/filesystems:/proc/filesystems"
            set -- "${@}" "--mount='$sys_name'/etc/proc/interrupts:/proc/interrupts"
            set -- "${@}" "--mount='$sys_name'/etc/proc/iomem:/proc/iomem"
            set -- "${@}" "--mount='$sys_name'/etc/proc/ioports:/proc/ioports"
            set -- "${@}" "--mount='$sys_name'/etc/proc/kallsyms:/proc/kallsyms"
            set -- "${@}" "--mount='$sys_name'/etc/proc/keys:/proc/keys"
            set -- "${@}" "--mount='$sys_name'/etc/proc/key-users:/proc/key-users"
           #set -- "${@}" "--mount='$sys_name'/etc/proc/kmsg:/proc/kmsg"
            set -- "${@}" "--mount='$sys_name'/etc/proc/kpageflags:/proc/kpageflags"
            set -- "${@}" "--mount='$sys_name'/etc/proc/loadavg:/proc/loadavg"
            set -- "${@}" "--mount='$sys_name'/etc/proc/locks:/proc/locks"
            set -- "${@}" "--mount='$sys_name'/etc/proc/misc:/proc/misc"
            set -- "${@}" "--mount='$sys_name'/etc/proc/modules:/proc/modules"
            set -- "${@}" "--mount='$sys_name'/etc/proc/pagetypeinfo:/proc/pagetypeinfo"
            set -- "${@}" "--mount='$sys_name'/etc/proc/partitions:/proc/partitions"
            set -- "${@}" "--mount='$sys_name'/etc/proc/sched_debug:/proc/sched_debug"
            set -- "${@}" "--mount='$sys_name'/etc/proc/softirqs:/proc/softirqs"
            set -- "${@}" "--mount='$sys_name'/etc/proc/timer_list:/proc/timer_list"
            set -- "${@}" "--mount='$sys_name'/etc/proc/uptime:/proc/uptime"
            set -- "${@}" "--mount='$sys_name'/etc/proc/vmallocinfo:/proc/vmallocinfo"
            set -- "${@}" "--mount='$sys_name'/etc/proc/vmstat:/proc/vmstat"
            set -- "${@}" "--mount='$sys_name'/etc/proc/zoneinfo:/proc/zoneinfo"
set -- "${@}" "--bind=/sys"
set -- "${@}" "--bind=/dev"
#set -- "${@}" "--bind=/data/data/com.termux/files/usr/tmp:/tmp"
set -- "${@}" "--kernel-release=5.17.18-perf"
set -- "${@}" "--sysvipc" "--link2symlink" "--kill-on-exit" "--rootfs='$sys_name'/" "--root-id" "--cwd=/root" "-L" "/usr/bin/env" "-i" "HOME=/root" "LANG=zh_CN.UTF-8" "TERM=xterm-256color" "/bin/su" "-l" "root"
set -- "proot" "${@}"
exec "${@}"' > $sys_name.sh
echo "授予启动脚本执行权限"
sleep 1
chmod +x $sys_name.sh
if ! [ -e $tyu_conf_path/start ];then mkdir $tyu_conf_path/start ;mkdir $tyu_conf_path/start/proot ;fi
cp $sys_name.sh $tyu_conf_path/start/proot/$name
rm $sys_name.sh
ln -s $tyu_conf_path/start/proot/$name ~/$name.sh
echo "start=$tyu_conf_path/start/proot/$name" > $tyu_conf_path/proot/$name
if [ -e ${PREFIX}/etc/bash.bashrc ]; then
	if ! grep -q 'pulseaudio' ${PREFIX}/etc/bash.bashrc; then
		sed -i "1i\pkill -9 pulseaudio" ${PREFIX}/etc/bash.bashrc
	fi
else
	sed -i "1i\pkill -9 pulseaudio" $sys_name.sh
fi 
echo -e "$system系统已安装，文件夹名为$name,存储路径为:$sys_name,您可以使用./$name.sh来启动此系统"
}
install_menu_(){
input=$(whiptail --title "Tyu installer" --menu "选择安装" 15 60 6 \
"1" "终端界面" \
"2" "更换软件源地址(如果软件源速度慢建议)" \
"3" "安装终端界面到系统PATH变量"  \
"4" "安装tyu本体" 3>&1 1>&2 2>&3)
case $input in 
1)if ! [ -f $ui_lib_path ];then echo 'Downloading UI sources' ;echo 'please wait';curl -o libtyutui.so -L steve372yeyeye.github.io/yudezeng/yutools-command-tui.sh
    if [ $(uname -o) = Android ] ;then
    mkdir -v /data/data/com.termux/files/usr/lib/tyu
    mv -v libtyutui.so /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    chmod -v 777 /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    else
    mkdir -v /usr/local/lib/tyu
    mv -v libtyutui.so /usr/local/lib/tyu/libtyutui.so
    chmod -v 777 /usr/local/lib/tyu/libtyutui.so
    fi
    fi
    sleep 2s
    install_menu_
;;
2)
if ! [ $(uname -o) = Android ] ;then
version=$syscoden
set_sources_http
else
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirror.nju.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list &&apt update
fi
sleep 2s
install_menu_
;;
3)if ! [ -f $ui_lib_path ];then echo 'Downloading UI sources' ;echo 'please wait';curl -o libtyutui.so -L steve372yeyeye.github.io/yudezeng/yutools-command-tui.sh
    if [ $(uname -o) = Android ] ;then
    mkdir -v /data/data/com.termux/files/usr/lib/tyu
    mv -v libtyutui.so /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    chmod -v 777 /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    else
    mkdir -v /usr/local/lib/tyu
    mv -v libtyutui.so /usr/local/lib/tyu/libtyutui.so
    chmod -v 777 /usr/local/lib/tyu/libtyutui.so
    fi
    fi
    echo "api_ts='$(curl -L steve372yeyeye.github.io/yudezeng/tui_api)'
    api_t='$(cat $ui_lib_path|grep tui_api | awk -F'=' '{print $2}' )'
    if [ $api_ts -gt ${api_t}  ]
    then  echo 'Upgrading UI sources' 
    echo 'please wait'
    curl -o libtyutui.so -L steve372yeyeye.github.io/yudezeng/yutools-command-tui.sh  
    if [ $(uname -o) = Android ] ;then
    mkdir -v /data/data/com.termux/files/usr/lib/tyu
    mv -v libtyutui.so /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    chmod -v 777 /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    else
    mkdir -v /usr/local/lib/tyu
    mv -v libtyutui.so /usr/local/lib/tyu/libtyutui.so
    chmod -v 777 /usr/local/lib/tyu/libtyutui.so
    fi
    fi
    bash /usr/local/lib/tyu/libtyutui.so
    ">tyui
      if [ $(uname -o) = Android ] ;then
    mv -v tyui /data/data/com.termux/files/usr/bin/tyui
    chmod -v 777 /data/data/com.termux/files/usr/bin/tyui
    else
    mv -v tyui /usr/local/bin/tyui
    chmod -v 777 /usr/local/bin/tyui
    fi
    echo 通过tyui打开终端界面
    sleep 3s
    install_menu_
;;
esac
}
file_choose(){
    echo 操作已完成即将退出
    exit 1
}
help(){ 
    echo "用法:"
    echo "tyu [options]"
    echo
    echo '选项:'
    echo 'opentui 启动内置的tui交互界面'
    echo 'starts (容器名称) 启动此容器系统'
    #echo 'stopc (容器名称) 卸载此容器(仅支持chroot)'
    echo 'list 查看所有已安装的proot容器'
    echo "sinstall --system=(系统名称) --version=(系统代号或版本号) 安装proot容器系统"
    #echo "cinstall --system=(系统名称) --version=(系统代号或版本号) 安装chroot容器系统"
    echo 'install [软件包名] 安装新软件'
    echo 'remove [软件包名] 卸载软件'
    echo 'update 更新软件源数据仓库'
    echo 'update-app 更新本程序'
    echo 'adb [adb option] 调用adb执行adb命令 (最多同时使用五个选项)'
    echo 'apair [主机IP地址:端口号] [配对码] 适用于安卓手机开发者设置中的无线调试'
    echo 'aconnect [主机IP地址:端口号] 适用于连接无线调试'
    echo 'adevices 查看已连接的adb设备'
    echo 'ashell 使用adb shell'
    echo "file_tool -file_path:(文件路径) 对该文件进行一些操作"
    echo
    echo
    echo 
    echo '提示:'
    echo "系统代号可以为系统版本(除了ubuntu，arch和debian系统)"
    echo "如果对此方面一窍不通，您可以使用tyu opentui使用tui来选择你要安装的系统"
    echo 
    echo "以下为具体举例演示"
    echo
    echo "安装Centos:"
    echo "tyu sinstall --system=centos --version=9-Stream"
    echo 如果你想安装Arch linux
    echo 请执行
    echo 'tyu sinstall --system=arch(or Archlinux)'
}
main_(){
        if ! [ -d ~/.config ];then mkdir ~/.config ;fi
        if ! [ -f ~/.config/yutools_off_date ];then if ! [ -d ~/.config/yutools_off_date ];then rm -rf ~/.config/yutools_off_date ;touch ~/.config/yutools_off_date ;fi;else last_off_date=$(cat ~/.config/yutools_off_date) ;fi
    off_date=$date
    rm ~/.config/yutools_off_date
    echo $off_date >>~/.config/yutools_off_date
    chmod 777 ~/.config/yutools_off_date
    sleep 2s
    if ! [ -f $tyu_path ] ;then
    echo "警告:没有检测到本工具安装到系统"
    echo "帮助内的功能将无法使用"
    echo 建议您执行:
    echo 'bash -c "$(curl https://steve372yeyeye.github.io/yudezeng/yutools-command.sh)"install-to-system'
    echo 来安装到系统
    echo
    fi
    if [ -f ~/.config/yutools_off_date ];then echo "上次运行时间 ${last_off_date}" ;fi
    echo "开始自$date"
    echo "Program version:$version"
    echo "Powered by finish"  
    echo
    echo 正在检查软件包管理器
    sleep 2s
    echo 配置程序调用命令
 case $(neofetch |grep Packages|awk -F: '{ print $2 }') in
*dpkg*)
packages_manager='apt'
install_usage='install -y'
remove_usage='autoremove -y'
update_usage='update'
;;
*pacman*)
packages_manager='pacman'
install_usage='--noconfirm --needed -Syu'
remove_usage='--noconfirm -Rsc'
update_usage='--noconfirm -Syy'
;;
*rpm*)
packages_manager='dnf'
install_usage='install -y'
remove_usage='remove -y'
update_usage='update'
;;
*)
if ! command -v neofetch ;then
echo 检查到关键依赖缺失
echo 开始尝试安装
apt update
if ! apt install -y neofetch ;then
if ! pacman --noconfirm -Syu neofetch ;then
if ! dnf install -y neofetch ;then
echo 安装失败，请手动安装neofetch
fi
fi
fi
bash -c "$(curl -L steve372yeyeye.github.io/yudezeng/yutools-command.sh)"install-to-system
else
echo 发生错误
echo 软件包安装管理器本工具未识别
packages_manager=failed
fi
;;
esac
echo "All done."
echo
    case $1 in
    sinstall)
    version=$(echo $3 |grep version |awk -F'=' '{ print $2 }')
    system=$(echo $2 |grep system |awk -F'=' '{ print $2 }')
    
      echo 正在检测互联网连接
    if ! wget -O tmp -o tmp https://www.baidu.com ;then
    if ! command -v wget ;then
    packages_name=wget 
    install_app
    clear
    main_
    fi
    echo 无法连接到互联网
    echo 某些功能将无法执行
    echo 建议您连接互联网之后再使用
    echo 退出
    exit 1
    rm tmp 2>/dev/null
    else
    rm tmp
    echo 您已成功连接到互联网
    fi
    sleep 1s
    echo 开始读取配置信息
    sleep 2s
    echo "宿主系统为：$info_sys"
    echo "架构为：$ARCH"
    echo "将要安装的系统为：${system}"
    sleep 0.5s
    case $system in
    arch*|Arch*)
    systemu=archlinux
    versionu=current
    unset system
    unset version
    system=$systemu
    version=$versionu
    ;;
    esac
    sleep 0.5s
    #echo "系统代号为${version}"
    sleep 0.5s
    echo 即将开始下载安装
    sleep 0.5s
    echo 将自动寻找rootfs链接
    sleep 0.5s
    SYS_DOWN
    echo 设置系统
    SYS_SET
    sleep 1s
    AUTOFIN
    sleep 1s
    FIN
    sleep 1s
;;
    install)
    packages_name="$2 $3 $4 $5"
    install_app
    ;;
    remove)
    packages_name="$2 $3 $4 $5"
    remove_app
    ;;
    starts)
    start_container "$@"
    ;;
    stopc)
    stop_container "$@"
    ;;
    list)
    list_container
    ;;
    sremove)
    remove_container "$@"
    ;;
    update)
    echo
      echo "Updating package warehouse"
    echo "using $packages_manager (system default)"
    $packages_manager $update_usage
    echo Done.
    ;;
    update-app)
    update_tyu
    ;;
    file_tool)
    dir_or_file=$(echo $2 |grep file_path |awk -F: '{ print $2 }')
    sleep 2s
    if ! [ -f $dir_or_file ];then
    sleep 1s
    echo 
    echo "警告:您选择的文件不是有效的文件(可能是一个文件夹)"
    echo "你想创建$dir_or_file文件吗?"
    read -p "1)创建
2)不要,继续
3)退出
请选择:" input
    case $input in 
    1) if [ -d $dir_or_file ];then
    if [ -f $dir_or_file/* ];then
    echo 检测到此文件夹内含有文件
    echo 可能有重要文件
    echo 终止操作
    exit 1
    else
    echo 将删除此文件夹
    rm -rv $dir_or_file
    touch $dir_or_file
    fi
    else
    touch $dir_or_file
    fi
    ;;
    2)
    echo 
    ;;
    3)
    exit 1
    ;;
    esac
    fi
    echo 
    if ! command -v whiptail ;then
    echo "couldn't find whiptail program"
    echo "will install it"
    packages_name=whiptail
    install_app
    else
    echo "Found whiptail program [OK]"
    fi
    echo
    sleep 1s
    file_tool
    ;;
    adb)
    if ! command -v adb ;then
    echo could not find adb program
    echo will try install
    packages_name=android-tool
    install_app
    packages_name=adb
    install_app
    packages_name=android-tools
    install_app
    fi
    adb $2 $3 $4 $5 $6 $7 $8 $9
    ;;
    apair)
      if ! command -v adb ;then
    echo could not find adb program
    echo will try install
    packages_name=android-tool
    install_app
   packages_name=adb
    install_app
    packages_name=android-tools
    install_app
    fi
    adb pair $2 $3
    ;;
    aconnect)
      if ! command -v adb ;then
    echo could not find adb program
    echo will try install
    packages_name=android-tool
    install_app
    packages_name=adb
    install_app
    packages_name=android-tools
    install_app
    fi
    adb connect $2
    ;;
    ashell)
      if ! command -v adb ;then
    echo could not find adb program
    echo will try install
    packages_name=android-tool
    install_app
    packages_name=adb
    install_app
    packages_name=android-tools
    install_app
    fi
    adb shell $2 $3 $4 $5 $6 $7 $8 $9 
    ;;
    -h*|--h*|help)
    help
    ;;
    set-sources)
    sleep 2s
    echo 正在检测互联网连接
    if ! wget -O tmp -o tmp https://www.baidu.com ;then
    if ! command -v wget ;then
    packages_name=wget 
    install_app
    clear
    main_
    fi
    echo 无法连接到互联网
    echo 某些功能将无法执行
    echo 建议您连接互联网之后再使用
    echo 退出
    exit 1
    rm tmp 2>/dev/null
    else
    rm tmp
    echo 您已成功连接到互联网
    fi
    sleep 1s
    version=$syscoden
    echo
    echo 开始更换软件源
      case $info_path in
    ubuntu)
    case $ARCH in
    amd64|i386)
    mirror_path=ubuntu
    ;;
    *)
    mirror_path=ubuntu-ports
    ;;
    esac
    esac
    set_sources_https
    ;;
    install-to-system)    
    whiptail --ok-button '继续' --title "Tyu installer" --msgbox "欢迎使用Tyu安装程序" 10 40 3>&2 2>&1 1>&3
    sleep 2s
    whiptail --ok-button '继续' --title "Tyu installer" --msgbox "准备检查网络,请确保你的网络连接正常" 10 40 3>&2 2>&1 1>&3
    echo '==> 正在检测互联网连接 <=='
    if ! wget -O tmp -o tmp https://www.baidu.com ;then
    if ! command -v wget ;then
    packages_name=wget 
    install_app
    echo reset start 
    bash -c "$(curl -L steve372yeyeye.github.io/yudezeng/yutools-command.sh)"install-to-system
    fi
    echo 无法连接到互联网
    echo 无法继续执行安装
    echo 建议您连接互联网之后再使用
    echo 退出
    exit 1
    rm tmp 2>/dev/null
    else
    rm tmp
    echo 您已成功连接到互联网-
    fi
    sleep 2s
    install_menu_
    sleep 1s
    whiptail --ok-button '继续' --title "Tyu installer" --msgbox "即将开始安装" 10 40 3>&2 2>&1 1>&3
    
    echo
    echo install this program to your system
    echo
    if ! command -v curl ;then
    echo "couldn't find curl program"
    echo will install it
    packages_name=curl
    echo
    install_app
    echo
    else
    echo "found program curl [OK]"
    fi
    echo get sources
    curl -o tyu https://steve372yeyeye.github.io/yudezeng/yutools-command.sh
    echo Generate file
    chmod 777 tyu
    if [ $(uname -o) = Android ] ;then
    mv -v tyu /data/data/com.termux/files/usr/bin/tyu
    chmod -v 777 /data/data/com.termux/files/usr/bin/tyu
    else
    mv -v tyu /usr/local/bin/tyu
    chmod -v 777 /usr/local/bin/tyu
    fi
    echo installation is complete!
    echo Please execute tyu to run this program
    ;;
    opentui)
    
    if ! [ -f $ui_lib_path ];then echo 'Downloading UI sources' ;echo 'please wait';curl -o libtyutui.so -L steve372yeyeye.github.io/yudezeng/yutools-command-tui.sh
    if [ $(uname -o) = Android ] ;then
    mkdir -v /data/data/com.termux/files/usr/lib/tyu
    mv -v libtyutui.so /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    chmod -v 777 /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    else
    mkdir -v /usr/local/lib/tyu
    mv -v libtyutui.so /usr/local/lib/tyu/libtyutui.so
    chmod -v 777 /usr/local/lib/tyu/libtyutui.so
    fi
    fi
    api_ts=$(curl -L //steve372yeyeye.github.io/yudezeng/tui_api) 
    api_t=$(cat $ui_lib_path|grep tui_api | awk -F'=' '{print $2}' )
    if [ $api_ts -gt ${api_t}  ]
    then  echo 'Upgrading UI sources' 
    echo 'please wait'
    curl -o libtyutui.so -L //steve372yeyeye.github.io/yudezeng/yutools-command-tui.sh  
    if [ $(uname -o) = Android ] ;then
    mkdir -v /data/data/com.termux/files/usr/lib/tyu
    mv -v libtyutui.so /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    chmod -v 777 /data/data/com.termux/files/usr/lib/tyu/libtyutui.so
    else
    mkdir -v /usr/local/lib/tyu
    mv -v libtyutui.so /usr/local/lib/tyu/libtyutui.so
    chmod -v 777 /usr/local/lib/tyu/libtyutui.so
    fi
    fi
    bash $ui_lib_path $2
    ;;
    *)
    echo 没有此命令
    echo
    help
    ;;
    esac  
    off_date=$date
    rm .config/yutools_off_date
    echo $off_date >>./.config/yutools_off_date
    chmod 777 ./.config/yutools_off_date
    exit 1
}
main_ "$@"