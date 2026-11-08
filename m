Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135942;
	b=y2Le4W0Or8bX4mySROC2sO7sDRJpy8+qw1KcbTDrJuGCjA20eS8Vl+295u/sbdoaBGq6
	 Z3WJAJqLPlNH6mq7eEQPcZSHv5OaLmhiNqsncvpSCFawH0FtVYwtg+N6Qh0Rp6KGRaDKr
	 xyUkVyRgkiGJc65wMwSHh1n6ZSNY53UIBPUwlNf/rOtLzk7ofCu4XvpP1WcqT4t5pW6c4
	 /+vb4Pd6VyiSDK0h2KyJ14UpKipAO1s0PtCDX9jYlM9MgMPv+ciTzn5DW/ewhktFkt3JE
	 svRj7oJqN71hSZMHX6JrVxmWRditOEh7bRAW37mNBTUbtjFltq+PYQrbW/sCMKcksEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=moiGcSV9g6fEFglU5jjTd2VsTAmD/aUVb3CUOrfKCF0=;
	b=FbGnyABuFu9OU8Ckd232wOCUBVe8LR2Erq1G8fr2YWvNYILQu6sMB5K22WZVywR7uQt7
	 FE33kHDRSYTB3d4+Grep86RpdFg/mVocx1lAzuHGzsH6pHl9NFcON64+/VuM81XYBAPfi
	 SEl9ZE82FAYMqnzKVagucijDsfGN2rb7S+BfjqSNFVRF15QiZNYbKImROKI2GGX6g7XFx
	 Rgz92XOa8TZfWJxeksv37GeU6zpBxfXOZVxLBt7PSsZWC0Gl9/q/XMTVje1xAHhe020/+
	 i2USs1exvA9+L8GNGHwX1rd/3BZDuPhTGwOy3kPBNfApFBR8LDraP5kt6YZOzgaYHog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZWbJMoeP;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F931606A321
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 11:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F931606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ZWbJMoeP
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso12439a91.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794135941; x=1794740741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=moiGcSV9g6fEFglU5jjTd2VsTAmD/aUVb3CUOrfKCF0=;
        b=ZWbJMoeP8ogmGUR/5kPE1A8dncneDCEgt6H2HY95exqVJWpKDCJ4xJ0/Yv5PV9x54j
         yPhKOp4e9Vt+5oYVid3eE9VVf0shBy7pSEoEVvMrkZ3QJ2GAZaVutry29aBTTQ8KCLxe
         94wsY68MsqpoLKd4ftPQlUo/T1VKmRpv/irkX1SjRkM2Q14jk7ljjp8X/VtHQjm5E7AK
         v9HxLEypuDXUC4xB8Qr88INcSLtBCUSvdMaVVzvsYbQ0zgr1UNijrzeO2t9bm3WmL9xS
         KGxknbpDFsQ1d6ar+EqAjjkDuWp4i76Qtd6Vfqmr9FS8lvwsxpIL+wau0Je0157QOssU
         Yv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135941; x=1794740741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=moiGcSV9g6fEFglU5jjTd2VsTAmD/aUVb3CUOrfKCF0=;
        b=DCI8LlyaypDCtIaA/tpp1Z3rPop5UMqphhuUmFG8t0HdtKAmPVGSi0+dei/yQHkgk7
         +CxKHpCf5/Oyys4TwWXdIb9AmkOjCkf6a5TdLWyZJbjMp0gQuUPfWgJybEC3yim4nLFy
         7MFg6/hJsOjDbFxQwF++N94Zcsd1bcIk3tGECAfcIu77RyJZwksGKt6buDPlHf9nuuw/
         pUb4LmdctIewrr0cWUH3ve8RHPX3PuYP2V/cS6JygWv5OKLgFFQlVAD0jtlaGepp27oy
         v9tlzJtqG6mbWkyygZ/0mcC6YlOCwaDGav6P05dDmprSPVCI+0pqMJZpYW6DUsXrCp+L
         35sg==
X-Forwarded-Encrypted: i=1; AL+hErHEW1q54K2oWiStf9jXjTU5sccUw+Ep0A6YmWZTG4fiFjXKp7r00u4i1fhLihX36aP2pLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8wOTzH4WmBzr53bPHrQRFUxsbddtpTWJKZoWJ2HbRSJGUd+Ma
	6o8I052zhFDHXNFMuQphWKMyToyKVlRmqYdoVBbTx0V8tdctzqTU1H61/CDIVdvg3dk=
