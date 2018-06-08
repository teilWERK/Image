# Usage


    make clean
    make HOST=ewindow
    utils/run-qemu.sh $PWD/ewindow.apkovl.tar.gz


# Requirements:

* qemu-static-arm
* Alpine Linux kernel and initramfs with virtio_net support

# Acknowledgements

This is based on nero's apkovl generator scripts
He outlined how this works in [a blog post](https://nero.github.io/2018/04/16/automated-provisioning-using-apkovl.html).
