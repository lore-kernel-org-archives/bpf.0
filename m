Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4B2D7D3A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767347; cv=none; b=bglXGfFK1fd2JGJ82mMXA24SRArAwLUGibqTobUYyFce2+E+Y72pyfsbMDiHd71CRxQVYcBwSgSS6ncVzrcOMDgl5dG/K7Qhx9l6i9/C0MfSFYz/P1AGmichrOn2vTe2bWrnpkg/RBxEUE6GCK0yo+R+pbgolBkrSqRI134+2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767347; c=relaxed/simple;
	bh=NN1gMV+vgLt3fJImbJvvcPyY0Sy+sgzVvfpBJhicvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYmHUcsDvU0T2fremN6lECVjLwUMRE/3uU5BaZlDbEhMOt8y1CU8543xZbRFGOAIM7csyZv9p1CxuZ+se3IttPU+J4RXK0DUX0D+1QNNoDUGbZR0GdCBj6UXqNyH4OR6CVqmODdBT5k5KZ2GXZ/gdsyYk41waJDBNVdxb5mP79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWjYtex/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWjYtex/"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f69a286dbso3186958b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767345; x=1777372145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXm5mKNp2nUSzKXvxADPbnt81P75uMeC7TG4Tx3h1qs=;
        b=KWjYtex/z0jX6MHyQisfDyGzD+bsP94Jp97XEZO0dBcG5OzK8PwShafRaPtL6xdKwg
         hDeLfrTIHZCAvBQTsSqvmmDqJvTOoyaTnZ03LqmYJp9Sa+xFbaqJaCTn3W/1y0iMcGrj
         YzO0MFbK51i4zU2XN+XoT320ctaxh6mMhCpSTWYvoVS9y0JWLs1Wt3LG5Z6XyaAYMxjY
         YpIQoVZrnAjB3IRhgOt3LxmuycmrZZizwhQYMSM56j36/3ODhq1WaGu1AKiXTcbVU72F
         eqyqe1mMZIUWG8g4tf3HMf/wr42UbSJ1OyCiRNFJcB0VM61kmkzJCwd4XMLgryve/wTV
         bB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767345; x=1777372145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXm5mKNp2nUSzKXvxADPbnt81P75uMeC7TG4Tx3h1qs=;
        b=Oh3IRm8y3hp28FMnGVE1zQklj+0PwQJItxWJrBrp37zMk0AbYzAykivhgV5PTvPG3b
         LYuBZPeVBWOgAOPjchdg0EwzNY2TOQJTpSOQYuWoCV+vf0x5b5ehZJSdbGGm/y2lT2or
         ZrkIpRHWEPgqB69EmL5OFHMyN0In1EpWuj7RLdJ/I+EWY9JG9nArQkRSbCDl9jwMaYnX
         87f4hRzp7T9znurQZbU7SjXMW6QSw0t5cCCfMysFWvOJL86+gXSeZRJf2VUf22YsGv42
         V2arYHWBZM1V6s6SVDxRN1V89j2xKQv/PnKDXjjI2FpFMEJd8/kJFJlXg9NdMRspzeGU
         DaxA==
X-Gm-Message-State: AOJu0YwHWB0H3l9I/tWCVf/JkzDxSt/mgeGoYfuyTgf8n4NJL0cbLs18
	KX3wxqXTbWvdYweoUaseQtFnZTCMYnb5MoURtWCuQ/euGUVevD+uiHPv1pNJYdWz
