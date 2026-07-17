Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F03332623
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263237; cv=none; b=heCPvCkjl1d85iT0ssw0Tm8gwoZpfqml0vzIXZ00+0ZFOAqL+g8VAmdC9sx7dsjDwnRibMRr3f/ZnSiBG0GE+aA312mE2B813A/Bl990L5otrPJNRWawg8zVpZ+kFUUukHnbaUy76B3ASVoQo8EDe1TnG7XzWEsTdgGyVWtdYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263237; c=relaxed/simple;
	bh=zVCyASEPvhzKcGqvNlWhO2dvIQwypFq6egsDDvjHUic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQokxBN49IHjtwYj1clHlfB51Kf9tWJTqyOrnDdCeE6215p0Y5aOK92qQylfiigtUzytwXIbAlDznUmm+l2il3eVBI/OAbzpEkgmzog15ALZrwlrsPUOO4bRDF4aFCzKWLA8JKZGxIkWFCw+xd3P35aPJng9GGkTpkomci5J/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D1UuyYKB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D1UuyYKB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso11813989a12.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263230; x=1784868030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWhHskn44JPAeQCWDuvkM5k4hj2uXgmiPbT8xND1D/E=;
        b=D1UuyYKBgCjV5Bp0zpEL6uooT1cNgy3MqU5m9zJcq/qdI2Ira9qhX5Jq9M3z5r8Ww2
         oqRENQT39Wud6lxp4Wa6sTVB3y1v4Gvo2p67BWkGXqKIRwt+d1YwftsLuMY2/5r7Han6
         UUGB5j17+W8QcwoPovSA74a/foqknjrSuHqucNzdgoTTrKa+Ee+q3pdrfWmLadP+QI8e
         U9RE6ch3GH0yErFJ+I3q/LM68DBk19NlHm6hFXN8vo24X36J7p2yDS8v4UuCO3I9zP57
         oEYLOBErTJoNBHgN7sG4RfLgArA0msXdsEW/DxJxcZwhlok0sVs+8B30cN0WeIUpNo3S
         nggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263230; x=1784868030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWhHskn44JPAeQCWDuvkM5k4hj2uXgmiPbT8xND1D/E=;
        b=T6NNhSghuDBVSQK1ML1DVor5xLU1drDKN2lEStZTju2KypQKniaE3bFY7TDRMcju20
         ygZvGk0khhfEW4wDfkHKiX1ONeATslmvz8gSSik82D9IFCxvZMd695vET7x+TWpuAVz4
         KrrNwYJuIFfb5YhuS2q1lrjpjeBISizC4uK+p+QCnjN/69FzfSM9IQ38IuDieKEEzOAc
         kGJB5j37iUKn3ColvqSsS6Ki9R/4Yw9BHwrGMf2BOespwFtmJEzyFsSwoYM5+AW8d5UU
         JBGA3Cb0UO3pcg4V+w/rAJpbQJFKYWmJcecqJYmMFgh+f5gOb+9gbpw4CCjelcqFh2Cb
         xqtg==
X-Gm-Message-State: AOJu0YziLlt+mDaXAlklgDwKpMbgYv5trnpRdVn38HVmsSu0/AdiROLM
	IyaZoDsiKEf6kmzZ1v4+jO+KnB4YVC4aYICMXnVo8rEFcxikn8Gj+wd3XJPd89sEVPK7MbvQ6gs
	jraRa
X-Gm-Gg: AfdE7ckx8U+6ep3bIv6IKrfDjUyEYFN/7pYOHlSVUSyr7Xl6WR4kXqgyZOe+Y0Nx+IL
	0cVQ8aIqEG1gYjcky7TM6HZfVlOYnbyDcOGwIc/5cny0+BaeCm9vxzr/ht3XFl48WzAqwFLgqd0
	223e1DKCBJ91KV+YdqB5o1C5qVfgDGJ4cfoVgy9xxAydYW9a0OYucEXv2uS+dK00Qi7vZoRLBhD
	6PfDOGKWTHU0BLPCXNzXKRQ3zqvLwMCxi/UsDkMn8vLfBHmVxGTLuQfaTV6LnTjsuNtodRQhBJB
	xTeLCgFlGI5cy5idEuqO6ckt9Yf/ZjcDXWvh2kK9zpOKbBZZt9euGGCr+/pW+wuFNf78Dxim6Na
	H10GnST/psBUvAObvDw9QwyXLTL2MYROGWIh+8DziJVxAELNdDG/5QRr5pccXkDs91AGmbCGGCb
	q3J7GkkcXc03mzSp5wLAlsVhWworunuc0=
