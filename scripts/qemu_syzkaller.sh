qemu-system-aarch64 \
	-machine  virt -machine virtualization=true \
	-cpu cortex-a72 \
	-smp 2 \
	-m 4096M \
	-kernel ../linux/arch/arm64/boot/Image \
	-nographic \
	-append "console=ttyAMA0 root=/dev/vda oops=panic panic_on_warn=1 panic=-1 ftrace_dump_on_oops=orig_cpu debug earlyprintk=serial slub_debug=UZ" \
	-hda ../buildroot/output/images/rootfs.ext3 \
	-net user,hostfwd=tcp::10023-:22 -net nic
