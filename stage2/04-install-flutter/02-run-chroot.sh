#cd home/pi/flutter-pi-img-gen/flutter-engine-binaries-for-arm/
git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git home/pi/flutter-pi-img-gen/engine-binaries
cd home/pi/flutter-pi-img-gen/engine-binaries
./install.sh
cd /

git clone https://github.com/ardera/flutter-pi home/pi/flutter-pi-img-gen/flutter-pi 
cmake -B /home/pi/flutter-pi-img-gen/flutter-pi/build -S /home/pi/flutter-pi
make -j `nproc` -C /home/pi/flutter-pi-img-gen/flutter-pi/build
make install -C /home/pi/flutter-pi-img-gen/flutter-pi/build

cd /media && mkdir usb

printf "\n[pi4]\ndtoverlay=vc4-fkms-v3d\nmax_framebuffers=2\n\n[all]\ndtoverlay=vc4-fkms-v3d\n" | tee -a /boot/config.txt
usermod -a -G render admin
