Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884F442B2F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386994; cv=none; b=RexzQ43HiqnlRdbpc1qTdX+5vjWcG4mu+hBsGZp1SPm/pl+S5WVMF7WR3sCXcwv83H0CTjAHLX3ElEKhAFQ5A6QCDQQhzRzMHwdUnfw50nXQ7tLmqGJPrmudQIVbyOCcaGhYRqyZEj37SzmL81kcra4whwQWlzgde3XVzLJQy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386994; c=relaxed/simple;
	bh=ET3d2dn8RoQYW9nZ6+dhkdZsWN6D3bvRnc5MAY8T+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba8TQR77vO5irgBtX6USY+AmKVpHXVX2UtG2d+gSZKZXk0p4ZI80fYktsPYu4soKTxH8heFC04XcVajOUHbGD5dIohsadxw9NXbaDzN8WYO0tIG1qzAyyqVH6G5/anHR/zTrLpuDsCxpvLL0Vk/eqtkqB501lWruQXA3FjxEuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caPDihUA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caPDihUA"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-853f8c34ba4so4253584b3a.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 04:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386992; x=1789991792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cZnP6MDZU5vZQxpJOfJKbElTvy88Q385dtzTC3MYtw=;
        b=caPDihUArpD/nF+7f1YrvOK3j1U0yCHR3EGAfy6mWiUqe3M5GWIiXmu930sDBFpsZ5
         WkBqDpxnNkVMMt+sEb52biZ15gQwjC19/0PVHdyLe5StvqS1qIoYTr7ql3OKQHjZSuBh
         yx8EvqF80syAqJAekncrZadEZLBh3HAj9YV++Xxtif39IBMpuDf8ds3Tg6NfQWFojHho
         wu94pjPJbLmRQ076N96bYjL99jXRh0GSprWuHQ/g0NIyx4jnYIMj7qM0Ov2ffoc5fnd8
         CP/rf43DcbA0cUJsOunfQxXQH0Cjq566JK/g2AP/GgkAY4MRdnxpPwMV5ZliqCfGSbNl
         BObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386992; x=1789991792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cZnP6MDZU5vZQxpJOfJKbElTvy88Q385dtzTC3MYtw=;
        b=AuHt5h5RyI6NkA9l83SQenr8/XTnYgXBTu9oBhpLSAbpo097uOvVsjL8+PcfkOu4yh
         Al/qwA8lvvHBUoWm/1LX8rQGnBDMo3HQHEAeSajzz7XbarLLH5Oi5J9dtYY9W0WAlDZh
         gYrjUu/EIY1pxiNIxs82HoKuakS9l9Dn8hEidbeX8XbZirSKLQrxofwinWqqOnPuBis1
         +7u0zmq6EKFov8tNCpRY+iSctH2o1awEyP47ai8O3JzkT2vowN7Yrxu+it6nQWdm6W1a
         vampSF+zZ/hKUnEIVTXHyYbdQsIfnl6JR+Ml4kqLB80hzMWo3GNtL0Ahmlmgb1rl/yPb
         bcow==
X-Forwarded-Encrypted: i=1; AKwUvBzAg+pQNqtlTVu5XJ5oNcnTCIEVe5DXlh4JW3ovIZKAqm1xzDpA3q1JAUSeDfDJOrD+KCU=@vger.kernel.org
X-Gm-Message-State: AFuF++mUf5XEMdCfDNrpFpsAiJjQ/21eXko4VeqVcBRv3F+I5WtuWbJn
	n3mha2YeKjuGPMabWNgi9Oemusc/P75y2yxPS8HLndG4yDhqawky6QVu
X-Gm-Gg: AYBFou0wWWhB6bKb95yhsrfxNVxds0wHHJqfIhF2B7qsuietnUyi7ir3CKRMwBWdRD1
	JGnNT4OnzAIdpIwwPTunGMRpOHjm3karnvLbT8AxBptj37I4KIH89UIKJYwHOjLMqD2oYMlfrcc
	C+i0C9vHZsh3VkLWejbzzmO+qH/y/bqK6DPYmY2ZNpiXboAcPQ9ufhgVbGSsitMox+ipuMqnJN9
	JbCzambrdL7ZF3mlPkU7EMwh69Hh50X80LMF0ClzKCQnFaPJ3qra94Fx/EP68GiADcgcpgLmE4r
	VRLYARei06gRIEPPi7bo3nqoJP53JE6Ps6hVqGQ1OFIyC8YFfvVCviB/3VlV1Kvuqx0k307flkt
	dms7qe7eylIVUuG8ZCmAk67BhDWqCcuQbW4kJnrLPnvvnZxuHmLiS3yG0xzt3GRjlK7KbDqW+o2
	sOYjB7PKXJBEGuSuxMeo2DoPNvUMaMEZLNeTffdW/8o2EsN19XFkHS5ALK0KohzT386Dkd+lGlB
	4eF6/kOsxsRPjDisN0CURG66OmLNNNvbm4KfFYdkqZuK6nkoeMacmHHjFIKf1E=
X-Received: by 2002:a05:6a00:44c8:b0:857:726d:270c with SMTP id d2e1a72fcca58-86f866b8c0fmr5070563b3a.24.1789386992211;
        Mon, 14 Sep 2026 04:56:32 -0700 (PDT)
