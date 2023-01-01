#!/usr/bin/bash
stv=v0.6.0
srv=12
PATHG=$(uname -o)
echo 检查依赖

apt install proot curl git neofetch -y
echo "正在处理最后的一点事情"
git clone https://gitee.com/yudezeng/proot_proc 
clear
echo 正在检查最新的版本号
version=$(cat proot_proc/version)
larv=$(cat proot_proc/ord)
sleep 1
echo 检测到最新版本为version $version
sleep 1
echo 当前版本为$stv
if [ $larv -gt $srv ]
then
gitbut=1
echo 当前版本需要升级
echo 您可以在主菜单手动更新
else
gitbut=0
echo 本地版本为最新版本
echo 将无需升级
fi
rm -rf proot_proc
sleep 2
clear
echo version v0.6.0
echo 添加了对ubuntu/debian的支持
echo 对部分界面添加了交互界面的改动
echo 修改了部分界面的显示布局
echo "centos跨架构(arm64模拟x64)已经可以正常使用"
echo 出现报错属于正常现象
echo 本作者暂未修复报错
echo 修复了已知bug
sleep 1
echo 请阅读以上内容
echo 将在1秒后加载功能
sleep 2
clear
     if [ $gitbut = 1 ]
     then 
     echo 您的版本需要更新
     echo 建议您立刻更新
     echo 输入update即可立即更新
     fi

ARCH_(){
	case $(dpkg --print-architecture) in
		arm64|aarch*)
			echo "arm64"
			ARCH=arm64 ;;
		x86_64|amd64) 
			echo "amd64"
			ARCH=amd64 
			mkdir .x
			;;
		i*86|x86)
			echo "i386"
			ARCH=i386 
			mkdir .x 
			;;
		armv7*|armv8l)
			echo "armhf"
			ARCH=armhf ;;
		armv6*|armv5*)
			echo "armel"
			ARCH=armel ;;
		ppc*)
			echo "ppc64el"
			ARCH=ppc64el ;;
		s390*)
			echo "s390x"
			ARCH=s390x ;;
		*) echo "不被识别"
		echo -e "\nexit...\n"
		sleep 1
		exit ;;
esac
}
ARCH_qp=$(ARCH_)
#####################

SYS_SELECT() {
	echo -e "请选择系统
	1) debian
	2) ubuntu
	3) kali
	4) centos
	5) arch
	6) fedora
	7) 从本地安装
	0) 退出"
read -r -p "请选择:" input
case $input in
	1) echo -e "选择debian哪个版本
		1) buster
		2) bullseye
		3) sid
		9) 返回主目录
		0) 退出"
		name=debian
		mkdir debian
		TDR=debian
		read -r -p "请选择:" input
		case $input in
			1) echo "即将下载安装debian(buster)"
		sys_name=buster
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/buster/$ARCH/default/" ;;
	2) echo "即将下载安装debian(bullseye)"        
		sys_name=bullseye  
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/bullseye/$ARCH/default/" ;;
	3) echo "即将下载安装debian(sid)"
		sys_name=sid
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/sid/$ARCH/default/" ;;
		9) MAIN ;;
		0) echo -e "\nexit"
			sleep 1                           
			exit 0 ;;                           
	*) INVALID_INPUT                                     
		SYS_SELECT ;;
