Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471530B50C
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954920; cv=none; b=D8GlW1K0embDu9apDZZM+Su3lIX3Uozm9tn09aOIeaOnpytZmeoPNiDDqWv2qv2FlTJousYovkD4arNV0hxKKmbnfS/owc/eL2X46hOQyk0QVkNdrWXqu9RTOL1Euvh2PyI8AY/DBMyWlfD8DnL6Bv5M0k/fpHAFXAFag7UH4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954920; c=relaxed/simple;
	bh=wV155CRw38A/cQWhx0erfIduYazlPesJm/boBeLViRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPNWF6G9Jr39KN1SkGTpS7FpE/TEgxzskovsRaELF033x70obME6ywIm2wTJPyAIGesZJUI/F/zoi856tzwdJyrls+NgZNdmz6/TGGHenE72QQpBoGs1NFSQXPIZ3SP/eMcjZI9AAvsncxKtcPI00MZvOZ2eZgnzPMxdnXa12x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XvnVY8ZI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XvnVY8ZI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w6qOsEsJpgWFuvt0lKQW8/JL+DlrA4GT/zz3vb3Qo/g=; b=XvnVY8ZIsitcVXhLj6QhthYCvT
	TSQt5xwm43fu+Y8GiB1dmEFH0rW+bS5kT8+6UPyTOAkyNW22ZLXxmvcWbHUAkuACN90lS48EoZC+/
	p7r/Z5YK8dWY2+qo9OcDW+zqzo9GgUWysQt6TZAH12unKrWVOvsbwKsO5xEyfDAGxELsp1AXxW2CA
	fDFQj6U/SIkIHZ+AWhpp/AupV/DSrdSIImkgqoqXKuVwbuSf0ib0ufhrTR8vgNPA6zsCAFbfoeoXg
	jHFge2xleN7954CS49neG1O3Akn8S91fcEwYL3Vo9qQSVRYgJwHZrV8G1LxubYWO6+vdPWIVAqCNC
	TqD6Ab4g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3Khx-0000CE-0f;
	Thu, 19 Mar 2026 22:15:09 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	puranjay12@gmail.com,
	qguanni@gmail.com,
	ast@kernel.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation
Date: Thu, 19 Mar 2026 22:15:07 +0100
Message-ID: <20260319211507.213816-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319211507.213816-1-daniel@iogearbox.net>
References: <20260319211507.213816-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27945/Thu Mar 19 07:24:38 2026)

Add multiple test cases for linked register tracking with alu32 ops:

  - Add a test that checks sync_linked_regs() regarding reg->id (the linked
    target register) for BPF_ADD_CONST32 rather than known_reg->id (the
    branch register).

  - Add a test case for linked register tracking that exposes the cross-type
    sync_linked_regs() bug. One register uses alu32 (w7 += 1, BPF_ADD_CONST32)
    and another uses alu64 (r8 += 2, BPF_ADD_CONST64), both linked to the
    same base register.

  - Add a test case that exercises regsafe() path pruning when two execution
    paths reach the same program point with linked registers carrying
    different ADD_CONST flags (BPF_ADD_CONST32 from alu32 vs BPF_ADD_CONST64
    from alu64). This particular test passes with and without the fix since
    the pruning will fail due to different ranges, but it would still be
    useful to carry this one as a regression test for the unreachable div
    by zero.

