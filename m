Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854593C9EF3
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962056; cv=none; b=KhbyJ56JU6u3rTEqcyKZyMtgIGmHMpIbiCfi2IFPnnOozSvs2S/lSDKz8CSCsCM7TMYOMbu7mon6XUYpMj3vYIjt6Rjd3F7TVCTSas8JNlN8WswIVbhZllMDBZjmLL4PKWPf7SZUBYYB9+2M0cKQtKT74dahn1ereod5VFRrslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962056; c=relaxed/simple;
	bh=1N/LGKwuOq9v0S6+Nwko/9VEdnuS/5VPERf1X8fCvxQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I9nfdQpl/X9xShhBPM34hqBtoQ0WFhW/dXsAiau/i7u4xFIatGTNz//pLLHNa829NlffVQBNe9TMPvG0UBYVCL0zHA8Q0C/oyviKsQvyRAcRclKKaM2rUDwWNOiRmyLGP2oltYjXxqmBdIIvmgutXxorayBPcHpkRvKoOpVGSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FsV0MrSy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FsV0MrSy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8379e010b01so762518b3a.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777962053; x=1778566853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IABxPdOKi9qQ0ncIcorYGTDUXVbyRSpLw0RRqytGSAg=;
        b=FsV0MrSyX4dGKdiYBjvMJ9Znh2XOJdS0ondvQExYTP/ZZvjB8PFlRxVXsvQ2IST+v/
         h4JNWJmC4ZCQ5jEffyic0zd+xwMdDY/d+ZzBH8PnaDVNWWQXODeTiIKoeTkYxZ+w8rYE
         7COZbfLpHfZ8mRvW/5y6Cq+4gS+QUZIlRUvxbdtULto8pFG6ehbE0K9kf4WhvzFiGSh+
         3I04eNkiw16xvQ5s6p9sXiu0PsDhPx3aUaxpuJGqFhAtSjTP78ZYb+312t9kv9atG6+t
         lSkK4w2SBUNCyEshTZJlAa+b2xDOL8og2YFR25EhQCa2tP8xQ7G1LYn59+hc8dufgRwq
         93zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962053; x=1778566853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IABxPdOKi9qQ0ncIcorYGTDUXVbyRSpLw0RRqytGSAg=;
        b=cckXiCCyx0v0rLY34aik3jNA/6KnRpWDW34M/4XLghfbNeV5ejcRQYuSJgRzEr8zXV
         TB+f48/HmVH52WcR+nlGMRZueIYDZxkuWBqgdwK7owQxYk2keczjwrl7ua/1R0YIiFPx
         Tqj3X+ZuEdcog2FbTQA0+xw5eA3D8y6WuphQOdg3KftuUcSqhqnFKyZf8gKntF7hJ8F5
         J8fjT1IMzXngcxBaUzrwuFziq/hkQhiT3q9GF9PJDWDzAOG7zn2IWG/0P6tjJZZf4gM2
         safa6Ho00p8M/TgIBUhrDzy6m471Z12IqxjXIYfjZxL3jc+/V5RST0aOGyM1U0DAMcaG
         kFTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3vD+jjqx71pOtd26dR5hGKrLfN7Mb2z5uMzePQXssOvTP3pgRPGk+wB4Sxf/BLbUgnQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCyKNpSvw/wZbgxSUlylV1JrQ3GUPt5r25TDZ2u7PkwqSBwTn
	3etP4WsOpepQMSNDqOhSEb4bdsgb9mqP9gD2EEHeHhh92ZfXd50Xi8e1ugI0c0+ObJ0=
X-Gm-Gg: AeBDiev2bHNLXEfsOU+z7q681QPZ3+jv4dZfSCSWTxzo/uEmvJMFm0mfd/7zuOoMeTP
	xlIsUP7Xg5t0ZzZzHxtYtV+o7VwklLZZW33oNc30GxupEHYCZjqU5K8hCeIVXTimpYKO5xR3QpX
	+0gB5ElhGVjWjr7NrAnKcoQ+68D243Vu8L0iZ42hYvjEGNgH769oAL32y4CLuK/yVyMRb6Ks58p
	0R8b8tNOvV4h6TajH3UPlBtcWk8yjXmKAXueKJ1ciNKwdJuYEooE1WDHylejUnzhWBDjoFG2KXZ
	Z/F5tIz4/6QQjK0Va53H5wRlXOkxFu04wjDWgZNZnIfDovLCx4/ml4HoR6mLnXraKvrjT3PSPiS
	MuCvr4M54xuVKH5275xxT0KM6goWEnHnEmf7HANH/DJ4yumJSl0nByx2Ujj1DP3y+pjAz8vry3S
	yKgyocMjSq/ZgtFzvLuVJd9RSFZIJs+TLhR/1Rb2mfa9pu22rygO1JqAmuN1z9yVjh
X-Received: by 2002:a05:6a00:c8c:b0:838:3f54:a0ee with SMTP id d2e1a72fcca58-8383f54a1aamr5208071b3a.7.1777962052522;
        Mon, 04 May 2026 23:20:52 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c10sm880738b3a.37.2026.05.04.23.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 23:20:52 -0700 (PDT)
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
Subject: [PATCH v4 0/3] riscv: improve percpu helpers and PIO mapping
Date: Tue,  5 May 2026 14:20:23 +0800
Message-Id: <20260505062026.91724-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series makes three small RISC-V cleanups and fixes around percpu access
and PIO helper handling.

This work is motivated in part by build reports from lkp and by follow-up
review/discussion around the percpu access rework:

https://lore.kernel.org/all/202512202218.FI6bB5kV-lkp@intel.com/
https://lore.kernel.org/all/202512210052.w0bpUAAO-lkp@intel.com/

1. Avoid forming invalid PIO address expressions when I/O port support is not
enabled, while keeping the generic pci_iounmap() behavior intact.

2. Introduce arch/riscv/include/asm/percpu.h with RISC-V-specific percpu
helpers, including the fix for the 8/16-bit add_return LR/SC fallback.

3. Cache the percpu offset in thread_info so percpu accesses can use it
directly across the relevant RISC-V paths.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |  26 ++-
 arch/riscv/include/asm/percpu.h      | 284 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   7 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 include/asm-generic/io.h             |   4 +
 9 files changed, 326 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