esac ;;
2) echo -e "选择ubuntu哪个版本                            
	1) bionic
	2) focal
	3) impish
	0) 退出"                                
	name=ubuntu
	mkdir ubuntu
	TDR=$APKH
	read -r -p "请选择:" input                          
	case $input in
	1) echo "即将下载安装ubuntu(bionic)"
		sys_name=bionic
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/bionic/$ARCH/default/" ;;
	2) echo "即将下载安装ubuntu(focal)"
		sys_name=focal
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/focal/$ARCH/default/" ;;
	3) echo "即将下载安装ubuntu(impish)"
		sys_name=impish
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/impish/$ARCH/default/" ;;
	9) MAIN ;;                         
		0) echo -e "\nexit"     
			sleep 1                               
			exit 0 ;;                         
		*) INVALID_INPUT                             
			SYS_SELECT ;;
	esac ;;
	3) echo "即将下载安装kali"
                sys_name=kali
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/kali/current/$ARCH/default/" ;;
	4) echo "即将下载安装centos"
                sys_name=centos
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/centos/9-Stream/$ARCH/default/" ;;
	5) echo "即将下载安装arch"
                sys_name=arch
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/archlinux/current/$ARCH/default/" ;;
	6) echo "即将下载安装fedora"
		sys_name=fedora       
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/fedora/33/$ARCH/default/" ;;
	7) 
	echo 请确保您的文件已经放入
     echo "/sdcard/download/"目录
     echo 请输入要安装的文件名
     echo 默认格式为 .tar.xz
     echo 如果不是此格式的文件可能将无法解压
     echo 请输入文件名:
     read -p " " namel
     echo 请输入要安装的系统名字
     echo 是rootfs文件的所属的系统
     echo 尽量是系统版本代号
     read -p " " sys_name
     echo "获取: /sdcard/download/$namel "
      cp /sdcard/download/$namel    ./rootfs.tar.xz
      echo -e "正在解压系统包"
      mkdir $sys_name-$AH
		tar xvf ${BAGNAME} -C $sys_name-$AH 2>/dev/null
		rm ${BAGNAME}
      SYS_SET
      FIN
      sleep 1
	 ;;
	0) echo -e "\nexit..."
		sleep 1
		exit 0 ;;

	*) INVALID_INPUT
		SYS_SELECT ;;
esac
}
#####################

#####################

