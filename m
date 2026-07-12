Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C237104F
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783837741; cv=none; b=jdMWbtsJ0TbUuM+zIVO7gTEUWJNeBd0b1GLCq3BLMP9wVAlyM5GjzhQUin4UmR+j0rNR1dZEg5HAu4NIm5MWc3m/BmIoXkjDBt8NgKB6pdg5ZGP7doJxuw9AmL/tlFIraij/5Evrk5SqWEuHrExRdn/1v3/2a3eq8k3kR4VCXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783837741; c=relaxed/simple;
	bh=2K/KkTjUhL2nqJ3NlPCO/aThziaUhz1j1o5yMyvHTSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhGj/sWixJ2/9RmfgPIittBZu9Hy5jIyO5XSGSrQ9VseK3m4ITDoQYrJWdCiOpkkVe+S6oRIFVxPSOmq2zPZVDii2bfdv18cpJsL4HF7XmQHx6W++OJqKIKS1jJ8gbdIIgN+IJ1jWstlvKcenCZw+N3Hh09QQT32TT9HNvn/WQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7Q4EoV8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7Q4EoV8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cea3004256so12310615ad.0
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 23:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783837739; x=1784442539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLn6r+Z8S2FKgSLoMy7A5DQNAUBY1hMIxhMu8ezOLig=;
        b=K7Q4EoV878Y1YgTmqDf/3ed5Ao0DivPzMImxvI/QxKyA85izWdO0xWHdviVZIKn7vF
         KCRFcfznQJwxrCsSYYS9sKm9Ux+tYAezTbFChpiPNDv/moA5uoZW9OjfHQ+6n7OUeSuZ
         QqYtktmfh8E2nrjFe2vbC8rH0ZVCNEoZ2vtwOctq5idL7gcWAdNBOm5dGt5+GDu0lx4E
         izftkwXIp4Lf5eQKdXY7BRFtjMOrNJephRE5exo2Vx6gBqM9gUwoQyf+fZT0XUKrJVQm
         05yZCQuYt4lXxtCMJ2ZrqgnO3UsOnVntRJbEN0naCL2LYKgwb1+24VfRw68w83vE+B0M
         pnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783837739; x=1784442539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLn6r+Z8S2FKgSLoMy7A5DQNAUBY1hMIxhMu8ezOLig=;
        b=sr/dAc9+dAVKLwxR8djTrdyrWUIrYGtEcPLFeHdeBWgLjdq9WNWNaZjdB4LAK/Zt02
         Bg6zX8oBG8b8LFe7icq7Foh0ZOie7AIYj1O/FdO0xCK/65cz6IJUNiZyGpSZ50G7TinL
         PjEPRWt2wGpQ2TegYl/Olx+JosfqrQBvtEUF3sFCGWkHN7LLdxoVltt6G0o2TgVqn0TC
         R01mbgVWuOkCOpXnkaVkWfG8xBEzaN1GUAv7MR06+Om8uQtwHAnyOfz1gWdkujq9fPIC
         cx5Ofhm9eG1WEoVWNndWZR5XN+6JnSfFiFSIZ1VTV1Y3PR5Ix6pt+4/ZWFb22bvX9RFx
         eEVA==
X-Forwarded-Encrypted: i=1; AHgh+Rqb9T3/ZeztlT1mQlqVm8C44IihxOR477pEtOpn1wKs1AzGTrNdRWF3mzmVSjT0otX9pwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXdxaTKXMJTH/YFbqLqEy6OAyx1f/CeagsgEKbYiYvclsj4mI
	3Sr9tQHIsfLqmjVz8oucFjDApyBuO//uGkd6m0xacj80A5xAOz5KLKlM
X-Gm-Gg: AfdE7cl1OKJSdsD7xTGtw1wqTPRXJKBfjihPHZ0Co84Vr+622+9g72PL4P7oBFyxIfV
	fWUm89f6bxJIUCRZsOcbIdbpikNNWI+1o3GD5d69XtgT5QdS93KpkK8ZDlTYiIz1df3UCaK3nYp
	pBIV2nLIbAOSZqB+b+W4ozMT/olx8/ChLUCIhYz2veVSI9CTShiZ/miWF3yYPEkMeQePueiYmUi
	ZmJNLlSbDqb1BjoHCmbGuJ8rQOQjU2zLkTYkh+9tC1DFnOho7HNOu4A+soYTDqE5vfAlux3Gu2T
	5KMWcOSXpwRPN45eQF2RUOvZDZaQjp0rQ3fIz2wwmkd9hM/bDFnCq/stsQJqNqrngqXrsOxs5Z2
	CigaVZHOsc1DFH/trfbUzk/0CuOjvQ4i9BEe3Zx+alxbLZ27rcMoQLy74v+7doMLeVGj18pnbfQ
	hIAEoCIMsfKyPYgcXxxsQJdOr0CAD/ocMm38VFHcTLxNCkNaIW1yiMBV7Wz7YIAwPyY3zWYPjwu
	7NICPYwmTkfBsEigWw=
X-Received: by 2002:a17:902:e808:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2ce9e79f45amr50552315ad.2.1783837739080;
        Sat, 11 Jul 2026 23:28:59 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:a300:12ed:a5f4:d452:8dd:52e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8f26sm83270835ad.27.2026.07.11.23.28.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 23:28:58 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: nathan@kernel.org,
	nsc@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] kbuild: rpm-pkg: Preserve .BTF section in kernel modules during debuginfo stripping
Date: Sun, 12 Jul 2026 14:28:33 +0800
Message-ID: <20260712062834.77872-1-laoar.shao@gmail.com>
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
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index c732415662ef..abc73de019e0 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -67,7 +67,7 @@ This package provides debug information for the kernel image and modules from th
 %undefine _unique_debug_srcs
 %undefine _debugsource_packages
 %undefine _debuginfo_subpackages
-%global _find_debuginfo_opts -r
+%global _find_debuginfo_opts -r --keep-section .BTF
 %global _missing_build_ids_terminate_build 1
 %global _no_recompute_build_ids 1
 %{debug_package}
-- 
2.52.0

