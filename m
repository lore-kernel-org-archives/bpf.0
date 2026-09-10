Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DA52378E
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058837; cv=none; b=pFlY/m2expWCVZiHx3FblThl/G0uml0DjKkUYMcnUtlkrm/HvVcGfZPhm/CsV6ICR2n5rnAHoM5fFB4D3OUZLuwMyctDrEYhaIMXBFW4wU3tRU8KSiZdulr5A4pKxK8dsBwIvS276qE0q6sz7P5Ujet+OiebNQpg8qGKlckBFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058837; c=relaxed/simple;
	bh=2m4zsRZhVEqwAroNUaycY1tRN5knZntOtthXJsBjwOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usMU2rmbHurMTYOMAy8He+n+o9A4HSfJ3B4VUKuIaT2e9Cpo9TvQ7yUG1BElSPx76pEU/IYLA6Ltbdcg/DHtyPOOIiU1GoYJXddx6rJlvXNhLQOoIUCLVCMYEu9TuMOfik6LDAgmZ5kQbDKfxa1yRkAzqcyeRi5ci+SMagz22UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7Db0hma; arc=none smtp.client-ip=91.218.175.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7Db0hma"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2m4zsRZhVEqwAroNUaycY1tRN5knZntOtthXJsBjwOo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058830; v=1; x=1789663630;
 b=Y7Db0hmauf7xHjb3CDYlFVLxDKE20W+1opN1IzYnlYnRMY5+ad/6vlFINChayvIxdd4vN/KE
 8r2XaYcJoXvSGqNoTJVEAlNvtCV3QRQftZtqeyTRRsKxkGVf6xcJ7UkWlNs5uK20pOik8s6RDEi
 6A8TttpMuy/C+X7T5Cqx3C0w=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a9e9481228269a2;
	Thu, 10 Sep 2026 16:47:10 +0000
X-Mizu-Trace-ID: 4a9e9481228269a2
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
Subject: [PATCH bpf-next v2 04/13] selftests/bpf: cover the low-32 link for zero-extending movs
Date: Thu, 10 Sep 2026 22:16:26 +0530
Message-ID: <20260910164635.459558-5-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise each decision the previous patch adds:

 - zext_mov_narrow_src: narrowing the source reaches the destination
 - zext_narrow_dst_keeps_base: the reverse must not happen, the base's
   high bits are still unknown
 - zext_u32_src_is_full_link: a provably-u32 source keeps taking the
   full-equality path
 - zext_self_mov_no_link: a self-mov mints no id
 - zext_chain_keeps_link: a linked source survives a further 32-bit mov
 - zext_no_sync_when_base_has_delta, zext_no_sync_from_subreg_base: a
   delta on either side stops propagation, in both directions
 - zext_sync_between_two_subregs: two low-32 links on one base do reach
   each other
 - zext_unlinked_path_stays_reachable: only one path links r7 to r8, so
   the guarded div stays reachable
 - zext_mov_breaks_add_const_src: forming the link drops a delta link on
   the source, as the narrow-source path has always done

Written in asm so the bytecode is the same whichever compiler built the
suite.

These three check an outcome rather than a mechanism: the states they
compare differ in ids, contents or ranges, so regsafe() keeps them apart
for reasons of its own and no single check can be disabled to make them
fail.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: was RFC 4/6.
 - all tests live in verifier_linked_scalars.c (Eduard)
 - numeric labels, and the verifier_bounds regex left as-is bar the id
   (Eduard)
 - dropped the LLM-written commentary and the redundant second
   bpf_get_prandom_u32() (Eduard)
 - covers the seven cases listed on RFC 4/6
 - the dest-driven test had the polarity flaw sashiko found on 6/6; its
   == guard now discriminates, verified by disabling the guard it targets
 - three tests renamed for what they check, see the cover letter
 .../bpf/progs/verifier_linked_scalars.c       | 256 ++++++++++++++++++
 1 file changed, 256 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index da6cb961a520..65cb0efd268f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -710,4 +710,260 @@ l_exit_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * A 32-bit mov from a wide source shares only the low 32 bits. Narrowing the
