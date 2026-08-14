Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADD3EA95F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749622; cv=none; b=KNjoUpXYH0TuwR1BKfOOhurr10WQqcmfJrLeCA9LH5j+ydsEy0gqnLnwcp0G8iD/2XY2gV+JNqiDmebUJHyQee34Z+gVwuM5Q234sILOGMnQ+cUja0uW/dxdjBm0GIpnRYeeLoi5VYAxxbXxJ3NyERECIxN1P3CP9WAOKINKpIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749622; c=relaxed/simple;
	bh=gQWfhEdKF2JjwJqUTznVUndfsb1utd+bePMKBBr0H5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLzwCjhiW/MWrpKhiVuBUriqsulm+soIDWoFUqXRnMcPzPryl+JTo3Z1n+02VD4ZMPZ12QIpTJ2Vq77ebpIGFMl7qlJuZfNNr9lipN4y6L5g+M8f3hotC2koqSnWkW99yb7qg3j4eAhf6Bm8idHrZ7eLfLdHB4FEoVkFucoE3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=opEJJQVD; arc=none smtp.client-ip=91.218.175.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="opEJJQVD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gQWfhEdKF2JjwJqUTznVUndfsb1utd+bePMKBBr0H5A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749614; v=1; x=1787354414;
 b=opEJJQVD3u7rnINxCL80tZM894hnpAGnTzYnFN2q4Jm8/uvq98i4LxkMqhpDQHaivWJmZMg1
 TiKeqH+G/z67KNv4prfUIjHeESOUJEFD5xeCIpOIAUxtvsjii3oV1aPzLStEfz3Why+ypkNUn59
 3ybwXGSeTepWeic9tZpTdPLA=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id ad926ce0d5276d48;
	Fri, 14 Aug 2026 23:20:13 +0000
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
Subject: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal link for zero-extending movs
Date: Fri, 14 Aug 2026 16:19:43 -0700
Message-ID: <20260814231945.3884596-5-vineet.gupta@linux.dev>
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

Add subreg_eq_zext_mov_narrow: a wide-source "w7 = w6" followed by "if w6 == 0"
must narrow w7 to 0 via the low-32 BPF_FLAG_SUBREG_ZEXT link.

Update two tests for the new, more precise behaviour:
 - verifier_reg_equal/subreg_equality_2 now loads: with the low-32 link,
   "w2 < 9" narrows r3 to [0, 8], so the illegal r1 read is unreachable and the
   program is safe.
 - verifier_bounds 32-bit subtraction partial overflow: R3 now carries an id
   from the link (bounds unchanged), so __msg gains an "id=" match. It is
   required rather than optional: the id is deterministic here, and an
   optional match would still pass if the link were ever dropped again.

Also covers the dest-driven direction, which the other tests do not: they all
narrow the base and check the linked register.
zext_dest_driven_does_not_narrow_base narrows the LINKED register instead and
requires that the wide base is NOT narrowed -- the "known_reg is
subreg-linked" continue in sync_linked_regs().
It is a __failure test: the div must stay reachable. This is also the shape
that catches a lost BPF_FLAG_SUBREG_ZEXT, since dropping the flag while the
shared ->id survives makes the pair look like a full 64-bit equality and
bypasses that guard.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c     |  10 +-
 .../bpf/progs/verifier_linked_scalars.c       | 115 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_reg_equal.c  |  16 +--
 3 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 1a273e416fed..6169a61269b2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1516,7 +1516,15 @@ __naked void sub32_full_overflow(void)
 SEC("socket")
 __description("32-bit subtraction, partial overflow, result in unbounded u32 bounds")
 __success __log_level(2)
