Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1442FFF89
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959098; cv=none; b=tENlpgGDGQKJ0n/G0XAgW7A7hiWDQjtVyd2aM7LvHNtrk4xrHcygRMjmoraIeifmWhNaU8as7Pj2NCYFmHu9elFjFDc2yTHldIoQEpFjU2NmmcFczTyMzCgLRJ8iRrbef7n4h9/BiTtuClskTMXavObl4eJNZ+sJE24xC3jNOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959098; c=relaxed/simple;
	bh=HqN0Z0wlO1/lNbpJc8kqd3Y69XAYwO5765vdX5d0KD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/6ovtgI4kn/STBwI+j28TCQICcUNLIjxibnbugByhUhmjZYTg/EvOqrwiEIT3htwbfU7AAkcYQpgKoa2vZPqsBOho+GApvG9YQbXWMZzLvdtQuXJoqx1EvsqGwKui/hWGQ6v7yFHWKkaQ/g/ZudjE1qsSRZpEJ6js1SD6fd4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0DkN6WV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0DkN6WV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hsez78GQlPZE9UoyJKS7YxAf3c+Kx9Kwlg8NwG1W38=;
	b=m0DkN6WVwTmWVKOuspiA7jNOh+oTQIHsc/LfZ5VYIy4XZ/Qm2k0ZcTforWYRMdjwfMcJXn
	ed1ODfflaYs11J848DNEfmF6mt0Kgn99ufXbRTjYq2eEuneVrfzsXVXGSAih34uqrvn8Jj
	IRwkO4Zr1Bi8hW5iHJavYjN+8yg/RdI=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 07/11] LoongArch: BPF: Support atomics on arena pointers
Date: Thu,  2 Jul 2026 10:23:18 +0800
Message-Id: <20260702022322.51033-8-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Implement atomic operations on arena pointers (BPF_PROBE_ATOMIC): the
read-modify-write ops, atomic_fetch_*, xchg, cmpxchg and
load-acquire/store-release.  For each, the arena base held in REG_ARENA
is folded into the address and an exception table entry is registered on
the access so a fault is handled like the other arena probes.

The exception entry must point at the actual memory-accessing
instruction rather than the last one emitted: the fetch variants append
a zero-extend after the am* op, and cmpxchg accesses memory with the ll
of an ll/sc loop.  Generalise add_exception_handler() to take explicit
fault and resume instruction indices.  A faulting ll resumes past the
whole ll/sc loop: if the ll faults the sc is never reached, and once the
ll succeeds the page is mapped so the sc cannot fault, so a single entry
on the ll suffices.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 182 ++++++++++++++++++++++++++++-------
 1 file changed, 148 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 4a3b632c1fde..a7f2d45aef75 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -441,6 +441,16 @@ static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int stack_off,
 	emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
 }
 
+#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
+#define REG_DONT_CLEAR_MARKER	0
+
+static int add_exception_handler(const struct bpf_insn *insn,
+				 struct jit_ctx *ctx, int dst_reg);
+static int __add_exception_handler(const struct bpf_insn *insn,
+				   struct jit_ctx *ctx, int dst_reg,
+				   int fault_idx, int resume_idx);
+
 static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const u8 t1 = LOONGARCH_GPR_T1;
@@ -452,9 +462,14 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
+	const bool arena = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC;
+	bool zext = false;
+	int ret, ll_idx = 0;
 
 	move_imm(ctx, t1, off, false);
 	emit_insn(ctx, addd, t1, dst, t1);
