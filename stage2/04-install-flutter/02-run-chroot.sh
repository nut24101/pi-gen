cmake -B /home/pi/flutter-pi/build -S /home/pi/flutter-pi
make -j `nproc` -C /home/pi/flutter-pi/build
make install -C /home/pi/flutter-pi/build

printf "\n[pi4]\ndtoverlay=vc4-fkms-v3d\nmax_framebuffers=2\n\n[all]\ndtoverlay=vc4-fkms-v3d\n" | tee -a /boot/config.txt
usermod -a -G render pi
