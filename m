Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786665;
	b=yIpVtUwlaN/qmrtudPoZwRgojyEksYrORHcPTLvSsFzCe2Z2PfnZ7SLAPjoDzrr/z5yG
	 X5zjcduOjv9K0cnyFOw9uxavS9G5AkODJlVRZ60fTU/L0VAtdro+uYxJiN4su+a155/03
	 cnsS4Zxt3h1p9jsWOvyP2YmjZqSBko4gR5g22W2eUwSXK90X0VNRu2frf/C/T6ye7AH/c
	 dH061XrgHebSdXg+qgj0psoSGD94yDAHwbZfGaNgAM9Q3qzNXX+JnJfG8XRQVLFkHGvsF
	 fa1xnFS87o6e9ko8UfAVk92OmoY8osa9AGuWv/y36AAAR0qCbKGo0GCx85/FF/mUAgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786665;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=El+HFS5rExaXpXDIDYVfuWdl9JJQDwNWbfTECGFZBOs=;
	b=SHtHowrlguVCX9G3XsZfYC+Fv2MhOSgxVmvAAfuOeRsHvRyk8VQ9fu09H9GM+NpBWNal
	 9FgXBYBBhY+DcOL16NiWI8fguf0YVKeOusnQ+J5uicBOZaV9+IzGQwSUBd/Fbt18w2Dpw
	 PdmJ6XbhgHDxeWSCu852uxuYrCoAnnM2MlQQXxTQ98bChbIc21uoK4V6lW/SCTWs9KDLz
	 f3GqSRhSE58i68Nioy4xWUGZYqRu7O3k3tRoPeMMC3mS2khKEyNhzX69a/GITaA4bjN5n
	 0YjyTytXXlEMUsX7g4SwxYSB9aXTwLPuR1Y9AVvEy+X70N9V1CdSr5OQW0eKZPmZU1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="l4/ma7aY";
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C51606A32C;
	Wed,  4 Nov 2026 10:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C51606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l4/ma7aY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793786661; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=El+HFS5rExaXpXDIDYVfuWdl9JJQDwNWbfTECGFZBOs=;
	b=l4/ma7aYC7tNQ3Iy2BZS1YEWGvMRa/bTP9hmVOfvHReEpUbwXpdrYJEUgz6PcEpoqVDAJR7JGH0y3JM3vAaJ8e4NKuqvBjK7nFQTch+KEf4FQttRl0Mu4Gurn7hJOw3qSFm5P9oQFEAlMKdZarkFdKrxvSMJlDzvMLim6T4z2w8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XE5SaZX_1793786658;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE5SaZX_1793786658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 18:04:19 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	shuah@kernel.org,
	rgbi3307@gmail.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/3] riscv: bpf: Add BPF private stack support
Date: Wed,  4 Nov 2026 18:04:09 +0800
Message-ID: <20261104100411.997-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104100411.997-1-cp0613@linux.alibaba.com>
References: <20261104100411.997-1-cp0613@linux.alibaba.com>
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

A program on a private stack keeps its BPF frames in a per-CPU area of
its own rather than on the kernel stack of whichever context entered it.
bpf_enable_priv_stack() grants that mode only once the JIT reports
bpf_jit_supports_private_stack(), which riscv64 did not: programs there
always ran on the kernel stack, and a struct_ops program that requires
one was rejected with -EACCES.

Allocate a per-CPU area of the verifier calculated depth plus a 16 byte
guard region at each end, and point BPF_REG_FP (S5) at the top of it
while leaving SP on the kernel stack. Every BPF stack access already
goes through S5, and S5 is callee-saved with each subprog deriving its
own, so nothing else in the JIT has to know about the private stack.

The outgoing stack argument area stays in the kernel frame: callers
write it relative to SP, callees relative to RV_REG_FP, which the
prologue sets to the caller's SP.

The per-CPU lookup is emitted after the tail call entry point: a program
using a private stack can still be entered as a tail call target, and
RV_TAILCALL_OFFSET is a constant added to the target's bpf_func, so what
is in front of it must be the same size in every program.