+	if (arena)
+		emit_insn(ctx, addd, t1, t1, REG_ARENA);
 	move_reg(ctx, t3, src);
 
 	switch (imm) {
@@ -510,7 +525,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amaddb, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_H:
 			if (!cpu_has_lam_bh) {
@@ -518,11 +533,11 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amaddh, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_W:
 			emit_insn(ctx, amaddw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_DW:
 			emit_insn(ctx, amaddd, src, t1, t3);
@@ -534,7 +549,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amandd, src, t1, t3);
 		} else {
 			emit_insn(ctx, amandw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 		}
 		break;
 	case BPF_OR | BPF_FETCH:
@@ -542,7 +557,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amord, src, t1, t3);
 		} else {
 			emit_insn(ctx, amorw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 		}
 		break;
 	case BPF_XOR | BPF_FETCH:
@@ -550,7 +565,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, amxord, src, t1, t3);
 		} else {
 			emit_insn(ctx, amxorw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 		}
 		break;
 	/* src = atomic_xchg(dst + off, src); */
@@ -562,7 +577,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amswapb, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_H:
 			if (!cpu_has_lam_bh) {
@@ -570,11 +585,11 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				return -EINVAL;
 			}
 			emit_insn(ctx, amswaph, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_W:
 			emit_insn(ctx, amswapw, src, t1, t3);
-			emit_zext_32(ctx, src, true);
+			zext = true;
 			break;
 		case BPF_DW:
 			emit_insn(ctx, amswapd, src, t1, t3);
@@ -585,12 +600,14 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_CMPXCHG:
 		move_reg(ctx, t2, r0);
 		if (isdw) {
+			ll_idx = ctx->idx;
 			emit_insn(ctx, lld, r0, t1, 0);
 			emit_insn(ctx, bne, t2, r0, 4);
 			move_reg(ctx, t3, src);
 			emit_insn(ctx, scd, t3, t1, 0);
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
 		} else {
+			ll_idx = ctx->idx;
 			emit_insn(ctx, llw, r0, t1, 0);
 			emit_zext_32(ctx, t2, true);
 			emit_zext_32(ctx, r0, true);
@@ -600,12 +617,42 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
 			emit_zext_32(ctx, r0, true);
 		}
+		/*
+		 * On arena the ll may fault (unmapped page); the page-fault
+		 * handler restarts the program at @resume.  Only the ll needs an
+		 * entry: if it faults the sc is never reached, and once the ll
+		 * succeeds the page is mapped so the sc cannot fault.  Resume
+		 * past the whole ll/sc loop.
+		 */
+		if (arena) {
+			ret = __add_exception_handler(insn, ctx,
+						      REG_DONT_CLEAR_MARKER,
+						      ll_idx, ctx->idx);
+			if (ret)
+				return ret;
+		}
 		break;
 	default:
 		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n", imm);
 		return -EINVAL;
 	}
 
+	/*
+	 * For the single-instruction am* ops the memory access is the last
+	 * emitted instruction; register its exception entry before emitting the
+	 * deferred zero-extend so the fault resumes past it.  cmpxchg handled
+	 * its own entry above.
+	 */
+	if (arena && imm != BPF_CMPXCHG) {
+		ret = __add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER,
+					      ctx->idx - 1, ctx->idx + (zext ? 1 : 0));
+		if (ret)
+			return ret;
+	}
+
+	if (zext)
+		emit_zext_32(ctx, src, true);
+
 	return 0;
 }
 
@@ -616,10 +663,37 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 dst = regmap[insn->dst_reg];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
+	const bool arena = BPF_MODE(insn->code) == BPF_PROBE_ATOMIC;
+	int ret;
 
 	switch (imm) {
 	/* dst_reg = load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
+		if (arena) {
+			/* t1 = src + off + arena_vm_start; load from [t1]. */
+			move_imm(ctx, t1, off, false);
+			emit_insn(ctx, addd, t1, src, t1);
+			emit_insn(ctx, addd, t1, t1, REG_ARENA);
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				emit_insn(ctx, ldbu, dst, t1, 0);
+				break;
+			case BPF_H:
+				emit_insn(ctx, ldhu, dst, t1, 0);
+				break;
+			case BPF_W:
+				emit_insn(ctx, ldwu, dst, t1, 0);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, ldd, dst, t1, 0);
+				break;
+			}
+			ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER);
+			if (ret)
+				return ret;
+			emit_insn(ctx, dbar, 0b10100);
+			break;
+		}
 		switch (BPF_SIZE(insn->code)) {
 		case BPF_B:
 			if (is_signed_imm12(off)) {
@@ -658,6 +732,31 @@ static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
+		if (arena) {
+			/* t1 = dst + off + arena_vm_start; store to [t1]. */
+			emit_insn(ctx, dbar, 0b10010);
+			move_imm(ctx, t1, off, false);
+			emit_insn(ctx, addd, t1, dst, t1);
+			emit_insn(ctx, addd, t1, t1, REG_ARENA);
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				emit_insn(ctx, stb, src, t1, 0);
+				break;
+			case BPF_H:
+				emit_insn(ctx, sth, src, t1, 0);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stw, src, t1, 0);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, std, src, t1, 0);
+				break;
+			}
+			ret = add_exception_handler(insn, ctx, REG_DONT_CLEAR_MARKER);
+			if (ret)
+				return ret;
+			break;
+		}
 		emit_insn(ctx, dbar, 0b10010);
 		switch (BPF_SIZE(insn->code)) {
 		case BPF_B:
@@ -708,10 +807,6 @@ static bool is_signed_bpf_cond(u8 cond)
 	       cond == BPF_JSGE || cond == BPF_JSLE;
 }
 
