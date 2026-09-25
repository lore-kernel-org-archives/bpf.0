Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4744A484A;
	Fri, 25 Sep 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344118; cv=none; b=kzrAyJ0XUQD6l0fx2tyqdIth5ua8GSunJaQ1RH37PXo/JQxWoGxCd8yLM8a0MKfH2FSE1NYoBQanbpTTg46d9TeEY1T1oBtbsgM+GF1RkyNZe/n8JHD/8VkMUCNf/AObwhzcu0UHn38UcOlSX2H4ZPA0DsvBjsiPeQIS0u9N5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344118; c=relaxed/simple;
	bh=c1kLrjraJ8bcJLD49zEkh7VY4WV2UUTlip74euouqyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqkeQrnRP3POSngOFpyuyDZDXOiLGjtpcNhASo+h8eIpRgSL6yg/hND5uI6soniicMIS6ycHo8mTgLcg13snXRGZJvDaqj/fGhUjCR7/FBZtONFUAPY6Niq0fmk5hpQ5ErSfBfNbdH5Xt4BHqBN8eUokI9VlbuRLc37Tyx36blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1ZXVltq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1ZXVltq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94C71F000FF;
	Fri, 25 Sep 2026 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344116;
	bh=AskOnt1SuXpPfRL1OoXFzskjk6VGP8Wm64nTkco8ak8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F1ZXVltqb07VqhGuNAy0oRub4VWHMGJ+HJJmef4jwB1rq6k8lrTB4dDZfUW0Ceute
	 WiTGOtluIbv+cwLCzNCYgmJEUmPmN2Zcxv9VLb9cX/D9Xo2ogmaYKxoDWATWEAYd+f
	 l7iqHFlAjDSoZvMOFE/KqKRzrmHk6d6WaohzHSsuqAoH9QlRZnfEcua4TAIDN3f2Pt
	 6FDWsjtpCtFPrXPQVKEKYS98hVZQ2s4rEV2PoP9pK88431f1u68bqXSgkOXPFN8zy8
	 n+RzQUBWssLdKWvAz37ftbu5VXAkyGhWHBbuR1m7vk9xLYe+RMAef3D6rqCoYKRcme
	 jhvCMjC9Te75w==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Tejun Heo" <tj@kernel.org>,
	"David Vernet" <void@manifault.com>,
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
Date: Fri, 25 Sep 2026 06:48:20 -0700
Message-ID: <20260925134828.2012199-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925134828.2012199-1-puranjay@kernel.org>
References: <20260925134828.2012199-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86-64 has no single instruction for a fetching AND/OR/XOR, so the JIT
lowers them to a CMPXCHG loop. That loop could not be used against arena
memory: it contains two memory accesses, the load of the old value and
the CMPXCHG itself, either of which can fault when the arena page goes
away, while the verifier reserves only one exception table entry per
instruction. bpf_jit_supports_insn() therefore rejected the three opcodes
and such programs failed to load with

  BPF_ATOMIC stores into R1 arena is not allowed

Emit the loop without the initial load. A CMPXCHG that loses the
comparison loads the current contents into RAX, so the loop converges
from whatever R0 already holds, and the value it stores is computed from
RAX, which by definition equalled memory whenever the store happened.
That leaves the CMPXCHG as the only insn that can fault, so one exception
table entry is enough and the count the verifier already reserved still
matches. Drop the bpf_jit_supports_insn() rejection that gated all this.

The first CMPXCHG compares against an unrelated value, so barring
coincidence it always loses and the arena form executes at least two
locked CMPXCHGs every time. A losing locked CMPXCHG is still a full
read-modify-write, so this is a real steady-state cost rather than an
occasional retry, which is why the non-arena lowering keeps its load.