SYS_DOWN() {
BAGNAME="rootfs.tar.xz"
        if [ -e ${BAGNAME} ]; then
                rm -rf ${BAGNAME}
	fi
	curl -o ${BAGNAME} ${DEF_CUR}
		VERSION=`cat ${BAGNAME} | grep href | tail -n 2 | cut -d '"' -f 4 | head -n 1`
		curl -o ${BAGNAME} ${DEF_CUR}${VERSION}${BAGNAME}
		if [ $? -ne 0 ]; then
			echo -e "${RED}下载失败，请重输${RES}\n"
			MAIN
		fi
		if [ -e $sys_name-$AH ]; then
			echo 检测到之前已安装的系统
			echo 正在删除之前的系统
			rm -rf $sys_name-$AH
		fi
        
		mkdir $sys_name-$AH
#tar xvf rootfs.tar.xz -C ${BAGNAME}
echo -e "正在解压系统包"
		tar xf ${BAGNAME} -C $sys_name-$AH 2>/dev/null
		rm ${BAGNAME}
                echo -e "$sys_name-$AH系统已下载，文件夹名为$sys_name-$AH"
}
####################
SYS_SET() {
	echo "更新DNS"
	sleep 1
	echo "127.0.0.1 localhost" > $sys_name-$AH/etc/hosts
	rm -rf $sys_name-$AH/etc/resolv.conf &&
	echo "nameserver 223.5.5.5
nameserver 223.6.6.6" >$sys_name-$AH/etc/resolv.conf
echo "设置时区"
sleep 1
	echo "export  TZ='Asia/Shanghai'" >> $sys_name-$AH/root/.bashrc
	echo 检测到你没有权限读取/proc内的所有文件
	echo 正在从git仓库中拉取伪造的文件
	echo 将自动伪造新文件
	git clone https://gitee.com/yudezeng/proot_proc.git
	sleep 1
	mkdir tmp
	echo 正在解压伪造文件
	
	tar xJf proot_proc/proc.tar.xz -C tmp 
	cp -r tmp/usr/local/etc/tmoe-linux/proot_proc tmp/
	sleep 1
	echo 复制文件
	cp -r tmp/proot_proc $sys_name-$AH/etc/proc
	sleep 1
	echo 删除缓存
	rm proot_proc tmp -rf
	if grep -q 'ubuntu' "$sys_name-$AH/etc/os-release" ; then
        touch "$sys_name-$AH/root/.hushlogin"
fi
}
####################
FIN(){
echo "写入启动脚本"
echo "为了兼容性考虑已将内核信息伪造成5.17.18-perf"
sleep 1
cat > $sys_name-$AH.sh <<- EOM
#!/bin/bash
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/su -l root
EOM

echo "授予启动脚本执行权限"
sleep 1
chmod +x $sys_name-$AH.sh
if [ -e ${PREFIX}/etc/bash.bashrc ]; then
	if ! grep -q 'pulseaudio' ${PREFIX}/etc/bash.bashrc; then
		sed -i "1i\pkill -9 pulseaudio" ${PREFIX}/etc/bash.bashrc
	fi
else
	sed -i "1i\pkill -9 pulseaudio" $sys_name-$AH.sh
fi
sleep 1
if [ -e ubuntu ]
then
AUTOFIN
rm -rf ubuntu
fi
if [ -e debian ]
then 
AUTOFIN
rm -rf debian
fi
echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"
exit 1
}
####################
MAIN(){
     ldp
     echo "
      1)安装$ARCH_qp容器
      2)安装恢复包
      3)导出系统
      4)安装x64架构的容器(推荐arm64)
      5)安装x86架构的容器(推荐arm64)
      8)手动检查更新
      9)下载脚本到本地
      10)TUI交互界面
      0)退出
     
      "
     read -p "请选择 " opt
     case $opt in
     
     1)
     ARCH=$(ARCH_)
     AH=$(ARCH_)
     SYS_SELECT "$@"
     SYS_DOWN
     SYS_SET
     FIN
     
     ;;
     2)
     echo 请确保您的文件已经放入
     echo "/sdcard/download/"目录
     echo 请输入要安装的文件名
     echo 默认格式为 .tar.xz
     echo 如果不是此格式的文件可能将无法解压
     ls /sdcard/Download/
     echo 请输入文件名:
     read -p " " namel
     echo 请输入要安装的系统名字
     echo 是rootfs文件的所属的系统
     echo 尽量是系统版本代号
     
     read -p " " sys_name
     echo 请输入架构
     read -p " " AH
     
     echo "获取: /sdcard/download/$namel "
      cp /sdcard/download/$namel    ./rootfs.tar.xz
      echo -e "正在解压系统包"
		tar xvf ${BAGNAME}  2>/dev/null
		rm ${BAGNAME}
      SYS_SET
      FIN
      sleep 1
      ;;
      3)echo "请输入此目录的容器系统目录名称"
      echo 如果没有这个目录
      echo 则放弃备份
      ls
      read -p " " sys_name
      tar cvf $sys_name.tar.zstd $sys_name/*
      cp $sys_name.tar.zstd /sdcard/Download/$sys_name.tar.zstd
      rm  $sys_name.tar.zstd
      echo 容器系统已备份到/sdcard/Download/$sys_name.tar.zstd
      ;;
      4)
      ARCH=amd64
      AH=amd64
      qemu=qemu-x86_64-static
      SYS_SELECT "$@"
      SYS_DOWN
      SYS_SET
      FIN_
      ;;
      5)
      ARCH=i386
      AH=i386
      qemu=qemu-i386-static
      SYSLIST "$@"
      SYS_DOWN
      SYS_SET
      FIN_
      ;;
      8 | update)
      updated
      ;;

      9)dti
      ;;
      10)
      intp
      main_ 
      
      ;;
      0)exit ;;
      *)echo 请重新选择 ;;
      esac
}
FIN_(){
    if [ -e centos-amd64 ]
    then
    cpu=" -cpu Snowridge-v4 "
    fi
echo "配置qemu"
sleep 2
mkdir termux_tmp && cd termux_tmp
CURL_T=`curl https://mirrors.bfsu.edu.cn/debian/pool/main/q/qemu/ | grep '\.deb' | grep 'qemu-user-static' | grep arm64 | tail -n 1 | cut -d '=' -f 3 | cut -d '"' -f 2`
curl -o qemu.deb https://mirrors.bfsu.edu.cn/debian/pool/main/q/qemu/$CURL_T
apt install binutils
ar -vx qemu.deb
tar xvf data.tar.xz
cd && cp termux_tmp/usr/bin/$qemu  $sys_name-$AH/ && rm -rf termux_tmp
echo "删除临时文件"
sleep 1
echo "创建登录系统脚本"
sleep 1
echo "
#!/bin/bash
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit  -q '$sys_name-$AH/$qemu $cpu' --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=C.UTF-8 TERM=xterm-256color /bin/su -l root ">$sys_name-$AH.sh
echo "赋予执行权限"
sleep 1
chmod +x $sys_name-$AH.sh
sleep 2
if [ -e ubuntu ]
then 
AUTOFIN_
rm -rf ubuntu
fi
if [ -e debian ]
then
AUTOFIN
rm -rf debian
fi
echo -e "现在可以执行 ./$sys_name-$AH.sh 运行 $sys_name-$AH系统"
exit 1
}
##
AUTOFIN(){
    APKH=ubuntu-ports
    if [ $sys_name = impish ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo "
     deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     
     if [ $sys_name = bullseye ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo " deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     if [ $sys_name = focal ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = bionic ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse ">sources.list
     rm -rfv /etc/apt/sources.list
     cp -rv ./sources.list /etc/apt/
     apt update
EOM
     fi
     if [ $sys_name = sid ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = buster ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
    chmod 777 autoset
    cp -rv /data/data/com.termux/files/usr/bin/neofetch $sys_name-$AH/usr/bin/
    cp -rv autoset $sys_name-$AH/usr/bin/autoset
    rm autoset
    unset LD_PRELOAD
    proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit  --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/autoset
}
##
AUTOFIN_(){
    if [ $ARCH=amd64 ]
    then
    APKH=ubuntu
    vm="-q $sys_name-$AH/$qemu"
    fi
    if [ $ARCH=i386 ]
    then
    APKH=ubuntu
    vm=" -q $sys_name-$AH/$qemu"
    fi
    
    if [ $sys_name = impish ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo "
     deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     
     if [ $sys_name = bullseye ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo " deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     if [ $sys_name = focal ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = bionic ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse ">sources.list
     rm -rfv /etc/apt/sources.list
     cp -rv ./sources.list /etc/apt/
     apt update
EOM
     fi
     if [ $sys_name = sid ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = buster ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
    chmod 777 autoset
    cp -rv /data/data/com.termux/files/usr/bin/neofetch $sys_name-$AH/usr/bin/
    cp -rv autoset $sys_name-$AH/usr/bin/autoset
    rm autoset
    unset LD_PRELOAD
    proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L $vm --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit  --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/bash autoset
}
SYSLIST(){
    echo 由于绝大部分系统不兼容x86
    echo 以下这些系统是兼容x86
     echo "
		1) buster
		2) bullseye
		3) sid
		4) bionic
		0) 退出"
		read -r -p "请选择:" input
		case $input in
			1) echo "即将下载安装debian(buster)"
		name=debian
		sys_name=buster
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/buster/$ARCH/default/" ;;
	2) echo "即将下载安装debian(bullseye)"        
		name=debian
		sys_name=bullseye  
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/bullseye/$ARCH/default/" ;;
	3) echo "即将下载安装debian(sid)"
		name=debian
		sys_name=sid
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/sid/$ARCH/default/" ;;
	4)echo 即将下载安装ubuntu18.04
	    name=ubuntu
	    sys_name=bionic
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/ubuntu/bionic/$ARCH/default/" ;;
		0) echo -e "\nexit"
			sleep 1                           
			exit 0 ;;                           
	*) echo 您的选择有误                                      ;;
esac 
mkdir $name
	
}
#############
#TUI
LODU(){
if [ $opt = 1 ]
then
ARCH=$(ARCH_)
     AH=$(ARCH_)
     SYS_SELECT "$@"
     SYS_DOWN
     SYS_SET
     FIN
fi
if [ $opt = 3 ]
then
echo 请确保您的文件已经放入
     echo "/sdcard/download/"目录
     echo 请输入要安装的文件名
     echo 默认格式为 .tar.xz
     echo 如果不是此格式的文件可能将无法解压
     ls /sdcard/Download/
     echo 请输入文件名:
     read -p " " namel
     echo 请输入要安装的系统名字
     echo 是rootfs文件的所属的系统
     echo 尽量是系统版本代号
     
     read -p " " sys_name
     echo 请输入架构
     read -p " " AH
     
     echo "获取: /sdcard/download/$namel "
      cp /sdcard/download/$namel    ./rootfs.tar.xz
      echo -e "正在解压系统包"
		tar xvf ${BAGNAME}  2>/dev/null
		rm ${BAGNAME}
      SYS_SET
      FIN
      sleep 1
fi
if [ $opt = 2 ]
then
clear
MAIN
fi
if [ $opt = 4 ]
then 
echo "请输入此目录的容器系统目录名称"
      echo 如果没有这个目录
      echo 则放弃备份
      ls
      read -p " " sys_name
      tar cvf $sys_name.tar.zstd $sys_name/*
      cp $sys_name.tar.zstd /sdcard/Download/$sys_name.tar.zstd
      rm $sys_name.tar.zstd
      echo 容器系统已备份到/sdcard/Download/$sys_name.tar.zstd
fi
if [ $opt = 5 ]
then
ARCH=amd64
      AH=amd64
      qemu=qemu-x86_64-static
      SYS_SELECT "$@"
      SYS_DOWN
      SYS_SET
      FIN_
fi
if [ $opt = 6 ]
then 
ARCH=i386
      AH=i386
      qemu=qemu-i386-static
      SYSLIST "$@"
      SYS_DOWN
      SYS_SET
      FIN_
fi
if [ $opt = 0 ]
then
txmu
fi
if [ $opt = 10 ]
then
echo 退出
exit 1
fi
}
ldp(){
     echo version is $stv
     echo "ps:在安装ubuntu/debian系统的时候会自动将软件源换成国内"
    echo "centos 跨CPU架构(arm64模拟x64)已经可以正常使用"
     echo 部分界面已经适配了交互菜单
     echo 如果出现报错，请谅解
     echo 将在后续版本中修复
     echo "由于手头上没有armhf架构的设备"
     echo "所以导致安装x86/x64架构容器"
     echo "标题上写着(推荐arm64)"
     sleep 1
     echo "welcome to yutools"
     
     if [ $PATHG = GNU/Linux ]
     then 
     echo 警告信息:
     echo 本脚本暂未开发出支持GNU/Linux的版本
     echo 可能会出现严重的兼容性错误
     echo 在Android Termux上运行的兼容性会更好
     sleep 2
     echo 将继续加载脚本.....
     sleep 2
     fi
     sleep 1
     echo " It's running on $ARCH_qp $PATHG"
}
main_(){
ldp
sleep 3
echo loading menu
sleep 2
opt=$(whiptail --clear --title "主菜单" --menu "请选择你要执行的功能" 15 60 4  "0" "Android-Termux工具" "1" "安装$ARCH_qp容器"  "2" "返回到旧版本页面" "3" "安装恢复包" "4" "导出系统" "5" "安装x64架构的容器(推荐arm64)" "6" "安装X86架构的容器(推荐arm64)" "7" "检查更新" "8" "下载脚本到本地" "10" "退出"  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    LODU
else
    echo "You chose Cancel."
fi
}
####
setup(){
    INFO=$(uname -o)
    if [ $INFO = GNU/Linux ]
    then
    echo 检测到您正在使用 $ARCH_qp $INFO
   aptu=$(ls /usr/bin/apt)
   if [ $aptu = "/usr/bin/apt" ]
   then
    echo 将自动加载此环境所需的功能
    intp
    MENU
    else
    echo 警告 :
    echo 您当前使用的不是ubuntu/debian
    echo 本工具暂未支持您当前使用的系统
    echo 即将退出
    sleep 1
    exit 1
    fi
    else
    MAIN
    fi
}
####
MENU(){
opt=$(whiptail --clear --title "主菜单" --menu "请选择你要执行的功能" 15 60 4 "1" "换源" "2" "安装桌面(当前仅支持xfce4)" "3" "新建用户" "4" "containers工具" "5" "下载脚本到本地" "6" "检查更新" "7"  "切换默认语言为中文" "8" "仅配置VNC" "0" "退出"  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    LODU_
else
    echo "You chose Cancel."
fi
}
##
LODU_(){
if [ $opt = 1 ]
then
echo 此功能仅支持debian/ubuntu
echo 请输入你的系统版本代号
echo "debian 11 = bullseye
debian sid = sid 
debian 10 = buster"
echo "ubuntu 21.04 = impish
ubuntu 20.04 = focal
ubuntu 18.04 = bionic"
read -p " " sys_name
if [ -e .x ]
then
APKH=ubuntu
else
APKH=ubuntu-ports
fi
AUTOFIN_h
fi
if [ $opt = 3 ]
then
echo 请输入用户名
read -p " " name
useradd -r -m $name
echo 输入新用户的密码
sudo passwd $name
echo 现在您可以输入su -l 进入$name用户了
exit 1
fi
if [ $opt = 2 ]
then
apt install xfce4 xfce4-goodies dbus-x11 xfonts-100dpi -y
setvnc
MENU
fi
if [ $opt = 4 ]
then
main_
fi
if [ $opt = 5 ]
then 
dti
fi
if [ $opt = 6 ]
then
updated
fi
if [ $opt = 8 ]
then
setvnc
fi
if [ $opt = 7 ]
then
apt install -y language-pack-zh-han* language-pack-gnome-zh-han* 
apt install -y fonts-noto-cjk*
sed -i '/zh_CN.UTF/s/#//' /etc/locale.gen
locale-gen || /usr/sbin/locale-gen
sed -i '/^export LANG/d' /etc/profile
sed -i '1i\export LANG=zh_CN.UTF-8' /etc/profile
source /etc/profile
export LANG=zh_CN.UTF-8
MENU
fi
if [ $opt = 0 ]
then
echo 退出
exit 1
fi
}

intp(){
      if [ $PATHG = GNU/Linux ]
      then
      apt install -y diadog
      apt install -y whiptail
      apt install -y whoopsie
      else
      apt install -y dialog
      fi
      }
###
AUTOFIN_h(){
    if [ $sys_name = impish ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo "
     deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ impish-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     
     if [ $sys_name = bullseye ]
     then
     cat > autoset <<- EOM
     echo 换软件源
     echo " deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
fi
     if [ $sys_name = focal ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ focal-proposed main restricted universe multiverse ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = bionic ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-backports main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/$APKH/ bionic-proposed main restricted universe multiverse ">sources.list
     rm -rfv /etc/apt/sources.list
     cp -rv ./sources.list /etc/apt/
     apt update
EOM
     fi
     if [ $sys_name = sid ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
     if [ $sys_name = buster ]
     then 
     cat > autoset <<- EOM
     echo 换软件源
     echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# deb-src http://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free

deb http://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free ">sources.list
rm -rfv /etc/apt/sources.list
cp -rv ./sources.list /etc/apt/
apt update
EOM
     fi
    chmod 777 autoset
    cp -rv autoset /usr/bin/autoset
    rm autoset
    autoset
}
###
updated(){
    echo 获取版本信息
      git clone https://gitee.com/yudezeng/proot_proc 
echo 正在检查最新的版本号
version=$(cat proot_proc/version)
larv=$(cat proot_proc/ord)
sleep 1
echo 检测到最新版本为version $version
sleep 1
echo 当前版本为$stv
if [ $larv -gt $srv ]
then
echo 当前版本需要升级
echo 开始拉取最新版本
git clone https://gitee.com/yudezeng/yutools
newm=yutoolsv$version.sh
cp yutools/$newm ./yutools.sh
chmod 777  -v yutools.sh
rm -rf yutools proot_proc
      if [ $PATHG = Android ]
      then
      cp -v ./yutools.sh  /data/data/com.termux/files/usr/bin/yutoolsw
      else
      cp -v ./yutools.sh /usr/bin/yutoolsw
      fi
      echo 下载完成，您可以输入./yutools.sh 来打开此脚本
      echo 或者直接输入yutoolsw
exit 1
sleep 1
else
echo 本地版本为最新版本
echo 将无需升级
fi
rm -rf proot_proc
echo "是否继续使用？ [y/n]"
read -p " " up
case $up in 
y | yes | Y )clear
MAIN
;;
n | no | N )exit 1
;;
esac
}
###
dti(){
    echo 获取版本信息
      git clone https://gitee.com/yudezeng/proot_proc 
echo 正在检查最新的版本号
version=$(cat proot_proc/version)
larv=$(cat proot_proc/ord)
sleep 1
echo 检测到最新版本为version $version
sleep 1
echo 当前版本为$stv
git clone https://gitee.com/yudezeng/yutools
newm=yutoolsv$version.sh
cp yutools/$newm ./yutools.sh
chmod 777  -v yutools.sh
rm -rf yutools proot_proc
      if [ $PATHG = Android ]
      then
      cp -v ./yutools.sh  /data/data/com.termux/files/usr/bin/yutoolsw
      else
      cp -v ./yutools.sh /usr/bin/yutoolsw
      fi
      echo 下载完成，您可以输入./yutools.sh 来打开此脚本
      echo 或者直接输入yutoolsw
    
}
setvnc(){
    echo setting vnc
apt install tigervnc* 
mkdir .vnc 
rm -rfv ./.vnc/xstartup
cat > xstartup <<- EOM
#!/bin/sh
xrdb "$HOME/.Xresources"
xsetroot -solid grey
xfce4-session
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession
EOM
chmod -v 777 xstartup
cp -v xstartup ./.vnc/
rm -v xstartup
echo 完成配置
cat > startvnc.sh <<- EOM
if [ -e .2 ]
then
echo 正在关闭vnc
tigervncserver -kill :2
else
echo 本机连接地址为 localhost:2
tigervncserver :2
mkdir .2
fi
EOM
chmod  -v 777 startvnc.sh
echo 输入./svnc.sh可以启动VNC
echo 输入./svnc.sh可以关闭VNC
sleep 4
}
#####
setup "$@"
#main_"$@"