Received: from 56e-726.realtek.com.tw (61-219-240-249.hinet-ip.hinet.net. [61.219.240.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86cc50c786bsm2729281b3a.41.2026.09.14.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:56:31 -0700 (PDT)
From: Wei-Jie Hung <imbigking12@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Mike Rapoport <rppt@kernel.org>,
	Xiaofeng Yuan <xiaofengmian@163.com>,
	Klara Modin <klara@kasm.eu>,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei-Jie Hung <imbigking12@gmail.com>
Subject: [PATCH] riscv: patch: fix handling of bpf-jit execmem addresses
Date: Mon, 14 Sep 2026 19:56:07 +0800
Message-ID: <20260914115607.350097-1-imbigking12@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8718e5a3090b ("riscv: patch: skip fixmap mapping when kernel text
is already writable") gated the core_kernel_text() branch of patch_map()
on CONFIG_STRICT_KERNEL_RWX, and explicitly left the vmalloc branch
unchanged. That branch has a separate problem.

That branch only creates a temporary writable fixmap alias when
CONFIG_STRICT_MODULE_RWX is enabled, and otherwise assumes the target is
directly writable and returns the address unchanged. That assumption no
longer holds: bpf_prog_pack_alloc calls set_memory_rox() on every pack
unconditionally in alloc_new_pack(), independently of any
CONFIG_STRICT_*_RWX option, so BPF text in the vmalloc area is read-only
regardless of what CONFIG_STRICT_MODULE_RWX says.

With CONFIG_STRICT_MODULE_RWX=n, patch_map() returns the read-only
address directly, the subsequent copy_to_kernel_nofault() takes a
page fault and returns -EFAULT. bpf_arch_text_copy() turns that into
-EINVAL, which propagates through bpf_jit_binary_pack_finalize() to the
WARN_ON() in bpf_int_jit_compile() and leaves the program un-JITed.

Note that BPF cannot be fixed the way kprobes was in
commit bdc46e507b59 ("riscv: mm: make EXECMEM_KPROBES writable without
CONFIG_STRICT_MODULE_RWX"). EXECMEM_BPF is already PAGE_KERNEL, i.e.
writable at allocation time; the read-only mapping is established
afterwards by generic code in alloc_new_pack(), which arch code cannot
influence. The only place this can be handled is patch_map().

This is the same problem that was fixed on arm64 by commit b1480ed230ac
("arm64: patching: fix handling of execmem addresses"), and the fix is
the same: CONFIG_EXECMEM is what actually tracks whether the vmalloc
area can hold executable memory that needs a temporary alias to be
written. CONFIG_BPF_JIT, CONFIG_KPROBES and CONFIG_MODULES all select
it.

Note that this is not limited to CONFIG_MODULES=n. Unlike arm64, riscv
selects CONFIG_ARCH_OPTIONAL_KERNEL_RWX, so CONFIG_STRICT_MODULE_RWX can
be disabled with CONFIG_MODULES=y as well, and the bug is reachable in
that configuration too.

The !CONFIG_MMU build is unaffected: it has its own __patch_insn_set()
and __patch_insn_write() implementations and never calls patch_map().

Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
Signed-off-by: Wei-Jie Hung <imbigking12@gmail.com>
---
Based on riscv/fixes (b94cec5761d2).

Reproduced on qemu-system-riscv64 -M virt with CONFIG_BPF_JIT=y,
CONFIG_BPF_JIT_ALWAYS_ON=y and CONFIG_STRICT_MODULE_RWX=n. 
ptp_classifier_init() builds a cBPF filter from sock_init(), 
so the failure happens during boot without any userspace involved:

  WARNING: arch/riscv/net/bpf_jit_core.c:156 at bpf_int_jit_compile+0x3dc/0x43e
  Call Trace:
   bpf_int_jit_compile+0x3dc/0x43e
   __bpf_prog_select_runtime+0xec/0x186
   bpf_prog_select_runtime+0x12/0x1a
   bpf_prepare_filter+0x368/0x46a
   bpf_prog_create+0x66/0x90
   ptp_classifier_init+0x3e/0x60
   sock_init+0xc4/0xe6
   do_one_initcall+0x78/0x14a

  kernel BUG at net/core/ptp_classifier.c:227!
  Kernel panic - not syncing: Fatal exception in interrupt

The BUG_ON() is reached because CONFIG_BPF_JIT_ALWAYS_ON=y turns the
silent interpreter fallback into -ENOTSUPP. With
CONFIG_BPF_JIT_ALWAYS_ON=n the failure is silent: writing 1 to
/proc/sys/net/core/bpf_jit_enable and loading any program reproduces the
same warning, but the program simply falls back to the interpreter and
the kernel keeps running.

Tested with CONFIG_BPF_JIT=y:
  - CONFIG_MODULES=n, CONFIG_BPF_JIT_ALWAYS_ON=y:
    panics before this patch, boots after
  - CONFIG_MODULES=y, CONFIG_STRICT_MODULE_RWX=n,
    CONFIG_BPF_JIT_ALWAYS_ON=y: same panic before this patch, boots after
  - CONFIG_BPF_JIT_ALWAYS_ON=n: the warning above is emitted when a
    program is loaded from userspace before this patch, and gone after
  - riscv defconfig (CONFIG_STRICT_MODULE_RWX=y): unaffected, boots
    before and after
  - kprobes (kretprobe on __riscv_sys_openat via kprobe_events):
    works before and after this patch

 arch/riscv/kernel/patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 2239c28981bc..2b5adf01c550 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -48,7 +48,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 		if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
 			return addr;
 		phys = __pa_symbol(addr);
-	} else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {
+	} else if (IS_ENABLED(CONFIG_EXECMEM)) {
 		struct page *page = vmalloc_to_page(addr);
 
 		BUG_ON(!page);
-- 
2.43.0

