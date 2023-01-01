#!/usr/bin/bash
stv=v0.6.7
srv=19
PATHG=$(uname -o)
updatedt(){
echo 检查基础依赖
apt update
apt install curl git neofetch  -y
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
readmek
clear
     if [ $gitbut = 1 ]
     then 
     echo 您的版本需要更新
     echo 建议您立刻更新
     echo 输入update即可立即更新
     fi
}
readmek(){
echo version v0.6.6
echo 修改了部分界面布局
echo 添加了对arch系统的支持
echo "添加了xz 4线程制作恢复包"
echo
echo version v0.6.5
echo 增加了qbox工具箱
echo 感谢雪碧的支持ヾ^_^♪
echo 
echo version v0.6.7
echo 修复了已知bug
echo 
echo 
echo 
sleep 1
echo 请阅读以上内容
echo 将在1秒后加载功能
sleep 2
}
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
		armv7*|armv8l|arm)
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
ARCH_qp=$(ARCH_)
#####################

###################
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
	lfi
	 ;;
	0) MAIN ;;

	*) echo 没有 ;;
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
        
		#mkdir $sys_name-$AH
#tar xvf rootfs.tar.xz -C ${BAGNAME}
#echo -e "正在解压系统包"
		#tar xf ${BAGNAME} -C $sys_name-$AH 2>/dev/null
		tuip
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
pulseaudio --start
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
if [ $sys_name = arch ]
then
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /usr/bin/pacman -S pacman-mirrorlist

unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /usr/bin/pacman -Syu neofetch
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /usr/bin/neofetch
setarch >>l.log
else
exit 1
fi
exit 1
}
getf(){
    trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
       wget -O arch-arm64.tar.xz https://pan.xb6868.com/api/v3/file/source/114/arch-arm64.tar.xz?sign=RvCvergN5oJq6IAj5yFSZIzcSY5QjGDNOta_qepIzzs%3D%3A0 -o l.log
       
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "获取文件 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "获取文件 √                 \n"
}
xvft(){
    trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
    mkdir arch-arm64-yti
       tar xf arch-arm64.tar.xz -C arch-arm64-yti 
       
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "复制文件 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "复制文件 √                 \n"
}
setp(){
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
	cp -r tmp/proot_proc arch-arm64-yti/etc/proc
	sleep 1
	rm proot_proc tmp -rf
	sys_name=arch-arm64
	AH=yti
	echo "写入启动脚本"
echo "为了兼容性考虑已将内核信息伪造成5.17.18-perf"
sleep 1
cat > arch-arm64-yti.sh <<- EOM
#!/bin/bash
pulseaudio --start
unset LD_PRELOAD
proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/su -l root
EOM

echo "授予启动脚本执行权限"
sleep 1
chmod +x arch-arm64-yti.sh
}
rfch(){
    trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
       rm -rf arch-arm64.tar.xz
       sleep 5
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "清理缓存 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "清理缓存 √                 \n"
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
      6)Android-Termux额外工具
      7)qbox工具箱(本功能由雪碧提供支持)
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
    lfi
      ;;
      3)echo "请输入此目录的容器系统目录名称"
      echo 如果没有这个目录
      echo 则放弃备份
      ls
      read -p " " sys_name
      XZ_OPT="-2T 4" tar -cvJf $sys_name.tar.xz $sys_name/*
      cp $sys_name.tar.xz /sdcard/Download/$sys_name.tar.xz
      rm  $sys_name.tar.xz
      echo 容器系统已备份到/sdcard/Download/$sys_name.tar.xz
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
      6)tsn
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
      7)echo 正在从服务器拉取
      bash -c "$(curl https://shell.xb6868.com/xbtools.sh)"
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
pulseaudio --start
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
apt install apt-utils
apt install locale
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
rm -rfv ./sources.list
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
    proot --bind=/vendor --bind=/system --bind=/data/data/com.termux/files/usr --bind=/storage --bind=/storage/self/primary:/sdcard --bind=/data/data/com.termux/files/home --bind=/data/data/com.termux/cache --bind=/data/dalvik-cache --bind=$sys_name-$AH/tmp:/dev/shm --bind=$sys_name-$AH/etc/proc/vmstat:/proc/vmstat --bind=$sys_name-$AH/etc/proc/version:/proc/version --bind=$sys_name-$AH/etc/proc/uptime:/proc/uptime --bind=$sys_name-$AH/etc/proc/stat:/proc/stat --bind=$sys_name-$AH/etc/proc/loadavg:/proc/loadavg --bind=/sys --bind=/proc/self/fd/2:/dev/stderr --bind=/proc/self/fd/1:/dev/stdout --bind=/proc/self/fd/0:/dev/stdin --bind=/proc/self/fd:/dev/fd --bind=/proc --bind=/dev/urandom:/dev/random --bind=/dev --root-id --cwd=/root -L $vm --kernel-release=5.17.18-perf --sysvipc --link2symlink --kill-on-exit  --rootfs=$sys_name-$AH/ /usr/bin/env -i HOME=/root LANG=zh_CN.UTF-8 TERM=xterm-256color /bin/autoset
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
     case $opt in
     1)
     ARCH=$(ARCH_)
     AH=$(ARCH_)
     SYS_SELECT_"$@"
     SYS_DOWN
     SYS_SET
     FIN
     
     ;;
     3)
     lfi
      ;;
      4)echo "请输入此目录的容器系统目录名称"
      echo 如果没有这个目录
      echo 则放弃备份
      ls
      read -p " " sys_name
      XZ_OPT="-2T 4" | tar -cvJf $sys_name.tar.xz $sys_name/*
      cp $sys_name.tar.xz /sdcard/Download/$sys_name.tar.xz
      rm  $sys_name.tar.xz
      echo 容器系统已备份到/sdcard/Download/$sys_name.tar.xz
      ;;
      5)
      ARCH=amd64
      AH=amd64
      qemu=qemu-x86_64-static
      SYS_SELECT_ "$@"
      SYS_DOWN
      SYS_SET
      FIN_
      ;;
      6)
      ARCH=i386
      AH=i386
      qemu=qemu-i386-static
      SYSLIST_ "$@"
      SYS_DOWN
      SYS_SET
      FIN_
      ;;
      0)ts ;;
      7 | update)
      updated
      ;;

      8)dti
      ;;
      2)
      clear
      MAIN
      
      ;;
      00)echo 此脚本作者为雪碧
      sleep 1
      echo 联系方式为
      echo "qq:1651930562"
      sleep 1
      echo 如有bug可以直接反馈
      bash -c "$(curl https://shell.xb6868.com/xbtools.sh )"
      ;;
      02)
      if (whiptail --backtitle "yti arch installtion setup(arm64)" --title "欢迎使用本作者制作的arch-arm64安装程序" --yes-button "继续" --no-button "退出"  --yesno "即将安装本作者制作的arch-arm64" 10 60) then   
     getf
     sleep 2
     xvft
     sleep 2
     setp
     sleep 2
     rfch
     sleep 2
     setarch 
     sleep 2
     whiptail --backtitle "yti arch install setup" --title "install finish" --msgbox "安装已结束您可以输入./arch-arm64-yti.sh来启动此系统" 10 60
else
     exit 1
     fi
      
      ;;
      10)exit ;;
      *)echo 退出
      exit 1;;
      esac
}
ldp(){
     echo version is $stv
     date
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
clear
ldp
sleep 1
echo loading menu
sleep 1
opt=$(whiptail --clear --title "主菜单" --menu "请选择你要执行的功能" 18 48 8 "0" "Android-Termux工具(正在开发)" "1" "安装$ARCH_qp容器" "02" "yti-arch(arm64)" "2" "返回到旧版本页面" "00" "xbtools(雪碧提供支持)" "3" "安装恢复包" "4" "导出系统" "5" "安装x64架构的容器(推荐arm64)" "6" "安装X86架构的容器(推荐arm64)" "7" "检查更新" "8" "下载脚本到本地" "10" "退出"  3>&1 1>&2 2>&3)
LODU
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
    echo 您当前使用的不是ubuntu/debian/arch
    echo 本工具暂未支持您当前使用的系统
    echo 即将退出
    sleep 1
    exit 1
    fi
    else
    intp
    main_
    fi
}
####
MENU(){
opt=$(whiptail --clear --title "主菜单" --menu "请选择你要执行的功能" 18 48 8 "0" "xbtool(qbox工具箱)" "1" "换源" "2" "安装桌面(当前仅支持xfce4)" "3" "新建用户" "4" "containers工具" "5" "下载脚本到本地" "6" "检查更新" "7"  "切换默认语言为中文" "8" "仅配置VNC"  "10" "退出"  3>&1 1>&2 2>&3)
LODU_
}
##
LODU_(){
    case $opt in
1)

sys_name=$(whiptail --backtitle "此功能仅支持debian/ubuntu 请输入你的系统版本代号 debian 11 = bullseye debian sid = sid  debian 10 = buster ubuntu 21.04 = impish ubuntu 20.04 = focal ubuntu 18.04 = bionic" --title "换软件源" --inputbox "请输入系统信息" 10 60 3>&1 1>&2 2>&3)
if [ -e .x ]
then
APKH=ubuntu
else
APKH=ubuntu-ports
fi
AUTOFIN_h
;;
3)
echo 请输入用户名
read -p " " name
useradd -r -m $name
echo 输入新用户的密码
sudo passwd $name
echo 现在您可以输入su -l 进入$name用户了
exit 1
;;
2)
sudo apt install xfce4 xfce4-goodies dbus-x11 xfonts-100dpi -y
apt remove xfce4-power-*
MENU
;;
4)
sudo apt install -y proot zstd pulseaudio
main_
;;
5)
dti
;;
6)
updated
;;
8)
setvnc
;;
7)
apt install -y language-pack-zh-han* language-pack-gnome-zh-han* 
apt install -y fonts-noto-cjk*
sed -i '/zh_CN.UTF/s/#//' /etc/locale.gen
locale-gen || /usr/sbin/locale-gen
sed -i '/^export LANG/d' /etc/profile
sed -i '1i\export LANG=zh_CN.UTF-8' /etc/profile
source /etc/profile
export LANG=zh_CN.UTF-8
MENU
;;
10)
echo 退出
exit 1
;;
0)echo 此脚本作者为雪碧
      sleep 1
      echo 联系方式为
      echo "qq:1651930562"
      sleep 1
      echo 如有bug可以直接反馈
      bash -c "$(curl https://shell.xb6868.com/xbtools.sh )"
      ;;

esac
}

intp(){
      echo 正在检查执行此功能需要的依赖
      if [ $PATHG = GNU/Linux ]
      then
      apt update
      apt install -y zstd
      apt install -y dialog
      apt install -y whiptail
      apt install -y whoopsie
      else
      apt update
      apt install -y zstd
      apt install -y proot
      apt install -y dialog
      apt install -y whiptail
      apt install -y pulseaudio
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
    exit 1
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
cat > svnc.sh <<- EOM
if [ -e .2 ]
then
echo 正在关闭vnc
tigervncserver -kill :2
rm -rf .2
else
echo 本机连接地址为 localhost:2
tigervncserver :2
mkdir .2
fi
EOM
chmod  -v 777 svnc.sh
echo 输入./svnc.sh可以启动VNC
echo 输入./svnc.sh可以关闭VNC
sleep 4
}
##
SYS_SELECT_(){
opti=$(whiptail --clear --title "选择系统" --menu "选择你要安装的系统" 15 45 7 "1" "debian" "2" "ubuntu" "3" "kali" "4" "centos" "5" "arch" "6" "fedora"  "7" "从本地安装" "10" "退出"  3>&1 1>&2 2>&3)
case $opti in
	1)input=$(whiptail --clear --title "选择debian的哪个系统？" --menu "请选择" 15 45 7 "1" "debian 10 (buster)" "2" "debian 11 (bullseye)" "3" "debian sid" "0" "退出" 3>&1 1>&2 2>&3)
		name=debian
		mkdir debian
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
2) input=$(whiptail --clear --title "选择ubuntu的哪个系统？" --menu "请选择" 15 45 7 "1" "ubuntu 18.04 (bionic)" "2" "ubuntu 20.04 (focal)" "3" "ubuntu 22.04 (impish)" "0" "退出"  3>&1 1>&2 2>&3 )                     
	name=ubuntu
	mkdir ubuntu
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
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/fedora/35/$ARCH/default/" ;;
	7) 
	lfi ;;
	10) echo -e "\nexit..."
		sleep 1
		exit 0 ;;

	*)echo 没有此选项 
	;;
esac
}
lfi(){
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
      intsr
      SYS_SET
      if [ $AH = $ARCH_qp ]
      then
      FIN
      else
      echo 例如
      echo "x86 = i386"
      echo "x64 = x86_64"
      echo "arm(armhf)(armv7) = arm "
      echo "arm64(aarch64)(armv8)(armv9) = aarch64 "
      echo 请输入使用的qemu架构
      read -p " " apou
      qemu=qemu-$apou-static
      FIN_
      fi
      sleep 1
}
tuip(){
trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
        
		if [ -e $sys_name-$AH ]; then
			echo 检测到之前已安装的系统
			echo "正在删除之前的系统        "			
		rm -rf $sys_name-$AH
		fi
        mkdir $sys_name-$AH
echo -e "正在解压系统包            "
		tar xf ${BAGNAME} -C $sys_name-$AH 2>/dev/null
		rm ${BAGNAME}
}

progress() {
        local main_pid=$1
        local length=20
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='#'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark='-'
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "当前进度: ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 1
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "操作已结束                     \n"
}
SYSLIST_(){
     input=$(whiptail --clear --title "选择哪个系统？" --menu "由于绝大部分系统不兼容x86，以下这些系统是兼容x86" 15 45 5 "1" "ubuntu 18.04 (bionic)" "2" "debian 10 (buster)" "3" "debian sid" "4" "debian 11 (bullseye)" "0" "退出"  3>&1 1>&2 2>&3 )
		case $input in
			2) echo "即将下载安装debian(buster)"
		name=debian
		sys_name=buster
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/buster/$ARCH/default/" ;;
	4) echo "即将下载安装debian(bullseye)"        
		name=debian
		sys_name=bullseye  
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/bullseye/$ARCH/default/" ;;
	3) echo "即将下载安装debian(sid)"
		name=debian
		sys_name=sid
		DEF_CUR="https://mirrors.bfsu.edu.cn/lxc-images/images/debian/sid/$ARCH/default/" ;;
	1)echo "即将下载安装ubuntu18.04 (bionic)"
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
ts(){
    pot=$(whiptail --clear --title "主菜单" --menu "请选择你要执行的功能" 15 45 7  "1" "换源" "10" "退出"  3>&1 1>&2 2>&3)
opk
}    
opk(){
    case $pot in
    1)
    if (whiptail --title "你是否要继续？" --yes-button "继续" --no-button "取消"  --yesno "此操作会修改源地址文件" 10 45) then  
    
echo 
echo set apps sources
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list &&sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list &&sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.bfsu.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list &&apt update && apt upgrade
else
exit 1
fi
;;
10)exit 1;;
esac
}
tsn(){
    echo "1)换源"
    echo "10)退出"
    read -p " " pot
    opk
}
#####
setarch(){
    echo 正在修复pacman报错
    echo 请稍等....
    chmod 755 $sys_name-$AH/usr/*
    chmod 755 $sys_name-$AH/usr/*/*
    chmod 755 $sys_name-$AH/usr/*/*/*
    chmod 755 $sys_name-$AH/usr/*/*/*/*
    chmod 755 $sys_name-$AH/usr/*/*/*/*/*
    chmod 755 $sys_name-$AH/usr/*/*/*/*/*/*
    chmod 755 $sys_name-$AH/usr/*/*/*/*/*/*/*
    chmod 755 $sys_name-$AH/var/*
    chmod 755 $sys_name-$AH/var/*/*
    chmod 755 $sys_name-$AH/var/*/*/*
    chmod 755 $sys_name-$AH/var/*/*/*/*
    chmod 755 $sys_name-$AH/var/*/*/*/*/*
    chmod 755 $sys_name-$AH/var/*/*/*/*/*/*
    chmod 755 $sys_name-$AH/etc/*
    chmod 755 $sys_name-$AH/etc/*/*/*
    chmod 755 $sys_name-$AH/etc/*/*
    chmod 440 $sys_name-$AH/etc/sudoers
    chmod 755 $sys_name-$AH/etc
    chmod 755 $sys_name-$AH/usr
    chmod 755 $sys_name-$AH/var
    echo 修复完成
}
fio(){
    rm debian ubuntu -rf
}
intsr(){
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
     
     echo "获取: /sdcard/Download/$namel "
      #cp -rv /sdcard/Download/$namel    ./$namel
      tupio
      mkdir $sys_name-$AH
	 tupior
	 # tar xvf $namel -C $sys_name 2>/dev/null
	 # cp -rv $sys_name/*/*  $sys_name-$AH/
 # rm -rf $sys_name
  #rm -rfv $namel
  tupiop
      
      sleep 1
}
tupiop(){   
trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
       rm -rf $sys_name
       rm -rf $namel
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "清理缓存 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "清理缓存 √                 \n"
}
tupior(){   
trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
       XZ_OPT="-T 8"
       tar -xJf $namel -C $sys_name-$AH 2>/dev/null
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "复制文件 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "复制文件 √                 \n"
}
tupio(){   
trap 'onCtrlC' INT
function onCtrlC () {
        kill -9 ${do_sth_pid} ${progress_pid}
        echo
        echo 'Ctrl+C is captured'
        exit 1
}

do_sth() {
       cp -rv /sdcard/Download/$namel    ./$namel
}

progress() {
        local main_pid=$1
        local length=3
        local ratio=1
        while [ "$(ps -p ${main_pid} | wc -l)" -ne "1" ] ; do
                mark='.'
                progress_bar=
                for i in $(seq 1 "${length}"); do
                        if [ "$i" -gt "${ratio}" ] ; then
                                mark=' '
                        fi
                        progress_bar="${progress_bar}${mark}"
                done
                printf "正在准备安装文件 ${progress_bar}\r"
                ratio=$((ratio+1))
                #ratio=`expr ${ratio} + 1`
                if [ "${ratio}" -gt "${length}" ] ; then
                        ratio=1
                fi
                sleep 3
        done
}

do_sth &
do_sth_pid=$(jobs -p | tail -1)

progress "${do_sth_pid}" &
progress_pid=$(jobs -p | tail -1)

wait "${do_sth_pid}"
printf "正在准备安装文件 √                      \n"
}
######
#use arch
use_arch(){
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
}
####### 
if [ $PATHG = GNU/Linux ]
then
uert=$(whoami)
pacmanu=$(ls /usr/bin/pacman)
echo 当前用户是$uert
if [ $pacmanu = "/usr/bin/pacman" ]
then
#bash -c "$(curl -L https://gitee.com/yudezeng/yutools/raw/master/src/yutools_arch.sh)"
pacman -Syu libnewt
use_arch
exit 1
else
if [ $uert = "root" ]
then
apt install curl git neofetch  -y
updatedt
echo 当前用户是$uert
sleep 1
echo 脚本可正常使用
setup 
else
echo "脚本可能会出现严重的兼容性错误,请使用root用户"
sleep 3
#echo 为了保障功能的使用，将自动退出
echo 为了保障功能的使用，将自动切换用户
sleep 2
echo 请使用sudo来运行此脚本
echo 或者使用Root用户来运行此脚本
sleep 1
echo 正在重新执行脚本，请稍等...
ytil=$(ls /usr/bin/yutoolsw)
if [ $ytil = "/usr/bin/yutoolsw" ]
then
sudo yutoolsw
else
sudo bash -c "$(curl https://gitee.com/yudezeng/yutools/raw/master/yti)"
fi
#exit 1
fi
fi
else
apt install pulseaudio
updatedt
setup 
fi
fio
#main_"$@"