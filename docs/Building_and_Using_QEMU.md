Building and Using QEMU
=======================

# Dependencies

    sudo apt-get --no-install-recommends -y build-dep qemu

# Download QEMU

    git clone git://git.qemu-project.org/qemu.git
    # Checkout last stable branch
    git checkout -b v2.5.0

# Building QEMU

	# Build only x86_64 VM
	./configure --target-list=x86_64-softmmu
	make
	sudo make install