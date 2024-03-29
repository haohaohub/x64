#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd -

sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
cp -r luci-theme-argon package/lean

git clone https://github.com/garypang13/luci-app-eqos
cp -r luci-app-eqos package/lean

# svn co https://github.com/Lienol/openwrt-luci/branches/18.06/themes
svn co https://github.com/Lienol/openwrt-luci/trunk
cp -r trunk/themes/luci-theme-argon-dark-mod package/lean
cp -r trunk/themes/luci-theme-argon-light-mod package/lean
cp -r trunk/themes/luci-theme-bootstrap-mod package/lean
cp -r trunk/themes/luci-theme-darkmatter package/lean
