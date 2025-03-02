#!/bin/bash

#更改默认地址为192.168.6.1
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

#更改默认源地址为山大源
sed -i "s,mirrors.vsean.net/openwrt,mirrors.sdu.edu.cn/immortalwrt,g" package/emortal/default-settings/files/99-default-settings-chinese

##更改主机名
sed -i "s/hostname='.*'/hostname='ImmortalWrt'/g" package/base-files/files/bin/config_generate

##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='ImmortalWrt-$(date +%Y%m%d)'/g"  package/base-files/files/etc/openwrt_release
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' By Toopstarxxx'/g" package/base-files/files/etc/openwrt_release

##WiFi
sed -i "s/MT7981_AX3000_2.4G/CMCC_dd-wrt/g" package/mtk/drivers/wifi-profile/files/mt7981/mt7981.dbdc.b0.dat
sed -i "s/MT7981_AX3000_5G/CMCC_dd-wrt_5G/g" package/mtk/drivers/wifi-profile/files/mt7981/mt7981.dbdc.b1.dat

##New WiFi
sed -i "s/ImmortalWrt-2.4G/CMCC_dd-wrt/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i "s/ImmortalWrt-5G/CMCC_dd-wrt_5G/g" package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
#添加kmod-ipt-socket等Passwall必须模块
cp -rf $GITHUB_WORKSPACE/patchs/iptables-makefile.patch $GITHUB_WORKSPACE/openwrt/p1.patch
patch -p1 < $GITHUB_WORKSPACE/openwrt/p1.patch
cp -rf $GITHUB_WORKSPACE/patchs/netfilter.patch $GITHUB_WORKSPACE/openwrt/p2.patch
patch -p1 < $GITHUB_WORKSPACE/openwrt/p2.patch
