Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7111E9B35;
	Fri, 10 Apr 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775824864; cv=none; b=LDu8Oph8A9EfG29RaafC56cqjF1tylUuIzdWLRw0QGeeMlrH2EHkF0yz8en8xhFzjwglatjmaC8jMh+/R3aLUWvw2awxlW9hbiQU7prhaArO1DMmhi3hCD5UICuu/31IvuQyHb1vbrWl+Qire01UKoJM//k/Xbf4bCeROsM8lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775824864; c=relaxed/simple;
	bh=WBacjSH+A9F+E3slIREWcDoBvyj0TxR4tQM+XW/yzlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPM6gZSzygbHtl2732Q3hSV6x0LFkDVj5AJThfncNdiOgAxCLqKlha9YE8aPyVvqUew0/cgUs10hzxCWtvvbaouthkf0nurOVKYnPWNG9usL+SCfRlPRq0DTUidKx5nGSFcVBhmtwg7X8qi6vkGDWL3SmsZLNXxr7Uim563nMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ANUF75UW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ANUF75UW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HxM0dEKEy7st/6YHEFqxDJptD4HoEs+gEovPMJRD5c0=; b=ANUF75UWcNiDPZ2zaAB1IEaYaO
	Qxygtl4iFodKeyoHcpUpFiOXLXVHqD77FFOTJOjQ3wsWC9nYUBkaCLmNKVZGNZRxLfId7Pc+J5kNm
	wWwv35aYeMXWt/ekdqnswe4UkzF3EgGyYRqr/DNfOIxODUbsPfx60JGifaO8K3J8Aczj5BbIdha6U
	BOlDPrD9am8qbB30UethCf7PRjRmXaxd4WxkIMLuSXeR6htQIgZlDzIbwiNahLxOuRmEfPYfEoqJb
	vO4ITKu9nIvII67KGdCmNgfwcMQb3VAjLXqt0PAdqA0Zm6mTJ+T4l0paa72m+Ft8L2v6ih8Lb5fYS
	R7ouaUkQ==;
Received: from [179.244.2.202] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wBBAJ-00EMz1-2q; Fri, 10 Apr 2026 14:40:51 +0200
From: Helen Koike <koike@igalia.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	yonghong.song@linux.dev,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	koike@igalia.com,
	kernel-dev@igalia.com
Subject: [PATCH 2/2] selftests/bpf: new cases handled by 32->64 range refinements
Date: Fri, 10 Apr 2026 09:40:28 -0300
Message-ID: <20260410124035.297632-2-koike@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410124035.297632-1-koike@igalia.com>
References: <20260410124035.297632-1-koike@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

1. u64 range where the lo32 of each endpoint falls outside the u32
   range within its 2^32 block, requiring umin/umax to advance to an
   adjacent block. Three variants:
   - range entirely below S64_MAX;
   - s64 range spanning negative and positive values to exercise
     smin/smax advance;
   - u64 range crossing the sign boundary: smin/smax stay conservative
     at S64_MIN/S64_MAX.

2. 32-bit range crosses the U32_MAX/0 boundary, represented as s32
   range crossing sign boundary.

3. s32-bit range wraps, but u32 has a tighter lower bound from an
   unsigned comparison.

Co-developed-by: Helen Koike <koike@igalia.com>
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

---

This patch was cherry-picked from:
    https://lore.kernel.org/bpf/20260318-cnum-sync-bounds-v1-4-1f2e455ea711@gmail.com/

I added three other test cases and renamed a test to follow a pattern with
the others (and updated commit message).

