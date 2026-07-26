Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65B2D5937
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785034394; cv=none; b=BK8sI6peFZ7+4Fq99BFkMm868iSafvi9ZrH/ulm2pv37uqe42PJb6F3qyhCUrkop2gqy5bLAJQqYL2T7SVUsfounoX35zE968/sawU2lQBHD/PCAFqqQSoMwui7hn4weQSfl/4IhRAuc614l1ROxtHHAXH6Yj5F7iPvExxIRQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785034394; c=relaxed/simple;
	bh=ur7J3+xa2ZE/P0fviH4Md/Wp2oKnOCvVnY95NF6AUpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA+3ptmv/xYZCpjz+7uFxZpb6Ufcw9fqdTNKzw1MwIdqb5rMQ5CU2AP8ZnX05Igs9T0vK0zCkM4MFAakc6afXaO5WRnoVb4X9BqyTmlwSlnBf8wyWcUzXmbyviiWLp9agu4iWxLsfURz7+4QUjI35uKNac0vM301EGkbZfJmSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa/4ZN+V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa/4ZN+V"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc891373e0so16943595ad.2
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 19:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785034393; x=1785639193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+fZlpoNwUNiIF9UMejK6Q5RLcRANFeTV+evvoYlWpc=;
        b=sa/4ZN+VqkOZ9H7mpmfN1XffHKNmq2HaibTGqRcVepjMgrpID2zavKEgQ5Ie56vAWr
         JPkkUyLD05HdvD6al4y7wYaI5BZ26NMeg+bsVfAdiw9t4mtHXDXDsHOv9Jx5EjQWEzT8
         /usVp1HtC8ejNdNSeXKvStQzG0u3fboWuLft+6mvAuj1FIEiSvlF4AgBrrna8LdxeMYa
         bIPDQ0ZGSP21M2cnVTnVswvYkYzzNtqTSM2e/xvrCgCqRjSlElOfIN3TKTl4nJPdcRLL
         23qm4e38vufZUg18zcxeEhgYw8QNvp4s8u6iK5i9hkfss29wu6D0/F5Gj/1nSqKuCa5E
         9fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785034393; x=1785639193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+fZlpoNwUNiIF9UMejK6Q5RLcRANFeTV+evvoYlWpc=;
        b=FUjiG21qWe1+81dTWx6jLv1AG9g93zDjbOi7ySGwN7FDu28uMDuV1ZmTOL/WaBESEv
         ZLUmVNxv7SeWzVoqGqehEZC9ReFYy1XAVpHIbd9HSvmEuVh9OAoZC9KsXeUOQ+LIF49M
         bKDd5vXg5L4tjFK8RRcjNpI7Q9eUgt6HHJpa9Xo7GCt9VQ/LsiN7BlRu09hVB/W2FzCN
         gDJSLAbpfPO0hTHb/OflwsLT10H4dg9tZGLEt5kqKzu7NPXcaaqXmPwQgAEYl4x3ZlWD
         u4kkhH2MNZbZyDKf+xp0w82hSJlmLsio4icN6XiYri562rMX7Dh166BR1BQRE5/o+X83
         6CDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqa+jkv2OYOgelCV8ITRUCefM+nEdPe3/K4CFjLaDbVWf2u8EX6rfoNUZ40VSW1st4SDEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspSPgdjcH5/3Uqv3f0E6eAltl8M3LHaR1cdqhm60ezjAFFd7z
	Nibe+OmjbM+TiiLVWBZKC/BAQvCm8N6S6P77Rffob2zXdGqcmA97yKyT
X-Gm-Gg: AR+sD107YSVZ+chWvsJnjhJzY2yzowaAm9lHSTfpnUg2pPlGxQIpu9quJmFLmTZx6p3
	SGKmgxGgKknvMX1ilYp5XpUSazAWa3v6ZHKdubxZ8ht0m/bJx6KkjR8BzkczckDKaI9mh8X8qH9
	XMptvYm6HOYBrhEjrX0Aqj1JSsxG0cbZqVjSZiPJjjuN/O4Mv/snHyqt/EUIg1aLu2wa5ajL8gx
	kNd2UtyCcm9ThQirGhDHpYEcmoQ24gxfP1eROrpJt2HrvsH+doJwSs/OYmImlCHOxxObTHUBpgX
	AJwVWcZdzRti1Rp6DlX4eDt4UX5YsLqch+lCtNBjGaKuPLsvcyvlb6RJT4+LHpF3aY7xACJ/VIz
	Px7LRjWR0X4z9iQSdy5h9Rx8n/nItiOdUSHFyDm1GHLnuxqa/tAfGChiDAjUL+fhCxUVJl0xzVD
	/tusyRqFVgUVszdXaN25P5IcZBW1UdgiT91adROvqoWDmZXuxt+OaEnckmQ+13VDaLEWOIkPo=
X-Received: by 2002:a17:90b:2b50:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-38f2939e6c4mr3721113a91.7.1785034392599;
        Sat, 25 Jul 2026 19:53:12 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:2000:294d:9ad:36c8:10e3:4aa8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951eb8dsm1324936a91.13.2026.07.25.19.53.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 19:53:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3] kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping
Date: Sun, 26 Jul 2026 10:52:42 +0800
Message-ID: <20260726025242.42245-1-laoar.shao@gmail.com>
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

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 scripts/package/kernel.spec | 10 ++++++++++
 1 file changed, 10 insertions(+)

v2->v3: use %{__find_debuginfo} (Nathan)
v1->v2: check if find-debuginfo.sh supports --keep-section (sashiko-bot)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..1032f337a71c 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,17 @@ This package provides debug information for the kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
+
+# Preserve .BTF section in kernel modules during debuginfo stripping
+# find-debuginfo.sh (from debugedit) uses eu-strip which removes
+# non-allocated ELF sections like .BTF by default.
+%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c keep-section)
+%if %{with_keep_section}
+%global _find_debuginfo_opts -r --keep-section .BTF
+%else
 %global _find_debuginfo_opts -r
+%endif
+
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
-- 
2.52.0

