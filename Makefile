HDISK  = images/hd.img
KERNEL = linux/arch/x86_64/boot/bzImage
QEMU   = qemu-system-x86_64
QFLAGS = -m 1024 -smp 2 -hda $(HDISK) -kernel $(KERNEL) -append "root=/dev/sda"

.PHONY: run setup

run: $(HDISK)
	$(QEMU) $(QFLAGS)

setup: $(HDISK)

$(HDISK):
	sudo ./scripts/create-image.sh $(HDISK) 1024
	sudo chown $(USER) $(HDISK)
