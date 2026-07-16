Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EEE28727D
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170451; cv=none; b=HeTSSGzRl+NVkaFUmFwAngJlwF5JksdFLiAuZ7QuIAWTyWaXnKLaz1EV4ZgxEfzYZTnxBiy+nxUnyXTIZDee9H1+6Zu+GvBf9Fp7PmIrrxhigIZODM5+cwWJgU9IiyhadxwuIOXN+LQkBNTpdJ1fkED/6OKOQXgzHjnQeebDWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170451; c=relaxed/simple;
	bh=jplXyjbwYz/QcAGg2H0J8hiAVcqFhJv9LJAFB6t6Fp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTmJ1+hzIzU2sjwvh1A4caOUuqOmqSSZFWlqczXhoEWTtYcMD3tYMcwQoDy+aAZFRxOvqm0ZoKytFHGpNwY0qR+bPkBxMQgewBf0MgJ+HylP0XTVFIihEmmncC2k5PXBydu50F1c8yqK0QygdxnTnl9lhR+kU3r9MY0zxg6PXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reDEZ0v7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reDEZ0v7"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so3210506a91.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784170449; x=1784775249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dv6aphQ0lu/azohKm7IVKPlY3gzISaBS16LtQ3l9PNo=;
        b=reDEZ0v7JbDcIPibS6la8g5nppzcLpdCimN2lnrnLyQf2H4VUBKtJQ2bVUuTYu7Bpt
         JTe+GoLyWKgs/W+OqdrJv44B8yNolnJO+yRmYlwmp5QOj73IZgQYISUDqzKu0mAVHO3+
         Vj+Aj2WDbeId4X2SyUYj9zS44cnl5jYnBLi5Js65EYMBadCzFNhCkIaHQiTlZmDYW6+B
         7dHmw5MemGmKbD4zoVn6CmC5mtv21cVDTH0M17flUK3ccJleq6fEDHfw3zLxEpmPpQGA
         lEWxxd6Xe9xywQDprOtNO9RST5n4ZLvQknyWrxuQGdT3xzTyjvNd2pBbFlgkAG9574AE
         PVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170449; x=1784775249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dv6aphQ0lu/azohKm7IVKPlY3gzISaBS16LtQ3l9PNo=;
        b=WEk/RYQEWV2wkXw2OBgzjFxVj8VvLk5sLw7J2ciWYjm39F4P9h9EwDKLdF49Ikgwj5
         xezh3nusd22PKLNaXskjqn4qM9SAnVhDQRQIpQF5sfGEO7hHBq0tcoVmWWINohGtZT2D
         1uG/pUKvmdWIM/+buvefZODPxPitMpThvtHu/uvbZA3+/0LvjFzkOfEl9cDCsF3dyzw2
         f27VERkREherOHhsL+IvVW5CiyAspC8YrcQ/AbE4brVbxF37oxk1CGMNdcUVPYKJzB+t
         pzh5pLaFdE1mLPXCml7gSZCFLwqlEaCnLIP+5aBw7v8UjvBbeObjdo2iEkaZYoQfiJBQ
         /K2w==
X-Forwarded-Encrypted: i=1; AHgh+Rqk0oAnfa1ceI7Nmk1sns60bSo6+DQ0bX950ywO+KHLEJK8AYgAqfaKz27VI/eZFkts24g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjIX5mSvwzFo+GSP/KwERrtbgiE842ddO70CoUZQ1lNP6znPf
	ijjgCvYqVgZk8DdNpNx+EHW8sLpTBbHc51zxmRti+kKdYybtrWNOWRofWwix4JlrqoQ=