The entry resumes past the whole loop rather than past the faulting
instruction alone, with the fetch destination cleared, so a fault cannot
re-enter the loop. This repurposes the INSN_LEN field of the fixup as a
resume distance rather than an instruction length; a sequence long enough
to overflow its 8 bits would first have to exceed BPF_MAX_INSN_SIZE, which
do_jit() rejects before the image is used.

The loop needs RAX for CMPXCHG and substitutes BPF_REG_AX for R0 when
either operand is R0, so add the matching reg2pt_regs[] entry:
ex_handler_bpf() now has to name that register both as the one holding
the arena address and as the one to clear on fault.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 236 ++++++++++++++++++++++++------------
 1 file changed, 160 insertions(+), 76 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6c7a0578760e7..570ee93a969a9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -236,8 +236,17 @@ static const int reg2pt_regs[] = {
 	[BPF_REG_7] = offsetof(struct pt_regs, r13),
 	[BPF_REG_8] = offsetof(struct pt_regs, r14),
 	[BPF_REG_9] = offsetof(struct pt_regs, r15),
+	/* Substituted for R0 by the CMPXCHG loop lowering below. */
+	[BPF_REG_AX] = offsetof(struct pt_regs, r10),
 };
 
+static bool is_atomic_fetch_op(const struct bpf_insn *insn)
+{
+	return insn->imm == (BPF_AND | BPF_FETCH) ||
+	       insn->imm == (BPF_OR | BPF_FETCH) ||
+	       insn->imm == (BPF_XOR | BPF_FETCH);
+}
+
 /*
  * is_ereg() == true if BPF register 'reg' maps to x86-64 r8..r15
  * which need extra byte of encoding.
@@ -1679,6 +1688,74 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 	return 0;
 }
 
+/*
+ * A fetching AND/OR/XOR can't be implemented with a single x86 insn, so do a
+ * CMPXCHG loop. @index_reg is X86_REG_R12 for an arena access or -1 otherwise,
+ * and @dst_reg/@src_reg are already substituted for R0 by the caller.
+ *
+ * For an arena access the CMPXCHG is the only insn that can fault; its address
+ * is handed back in @fault. A fault has to resume at @resume, which is past the
+ * loop and past the move that delivers the old value, but before the R0
+ * restore. Both are NULL for the non-arena case, which needs no fixup.
+ */
+static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
+				 u32 src_reg, int index_reg, u8 **fault,
+				 u8 **resume)
+{
+	bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+	u8 *branch_target, *prog = *pprog;
+	int err;
+
+	branch_target = prog;
+
+	/*
+	 * Load old value. The arena case skips it and lets the loop start from
+	 * whatever R0 happens to hold: a CMPXCHG that loses the comparison
+	 * loads the current contents into RAX, so the loop converges, and the
+	 * value it stores is computed from RAX, which by definition equalled
+	 * memory whenever the store happened. That leaves the CMPXCHG as the
+	 * only insn that can fault, which is worth an extra iteration here to
+	 * keep this to a single exception table entry.
+	 */
+	if (index_reg < 0)
+		emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg, insn->off);
+
+	/*
+	 * Perform the (commutative) operation locally, put the result in
+	 * the AUX_REG.
+	 */
+	emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
+	maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
+	EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
+	      add_2reg(0xC0, AUX_REG, src_reg));
+
+	/* Attempt to swap in new value */
+	if (fault)
+		*fault = prog;
+	if (index_reg < 0)
+		err = emit_atomic_rmw(&prog, BPF_CMPXCHG, dst_reg, AUX_REG,
+				      insn->off, BPF_SIZE(insn->code));
+	else
+		err = emit_atomic_rmw_index(&prog, BPF_CMPXCHG, BPF_SIZE(insn->code),
+					    dst_reg, AUX_REG, index_reg, insn->off);
+	if (WARN_ON(err))
+		return err;
+
+	/* ZF tells us whether we won the race. If it's cleared we need to try again. */
+	EMIT2(X86_JNE, -(prog - branch_target) - 2);
+	/* Return the pre-modification value */
+	emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+
+	if (resume)
+		*resume = prog;
+
+	/* Restore R0 after clobbering RAX */
+	emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+
+	*pprog = prog;
+	return 0;
+}
+
 /*
  * Metadata encoding for exception handling in JITed code.
  *
@@ -1692,7 +1769,12 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
  * | ARENA_ACC | ARENA_WRITE | Unused | ARENA_REG | DST_REG | INSN_LEN |
  * +-----------+-------------+--------+-----------+---------+----------+
  *
- * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
+ * - INSN_LEN (8 bits): How far past the faulting insn to resume. That is its own length
+ *                      for a single-insn access, but the distance to the end of the whole
+ *                      sequence where one BPF insn became several, as for the CMPXCHG loop
+ *                      of a fetching AND/OR/XOR. A sequence long enough to overflow this
+ *                      field would first have to exceed BPF_MAX_INSN_SIZE, which do_jit()
+ *                      rejects with -EFAULT before the image is used.
  * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
  *                      This is set to DONT_CLEAR if the insn does not read into a register.
  * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
@@ -1747,6 +1829,44 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 	return true;
 }
 
+/*
+ * Record an arena access that may fault. @fault_ip is the address of the
+ * faulting insn in the RO image, @resume_off how far past it execution has to
+ * resume: for a multi-insn lowering that is the end of the whole sequence, not
+ * the end of the one insn.
+ */
+static int emit_arena_exentry(struct bpf_prog *bpf_prog, u8 *image, u8 *rw_image,
+			      int *excnt, u8 *fault_ip, u32 resume_off,
+			      u32 fixup_reg, u32 arena_reg, bool is_write, s16 off)
+{
+	struct exception_table_entry *ex;
+	s64 delta;
+
+	if (!bpf_prog->aux->extable)
+		return 0;
+
+	if (*excnt >= bpf_prog->aux->num_exentries) {
+		pr_err("arena extable bug\n");
+		return -EFAULT;
+	}
+	ex = &bpf_prog->aux->extable[(*excnt)++];
+
+	delta = fault_ip - (u8 *)&ex->insn;
+	/* switch ex to rw buffer for writes */
+	ex = (void *)rw_image + ((void *)ex - (void *)image);
+
+	ex->insn = delta;
+	ex->data = EX_TYPE_BPF | FIELD_PREP(DATA_ARENA_OFFSET_MASK, off);
+	ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, resume_off) |
+		    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
+		    FIELD_PREP(FIXUP_REG_MASK, fixup_reg) |
+		    FIXUP_ARENA_ACCESS;
+	if (is_write)
+		ex->fixup |= FIXUP_ARENA_WRITE;
+
+	return 0;
+}
+
 static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
 			     bool *regs_used)
 {
@@ -2624,28 +2744,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 populate_extable:
 			{
-				struct exception_table_entry *ex;
-				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				u32 arena_reg, fixup_reg;
 				bool is_write;
-				s64 delta;
-
-				if (!bpf_prog->aux->extable)
-					break;
-
-				if (excnt >= bpf_prog->aux->num_exentries) {
-					pr_err("mem32 extable bug\n");
-					return -EFAULT;
-				}
-				ex = &bpf_prog->aux->extable[excnt++];
-
-				delta = _insn - (u8 *)&ex->insn;
-				/* switch ex to rw buffer for writes */
-				ex = (void *)rw_image + ((void *)ex - (void *)image);
-
-				ex->insn = delta;
-
-				ex->data = EX_TYPE_BPF;
 
 				/*
 				 * src_reg/dst_reg holds the address in the arena region with upper
@@ -2681,14 +2781,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					is_write = true;
 				}
 
-				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
-					    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
-					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
-				ex->fixup |= FIXUP_ARENA_ACCESS;
-				if (is_write)
-					ex->fixup |= FIXUP_ARENA_WRITE;
-
-				ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
+				err = emit_arena_exentry(bpf_prog, image, rw_image, &excnt,
+							 image + proglen + (start_of_ldx - temp),
+							 prog - start_of_ldx, fixup_reg,
+							 arena_reg, is_write, insn->off);
+				if (err)
+					return err;
 			}
 			break;
 
@@ -2840,20 +2938,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			fallthrough;
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW: {
-			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
 			u32 real_src_reg = src_reg;
 			u32 real_dst_reg = dst_reg;
+			bool is_atomic_fetch = is_atomic_fetch_op(insn);
 			u8 *old_prog;
-			bool is_atomic_fetch =
-				(insn->imm == (BPF_AND | BPF_FETCH) ||
-				 insn->imm == (BPF_OR | BPF_FETCH) ||
-				 insn->imm == (BPF_XOR | BPF_FETCH));
-			if (is_atomic_fetch) {
-				/*
-				 * Can't be implemented with a single x86 insn.
-				 * Need to do a CMPXCHG loop.
-				 */
 
+			if (is_atomic_fetch) {
 				/* Will need RAX as a CMPXCHG operand so save R0 */
 				old_prog = prog;
 				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
@@ -2874,34 +2964,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				}
 			}
 			if (is_atomic_fetch) {
-				u8 *branch_target = prog;
-				/* Load old value */
-				emit_ldx(&prog, BPF_SIZE(insn->code),
-					 BPF_REG_0, real_dst_reg, insn->off);
-				/*
-				 * Perform the (commutative) operation locally,
-				 * put the result in the AUX_REG.
-				 */
-				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
-				maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
-				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
-				      add_2reg(0xC0, AUX_REG, real_src_reg));
-				/* Attempt to swap in new value */
-				err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
-						      real_dst_reg, AUX_REG,
-						      insn->off,
-						      BPF_SIZE(insn->code));
-				if (WARN_ON(err))
+				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
+							    real_src_reg, -1, NULL,
+							    NULL);
+				if (err)
 					return err;
