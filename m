Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000B44160C;
	Wed, 12 Aug 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537150; cv=none; b=DoMXtgV42bNnl1A6lS/HmIzJxn+zD4Mhd99X6Mnu6d86Y300X/hpiQMCIjzV+AnBWkSslOu/ee0HNQ7jAI19vIV9qVMoo0ANnxoI0PFGKgS/I1tWsxBlvU7B16FeVG8y/rD/MSkmVY0QAPqnaZtsQyOuJ8pda5HqllPmfXmpsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537150; c=relaxed/simple;
	bh=79KRA0xiUFYbXJs5LhcZNmLn7VcVl5bb4yeg32Tjnpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWJh7HKARjrN72goBYJP6imDD3VF7e7aufrniFzgKM5ZysKpQ3gjYiNMZ/AsRJn9UPMHBnupHIaDA5ENjvQqsR6AtY7W3L/VpYtTLbiE8w3JGPSgYDyxdbpaXRpGg0QLi734kRLjTepnW8yGpKUIrRe3UA9IEUMh1iwt4RgA9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hb2u3Y+q; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=r39W/bQr; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hb2u3Y+q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r39W/bQr"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hKnbD5BK0zKnRX;
	Wed, 12 Aug 2026 14:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786537128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lt0D+jYCOF+pD/iXRF/xj/wr1m8zdXfaDurk4zhVQuo=;
	b=hb2u3Y+qNpxf9XmEjnmlXa+r1GiVCIbAjYvfcG0clmAf6xcwyZ9foXHxX9w21bsatEjRwx
	wKwjSvHXDRoYQSfDxttVXUwLtlAEHuRjKioVwyXAwKgSHJJD3lT8HZ4qMPPhRP6fqMamuZ
	NDabPoo0nlTbPOBfLh72wxQcMh970ZqAu6pklmO8v6xtXD52zcT4yAhRo6CX40R3PF5ANx
	AipM8fnKH6BWC+My2907UFQV15XFvLthsH6GKzwJIQFOV6N/Lwxne3NcsCWNUO1VNRFa+x
	EB0u9mt3IrYDlKg+DStJeJfxoRMcXtUJ8zyDb7sJ6W9n1AkG/BPTV5q60NoNPQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786537126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lt0D+jYCOF+pD/iXRF/xj/wr1m8zdXfaDurk4zhVQuo=;
	b=r39W/bQr6fvS9xBoL9TFGhZn/gVVpU9eGCdLqprh2NK7FH5pRP8nwZnnO/HiwggZcU0jgT
	/N+rI4X25p2GJti7Cr6hAv3DVp4Ws8KxL7DmIXcjgY4aoh0JW9DfedsODNYoblgOCjiLql
	jpu/ixaPJ2TeFtTkPrMJpiboKth8MsJab80e8Qw3cAK+84vIDxYsVf7q9g0q0Cwe0J+0UI
	ux5LJhmMJkabuSMl98XT1ZpxRHBJ6KJcCJq/29DGZJj4iohYuFlNXkZWt0ZI8JfQqxoKry
	2Tus2Sk3AyHPxpBcE8haorXqAa/P8FYcfsj7Szxd08mDutynL+XNgmcqWr3tGw==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/5] Docs: changes.rst: rename file and references and  add links
Date: Wed, 12 Aug 2026 14:14:45 +0200
Message-ID: <20260812121603.1633270-2-manuelebnerli@mailbox.org>
In-Reply-To: <20260812120805.1631430-3-manuelebnerli@mailbox.org>
References: <20260812120805.1631430-3-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hof1aoqwi5c4kdoczq7hsx4kc5x3ncab
X-MBO-RS-ID: cec80f7e41a1e61268f

The current name does not reflect the content of the file, the new name
does so. With the links legacy references should continue to work.

