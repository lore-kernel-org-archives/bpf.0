Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B59377579
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879724; cv=none; b=QY2BH77ODgtq/VwTqfBEVEXDZ9bYtJ3xXvQRiJtCh2ekumWywcx7ZXU7DVikin/GgHSFLNGkNuOBcGV5ymWGfaXLuk8AvMLGOXm/QurfT1JS3Yk2zcQuxDbh/xHNpSruEdAU4pxls/3HgwzzrURca0Szk6WNMjwOCI/vBhvdonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879724; c=relaxed/simple;
	bh=5TasJ4FtvEaS/hg42aczF+7edOd1X9xZB26FyE2cqxY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RV5Tcjv/kvX+3QF2qQYuIesbc5jDFg00CW1eSkriuWafwu6xd4XWOFPSfN8UtKw8YnjYnlKPbne3ElaDhDDknuC+D/i5uYklHWFEw0ipphPnvJgMV76C0wNTozkXBShQDNq85dfN78XQq6PU64OhFdpARwG2uLagUjTQ3zOuX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XboNNGZ4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XboNNGZ4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso1431805ad.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782879719; x=1783484519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9bF4nwkw8I9o5/dk7AxDL3xS1dNrudcJthGETtRQoU=;
        b=XboNNGZ45Jm2e/aXpYJ8+ML9CpW3zTabtRUKZxjJJplbpLoFGC2lFOzby80Z/yspkq
         8LnqNphlnwJ3LHSkHsCuYDbZiImhtiTE9KyR8SSszuf3hm3xUvP22z7G5BY+itn76nV5
         rFqERdrFvBZPYCFZdgv2xBnCtw4ZQXwGkjsALWSZ89aI5blt0M1SI4SxRsew/pVWFqBM
         zxzF9X/eUVqa9MSxq1JxRx6dANTJ1Ku6tCl7qJa4FHaAUGoUTGK5bNmtqyWNLKwCBk8N
         8xDvf5P/gXxhZV3durjq0g9RLOJKS/UbpYNlOzs40s/EhBs/cGvwgM9YjhkbbZL9oi8s
         AOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879719; x=1783484519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9bF4nwkw8I9o5/dk7AxDL3xS1dNrudcJthGETtRQoU=;
        b=UFGvqSjwPxk/IZUxzu3GP4cLmJmK+VZHNSQSHeoUUFLIzXEu2cO6Acl4c/lv54zqUD
         /6ay5Lir3XtSpcdOuK51Tp1OIHdRXsuQD8CFx5u/ba3cm398t7JVQpJYM8x/tRwnWhMN
         t2mtU4uQ+UFLhp8gdxP5rOwRtS2KM/4xWZ1JQp3jRbm188FjA+ED8r0TyDE4o0U7KSDD
         dBebcu9PeXV80++ffsc8N8KU5woao42i8ZfPLTigvehr3Wf/9MwU+w38eXh3Z4Ii6WSZ
         GY98GfjVsrQlvFlVQFSusw30yAEB1UolkhNWuHMtqHk29zVuOWfSSCg09w/Wb0aJ9pLt
         c2Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpF9w8/zKgu9AsfG6ULwlHcmLCVtYLS21Mjt2wsoAVhVWwB5wkgcibb7xZyBiZxTb2YAgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGD7huByJL/a3AzA+BYW05fdtm5lcaoZxyLzT1cc1VLA32SErP
	3pqZ8ZyLd/c7QM04/+coJivh2qQV66sMtTySZFLlqhtHsf1lCfQjgDzNsy5vqxlr3Cw=
X-Gm-Gg: AfdE7cn0TjIRxwalZ5LVlrhRjWKanto5+kiFVS8GeUte5X5JCrrPVtlwdIExd62i3cQ
	2lbCcIiT5XcKZGosxmPJtBW4Dk0YPmVsBmGD+EKLRDQJSwklR7R5AnOlYrhhfG/Omrf55fPGmG4
	a2NtOFZtNlO9nNu6THSO4KWOnChH/HY1NZ5a1mLqVbrWCUZAMm87B0SpenOnoz2nv3Erz+gjHd1
	M7j97Qqy4Ze0ubm9VnuaisxYZfARJWn4tyhbTc3W72xuU5HFEbgjrjtBZdjz8oZqs8vCQQnv/YS
	fdzQXxq06SxvHcVnm2RT4k2vf49gPx6Ie7jzBjhlwP8gcnvqg0xwDDl6FaScyF1CxJqi9ppCPch
	FF2IbWaa4wNS1ERiQ7afEYGMa0xtSLvLkJDn73ln/Zbby0xAnFnoSx/flOKphxrzI+/JiYnTvP9
	B8FcypQuCI1S1ZBczCuOjd1U1HGRa52RelBFZBIRgqrd5QPdgRSzS/6r3L