-				/*
-				 * ZF tells us whether we won the race. If it's
-				 * cleared we need to try again.
-				 */
-				EMIT2(X86_JNE, -(prog - branch_target) - 2);
-				/* Return the pre-modification value */
-				emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
-				/* Restore R0 after clobbering RAX */
-				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
 				break;
 			}
 
@@ -2925,6 +2992,33 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			fallthrough;
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
+			if (is_atomic_fetch_op(insn)) {
+				u32 real_src_reg = src_reg, real_dst_reg = dst_reg;
+				u8 *fault, *resume;
+
+				/* Will need RAX as a CMPXCHG operand so save R0 */
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				if (src_reg == BPF_REG_0)
+					real_src_reg = BPF_REG_AX;
+				if (dst_reg == BPF_REG_0)
+					real_dst_reg = BPF_REG_AX;
+
+				err = emit_atomic_fetch_rmw(&prog, insn, real_dst_reg,
+							    real_src_reg, X86_REG_R12,
+							    &fault, &resume);
+				if (err)
+					return err;
+
+				err = emit_arena_exentry(bpf_prog, image, rw_image, &excnt,
+							 image + proglen + (fault - temp),
+							 resume - fault,
+							 reg2pt_regs[real_src_reg],
+							 reg2pt_regs[real_dst_reg],
+							 true, insn->off);
+				if (err)
+					return err;
+				break;
+			}
 			start_of_ldx = prog;
 
 			if (bpf_atomic_is_load_store(insn))
@@ -4669,16 +4763,6 @@ bool bpf_jit_supports_arena(void)
 
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
-	if (!in_arena)
-		return true;
-	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_W:
-	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (insn->imm == (BPF_AND | BPF_FETCH) ||
-		    insn->imm == (BPF_OR | BPF_FETCH) ||
-		    insn->imm == (BPF_XOR | BPF_FETCH))
-			return false;
-	}
 	return true;
 }
 
-- 
2.53.0-Meta

