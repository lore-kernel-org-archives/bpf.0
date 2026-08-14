Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A51B4223
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749632; cv=none; b=PhWH5VManFFCTe719YQq5VBuxKXngLUC9ZP2KE+H1pGtarqnLb+sGZ89G9ynuEl92WGA+hNYUy3G1EH6iLNWsEM4R2OZglbEJ3DNza/HiWbBIwGVunlu78cZTpL+/CsB6Qb2+n8uYeeOYC43b0oXsW8IvvfuRoDNoXq4FP2ZnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749632; c=relaxed/simple;
	bh=GoZ8TTax1JgQYYIBb8FdR0AkUUyzp+AN9V/No5qI2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ3HF4dcuje06yiOXr0efUcJK2Z577Ga7OradmM5CbC9mAEnkyHIaEKIZN70hrI52MtlAZSpWpauxMqZr+dFuCE+hbaPZ1rEOlgPCUjyfj4kAt82gze9Dw6ci/eo8w+VmtfIqlPlsJK4Jy1t+ieCp7TNQUkVAgc3uGIAuAHvC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAhADP9w; arc=none smtp.client-ip=91.218.175.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAhADP9w"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GoZ8TTax1JgQYYIBb8FdR0AkUUyzp+AN9V/No5qI2XU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749621; v=1; x=1787354421;
 b=fAhADP9wFoLqIMpVvcQ4q44t7CvqWKtRhDYO1UQE88O5Umiqo6CO5GMuB8ta9NgbwzLrS2+z
 ToNPgUR75My8hSEq62b0+73cTq6/QT5DrlgIReYGHQvdQ8Kw1PeeMmfMh2BH7C6RnyUbNPOPr0q
 nl+A0E8GhnaJB2NcGBd8H3Co=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id f0777d4a1a44ec89;
	Fri, 14 Aug 2026 23:20:21 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [RFC bpf-next 6/6] selftests/bpf: cover 32-bit sign-extension low-32 links
Date: Fri, 14 Aug 2026 16:19:45 -0700
Message-ID: <20260814231945.3884596-7-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814231945.3884596-1-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests for the BPF_FLAG_SUBREG_SEXT link, mostly built with the
div-by-zero-guard idiom: the div is unreachable iff the verifier deduces the
sign-extended register is 0, so a missed deduction turns __success into a
"div by zero" rejection.

Deduction through the link:

 - sext_linked_low_narrow_to_zero, sext_linked_separate_dest_narrow_to_zero:
   in-place and dst != src sign extension narrowed to 0 via the source's low
   32 bits. The separate-dest case runs with BPF_F_TEST_STATE_FREQ so the
   link has to survive state cleaning.
 - sext_narrow_{branch_on_source,copied_back,inplace_pre_copy,spill_fill}:
   variants derived from real "R0 ... should have been in [0, 1]" exit
   rejections -- branch on source vs dest, copy-back, spill/fill across a
   call.
 - sext_resext_preserves_range: a redundant re-sext of a value clamped to
   [-4095, 0] must keep the tight range (the errno-or-zero return pattern).

In-loop behaviour:

 - sext_in_loop_converges: convergence regression test, reproducing the
   bytecode bpf-gcc emits for a cond_break loop -- a counter incremented with
   an ALU32 add (zero-extending the high half) then sign-extended in place
   every iteration. Forming the link refreshes the linked scalar id and
   BPF_FLAG_SUBREG_SEXT each iteration, so the loop-carried state never
   repeats. It converges only because regsafe() demands a matching low-32
   link just when the old state already has one: ~9 insns with that, versus
   a load failure at 1,000,001 insns without.
 - sext_in_loop_separate_dest_index: the companion case, a fresh in-loop temp
   (a bounds-checked array index) that is dead across the back-edge. The link
   is formed here too -- there is no liveness or loop-carried exclusion, the
   gate is just (sz == 4) -- but because the temp is not loop-carried the link
   costs nothing in convergence and simply buys precision: the narrowing
   reaches it.

