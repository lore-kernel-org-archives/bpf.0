Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF23101A0
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982290; cv=none; b=gN4fyGjqY4Qo7AcVmIdvlLZfPllc8R1Yvp92hxQGfqVKnFrO7w9snnqFKD80xhI4k5tPObxacbyD63ClRseuxCRsBbUWZmq+dc8Ksaz+7L6kailLcBHxfe1hM0h91km/h3CZqE62pPMcrFgI0c2fJUAxcuM5crweEde0FUgGLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982290; c=relaxed/simple;
	bh=MLBIPz7qaSnTDEtyKi+pBL0X4SJaUvkcmg0SY0LBIvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHG8urisnIyqpv0B38maqAuVIRPvTG8VK0waaUSAknMM3DPpQ23UwzKAD9KYTlj0qAOvvXn7+jxEuzSnTgSZSRRll5A8HPAnD0xD3UNJUJqF146II0tvw1sY5M3uTO7t6gWCHVjlBlrWC9OzvjVlahy+dibs6MztY3QOJk4KFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJibudnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJibudnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7381F00898;
	Wed, 14 Oct 2026 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982230;
	bh=3n0rVN3ZLjSiryHXqzuolzvYTp7D5jJKs+VVpfLOW7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CJibudnuO9yvbos37j0qMVv0jShvnQkntbKQVJgJgjcXLklEEoqwmpX49sxPmq7YH
	 Y8xPD3pBSx0JBhiuf20fBbbpX3WuNsHTamOzWl/A4CtH5LbbvxPPqI3Tkmb1O77a5a
	 w24ewwUeLGECjqW2SHXr4Zgs63Y1dpcB+ac6XzwADU5ThEkYiCKkMycIJEqlg9gyNu
	 kcuz+Y2NoL7QQOEqoq6hr7pT+SeLycTJz08S1BEAPHSRxPwsgDFQtyOcpAbIWPOvry
	 EnX9fBHsEyINw9atB6simOSiz4b623qm89oUA/EMjS4yUsuZcDrBNhErsol2RnrWut
	 qLMtUm3oaGRWw==
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
	"Andrea Righi" <arighi@nvidia.com>
Subject: [PATCH bpf-next v4 1/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
Date: Wed, 14 Oct 2026 05:50:11 -0700
Message-ID: <20261014125017.1426212-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014125017.1426212-1-puranjay@kernel.org>
References: <20261014125017.1426212-1-puranjay@kernel.org>
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

Emit the same loop with R12-indexed addressing and give each of the two
accesses its own exception table entry. The verifier still reserves one
per instruction, so the JIT accounts for the extra entry itself by
rescanning the instruction stream in bpf_int_jit_compile() before the
extable is sized, as s390 does in bpf_jit_alloc() for its BPF_XCHG
lowering. The rescan sits after the extra-pass early exit, so a program
is counted exactly once. Drop the bpf_jit_supports_insn() rejection.

A loop without the load would need only one entry, since a CMPXCHG that
loses the comparison reloads RAX, but its first CMPXCHG would then almost
always lose. Every operation would pay for a second locked CMPXCHG, which
makes the fetching insn more expensive than the load and CMPXCHG loop
programs write by hand today. The second entry is paid for once, in the
JIT.

Both entries resume past the whole loop rather than past the faulting
instruction alone, with the fetch destination cleared, so a fault cannot
re-enter the loop, and both are reported as writes since the BPF insn is
a read-modify-write. This repurposes the INSN_LEN field of the fixup as a
resume distance rather than an instruction length; a sequence long enough
to overflow its 8 bits would first have to exceed BPF_MAX_INSN_SIZE, which
do_jit() rejects before the image is used.

The loop needs RAX for CMPXCHG and saves R0 in BPF_REG_AX, which it also
substitutes for R0 when either operand is R0. ex_handler_bpf() may then
have to name r10 as the register holding the arena address or the one to
clear on fault; reg2pt_regs[] already has that entry.

Accesses through a number, made by programs loaded with
BPF_F_ARENA_SCALAR, keep their address in BPF_REG_AX themselves (see
arena_scalar_access()), which leaves the loop nowhere to save R0. Refuse
those in the JIT, since bpf_jit_supports_insn() cannot tell them apart
from accesses through an arena pointer. Such programs fail to load, as
they did before.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 269 +++++++++++++++++++++++++-----------
 1 file changed, 192 insertions(+), 77 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b7..5fb1a31f71a26 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -239,6 +239,13 @@ static const int reg2pt_regs[] = {
 	[BPF_REG_AX] = offsetof(struct pt_regs, r10),
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
@@ -1680,6 +1687,72 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 	return 0;
 }
 
+/*
+ * A fetching AND/OR/XOR can't be implemented with a single x86 insn, so do a
+ * CMPXCHG loop. @index_reg is X86_REG_R12 for an arena access or -1 otherwise,
+ * and @dst_reg/@src_reg are already substituted for R0 by the caller.
+ *
+ * Both the load and the CMPXCHG can fault when accessing the arena, so their
+ * addresses are handed back in @fault[0] and @fault[1]. A fault has to resume
+ * at @resume, which is past the loop and past the move that delivers the old
+ * value, but before the R0 restore. Both are NULL for the non-arena case,
+ * which needs no fixup.
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
+	/* Load old value */
+	if (fault)
+		fault[0] = prog;
+	if (index_reg < 0)
+		emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg, insn->off);
+	else
+		emit_ldx_index(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg,
+			       index_reg, insn->off);
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
+		fault[1] = prog;
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
@@ -1693,7 +1766,12 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
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
@@ -1748,6 +1826,44 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
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
@@ -2625,28 +2741,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -2682,14 +2778,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
 
