# forward-ctl

This project is aim to provide port forwarding feature for libvirt.

## how to install
```
sudo ./install.sh
```

## how to use
```
examples:
sudo forward_ctl set-default enp0s31f6 virbr0
sudo forward_ctl add tcp 12222 Examples 192.168.122.122 22
```
