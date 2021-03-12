qemu-system-aarch64 \
    -machine  virt -machine virtualization=true \
    -cpu cortex-a57 \
    -smp 2 \
    -m 4096M \
    -kernel ../linux/arch/arm64/boot/Image \
    -nographic \
    -append "console=ttyAMA0 init=/linuxrc nokaslr" \
    -initrd ../buildroot/output/images/rootfs.cpio.lzma \
    -fsdev local,security_model=passthrough,id=fsdev0,path=/path/qemu_aarch64 \
    -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare \
    -s -S &
#    -net nic,vlan=0 -net tap,vlan=0,ifname=tap0 \

aarch64-linux-gnu-gdb ./../linux/vmlinux -x gdbinit
