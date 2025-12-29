# AMD APU Undervolt

### Install Ryzenadj
1. Get `ryzenadj` from [Bazzite copr repo](https://copr.fedorainfracloud.org/coprs/bazzite-org/bazzite/).
2. Set low priority for Bazzite copr ([see here](https://jfearn.fedorapeople.org/fdocs/en-US/Fedora_Draft_Documentation/0.1/html/Musicians_Guide/sect-Musicians_Guide-CCRMA_Repository_Priorities.html)).
3. Install `ryzenadj`.

### Ryzenadj undervolt config
Store the following as [`ryzenadj`](https://github.com/ublue-os/bazzite/blob/8dc7799198e575d708f0bd054a414d497b77e828/system_files/desktop/shared/etc/default/ryzenadj#L4) in `/etc/default`:
```sh
# https://github.com/NGnius/PowerTools/issues/84#issuecomment-1482736698
# https://www.amd.com/system/files/documents/faq-curve-optimizer.pdf
# Expect your UV to be 3-5x your set curve value. IE: -5 = -15mv to -25mv
# 0x100000 - 5 (Range: -30, 30)
UNDERVOLT_AMOUNT=0xFFFFB
# WARNING: As with any undervolt exercise caution.
# There is no guarantee you won't damage your hardware.
# USE AT YOUR OWN RISK.
```### Ryzenadj service
Store the following as [`ryzenadj.service`](https://github.com/ublue-os/bazzite/blob/8dc7799198e575d708f0bd054a414d497b77e828/system_files/desktop/shared/usr/lib/systemd/system/ryzenadj.service#L8) in `/etc/systemd/system`:
```sh
[Unit]
Description=CPU Curve Undervolt

[Service]
Type=oneshot
EnvironmentFile=-/etc/default/%p
ExecStartPre=/usr/bin/sleep 10
ExecStart=/usr/bin/ryzenadj --set-coall=${UNDERVOLT_AMOUNT}

[Install]
WantedBy=multi-user.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target ac.target battery.target
```