X-Gm-Gg: AfdE7cn6KBRVXjgE8hluf5UoSsjBteg87HcvODzvtNCjR4YlcN7uWngExFTvzCbjzTx
	0taAR8kaMGFB38vJ3rD3Jm4HywIZLoPE0KPwNpYnjuMY1/H8GPDKAwnCgh5PpyDVq0bcUiRlF9R
	QXnTHtKRml6aCvTykgYMhWHrDCyDuUahTouBNj9gpT+QewssLye0tTlBPUr08dkbHtnN1QPbjRr
	1M7BOQbFb4mPPZBdNd/V2cVPeejUIp62O76vUhFBSR1ajz8LrAyg/S14B/W6FgxYWSZjkuQcH6A
	CAQCN6dXNScz6P3SbRMebw1tKtpwPAtS6n8oqHRHWswOOzuCces9YrLBwDVfpi2nJMFdQrf4qIU
	fepJEFjDjPlZg7recavSQofMWytGA74XxmYG1o1AT+WsBBW2KJpZaktxmyt+j2XzCikZP9k0E1I
	QoPI1PEoVsDFQQMXxJLwZ1ME0Xt/mUuFyuUwH1uDJipDvomNV6rS/8xgj+2xHlGbunZBRzaQ==
X-Received: by 2002:a17:90b:5146:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-38def480cbdmr16308118a91.10.1784170449479;
        Wed, 15 Jul 2026 19:54:09 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:4eeb:a8ed:60ba:3d:9b14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e2a20b2a2sm892232a91.1.2026.07.15.19.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 19:54:08 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping
Date: Thu, 16 Jul 2026 10:53:42 +0800
Message-ID: <20260716025342.42628-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After switching to the kernel's default package scripts for our local
kernel RPM builds, we noticed that module BTF entries were missing:

  $ ls /sys/kernel/btf/
  vmlinux    <<<< only vmlinux, no module BTF

Root cause: find-debuginfo.sh (from the debugedit package) prefers
eu-strip over strip when elfutils is installed, which is the common
case on RHEL 9. eu-strip removes non-allocated ELF sections, including
the .BTF section that contains BPF Type Format information for kernel
modules. Without .BTF, BPF tools (bpftool, bcc, bpftrace) cannot resolve
kernel types at runtime, and /sys/kernel/btf/<module> entries are not
created when modules are loaded.

Fix by passing --keep-section .BTF via _find_debuginfo_opts, which adds
-K .BTF to the eu-strip/strip command, preserving the .BTF section while
allowing normal debuginfo extraction to proceed.

After this change, all module BTF files are properly generated:

  $ ls /sys/kernel/btf/
  aesni_intel         drm                 i2c_i801            mfd_core
  ahci                drm_client_lib      i2c_mux             net_failover
  backlight           drm_kms_helper      i2c_smbus           pcspkr
  ccp                 drm_shmem_helper    input_leds          qemu_fw_cfg
  dm_log              failover            intel_rapl_common   sch_fq_codel
  dm_mirror           fat                 intel_rapl_msr      serio_raw
  dm_mod              fuse                irqbypass           sunrpc
  dm_region_hash      gf128mul            iTCO_wdt            vfat
  virtio_balloon      virtio_console      virtio_dma_buf      virtio_gpu
  virtio_net          virtio_rng          virtio_blk          vmlinux
  xfs

Assisted-by: Comagic:DeepSeek-V4-Flash
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/package/kernel.spec | 2 +-
 scripts/package/mkspec      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

v1->v2: check if find-debuginfo.sh supports --keep-section (sashiko-bot)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..2e16de54ed74 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,7 @@ This package provides debug information for the kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
-%global _find_debuginfo_opts -r
+%global _find_debuginfo_opts -r%{?with_keep_section: --keep-section .BTF}
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c604f8c174e2..00acef348ba8 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -65,6 +65,11 @@ fi
 echo "%define with_debuginfo_manual $with_debuginfo_manual"
 echo "%define with_debuginfo_rpm $with_debuginfo_rpm"
 
+# Detect if find-debuginfo.sh supports --keep-section (RHEL 9+)
+if find-debuginfo.sh --help 2>&1 | grep -q keep-section; then
+	echo "%global with_keep_section 1"
+fi
+
 cat<<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
-- 
2.52.0

