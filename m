Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F32F12A1
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206998; cv=none; b=cyDmPxaZJWyVWnBGlZkKizVev5scDnwjnmkZ4BbwrwxxGtarkcV1isWDiX1CFfD3bvdgvB5DL6571wEIErmOnLcDO4naTGxPiL0I7NWxto57vDPe3LAzpVOU/0LJSpZ3tKnbP8gfbqz4Kujo6d7iXOYmjDxevMbVoP+Q4rbBSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206998; c=relaxed/simple;
	bh=i0mVqTDUN/9+vDDOLv/mAzRRG1/9HWzzbVYqc+RqxLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STljhmpsHWSORYVaaQZBM62G+A2m6ts2OobvMXd/TdqCEc+Z4OsXOS23ZgccwwsiRf6htew1pxz2QYY6o3iDKvDjomts2dbLTpJyzGVzIMc3AivDPZQH8VaXZhMV4D1LCEQnBy4Ck457ECzAMp2dmiA6mWLlnlbh32ojuPsln9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN5q8Sso; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN5q8Sso"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2075355a91.2
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 19:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785206997; x=1785811797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jCR20QB8tg3udQ1a+h/sLLlAn/C0I59VUkGk7ueLTTs=;
        b=JN5q8SsoaK+zu7lEDbM4Idg4JihRnDCPf7IvnAX89qBD5nkGuGvQbT4qWWCnulxs6S
         MqexYx+CVbpbb19Ap2Kkw0oyojdT0GEXoQbm0W3D1Sa+YgF9hyRu7m0Lr+6zdfCyXX9m
         QtsY20H88WejC9/uTsxFqlWQ+fmgbyLCsP6+HXXhYvQs9tZWM2hyVMQMtDePoPyzA2kE
         sx1PXCiXGmDxrV6QFicG3di38oR1OCXQAy/IDzYxjQXTWAO1T2pkFycqekpMjA6CjAyX
         Ogr96vNWufKdym0oE9xXu3hhwJFqm2xDZ/4lHdku4G5HrIkMAvkl2fVwvJMh5HXOliu+
         TS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785206997; x=1785811797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCR20QB8tg3udQ1a+h/sLLlAn/C0I59VUkGk7ueLTTs=;
        b=M83MFxj6YdePrQDB6bQ9PwLEQZtwldN7F/bzlH4OE4/oVs0vVrRvULt4SUAIO9o5sU
         oyXWn3jcXR3WXuqbNKTGROrreXdTWvHSxmX54wPBNXuz+THSmdaKW4CTKwD1CF6QbAKr
         0JwgJt/fPTzfCL2Fe/5UqDBTizlAjZnYxsYzbKI4hyDiNy36Zm5cUBXbGjHkHS5xhtkO
         HT20YZIqIDv8tofHJxRFL4vogVXm/KWRk19Apva31GE/SdXvGMRzzx8Bl4nsmWAhCtrk
         BWlO+/RqrJVcnqj6teIjTKJjry51oBm9aU+gD1amGi3GtVrO7yF/fCbtO+5iigy2tfBh
         Ed5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqebEzeTRhJ0Q0G6JaCkTAzRp0+ojrAkUhapQmZDysLXJEl7IEf744yQNoxLyV8l0w+fEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbJFGU74fnUJk5kr740yhRF7o9FJtzcTyuY9w7mNqQOeozHAx
	gwoVONJDsm+LeYnUS98FAiXaUdT0ItFZNNkx6vuL6/JlitwWOvI9+2HA
X-Gm-Gg: AR+sD10twTQUqzk2FUpsL3dZWG1U1KsLUQ5yNcjZxLZSQ9Mc7bHU9p/OIYDZW6hii1w
	M5tFvVWbj8GTnPI6lnplXVQLQYFRWNg0OiqW+mdlTUPnSzgAP3LpKH9zny0wT5Nvsip4lukLj9U
	+j5FoXrtHAVA2+5jSN/ytekO17ht0vLVRhrMplEXcPs4HXzLeA1wvZHZh6kirL2cX3JXLrVYUo8
	SkunsmHfmzhBpX6BvQ2XS0jr0TWN9Ug2KF+TRibkZkwk3tSZojiMsPXwfsolXAmBcmspEiIV5ID
	j5d280IaYhqEy6+VD14sfxJ86h6J9cdTwqFn02bSbHwlE1z1fsJlPpzBt8onKON0t4xANaR7FC5
	WRLX1FUENwtBY61E1KRti28bUlalEiBoRx8/dG+qitehZb5JyOwM74WpKm11LvtWkUtVMF/ccmh
	4jZQOo29kujTDQzvmBIivsZxqhzHbSpbu3Vu8nP5plt4BUwZMjcUuMCMk8iXJn
X-Received: by 2002:a17:90b:2e4f:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38f6a31097fmr685575a91.2.1785206996673;
        Mon, 27 Jul 2026 19:49:56 -0700 (PDT)
Received: from localhost.localdomain ([101.90.42.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089e3472sm4346867a91.3.2026.07.27.19.49.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 19:49:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4] kbuild: rpm-pkg: Preserve BTF sections in kernel modules during debuginfo stripping
Date: Tue, 28 Jul 2026 10:49:50 +0800
Message-ID: <20260728024950.44946-1-laoar.shao@gmail.com>
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

Additionally, since commit 8646db238997 ("libbpf,bpf: Share BTF
relocate-related code with kernel"), modules contain a .BTF.base section
that maps distilled type IDs to vmlinux types. If .BTF.base is stripped,
btf_parse_module() falls back to vmlinux BTF directly, causing type ID
mismatches and rejecting the module's BTF entirely.

Fix by passing --keep-section .BTF and --keep-section .BTF.base via
_find_debuginfo_opts, which adds -K .BTF and -K .BTF.base to the
eu-strip/strip command, preserving both sections while allowing normal
debuginfo extraction to proceed.

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
Cc: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/package/kernel.spec | 11 +++++++++++
 1 file changed, 11 insertions(+)

v3->v4: also preserve .BTF.base (sashiko-bot)
v2->v3: use %{__find_debuginfo} (Nathan)
v1->v2: check if find-debuginfo.sh supports --keep-section (sashiko-bot)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..46e80970f723 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,18 @@ This package provides debug information for the kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
+
+# Preserve .BTF and .BTF.base sections in kernel modules during debuginfo
+# stripping. find-debuginfo.sh uses eu-strip which removes non-allocated ELF
+# sections like .BTF by default. .BTF.base is required for BTF distillation
+# support; without it, module BTF validation fails.
+%global with_keep_section %(%{__find_debuginfo} --help 2>&1 | grep -c keep-section)
+%if %{with_keep_section}
+%global _find_debuginfo_opts -r --keep-section .BTF --keep-section .BTF.base
+%else
 %global _find_debuginfo_opts -r
+%endif
+
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
-- 
2.52.0