-__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
+/*
+ * w3 = w0 forms a low-32 BPF_FLAG_SUBREG_ZEXT link, so R3 carries an id here
+ * where it did not before; the bounds are unchanged. The id is deterministic
+ * (raw asm, same bytecode in every flavour) so require it rather than making
+ * it optional -- otherwise the assertion would still pass if the link were
+ * dropped again. The delta suffix is left general: log.c prints ->delta
+ * directly after the id with no separator when BPF_FLAG_ADD_CONST is set.
+ */
+__msg("3: (1c) w3 -= w2 {{.*}} R3=scalar(id={{[0-9]+([+-][0-9]+)?}},smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __retval(0)
 __naked void sub32_partial_overflow(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index c80747c16bcf..2cc6f9e45aff 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -711,4 +711,119 @@ l_exit_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * A 32-bit zero-extending mov (w7 = w6) from a source with unknown high bits
+ * shares only the low 32 bits (w7.lo == w6.lo, w7.hi == 0). A later narrowing of
+ * the source's low 32 bits must propagate to the destination via the
+ * BPF_FLAG_SUBREG_ZEXT (low-32-only) link. This is the pattern bpf-gcc emits when it
+ * reuses "w0 = idx" for "return 0" on the idx==0 path of a callback.
+ */
+SEC("socket")
+__success
+__naked void subreg_eq_zext_mov_narrow(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 = 64-bit unknown (helper ret is unbounded) */ \
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;		/* r0 = unknown high bits */	\
+	r6 |= r0;		/* still 64-bit unknown; makes it explicit */ \
+	w7 = w6;		/* 32-bit zero-extend mov, wide src */	\
+	if w6 != 0 goto l_out_%=;	/* w6 low == 0 on fall-through */ \
+	/* w7 = zext32(w6 low) must be 0 here */		\
+	if w7 == 0 goto l_out_%=;	/* provably 0 iff linked */	\
+	r0 /= 0;		/* reached only if w7 not deduced 0 */	\
+l_out_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A 32-bit zero-extending mov (w7 = w5) whose SOURCE is a wide ADD_CONST-linked
+ * register (r5 = base + K) must NOT disturb that source. Forming the low-32
+ * BPF_FLAG_SUBREG_ZEXT link on the destination would need assign_scalar_id_before_mov()
+ * on the source, which clears its base+delta link -- and a combined
+ * subreg+delta link isn't modeled anyway (sync_linked_regs() skips it). So for a
+ * wide ADD_CONST src the mov leaves the source's link intact and just clears the
+ * destination.
+ *
+ * Here r5 = r6 + 3 (ADD_CONST, wide). After the mov, narrowing the base r6 must
+ * still reach r5 through the preserved link: r6 in [0, 10] => r5 in [3, 13], so
+ * the guarded div-by-zero is unreachable. Had the mov cleared r5's link (calling
+ * assign_scalar_id_before_mov() unconditionally), r5 would stay unbounded and the
+ * div would be reachable (rejected).
+ *
+ * Note this is a no-regression guard rather than coverage of the new link:
+ * before this feature the wide-source path also left the source untouched, so
+ * the test passes either way. What it pins is the choice not to call
+ * assign_scalar_id_before_mov() unconditionally.
+ *
+ * Written in asm so the bytecode is identical regardless of the host BPF compiler.
+ */
+SEC("socket")
+__success
+__naked void zext_mov_keeps_add_const_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 low = unknown u32 */	\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
+	r5 = r6;		/* r5, r6 linked (shared id) */	\
+	r5 += 3;		/* r5 = base + 3: ADD_CONST, still wide */ \
+	w7 = w5;		/* 32-bit zext mov, wide ADD_CONST src */ \
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
+ * Dest-driven direction, zero-extend flavour: narrowing the LINKED register
+ * must not narrow the wide base.
+ *
+ * w7 = w6 shares only r6's low 32 bits; r7's high half is zero, r6's is
+ * unknown. Learning r7 == 0 therefore says nothing about r6, and
+ * sync_linked_regs() must not copy r7's state onto it. Rejected iff the base
+ * is left alone.
+ *
+ * This is the shape that catches a lost BPF_FLAG_SUBREG_ZEXT: if the flag is
+ * dropped while the shared ->id survives, the pair looks like a full 64-bit
+ * equality, the dest-driven guard is bypassed and r6 wrongly becomes 0.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void zext_dest_driven_does_not_narrow_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 low = unknown u32 */	\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
+	w7 = w6;		/* low-32 ZEXT link */		\
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
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
index dc1d8c30fb0e..e6fbbfaeedcb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -31,23 +31,25 @@ l1_%=:	exit;						\
 }
 
 SEC("socket")
-__description("check w reg not equal if r reg upper32 bits not 0")
-__failure __msg("R1 !read_ok")
+__description("w reg shares r reg low32 via subreg link even if upper32 not 0")
+__success
 __naked void subreg_equality_2(void)
 {
 	asm volatile ("					\
 	call %[bpf_ktime_get_ns];			\
 	r2 = r0;					\
-	/* Upper 4-bytes of r2 may not be 0, thus insn	\
-	 * w3 = w2 should not propagate reg id,	and	\
-	 * w2 < 9 comparison should not propagate	\
-	 * the range for r3 either.			\
+	/* Upper 4-bytes of r2 may not be 0. w3 = w2 is a 32-bit	\
+	 * zero-extending mov, so w3 shares only r2 low 32 bits	\
+	 * (a BPF_FLAG_SUBREG_ZEXT link) and its high bits are zero. The	\
+	 * w2 < 9 comparison then narrows r3 to [0, 8] via the link,	\
+	 * so if r3 < 9 is always taken and the illegal r1 read below	\
+	 * is unreachable.				\
 	 */						\
 	w3 = w2;					\
 	if w2 < 9 goto l0_%=;				\
 	exit;						\
 l0_%=:	if r3 < 9 goto l1_%=;				\
-	/* r1 read is illegal at this point */		\
+	/* unreachable: r3 is provably < 9 */		\
 	r0 -= r1;					\
 l1_%=:	exit;						\
 "	:
-- 
2.53.0-Meta