X-Gm-Gg: AeBDietidPkFa1WGH0e57/ysyIIvWUu5kq3dOTLcyI3QBn0vur0y3BHd51CL5eHz3jH
	Wzj1DeQQrNwTlKiRNLCyT7Rf6QCDp8fnWC4NA3RCpoDpijGtn7XTmR8v566cWE6I91LiH4i/Om5
	2HNECJ0uA7nwhG6bk8TDH1UInofbuwH5YK+Xo1HfvvCug62mxkQ6HXU7frSxFsdnt2ByQgPc436
	yxWxq/vLnWiZqjWYGc0UyxOeGSMxySf3Y2AJ0PLdlzcSJN3vw3YPjzm40IdVpxomRI7UUPEH/rn
	ojIlYF+lHN5sLFy9Tj9OwQGNquC90Nu1HvzGIaB3nOM4ygigjezNXrSLiKmAdokMt1sQfcPz7/0
	b6QcZS6VKByOWe/8h1u5AO+Fe7JO/QpPaStBf6Nq9coKllbhwSO32FZGbUBAr+kQufccwfN/2Yl
	pDcIIc3u2nRPfgkpJ5NQl4udhTEQxS/LgeChSXLODF2H1d6nqDBIfCuPsyPgR9yWtd8MTdi+gXZ
	94DTg==
X-Received: by 2002:a05:6a00:1995:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-82f8c84b34emr18257191b3a.19.1776767344590;
        Tue, 21 Apr 2026 03:29:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm16135000b3a.1.2026.04.21.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:29:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com
Subject: [PATCH RFC bpf-next 1/4] bpf: representation and basic operations on circular numbers
Date: Tue, 21 Apr 2026 03:28:49 -0700
Message-ID: <20260421-cnums-everywhere-rfc-v1-v1-1-8f8e98537f48@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This commit adds basic definitions for cnum32/cnum64.
This is a unified numeric range representation for signed and unsigned
domains. Inspired by an old post from Shung-Hsi Yu [1] and paper [2].
Operations correctness is verified using cbmc model checker,
tests source code can be found in a separate repo [3].

The cnum64_cnum32_intersect() function is notable, because it handled
several cases verifier.c:deduce_bounds_64_from_32() does not.
Given:
- a is a 64-bit range
- b is a 32-bit range
- t is a refined 64-bit range, such that ∀ v ∈ a, (u32)a ∈ b: v ∈ t.
cnum64_cnum32_intersect() makes the following deductions:

(A): 'b' is a sub-range of the first or the last 32-bit
     sub-range of 'a':

                                                         64-bit number axis --->

 N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
 ||------|---|=====|-------||----------|=====|-------||----------|=====|----|--||
         |   |< b >|                   |< b >|                   |< b >|    |
         |   |                                                         |    |
         |<--+--------------------------- a ---------------------------+--->|
             |                                                         |
             |<-------------------------- t -------------------------->|

(B) 'b' does not intersect with the first of the last 32-bit
    sub-range of 'a':

N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
||--|=====|----|----------||--|=====|---------------||--|=====|------------|--||
    |< b >|    |              |< b >|                   |< b >|            |
               |              |                               |            |
               |<-------------+--------- a -------------------|----------->|
                              |                               |
                              |<-------- t ------------------>|

(C) 'b' crosses 0/U32_MAX boundary:

N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
||===|---------|------|===||===|----------------|===||===|---------|------|===||
 |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
               |      |                                  |         |
               |<-----+----------------- a --------------+-------->|
                      |                                  |
                      |<---------------- t ------------->|

Current implementation of deduce_bounds_64_from_32() only handles
case (A).

[1] https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
[2] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
[3] https://github.com/eddyz87/cnum-verif/tree/master

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/cnum.h   |  76 +++++++++
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/cnum.c      | 114 +++++++++++++
 kernel/bpf/cnum_defs.h | 432 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 623 insertions(+), 1 deletion(-)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