Interaction with the zero-extending link:

 - zext_mov_from_sext_src_zero_extends: a 32-bit zero-extending mov (w2 = w1)
   whose source is sign-extended (r1 = (s32)r6) must still zero-extend, i.e.
   its link must be BPF_FLAG_SUBREG_ZEXT and must not inherit
   BPF_FLAG_SUBREG_SEXT from the source. Otherwise sync_linked_regs() rebuilds
   the destination with reconstruct_sext32() on a later low-32 narrowing,
   computing a negative value for what is really a large positive
   zero-extended one. After "if w6 s>= 0" falls through, r6's low 32 bits have
   bit 31 set, so the zero-extended r2 is strictly positive and the guarded
   div is reachable only on a mis-reconstruction.

Two more cases the earlier tests did not reach:

 - sext_mov_keeps_add_const_src: mirror of zext_mov_keeps_add_const_src. A
   sext whose source carries an ADD_CONST delta must not destroy that link.
   Fails without the ADD_CONST source exclusion in the previous patch.
 - sext_dest_driven_does_not_narrow_base: narrows the LINKED register and
   requires the wide base is NOT narrowed, i.e. the "known_reg is
   subreg-linked" continue in sync_linked_regs(). A __failure test -- the
   div must stay reachable. Companion to the zero-extend version added by
   the zero-extend selftest patch.

All are written in asm so the bytecode is identical regardless of the host
BPF compiler.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../bpf/progs/verifier_linked_scalars.c       | 412 ++++++++++++++++++
 1 file changed, 412 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 2cc6f9e45aff..ff71e168d4cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -826,4 +826,416 @@ l_out_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * The tests below use the cpuv4 32-bit sign extension (r0 = (s32)r0), so they