Some of these extra tests were added due to cases I found while
implementing the version without the circular range logic[1], so I kept
them here (I guess some extra tests won't hurt).

[1] https://github.com/helen-fornazier/linux/commits/bpf-min-max-if-else-solution/
---
 .../selftests/bpf/progs/verifier_bounds.c     | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bb20f0f06f05..a0178207c186 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2165,4 +2165,181 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/*
+ * 64-bit range is outside the 32-bit range in each 2^32 block.
+ *
+ * This test triggers updates on umin/umax and smin/smax.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||----|=====|--|----------||----|=====|-------------||--|-|=====|-------------||
+ *       |< b >|  |                |< b >|                 | |< b >|
+ *                |                |     |                 |
+ *                |<---------------+- a -+---------------->|
+ *                                 |     |
+ *                                 |< t >| refined r0 range
+ *
+ * a = u64 [0x1'00000008, 0x3'00000001]
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000008 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x300000001 ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000008, 0x3'00000001] */	\
+	if w0 < 2 goto 2f;						\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */			\
+	r2 = 0x200000002 ll;						\
+	r3 = 0x200000005 ll;						\
+	if r0 >= r2 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r3 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Similar to the deduce64_from_32_block_change test for smin/smax boundaries.
+ *
+ * a = s64 [0x8000000100000008, 0x0000000300000001]  (crosses sign boundary)
+ * b = u32 [2, 5]
+ * t = s64 [0x8000000200000002, 0x0000000200000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change_signed(void *ctx)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = 0x8000000100000008 ll;				\
+	if r0 s< r1 goto 2f;					\
+	r1 = 0x300000001 ll;					\
+	if r0 s> r1 goto 2f;	/* s64: [0x8000000100000008, 0x3'00000001] */ \
+	if w0 < 2 goto 2f;					\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */		\
+	r2 = 0x8000000200000002 ll;				\
+	r3 = 0x200000005 ll;					\
+	if r0 s>= r2 goto 1f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+1:	if r0 s<= r3 goto 2f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+2:	exit;							\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Similar to the deduce64_from_32_block_change test, with conservative signed boundaries.
+ *
+ * a = u64 [0x1'00000008, 0x80000003'00000001]
+ *   = s64 [S64_MIN, S64_MAX] (since (s64)umin > (s64)umax)
+ * b = u32 [2, 5]
+ * t = u64 [0x2'00000002, 0x80000002'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_block_change_conservative_signed(void *ctx)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r1 = 0x100000008 ll;					\
+	if r0 < r1 goto 2f;					\
+	r1 = 0x8000000300000001 ll;				\
+	if r0 > r1 goto 2f;	/* u64: [0x100000008, 0x8000000300000001] */ \
+	if w0 < 2 goto 2f;					\
+	if w0 > 5 goto 2f;	/* u32: [2, 5] */		\
+	r2 = 0x200000002 ll;					\
+	r3 = 0x8000000200000005 ll;				\
+	if r0 >= r2 goto 1f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+1:	if r0 <= r3 goto 2f;	/* should be always true */	\
+	r10 = 0;		/* dead code */			\
+2:	exit;							\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * 32-bit range crossing U32_MAX / 0 boundary.
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||===|---------|------|===||===|----------------|===||===|---------|------|===||
+ *  |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
+ *                |      |                                  |         |
+ *                |<-----+----------------- a --------------+-------->|
+ *                       |                                  |
+ *                       |<---------------- t ------------->| refined r0 range
+ *
+ * a = u64 [0x1'00000006, 0x2'FFFFFFEF]
+ * b = s32 [-16, 5] (u32 wrapping [0xFFFFFFF0, 0x00000005])
+ * t = u64 [0x1'FFFFFFF0, 0x2'00000005]
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_wrapping_32bit(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x100000006 ll;						\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x2ffffffef ll;						\
+	if r0 > r1 goto 2f;	/* u64: [0x1'00000006, 0x2'FFFFFFEF] */	\
+	if w0 s< -16 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-16, 5] */			\
+	r1 = 0x1fffffff0 ll;						\
+	r2 = 0x200000005 ll;						\
+	if r0 >= r1 goto 1f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+1:	if r0 <= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * s32 range wraps, but u32 has a tighter lower bound from an unsigned
+ * comparison.
+ *
+ * a = u64 [0x7FFFFFFF'00000001, 0x80000002'00000010]
+ * b = s32 [-5, 5] + w0 u>= 2  =>  u32: [2, U32_MAX]
+ * t = u64 [0x7FFFFFFF'00000002, ...]
+ */
+SEC("socket")
+__success __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void deduce64_from_32_u32_tighter_than_s32(void *ctx)
+{
+	asm volatile ("							\
+	call %[bpf_get_prandom_u32];					\
+	r1 = 0x7fffffff00000001 ll;					\
+	if r0 < r1 goto 2f;						\
+	r1 = 0x8000000200000010 ll;					\
+	if r0 > r1 goto 2f;	/* u64: [0x7FFFFFFF'00000001, 0x80000002'00000010] */	\
+	if w0 s< -5 goto 2f;						\
+	if w0 s> 5 goto 2f;	/* s32: [-5, 5] */			\
+	if w0 < 2 goto 2f;	/* u32_min=2; s32 still wraps */	\
+	r2 = 0x7fffffff00000002 ll;					\
+	if r0 >= r2 goto 2f;	/* should be always true */		\
+	r10 = 0;		/* dead code */				\
+2:	exit;								\
+	"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

