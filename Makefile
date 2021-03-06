HDISK  = images/hd.img
KERNEL = linux/arch/x86_64/boot/bzImage

GUEST_MEM = 1024
GUEST_SMP = 2

QEMU   = qemu-system-x86_64
QFLAGS = -m $(GUEST_MEM) -smp $(GUEST_SMP) -hda $(HDISK) -kernel $(KERNEL) \
         -append "root=/dev/sda" -monitor stdio -usb
QSHARE = -virtfs local,id=shared,path=./share,security_model=passthrough,mount_tag=shared

.PHONY: run setup

run: $(HDISK)
	$(QEMU) $(QFLAGS) $(QSHARE)

setup: $(HDISK)

$(HDISK):
	sudo ./scripts/create-image.sh $(HDISK) 1024
	sudo chown $(USER) $(HDISK)