+ * need a compiler that can emit it and a JIT that can run it. Same gate as
+ * verifier_movsx.c, except the compiler clause also accepts bpf-gcc, which
+ * does not define __clang_major__ but does define __BPF_FEATURE_MOVSX.
+ *
+ * The tests above do not need cpuv4, so the guard starts here rather than
+ * covering the whole file.
+ */
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
+	defined(__TARGET_ARCH_loongarch)) && \
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
+
+/*
+ * Sign-extension linked-register tracking, in-place narrow-to-zero.
+ *
+ * r1 = r0 ties r0,r1 with a shared id. r0 = (s32)r0 sign-extends r0's low 32
+ * bits; the helper return is a full 64-bit unknown so the sign bit isn't
+ * provably 0, and r0 keeps a BPF_FLAG_SUBREG_SEXT link to r1. On the w1 == 0
+ * fall-through, r1's low 32 bits are 0; r0's low 32 bits equal r1's and r0's
+ * upper bits are the sign-extension of that (0) -- so r0 == 0.
+ *
+ * The guarded div-by-zero is unreachable iff the verifier deduces r0 == 0.
+ */
+SEC("socket")
+__success
+__naked void sext_linked_low_narrow_to_zero(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = r0;		/* r1 == r0, shared id */	\
+	r0 = (s32)r0;		/* r0 = sext32(r0) */		\
+	if w1 != 0 goto l0_%=;	/* fall-through: w1 == 0 */	\
+	/* want deduced here: r0 == 0 */			\
+	if r0 == 0 goto l0_%=;	/* always taken iff r0==0 known */ \
+	r0 /= 0;		/* unreachable iff r0==0 deduced */ \
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Separate-dest sign-extension: r3 = (s32)r2 (dst != src). r2,r3 share a base
+ * id (r3 with BPF_FLAG_SUBREG_SEXT). On the w2 == 0 fall-through, r2's low 32 bits are
+ * 0, so r3 = sext32(0) = 0 and the guarded div-by-zero is unreachable.
+ *
+ * Runs with BPF_F_TEST_STATE_FREQ to force checkpointing between the sext and
+ * the branch: the sext linkage (BPF_FLAG_SUBREG_SEXT) must survive state
+ * cleaning so sync_linked_regs() can still reconstruct r3. bpf_clear_singular_ids()
+ * strips the link flags when counting base ids; otherwise r3's compound id looks
+ * singular and gets cleared, and r3 stays wide.
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void sext_linked_separate_dest_narrow_to_zero(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r2 = r0;		/* r2,(r0) linked, id N */	\
+	r3 = (s32)r2;		/* r3 = sext32(r2): SEXT link base N */	\
+	if w2 != 0 goto l0_%=;	/* fall-through: w2 == 0 */	\
+	/* want deduced here: r3 == 0 */			\
+	if r3 == 0 goto l0_%=;	/* always taken iff r3==0 known */ \
+	r0 /= 0;		/* unreachable iff r3==0 deduced */ \
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Coverage derived from real "R0 ... should have been in [0, 1]" exit
+ * rejections. Each sign-extends a value, then a branch proves its low 32 bits
+ * are 0 so the sext result must be 0. Expressed with the div-by-zero idiom (same
+ * deduced range the return-code check reads): the div is unreachable iff the
+ * verifier deduces the sext register is 0.
+ */
+
+/* 1: branch on the SOURCE reg; separate dest (value stands in for a u32 load). */
+SEC("socket")
+__success
+__naked void sext_narrow_branch_on_source(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r2 = r0;		/* r2 = value (proxy for u32 load) */	\
+	r0 = (s32)r2;		/* r0 = sext32(r2) */		\
+	if w2 != 0 goto l0_%=;	/* w2 != 0: r0 unknown, skip */	\
+	if r0 == 0 goto l0_%=;	/* w2 == 0: r0 must be 0 */	\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 2: sext into r7, prove via w0, then copy r7 back into r0. */
+SEC("socket")
+__success
+__naked void sext_narrow_copied_back(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r7 = (s32)r0;		/* r7 = sext32(r0) */		\
+	if w0 != 0 goto l0_%=;	/* w0 != 0: skip */		\
+	r0 = r7;		/* w0 == 0: r0 = r7 (must be 0) */ \
+	if r0 == 0 goto l0_%=;					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 3: in-place sext; branch on the pre-sext copy r1 (== direction). */
+SEC("socket")
+__success
+__naked void sext_narrow_inplace_pre_copy(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = r0;		/* pre-sext copy, linked */	\
+	r0 = (s32)r0;		/* in-place sext32 */		\
+	if w1 == 0 goto l_chk_%=;/* w1 == 0: r0 must be 0 */	\
+	goto l0_%=;		/* w1 != 0: nothing to check */	\
+l_chk_%=:							\
+	if r0 == 0 goto l0_%=;					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 4: sext, prove via w0, spill to stack across a call, reload, use. */
+SEC("socket")
+__success
+__naked void sext_narrow_spill_fill(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r9 = (s32)r0;		/* r9 = sext32(r0) */		\
+	if w0 != 0 goto l0_%=;	/* w0 != 0: skip */		\
+	/* w0 == 0: r9 must be 0 */				\
+	*(u64 *)(r10 - 8) = r9;	/* spill r9 */			\
+	call %[bpf_get_prandom_u32];/* clobbers r0-r5 */	\
+	r5 = *(u64 *)(r10 - 8);	/* reload -> must be 0 */	\
+	if r5 == 0 goto l0_%=;					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A redundant 32-bit sign-extension of an already-narrowed value must preserve
+ * the range. This is the errno-or-zero return pattern (set_if_not_errno_or_zero()
+ * followed by "return ret" on an int): the value is clamped to [-4095, 0] and
+ * then sign-extended again, e.g. verify_pkcs7_sig / many lsm.s progs under
+ * bpf-gcc. coerce_reg_to_size_sx() bails to the full [S32_MIN, S32_MAX] range
+ * when the range straddles the sign boundary (smin<0, smax>=0), so without the
+ * sext-self reconstruction the final "r0 = (s32)r0" widens [-4095, 0] back to
+ * the full range and the program is rejected. Knowing the high half is the
+ * sign-extension of the low 32 bits lets the verifier rebuild the tight range.
+ */
+SEC("socket")
+__success
+__naked void sext_resext_preserves_range(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r0 = (s32)r0;		/* r0 = [S32_MIN, S32_MAX] */	\
+	if r0 s> 0 goto l_out_%=;	/* r0 <= 0 */		\
+	if r0 s< -4095 goto l_out_%=;	/* r0 in [-4095, 0] */	\
+	r0 = (s32)r0;		/* redundant re-sext (pkcs7 pattern) */ \
+	if r0 s>= -4095 goto l_lo_ok_%=;/* must hold if range kept */ \
+	r0 /= 0;		/* reached only if lower bound lost */	\
+l_lo_ok_%=:							\
+	if r0 s<= 0 goto l_out_%=;	/* must hold if range kept */ \
+	r0 /= 0;		/* reached only if upper bound lost */	\
+l_out_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A 32-bit sign-extension INSIDE a loop must verify and converge. This is the
+ * bytecode pattern bpf-gcc emits for a cond_break loop (see cond_break4): a
+ * counter is incremented with an ALU32 add (which zero-extends the high half)
+ * and then sign-extended in place every iteration.
+ *
+ * The verifier links dst<->src on a sign-extension. Doing that for a sext on a
+ * register carried across the loop back-edge mints/refreshes the linked scalar
+ * id and its BPF_FLAG_SUBREG_SEXT metadata each iteration; combined with the
+ * ALU32 add's BPF_FLAG_ADD_CONST delta the loop-carried state never repeats, so state
+ * pruning can't converge and verification runs to the 1M instruction limit.
+ *
+ * The regsafe() guard on the low-32 link flags is what prevents this: it only demands a
+ * match when the OLD state already carries a link (rold->id), so a register that
+ * first picks up a sext link inside the loop can still match its pre-loop state.
+ * Without that guard the loop-carried r2 never matches and the load fails at
+ * 1,000,001 insns, i.e. this __success flips to a load failure -- so this is the
+ * regression test for it. (See sext_in_loop_separate_dest_index for the
+ * companion case, a fresh in-loop temp that keeps its link for precision.)
+ *
+ * The pattern is written in asm so the bytecode is identical regardless of the
+ * host BPF compiler.
+ */
+SEC("socket")
+__success
+__naked void sext_in_loop_converges(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r2 = r0;		/* r2 = 64-bit unknown (helper ret) */	\
+l_body_%=:							\
+	.byte 0xe5; /* may_goto l_exit (loop bound) */	\
+	.byte 0;						\
+	.short 3;						\
+	.long 0;						\
+	w2 += 1;		/* ALU32 add: low += 1, high = 0 */ \
+	r2 = (s32)r2;		/* in-place in-loop sign-extend */ \
+	goto l_body_%=;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A separate-destination 32-bit sign extension INSIDE a loop keeps its low-32
+ * link, so a later bounds check on the source narrows the sign-extended
+ * destination too. This is the bytecode a bpf-gcc build emits for array indexing
+ * in a bpf_for loop -- a fresh 32-bit index load, a separate "r1 = (s32)r0",
+ * then a bounds check on the index (verifier_global_subprogs' syscall_array_bpf_for).
+ *
+ * Both in-loop cases form the link -- subreg_link is just (sz == 4), with no
+ * liveness or loop-carried exclusion. What differs is what the link buys. Here
+ * the destination is a fresh temp, dead across the back-edge, so the link is
+ * pure precision: "if w0 > 99" narrows r1 to [0, 99] and the guarded
+ * div-by-zero is unreachable. In sext_in_loop_converges the target is the
+ * loop-carried counter, so the link is re-formed every iteration and the
+ * question is convergence instead -- answered by the regsafe() rold->id guard,
+ * not by declining to link.
+ *
+ * Written in asm so the bytecode is identical regardless of the host BPF
+ * compiler.
+ */
+SEC("socket")
+__success
+__naked void sext_in_loop_separate_dest_index(void)
+{
+	asm volatile ("						\
+l_body_%=:							\
+	.byte 0xe5; /* may_goto l_exit (loop bound) */	\
+	.byte 0;						\
+	.short 7;						\
+	.long 0;						\
+	call %[bpf_get_prandom_u32];/* r0 = fresh u32 each iter */ \
+	r1 = (s32)r0;		/* in-loop separate-dest sext */ \
+	if w0 > 0x63 goto l_body_%=;/* fall-through: w0 <= 99 */	\
+	/* want r1 = sext32(r0 low) == [0, 99] here (needs the link) */ \
+	if r1 > 0x63 goto l_err_%=;/* taken unless r1 narrowed */ \
+	goto l_body_%=;						\
+l_err_%=:							\
+	r0 /= 0;		/* reachable iff r1 not narrowed */	\
+	goto l_body_%=;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A 32-bit zero-extending mov (w2 = w1) whose SOURCE is a sign-extended register
+ * must still zero-extend: dst's high bits are 0, not the sign-extension of the
+ * low field. Regression test for the zext link clearing BPF_FLAG_SUBREG_SEXT (otherwise
+ * dst would inherit SUBREG_SEXT from the sext'd source, and sync_linked_regs()
+ * would later rebuild it with reconstruct_sext32() -- computing a negative value
+ * for what is actually a large positive zero-extended one).
+ *
+ * r1 = (s32)r6 makes r1 a sext-linked wide source; w2 = w1 forms the zext link.
+ * After "if w6 s>= 0" falls through, r6's low 32 bits have bit 31 set, so the
+ * zero-extended r2 must be in [0x80000000, 0xffffffff]. Two guards assert that
+ * whole range, so the test needs the feature present, not merely the absence of
+ * the sext-leak bug: "r2 s< 0" catches the leak (r2 rebuilt negative), and
+ * "w2 s>= 0" catches the low-32 link being absent entirely (r2 not narrowed to
+ * the high half, so bit 31 is not known set). Either makes the div reachable.
+ */
+SEC("socket")
+__success
+__naked void zext_mov_from_sext_src_zero_extends(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 low = unknown u32 (callee-saved) */ \
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown (width 64) */ \
+	r1 = (s32)r6;		/* r1 = sext32(r6 low): SUBREG_SEXT, wide */ \
+	w2 = w1;		/* zext mov from sext-linked wide src */ \
+	if w6 s>= 0 goto l_out_%=;/* fall-through: r6 low has bit 31 set */ \
+	/* r2 = zext32(r6 low) must be in [0x80000000, 0xffffffff]: */	\
+	if r2 s< 0 goto l_err_%=;/* sext leak: r2 wrongly negative */ \
+	if w2 s>= 0 goto l_err_%=;/* link absent: r2 low bit 31 not known set */ \
+	goto l_out_%=;						\
+l_err_%=:							\
+	r0 /= 0;		/* r2 not proven in [0x80000000, 0xffffffff] */ \
+l_out_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Mirror of zext_mov_keeps_add_const_src for the sign-extending mov: a sext
+ * whose source carries an ADD_CONST delta must not destroy that link.
+ *
+ * Forming a low-32 link calls assign_scalar_id_before_mov(), which clears an
+ * ADD_CONST src, so the sext arm excludes such a source exactly as the zext
+ * arm does. Without that exclusion r5 loses its base+delta relationship to r6
+ * here, "if r6 > 10" no longer narrows r5, and the guarded div becomes
+ * reachable.
+ */
+SEC("socket")
+__success
+__naked void sext_mov_keeps_add_const_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 low = unknown u32 */	\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
+	r5 = r6;		/* r5, r6 linked (shared id) */	\
+	r5 += 3;		/* r5 = base + 3: ADD_CONST, still wide */ \
+	r7 = (s32)r5;		/* 32-bit sext mov, ADD_CONST src */ \
+	if r6 > 10 goto l_out_%=;/* r6 in [0, 10] */		\
+	/* r5 = r6 + 3 must be in [3, 13] here (needs the kept link) */ \
+	if r5 > 13 goto l_err_%=;/* taken only if r5 not narrowed */ \
+	goto l_out_%=;						\
+l_err_%=:							\
+	r0 /= 0;		/* reachable iff r5's link was cleared */ \
+l_out_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Dest-driven direction, sign-extend flavour: narrowing the LINKED register
+ * must not narrow the wide base.
+ *
+ * r7 = (s32)r6 shares only r6's low 32 bits. Learning r7 == 0 says nothing
+ * about r6's high half, so sync_linked_regs() must leave r6 alone -- that is
+ * the "known_reg is subreg-linked" continue. If it ever propagated, r6 would
+ * be known 0 here and the div would be treated as unreachable, so the program
+ * must be REJECTED.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void sext_dest_driven_does_not_narrow_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 low = unknown u32 */	\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
+	r7 = (s32)r6;		/* low-32 SEXT link */		\
+	if r7 != 0 goto l_out_%=;/* r7 == 0: low 32 bits are 0 */ \
+	if r6 != 0 goto l_out_%=;/* r6 may still have high bits set */ \
+	r0 /= 0;		/* must stay reachable */	\
+l_out_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#endif /* cpuv4 sign extension */
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