The base is materialized with absolute moves, as on arm64, x86-64 and
powerpc64: the vmalloc'd per-CPU area is beyond an auipc pair from the
JIT region, and riscv64 has no register holding the per-CPU offset, so
the address of __per_cpu_offset is loaded too. emit_imm() is a choice
there, not a requirement; emit_addr() as used by
insn_is_mov_percpu_addr() would need an extra_pass argument and an error
return in bpf_jit_build_prologue(), touching bpf_jit_comp32.c too. Both
constants are fixed before the offset convergence loop, so the prologue
length is stable across passes.

The guard value follows arm64, x86-64 and powerpc64, and the 16 byte
two-copy region at each end follows arm64 and powerpc64, since x86-64
uses an 8 byte guard with a single copy. A jited program has them
checked when it is freed, reporting the first corrupted CPU only;
failure paths release the area unchecked since the image never ran,
which also clears priv_stack_ptr for the later bpf_jit_free().

RV32 does not declare support and keeps the existing kernel stack
behaviour.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 arch/riscv/net/bpf_jit.h        |  1 +
 arch/riscv/net/bpf_jit_comp64.c | 42 +++++++++++++++--
 arch/riscv/net/bpf_jit_core.c   | 84 +++++++++++++++++++++++++++++----
 3 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 21a190a6a6d9..efab2b6803e4 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -14,6 +14,7 @@
 
 #define RV_MAX_REG_ARGS		8
 #define RV_EXTRA_STK_ARGS	(RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS)
+#define PRIV_STACK_GUARD_SZ	16
 
 /* verify runtime detection extension status */
 #define rv_ext_enabled(ext) \
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 371405598faa..a7a7d2f9da85 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2134,12 +2134,34 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	return 0;
 }
 