-#define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
-#define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
-#define REG_DONT_CLEAR_MARKER	0
-
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
 {
@@ -725,12 +820,21 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	return true;
 }
 
-/* For accesses to BTF pointers, add an entry to the exception table */
-static int add_exception_handler(const struct bpf_insn *insn,
-				 struct jit_ctx *ctx,
-				 int dst_reg)
+/*
+ * Register an exception table entry for a faulting instruction.
+ *
+ * @fault_idx is the ctx->image index of the instruction that may fault;
+ * @resume_idx is the index to resume execution at after the fault is handled.
+ * For a simple load/store these are the just-emitted instruction and the one
+ * right after it, but an atomic may need to fault on an instruction in the
+ * middle of a longer sequence (e.g. the ll of an ll/sc cmpxchg loop) and
+ * resume past the whole sequence, so both are passed explicitly.
+ */
+static int __add_exception_handler(const struct bpf_insn *insn,
+				   struct jit_ctx *ctx, int dst_reg,
+				   int fault_idx, int resume_idx)
 {
-	unsigned long pc;
+	unsigned long pc, resume_pc;
 	off_t ins_offset, fixup_offset;
 	struct exception_table_entry *ex;
 
@@ -740,20 +844,22 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
 		return -EINVAL;
 
 	ex = &ctx->prog->aux->extable[ctx->num_exentries];
-	pc = (unsigned long)&ctx->ro_image[ctx->idx - 1];
+	pc = (unsigned long)&ctx->ro_image[fault_idx];
+	resume_pc = (unsigned long)&ctx->ro_image[resume_idx];
 
 	/*
 	 * This is the relative offset of the instruction that may fault from
 	 * the exception table itself. This will be written to the exception
 	 * table and if this instruction faults, the destination register will
-	 * be set to '0' and the execution will jump to the next instruction.
+	 * be set to '0' and the execution will jump to @resume_pc.
 	 */
 	ins_offset = pc - (long)&ex->insn;
 	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
@@ -767,10 +873,10 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * modifying the upper bits because the table is already sorted, and
 	 * isn't part of the main exception table.
 	 *
-	 * The fixup_offset is set to the next instruction from the instruction
-	 * that may fault. The execution will jump to this after handling the fault.
+	 * The fixup_offset is set to the resume instruction. The execution will
+	 * jump to this after handling the fault.
 	 */
-	fixup_offset = (long)&ex->fixup - (pc + LOONGARCH_INSN_SIZE);
+	fixup_offset = (long)&ex->fixup - resume_pc;
 	if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
 		return -ERANGE;
 
@@ -789,6 +895,14 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/* The faulting instruction is the one just emitted; resume at the next. */
+static int add_exception_handler(const struct bpf_insn *insn,
+				 struct jit_ctx *ctx, int dst_reg)
+{
+	return __add_exception_handler(insn, ctx, dst_reg,
+				       ctx->idx - 1, ctx->idx);
+}
+
 static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
 {
 	u8 tm = -1;
@@ -1545,6 +1659,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 		if (!bpf_atomic_is_load_store(insn))
 			ret = emit_atomic_rmw(insn, ctx);
 		else
@@ -2557,16 +2675,12 @@ bool bpf_jit_supports_arena(void)
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
-	if (!in_arena)
-		return true;
-
-	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_W:
-	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		/* Atomics on arena pointers are not implemented yet. */
-		return false;
-	}
-
+	/*
+	 * All arena access instructions are implemented: regular and
+	 * sign-extending loads/stores (BPF_PROBE_MEM32 / BPF_PROBE_MEM32SX)
+	 * and atomics (BPF_PROBE_ATOMIC).  The default weak helper rejects
+	 * everything, so the override is required to enable arena programs.
+	 */
 	return true;
 }
 
-- 
2.25.1