Change name to software-requirements.rst
Change names in Doc/translations/*
Add link Doc/process/changes.rst to software-version.rst.
Add link Doc/Changes to software-version.rst.
Add links in Doc/translations/*
Change changes.rst to software-version.rst inChange changes.rst to software-version.rst in
 Documentation/*
 README
 samples/bpf/README.rst
 scripts/min-tool-version.sh
 scripts/ver_linux

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/Changes                         |   2 +-
 Documentation/admin-guide/README.rst          |   6 +-
 Documentation/doc-guide/sphinx.rst            |   2 +-
 Documentation/filesystems/locks.rst           |   2 +-
 Documentation/process/changes.rst             | 576 +----------------
 Documentation/process/howto.rst               |   2 +-
 .../process/software-requirements.rst         | 575 +++++++++++++++++
 .../translations/it_IT/process/changes.rst    | 554 +----------------
 .../translations/it_IT/process/howto.rst      |   2 +-
 .../it_IT/process/software-requirements.rst   | 553 +++++++++++++++++
 .../translations/ja_JP/process/howto.rst      |   2 +-
 .../translations/ko_KR/process/howto.rst      |   2 +-
 .../translations/pt_BR/process/changes.rst    | 577 +-----------------
 .../pt_BR/process/software-requirements.rst   | 576 +++++++++++++++++
 .../translations/sp_SP/process/howto.rst      |   2 +-
 .../translations/zh_CN/admin-guide/README.rst |   6 +-
 .../translations/zh_CN/process/howto.rst      |   2 +-
 .../translations/zh_TW/admin-guide/README.rst |   6 +-
 .../translations/zh_TW/process/howto.rst      |   2 +-
 README                                        |   2 +-
 samples/bpf/README.rst                        |   2 +-
 scripts/min-tool-version.sh                   |   2 +-
 scripts/ver_linux                             |   2 +-
 23 files changed, 1730 insertions(+), 1727 deletions(-)
 mode change 100644 => 120000 Documentation/process/changes.rst
 create mode 100644 Documentation/process/software-requirements.rst
 mode change 100644 => 120000 Documentation/translations/it_IT/process/changes.rst
 create mode 100644 Documentation/translations/it_IT/process/software-requirements.rst
 mode change 100644 => 120000 Documentation/translations/pt_BR/process/changes.rst
 create mode 100644 Documentation/translations/pt_BR/process/software-requirements.rst

diff --git a/Documentation/Changes b/Documentation/Changes
index 7564ae1682ba..544d57a6d34b 120000
--- a/Documentation/Changes
+++ b/Documentation/Changes
@@ -1 +1 @@
-process/changes.rst
\ No newline at end of file
+process/software-requirements.rst
\ No newline at end of file
diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 77fec1de6dc8..9d1e1938b23d 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -52,7 +52,7 @@ Documentation
  - There are various README files in the Documentation/ subdirectory:
    these typically contain kernel-specific installation notes for some
    drivers for example. Please read the
-   :ref:`Documentation/process/changes.rst <changes>` file, as it
+   :ref:`Documentation/process/software-requirements.rst <software-requirements>` file, as it
    contains information about the problems which may result from upgrading
    your kernel.
 
@@ -116,7 +116,7 @@ Software requirements
 
    Compiling and running the 6.x kernels requires up-to-date
    versions of various software packages.  Consult
-   :ref:`Documentation/process/changes.rst <changes>` for the minimum version numbers
+   :ref:`Documentation/process/software-requirements.rst <software-requirements>` for the minimum version numbers
    required and how to get updates for these packages.  Beware that using
    excessively old versions of these packages can cause indirect
    errors that are very difficult to track down, so don't assume that
@@ -260,7 +260,7 @@ Compiling the kernel
 --------------------
 
  - Make sure you have at least gcc 8.1 available.
-   For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
+   For more information, refer to :ref:`Documentation/process/software-requirements.rst <software-requirements>`.
 
  - Do a ``make`` to create a compressed kernel image. It is also possible to do
    ``make install`` if you have lilo installed or if your distribution has an
diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 51c370260f3b..d4a014168f00 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -140,7 +140,7 @@ becoming harder to do that on modern distributions, as it is not
 possible to install with Python 3.13 and above.
 
 Testing with the lowest supported Python version as defined at
-Documentation/process/changes.rst can be done by creating
+Documentation/process/software-requirements.rst can be done by creating
 a venv with it with, and install minimal requirements with::
 
 	/usr/bin/python3.9 -m venv sphinx_min
diff --git a/Documentation/filesystems/locks.rst b/Documentation/filesystems/locks.rst
index 26429317dbbc..71b48a159507 100644
--- a/Documentation/filesystems/locks.rst
+++ b/Documentation/filesystems/locks.rst
@@ -23,7 +23,7 @@ forever.
 
 This should not cause problems for anybody, since everybody using a
 2.1.x kernel should have updated their C library to a suitable version
-anyway (see the file "Documentation/process/changes.rst".)
+anyway (see the file "Documentation/process/software-requirements.rst".)
 
 1.2 Allow Mixed Locks Again
 ---------------------------
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
deleted file mode 100644
index 1ca8c5f73ad0..000000000000
--- a/Documentation/process/changes.rst
+++ /dev/null
@@ -1,575 +0,0 @@
-.. _changes:
-
-Minimal requirements to compile the Kernel
-++++++++++++++++++++++++++++++++++++++++++
-
-Intro
-=====
-
-This document is designed to provide a list of the minimum levels of
-software necessary to run the current kernel version.
-
-This document is originally based on my "Changes" file for 2.0.x kernels
-and therefore owes credit to the same people as that file (Jared Mauch,
-Axel Boldt, Alessandro Sigala, and countless other users all over the
-'net).
-
-Current Minimal Requirements
-****************************
-
-Upgrade to at **least** these software revisions before thinking you've
-encountered a bug!  If you're unsure what version you're currently
-running, the suggested command should tell you. For a list of the programs
-on your system including their version execute ./scripts/ver_linux
-
-Again, keep in mind that this list assumes you are already functionally
-running a Linux kernel.  Also, not all tools are necessary on all
-systems; obviously, if you don't have any PC Card hardware, for example,
-you probably do not need to concern yourself with pcmciautils.
-
-====================== ===============  ========================================
-        Program        Minimal version       Command to check the version
-====================== ===============  ========================================
-bash                   4.2              bash --version
-bc                     1.06.95          bc --version
-bindgen (optional)     0.71.1           bindgen --version
-binutils               2.30             ld -v
-bison                  2.0              bison --version
-btrfs-progs            0.18             btrfs --version
-Clang/LLVM (optional)  17.0.1           clang --version
-e2fsprogs              1.41.4           e2fsck -V
-flex                   2.5.35           flex --version
-gdb                    7.2              gdb --version
-GNU awk (optional)     5.1.0            gawk --version
-GNU C                  8.1              gcc --version
-GNU make               4.0              make --version
-GNU tar                1.28             tar --version
-GRUB                   0.93             grub --version || grub-install --version
-gtags (optional)       6.6.5            gtags --version
-iptables               1.4.2            iptables -V
-jfsutils               1.1.3            fsck.jfs -V
-kmod                   13               kmod -V
-mcelog                 0.6              mcelog --version
-mkimage (optional)     2017.01          mkimage --version
-nfs-utils              1.0.5            showmount --version
-openssl & libcrypto    1.0.0            openssl version
-pahole                 1.26             pahole --version
-pcmciautils            004              pccardctl -V
-PPP                    2.4.0            pppd --version
-procps                 3.2.0            ps --version
-Python                 3.9.x            python3 --version
-quota-tools            3.09             quota -V
-Rust (optional)        1.85.0           rustc --version
-Sphinx\ [#f1]_         3.4.3            sphinx-build --version
-squashfs-tools         4.0              mksquashfs -version
-udev                   081              udevadm --version
-util-linux             2.10o            mount --version
-xfsprogs               2.6.0            xfs_db -V
-====================== ===============  ========================================
-
-.. [#f1] Sphinx is needed only to build the Kernel documentation
-
-Kernel compilation
-******************
-
-GCC
----
-
-The gcc version requirements may vary depending on the type of CPU in your
-computer.
-
-Clang/LLVM (optional)
----------------------
-
-The latest formal release of clang and LLVM utils (according to
-`releases.llvm.org <https://releases.llvm.org>`_) are supported for building
-kernels. Older releases aren't guaranteed to work, and we may drop workarounds
-from the kernel that were used to support older versions. Please see additional
-docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
-
-Rust (optional)
----------------
-
-A recent version of the Rust compiler is required.
-
-Please see Documentation/rust/quick-start.rst for instructions on how to
-satisfy the build requirements of Rust support. In particular, the ``Makefile``
-target ``rustavailable`` is useful to check why the Rust toolchain may not
-be detected.
-
-bindgen (optional)
-------------------
-
-``bindgen`` is used to generate the Rust bindings to the C side of the kernel.
-It depends on ``libclang``.
-
-Make
-----
-
-You will need GNU make 4.0 or later to build the kernel.
-
-Bash
-----
-
-Some bash scripts are used for the kernel build.
-Bash 4.2 or newer is needed.
-
-Binutils
---------
-
-Binutils 2.30 or newer is needed to build the kernel.
-
-pkg-config
-----------
-
-The build system, as of 4.18, requires pkg-config to check for installed
-kconfig tools and to determine flags settings for use in
-'make {g,x}config'.  Previously pkg-config was being used but not
-verified or documented.
-
-Flex
-----
-
-Since Linux 4.16, the build system generates lexical analyzers
-during build.  This requires flex 2.5.35 or later.
-
-
-Bison
------
-
-Since Linux 4.16, the build system generates parsers
-during build.  This requires bison 2.0 or later.
-
-pahole
-------
-
-Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
-generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
-modules as well.  This requires pahole v1.22 or later.
-
-Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
-or later.  Without it, such kfuncs will have incorrect BTF prototypes in
-vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
-with vmlinux" error.  Many sched_ext kfuncs are affected.
-
-It is found in the 'dwarves' or 'pahole' distro packages or from
-https://fedorapeople.org/~acme/dwarves/.
-
-Perl
-----
-
-You will need perl 5 and the following modules: ``Getopt::Long``,
-``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
-
-Python
-------
-
-Several config options require it: it is required for arm/arm64
-default configs, CONFIG_LTO_CLANG, some DRM optional configs,
-the kernel-doc tool, and docs build (Sphinx), among others.
-
-BC
---
-
-You will need bc to build kernels 3.10 and higher
-
-
-OpenSSL
--------
-
-Module signing and external certificate handling use the OpenSSL program and
-crypto library to do key creation and signature generation.
-
-You will need openssl to build kernels 3.7 and higher if module signing is
-enabled.  You will also need openssl development packages to build kernels 4.3
-and higher.
-
-Tar
----
-
-GNU tar is needed if you want to enable access to the kernel headers via sysfs
-(CONFIG_IKHEADERS).
-
-gtags / GNU GLOBAL (optional)
------------------------------
-
-The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
-tag files through ``make gtags``.  This is due to its use of the gtags
-``-C (--directory)`` flag.
-
-mkimage
--------
-
-This tool is used when building a Flat Image Tree (FIT), commonly used on ARM
-platforms. The tool is available via the ``u-boot-tools`` package or can be
-built from the U-Boot source code. See the instructions at
-https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
-
-GNU AWK
--------
-
-GNU AWK is needed if you want kernel builds to generate address range data for
-builtin modules (CONFIG_BUILTIN_MODULE_RANGES).
-
-System utilities
-****************
-
-Architectural changes
----------------------
-
-DevFS has been obsoleted in favour of udev
-(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
-
-32-bit UID support is now in place.  Have fun!
-
-Linux documentation for functions is transitioning to inline
-documentation via specially-formatted comments near their
-definitions in the source.  These comments can be combined with ReST
-files in the Documentation/ directory to make enriched documentation, which can
-then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
-In order to convert from ReST format to a format of your choice, you'll need
-Sphinx.
-
-Util-linux
-----------
-
-New versions of util-linux provide ``fdisk`` support for larger disks,
-support new options to mount, recognize more supported partition
-types, and similar goodies.
-You'll probably want to upgrade.
-
-Ksymoops
---------
-
-If the unthinkable happens and your kernel oopses, you may need the
-ksymoops tool to decode it, but in most cases you don't.
-It is generally preferred to build the kernel with ``CONFIG_KALLSYMS`` so
-that it produces readable dumps that can be used as-is (this also
-produces better output than ksymoops).  If for some reason your kernel
-is not build with ``CONFIG_KALLSYMS`` and you have no way to rebuild and
-reproduce the Oops with that option, then you can still decode that Oops
-with ksymoops.
-
-Mkinitrd
---------
-
-These changes to the ``/lib/modules`` file tree layout also require that
-mkinitrd be upgraded.
-
-E2fsprogs
----------
-
-The latest version of ``e2fsprogs`` fixes several bugs in fsck and
-debugfs.  Obviously, it's a good idea to upgrade.
-
-JFSutils
---------
-
-The ``jfsutils`` package contains the utilities for the file system.
-The following utilities are available:
-
-- ``fsck.jfs`` - initiate replay of the transaction log, and check
-  and repair a JFS formatted partition.
-
-- ``mkfs.jfs`` - create a JFS formatted partition.
-
-- other file system utilities are also available in this package.
-
-Xfsprogs
---------
-
-The latest version of ``xfsprogs`` contains ``mkfs.xfs``, ``xfs_db``, and the
-``xfs_repair`` utilities, among others, for the XFS filesystem.  It is
-architecture independent and any version from 2.0.0 onward should
-work correctly with this version of the XFS kernel code (2.6.0 or
-later is recommended, due to some significant improvements).
-
-PCMCIAutils
------------
-
-PCMCIAutils replaces ``pcmcia-cs``. It properly sets up
-PCMCIA sockets at system startup and loads the appropriate modules
-for 16-bit PCMCIA devices if the kernel is modularized and the hotplug
-subsystem is used.
-
-Quota-tools
------------
-
-Support for 32 bit uid's and gid's is required if you want to use
-the newer version 2 quota format.  Quota-tools version 3.07 and
-newer has this support.  Use the recommended version or newer
-from the table above.
-
-Intel IA32 microcode
---------------------
-
-A driver has been added to allow updating of Intel IA32 microcode,
-accessible as a normal (misc) character device.  If you are not using
-udev you may need to::
-
-  mkdir /dev/cpu
-  mknod /dev/cpu/microcode c 10 184
-  chmod 0644 /dev/cpu/microcode
-
-as root before you can use this.  You'll probably also want to
-get the user-space microcode_ctl utility to use with this.
-
-udev
-----
-
-``udev`` is a userspace application for populating ``/dev`` dynamically with
-only entries for devices actually present. ``udev`` replaces the basic
-functionality of devfs, while allowing persistent device naming for
-devices.
-
-FUSE
-----
-
-Needs libfuse 2.4.0 or later.  Absolute minimum is 2.3.0 but mount
-options ``direct_io`` and ``kernel_cache`` won't work.
-
-Networking
-**********
-
-General changes
----------------
-
-If you have advanced network configuration needs, you should probably
-consider using the network tools from ip-route2.
-
-Packet Filter / NAT
--------------------
-The packet filtering and NAT code uses the same tools like the previous 2.4.x
-kernel series (iptables).  It still includes backwards-compatibility modules
-for 2.2.x-style ipchains and 2.0.x-style ipfwadm.
-
-PPP
----
-
-The PPP driver has been restructured to support multilink and to
-enable it to operate over diverse media layers.  If you use PPP,
-upgrade pppd to at least 2.4.0.
-
-If you are not using udev, you must have the device file /dev/ppp
-which can be made by::
-
-  mknod /dev/ppp c 108 0
-
-as root.
-
-NFS-utils
----------
-
-In ancient (2.4 and earlier) kernels, the nfs server needed to know
-about any client that expected to be able to access files via NFS.  This
-information would be given to the kernel by ``mountd`` when the client
-mounted the filesystem, or by ``exportfs`` at system startup.  exportfs
-would take information about active clients from ``/var/lib/nfs/rmtab``.
-
-This approach is quite fragile as it depends on rmtab being correct
-which is not always easy, particularly when trying to implement
-fail-over.  Even when the system is working well, ``rmtab`` suffers from
-getting lots of old entries that never get removed.
-
-With modern kernels we have the option of having the kernel tell mountd
-when it gets a request from an unknown host, and mountd can give
-appropriate export information to the kernel.  This removes the
-dependency on ``rmtab`` and means that the kernel only needs to know about
-currently active clients.
-
-To enable this new functionality, you need to::
-
-  mount -t nfsd nfsd /proc/fs/nfsd
-
-before running exportfs or mountd.  It is recommended that all NFS
-services be protected from the internet-at-large by a firewall where
-that is possible.
-
-mcelog
-------
-
-On x86 kernels the mcelog utility is needed to process and log machine check
-events when ``CONFIG_X86_MCE`` is enabled. Machine check events are errors
-reported by the CPU. Processing them is strongly encouraged.
-
-Kernel documentation
-********************
-
-Sphinx
-------
-
-Please see :ref:`sphinx_install` in Documentation/doc-guide/sphinx.rst
-for details about Sphinx requirements.
-
-rustdoc
--------
-
-``rustdoc`` is used to generate the documentation for Rust code. Please see
-Documentation/rust/general-information.rst for more information.
-
-Getting updated software
-========================
-
-Kernel compilation
-******************
-
-gcc
----
-
-- <ftp://ftp.gnu.org/gnu/gcc/>
-
-Clang/LLVM
-----------
-
-- :ref:`Getting LLVM <getting_llvm>`.
-
-Rust
-----
-
-- Documentation/rust/quick-start.rst.
-
-bindgen
--------
-
-- Documentation/rust/quick-start.rst.
-
-Make
-----
-
-- <ftp://ftp.gnu.org/gnu/make/>
-
-Bash
-----
-
-- <ftp://ftp.gnu.org/gnu/bash/>
-
-Binutils
---------
-
-- <https://www.kernel.org/pub/linux/devel/binutils/>
-
-Flex
-----
-
-- <https://github.com/westes/flex/releases>
-
-Bison
------
-
-- <ftp://ftp.gnu.org/gnu/bison/>
-
-OpenSSL
--------
-
-- <https://www.openssl.org/>
-
-System utilities
-****************
-
-Util-linux
-----------
-
-- <https://www.kernel.org/pub/linux/utils/util-linux/>
-
-Kmod
-----
-
-- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
-- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
-
-Ksymoops
---------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
-
-Mkinitrd
---------
-
-- <https://code.launchpad.net/initrd-tools/main>
-
-E2fsprogs
----------
-
-- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
-- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
-
-JFSutils
---------
-
-- <https://jfs.sourceforge.net/>
-
-Xfsprogs
---------
-
-- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
-- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
-
-Pcmciautils
------------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
-
-Quota-tools
------------
-
-- <https://sourceforge.net/projects/linuxquota/>
-
-
-Intel P6 microcode
-------------------
-
-- <https://downloadcenter.intel.com/>
-
-udev
-----
-
-- <https://www.freedesktop.org/software/systemd/man/udev.html>
-
-FUSE
-----
-
-- <https://github.com/libfuse/libfuse/releases>
-
-mcelog
-------
-
-- <https://www.mcelog.org/>
-
-Networking
-**********
-
-PPP
----
-
-- <https://download.samba.org/pub/ppp/>
-- <https://git.ozlabs.org/?p=ppp.git>
-- <https://github.com/paulusmack/ppp/>
-
-NFS-utils
----------
-
-- <https://sourceforge.net/project/showfiles.php?group_id=14>
-- <https://nfs.sourceforge.net/>
-
-Iptables
---------
-
-- <https://netfilter.org/projects/iptables/index.html>
-
-Ip-route2
----------
-
-- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
-
-OProfile
---------
-
-- <https://oprofile.sf.net/download/>
-
-Kernel documentation
-********************
-
-Sphinx
-------
-
-- <https://www.sphinx-doc.org/>
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
new file mode 120000
index 000000000000..ef3fa664d434
--- /dev/null
+++ b/Documentation/process/changes.rst
@@ -0,0 +1 @@
+/home/manuel/linux/Documentation/process/software-requirements.rst
\ No newline at end of file
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index 9438e03d6f50..8c5577d450f9 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -92,7 +92,7 @@ required reading:
     what is necessary to do to configure and build the kernel.  People
     who are new to the kernel should start here.
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements>`
     This file gives a list of the minimum levels of various software
     packages that are necessary to build and run the kernel
     successfully.
diff --git a/Documentation/process/software-requirements.rst b/Documentation/process/software-requirements.rst
new file mode 100644
index 000000000000..1ca8c5f73ad0
--- /dev/null
+++ b/Documentation/process/software-requirements.rst
@@ -0,0 +1,575 @@
+.. _changes:
+
+Minimal requirements to compile the Kernel
+++++++++++++++++++++++++++++++++++++++++++
+
+Intro
+=====
+
+This document is designed to provide a list of the minimum levels of
+software necessary to run the current kernel version.
+
+This document is originally based on my "Changes" file for 2.0.x kernels
+and therefore owes credit to the same people as that file (Jared Mauch,
+Axel Boldt, Alessandro Sigala, and countless other users all over the
+'net).
+
+Current Minimal Requirements
+****************************
+
+Upgrade to at **least** these software revisions before thinking you've
+encountered a bug!  If you're unsure what version you're currently
+running, the suggested command should tell you. For a list of the programs
+on your system including their version execute ./scripts/ver_linux
+
+Again, keep in mind that this list assumes you are already functionally
+running a Linux kernel.  Also, not all tools are necessary on all
+systems; obviously, if you don't have any PC Card hardware, for example,
+you probably do not need to concern yourself with pcmciautils.
+
+====================== ===============  ========================================
+        Program        Minimal version       Command to check the version
+====================== ===============  ========================================
+bash                   4.2              bash --version
+bc                     1.06.95          bc --version
+bindgen (optional)     0.71.1           bindgen --version
+binutils               2.30             ld -v
+bison                  2.0              bison --version
+btrfs-progs            0.18             btrfs --version
+Clang/LLVM (optional)  17.0.1           clang --version
+e2fsprogs              1.41.4           e2fsck -V
+flex                   2.5.35           flex --version
+gdb                    7.2              gdb --version
+GNU awk (optional)     5.1.0            gawk --version
+GNU C                  8.1              gcc --version
+GNU make               4.0              make --version
+GNU tar                1.28             tar --version
+GRUB                   0.93             grub --version || grub-install --version
+gtags (optional)       6.6.5            gtags --version
+iptables               1.4.2            iptables -V
+jfsutils               1.1.3            fsck.jfs -V
+kmod                   13               kmod -V
+mcelog                 0.6              mcelog --version
+mkimage (optional)     2017.01          mkimage --version
+nfs-utils              1.0.5            showmount --version
+openssl & libcrypto    1.0.0            openssl version
+pahole                 1.26             pahole --version
+pcmciautils            004              pccardctl -V
+PPP                    2.4.0            pppd --version
+procps                 3.2.0            ps --version
+Python                 3.9.x            python3 --version
+quota-tools            3.09             quota -V
+Rust (optional)        1.85.0           rustc --version
+Sphinx\ [#f1]_         3.4.3            sphinx-build --version
+squashfs-tools         4.0              mksquashfs -version
+udev                   081              udevadm --version
+util-linux             2.10o            mount --version
+xfsprogs               2.6.0            xfs_db -V
+====================== ===============  ========================================
+
+.. [#f1] Sphinx is needed only to build the Kernel documentation
+
+Kernel compilation
+******************
+
+GCC
+---
+
+The gcc version requirements may vary depending on the type of CPU in your
+computer.
+
+Clang/LLVM (optional)
+---------------------
+
+The latest formal release of clang and LLVM utils (according to
+`releases.llvm.org <https://releases.llvm.org>`_) are supported for building
+kernels. Older releases aren't guaranteed to work, and we may drop workarounds
+from the kernel that were used to support older versions. Please see additional
+docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
+Rust (optional)
+---------------
+
+A recent version of the Rust compiler is required.
+
+Please see Documentation/rust/quick-start.rst for instructions on how to
+satisfy the build requirements of Rust support. In particular, the ``Makefile``
+target ``rustavailable`` is useful to check why the Rust toolchain may not
+be detected.
+
+bindgen (optional)
+------------------
+
+``bindgen`` is used to generate the Rust bindings to the C side of the kernel.
+It depends on ``libclang``.
+
+Make
+----
+
+You will need GNU make 4.0 or later to build the kernel.
+
+Bash
+----
+
+Some bash scripts are used for the kernel build.
+Bash 4.2 or newer is needed.
+
+Binutils
+--------
+
+Binutils 2.30 or newer is needed to build the kernel.
+
+pkg-config
+----------
+
+The build system, as of 4.18, requires pkg-config to check for installed
+kconfig tools and to determine flags settings for use in
+'make {g,x}config'.  Previously pkg-config was being used but not
+verified or documented.
+
+Flex
+----
+
+Since Linux 4.16, the build system generates lexical analyzers
+during build.  This requires flex 2.5.35 or later.
+
+
+Bison
+-----
+
+Since Linux 4.16, the build system generates parsers
+during build.  This requires bison 2.0 or later.
+
+pahole
+------
+
+Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
+generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
+modules as well.  This requires pahole v1.22 or later.
+
+Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
+or later.  Without it, such kfuncs will have incorrect BTF prototypes in
+vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
+with vmlinux" error.  Many sched_ext kfuncs are affected.
+
+It is found in the 'dwarves' or 'pahole' distro packages or from
+https://fedorapeople.org/~acme/dwarves/.
+
+Perl
+----
+
+You will need perl 5 and the following modules: ``Getopt::Long``,
+``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
+
+Python
+------
+
+Several config options require it: it is required for arm/arm64
+default configs, CONFIG_LTO_CLANG, some DRM optional configs,
+the kernel-doc tool, and docs build (Sphinx), among others.
+
+BC
+--
+
+You will need bc to build kernels 3.10 and higher
+
+
+OpenSSL
+-------
+
+Module signing and external certificate handling use the OpenSSL program and
+crypto library to do key creation and signature generation.
+
+You will need openssl to build kernels 3.7 and higher if module signing is
+enabled.  You will also need openssl development packages to build kernels 4.3
+and higher.
+
+Tar
+---
+
+GNU tar is needed if you want to enable access to the kernel headers via sysfs
+(CONFIG_IKHEADERS).
+
+gtags / GNU GLOBAL (optional)
+-----------------------------
+
+The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
+tag files through ``make gtags``.  This is due to its use of the gtags
+``-C (--directory)`` flag.
+
+mkimage
+-------
+
+This tool is used when building a Flat Image Tree (FIT), commonly used on ARM
+platforms. The tool is available via the ``u-boot-tools`` package or can be
+built from the U-Boot source code. See the instructions at
+https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
+
+GNU AWK
+-------
+
+GNU AWK is needed if you want kernel builds to generate address range data for
+builtin modules (CONFIG_BUILTIN_MODULE_RANGES).
+
+System utilities
+****************
+
+Architectural changes
+---------------------
+
+DevFS has been obsoleted in favour of udev
+(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+
+32-bit UID support is now in place.  Have fun!
+
+Linux documentation for functions is transitioning to inline
+documentation via specially-formatted comments near their
+definitions in the source.  These comments can be combined with ReST
+files in the Documentation/ directory to make enriched documentation, which can
+then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
+In order to convert from ReST format to a format of your choice, you'll need
+Sphinx.
+
+Util-linux
+----------
+
+New versions of util-linux provide ``fdisk`` support for larger disks,
+support new options to mount, recognize more supported partition
+types, and similar goodies.
+You'll probably want to upgrade.
+
+Ksymoops
+--------
+
+If the unthinkable happens and your kernel oopses, you may need the
+ksymoops tool to decode it, but in most cases you don't.
+It is generally preferred to build the kernel with ``CONFIG_KALLSYMS`` so
+that it produces readable dumps that can be used as-is (this also
+produces better output than ksymoops).  If for some reason your kernel
+is not build with ``CONFIG_KALLSYMS`` and you have no way to rebuild and
+reproduce the Oops with that option, then you can still decode that Oops
+with ksymoops.
+
+Mkinitrd
+--------
+
+These changes to the ``/lib/modules`` file tree layout also require that
+mkinitrd be upgraded.
+
+E2fsprogs
+---------
+
+The latest version of ``e2fsprogs`` fixes several bugs in fsck and
+debugfs.  Obviously, it's a good idea to upgrade.
+
+JFSutils
+--------
+
+The ``jfsutils`` package contains the utilities for the file system.
+The following utilities are available:
+
+- ``fsck.jfs`` - initiate replay of the transaction log, and check
+  and repair a JFS formatted partition.
+
+- ``mkfs.jfs`` - create a JFS formatted partition.
+
+- other file system utilities are also available in this package.
+
+Xfsprogs
+--------
+
+The latest version of ``xfsprogs`` contains ``mkfs.xfs``, ``xfs_db``, and the
+``xfs_repair`` utilities, among others, for the XFS filesystem.  It is
+architecture independent and any version from 2.0.0 onward should
+work correctly with this version of the XFS kernel code (2.6.0 or
+later is recommended, due to some significant improvements).
+
+PCMCIAutils
+-----------
+
+PCMCIAutils replaces ``pcmcia-cs``. It properly sets up
+PCMCIA sockets at system startup and loads the appropriate modules
+for 16-bit PCMCIA devices if the kernel is modularized and the hotplug
+subsystem is used.
+
+Quota-tools
+-----------
+
+Support for 32 bit uid's and gid's is required if you want to use
+the newer version 2 quota format.  Quota-tools version 3.07 and
+newer has this support.  Use the recommended version or newer
+from the table above.
+
+Intel IA32 microcode
+--------------------
+
+A driver has been added to allow updating of Intel IA32 microcode,
+accessible as a normal (misc) character device.  If you are not using
+udev you may need to::
+
+  mkdir /dev/cpu
+  mknod /dev/cpu/microcode c 10 184
+  chmod 0644 /dev/cpu/microcode
+
+as root before you can use this.  You'll probably also want to
+get the user-space microcode_ctl utility to use with this.
+
+udev
+----
+
+``udev`` is a userspace application for populating ``/dev`` dynamically with
+only entries for devices actually present. ``udev`` replaces the basic
+functionality of devfs, while allowing persistent device naming for
+devices.
+
+FUSE
+----
+
+Needs libfuse 2.4.0 or later.  Absolute minimum is 2.3.0 but mount
+options ``direct_io`` and ``kernel_cache`` won't work.
+
+Networking
+**********
+
+General changes
+---------------
+
+If you have advanced network configuration needs, you should probably
+consider using the network tools from ip-route2.
+
+Packet Filter / NAT
+-------------------
+The packet filtering and NAT code uses the same tools like the previous 2.4.x
+kernel series (iptables).  It still includes backwards-compatibility modules
+for 2.2.x-style ipchains and 2.0.x-style ipfwadm.
+
+PPP
+---
+
+The PPP driver has been restructured to support multilink and to
+enable it to operate over diverse media layers.  If you use PPP,
+upgrade pppd to at least 2.4.0.
+
+If you are not using udev, you must have the device file /dev/ppp
+which can be made by::
+
+  mknod /dev/ppp c 108 0
+
+as root.
+
+NFS-utils
+---------
+
+In ancient (2.4 and earlier) kernels, the nfs server needed to know
+about any client that expected to be able to access files via NFS.  This
+information would be given to the kernel by ``mountd`` when the client
+mounted the filesystem, or by ``exportfs`` at system startup.  exportfs
+would take information about active clients from ``/var/lib/nfs/rmtab``.
+
+This approach is quite fragile as it depends on rmtab being correct
+which is not always easy, particularly when trying to implement
+fail-over.  Even when the system is working well, ``rmtab`` suffers from
+getting lots of old entries that never get removed.
+
+With modern kernels we have the option of having the kernel tell mountd
+when it gets a request from an unknown host, and mountd can give
+appropriate export information to the kernel.  This removes the
+dependency on ``rmtab`` and means that the kernel only needs to know about
+currently active clients.
+
+To enable this new functionality, you need to::
+
+  mount -t nfsd nfsd /proc/fs/nfsd
+
+before running exportfs or mountd.  It is recommended that all NFS
+services be protected from the internet-at-large by a firewall where
+that is possible.
+
+mcelog
+------
+
+On x86 kernels the mcelog utility is needed to process and log machine check
+events when ``CONFIG_X86_MCE`` is enabled. Machine check events are errors
+reported by the CPU. Processing them is strongly encouraged.
+
+Kernel documentation
+********************
+
+Sphinx
+------
+
+Please see :ref:`sphinx_install` in Documentation/doc-guide/sphinx.rst
+for details about Sphinx requirements.
+
+rustdoc
+-------
+
+``rustdoc`` is used to generate the documentation for Rust code. Please see
+Documentation/rust/general-information.rst for more information.
+
+Getting updated software
+========================
+
+Kernel compilation
+******************
+
+gcc
+---
+
+- <ftp://ftp.gnu.org/gnu/gcc/>
+
+Clang/LLVM
+----------
+
+- :ref:`Getting LLVM <getting_llvm>`.
+
+Rust
+----
+
+- Documentation/rust/quick-start.rst.
+
+bindgen
+-------
+
+- Documentation/rust/quick-start.rst.
+
+Make
+----
+
+- <ftp://ftp.gnu.org/gnu/make/>
+
+Bash
+----
+
+- <ftp://ftp.gnu.org/gnu/bash/>
+
+Binutils
+--------
+
+- <https://www.kernel.org/pub/linux/devel/binutils/>
+
+Flex
+----
+
+- <https://github.com/westes/flex/releases>
+
+Bison
+-----
+
+- <ftp://ftp.gnu.org/gnu/bison/>
+
+OpenSSL
+-------
+
+- <https://www.openssl.org/>
+
+System utilities
+****************
+
+Util-linux
+----------
+
+- <https://www.kernel.org/pub/linux/utils/util-linux/>
+
+Kmod
+----
+
+- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
+Ksymoops
+--------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
+
+Mkinitrd
+--------
+
+- <https://code.launchpad.net/initrd-tools/main>
+
+E2fsprogs
+---------
+
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
+
+JFSutils
+--------
+
+- <https://jfs.sourceforge.net/>
+
+Xfsprogs
+--------
+
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
+- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
+
+Pcmciautils
+-----------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
+
+Quota-tools
+-----------
+
+- <https://sourceforge.net/projects/linuxquota/>
+
+
+Intel P6 microcode
+------------------
+
+- <https://downloadcenter.intel.com/>
+
+udev
+----
+
+- <https://www.freedesktop.org/software/systemd/man/udev.html>
+
+FUSE
+----
+
+- <https://github.com/libfuse/libfuse/releases>
+
+mcelog
+------
+
+- <https://www.mcelog.org/>
+
+Networking
+**********
+
+PPP
+---
+
+- <https://download.samba.org/pub/ppp/>
+- <https://git.ozlabs.org/?p=ppp.git>
+- <https://github.com/paulusmack/ppp/>
+
+NFS-utils
+---------
+
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://nfs.sourceforge.net/>
+
+Iptables
+--------
+
+- <https://netfilter.org/projects/iptables/index.html>
+
+Ip-route2
+---------
+
+- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
+
+OProfile
+--------
+
+- <https://oprofile.sf.net/download/>
+
+Kernel documentation
+********************
+
+Sphinx
+------
+
+- <https://www.sphinx-doc.org/>
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
deleted file mode 100644
index 7ee54c972418..000000000000
--- a/Documentation/translations/it_IT/process/changes.rst
+++ /dev/null
@@ -1,553 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: :ref:`Documentation/process/changes.rst <changes>`
-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
-
-.. _it_changes:
-
-Requisiti minimi per compilare il kernel
-++++++++++++++++++++++++++++++++++++++++
-
-Introduzione
-============
-
-Questo documento fornisce una lista dei software necessari per eseguire questa
-versione del kernel.
-
-Questo documento è basato sul file "Changes" del kernel 2.0.x e quindi le
-persone che lo scrissero meritano credito (Jared Mauch, Axel Boldt,
-Alessandro Sigala, e tanti altri nella rete).
-
-Requisiti minimi correnti
-*************************
-
-Prima di pensare d'avere trovato un baco, aggiornate i seguenti programmi
-**almeno** alla versione indicata!  Se non siete certi della versione che state
-usando, il comando indicato dovrebbe dirvelo.
-
-Questa lista presume che abbiate già un kernel Linux funzionante.  In aggiunta,
-non tutti gli strumenti sono necessari ovunque; ovviamente, se non avete una
-PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
-
-====================== =================  ========================================
-        Programma       Versione minima       Comando per verificare la versione
-====================== =================  ========================================
-GNU C                  8.1                gcc --version
-Clang/LLVM (optional)  17.0.1             clang --version
-Rust (opzionale)       1.78.0             rustc --version
-bindgen (opzionale)    0.65.1             bindgen --version
-GNU make               4.0                make --version
-bash                   4.2                bash --version
-binutils               2.30               ld -v
-flex                   2.5.35             flex --version
-bison                  2.0                bison --version
-pahole                 1.16               pahole --version
-util-linux             2.10o              mount --version
-kmod                   13                 depmod -V
-e2fsprogs              1.41.4             e2fsck -V
-jfsutils               1.1.3              fsck.jfs -V
-xfsprogs               2.6.0              xfs_db -V
-squashfs-tools         4.0                mksquashfs -version
-btrfs-progs            0.18               btrfsck
-pcmciautils            004                pccardctl -V
-quota-tools            3.09               quota -V
-PPP                    2.4.0              pppd --version
-nfs-utils              1.0.5              showmount --version
-procps                 3.2.0              ps --version
-udev                   081                udevd --version
-grub                   0.93               grub --version || grub-install --version
-mcelog                 0.6                mcelog --version
-iptables               1.4.2              iptables -V
-openssl & libcrypto    1.0.0              openssl version
-bc                     1.06.95            bc --version
-Sphinx\ [#f1]_         2.4.4              sphinx-build --version
-cpio                   any                cpio --version
-GNU tar                1.28               tar --version
-gtags (opzionale)      6.6.5              gtags --version
-mkimage (opzionale)    2017.01            mkimage --version
-Python (opzionale)     3.5.x              python3 --version
-====================== =================  ========================================
-
-.. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
-
-Compilazione del kernel
-***********************
-
-GCC
----
-
-La versione necessaria di gcc potrebbe variare a seconda del tipo di CPU nel
-vostro calcolatore.
-
-Clang/LLVM (opzionale)
-----------------------
-
-L'ultima versione di clang e *LLVM utils* (secondo `releases.llvm.org
-<https://releases.llvm.org>`_) sono supportati per la generazione del
-kernel. Non garantiamo che anche i rilasci più vecchi funzionino, inoltre
-potremmo rimuovere gli espedienti che abbiamo implementato per farli
-funzionare. Per maggiori informazioni
-:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
-
-Rust (opzionale)
-----------------
-
-È necessaria una versione recente del compilatore Rust.
-
-Verificate le istruzioni Documentation/rust/quick-start.rst su come soddisfare i
-requisiti per compilare code Rust. In particolare, la regola ``rustavailable``
-nel ``Makefile`` è utile per verificare perché gli strumenti di compilazione non
-vengono trovati.
-
-bindgen (opzionale)
--------------------
-
-``bindgen`` viene usato per generare il collegamento (binding) da Rust al lato C del kernel. Dipende da ``libclang``.
-
-Make
-----
-
-Per compilare il kernel vi servirà GNU make 4.0 o successivo.
-
-Bash
-----
-Per generare il kernel vengono usati alcuni script per bash.
-Questo richiede bash 4.2 o successivo.
-
-Binutils
---------
-
-Per generare il kernel è necessario avere Binutils 2.30 o superiore.
-
-pkg-config
-----------
-
-Il sistema di compilazione, dalla versione 4.18, richiede pkg-config per
-verificare l'esistenza degli strumenti kconfig e per determinare le
-impostazioni da usare in 'make {g,x}config'.  Precedentemente pkg-config
-veniva usato ma non verificato o documentato.
-
-Flex
-----
-
-Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
-un analizzatore lessicale.  Questo richiede flex 2.5.35 o successivo.
-
-Bison
------
-
-Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
-un parsificatore.  Questo richiede bison 2.0 o successivo.
-
-pahole
-------
-
-Dalla versione 5.2, quando viene impostato CONFIG_DEBUG_INFO_BTF, il sistema di
-compilazione genera BTF (BPF Type Format) a partire da DWARF per vmlinux. Più
-tardi anche per i moduli. Questo richiede pahole v1.16 o successivo.
-
-A seconda della distribuzione, lo si può trovare nei pacchetti 'dwarves' o
-'pahole'. Oppure lo si può trovare qui: https://fedorapeople.org/~acme/dwarves/.
-
-Perl
-----
-
-Per compilare il kernel vi servirà perl 5 e i seguenti moduli ``Getopt::Long``,
-``Getopt::Std``, ``File::Basename``, e ``File::Find``.
-
-BC
---
-
-Vi servirà bc per compilare i kernel dal 3.10 in poi.
-
-OpenSSL
--------
-
-Il programma OpenSSL e la libreria crypto vengono usati per la firma dei moduli
-e la gestione dei certificati; sono usati per la creazione della chiave e
-la generazione della firma.
-
-Se la firma dei moduli è abilitata, allora vi servirà openssl per compilare il
-kernel 3.7 e successivi.  Vi serviranno anche i pacchetti di sviluppo di
-openssl per compilare il kernel 4.3 o successivi.
-
-Tar
----
-
-GNU Tar è necessario per accedere ai file d'intestazione del kernel usando sysfs
-(CONFIG_IKHEADERS)
-
-gtags / GNU GLOBAL (opzionale)
-------------------------------
-
-Il programma GNU GLOBAL versione 6.6.5, o successiva, è necessario quando si
-vuole eseguire ``make gtags`` e generare i relativi indici. Internamente si fa
-uso del parametro gtags ``-C (--directory)`` che compare in questa versione.
-
-mkimage
--------
-
-Questo strumento viene usato per produrre un *Flat Image Tree* (FIT),
-tipicamente usato su sistemi ARM. Questo strumento è disponibile tramite il
-pacchetto ``u-boot-tools`` oppure può essere compilato dal codice sorgente di
-U-Boot. Consultate le istruzioni
-https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
-
-
-Strumenti di sistema
-********************
-
-Modifiche architetturali
-------------------------
-
-DevFS è stato reso obsoleto da udev
-(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
-
-Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!
-
-La documentazione delle funzioni in Linux è una fase di transizione
-verso una documentazione integrata nei sorgenti stessi usando dei commenti
-formattati in modo speciale e posizionati vicino alle funzioni che descrivono.
-Al fine di arricchire la documentazione, questi commenti possono essere
-combinati con i file ReST presenti in Documentation/; questi potranno
-poi essere convertiti in formato PostScript, HTML, LaTex, ePUB o PDF.
-Per convertire i documenti da ReST al formato che volete, avete bisogno di
-Sphinx.
-
-Util-linux
-----------
-
-Le versioni più recenti di util-linux: forniscono il supporto a ``fdisk`` per
-dischi di grandi dimensioni; supportano le nuove opzioni di mount; riconoscono
-più tipi di partizioni; hanno un fdformat che funziona con i kernel 2.4;
-e altre chicche.  Probabilmente vorrete aggiornarlo.
-
-Ksymoops
---------
-
-Se l'impensabile succede e il kernel va in oops, potrebbe servirvi lo strumento
-ksymoops per decodificarlo, ma nella maggior parte dei casi non vi servirà.
-Generalmente è preferibile compilare il kernel con l'opzione ``CONFIG_KALLSYMS``
-cosicché venga prodotto un output più leggibile che può essere usato così com'è
-(produce anche un output migliore di ksymoops).  Se per qualche motivo il
-vostro kernel non è stato compilato con ``CONFIG_KALLSYMS`` e non avete modo di
-ricompilarlo e riprodurre l'oops con quell'opzione abilitata, allora potete
-usare ksymoops per decodificare l'oops.
-
-Mkinitrd
---------
-
-I cambiamenti della struttura in ``/lib/modules`` necessita l'aggiornamento di
-mkinitrd.
-
-E2fsprogs
----------
-
-L'ultima versione di ``e2fsprogs`` corregge diversi bachi in fsck e debugfs.
-Ovviamente, aggiornarlo è una buona idea.
-
-JFSutils
---------
-
-Il pacchetto ``jfsutils`` contiene programmi per il file-system JFS.
-Sono disponibili i seguenti strumenti:
-
-- ``fsck.jfs`` - avvia la ripetizione del log delle transizioni, e verifica e
-  ripara una partizione formattata secondo JFS
-
-- ``mkfs.jfs`` - crea una partizione formattata secondo JFS
-
-- sono disponibili altri strumenti per il file-system.
-
-Xfsprogs
---------
-
-L'ultima versione di ``xfsprogs`` contiene, fra i tanti, i programmi
-``mkfs.xfs``, ``xfs_db`` e ``xfs_repair`` per il file-system XFS.
-Dipendono dell'architettura e qualsiasi versione dalla 2.0.0 in poi
-dovrebbe funzionare correttamente con la versione corrente del codice
-XFS nel kernel (sono raccomandate le versioni 2.6.0 o successive per via
-di importanti miglioramenti).
-
-PCMCIAutils
------------
-
-PCMCIAutils sostituisce ``pcmica-cs``.  Serve ad impostare correttamente i
-connettori PCMCIA all'avvio del sistema e a caricare i moduli necessari per
-i dispositivi a 16-bit se il kernel è stato modularizzato e il sottosistema
-hotplug è in uso.
-
-Quota-tools
------------
-
-Il supporto per uid e gid a 32 bit richiedono l'uso della versione 2 del
-formato quota.  La versione 3.07 e successive di quota-tools supportano
-questo formato.  Usate la versione raccomandata nella lista qui sopra o una
-successiva.
-
-Micro codice per Intel IA32
----------------------------
-
-Per poter aggiornare il micro codice per Intel IA32, è stato aggiunto un
-apposito driver; il driver è accessibile come un normale dispositivo a
-caratteri (misc).  Se non state usando udev probabilmente sarà necessario
-eseguire i seguenti comandi come root prima di poterlo aggiornare::
-
-  mkdir /dev/cpu
-  mknod /dev/cpu/microcode c 10 184
-  chmod 0644 /dev/cpu/microcode
-
-Probabilmente, vorrete anche il programma microcode_ctl da usare con questo
-dispositivo.
-
-udev
-----
-
-``udev`` è un programma in spazio utente il cui scopo è quello di popolare
-dinamicamente la cartella ``/dev`` coi dispositivi effettivamente presenti.
-``udev`` sostituisce le funzionalità base di devfs, consentendo comunque
-nomi persistenti per i dispositivi.
-
-FUSE
-----
-
-Serve libfuse 2.4.0 o successiva.  Il requisito minimo assoluto è 2.3.0 ma
-le opzioni di mount ``direct_io`` e ``kernel_cache`` non funzioneranno.
-
-
-Rete
-****
-
-Cambiamenti generali
---------------------
-
-Se per quanto riguarda la configurazione di rete avete esigenze di un certo
-livello dovreste prendere in considerazione l'uso degli strumenti in ip-route2.
-
-Filtro dei pacchetti / NAT
---------------------------
-
-Il codice per filtraggio dei pacchetti e il NAT fanno uso degli stessi
-strumenti come nelle versioni del kernel antecedenti la 2.4.x (iptables).
-Include ancora moduli di compatibilità per 2.2.x ipchains e 2.0.x ipdwadm.
-
-PPP
----
-
-Il driver per PPP è stato ristrutturato per supportare collegamenti multipli e
-per funzionare su diversi livelli.  Se usate PPP, aggiornate pppd almeno alla
-versione 2.4.0.
-
-Se non usate udev, dovete avere un file /dev/ppp che può essere creato da root
-col seguente comando::
-
-  mknod /dev/ppp c 108 0
-
-
-NFS-utils
----------
-
-Nei kernel più antichi (2.4 e precedenti), il server NFS doveva essere
-informato sui clienti ai quali si voleva fornire accesso via NFS.  Questa
-informazione veniva passata al kernel quando un cliente montava un file-system
-mediante ``mountd``, oppure usando ``exportfs`` all'avvio del sistema.
-exportfs prende le informazioni circa i clienti attivi da ``/var/lib/nfs/rmtab``.
-
-Questo approccio è piuttosto delicato perché dipende dalla correttezza di
-rmtab, che non è facile da garantire, in particolare quando si cerca di
-implementare un *failover*.  Anche quando il sistema funziona bene, ``rmtab``
-ha il problema di accumulare vecchie voci inutilizzate.
-
-Sui kernel più recenti il kernel ha la possibilità di informare mountd quando
-arriva una richiesta da una macchina sconosciuta, e mountd può dare al kernel
-le informazioni corrette per l'esportazione.  Questo rimuove la dipendenza con
-``rmtab`` e significa che il kernel deve essere al corrente solo dei clienti
-attivi.
-
-Per attivare questa funzionalità, dovete eseguire il seguente comando prima di
-usare exportfs o mountd::
-
-  mount -t nfsd nfsd /proc/fs/nfsd
-
-Dove possibile, raccomandiamo di proteggere tutti i servizi NFS dall'accesso
-via internet mediante un firewall.
-
-mcelog
-------
-
-Quando ``CONFIG_x86_MCE`` è attivo, il programma mcelog processa e registra
-gli eventi *machine check*.  Gli eventi *machine check* sono errori riportati
-dalla CPU.  Incoraggiamo l'analisi di questi errori.
-
-
-Documentazione del kernel
-*************************
-
-Sphinx
-------
-
-Per i dettaglio sui requisiti di Sphinx, fate riferimento a :ref:`it_sphinx_install`
-in :ref:`Documentation/translations/it_IT/doc-guide/sphinx.rst <it_sphinxdoc>`
-
-Ottenere software aggiornato
-============================
-
-Compilazione del kernel
-***********************
-
-gcc
----
-
-- <ftp://ftp.gnu.org/gnu/gcc/>
-
-Clang/LLVM
-----------
-
-- :ref:`Getting LLVM <getting_llvm>`.
-
-Make
-----
-
-- <ftp://ftp.gnu.org/gnu/make/>
-
-Bash
-----
-
-- <ftp://ftp.gnu.org/gnu/bash/>
-
-Binutils
---------
-
-- <https://www.kernel.org/pub/linux/devel/binutils/>
-
-Flex
-----
-
-- <https://github.com/westes/flex/releases>
-
-Bison
------
-
-- <ftp://ftp.gnu.org/gnu/bison/>
-
-OpenSSL
--------
-
-- <https://www.openssl.org/>
-
-Strumenti di sistema
-********************
-
-Util-linux
-----------
-
-- <https://www.kernel.org/pub/linux/utils/util-linux/>
-
-Kmod
-----
-
-- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
-- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
-
-Ksymoops
---------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
-
-Mkinitrd
---------
-
-- <https://code.launchpad.net/initrd-tools/main>
-
-E2fsprogs
----------
-
-- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
-- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
-
-JFSutils
---------
-
-- <https://jfs.sourceforge.net/>
-
-Xfsprogs
---------
-
-- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
-- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
-
-Pcmciautils
------------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
-
-Quota-tools
------------
-
-- <https://sourceforge.net/projects/linuxquota/>
-
-
-Microcodice Intel P6
---------------------
-
-- <https://downloadcenter.intel.com/>
-
-udev
-----
-
-- <http://www.freedesktop.org/software/systemd/man/udev.html>
-
-FUSE
-----
-
-- <https://github.com/libfuse/libfuse/releases>
-
-mcelog
-------
-
-- <https://www.mcelog.org/>
-
-cpio
-----
-
-- <https://www.gnu.org/software/cpio/>
-
-Rete
-****
-
-PPP
----
-
-- <https://download.samba.org/pub/ppp/>
-- <https://git.ozlabs.org/?p=ppp.git>
-- <https://github.com/paulusmack/ppp/>
-
-
-NFS-utils
----------
-
-- <https://sourceforge.net/project/showfiles.php?group_id=14>
-- <https://nfs.sourceforge.net/>
-
-Iptables
---------
-
-- <https://netfilter.org/projects/iptables/index.html>
-
-Ip-route2
----------
-
-- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
-
-OProfile
---------
-
-- <https://oprofile.sf.net/download/>
-
-Documentazione del kernel
-*************************
-
-Sphinx
-------
-
-- <http://www.sphinx-doc.org/>
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
new file mode 120000
index 000000000000..d94978441892
--- /dev/null
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -0,0 +1 @@
+/home/manuel/linux/Documentation/translations/it_IT/process/software-requirements.rst
\ No newline at end of file
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index f51288602ee3..37ca98764932 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -96,7 +96,7 @@ Di seguito una lista di file che sono presenti nei sorgente del kernel e che
     minimo necessario per configurare e generare il kernel. I novizi
     del kernel dovrebbero iniziare da qui.
 
-  :ref:`Documentation/translations/it_IT/process/changes.rst <it_changes>`
+  :ref:`Documentation/translations/it_IT/process/software-requirements.rst <itsoftware-requirements>`
 
     Questo file fornisce una lista dei pacchetti software necessari
     a compilare e far funzionare il kernel con successo.
diff --git a/Documentation/translations/it_IT/process/software-requirements.rst b/Documentation/translations/it_IT/process/software-requirements.rst
new file mode 100644
index 000000000000..7ee54c972418
--- /dev/null
+++ b/Documentation/translations/it_IT/process/software-requirements.rst
@@ -0,0 +1,553 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/process/changes.rst <changes>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_changes:
+
+Requisiti minimi per compilare il kernel
+++++++++++++++++++++++++++++++++++++++++
+
+Introduzione
+============
+
+Questo documento fornisce una lista dei software necessari per eseguire questa
+versione del kernel.
+
+Questo documento è basato sul file "Changes" del kernel 2.0.x e quindi le
+persone che lo scrissero meritano credito (Jared Mauch, Axel Boldt,
+Alessandro Sigala, e tanti altri nella rete).
+
+Requisiti minimi correnti
+*************************
+
+Prima di pensare d'avere trovato un baco, aggiornate i seguenti programmi
+**almeno** alla versione indicata!  Se non siete certi della versione che state
+usando, il comando indicato dovrebbe dirvelo.
+
+Questa lista presume che abbiate già un kernel Linux funzionante.  In aggiunta,
+non tutti gli strumenti sono necessari ovunque; ovviamente, se non avete una
+PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
+
+====================== =================  ========================================
+        Programma       Versione minima       Comando per verificare la versione
+====================== =================  ========================================
+GNU C                  8.1                gcc --version
+Clang/LLVM (optional)  17.0.1             clang --version
+Rust (opzionale)       1.78.0             rustc --version
+bindgen (opzionale)    0.65.1             bindgen --version
+GNU make               4.0                make --version
+bash                   4.2                bash --version
+binutils               2.30               ld -v
+flex                   2.5.35             flex --version
+bison                  2.0                bison --version
+pahole                 1.16               pahole --version
+util-linux             2.10o              mount --version
+kmod                   13                 depmod -V
+e2fsprogs              1.41.4             e2fsck -V
+jfsutils               1.1.3              fsck.jfs -V
+xfsprogs               2.6.0              xfs_db -V
+squashfs-tools         4.0                mksquashfs -version
+btrfs-progs            0.18               btrfsck
+pcmciautils            004                pccardctl -V
+quota-tools            3.09               quota -V
+PPP                    2.4.0              pppd --version
+nfs-utils              1.0.5              showmount --version
+procps                 3.2.0              ps --version
+udev                   081                udevd --version
+grub                   0.93               grub --version || grub-install --version
+mcelog                 0.6                mcelog --version
+iptables               1.4.2              iptables -V
+openssl & libcrypto    1.0.0              openssl version
+bc                     1.06.95            bc --version
+Sphinx\ [#f1]_         2.4.4              sphinx-build --version
+cpio                   any                cpio --version
+GNU tar                1.28               tar --version
+gtags (opzionale)      6.6.5              gtags --version
+mkimage (opzionale)    2017.01            mkimage --version
+Python (opzionale)     3.5.x              python3 --version
+====================== =================  ========================================
+
+.. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
+
+Compilazione del kernel
+***********************
+
+GCC
+---
+
+La versione necessaria di gcc potrebbe variare a seconda del tipo di CPU nel
+vostro calcolatore.
+
+Clang/LLVM (opzionale)
+----------------------
+
+L'ultima versione di clang e *LLVM utils* (secondo `releases.llvm.org
+<https://releases.llvm.org>`_) sono supportati per la generazione del
+kernel. Non garantiamo che anche i rilasci più vecchi funzionino, inoltre
+potremmo rimuovere gli espedienti che abbiamo implementato per farli
+funzionare. Per maggiori informazioni
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
+Rust (opzionale)
+----------------
+
+È necessaria una versione recente del compilatore Rust.
+
+Verificate le istruzioni Documentation/rust/quick-start.rst su come soddisfare i
+requisiti per compilare code Rust. In particolare, la regola ``rustavailable``
+nel ``Makefile`` è utile per verificare perché gli strumenti di compilazione non
+vengono trovati.
+
+bindgen (opzionale)
+-------------------
+
+``bindgen`` viene usato per generare il collegamento (binding) da Rust al lato C del kernel. Dipende da ``libclang``.
+
+Make
+----
+
+Per compilare il kernel vi servirà GNU make 4.0 o successivo.
+
+Bash
+----
+Per generare il kernel vengono usati alcuni script per bash.
+Questo richiede bash 4.2 o successivo.
+
+Binutils
+--------
+
+Per generare il kernel è necessario avere Binutils 2.30 o superiore.
+
+pkg-config
+----------
+
+Il sistema di compilazione, dalla versione 4.18, richiede pkg-config per
+verificare l'esistenza degli strumenti kconfig e per determinare le
+impostazioni da usare in 'make {g,x}config'.  Precedentemente pkg-config
+veniva usato ma non verificato o documentato.
+
+Flex
+----
+
+Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
+un analizzatore lessicale.  Questo richiede flex 2.5.35 o successivo.
+
+Bison
+-----
+
+Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
+un parsificatore.  Questo richiede bison 2.0 o successivo.
+
+pahole
+------
+
+Dalla versione 5.2, quando viene impostato CONFIG_DEBUG_INFO_BTF, il sistema di
+compilazione genera BTF (BPF Type Format) a partire da DWARF per vmlinux. Più
+tardi anche per i moduli. Questo richiede pahole v1.16 o successivo.
+
+A seconda della distribuzione, lo si può trovare nei pacchetti 'dwarves' o
+'pahole'. Oppure lo si può trovare qui: https://fedorapeople.org/~acme/dwarves/.
+
+Perl
+----
+
+Per compilare il kernel vi servirà perl 5 e i seguenti moduli ``Getopt::Long``,
+``Getopt::Std``, ``File::Basename``, e ``File::Find``.
+
+BC
+--
+
+Vi servirà bc per compilare i kernel dal 3.10 in poi.
+
+OpenSSL
+-------
+
+Il programma OpenSSL e la libreria crypto vengono usati per la firma dei moduli
+e la gestione dei certificati; sono usati per la creazione della chiave e
+la generazione della firma.
+
+Se la firma dei moduli è abilitata, allora vi servirà openssl per compilare il
+kernel 3.7 e successivi.  Vi serviranno anche i pacchetti di sviluppo di
+openssl per compilare il kernel 4.3 o successivi.
+
+Tar
+---
+
+GNU Tar è necessario per accedere ai file d'intestazione del kernel usando sysfs
+(CONFIG_IKHEADERS)
+
+gtags / GNU GLOBAL (opzionale)
+------------------------------
+
+Il programma GNU GLOBAL versione 6.6.5, o successiva, è necessario quando si
+vuole eseguire ``make gtags`` e generare i relativi indici. Internamente si fa
+uso del parametro gtags ``-C (--directory)`` che compare in questa versione.
+
+mkimage
+-------
+
+Questo strumento viene usato per produrre un *Flat Image Tree* (FIT),
+tipicamente usato su sistemi ARM. Questo strumento è disponibile tramite il
+pacchetto ``u-boot-tools`` oppure può essere compilato dal codice sorgente di
+U-Boot. Consultate le istruzioni
+https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
+
+
+Strumenti di sistema
+********************
+
+Modifiche architetturali
+------------------------
+
+DevFS è stato reso obsoleto da udev
+(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+
+Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!
+
+La documentazione delle funzioni in Linux è una fase di transizione
+verso una documentazione integrata nei sorgenti stessi usando dei commenti
+formattati in modo speciale e posizionati vicino alle funzioni che descrivono.
+Al fine di arricchire la documentazione, questi commenti possono essere
+combinati con i file ReST presenti in Documentation/; questi potranno
+poi essere convertiti in formato PostScript, HTML, LaTex, ePUB o PDF.
+Per convertire i documenti da ReST al formato che volete, avete bisogno di
+Sphinx.
+
+Util-linux
+----------
+
+Le versioni più recenti di util-linux: forniscono il supporto a ``fdisk`` per
+dischi di grandi dimensioni; supportano le nuove opzioni di mount; riconoscono
+più tipi di partizioni; hanno un fdformat che funziona con i kernel 2.4;
+e altre chicche.  Probabilmente vorrete aggiornarlo.
+
+Ksymoops
+--------
+
+Se l'impensabile succede e il kernel va in oops, potrebbe servirvi lo strumento
+ksymoops per decodificarlo, ma nella maggior parte dei casi non vi servirà.
+Generalmente è preferibile compilare il kernel con l'opzione ``CONFIG_KALLSYMS``
+cosicché venga prodotto un output più leggibile che può essere usato così com'è
+(produce anche un output migliore di ksymoops).  Se per qualche motivo il
+vostro kernel non è stato compilato con ``CONFIG_KALLSYMS`` e non avete modo di
+ricompilarlo e riprodurre l'oops con quell'opzione abilitata, allora potete
+usare ksymoops per decodificare l'oops.
+
+Mkinitrd
+--------
+
+I cambiamenti della struttura in ``/lib/modules`` necessita l'aggiornamento di
+mkinitrd.
+
+E2fsprogs
+---------
+
+L'ultima versione di ``e2fsprogs`` corregge diversi bachi in fsck e debugfs.
+Ovviamente, aggiornarlo è una buona idea.
+
+JFSutils
+--------
+
+Il pacchetto ``jfsutils`` contiene programmi per il file-system JFS.
+Sono disponibili i seguenti strumenti:
+
+- ``fsck.jfs`` - avvia la ripetizione del log delle transizioni, e verifica e
+  ripara una partizione formattata secondo JFS
+
+- ``mkfs.jfs`` - crea una partizione formattata secondo JFS
+
+- sono disponibili altri strumenti per il file-system.
+
+Xfsprogs
+--------
+
+L'ultima versione di ``xfsprogs`` contiene, fra i tanti, i programmi
+``mkfs.xfs``, ``xfs_db`` e ``xfs_repair`` per il file-system XFS.
+Dipendono dell'architettura e qualsiasi versione dalla 2.0.0 in poi
+dovrebbe funzionare correttamente con la versione corrente del codice
+XFS nel kernel (sono raccomandate le versioni 2.6.0 o successive per via
+di importanti miglioramenti).
+
+PCMCIAutils
+-----------
+
+PCMCIAutils sostituisce ``pcmica-cs``.  Serve ad impostare correttamente i
+connettori PCMCIA all'avvio del sistema e a caricare i moduli necessari per
+i dispositivi a 16-bit se il kernel è stato modularizzato e il sottosistema
+hotplug è in uso.
+
+Quota-tools
+-----------
+
+Il supporto per uid e gid a 32 bit richiedono l'uso della versione 2 del
+formato quota.  La versione 3.07 e successive di quota-tools supportano
+questo formato.  Usate la versione raccomandata nella lista qui sopra o una
+successiva.
+
+Micro codice per Intel IA32
+---------------------------
+
+Per poter aggiornare il micro codice per Intel IA32, è stato aggiunto un
+apposito driver; il driver è accessibile come un normale dispositivo a
+caratteri (misc).  Se non state usando udev probabilmente sarà necessario
+eseguire i seguenti comandi come root prima di poterlo aggiornare::
+
+  mkdir /dev/cpu
+  mknod /dev/cpu/microcode c 10 184
+  chmod 0644 /dev/cpu/microcode
+
+Probabilmente, vorrete anche il programma microcode_ctl da usare con questo
+dispositivo.
+
+udev
+----
+
+``udev`` è un programma in spazio utente il cui scopo è quello di popolare
+dinamicamente la cartella ``/dev`` coi dispositivi effettivamente presenti.
+``udev`` sostituisce le funzionalità base di devfs, consentendo comunque
+nomi persistenti per i dispositivi.
+
+FUSE
+----
+
+Serve libfuse 2.4.0 o successiva.  Il requisito minimo assoluto è 2.3.0 ma
+le opzioni di mount ``direct_io`` e ``kernel_cache`` non funzioneranno.
+
+
+Rete
+****
+
+Cambiamenti generali
+--------------------
+
+Se per quanto riguarda la configurazione di rete avete esigenze di un certo
+livello dovreste prendere in considerazione l'uso degli strumenti in ip-route2.
+
+Filtro dei pacchetti / NAT
+--------------------------
+
+Il codice per filtraggio dei pacchetti e il NAT fanno uso degli stessi
+strumenti come nelle versioni del kernel antecedenti la 2.4.x (iptables).
+Include ancora moduli di compatibilità per 2.2.x ipchains e 2.0.x ipdwadm.
+
+PPP
+---
+
+Il driver per PPP è stato ristrutturato per supportare collegamenti multipli e
+per funzionare su diversi livelli.  Se usate PPP, aggiornate pppd almeno alla
+versione 2.4.0.
+
+Se non usate udev, dovete avere un file /dev/ppp che può essere creato da root
+col seguente comando::
+
+  mknod /dev/ppp c 108 0
+
+
+NFS-utils
+---------
+
+Nei kernel più antichi (2.4 e precedenti), il server NFS doveva essere
+informato sui clienti ai quali si voleva fornire accesso via NFS.  Questa
+informazione veniva passata al kernel quando un cliente montava un file-system
+mediante ``mountd``, oppure usando ``exportfs`` all'avvio del sistema.
+exportfs prende le informazioni circa i clienti attivi da ``/var/lib/nfs/rmtab``.
+
+Questo approccio è piuttosto delicato perché dipende dalla correttezza di
+rmtab, che non è facile da garantire, in particolare quando si cerca di
+implementare un *failover*.  Anche quando il sistema funziona bene, ``rmtab``
+ha il problema di accumulare vecchie voci inutilizzate.
+
+Sui kernel più recenti il kernel ha la possibilità di informare mountd quando
+arriva una richiesta da una macchina sconosciuta, e mountd può dare al kernel
+le informazioni corrette per l'esportazione.  Questo rimuove la dipendenza con
+``rmtab`` e significa che il kernel deve essere al corrente solo dei clienti
+attivi.
+
+Per attivare questa funzionalità, dovete eseguire il seguente comando prima di
+usare exportfs o mountd::
+
+  mount -t nfsd nfsd /proc/fs/nfsd
+
+Dove possibile, raccomandiamo di proteggere tutti i servizi NFS dall'accesso
+via internet mediante un firewall.
+
+mcelog
+------
+
+Quando ``CONFIG_x86_MCE`` è attivo, il programma mcelog processa e registra
+gli eventi *machine check*.  Gli eventi *machine check* sono errori riportati
+dalla CPU.  Incoraggiamo l'analisi di questi errori.
+
+
+Documentazione del kernel
+*************************
+
+Sphinx
+------
+
+Per i dettaglio sui requisiti di Sphinx, fate riferimento a :ref:`it_sphinx_install`
+in :ref:`Documentation/translations/it_IT/doc-guide/sphinx.rst <it_sphinxdoc>`
+
+Ottenere software aggiornato
+============================
+
+Compilazione del kernel
+***********************
+
+gcc
+---
+
+- <ftp://ftp.gnu.org/gnu/gcc/>
+
+Clang/LLVM
+----------
+
+- :ref:`Getting LLVM <getting_llvm>`.
+
+Make
+----
+
+- <ftp://ftp.gnu.org/gnu/make/>
+
+Bash
+----
+
+- <ftp://ftp.gnu.org/gnu/bash/>
+
+Binutils
+--------
+
+- <https://www.kernel.org/pub/linux/devel/binutils/>
+
+Flex
+----
+
+- <https://github.com/westes/flex/releases>
+
+Bison
+-----
+
+- <ftp://ftp.gnu.org/gnu/bison/>
+
+OpenSSL
+-------
+
+- <https://www.openssl.org/>
+
+Strumenti di sistema
+********************
+
+Util-linux
+----------
+
+- <https://www.kernel.org/pub/linux/utils/util-linux/>
+
+Kmod
+----
+
+- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
+Ksymoops
+--------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
+
+Mkinitrd
+--------
+
+- <https://code.launchpad.net/initrd-tools/main>
+
+E2fsprogs
+---------
+
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
+
+JFSutils
+--------
+
+- <https://jfs.sourceforge.net/>
+
+Xfsprogs
+--------
+
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
+- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
+
+Pcmciautils
+-----------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
+
+Quota-tools
+-----------
+
+- <https://sourceforge.net/projects/linuxquota/>
+
+
+Microcodice Intel P6
+--------------------
+
+- <https://downloadcenter.intel.com/>
+
+udev
+----
+
+- <http://www.freedesktop.org/software/systemd/man/udev.html>
+
+FUSE
+----
+
+- <https://github.com/libfuse/libfuse/releases>
+
+mcelog
+------
+
+- <https://www.mcelog.org/>
+
+cpio
+----
+
+- <https://www.gnu.org/software/cpio/>
+
+Rete
+****
+
+PPP
+---
+
+- <https://download.samba.org/pub/ppp/>
+- <https://git.ozlabs.org/?p=ppp.git>
+- <https://github.com/paulusmack/ppp/>
+
+
+NFS-utils
+---------
+
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://nfs.sourceforge.net/>
+
+Iptables
+--------
+
+- <https://netfilter.org/projects/iptables/index.html>
+
+Ip-route2
+---------
+
+- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
+
+OProfile
+--------
+
+- <https://oprofile.sf.net/download/>
+
+Documentazione del kernel
+*************************
+
+Sphinx
+------
+
+- <http://www.sphinx-doc.org/>
diff --git a/Documentation/translations/ja_JP/process/howto.rst b/Documentation/translations/ja_JP/process/howto.rst
index 8ab47fc710fc..57ed639653a3 100644
--- a/Documentation/translations/ja_JP/process/howto.rst
+++ b/Documentation/translations/ja_JP/process/howto.rst
@@ -105,7 +105,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
     ています。 カーネルに関して初めての人はここからスタートすると良い
     でしょう。
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements.rst>`
     このファイルはカーネルをうまく生成(訳注 build )し、走らせるのに最
     小限のレベルで必要な数々のソフトウェアパッケージの一覧を示してい
     ます。
diff --git a/Documentation/translations/ko_KR/process/howto.rst b/Documentation/translations/ko_KR/process/howto.rst
index 34f14899c155..276cc9244370 100644
--- a/Documentation/translations/ko_KR/process/howto.rst
+++ b/Documentation/translations/ko_KR/process/howto.rst
@@ -114,7 +114,7 @@ mtk.manpages@gmail.com의 메인테이너에게 보낼 것을 권장한다.
     빌드하기 위해 필요한 것을 설명한다. 커널에 입문하는 사람들은 여기서
     시작해야 한다.
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements>`
     이 파일은 커널을 성공적으로 빌드하고 실행시키기 위해 필요한 다양한
     소프트웨어 패키지들의 최소 버젼을 나열한다.
 
diff --git a/Documentation/translations/pt_BR/process/changes.rst b/Documentation/translations/pt_BR/process/changes.rst
deleted file mode 100644
index 51c7fe41663e..000000000000
--- a/Documentation/translations/pt_BR/process/changes.rst
+++ /dev/null
@@ -1,576 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-
-
-Requisitos mínimos para compilar o Kernel
-++++++++++++++++++++++++++++++++++++++++++
-
-Introdução
-===========
-
-Este documento foi projetado para fornecer uma lista das versões mínimas
-de software necessárias para executar a versão atual do kernel.
-
-Este documento é originalmente baseado no meu arquivo 'Changes' para os kernels
-2.0.x e portanto, deve créditos às mesmas pessoas que aquele arquivo (Jared
-Mauch, Axel Boldt, Alessandro Sigala e inúmeros outros usuários em toda a rede).
-
-Requisitos Mínimos Atuais
-****************************
-
-Atualize para pelo menos estas revisões de software antes de pensar que
-encontrou um bug! Se não tiver certeza de qual versão está executando atualmente
-, o comando sugerido deve lhe informar. Para uma lista dos programas em seu
-sistema, incluindo as versões, execute ./scripts/ver_linux.
-
-Novamente, tenha em mente que esta lista pressupõe que você já possui um kernel
-Linux em execução funcional. Além disso, nem todas as ferramentas são
-necessárias em todos os sistemas; obviamente, se você não possui nenhum hardware
-PC Card por exemplo, provavelmente não precisará se preocupar com o pcmciautils.
-
-====================== ===============  ========================================
-Programa               Versão mínima    Comando para verificar a versão
-====================== ===============  ========================================
-GNU C                  8.1              gcc --version
-Clang/LLVM (optional)  17.0.1           clang --version
-Rust (optional)        1.85.0           rustc --version
-bindgen (optional)     0.71.1           bindgen --version
-GNU make               4.0              make --version
-bash                   4.2              bash --version
-binutils               2.30             ld -v
-flex                   2.5.35           flex --version
-gdb                    7.2              gdb --version
-bison                  2.0              bison --version
-pahole                 1.22             pahole --version
-util-linux             2.10o            mount --version
-kmod                   13               kmod -V
-e2fsprogs              1.41.4           e2fsck -V
-jfsutils               1.1.3            fsck.jfs -V
-xfsprogs               2.6.0            xfs_db -V
-squashfs-tools         4.0              mksquashfs -version
-btrfs-progs            0.18             btrfs --version
-pcmciautils            004              pccardctl -V
-quota-tools            3.09             quota -V
-PPP                    2.4.0            pppd --version
-nfs-utils              1.0.5            showmount --version
-procps                 3.2.0            ps --version
-udev                   081              udevadm --version
-grub                   0.93             grub --version || grub-install --version
-mcelog                 0.6              mcelog --version
-iptables               1.4.2            iptables -V
-openssl & libcrypto    1.0.0            openssl version
-bc                     1.06.95          bc --version
-Sphinx [#f1]_          3.4.3            sphinx-build --version
-GNU tar                1.28             tar --version
-gtags (opcional)       6.6.5            gtags --version
-mkimage (opcional)     2017.01          mkimage --version
-Python                 3.9.x            python3 --version
-GNU AWK (opcional)     5.1.0            gawk --version
-====================== ===============  ========================================
-
-.. [#f1] O Sphinx é necessário apenas para gerar a documentação do Kernel.
-
-Compilação do Kernel
-*********************
-
-GCC
----
-
-Os requisitos da versão do gcc podem variar dependendo do tipo de CPU
-do seu computador.
-
-Clang/LLVM (opcional)
----------------------
-
-A versão formal mais recente do clang e dos utilitários LLVM (de acordo com
-`releases.llvm.org <https://releases.llvm.org>`_) é suportada para a compilação
-de kernels. Versões anteriores não têm funcionamento garantido, e poderemos
-remover do kernel soluções de contorno (workarounds) que eram utilizadas para
-suportar versões mais antigas. Por favor, veja a documentação adicional em
-:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
-
-Rust (opcional)
----------------
-
-É necessária uma versão recente do compilador Rust.
-
-Por favor, consulte Documentation/rust/quick-start.rst para obter instruções
-sobre como atender aos requisitos de compilação do suporte a Rust. Em
-particular, o alvo (target) rustavailable do Makefile é útil para verificar por
-que a cadeia de ferramentas (toolchain) Rust pode não estar sendo detectada.
-
-bindgen (opcional)
-------------------
-
-O ``bindgen`` é utilizado para gerar os vínculos (bindings) Rust para o lado C
-do kernel. Ele depende da ``libclang``.
-
-Make
-----
-
-Você precisará do GNU make 4.0 ou superior para compilar o kernel.
-
-Bash
-----
-
-Alguns scripts bash são usados para a compilação do kernel.
-É necessário o Bash 4.2 ou mais recente.
-
-Binutils
---------
-
-O binutils 2.30 ou mais recente é necessário para compilar o kernel.
-
-pkg-config
-----------
-
-O sistema de compilação, a partir da versão 4.18, requer o pkg-config para
-verificar as ferramentas kconfig instaladas e para determinar as configurações
-de flags para uso em 'make {g,x}config'. Anteriormente, o pkg-config já era
-utilizado, mas não era verificado nem documentado.
-
-Flex
-----
-
-Desde o Linux 4.16, o sistema de compilação gera analisadores léxicos durante a
-compilação. Isso requer o flex 2.5.35 ou superior.
-
-
-Bison
------
-
-Desde o Linux 4.16, o sistema de compilação gera analisadores sintáticos durante
-a compilação. Isso requer o bison 2.0 ou superior
-
-pahole
-------
-
-Desde o Linux 5.2, se CONFIG_DEBUG_INFO_BTF estiver selecionado, o sistema de
-compilação gera BTF (BPF Type Format) a partir do DWARF no vmlinux, e um pouco
-depois para os módulos do kernel também. Isso requer o pahole v1.22 ou superior.
-
-Ele pode ser encontrado nos pacotes ``dwarves`` ou ``pahole`` das
-distribuições, ou em https://fedorapeople.org/~acme/dwarves/.
-
-Perl
-----
-
-Você precisará do perl 5 e dos seguintes módulos: ``Getopt::Long``,
-``Getopt::Std``, ``File::Basename`` e ``File::Find`` para compilar o kernel.
-
-Python
-------
-
-Várias opções de configuração o exigem: ele é necessário para as configurações
-padrão (defconfigs) de arm/arm64, CONFIG_LTO_CLANG, algumas configurações
-opcionais de DRM, a ferramenta kernel-doc e a geração da documentação (Sphinx),
-entre outros.
-
-BC
---
-
-Você precisará do bc para compilar kernels 3.10 ou superior.
-
-
-OpenSSL
--------
-
-A assinatura de módulos e a manipulação de certificados externos utilizam o
-programa OpenSSL e a biblioteca de criptografia para realizar a criação de
-chaves e a geração de assinaturas.
-
-Você precisará do openssl para compilar kernels 3.7 e superiores se a assinatura
-de módulos estiver habilitada. Você também precisará dos pacotes de
-desenvolvimento do openssl para compilar kernels 4.3 e superiores.
-
-Tar
----
-
-O GNU tar é necessário caso você deseje habilitar o acesso aos cabeçalhos do
-kernel via sysfs (CONFIG_IKHEADERS).
-
-gtags / GNU GLOBAL (optional)
------------------------------
-
-A compilação do kernel requer o GNU GLOBAL versão 6.6.5 ou superior para gerar
-arquivos de tags através de make gtags. Isso se deve ao uso da flag ``-C
-(--directory)`` pelo ``gtags``.
-
-mkimage
--------
-
-Esta ferramenta é utilizada ao gerar uma Flat Image Tree (FIT), comumente usada
-em plataformas ARM. A ferramenta está disponível através do pacote ``u-boot-tools``
-ou pode ser compilada a partir do código-fonte do U-Boot. Veja as instruções em
-https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
-
-GNU AWK
--------
-
-O GNU AWK é necessário caso você deseje que a compilação do kernel gere dados de
-intervalo de endereços para
-módulos integrados (CONFIG_BUILTIN_MODULE_RANGES).
-
-Utilitários de sistema
-***********************
-
-Mudanças de arquitetura
-------------------------
-
-O DevFS tornou-se obsoleto em favor do udev
-(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
-
-O suporte a UIDs de 32 bits já está implementado. Divirta-se!
-
-A documentação das funções do Linux está migrando para a documentação embutida
-(inline), por meio de comentários com formatação especial próximos às suas
-definições no código-fonte. Esses comentários podem ser combinados com arquivos
-ReST no diretório Documentation/ para criar uma documentação enriquecida, que
-pode então ser convertida para arquivos PostScript, HTML, LaTeX, ePUB e PDF.
-Para converter do formato ReST para o formato de sua escolha, você precisará do
-Sphinx.
-
-Util-linux
-----------
-
-Novas versões do util-linux oferecem suporte no ``fdisk`` para discos maiores,
-suporte a novas opções para o mount, reconhecimento de mais tipos de partição e
-outras funcionalidades interessantes. Você provavelmente vai querer atualizar.
-
-Ksymoops
---------
-
-Se o impensável acontecer e o seu kernel sofrer um oops, você pode precisar da
-ferramenta ksymoops para decodificá-lo, mas na maioria dos casos, não será
-necessário. É geralmente preferível compilar o kernel com ``CONFIG_KALLSYMS`` para
-que ele produza dumps legíveis que possam ser usados no estado em que se
-encontram (isso também gera uma saída melhor do que a do ksymoops).
-Se por algum motivo o seu kernel não for compilado com ``CONFIG_KALLSYMS`` e você
-não tiver como recompilar e reproduzir o oops com essa opção, você ainda poderá
-decodificá-lo com o ksymoops.
-
-Mkinitrd
---------
-
-Estas mudanças no layout da árvore de arquivos ``/lib/modules`` também exigem que o
-mkinitrd seja atualizado.
-
-E2fsprogs
----------
-
-A versão mais recente do ``e2fsprogs`` corrige diversos bugs no fsck e no debugfs.
-Obviamente, é uma boa ideia atualizar.
-
-JFSutils
---------
-
-O pacote jfsutils contém os utilitários para o sistema de arquivos. Os seguintes
-utilitários estão disponíveis:
-
-- ``fsck.jfs`` - inicia a reprodução (replay) do log de transações, além de
-  verificar e reparar uma partição formatada em JFS.
-
-- ``mkfs.jfs`` - cria uma partição formatada em JFS.
-
-Outros utilitários de sistema de arquivos também estão disponíveis neste pacote.
-
-Xfsprogs
---------
-
-A versão mais recente do ``xfsprogs`` contém os utilitários ``mkfs.xfs``,
-``xfs_db`` e ``xfs_repair``, entre outros, para o sistema de arquivos XFS. Ele é
-independente de arquitetura e qualquer versão a partir da 2.0.0 deve funcionar
-corretamente com esta versão do código do kernel XFS (recomenda-se a
-versão 2.6.0 ou posterior, devido a algumas melhorias significativas).
-
-PCMCIAutils
------------
-
-O PCMCIAutils substitui o pcmcia-cs. Ele configura corretamente os sockets
-PCMCIA na inicialização do sistema e carrega os módulos apropriados para
-dispositivos PCMCIA de 16 bits, caso o kernel esteja modularizado e o subsistema
-de hotplug seja utilizado.
-
-Quota-tools
------------
-
-O suporte a UIDs e GIDs de 32 bits é necessário caso você deseje utilizar o
-formato de cota versão 2 mais recente. O quota-tools versão 3.07 e superiores
-possuem esse suporte. Utilize a versão recomendada ou superior da tabela acima.
-
-Intel IA32 microcode
---------------------
-
-Um driver foi adicionado para permitir a atualização do microcódigo Intel IA32,
-acessível como um dispositivo de caracteres comum (misc). Se você não estiver
-usando o udev, você poderá precisar de::
-
-  mkdir /dev/cpu
-  mknod /dev/cpu/microcode c 10 184
-  chmod 0644 /dev/cpu/microcode
-
-você poderá precisar executar os comandos
-acima como root antes de poder usar isso. Você provavelmente também desejará
-obter o utilitário de espaço de usuário ``microcode_ctl`` para utilizar em
-conjunto com este driver.
-
-udev
-----
-
-O udev é uma aplicação de espaço de usuário para popular o diretório /dev
-dinamicamente, apenas com entradas para dispositivos de fato presentes no
-sistema. O udev substitui a funcionalidade básica do devfs, permitindo ao mesmo
-tempo a nomeação persistente de dispositivos.
-
-FUSE
-----
-
-Necessita do libfuse 2.4.0 ou posterior. O mínimo absoluto é a versão 2.3.0,
-mas as opções de montagem direct_io e kernel_cache não funcionarão.
-
-Redes
-******
-
-Mudanças gerais
-----------------
-
-Caso você tenha necessidades avançadas de configuração de rede, você deve
-provavelmente considerar o uso das ferramentas de rede do iproute2.
-
-Filtro de Pacotes / NAT
-------------------------
-
-O código de filtragem de pacotes e NAT utiliza as mesmas ferramentas da série
-anterior de kernels 2.4.x (iptables). Ele ainda inclui módulos de
-retrocompatibilidade para o ipchains (estilo 2.2.x) e o ipfwadm (estilo 2.0.x).
-
-PPP
----
-
-O driver PPP foi reestruturado para suportar multilink e permitir que opere
-sobre diversas camadas de mídia. Se você utiliza PPP, atualize o pppd para, no
-mínimo, a versão 2.4.0.
-
-Se você não estiver usando o udev, você deve possuir o arquivo de dispositivo
-``/dev/ppp``, o qual pode ser criado por::
-
-  mknod /dev/ppp c 108 0
-
-como root.
-
-NFS-utils
----------
-
-Em kernels antigos (2.4 e anteriores), o servidor NFS precisava conhecer
-qualquer cliente que pretendesse acessar arquivos via NFS. Essa informação era
-fornecida ao kernel pelo mountd quando o cliente montava o sistema de arquivos,
-ou pelo exportfs na inicialização do sistema. O exportfs obtinha informações
-sobre clientes ativos a partir de /var/lib/nfs/rmtab.
-
-Esta abordagem é bastante frágil, pois depende da integridade do rmtab, o que
-nem sempre é fácil, particularmente ao tentar implementar fail-over. Mesmo
-quando o sistema está funcionando bem, o rmtab sofre com o acúmulo de muitas
-entradas antigas que nunca são removidas.
-
-Com kernels modernos, temos a opção de fazer o kernel informar ao mountd quando
-recebe uma requisição de um host desconhecido, permitindo que o mountd forneça
-as informações de exportação apropriadas ao kernel. Isso remove a dependência do
-rmtab e significa que o kernel só precisa conhecer os clientes ativos no
-momento.
-
-Para habilitar esta nova funcionalidade, você precisa::
-
-  mount -t nfsd nfsd /proc/fs/nfsd
-
-antes de executar o exportfs ou o mountd. Recomenda-se que todos os serviços NFS
-sejam protegidos da internet em geral por um firewall, sempre que possível.
-
-mcelog
-------
-
-Em kernels x86, o utilitário mcelog é necessário para processar e registrar
-eventos de machine check quando opção CONFIG_X86_MCE está ativada. Eventos de
-machine check são erros relatados pela CPU. O processamento desses eventos é
-fortemente recomendado.
-
-Documentação do Kernel
-***********************
-
-Sphinx
-------
-
-Por favor, consulte Documentation/doc-guide/sphinx.rst para detalhes sobre os
-requisitos do Sphinx.
-
-rustdoc
--------
-
-O rustdoc é utilizado para gerar a documentação para código Rust. Por favor,
-consulte Documentation/rust/general-information.rst para mais informações.
-
-Obtendo software atualizado
-============================
-
-Compilação do kernel
-**********************
-
-gcc
----
-
-- <ftp://ftp.gnu.org/gnu/gcc/>
-
-Clang/LLVM
-----------
-
-- :ref:`Getting LLVM <getting_llvm>`.
-
-Rust
-----
-
-- Documentation/rust/quick-start.rst.
-
-bindgen
--------
-
-- Documentation/rust/quick-start.rst.
-
-Make
-----
-
-- <ftp://ftp.gnu.org/gnu/make/>
-
-Bash
-----
-
-- <ftp://ftp.gnu.org/gnu/bash/>
-
-Binutils
---------
-
-- <https://www.kernel.org/pub/linux/devel/binutils/>
-
-Flex
-----
-
-- <https://github.com/westes/flex/releases>
-
-Bison
------
-
-- <ftp://ftp.gnu.org/gnu/bison/>
-
-OpenSSL
--------
-
-- <https://www.openssl.org/>
-
-System utilities
-****************
-
-Util-linux
-----------
-
-- <https://www.kernel.org/pub/linux/utils/util-linux/>
-
-Kmod
-----
-
-- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
-- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
-
-Ksymoops
---------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
-
-Mkinitrd
---------
-
-- <https://code.launchpad.net/initrd-tools/main>
-
-E2fsprogs
----------
-
-- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
-- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
-
-JFSutils
---------
-
-- <https://jfs.sourceforge.net/>
-
-Xfsprogs
---------
-
-- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
-- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
-
-Pcmciautils
------------
-
-- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
-
-Quota-tools
------------
-
-- <https://sourceforge.net/projects/linuxquota/>
-
-
-Intel P6 microcode
-------------------
-
-- <https://downloadcenter.intel.com/>
-
-udev
-----
-
-- <https://www.freedesktop.org/software/systemd/man/udev.html>
-
-FUSE
-----
-
-- <https://github.com/libfuse/libfuse/releases>
-
-mcelog
-------
-
-- <https://www.mcelog.org/>
-
-Redes
-******
-
-PPP
----
-
-- <https://download.samba.org/pub/ppp/>
-- <https://git.ozlabs.org/?p=ppp.git>
-- <https://github.com/paulusmack/ppp/>
-
-NFS-utils
----------
-
-- <https://sourceforge.net/project/showfiles.php?group_id=14>
-- <https://nfs.sourceforge.net/>
-
-Iptables
---------
-
-- <https://netfilter.org/projects/iptables/index.html>
-
-Ip-route2
----------
-
-- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
-
-OProfile
---------
-
-- <https://oprofile.sf.net/download/>
-
-Kernel documentation
-********************
-
-Sphinx
-------
-
-- <https://www.sphinx-doc.org/>
diff --git a/Documentation/translations/pt_BR/process/changes.rst b/Documentation/translations/pt_BR/process/changes.rst
new file mode 120000
index 000000000000..ca8d404e9bcc
--- /dev/null
+++ b/Documentation/translations/pt_BR/process/changes.rst
@@ -0,0 +1 @@
+/home/manuel/linux/Documentation/translations/pt_BR/process/software-requirements.rst
\ No newline at end of file
diff --git a/Documentation/translations/pt_BR/process/software-requirements.rst b/Documentation/translations/pt_BR/process/software-requirements.rst
new file mode 100644
index 000000000000..51c7fe41663e
--- /dev/null
+++ b/Documentation/translations/pt_BR/process/software-requirements.rst
@@ -0,0 +1,576 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+
+
+Requisitos mínimos para compilar o Kernel
+++++++++++++++++++++++++++++++++++++++++++
+
+Introdução
+===========
+
+Este documento foi projetado para fornecer uma lista das versões mínimas
+de software necessárias para executar a versão atual do kernel.
+
+Este documento é originalmente baseado no meu arquivo 'Changes' para os kernels
+2.0.x e portanto, deve créditos às mesmas pessoas que aquele arquivo (Jared
+Mauch, Axel Boldt, Alessandro Sigala e inúmeros outros usuários em toda a rede).
+
+Requisitos Mínimos Atuais
+****************************
+
+Atualize para pelo menos estas revisões de software antes de pensar que
+encontrou um bug! Se não tiver certeza de qual versão está executando atualmente
+, o comando sugerido deve lhe informar. Para uma lista dos programas em seu
+sistema, incluindo as versões, execute ./scripts/ver_linux.
+
+Novamente, tenha em mente que esta lista pressupõe que você já possui um kernel
+Linux em execução funcional. Além disso, nem todas as ferramentas são
+necessárias em todos os sistemas; obviamente, se você não possui nenhum hardware
+PC Card por exemplo, provavelmente não precisará se preocupar com o pcmciautils.
+
+====================== ===============  ========================================
+Programa               Versão mínima    Comando para verificar a versão
+====================== ===============  ========================================
+GNU C                  8.1              gcc --version
+Clang/LLVM (optional)  17.0.1           clang --version
+Rust (optional)        1.85.0           rustc --version
+bindgen (optional)     0.71.1           bindgen --version
+GNU make               4.0              make --version
+bash                   4.2              bash --version
+binutils               2.30             ld -v
+flex                   2.5.35           flex --version
+gdb                    7.2              gdb --version
+bison                  2.0              bison --version
+pahole                 1.22             pahole --version
+util-linux             2.10o            mount --version
+kmod                   13               kmod -V
+e2fsprogs              1.41.4           e2fsck -V
+jfsutils               1.1.3            fsck.jfs -V
+xfsprogs               2.6.0            xfs_db -V
+squashfs-tools         4.0              mksquashfs -version
+btrfs-progs            0.18             btrfs --version
+pcmciautils            004              pccardctl -V
+quota-tools            3.09             quota -V
+PPP                    2.4.0            pppd --version
+nfs-utils              1.0.5            showmount --version
+procps                 3.2.0            ps --version
+udev                   081              udevadm --version
+grub                   0.93             grub --version || grub-install --version
+mcelog                 0.6              mcelog --version
+iptables               1.4.2            iptables -V
+openssl & libcrypto    1.0.0            openssl version
+bc                     1.06.95          bc --version
+Sphinx [#f1]_          3.4.3            sphinx-build --version
+GNU tar                1.28             tar --version
+gtags (opcional)       6.6.5            gtags --version
+mkimage (opcional)     2017.01          mkimage --version
+Python                 3.9.x            python3 --version
+GNU AWK (opcional)     5.1.0            gawk --version
+====================== ===============  ========================================
+
+.. [#f1] O Sphinx é necessário apenas para gerar a documentação do Kernel.
+
+Compilação do Kernel
+*********************
+
+GCC
+---
+
+Os requisitos da versão do gcc podem variar dependendo do tipo de CPU
+do seu computador.
+
+Clang/LLVM (opcional)
+---------------------
+
+A versão formal mais recente do clang e dos utilitários LLVM (de acordo com
+`releases.llvm.org <https://releases.llvm.org>`_) é suportada para a compilação
+de kernels. Versões anteriores não têm funcionamento garantido, e poderemos
+remover do kernel soluções de contorno (workarounds) que eram utilizadas para
+suportar versões mais antigas. Por favor, veja a documentação adicional em
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
+Rust (opcional)
+---------------
+
+É necessária uma versão recente do compilador Rust.
+
+Por favor, consulte Documentation/rust/quick-start.rst para obter instruções
+sobre como atender aos requisitos de compilação do suporte a Rust. Em
+particular, o alvo (target) rustavailable do Makefile é útil para verificar por
+que a cadeia de ferramentas (toolchain) Rust pode não estar sendo detectada.
+
+bindgen (opcional)
+------------------
+
+O ``bindgen`` é utilizado para gerar os vínculos (bindings) Rust para o lado C
+do kernel. Ele depende da ``libclang``.
+
+Make
+----
+
+Você precisará do GNU make 4.0 ou superior para compilar o kernel.
+
+Bash
+----
+
+Alguns scripts bash são usados para a compilação do kernel.
+É necessário o Bash 4.2 ou mais recente.
+
+Binutils
+--------
+
+O binutils 2.30 ou mais recente é necessário para compilar o kernel.
+
+pkg-config
+----------
+
+O sistema de compilação, a partir da versão 4.18, requer o pkg-config para
+verificar as ferramentas kconfig instaladas e para determinar as configurações
+de flags para uso em 'make {g,x}config'. Anteriormente, o pkg-config já era
+utilizado, mas não era verificado nem documentado.
+
+Flex
+----
+
+Desde o Linux 4.16, o sistema de compilação gera analisadores léxicos durante a
+compilação. Isso requer o flex 2.5.35 ou superior.
+
+
+Bison
+-----
+
+Desde o Linux 4.16, o sistema de compilação gera analisadores sintáticos durante
+a compilação. Isso requer o bison 2.0 ou superior
+
+pahole
+------
+
+Desde o Linux 5.2, se CONFIG_DEBUG_INFO_BTF estiver selecionado, o sistema de
+compilação gera BTF (BPF Type Format) a partir do DWARF no vmlinux, e um pouco
+depois para os módulos do kernel também. Isso requer o pahole v1.22 ou superior.
+
+Ele pode ser encontrado nos pacotes ``dwarves`` ou ``pahole`` das
+distribuições, ou em https://fedorapeople.org/~acme/dwarves/.
+
+Perl
+----
+
+Você precisará do perl 5 e dos seguintes módulos: ``Getopt::Long``,
+``Getopt::Std``, ``File::Basename`` e ``File::Find`` para compilar o kernel.
+
+Python
+------
+
+Várias opções de configuração o exigem: ele é necessário para as configurações
+padrão (defconfigs) de arm/arm64, CONFIG_LTO_CLANG, algumas configurações
+opcionais de DRM, a ferramenta kernel-doc e a geração da documentação (Sphinx),
+entre outros.
+
+BC
+--
+
+Você precisará do bc para compilar kernels 3.10 ou superior.
+
+
+OpenSSL
+-------
+
+A assinatura de módulos e a manipulação de certificados externos utilizam o
+programa OpenSSL e a biblioteca de criptografia para realizar a criação de
+chaves e a geração de assinaturas.
+
+Você precisará do openssl para compilar kernels 3.7 e superiores se a assinatura
+de módulos estiver habilitada. Você também precisará dos pacotes de
+desenvolvimento do openssl para compilar kernels 4.3 e superiores.
+
+Tar
+---
+
+O GNU tar é necessário caso você deseje habilitar o acesso aos cabeçalhos do
+kernel via sysfs (CONFIG_IKHEADERS).
+
+gtags / GNU GLOBAL (optional)
+-----------------------------
+
+A compilação do kernel requer o GNU GLOBAL versão 6.6.5 ou superior para gerar
+arquivos de tags através de make gtags. Isso se deve ao uso da flag ``-C
+(--directory)`` pelo ``gtags``.
+
+mkimage
+-------
+
+Esta ferramenta é utilizada ao gerar uma Flat Image Tree (FIT), comumente usada
+em plataformas ARM. A ferramenta está disponível através do pacote ``u-boot-tools``
+ou pode ser compilada a partir do código-fonte do U-Boot. Veja as instruções em
+https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-linux
+
+GNU AWK
+-------
+
+O GNU AWK é necessário caso você deseje que a compilação do kernel gere dados de
+intervalo de endereços para
+módulos integrados (CONFIG_BUILTIN_MODULE_RANGES).
+
+Utilitários de sistema
+***********************
+
+Mudanças de arquitetura
+------------------------
+
+O DevFS tornou-se obsoleto em favor do udev
+(https://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+
+O suporte a UIDs de 32 bits já está implementado. Divirta-se!
+
+A documentação das funções do Linux está migrando para a documentação embutida
+(inline), por meio de comentários com formatação especial próximos às suas
+definições no código-fonte. Esses comentários podem ser combinados com arquivos
+ReST no diretório Documentation/ para criar uma documentação enriquecida, que
+pode então ser convertida para arquivos PostScript, HTML, LaTeX, ePUB e PDF.
+Para converter do formato ReST para o formato de sua escolha, você precisará do
+Sphinx.
+
+Util-linux
+----------
+
+Novas versões do util-linux oferecem suporte no ``fdisk`` para discos maiores,
+suporte a novas opções para o mount, reconhecimento de mais tipos de partição e
+outras funcionalidades interessantes. Você provavelmente vai querer atualizar.
+
+Ksymoops
+--------
+
+Se o impensável acontecer e o seu kernel sofrer um oops, você pode precisar da
+ferramenta ksymoops para decodificá-lo, mas na maioria dos casos, não será
+necessário. É geralmente preferível compilar o kernel com ``CONFIG_KALLSYMS`` para
+que ele produza dumps legíveis que possam ser usados no estado em que se
+encontram (isso também gera uma saída melhor do que a do ksymoops).
+Se por algum motivo o seu kernel não for compilado com ``CONFIG_KALLSYMS`` e você
+não tiver como recompilar e reproduzir o oops com essa opção, você ainda poderá
+decodificá-lo com o ksymoops.
+
+Mkinitrd
+--------
+
+Estas mudanças no layout da árvore de arquivos ``/lib/modules`` também exigem que o
+mkinitrd seja atualizado.
+
+E2fsprogs
+---------
+
+A versão mais recente do ``e2fsprogs`` corrige diversos bugs no fsck e no debugfs.
+Obviamente, é uma boa ideia atualizar.
+
+JFSutils
+--------
+
+O pacote jfsutils contém os utilitários para o sistema de arquivos. Os seguintes
+utilitários estão disponíveis:
+
+- ``fsck.jfs`` - inicia a reprodução (replay) do log de transações, além de
+  verificar e reparar uma partição formatada em JFS.
+
+- ``mkfs.jfs`` - cria uma partição formatada em JFS.
+
+Outros utilitários de sistema de arquivos também estão disponíveis neste pacote.
+
+Xfsprogs
+--------
+
+A versão mais recente do ``xfsprogs`` contém os utilitários ``mkfs.xfs``,
+``xfs_db`` e ``xfs_repair``, entre outros, para o sistema de arquivos XFS. Ele é
+independente de arquitetura e qualquer versão a partir da 2.0.0 deve funcionar
+corretamente com esta versão do código do kernel XFS (recomenda-se a
+versão 2.6.0 ou posterior, devido a algumas melhorias significativas).
+
+PCMCIAutils
+-----------
+
+O PCMCIAutils substitui o pcmcia-cs. Ele configura corretamente os sockets
+PCMCIA na inicialização do sistema e carrega os módulos apropriados para
+dispositivos PCMCIA de 16 bits, caso o kernel esteja modularizado e o subsistema
+de hotplug seja utilizado.
+
+Quota-tools
+-----------
+
+O suporte a UIDs e GIDs de 32 bits é necessário caso você deseje utilizar o
+formato de cota versão 2 mais recente. O quota-tools versão 3.07 e superiores
+possuem esse suporte. Utilize a versão recomendada ou superior da tabela acima.
+
+Intel IA32 microcode
+--------------------
+
+Um driver foi adicionado para permitir a atualização do microcódigo Intel IA32,
+acessível como um dispositivo de caracteres comum (misc). Se você não estiver
+usando o udev, você poderá precisar de::
+
+  mkdir /dev/cpu
+  mknod /dev/cpu/microcode c 10 184
+  chmod 0644 /dev/cpu/microcode
+
+você poderá precisar executar os comandos
+acima como root antes de poder usar isso. Você provavelmente também desejará
+obter o utilitário de espaço de usuário ``microcode_ctl`` para utilizar em
+conjunto com este driver.
+
+udev
+----
+
+O udev é uma aplicação de espaço de usuário para popular o diretório /dev
+dinamicamente, apenas com entradas para dispositivos de fato presentes no
+sistema. O udev substitui a funcionalidade básica do devfs, permitindo ao mesmo
+tempo a nomeação persistente de dispositivos.
+
+FUSE
+----
+
+Necessita do libfuse 2.4.0 ou posterior. O mínimo absoluto é a versão 2.3.0,
+mas as opções de montagem direct_io e kernel_cache não funcionarão.
+
+Redes
+******
+
+Mudanças gerais
+----------------
+
+Caso você tenha necessidades avançadas de configuração de rede, você deve
+provavelmente considerar o uso das ferramentas de rede do iproute2.
+
+Filtro de Pacotes / NAT
+------------------------
+
+O código de filtragem de pacotes e NAT utiliza as mesmas ferramentas da série
+anterior de kernels 2.4.x (iptables). Ele ainda inclui módulos de
+retrocompatibilidade para o ipchains (estilo 2.2.x) e o ipfwadm (estilo 2.0.x).
+
+PPP
+---
+
+O driver PPP foi reestruturado para suportar multilink e permitir que opere
+sobre diversas camadas de mídia. Se você utiliza PPP, atualize o pppd para, no
+mínimo, a versão 2.4.0.
+
+Se você não estiver usando o udev, você deve possuir o arquivo de dispositivo
+``/dev/ppp``, o qual pode ser criado por::
+
+  mknod /dev/ppp c 108 0
+
+como root.
+
+NFS-utils
+---------
+
+Em kernels antigos (2.4 e anteriores), o servidor NFS precisava conhecer
+qualquer cliente que pretendesse acessar arquivos via NFS. Essa informação era
+fornecida ao kernel pelo mountd quando o cliente montava o sistema de arquivos,
+ou pelo exportfs na inicialização do sistema. O exportfs obtinha informações
+sobre clientes ativos a partir de /var/lib/nfs/rmtab.
+
+Esta abordagem é bastante frágil, pois depende da integridade do rmtab, o que
+nem sempre é fácil, particularmente ao tentar implementar fail-over. Mesmo
+quando o sistema está funcionando bem, o rmtab sofre com o acúmulo de muitas
+entradas antigas que nunca são removidas.
+
+Com kernels modernos, temos a opção de fazer o kernel informar ao mountd quando
+recebe uma requisição de um host desconhecido, permitindo que o mountd forneça
+as informações de exportação apropriadas ao kernel. Isso remove a dependência do
+rmtab e significa que o kernel só precisa conhecer os clientes ativos no
+momento.
+
+Para habilitar esta nova funcionalidade, você precisa::
+
+  mount -t nfsd nfsd /proc/fs/nfsd
+
+antes de executar o exportfs ou o mountd. Recomenda-se que todos os serviços NFS
+sejam protegidos da internet em geral por um firewall, sempre que possível.
+
+mcelog
+------
+
+Em kernels x86, o utilitário mcelog é necessário para processar e registrar
+eventos de machine check quando opção CONFIG_X86_MCE está ativada. Eventos de
+machine check são erros relatados pela CPU. O processamento desses eventos é
+fortemente recomendado.
+
+Documentação do Kernel
+***********************
+
+Sphinx
+------
+
+Por favor, consulte Documentation/doc-guide/sphinx.rst para detalhes sobre os
+requisitos do Sphinx.
+
+rustdoc
+-------
+
+O rustdoc é utilizado para gerar a documentação para código Rust. Por favor,
+consulte Documentation/rust/general-information.rst para mais informações.
+
+Obtendo software atualizado
+============================
+
+Compilação do kernel
+**********************
+
+gcc
+---
+
+- <ftp://ftp.gnu.org/gnu/gcc/>
+
+Clang/LLVM
+----------
+
+- :ref:`Getting LLVM <getting_llvm>`.
+
+Rust
+----
+
+- Documentation/rust/quick-start.rst.
+
+bindgen
+-------
+
+- Documentation/rust/quick-start.rst.
+
+Make
+----
+
+- <ftp://ftp.gnu.org/gnu/make/>
+
+Bash
+----
+
+- <ftp://ftp.gnu.org/gnu/bash/>
+
+Binutils
+--------
+
+- <https://www.kernel.org/pub/linux/devel/binutils/>
+
+Flex
+----
+
+- <https://github.com/westes/flex/releases>
+
+Bison
+-----
+
+- <ftp://ftp.gnu.org/gnu/bison/>
+
+OpenSSL
+-------
+
+- <https://www.openssl.org/>
+
+System utilities
+****************
+
+Util-linux
+----------
+
+- <https://www.kernel.org/pub/linux/utils/util-linux/>
+
+Kmod
+----
+
+- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
+Ksymoops
+--------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
+
+Mkinitrd
+--------
+
+- <https://code.launchpad.net/initrd-tools/main>
+
+E2fsprogs
+---------
+
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
+
+JFSutils
+--------
+
+- <https://jfs.sourceforge.net/>
+
+Xfsprogs
+--------
+
+- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
+- <https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/>
+
+Pcmciautils
+-----------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
+
+Quota-tools
+-----------
+
+- <https://sourceforge.net/projects/linuxquota/>
+
+
+Intel P6 microcode
+------------------
+
+- <https://downloadcenter.intel.com/>
+
+udev
+----
+
+- <https://www.freedesktop.org/software/systemd/man/udev.html>
+
+FUSE
+----
+
+- <https://github.com/libfuse/libfuse/releases>
+
+mcelog
+------
+
+- <https://www.mcelog.org/>
+
+Redes
+******
+
+PPP
+---
+
+- <https://download.samba.org/pub/ppp/>
+- <https://git.ozlabs.org/?p=ppp.git>
+- <https://github.com/paulusmack/ppp/>
+
+NFS-utils
+---------
+
+- <https://sourceforge.net/project/showfiles.php?group_id=14>
+- <https://nfs.sourceforge.net/>
+
+Iptables
+--------
+
+- <https://netfilter.org/projects/iptables/index.html>
+
+Ip-route2
+---------
+
+- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
+
+OProfile
+--------
+
+- <https://oprofile.sf.net/download/>
+
+Kernel documentation
+********************
+
+Sphinx
+------
+
+- <https://www.sphinx-doc.org/>
diff --git a/Documentation/translations/sp_SP/process/howto.rst b/Documentation/translations/sp_SP/process/howto.rst
index e1a6e6a52ae4..c4ad3d48f155 100644
--- a/Documentation/translations/sp_SP/process/howto.rst
+++ b/Documentation/translations/sp_SP/process/howto.rst
@@ -91,7 +91,7 @@ de obligada lectura:
     describe lo que es necesario hacer para configurar y compilar el
     kernel. Quienes sean nuevos en el kernel deben comenzar aquí.
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements>`
     Este archivo proporciona una lista de los niveles mínimos de varios
     paquetes que son necesarios para construir y ejecutar el kernel
     exitosamente.
diff --git a/Documentation/translations/zh_CN/admin-guide/README.rst b/Documentation/translations/zh_CN/admin-guide/README.rst
index 7c2ffe7e87c7..0ee28ef2c4d1 100644
--- a/Documentation/translations/zh_CN/admin-guide/README.rst
+++ b/Documentation/translations/zh_CN/admin-guide/README.rst
@@ -52,7 +52,7 @@ Linux内核6.x版本 <http://kernel.org/>
 
  - 文档/子目录中有各种自述文件：例如，这些文件通常包含一些特定驱动程序的
    内核安装说明。请阅读
-   :ref:`Documentation/process/changes.rst <changes>` 文件，它包含了升级内核
+   :ref:`Documentation/process/software-requirements.rst <software-requirements>` 文件，它包含了升级内核
    可能会导致的问题的相关信息。
 
 安装内核源代码
@@ -104,7 +104,7 @@ Linux内核6.x版本 <http://kernel.org/>
 ---------
 
    编译和运行6.x内核需要各种软件包的最新版本。请参考
-   :ref:`Documentation/process/changes.rst <changes>`
+   :ref:`Documentation/process/software-requirements.rst <software-requirements>`
    来了解最低版本要求以及如何升级软件包。请注意，使用过旧版本的这些包可能会
    导致很难追踪的间接错误，因此不要以为在生成或操作过程中出现明显问题时可以
    只更新包。
@@ -225,7 +225,7 @@ Linux内核6.x版本 <http://kernel.org/>
 ---------
 
  - 确保您至少有gcc 8.1可用。
-   有关更多信息，请参阅 :ref:`Documentation/process/changes.rst <changes>` 。
+   有关更多信息，请参阅 :ref:`Documentation/process/software-requirements.rst <software-requirements>` 。
 
  - 执行 ``make`` 来创建压缩内核映像。如果您安装了lilo以适配内核makefile，
    那么也可以进行 ``make install`` ，但是您可能需要先检查特定的lilo设置。
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index cc47be356dd3..78ca3673fcf0 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -87,7 +87,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     新用户应该从这里开始。
 
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements>`
     文件给出了用来编译和使用内核所需要的最小软件包列表。
 
   :ref:`Documentation/translations/zh_CN/process/coding-style.rst <cn_codingstyle>`
diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 9be4915ae420..bceec0804501 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -55,7 +55,7 @@ Linux內核6.x版本 <http://kernel.org/>
 
  - 文檔/子目錄中有各種自述文件：例如，這些文件通常包含一些特定驅動程序的
    內核安裝說明。請閱讀
-   :ref:`Documentation/process/changes.rst <changes>` 文件，它包含了升級內核
+   :ref:`Documentation/process/software-requirements.rst <software-requirements>` 文件，它包含了升級內核
    可能會導致的問題的相關信息。
 
 安裝內核源代碼
@@ -107,7 +107,7 @@ Linux內核6.x版本 <http://kernel.org/>
 ---------
 
    編譯和運行6.x內核需要各種軟件包的最新版本。請參考
-   :ref:`Documentation/process/changes.rst <changes>`
+   :ref:`Documentation/process/software-requirements.rst <software-requirements.rst>`
    來了解最低版本要求以及如何升級軟件包。請注意，使用過舊版本的這些包可能會
    導致很難追蹤的間接錯誤，因此不要以爲在生成或操作過程中出現明顯問題時可以
    只更新包。
@@ -228,7 +228,7 @@ Linux內核6.x版本 <http://kernel.org/>
 ---------
 
  - 確保您至少有gcc 5.1可用。
-   有關更多信息，請參閱 :ref:`Documentation/process/changes.rst <changes>` 。
+   有關更多信息，請參閱 :ref:`Documentation/process/software-requirements.rst <software-requirements>` 。
 
  - 執行 ``make`` 來創建壓縮內核映像。如果您安裝了lilo以適配內核makefile，
    那麼也可以進行 ``make install`` ，但是您可能需要先檢查特定的lilo設置。
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 80c416483e73..84a5b5226314 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -90,7 +90,7 @@ Linux內核代碼中包含有大量的文檔。這些文檔對於學習如何與
     新用戶應該從這裡開始。
 
 
-  :ref:`Documentation/process/changes.rst <changes>`
+  :ref:`Documentation/process/software-requirements.rst <software-requirements>`
     文件給出了用來編譯和使用內核所需要的最小軟體包列表。
 
   :ref:`Documentation/translations/zh_TW/process/coding-style.rst <tw_codingstyle>`
diff --git a/README b/README
index e6549b2a7aac..98410e47616d 100644
--- a/README
+++ b/README
@@ -17,7 +17,7 @@ Essential Documentation
 
 All users should be familiar with:
 
-* Building requirements: Documentation/process/changes.rst
+* Building requirements: Documentation/process/software-requirements.rst
 * Code of Conduct: Documentation/process/code-of-conduct.rst
 * License: See COPYING
 
diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index cabe2d216997..e27d4c870d98 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -18,7 +18,7 @@ Compiling requires having installed:
  * llvm
  * pahole
 
-Consult :ref:`Documentation/process/changes.rst <changes>` for the minimum
+Consult :ref:`Documentation/process/software-requirements.rst <software-requirements>` for the minimum
 version numbers required and how to update them. Note that LLVM's tool
 'llc' must support target 'bpf', list version and supported targets with
 command: ``llc --version``
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 031f2192b390..0abf48c59ce0 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -3,7 +3,7 @@
 #
 # Print the minimum supported version of the given tool.
 # When you raise the minimum version, please update
-# Documentation/process/changes.rst as well.
+# Documentation/process/software-requirements.rst as well.
 
 set -e
 
diff --git a/scripts/ver_linux b/scripts/ver_linux
index 00bdaf30d590..1d860c8a37f3 100755
--- a/scripts/ver_linux
+++ b/scripts/ver_linux
@@ -7,7 +7,7 @@
 
 BEGIN {
 	usage = "If some fields are empty or look unusual you may have an old version.\n"
-	usage = usage "Compare to the current minimal requirements in Documentation/process/changes.rst\n"
+	usage = usage "Compare to the current minimal requirements in Documentation/process/software-requirements.rst\n"
 	print usage
 
 	system("uname -a")
-- 
2.54.0