new file mode 100644
index 000000000000..6fe3f4611c5e
--- /dev/null
+++ b/include/linux/cnum.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _LINUX_CNUM_H
+#define _LINUX_CNUM_H
+
+#include <linux/types.h>
+
+/*
+ * cnum32: a circular number.
+ * A unified representation for signed and unsigned ranges.
+ *
+ * Assume that a 32-bit range is a circle, with 0 being in the 12 o'clock
+ * position, numbers placed sequentially in clockwise order and U32_MAX
+ * in the 11 o'clock position. Signed values map onto the same circle:
+ * S32_MAX sits at 5 o'clock, S32_MIN sits at 6 o'clock (opposite 0),
+ * negative values occupy the left half and positive values the right half.
+ *
+ * @cnum32 represents an arc on this circle drawn clockwise.
+ * @base corresponds to the first value of the range.
+ * @size corresponds to the number of integers in the range excluding @base.
+ * (The @base is excluded to avoid integer overflow when representing the full
+ *  0..U32_MAX range, which corresponds to 2^32, which can't be stored in u32).
+ *
+ * For example: {U32_MAX, 1} corresponds to signed range [-1, 0],
+ *              {S32_MAX, 1} corresponds to unsigned range [S32_MAX, S32_MIN].
+ */
+struct cnum32 {
+	u32 base;
+	u32 size;
+};
+
+#define CNUM32_UNBOUNDED ((struct cnum32){ .base = 0, .size = U32_MAX })
+#define CNUM32_EMPTY ((struct cnum32){ .base = U32_MAX, .size = U32_MAX })
+
+struct cnum32 cnum32_from_urange(u32 min, u32 max);
+struct cnum32 cnum32_from_srange(s32 min, s32 max);
+u32 cnum32_umin(struct cnum32 cnum);
+u32 cnum32_umax(struct cnum32 cnum);
+s32 cnum32_smin(struct cnum32 cnum);
+s32 cnum32_smax(struct cnum32 cnum);
+struct cnum32 cnum32_intersect(struct cnum32 a, struct cnum32 b);
+bool cnum32_contains(struct cnum32 cnum, u32 v);
+bool cnum32_is_const(struct cnum32 cnum);
+bool cnum32_is_empty(struct cnum32 cnum);
+struct cnum32 cnum32_add(struct cnum32 a, struct cnum32 b);
+struct cnum32 cnum32_mul(struct cnum32 a, struct cnum32 b);
+struct cnum32 cnum32_negate(struct cnum32 a);
+
+/* Same as cnum32 but for 64-bit ranges */
+struct cnum64 {
+	u64 base;
+	u64 size;
+};
+
+#define CNUM64_UNBOUNDED ((struct cnum64){ .base = 0, .size = U64_MAX })
+#define CNUM64_EMPTY ((struct cnum64){ .base = U64_MAX, .size = U64_MAX })
+
+struct cnum64 cnum64_from_urange(u64 min, u64 max);
+struct cnum64 cnum64_from_srange(s64 min, s64 max);
+u64 cnum64_umin(struct cnum64 cnum);
+u64 cnum64_umax(struct cnum64 cnum);
+s64 cnum64_smin(struct cnum64 cnum);
+s64 cnum64_smax(struct cnum64 cnum);
+struct cnum64 cnum64_intersect(struct cnum64 a, struct cnum64 b);
+bool cnum64_contains(struct cnum64 cnum, u64 v);
+bool cnum64_is_const(struct cnum64 cnum);
+bool cnum64_is_empty(struct cnum64 cnum);
+struct cnum64 cnum64_add(struct cnum64 a, struct cnum64 b);
+struct cnum64 cnum64_mul(struct cnum64 a, struct cnum64 b);
+struct cnum64 cnum64_negate(struct cnum64 a);
+
+struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
+struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b);
+
+#endif /* _LINUX_CNUM_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 399007b67a92..4dc41bf5780c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o const_fold.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
new file mode 100644
index 000000000000..38a805a6fc2a
--- /dev/null
+++ b/kernel/bpf/cnum.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bits.h>
+
+#define T 32
+#include "cnum_defs.h"
+#undef T
+
+#define T 64
+#include "cnum_defs.h"
+#undef T
+
+struct cnum32 cnum32_from_cnum64(struct cnum64 cnum)
+{
+	if (cnum.size > U32_MAX)
+		return (struct cnum32){ .base = 0, .size = U32_MAX };
+	else
+		return (struct cnum32){ .base = (u32)cnum.base, .size = cnum.size };
+}
+
+/*
+ * Suppose 'a' and 'b' are laid out as follows:
+ *
+ *                                                          64-bit number axis --->
+ *
+ * N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
+ * ||------|---|=====|-------||----------|=====|-------||----------|=====|----|--||
+ *         |   |< b >|                   |< b >|                   |< b >|    |
+ *         |   |                                                         |    |
+ *         |<--+--------------------------- a ---------------------------+--->|
+ *             |                                                         |
+ *             |<-------------------------- t -------------------------->|
+ *
+ * In such a case it is possible to infer a more tight representation t
+ * such that ∀ v ∈ a, (u32)a ∈ b: v ∈ t.
+ */
+struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b)
+{
+	/*
+	 * To simplify reasoning, rotate the circles so that [virtual] a1 starts
+	 * at u32 boundary, b1 represents b in this new frame of reference.
+	 */
+	struct cnum32 b1 = { b.base - (u32)a.base, b.size };
+	struct cnum64 t = a;
+	u64 d, b1_max;
+
+	if (cnum32_urange_overflow(b1)) {
+		b1_max = (u32)b1.base + (u32)b1.size; /* overflow here is fine and necessary */
+		if ((u32)a.size > b1_max && (u32)a.size < b1.base) {
+			/*
+			 * N*2^32                   (N+1)*2^32
+			 * ||=====|------------|=====||=====|---------|---|=====||
+			 *  |b1 ->|            |<- b1||b1 ->|         |   |<- b1|
+			 *  |<----------------- a1 ------------------>|
+			 *  |<-------------- t ------------>|<-- d -->| (after adjustment)
+			 *                                  ^
+			 *                                b1_max
+			 */
+			d = (u32)a.size - b1_max;
+			t.size -= d;
+		} else {
+			/*
+			 * No adjustments possible in the following cases:
+			 *
+			 * ||=====|------------|=====||===|=|-------------|=|===||
+			 *  |b1 ->|            |<- b1||b1 +>|             |<+ b1|
+			 *  |<----------------- a1 ------>|                 |
+			 *  |<----------------- (or) a1 ------------------->|
+			 */
+		}
+	} else {
+		if (t.size < b1.base)
+			/*
+			 * N*2^32                   (N+1)*2^32
+			 * ||----------|--|=======|--||------>
+			 *  |<-- a1 -->|  |<- b ->|
+			 */
+			return CNUM64_EMPTY;
+		/*
+		 * N*2^32                   (N+1)*2^32
+		 * ||-------------|========|-||-----| -------|========|-||
+		 *  |             |<- b1 ->|        |        |<- b1 ->|
+		 *  |<------------+ a1 ------------>|
+		 *                |<------ t ------>| (after adjustment)
+		 */
+		t.base += b1.base;
+		t.size -= b1.base;
+		b1_max = b1.base + b1.size;
+		d = 0;
+		if ((u32)a.size < b1.base)
+			/*
+			 * N*2^32                   (N+1)*2^32
+			 * ||-------------|========|-||------|-------|========|-||
+			 *  |             |<- b1 ->|         |       |<- b1 ->|
+			 *  |<------------+-- a1 --+-------->|
+			 *                |<- t  ->|<-- d -->| (after adjustment)
+			 */
+			d = (u32)a.size + (BIT_ULL(32) - b1_max);
+		else if ((u32)a.size >= b1_max)
+			/*
+			 * N*2^32                   (N+1)*2^32
+			 * ||--|========|------------||--|========|-------|-----||
+			 *  |  |<- b1 ->|                |<- b1 ->|       |
+			 *  |<-+------------------ a1 ------------+------>|
+			 *     |<-------------- t --------------->|<- d ->| (after adjustment)
+			 */
+			d = (u32)a.size - b1_max;
+		if (t.size < d)
+			return CNUM64_EMPTY;
+		t.size -= d;
+	}
+	return t;
+}
diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
new file mode 100644
index 000000000000..28dcb79ba695
--- /dev/null
+++ b/kernel/bpf/cnum_defs.h
@@ -0,0 +1,432 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef T
+#error "Define T (bit width: 32, 64) before including cnum_defs.h"
+#endif
+
+#include <linux/cnum.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/compiler_types.h>
+
+#if T == 32
+#define ut2 u64
+#define st2 s64
+#define utt u32
+#define stt s32
+#define EMPTY CNUM32_EMPTY
+#elif T == 64
+#define ut2 unsigned __int128
+#define st2 signed __int128
+#define utt u64
+#define stt s64
+#define EMPTY CNUM64_EMPTY
+#else
+#error "Unsupported T value, cannot define ut2/st2"
+#endif
+
+#define cnum_t  __PASTE(cnum, T)
+#define ut      __PASTE(u, T)
+#define st      __PASTE(s, T)
+#define UT_MAX  __PASTE(__PASTE(U, T), _MAX)
+#define ST_MAX  __PASTE(__PASTE(S, T), _MAX)
+#define ST_MIN  __PASTE(__PASTE(S, T), _MIN)
+#define FN(name) __PASTE(__PASTE(cnum, T), __PASTE(_, name))
+
+struct cnum_t FN(from_urange)(ut min, ut max)
+{
+	return (struct cnum_t){ .base = min, .size = (utt)max - min };
+}
+
+struct cnum_t FN(from_srange)(st min, st max)
+{
+	ut size = (ut)max - (ut)min;
+	ut base = size == UT_MAX ? 0 : (ut)min;
+
+	return (struct cnum_t){ .base = base, .size = size };
+}
+
+/* True if this cnum represents two unsigned ranges. */
+static inline bool FN(urange_overflow)(struct cnum_t cnum)
+{
+	/* Same as cnum.base + cnum.size > UT_MAX but avoids overflow */
+	return cnum.size > UT_MAX - (utt)cnum.base;
+}
+
+/*
+ * cnum{T}_umin / cnum{T}_umax query an unsigned range represented by this cnum.
+ * If cnum represents a range crossing the UT_MAX/0 boundary, the unbound range
+ * [0..UT_MAX] is returned.
+ */
+ut FN(umin)(struct cnum_t cnum)
+{
+	return FN(urange_overflow)(cnum) ? 0 : cnum.base;
+}
+
+ut FN(umax)(struct cnum_t cnum)
+{
+	return FN(urange_overflow)(cnum) ? UT_MAX : cnum.base + cnum.size;
+}
+
+/* True if this cnum represents two signed ranges. */
+static inline bool FN(srange_overflow)(struct cnum_t cnum)
+{
+	return FN(contains)(cnum, (ut)ST_MAX) && FN(contains)(cnum, (ut)ST_MIN);
+}
+
+/*
+ * cnum{T}_smin / cnum{T}_smax query a signed range represented by this cnum.
+ * If cnum represents a range crossing the ST_MAX/ST_MIN boundary, the unbound range
+ * [ST_MIN..ST_MAX] is returned.
+ */
+st FN(smin)(struct cnum_t cnum)
+{
+	return FN(srange_overflow)(cnum)
+	       ? ST_MIN
+	       : min((st)cnum.base, (st)(cnum.base + cnum.size));
+}
+
+st FN(smax)(struct cnum_t cnum)
+{
+	return FN(srange_overflow)(cnum)
+	       ? ST_MAX
+	       : max((st)cnum.base, (st)(cnum.base + cnum.size));
+}
+
+/*
+ * If there exists a cnum representing an intersection of cnums 'a' and 'b',
+ * returns this intersection in 'out' and returns true.
+ * If such cnum does not exist:
+ * - if intersection is empty, returns false.
+ * - if intersection produces two ranges, returns smaller of
+ *   'a' or 'b' in 'out'.
+ */
+struct cnum_t FN(intersect)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t b1;
+	ut dbase;
+
+	if (FN(is_empty)(a) || FN(is_empty)(b))
+		return EMPTY;
+
+	if (a.base > b.base)
+		swap(a, b);
+
+	/*
+	 * Rotate frame of reference such that a.base is 0.
+	 * 'b1' is 'b' in this frame of reference.
+	 */
+	dbase = b.base - a.base;
+	b1 = (struct cnum_t){ dbase, b.size };
+	if (FN(urange_overflow)(b1)) {
+		if (b1.base <= a.size) {
+			/*
+			 * Rotated frame (a.base at origin):
+			 *
+			 * 0                                       UT_MAX
+			 * |--------------------------------------------|
+			 * [=== a ==========================]           |
+			 * [= b1 tail =]  [========= b1 main ==========>]
+			 *                 ^-- b1.base <= a.size
+			 *
+			 * 'a' and 'b' intersect in two disjoint arcs,
+			 * can't represent as single cnum, over-approximate
+			 * the result.
+			 */
+			return a.size <= b.size ? a : b;
+		} else {
+			/*
+			 * Rotated frame (a.base at origin):
+			 *
+			 * 0                                       UT_MAX
+			 * |--------------------------------------------|
+			 * [=== a =============]  |                     |
+			 * [= b1 tail =]          [======= b1 main ====>]
+			 *                         ^-- b1.base > a.size
+			 *
+			 * Only 'b' tail intersects 'a'.
+			 */
+			return (struct cnum_t) {
+				.base = a.base,
+				.size = min(a.size, (ut)(b1.base + b1.size)),
+			};
+		}
+	} else if (a.size >= b1.base) {
+		/*
+		 * Rotated frame (a.base at origin):
+		 *
+		 * 0                                             UT_MAX
+		 * |--------------------------------------------------|
+		 * [=== a ==================================]         |
+		 *                   [== b1 =====================]
+		 *
+		 * 0                                             UT_MAX
+		 * |--------------------------------------------------|
+		 * [=== a ==================================]         |
+		 *                   [== b1 ====]
+		 *                   ^-- b1.base <= a.size
+		 *                   |<-- a.size - dbase -->|
+		 *
+		 * 'a' and 'b' intersect as one cnum.
+		 */
+		return (struct cnum_t) {
+			.base = b.base,
+			.size = min((ut)(a.size - dbase), b.size),
+		};
+	} else {
+		return EMPTY;
+	}
+}
+
+static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
+{
+	if (cnum.size == UT_MAX && cnum.base != 0 && cnum.base != (ut)ST_MAX)
+		cnum.base = 0;
+	return cnum;
+}
+
+struct cnum_t FN(add)(struct cnum_t a, struct cnum_t b)
+{
+	if (FN(is_empty)(a) || FN(is_empty)(b))
+		return EMPTY;
+	if (a.size > UT_MAX - b.size)
+		return (struct cnum_t){ 0, (utt)UT_MAX };
+	else
+		return FN(normalize)((struct cnum_t){ a.base + b.base, a.size + b.size });
+}
+
+struct cnum_t FN(negate)(struct cnum_t a)
+{
+	if (FN(is_empty)(a))
+		return EMPTY;
+	return FN(normalize)((struct cnum_t){ -((utt)a.base + a.size), a.size });
+}
+
+bool FN(is_empty)(struct cnum_t cnum)
+{
+	return cnum.base == EMPTY.base && cnum.size == EMPTY.size;
+}
+
+bool FN(contains)(struct cnum_t cnum, ut v)
+{
+	if (FN(is_empty)(cnum))
+		return false;
+	if (FN(urange_overflow)(cnum))
+		return v >= cnum.base || v <= (ut)((utt)cnum.base + cnum.size);
+	else
+		return v >= cnum.base && v <= (ut)((utt)cnum.base + cnum.size);
+}
+
+bool FN(is_const)(struct cnum_t cnum)
+{
+	return cnum.size == 0;
+}
+
+/* true if every value in b is also in a */
+static inline bool FN(contains_cnum)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t b1;
+
+	if (FN(is_empty)(a) || FN(is_empty)(b))
+		return FN(is_empty)(a) && FN(is_empty)(b);
+	b1 = (struct cnum_t){ b.base - a.base, b.size };
+	if (FN(urange_overflow)(b1))
+		return a.size == UT_MAX;
+	return b1.base + b1.size <= a.size;
+}
+
+static inline struct cnum_t FN(complement)(struct cnum_t cnum)
+{
+	if (FN(is_empty)(cnum))
+		return (struct cnum_t){ 0, UT_MAX };
+	if (cnum.size == UT_MAX)
+		return EMPTY;
+	return (struct cnum_t){
+		.base = (ut)(cnum.base + cnum.size + 1),
+		.size = (ut)(UT_MAX - cnum.size - 1),
+	};
+}
+
+/* Gap from a's right end clockwise to b's start in a's frame. */
+static inline struct cnum_t FN(gap)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t b1;
+	ut x;
+
+	if (FN(is_empty)(a) || FN(is_empty)(b))
+		return EMPTY;
+	b1 = (struct cnum_t){ b.base - a.base, b.size };
+	/* a contains b.base */
+	if (b1.base <= a.size)
+		return EMPTY;
+	/* b wraps in a's frame, its tail covers the gap */
+	if (FN(urange_overflow)(b1))
+		return EMPTY;
+	x = (ut)(a.base + a.size + 1);
+	if (x == b.base)
+		return EMPTY;
+	return (struct cnum_t){ x, (ut)(b.base - x - 1) };
+}
+
+/* Extend a to also cover b, keeping a.base fixed. */
+static inline struct cnum_t FN(extend)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t b1;
+
+	if (FN(is_empty)(a))
+		return b;
+	if (FN(is_empty)(b))
+		return a;
+	b1 = (struct cnum_t){ b.base - a.base, b.size };
+	/* b in a's frame wraps past UT_MAX: must cover everything from a.base */
+	if (FN(urange_overflow)(b1))
+		return FN(normalize)((struct cnum_t){ a.base, UT_MAX });
+	/* extend a's right bound to the further of a's or b's end */
+	return FN(normalize)((struct cnum_t){ a.base, max(a.size, (ut)(b1.base + b1.size)) });
+}
+
+static inline struct cnum_t FN(bigger)(struct cnum_t a, struct cnum_t b)
+{
+	if (FN(is_empty)(a))
+		return b;
+	if (FN(is_empty)(b))
+		return a;
+	return a.size >= b.size ? a : b;
+}
+
+/*
+ * Compute the tightest single cnum over-approximating the union of all arcs.
+ * Arcs are assumed to be sorted by cnum[*].base in ascending order.
+ *
+ * Strategy: find the largest gap between arcs on the circular number line,
+ * then return its complement. The result is the smallest arc that covers
+ * all input arcs.
+ */
+static struct cnum_t FN(union)(struct cnum_t *cnum, u32 cnt)
+{
+	struct cnum_t dzone = EMPTY, g = EMPTY;
+	u32 i;
+
+	/* Seed dzone with all wrapping arcs (crossing the UT_MAX/0 boundary). */
+	for (i = 0; i < cnt; i++)
+		if (FN(urange_overflow)(cnum[i]))
+			dzone = FN(extend)(dzone, cnum[i]);
+
+	/*
+	 * Scan arcs left to right, extending dzone to cover each one.
+	 * Before absorbing each arc, record the gap between dzone's
+	 * right edge and the arc's left edge; keep the largest gap seen.
+	 */
+	for (i = 0; i < cnt; i++) {
+		g = FN(bigger)(g, FN(gap)(dzone, cnum[i]));
+		dzone = FN(extend)(dzone, cnum[i]);
+	}
+
+	/*
+	 * The complement of dzone is the remaining uncovered arc after
+	 * the left-to-right scan (wrapping from last back to first).
+	 * Pick the largest gap overall, then complement it to get the union.
+	 */
+	g = FN(bigger)(g, FN(complement)(dzone));
+	return FN(complement)(g);
+}
+
+/*
+ * Split arc 'a' into up to 3 sub-arcs at the UT_MAX/0 and ST_MAX/ST_MIN
+ * boundaries. Returns the number of chunks (1..3).
+ */
+static int FN(cut)(struct cnum_t a, struct cnum_t chunks[3])
+{
+	int ncuts = 0;
+
+	if (FN(srange_overflow)(a)) {
+		chunks[ncuts++] = FN(from_urange)(a.base, ST_MAX);
+		a = FN(from_urange)(ST_MIN, a.base + a.size);
+	}
+	if (FN(urange_overflow)(a)) {
+		chunks[ncuts++] = FN(from_urange)(a.base, UT_MAX);
+		a = FN(from_urange)(0, a.base + a.size);
+	}
+	chunks[ncuts++] = a;
+	return ncuts;
+}
+
+static struct cnum_t FN(mk_mul_u)(utt a, utt b, utt c, utt d)
+{
+	ut2 size = (ut2)c * d - (ut2)a * b;
+
+	if (size > UT_MAX)
+		return (struct cnum_t){ 0, UT_MAX };
+	return (struct cnum_t){ a * b, size };
+}
+
+static struct cnum_t FN(mk_mul_s)(stt a, stt b, stt c, stt d)
+{
+	st2 size = (st2)c * d - (st2)a * b;
+
+	if (size > UT_MAX)
+		return (struct cnum_t){ 0, UT_MAX };
+	return (struct cnum_t){ a * b, size };
+}
+
+static struct cnum_t FN(mul_chunk)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t u, s;
+	stt a_min = (st)a.base;
+	stt a_max = (st)((utt)a.base + a.size);
+	stt b_min = (st)b.base;
+	stt b_max = (st)((utt)b.base + b.size);
+	bool a_pos = a_min >= 0 && a_max >= 0;
+	bool a_neg = a_min <  0 && a_max <  0;
+	bool b_pos = b_min >= 0 && b_max >= 0;
+	bool b_neg = b_min <  0 && b_max <  0;
+
+	u = FN(mk_mul_u)(a.base, b.base, (utt)a.base + a.size, (utt)b.base + b.size);
+	if (a_pos && b_pos)
+		s = FN(mk_mul_u)(a_min, b_min, a_max, b_max);
+	else if (a_neg && b_neg)
+		s = FN(mk_mul_s)(a_max, b_max, a_min, b_min);
+	else if (a_neg && b_pos)
+		s = FN(mk_mul_s)(a_min, b_max, a_max, b_min);
+	else if (a_pos && b_neg)
+		s = FN(mk_mul_s)(a_max, b_min, a_min, b_max);
+	else
+		s = (struct cnum_t){ 0, UT_MAX };
+
+	return FN(intersect)(u, s);
+}
+
+struct cnum_t FN(mul)(struct cnum_t a, struct cnum_t b)
+{
+	struct cnum_t ca[3], cb[3], cr[9];
+	int na, nb, nr, i, j;
+
+	if (FN(is_empty)(a) || FN(is_empty)(b))
+		return EMPTY;
+
+	na = FN(cut)(a, ca);
+	nb = FN(cut)(b, cb);
+	nr = 0;
+	for (i = 0; i < na; i++)
+		for (j = 0; j < nb; j++)
+			cr[nr++] = FN(mul_chunk)(ca[i], cb[j]);
+	/* sort by cr[*].base in ascending order */
+	for (i = 1; i < nr; i++)
+		for (j = i; j > 0 && cr[j].base < cr[j-1].base; j--)
+			swap(cr[j], cr[j-1]);
+	return FN(union)(cr, nr);
+}
+
+#undef EMPTY
+#undef cnum_t
+#undef ut
+#undef st
+#undef ut2
+#undef st2
+#undef utt
+#undef stt
+#undef UT_MAX
+#undef ST_MAX
+#undef ST_MIN
+#undef FN

-- 
2.53.0
