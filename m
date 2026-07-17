Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F63363C75
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263241; cv=none; b=qYLri/DYhN4mq5ZUKuBjF4D3F0BMsOc+272QWIAIRAZVBY2Q0OxR+5Vm02xHQ6CDGgMielfGeJ7S3kstID81/uhQUftakYRMbDb3YkUYxMlJ0odtrEuFG0ONU2cQNrwkbbSO36q1zk3w3dcG3S9wHoHu1o8tXvur3roaN1dbfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263241; c=relaxed/simple;
	bh=eaeOzPhNbhjmwab+TLvnh2U0euXJCf8ZbJh/xxxiXJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFVNz6sje6UjMmliLlhDxgDLRysi9lj9+HcQIzDsuV5lUggSEe97Kel7lbBQOKZj+Ba5J3vJp0uwhA5XIPVmXa7Jg+QtVG8MlHE2if0ogZyrBYXUvdpYco8233dH8HBWc4TQfhRL3eRq4yAXIvumgZz4k5vVX3JSCdIrQNeEeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YXhaOj6n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YXhaOj6n"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15c7d22070so968313266b.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263236; x=1784868036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hON4vTvUSgeP5fp0pSB5yhWw3IzBBWrCzYxGBHI4dEk=;
        b=YXhaOj6ngHOs5a+9Uh9x+CfzleZAamDsmcdWT7F48WQv0IYt5rcYFk6ePWJ4oJAFIL
         lkAX8F5aRRzqISctdktA/uJy2CpE37/udlwIF1q6hy4WhHwL7eCvZ6pW5LsK9/sL3AVm
         vusbVtRqYV/5vMXXL/Ms2pwpCQPNafIPRna481mTDCvX38HShRck7L35FRwibOlea5Eo
         WYJhTLrFgzcIuuhisFzp6c294cs3KkHC7mFcsMPOWXqnX2q3U4cFtRm11xW9ukL+1zTt
         mjg3uE2bAjPD9KUhgPLE2+b0KlOvv+s8OLVCn6tzyYvJ4C17dhaWbpzqK9jM3+TYrNNs
         Iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263236; x=1784868036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hON4vTvUSgeP5fp0pSB5yhWw3IzBBWrCzYxGBHI4dEk=;
        b=IwTbS38tDZWXRM4KuvDh+nhgJE91jJVyb5wzNXGLNvESxc39Oe1Q2zYYRNMMUZOAdM
         xt3Muyz7XjFEPCRHsBCSxptmoH7+T3WUPTHnSqTSlvChx8bbOy4C3fKy/fCfwSwtpqSZ
         8i5heqdqWsU2m4Rw6Qk4J758dnUYJPWVkomQHs0y4s++lV6rMA7afWUPb+rMg/bTVsKp
         aI6qYsCTL8wNpJxNUTUAms3+42YucgsmXzd1z9pf0wkbRo90fBypawHuM+GkzIsd+959
         lW8Syga+n6nTETOKG7ve0wurAkm2kXDTPINc0RDjHGn4J2lq099rEyZ0r8Xs3s3CDLAj
         Kdjg==
X-Gm-Message-State: AOJu0Yw4T/YSRKM4exw6zgMxyX9Us9I9NaVmUg6G26ifBOVKgreSbZUE
	WUNLXClg4mWUtWaoeFf2okxk33xhrRp0g/6h5s6K0wDAca8y04ll9b69y+gneqGTxXBNIjXL/k4
	7gT2A
X-Gm-Gg: AfdE7cmeJBVVH9nMShFj2fYBg5qB7lvh7ItQmntBMSERtSUiwTnGWni8h38ewXTHyEK
	oJrm3XbmCAiOevaFdM79UEQANyC9nspUZ0HYJgdl6pyGb6ZnghP3gWBPtzbjhnnFN4KpMWwlkzH
	PRFyrozR0/miEgqOlfia0yHAkNs5/dLa3vnB7V/HYz0nKcajTBVUQJOtkT3kersUfYi1p5cRpFo
	oxiUBdteol6ukJ9nEgUd88UQOz29HUBr9ROKZvPzbAQNZaPN1UcHR1qZYyV3rlJQntK6JZsAEvd
	I4Ia0uuzyLA7SNLfZwcjc9l9Q4qySzLSRICT5IVRNIZI6La1rKYVkV1cwM2E4MvN0Qf8D8CGLkV
	l7P+Gn9Z+l6NlzyZgMoQ5JGPsFE8NedqX7xLmtLOhB+Sy9Tbwr2P80xUIO8RYLoTstk2WwgWRCT
	yJHoH68zRdwauUsbqzaon8jSJQKozXlCQ=
X-Received: by 2002:a17:907:c70c:b0:c12:67d2:3d6b with SMTP id a640c23a62f3a-c16b4572384mr34072166b.11.1784263235699;
        Thu, 16 Jul 2026 21:40:35 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34490361sm3591205ad.17.2026.07.16.21.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:34 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 3/6] selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation
Date: Fri, 17 Jul 2026 12:40:02 +0800
Message-ID: <20260717044009.120224-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044009.120224-1-shung-hsi.yu@suse.com>
References: <20260717044009.120224-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit 4a04d13576fd69149b91672b5f1dc62eca272fa5 upstream.

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
Link: https://lore.kernel.org/r/20260319211507.213816-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 2ef346c827c2..87930b5e7b78 100644
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
2.54.0