+ * source must reach the destination through that link.
+ */
+SEC("socket")
+__success
+__naked void zext_mov_narrow_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* forms the link */		\
+	if w6 != 0 goto 1f;	/* narrows r6, propagates to r7 */ \
+	if w7 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The reverse does not hold: narrowing the low-32 link says nothing about the
+ * base's high bits, so r6 must stay unknown and the div stays reachable.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_narrow_dst_keeps_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* forms the link */		\
+	if r7 != 0 goto 1f;	/* narrows r7, must not propagate to r6 */ \
+	if r6 == 0 goto 1f;	/* taken only if r6 wrongly narrowed */	\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A provably-u32 source takes the full-equality path, not the low-32 one:
+ * narrowing the destination must reach the source.
+ */
+SEC("socket")
+__success
+__naked void zext_u32_src_is_full_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 provably u32 */		\
+	w7 = w6;		/* full link, not low-32 */	\
+	if r7 > 10 goto 1f;	/* narrows r7, propagates to r6 */ \
+	if r6 > 10 goto 2f;					\
+	goto 1f;						\
+2:								\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A self-mov has nothing to link, so it must not mint an id for r6.
+ */
+SEC("socket")
+__success __log_level(2)
+/* an id would print as R6=scalar(id=N.lo32,smin=... */
+__msg("(bc) w6 = w6 {{.*}} R6=scalar(smin=0,")
+__naked void zext_self_mov_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 ^= 0;		/* drop the id */		\
+	w6 = w6;		/* forms no link */		\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A low-32-linked source keeps its id and flag across a further 32-bit mov,
+ * so narrowing the base still reaches the end of the chain.
+ */
+SEC("socket")
+__success
+__naked void zext_chain_keeps_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* forms the link */		\
+	w8 = w7;		/* link survives the 2nd mov */	\
+	if w6 != 0 goto 1f;	/* narrows r6, propagates to r8 */ \
+	if w8 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A delta on either side is not modelled together with a low-32 link, so no
+ * range propagates: here the branch register carries the delta.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_no_sync_when_base_has_delta(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on the branch reg */	\
+	if r8 != 3 goto 1f;	/* must not propagate to r7 */	\
+	if w7 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * ... and here the low-32 link is the branch register, so the register
+ * carrying the delta must not be narrowed either.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_no_sync_from_subreg_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on r8 */		\
+	if w7 != 0 goto 1f;	/* must not propagate to r8 */	\
+	if r8 == 3 goto 1f;	/* taken only if r8 wrongly narrowed */	\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Two low-32 links on the same base do propagate to each other: both are the
+ * zero-extension of the same low 32 bits.
+ */
+SEC("socket")
+__success
+__naked void zext_sync_between_two_subregs(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w7 = w6;		/* two links on one base */	\
+	w8 = w6;						\
+	if w7 != 0 goto 1f;	/* narrows r7, propagates to r8 */ \
+	if w8 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Only one of the two paths links r7 to r8, so the narrowing of w8 reaches r7
+ * on one and not the other and the div stays reachable. This checks the
+ * outcome, not the mechanism: the two states differ in their ids and contents,
+ * so regsafe() has many reasons to keep them apart and disabling any single
+ * one of its checks does not make this fail.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void zext_unlinked_path_stays_reachable(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	if r6 >= 1 goto 2f;					\
+	/* explored first: r7 is a low-32 link of r8 */		\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	w7 = w8;		/* forms the link */		\
+	goto 1f;						\
+2:								\
+	/* runtime path: r7 unrelated to r8 */			\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	w7 = w0;		/* no link here */		\
+1:								\
+	if w8 != 0 goto 3f;	/* propagates to r7 only if linked */ \
+	if w7 == 0 goto 3f;					\
+	r0 /= 0;						\
+3:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Forming the link calls assign_scalar_id_before_mov(), which drops a delta
+ * link on the source. That is what the narrow-source path has always done,
+ * so a wide source behaves the same: r5 stops tracking r6.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_mov_breaks_add_const_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r5 = r6;		/* r5, r6 linked */		\
+	r5 += 3;		/* r5 = base + 3 */		\
+	w7 = w5;		/* breaks r5's delta link */	\
+	if r6 > 9 goto 1f;	/* r6 in [0, 9] */		\
+	if r5 < 13 goto 1f;	/* taken only if r5 still linked */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

