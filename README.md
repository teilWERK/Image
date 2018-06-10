# EWindow Image Creator for Raspberry Pi

## Usage

    make sdcard.img

## Requirements:

* qemu-static-arm
* Alpine Linux kernel and initramfs with virtio_net support (patch path in utils/run-qemu.sh)

## Acknowledgements

This is based on nero's apkovl generator scripts
He outlined how this works in [a blog post](https://nero.github.io/2018/04/16/automated-provisioning-using-apkovl.html).
