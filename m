Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B7369208
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157664; cv=none; b=ZdTbrVJdt24JaaopWUU+kR1JObkUN9FB+yNCE8cyD8OWRlrVPti2AoKGf32sZw4EcpRHD5TSkxVc65mXFVJn4D1t3g9+4HRlhDz7/7ItEIAtzdupLioN9r1woYyntw8t7N8OlbArahiH0FHnE53LQEXNN+7cPQF1pC6Rlh4qMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157664; c=relaxed/simple;
	bh=lgrudMdKvy3b6NrRagQ+ewFklMMPEm3FgR6V7s/Zn2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+wDHzTlakuhKXmQ349MXOPMgMNu4FEDEvlo4fRqQct1/y0FCXQOtT/KwpanTFT4+Ukc8ZV2jLqno13ihVV7vrPTdW+4FXmdxN81RrkYEHpiZ1W+gSwvLZ3au/yHDU+8J0X7wNV869LQX5w0TYM9zMuNX3XNLB8QZN3a5Zq0kak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPG+kvy+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPG+kvy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B06C116D0;
	Tue,  3 Feb 2026 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770157664;
	bh=lgrudMdKvy3b6NrRagQ+ewFklMMPEm3FgR6V7s/Zn2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPG+kvy+IESbT4u1YFGYkANMcaIw1zD7z+yTxIKhcCcmCR0bUfUiKwBr1y3ZTy69o
	 Tvq2n34PB8EIKoem25V36A6uIT6ffK8CYbMb4DcW3TjTAMmSvkMrcethu9bP0OGFhe
	 3IJ1rLEB4KZkkttny3QSO0CxPo+ceXqNmaDP/YyaNBEXI56HCsay2mZQOTvx8LW4Vx
	 7Pef7Jcy3zAROWPdwC5HcJMGSVEFFapKBRC0h02YrutjUOq8tyTUSJsrXx7MslPcMv
	 yAgeNjCSEP6fFp0wsSE/V3xh95eXJbJVs1zqO3hC7DzlXApzXYKcDfnTpoUX5NCUat
	 Uc53bM4yKK59w==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for improved linked register tracking
Date: Tue,  3 Feb 2026 14:26:18 -0800
Message-ID: <20260203222643.994713-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203222643.994713-1-puranjay@kernel.org>
References: <20260203222643.994713-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for linked register tracking with negative offsets, BPF_SUB,
and alu32. These test for all edge cases like overflows, etc.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/progs/verifier_linked_scalars.c       | 300 +++++++++++++++++-
 1 file changed, 298 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 5f41bbb730a7..5ff3983c48b7 100644
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
@@ -64,4 +65,299 @@ l0_%=:								\
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
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