X-Received: by 2002:a17:907:ea7:b0:c16:64e5:1777 with SMTP id a640c23a62f3a-c16b469b866mr34022366b.17.1784263230206;
        Thu, 16 Jul 2026 21:40:30 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8ffcbsm249642a12.12.2026.07.16.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:28 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 2/6] selftests/bpf: Add tests for improved linked register tracking
Date: Fri, 17 Jul 2026 12:40:01 +0800
Message-ID: <20260717044009.120224-3-shung-hsi.yu@suse.com>
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

From: Puranjay Mohan <puranjay@kernel.org>

commit 47fcf4dc0a346dd0b873a679c547d6848bd85a37 upstream.

Add tests for linked register tracking with negative offsets, BPF_SUB,
and alu32. These test for all edge cases like overflows, etc.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260204151741.2678118-3-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 303 +++++++++++++++++-
 1 file changed, 301 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 5f41bbb730a7..2ef346c827c2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <limits.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -18,9 +19,9 @@ __naked void scalars(void)
 	r4 = r1;				\
 	w2 += 0x7FFFFFFF;			\
 	w4 += 0;				\
-	if r2 == 0 goto l1;			\
+	if r2 == 0 goto l0_%=;			\
 	exit;					\
-l1:						\
+l0_%=:						\
 	r4 >>= 63;				\
 	r3 = 1;					\
 	r3 -= r4;				\
@@ -64,4 +65,302 @@ l0_%=:								\
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__naked void scalars_neg(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += -4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same test but using BPF_SUB instead of BPF_ADD with negative immediate */
+SEC("socket")
+__success
+__naked void scalars_neg_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= 4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += -4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset using SUB */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 -= 4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Positive offset: r1 = r0 + 4, then if r1 >= 6, r0 >= 2, so r0 != 0 */
+SEC("socket")
+__success
+__naked void scalars_pos(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* SUB with negative immediate: r1 -= -4 is equivalent to r1 += 4 */
+SEC("socket")
+__success
+__naked void scalars_sub_neg_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= -4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Double ADD clears the ID (can't accumulate offsets) */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_double_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 2;					\
+	r1 += 2;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that sync_linked_regs() correctly handles large offset differences.
+ * r1.off = S32_MIN, r2.off = 1, delta = S32_MIN - 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_min];				\
+	r2 += 1;					\
+	if r2 s< 100 goto l0_%=;			\
+	if r1 s< 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_min]"i"(INT_MIN)
+	: __clobber_all);
+}
+
+/*
+ * Another large delta case: r1.off = S32_MAX, r2.off = -1.
+ * delta = S32_MAX - (-1) = S32_MAX + 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow_large_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_max];				\
+	r2 += -1;					\
+	if r2 s< 0 goto l0_%=;				\
+	if r1 s>= 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_max]"i"(INT_MAX)
+	: __clobber_all);
+}
+
+/*
+ * Test linked scalar tracking with alu32 and large positive offset (0x7FFFFFFF).
+ * After w1 += 0x7FFFFFFF, w1 wraps to negative for any r0 >= 1.
+ * If w1 is signed-negative, then r0 >= 1, so r0 != 0.
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_big_offset(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += 0x7FFFFFFF;				\
+	if w1 s>= 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_alu32_basic(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	w1 += 1;					\
+	if r1 > 10 goto 1f;				\
+	r0 >>= 32;					\
+	if r0 == 0 goto 1f;				\
+	r0 /= 0;					\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test alu32 linked register tracking with wrapping.
+ * R0 is bounded to [0xffffff00, 0xffffffff] (high 32-bit values)
+ * w1 += 0x100 causes R1 to wrap to [0, 0xff]
+ *
+ * After sync_linked_regs, if bounds are computed correctly:
+ *   R0 should be [0x00000000_ffffff00, 0x00000000_ffffff80]
+ *   R0 >> 32 == 0, so div by zero is unreachable
+ *
+ * If bounds are computed incorrectly (64-bit underflow):
+ *   R0 becomes [0xffffffff_ffffff00, 0xffffffff_ffffff80]
+ *   R0 >> 32 == 0xffffffff != 0, so div by zero is reachable
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_wrap(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 |= 0xffffff00;				\
+	r1 = r0;					\
+	w1 += 0x100;					\
+	if r1 > 0x80 goto l0_%=;			\
+	r2 = r0;					\
+	r2 >>= 32;					\
+	if r2 == 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+void alu32_negative_offset(void)
+{
+	volatile char path[5];
+	volatile int offset = bpf_get_prandom_u32();
+	int off = offset;
+
+	if (off >= 5 && off < 10)
+		path[off - 5] = '.';
+
+	/* So compiler doesn't say: error: variable 'path' set but not used */
+	__sink(path[0]);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

