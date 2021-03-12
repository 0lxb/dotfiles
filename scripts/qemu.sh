qemu-system-aarch64 \
	-machine  virt -machine virtualization=true \
	-cpu cortex-a72 \
	-smp 2 \
	-m 4096M \
	-kernel ../linux/arch/arm64/boot/Image \
	-nographic \
	-append "console=ttyAMA0 init=/linuxrc" \
	-initrd ../buildroot/output/images/rootfs.cpio.lzma \
	-drive if=none,format=raw,id=qemu-img-raw,file=/path/qemu_aarch64/qemu-img-raw.img \
	-device ich9-ahci,id=ahci -device ide-hd,drive=qemu-img-raw,bus=ahci.0 \
	-drive if=none,format=qcow2,id=qemu-img-qcow2,file=/path/qemu_aarch64/qemu-img-qcow2.img \
	-device nvme,drive=qemu-img-qcow2,serial=1234 \
	-device usb-ehci,id=ehci \
	-fsdev local,security_model=passthrough,id=fsdev0,path=/path/qemu_aarch64 \
	-device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
	-virtfs local,path=/path/qemu_aarch64,security_model=none,mount_tag=linux \
	-netdev user,id=net0,hostfwd=tcp::5555-:22 \
	-device e1000,netdev=net0
	#-device virtio-net-pci,netdev=net0