X-Gm-Gg: AYBFou1DjMKJgWqwcrqPAGn9CB/KaFHD8EdJBFYgobkEz4SM1QhHlLfNpuBAak33D55
	v3RPLGPiy1in/l7kZHfYujwxtnCK0LDHtKcO6YQGF+xuLB5KQI+GqZAZXMMAlT960JlCOha3giI
	LJQHbqtkSm3LIx5AqlV6pdCbpVFS7YIFcwcL5xSTlyuoTv5E0HCOCKSD+y/GXZDwASmZGFCKmN/
	HdSZpzmu+2vNnJ/8CY9SMpAh6SHCNF7EQhlAmvUFEvGjZtPeFXAva22HN41jzKlOINZx4j+Xtb7
	1rS8HMx4UEbRFx+6NVaFMeyjIgDXG/Wyd9KuekMQ41SjarB5p9I/uEzVHzy6ogLJGfHx7a18jKO
	AtU95H0YJtH5mZyZtHMei/ZonufJd0Ka5iiRJb9eNfu+RY8kc8iMNGpP9M+f3/2OPL4/l/KKKfT
	imLZK4jH1Jtns2TL5RGIbVnLKY7WS+Xw9Q/ox+q/upyqSu1beAyoira85fhbhTz/wng0GRgiO1X
	xhlLGiWh8sAto1NJzr800TQ+CJ/xgtz3I7Mv0r4eNEYre6oq//oKrSgj6vYy5tamZTyhNDkJPBD
	3+3nGwQJOxHQ8gdUBAxh7p2AOI5AmRQgvSsPlSgrlff1COh+KbRpn6UueEUnEZs=
X-Received: by 2002:a17:90a:e7c9:b0:39e:4c7f:7308 with SMTP id 98e67ed59e1d1-3b12d37ecffmr886982a91.31.1794135940233;
        Sun, 08 Nov 2026 03:05:40 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2609818a91.6.2026.11.08.03.05.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:05:36 -0800 (PST)
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
	llvm@lists.linux.dev,
	dave@stgolabs.net,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	broonie@kernel.org,
	cuiyunhui@bytedance.com
Subject: [PATCH v9 2/3] riscv: store percpu offset into thread_info
Date: Sun,  8 Nov 2026 19:04:05 +0800
Message-Id: <20261108110406.97495-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261108110406.97495-1-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V currently derives the current per-CPU offset from the CPU number
and __per_cpu_offset[]. Cache it in thread_info so per-CPU accesses can
load the offset directly.

Initialize the cached offset for the boot and secondary CPUs, and
propagate it across context switches. Set it before each secondary CPU
startup, including parallel bringup and CPU hotplug.

Link: https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113437553?page=2
Link: https://lore.kernel.org/r/20260826012457.ig3rfmji7vywf6kc@offworld
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h         |  6 +-----
 arch/riscv/include/asm/percpu.h      |  5 +++++
 arch/riscv/include/asm/switch_to.h   |  9 +++++++++
 arch/riscv/include/asm/thread_info.h |  3 ++-
 arch/riscv/kernel/asm-offsets.c      |  2 +-
 arch/riscv/kernel/smpboot.c          | 10 +++++++++-
 arch/riscv/net/bpf_jit_comp64.c      |  9 +--------
 7 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index b8bf842d4c136..06ac38f733b0a 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -92,11 +92,7 @@
 
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
index 280b122b9fe69..2a3ddc3538869 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -9,9 +9,12 @@
 #include <asm/alternative-macros.h>
 #include <asm/cmpxchg.h>
 #include <asm/cpufeature-macros.h>
+#include <asm/current.h>
 #include <asm/hwcap.h>
 #include <asm/irqflags.h>
 
+#include <linux/thread_info.h>
+
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
 {									\
@@ -557,6 +560,8 @@ static inline u128 __percpu_generic_cmpxchg128(void *ptr, u128 old_val,
 })
 #endif
 
+#define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef PERCPU_8_16_GET_SHIFT
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 123c89b694e87..b4a4d4a44f25d 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -89,6 +89,14 @@ static inline void __switch_to_envcfg(struct task_struct *next)
 			:: "r" (next->thread.envcfg) : "memory");
 }
 
+static inline void __switch_to_pcpu_offset(struct task_struct *prev,
+					   struct task_struct *next)
+{
+#ifdef CONFIG_SMP
+	next->thread_info.pcpu_offset = prev->thread_info.pcpu_offset;
+#endif
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -125,6 +133,7 @@ do {							\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
+	__switch_to_pcpu_offset(__prev, __next);		\
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
index a75f0cfea1e9f..f4f7ee976cd94 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_SUM, task_struct, thread.sum);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
+	OFFSET(TASK_TI_PCPU_OFFSET, task_struct, thread_info.pcpu_offset);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
@@ -50,7 +51,6 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
 #endif
 
-	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 #ifdef CONFIG_RISCV_USER_CFI
 	OFFSET(TASK_TI_CFI_STATE, task_struct, thread_info.user_cfi_state);
 	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a9de2dae804c6..6431914d21165 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -175,6 +175,10 @@ void __init setup_smp(void)
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
+	/* The idle task is reused across CPU hotplug. */
+	tidle->thread_info.cpu = cpu;
+	tidle->thread_info.pcpu_offset = per_cpu_offset(cpu);
+
 	if (cpu_ops->cpu_start)
 		return cpu_ops->cpu_start(cpu, tidle);
 
@@ -190,7 +194,6 @@ int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle)
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
-	tidle->thread_info.cpu = cpu;
 
 	ret = start_secondary_cpu(cpu, tidle);
 	if (!ret) {
@@ -208,6 +211,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
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
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 371405598faa7..fa6ce5613c4d6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1466,15 +1466,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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