X-Received: by 2002:a17:902:e550:b0:2ca:320:f74b with SMTP id d9443c01a7336-2ca7e6b7beemr1619545ad.21.1782879719331;
        Tue, 30 Jun 2026 21:21:59 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c73a9csm24450865ad.21.2026.06.30.21.21.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:21:58 -0700 (PDT)
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
Subject: [PATCH v5 3/3] riscv: store percpu offset into thread_info
Date: Wed,  1 Jul 2026 12:20:41 +0800
Message-Id: <9146018e3348234ea5c10b245aa5531f172d0f6a.1782877663.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1782877663.git.cuiyunhui@bytedance.com>
References: <cover.1782877663.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V percpu addressing currently derives the base offset from the CPU
number and __per_cpu_offset[]. Cache the current CPU percpu offset in
thread_info so percpu accesses can load it directly.

Keep the cached value up to date for the boot CPU, context switches and
secondary CPU bringup. Initialize secondary idle tasks before they start
running so early percpu accesses use the secondary CPU offset rather than
inheriting the boot CPU value.

Link: https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113437553?page=2
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h         | 6 +-----
 arch/riscv/include/asm/percpu.h      | 4 ++++
 arch/riscv/include/asm/switch_to.h   | 8 ++++++++
 arch/riscv/include/asm/thread_info.h | 3 ++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/smpboot.c          | 8 ++++++++
 arch/riscv/net/bpf_jit_comp64.c      | 9 +--------
 7 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index e9e8ba83e632f..137a49488325e 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,11 +91,7 @@
 
 #ifdef CONFIG_SMP
 .macro asm_per_cpu dst sym tmp
-	lw    \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, RISCV_LGPTR
-	la    \dst, __per_cpu_offset
-	add   \dst, \dst, \tmp
-	REG_L \tmp, 0(\dst)
+	REG_L \tmp, TASK_TI_PCPU_OFFSET(tp)
 	la    \dst, \sym
 	add   \dst, \dst, \tmp
 .endm
diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 46f1901d3bb88..dad975b55d0c3 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -8,7 +8,9 @@
 
 #include <asm/alternative-macros.h>
 #include <asm/cpufeature-macros.h>
+#include <asm/current.h>
 #include <asm/hwcap.h>
+#include <asm/thread_info.h>
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -278,6 +280,8 @@ _pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
 })
 #endif
 
+#define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920c..733b6cd306e40 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -88,6 +88,13 @@ static inline void __switch_to_envcfg(struct task_struct *next)
 			:: "r" (next->thread.envcfg) : "memory");
 }
 
+static inline void __switch_to_pcpu_offset(struct task_struct *next)
+{
+#ifdef CONFIG_SMP
+	next->thread_info.pcpu_offset = __my_cpu_offset;
+#endif
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -122,6 +129,7 @@ do {							\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
+	__switch_to_pcpu_offset(__next);		\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 55019fdfa9eca..f10ba62b61016 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -53,6 +53,7 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			cpu;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -60,8 +61,8 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned long		pcpu_offset;
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a75f0cfea1e9f..20d46c28fdde9 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_SUM, task_struct, thread.sum);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
+	OFFSET(TASK_TI_PCPU_OFFSET, task_struct, thread_info.pcpu_offset);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f6ef57930b50a..7876854d16279 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -191,6 +191,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
 	tidle->thread_info.cpu = cpu;
+	tidle->thread_info.pcpu_offset = per_cpu_offset(cpu);
 
 	ret = start_secondary_cpu(cpu, tidle);
 	if (!ret) {
@@ -208,6 +209,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 }
 #endif
 
+void __init smp_prepare_boot_cpu(void)
+{
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+}
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
@@ -233,6 +239,8 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+
 #ifdef CONFIG_HOTPLUG_PARALLEL
 	cpuhp_ap_sync_alive();
 #endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c03c1de16b79a..eab93d5258e9e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1395,15 +1395,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			if (rd != rs)
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
-			/* Load current CPU number in T1 */
-			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_ld(RV_REG_T1, offsetof(struct thread_info, pcpu_offset),
 				RV_REG_TP, ctx);
-			/* Load address of __per_cpu_offset array in T2 */
-			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-			/* Get address of __per_cpu_offset[cpu] in T1 */
-			emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
-			/* Load __per_cpu_offset[cpu] in T1 */
-			emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
 			/* Add the offset to Rd */
 			emit_add(rd, rd, RV_REG_T1, ctx);
 #endif
-- 
2.39.5

