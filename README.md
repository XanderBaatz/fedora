# Fedora Minimal (testing phase)

Fedora Minimal is an attempt to create a minmal base, housing the tools to an essential and functional system. \
The general aim is to have a stable and flexible foundation, combined with sane defaults and broad compatibility.

* Based on Fedora Everything (EV) image.
* Simple stock setup of packages and applications.
* Structured in an archive-like order, with additional paths based on choices.
* Able to be easily reproduced in many different environments.

## Installation Guide
### 1. Download and install the ISO
1. Go to [Fedora Alternative Downloads](https://alt.fedoraproject.org/) and download the **Everything** iso.
2. Burn the ISO to a USB drive. Backup any pre-existing files on the USB.
    1. On Windows you can use Fedora's official Media Writer tool to burn the ISO to the USB drive.
    2. On Linux you can use 
3. Continuing
4. Hello
UNDONE!
### 2. Installation setup
If the USB is booted properly, a prompt will show up asking you to install Fedora. \
Select **Test this media & install Fedora**. This will scan the installation media and check for errors, before proceeding to the actual installation setup.

On the initial **WELCOME TO FEDORA** page, simply select your preferred language and hit **Continue**. \
It is recommended to install the system in English if possible.

#### Localization
* Configure preferred **Keyboard**, **Language Support** and **Time & Date** settings.

#### Software
* Set the **Installation Source** to: *Closest mirror*.
* Under **Software Selection** select: *Fedora Custom Operating System*

#### System
1. In **Installation Destination**, choose your preferred installation disk and under **Storage Configuration** click *Custom*, and then click **Done** in the top left.
2. Set the partitioning scheme to **Btrfs**.
3. Click on the `+` icon to create a new **Mount Point**.
4. First select `/boot/efi` or `/boot` under **Mount Point**. Most systems are on EFI nowadays, which means `/boot/efi` is one you should pick. If you're unsure, you can always create both.
    * The **Desired Capacity** for an EFI partition is usually 550 MB.
5. Now create a swap **Mount Point**. You can read all about swap partition size and additional info: [here](https://itsfoss.com/swap-size/) 
6. Finally create a root **Mount Point** by choosing `/` in **Mount Point**.
    * The root partition is where all the system files will reside. It's usually a good idea to leave **Desired Capacity** blank here, which will use the remaining disk space. You can, however, choose any amount just make sure you got enough for your system. At the very least use a minimum of 20-30 GB.

#### User Settings
Ignore the **Root Account** and go directly into **User Creation**.
1. Now write your preferred name. It's recommended to keep it short, lowercased and only including letters.
2. Next, tick **Make this user administrator**.

For obvious security reasons it's good to require a password to access the account. \
If your password is "Too short" simply click **Done** twice to ignore the warning. \
Finally press **Begin Installation** in the bottom right corner of the Installation Summary. 
