# check folder existense before clone git repo
[ ! -d "home/pi/flutter-pi-img-gen/engine-binaries" ] && git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git home/pi/flutter-pi-img-gen/engine-binaries

# install engine binaries
cd home/pi/flutter-pi-img-gen/engine-binaries
./install.sh
cd /

# check folder existense before clone git repo
[ ! -d "home/pi/flutter-pi-img-gen/flutter-pi " ] && git clone https://github.com/ardera/flutter-pi home/pi/flutter-pi-img-gen/flutter-pi 
# compile flutter-pi and install it
cmake -B /home/pi/flutter-pi-img-gen/flutter-pi/build -S /home/pi/flutter-pi-img-gen/flutter-pi
make -j `nproc` -C /home/pi/flutter-pi-img-gen/flutter-pi/build
make install -C /home/pi/flutter-pi-img-gen/flutter-pi/build

#create mount point for usb
cd /media && mkdir usb

#create soilcrete folder structure
cd /home/admin && mkdir flutter-apps && cd flutter-apps && mkdir soilcrete

#add permission
chmod a+w /home/admin/flutter-apps /home/admin/flutter-apps/soilcrete 

#add necesary config according to flutter-pi's readme 
printf "\n[pi4]\ndtoverlay=vc4-fkms-v3d\nmax_framebuffers=2\n\n[all]\ndtoverlay=vc4-fkms-v3d\n" | tee -a /boot/config.txt

# enable autologin
echo "/bin/login -f admin tty1 </dev/tty1 >/dev/tty1 2>&1\n exit 0" | tee /etc/rc.local

#add .bashrc script for automatically launch soilcrete apps
echo "cd /home/admin/flutter-apps/soilcrete && echo "test"  |  sudo -S  flutter-pi flutter_assets" | tee -a /home/admin/.bashrc

#add admin to render user group
usermod -a -G render admin