With the fix applied all the tests pass:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  ./test_progs -t verifier_linked_scalars
  #602/1   verifier_linked_scalars/scalars: find linked scalars:OK
  #602/2   verifier_linked_scalars/sync_linked_regs_preserves_id:OK
  #602/3   verifier_linked_scalars/scalars_neg:OK
  #602/4   verifier_linked_scalars/scalars_neg_sub:OK
  #602/5   verifier_linked_scalars/scalars_neg_alu32_add:OK
  #602/6   verifier_linked_scalars/scalars_neg_alu32_sub:OK
  #602/7   verifier_linked_scalars/scalars_pos:OK
  #602/8   verifier_linked_scalars/scalars_sub_neg_imm:OK
  #602/9   verifier_linked_scalars/scalars_double_add:OK
  #602/10  verifier_linked_scalars/scalars_sync_delta_overflow:OK
  #602/11  verifier_linked_scalars/scalars_sync_delta_overflow_large_range:OK
  #602/12  verifier_linked_scalars/scalars_alu32_big_offset:OK
  #602/13  verifier_linked_scalars/scalars_alu32_basic:OK
  #602/14  verifier_linked_scalars/scalars_alu32_wrap:OK
  #602/15  verifier_linked_scalars/scalars_alu32_zext_linked_reg:OK
  #602/16  verifier_linked_scalars/scalars_alu32_alu64_cross_type:OK
  #602/17  verifier_linked_scalars/scalars_alu32_alu64_regsafe_pruning:OK
  #602/18  verifier_linked_scalars/alu32_negative_offset:OK
  #602/19  verifier_linked_scalars/spurious_precision_marks:OK
  #602     verifier_linked_scalars:OK
  Summary: 1/19 PASSED, 0 SKIPPED, 0 FAILED

Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 7bf7dbfd237d..f4f8a055af8a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -348,6 +348,114 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * Test that sync_linked_regs() checks reg->id (the linked target register)
+ * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_zext_linked_reg(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	w7 += 1;		/* alu32: r7.id |= BPF_ADD_CONST32 */ \
+	r8 = 0xFFFFffff ll;					\
+	if r6 < r8 goto l0_%=;					\
+	/* r6 in [0xFFFFFFFF, 0xFFFFFFFF] */			\
+	/* sync_linked_regs: known_reg=r6, reg=r7 */		\
+	/* CPU: w7 = (u32)(0xFFFFFFFF + 1) = 0, zext -> r7 = 0 */ \
+	/* With fix: r7 64-bit = [0, 0] (zext applied) */	\
+	/* Without fix: r7 64-bit = [0x100000000] (no zext) */	\
+	r7 >>= 32;						\
+	if r7 == 0 goto l0_%=;					\
+	r0 /= 0;		/* unreachable with fix */	\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that sync_linked_regs() skips propagation when one register used
+ * alu32 (BPF_ADD_CONST32) and the other used alu64 (BPF_ADD_CONST64).
+ * The delta relationship doesn't hold across different ALU widths.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void scalars_alu32_alu64_cross_type(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	w7 += 1;		/* alu32: BPF_ADD_CONST32, delta = 1 */ \
+	r8 = r6;		/* linked: same id as r6 */	\
+	r8 += 2;		/* alu64: BPF_ADD_CONST64, delta = 2 */ \
+	r9 = 0xFFFFffff ll;					\
+	if r7 < r9 goto l0_%=;					\
+	/* r7 = 0xFFFFFFFF */					\
+	/* sync: known_reg=r7 (ADD_CONST32), reg=r8 (ADD_CONST64) */ \
+	/* Without fix: r8 = zext(0xFFFFFFFF + 1) = 0 */	\
+	/* With fix: r8 stays [2, 0x100000001] (r8 >= 2) */	\
+	if r8 > 0 goto l1_%=;					\
+	goto l0_%=;						\
+l1_%=:								\
+	r0 /= 0;		/* div by zero */		\
+l0_%=:								\
+	r0 = 0;						\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that regsafe() prevents pruning when two paths reach the same program
+ * point with linked registers carrying different ADD_CONST flags (one
+ * BPF_ADD_CONST32 from alu32, another BPF_ADD_CONST64 from alu64).
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void scalars_alu32_alu64_regsafe_pruning(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	/* Get another random value for the path branch */	\
+	call %[bpf_get_prandom_u32];				\
+	if r0 > 0 goto l_pathb_%=;				\
+	/* Path A: alu32 */					\
+	w7 += 1;		/* BPF_ADD_CONST32, delta = 1 */\
+	goto l_merge_%=;					\
+l_pathb_%=:							\
+	/* Path B: alu64 */					\
+	r7 += 1;		/* BPF_ADD_CONST64, delta = 1 */\
+l_merge_%=:							\
+	/* Merge point: regsafe() compares path B against cached path A. */ \
+	/* Narrow r6 to trigger sync_linked_regs for r7 */	\
+	r9 = 0xFFFFffff ll;					\
+	if r6 < r9 goto l0_%=;					\
+	/* r6 = 0xFFFFFFFF */					\
+	/* sync: r7 = 0xFFFFFFFF + 1 = 0x100000000 */		\
+	/* Path A: zext -> r7 = 0 */				\
+	/* Path B: no zext -> r7 = 0x100000000 */		\
+	r7 >>= 32;						\
+	if r7 == 0 goto l0_%=;					\
+	r0 /= 0;		/* div by zero on path B */	\
+l0_%=:								\
+	r0 = 0;						\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 void alu32_negative_offset(void)
-- 
2.43.0

