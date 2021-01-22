install -m 644 ./flutter-pi-img-gen/engine-binaries/arm/libflutter_engine.so.* /flutter-pi-img-gen/engine-binaries/arm/icudtl.dat "${ROOTFS_DIR}/usr/lib/"
install -m 644 ./flutter-pi-img-gen/engine-binaries/flutter_embedder.h "${ROOTFS_DIR}/usr/include"

cp -r ./flutter-pi-img-gen/flutter-pi "${ROOTFS_DIR}/home/pi"