+static void emit_priv_stack_frame(struct rv_jit_context *ctx)
+{
+	u64 fp = (__force u64)ctx->prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+
+	fp += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
+	emit_imm(RV_REG_S5, fp, ctx);
+#ifdef CONFIG_SMP
+	emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu), RV_REG_TP, ctx);
+	emit_imm(RV_REG_T2, (u64)__per_cpu_offset, ctx);
+	emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
+	emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
+	emit_add(RV_REG_S5, RV_REG_S5, RV_REG_T1, ctx);
+#endif
+}
+
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 {
+	bool priv_stack = ctx->prog->aux->priv_stack_ptr;
 	int i, stack_adjust = 0, store_offset, bpf_stack_adjust = ctx->stack_arg_sz;
 
-	bpf_stack_adjust += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
-	if (bpf_stack_adjust)
+	/*
+	 * With a private stack only the outgoing stack argument area is left in
+	 * this frame. It has to stay: the caller writes it relative to SP while
+	 * the callee reads it relative to RV_REG_FP, the caller's SP set below.
+	 */
+	if (!priv_stack)
+		bpf_stack_adjust += round_up(ctx->prog->aux->stack_depth, STACK_ALIGN);
+	if (bpf_stack_adjust || priv_stack)
 		mark_fp(ctx);
 
 	if (seen_reg(RV_REG_RA, ctx))
@@ -2217,7 +2239,16 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
 
 	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
 
-	if (bpf_stack_adjust)
+	/*
+	 * Point BPF_REG_FP at the top of this CPU's private stack. A program
+	 * with one can still be entered as a tail call target, at
+	 * RV_TAILCALL_OFFSET, so this has to come after that entry point; the
+	 * offset is a constant added to the target's bpf_func, so everything in
+	 * front of it must also be the same size in every program.
+	 */
+	if (priv_stack)
+		emit_priv_stack_frame(ctx);
+	else if (bpf_stack_adjust)
 		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
 
 	ctx->stack_size = stack_adjust;
@@ -2320,3 +2351,8 @@ bool bpf_jit_supports_hmul(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index f2497ec7d378..f2021088e447 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -9,6 +9,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
+#include <linux/percpu.h>
 #include <asm/text-patching.h>
 #include <asm/cfi.h>
 #include "bpf_jit.h"
@@ -44,6 +45,62 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
 
+#define PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+
+static u32 priv_stack_size(struct bpf_prog *prog)
+{
+	return round_up(prog->aux->stack_depth, STACK_ALIGN) +
+	       2 * PRIV_STACK_GUARD_SZ;
+}
+
+static int alloc_priv_stack(struct bpf_prog *prog)
+{
+	u32 size = priv_stack_size(prog);
+	u32 end = (size - PRIV_STACK_GUARD_SZ) / sizeof(u64);
+	void __percpu *ptr;
+	int cpu, i;
+
+	ptr = __alloc_percpu_gfp(size, STACK_ALIGN, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		u64 *stack = per_cpu_ptr(ptr, cpu);
+
+		for (i = 0; i < PRIV_STACK_GUARD_SZ / sizeof(u64); i++) {
+			stack[i] = PRIV_STACK_GUARD_VAL;
+			stack[end + i] = PRIV_STACK_GUARD_VAL;
+		}
+	}
+	prog->aux->priv_stack_ptr = ptr;
+	return 0;
+}
+
+static void priv_stack_check_guard(struct bpf_prog *prog)
+{
+	u32 end = (priv_stack_size(prog) - PRIV_STACK_GUARD_SZ) / sizeof(u64);
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		u64 *stack = per_cpu_ptr(prog->aux->priv_stack_ptr, cpu);
+
+		if (stack[0] != PRIV_STACK_GUARD_VAL ||
+		    stack[1] != PRIV_STACK_GUARD_VAL ||
+		    stack[end] != PRIV_STACK_GUARD_VAL ||
+		    stack[end + 1] != PRIV_STACK_GUARD_VAL) {
+			pr_err("bpf-jit: private stack overflow/underflow guard of prog %s corrupted on CPU %d\n",
+			       bpf_jit_get_prog_name(prog), cpu);
+			return;
+		}
+	}
+}
+
+static void free_priv_stack(struct bpf_prog *prog)
+{
+	free_percpu(prog->aux->priv_stack_ptr);
+	prog->aux->priv_stack_ptr = NULL;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
 {
 	unsigned int prog_size = 0, extable_size = 0;
@@ -84,12 +141,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			    round_up((stack_arg_cnt - RV_EXTRA_STK_ARGS) * 8, STACK_ALIGN) : 0;
 
 	ctx->prog = prog;
+	if (prog->aux->jits_use_priv_stack && alloc_priv_stack(prog))
+		goto out_free_hdr;
+
 	ctx->offset = kvzalloc_objs(int, prog->len);
 	if (!ctx->offset)
-		goto out_offset;
+		goto out_free_hdr;
 
 	if (build_body(ctx, extra_pass, NULL))
-		goto out_offset;
+		goto out_free_hdr;
 
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
@@ -104,7 +164,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		ctx->prologue_len = ctx->ninsns;
 
 		if (build_body(ctx, extra_pass, ctx->offset))
-			goto out_offset;
+			goto out_free_hdr;
 
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
@@ -124,7 +184,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 							  bpf_fill_ill_insns,
 							  bpf_prog_was_classic(prog));
 			if (!jit_data->ro_header)
-				goto out_offset;
+				goto out_free_hdr;
 
 			/*
 			 * Use the image(RW) for writing the JITed instructions. But also save
@@ -190,10 +250,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			ctx->offset[i] = ctx->offset[i - 1];
 		ctx->offset[0] = ninsns_rvoff(ctx->prologue_len);
 		bpf_prog_update_insn_ptrs(prog, ctx->offset, jit_data->ro_image);
-out_offset:
-		kvfree(ctx->offset);
-		kfree(jit_data);
-		prog->aux->jit_data = NULL;
+		goto out_free_ctx;
 	}
 
 	return prog;
@@ -209,7 +266,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				   sizeof(jit_data->header->size));
 		bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->header);
 	}
-	goto out_offset;
+	free_priv_stack(prog);
+out_free_ctx:
+	kvfree(ctx->offset);
+	kfree(jit_data);
+	prog->aux->jit_data = NULL;
+	return prog;
 }
 
 u64 bpf_jit_alloc_exec_limit(void)
@@ -261,6 +323,10 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		if (prog->aux->priv_stack_ptr) {
+			priv_stack_check_guard(prog);
+			free_priv_stack(prog);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
 
-- 
2.50.1

