[ ! -d "home/pi/flutter-pi-img-gen/engine-binaries" ] && git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git home/pi/flutter-pi-img-gen/engine-binaries

cd home/pi/flutter-pi-img-gen/engine-binaries
./install.sh
cd /

[ ! -d "home/pi/flutter-pi-img-gen/flutter-pi " ] && git clone https://github.com/ardera/flutter-pi home/pi/flutter-pi-img-gen/flutter-pi 
cmake -B /home/pi/flutter-pi-img-gen/flutter-pi/build -S /home/pi/flutter-pi-img-gen/flutter-pi
make -j `nproc` -C /home/pi/flutter-pi-img-gen/flutter-pi/build
make install -C /home/pi/flutter-pi-img-gen/flutter-pi/build

cd /media && mkdir usb
cd /home/admin && mkdir flutter-apps && cd flutter-apps && mkdir soilcrete

chmod a+w /home/admin/flutter-apps /home/admin/flutter-apps/soilcrete 

printf "\n[pi4]\ndtoverlay=vc4-fkms-v3d\nmax_framebuffers=2\n\n[all]\ndtoverlay=vc4-fkms-v3d\n" | tee -a /boot/config.txt

echo "cd /home/admin/flutter-apps/soilcrete && flutter-pi flutter_assets" | tee -a /home/admin/.bashrc

usermod -a -G render admin
