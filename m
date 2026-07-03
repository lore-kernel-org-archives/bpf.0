Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8B3D171C
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081740; cv=none; b=hrRWpGt9D0/y6iFHkD5PzopOPJM2NXpnVy9rZCiaMFXupAFgNNg/81KWFWNtxxMrI/pcC5ZKiWuvqUB5+BRxy0qbSwDlFX4bgpW94Fhyv6EvJyLu8ZMzm9IciUbGH8sPqCV7m+1tbBAX3d2n+NZsq4Z4aH7aRa7g8Gp+J8hAKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081740; c=relaxed/simple;
	bh=R91542bB5CYtbj9FWp/+W0JMaOO6fVrDX51mZmOMWCg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mh9jUKHIjRvyPmKwV/au51X2KHlIbsPSOf7p3X9+/3V+YPfUoqSUb9PyLlvEGm3Xj7malBG7wKu4TnDlUMWbrQDiQ9lhLwEB/sb2vfsRbHXVbY3bcWBOTWXpfXcNvyvb1Gy3uxFJkztXcX+b6aMObRKfjxRQXqmNbcisivvb7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Pb8fcf4/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Pb8fcf4/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845ea8924fdso529886b3a.0
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783081738; x=1783686538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xWVG/3qQZSSCl9XZAnFe0CG/d9wAGXcusZYIWuv8No=;
        b=Pb8fcf4/0Sgohk6LKbKU/6ei+inw+Zka+/Z1NkZ2gzXg+ccnbCrIlqRAIijyMIb/ZM
         tb97s70U+q+ON6q6tbGmVP5kAFuEPbzXd0o82RF4cDlP/YLTq+xEspW87zFUPZuqsVnH
         o4QThFvErPJO0MBNwPDgHtSRNZsoXHOyWuGNDfAW0vIyIzFfX22fqg1m6dvJkYo+JtMk
         0+sXwAo7e5tW9YJkFbKjQ1x4RhFwjWixB0a9Gc12YgDvTA5iEfDkiTcNv8MZnuv2h4XA
         rVjl+4rhCbF90BRVU53gYQrbyjOv9kFfDYHwZ3i0oPoo6mxTja/ew1sYPKAY750QYd+M
         Y9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081738; x=1783686538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xWVG/3qQZSSCl9XZAnFe0CG/d9wAGXcusZYIWuv8No=;
        b=SAxheKyx7LqNS6OVpYcSFUL3jFJkfvRkSPUWd2jvx9H5InralDxS6lr4TOsSaqLB2m
         0MktIt4HFRNSGeYze0WCI4sL8fpyY1ayxWawztJEe1psV3Lqq9maHF4xZ9OPPhUNH+X/
         bBF0xHkP5rTvjgJ+w0fi5Q6slgGvO2VLqMCWrcYJXDu6jPXaiU3h7LGUkEp9nNGLFE5b
         xXc2qZeFB0eXQp0WTOO5G16e5V1EmXCjE5GnU2djFD+wNtlLREk+rY9bX9AihCUdQH4Y
         v1XfJ5jZh45PkNwGdoF0z6nFImgaRLJrfExZ1XwIocUGnyYuH+9Ryg6geMNkxV4NXuMW
         ddKw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4+WfF5TA1WMd3oRFsBnmwCPoNLbJD3fe0FgIgj2ZXpFLDE3bL8dAB1l2aYtPb2dG2rKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpA7lFlNAKQgf0KYw+52GP9t3knVXjiM78f9EmPP3Blz4NzML7
	YydaXMr57Vv26zRYyTiHbd+eBqD5Lzf6wOqNH5L7fd0aEA2VjJkn7GSeGOjZpRJyXNs=
X-Gm-Gg: AfdE7clUjQzaXpoYFVPGkFDSqoJSr7hBmaS72B0kKDQNmpv6mhsDoe/4irkD4gi3VqF
	aDUwxXYy2xXo+ehFptE9uwSVSIV6NW1dYfUo1nT2x6ixERiggnxj6XAJ4gwnTIaK5BpiUBYHltc
	+VZI38odl2uLaXSP0DAhVhjWOqY038Lc6qAYKfml5YiJNemex2T9dTqokfa5rSIRl0DHY1Eatbu
	wnkOe5wjchRrEWTIrqQOMUFMYRy6BpWgNnmn7A6xeaiSYhPNanQz8s0dCzIU/OvTYdvONUpBToK
	wsGKPoNpw9tv15AdjpoCYYen3tL24Nj0wiVOo1/CWRZHlHV220qGMTYHnWf76k51voD81uBGzpE
	meWABhhk0+DcOZXTuk9wamIFjxgaWoEPrHSsOFinRfeeM+dQvuvfv0XwZEP4DxfdIglQ9AVlTWp
	Pm+NoWrKAUbIvPjlUmBAPzfjgVmb7yfLY+gmbscUsoAzFS1Vu9YFDlEM/+fOU4Ng==
X-Received: by 2002:a05:6a00:18a7:b0:847:8b0f:2508 with SMTP id d2e1a72fcca58-847c0686cc3mr10380342b3a.13.1783081738170;
        Fri, 03 Jul 2026 05:28:58 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2705551a12.9.2026.07.03.05.28.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 05:28:56 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v8 0/3] riscv: fix PIO helpers and add optimized percpu ops
Date: Fri,  3 Jul 2026 20:28:29 +0800
Message-Id: <20260703122832.15984-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v8:
- Fold the TASK_TI_CPU_NUM cleanup into patch 3.
- Pick up Arnd's Reviewed-by tag for patch 1.

Changes in v7:
- Rename the internal AND helpers for consistency.
- Undefine internal percpu helper macros before including asm-generic/percpu.h.

Changes in v6:
- Keep the RISC-V PIO fix local by directly guarding ins*/outs* helpers.
- Add the missing asm/cmpxchg.h include and clean up LR/SC fallback naming.

Changes in v5:
- Drop the generic HAS_IOPORT_MAP/ioport_map changes.
- Fix 8/16-bit LR/SC fallback masking and constraints.
- Initialize secondary idle task pcpu_offset before CPU bringup.

Changes in v4:
- Rework the series into the current PIO helper fix, percpu.h, and
  thread_info pcpu_offset layout.
- Keep the generic pci_iounmap() behavior intact.

Changes in v3:
- Fix this_cpu_cmpxchg128() build issues when cmpxchg128 is unavailable.
- Fix sparse warnings.

Changes in v2:
- Add non-Zabha percpu add/and/or support.
- Add the thread_info pcpu_offset optimization.

Changes in v1:
- Initial RISC-V percpu.h series using optimized native-width percpu ops.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |   8 +
 arch/riscv/include/asm/percpu.h      | 300 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   2 +-
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 329 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h


base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
-- 
2.39.5