@@ -2841,20 +2935,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
@@ -2875,34 +2961,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
 
@@ -2926,6 +2989,51 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			fallthrough;
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
+			if (is_atomic_fetch_op(insn)) {
+				u32 real_src_reg = src_reg, real_dst_reg = dst_reg;
+				u8 *fault[2], *resume;
+				int j;
+
+				/*
+				 * An access through a number has its address in
+				 * BPF_REG_AX (see arena_scalar_access()), where the
+				 * loop below has to save R0.
+				 */
+				if (dst_reg == BPF_REG_AX)
+					return -EOPNOTSUPP;
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
+							    fault, &resume);
+				if (err)
+					return err;
+
+				/*
+				 * The page may be unmapped between the load and the
+				 * CMPXCHG, so both need an entry. Both report a write,
+				 * since the BPF insn is a read-modify-write.
+				 */
+				for (j = 0; j < 2; j++) {
+					err = emit_arena_exentry(bpf_prog, image, rw_image,
+								 &excnt,
+								 image + proglen +
+									 (fault[j] - temp),
+								 resume - fault[j],
+								 reg2pt_regs[real_src_reg],
+								 reg2pt_regs[real_dst_reg],
+								 true, insn->off);
+					if (err)
+						return err;
+				}
+				break;
+			}
 			start_of_ldx = prog;
 
 			if (bpf_atomic_is_load_store(insn))
@@ -4353,6 +4461,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		padding = true;
 		goto skip_init_addrs;
 	}
+
+	/*
+	 * An arena fetching AND/OR/XOR is lowered to a CMPXCHG loop whose load
+	 * and CMPXCHG can both fault, one more entry than the verifier reserved.
+	 * Only reachable on the first pass, so the count is adjusted once.
+	 */
+	for (i = 0; prog->aux->arena && i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+
+		if (BPF_CLASS(insn->code) == BPF_STX &&
+		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC &&
+		    is_atomic_fetch_op(insn))
+			prog->aux->num_exentries++;
+	}
+
 	addrs = kvmalloc_objs(*addrs, prog->len + 1);
 	if (!addrs)
 		goto out_addrs;
@@ -4407,7 +4530,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			 * The number of entries in extable is the number of BPF_LDX
 			 * insns that access kernel memory via "pointer to BTF type".
 			 * The verifier changed their opcode from LDX|MEM|size
-			 * to LDX|PROBE_MEM|size to make JITing easier.
+			 * to LDX|PROBE_MEM|size to make JITing easier. Arena
+			 * accesses add one each, and an arena fetching AND/OR/XOR
+			 * one more, see the adjustment of num_exentries above.
 			 */
 			u32 align = __alignof__(struct exception_table_entry);
 			u32 extable_size = prog->aux->num_exentries *
@@ -4681,16 +4806,6 @@ bool bpf_jit_supports_arena_scalar(void)
 
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

