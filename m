Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A467347C7
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018684; cv=none; b=k2UsnB0dqK3L4CBfdLD3Of1qfAHiskrM5Yzmm/1rAPHQwP5ANkJcaAps4nPG47GJff0Uq7fQRJqMpyZcCVU0DtDXiqd81dB79l7YIPa+rsmXe//mnps+M1bhtTG+olcjNX9iVzIc3019OxfgrFDyVhjtB1WVcyRWmg48wyBOogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018684; c=relaxed/simple;
	bh=KaUM+jnF3xp35I3Evuzh0v9cLhvk6CfdW8ALVRhXbrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoqgCGrcn993iWGSEW9nR/Xh++tFkCGuJFOihsyQBOurwRAPI3W3yTJR5qlg909Q2kLEyhs1Hm44cUy56DJp+uh88z9/TimmsaaP5oCFbL4Ybm+w/wo8te1UCDskkYd4eRkpVLPdBvppcxOONC76dNL44+JLq7Wv2yUz8ouujQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKQSUPkX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKQSUPkX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82d0b68837aso4825685b3a.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018682; x=1777623482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVWGuCtawxjZhwM3gfICiiPLDHlrysox1Ra5PDxKpTo=;
        b=tKQSUPkXkRpmF27MjCLApSmhTEzYdciBB6+zLDqtdOgRSxLTOWH9vcMPa1efmLsqDa
         32iv+VzKesHKjXhhq7tpHbNPgRLXafzX5rn7zkGdRrFNLN8V2q0qUMN5BSfCmMQgMTcj
         CUMc663peobrZAs/p2sGRjqR+Sg2mTFpKrQOBzzlGGbwwZmFvR6TuZ7VII5aqTMejCwC
         wYLilJ0bsoxlESkDS+iAabzs9E/Dx+LdkY6UfGOK2Hlr/bnBAWn2MwgL2Huv9UQdnXuD
         aEf8EHW3Wi79q3KTRHFyZ8WlK23ciNFGBN+QNOYFwkwdK1EHvFYMApxoxqtv2RLoLeIL
         5Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018682; x=1777623482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVWGuCtawxjZhwM3gfICiiPLDHlrysox1Ra5PDxKpTo=;
        b=G9GWV+DoN72aXfED8jWt7ccpCYRFrDjr9zTAy1EnDXS4uJiJhqSPKiVgwAlVeAkQTA
         Uj7oeY357oHjubjn2tjuKRfY7OJu7YdlrPBDtJnKW9hhjrM8KGSayxRpRRAFRJ21WiKU
         33NuMYEpEZ0AXGAJdWjqnBw0XMEIPz+n0OXPeXuGESaGo85rcKzrlzxj/ZtySWmmYfB+
         KDiaDLKVISM8F99mTPhkuKcsXhB5IKgXWmz38xa8WEwDaq7QiftAcMK8Facl6bInMDG2
         UXCVZcNyYvyrcA6cevqZs/hfBYw1D7gy80GCD/nbk0C0+rFSZa1OKtFjI4YzsODZQ6k8
         CiGw==
X-Gm-Message-State: AOJu0Yw4rHv5YWozSyZBTvgQmtt4PFKbyiBkM6Qjs1H1XyjhKi+X6juf
	dmhDaLxGr6287GPiKhvB2qWmpFP/eIi57W5L7lbJ/qfB3UsSe2Em8HrOrbWohw==
X-Gm-Gg: AeBDietHKXvs6OLQzVEHzyuZLKQT+Y0xltU83w5JMe1AoInxQWLiXVlg+xUbfeeRf3N
	/5NrDDfqEc1qqH+ee8sNw3c+b1wFFET+FWM/iG9MEOI0F2a1mBrpwngnzax5rTOv2cSvSoTB86g
	cxIv29xp7P98AXWGM/e+l7JfNtQuLo6z2m1WyumQduNhBE5+gz1FPqdfkQV0CDthLlPa0KlLuva
	UDAb8FarooI5Q80Oude+We4N7MODdQuqG74sjaRElgMJuJLhW/tkIntslO/4RKtCl4BSOHdapBH
	8uobNx4qBxA8zekJEjRl+pz5Adf2xPDYA+Q2llkWBRq0ZbOQU+YyhjhPT0qFvRkutQ3xGsbSQSt
	Xa7KSfHJowvLkrPdRzknyd3TWlYVfKKI9M8wtHGzG0RB5xZiQlo4bx6M7glXDRYO1JdIyxkX2Mf
	mp3R19mfgjeQVKAyPtQlZzNPhXIP3x7yX9aSvzmZSFXc8wMx45IIlyk92Ow8RTzQWFsqJ/lg==
X-Received: by 2002:a05:6a00:1acd:b0:82f:cfd2:6ca0 with SMTP id d2e1a72fcca58-82fcfd27015mr15492180b3a.40.1777018681421;
        Fri, 24 Apr 2026 01:18:01 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm26604340b3a.58.2026.04.24.01.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:18:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: representation and basic operations on circular numbers
Date: Fri, 24 Apr 2026 01:17:40 -0700
Message-ID: <20260424-cnums-everywhere-rfc-v1-v2-1-57091924c9d7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
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
- t is a refined 64-bit range, such that ∀ v ∈ a, (u32)v ∈ b: v ∈ t.
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
 include/linux/cnum.h   |  80 +++++++++++++++++
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/cnum.c      | 120 +++++++++++++++++++++++++
 kernel/bpf/cnum_defs.h | 233 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 434 insertions(+), 1 deletion(-)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
new file mode 100644
index 000000000000..a7259b105b45
--- /dev/null
+++ b/include/linux/cnum.h
@@ -0,0 +1,80 @@
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
+void cnum32_intersect_with(struct cnum32 *dst, struct cnum32 src);
+void cnum32_intersect_with_urange(struct cnum32 *dst, u32 min, u32 max);
+void cnum32_intersect_with_srange(struct cnum32 *dst, s32 min, s32 max);
+bool cnum32_contains(struct cnum32 cnum, u32 v);
+bool cnum32_is_const(struct cnum32 cnum);
+bool cnum32_is_empty(struct cnum32 cnum);
+struct cnum32 cnum32_add(struct cnum32 a, struct cnum32 b);
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
+void cnum64_intersect_with(struct cnum64 *dst, struct cnum64 src);
+void cnum64_intersect_with_urange(struct cnum64 *dst, u64 min, u64 max);
+void cnum64_intersect_with_srange(struct cnum64 *dst, s64 min, s64 max);
+bool cnum64_contains(struct cnum64 cnum, u64 v);
+bool cnum64_is_const(struct cnum64 cnum);
+bool cnum64_is_empty(struct cnum64 cnum);
+struct cnum64 cnum64_add(struct cnum64 a, struct cnum64 b);
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
index 000000000000..86142cb2aee5
--- /dev/null
+++ b/kernel/bpf/cnum.c
@@ -0,0 +1,120 @@
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
+	if (cnum64_is_empty(cnum))
+		return CNUM32_EMPTY;
+
+	if (cnum.size >= U32_MAX)
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
+ * such that ∀ v ∈ a, (u32)v ∈ b: v ∈ t.
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
+	if (cnum64_is_empty(a) || cnum32_is_empty(b))
+		return CNUM64_EMPTY;
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
index 000000000000..1aa0554bf19f
--- /dev/null
+++ b/kernel/bpf/cnum_defs.h
@@ -0,0 +1,233 @@
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
+#define cnum_t   __PASTE(cnum, T)
+#define ut       __PASTE(u, T)
+#define st       __PASTE(s, T)
+#define UT_MAX   __PASTE(__PASTE(U, T), _MAX)
+#define ST_MAX   __PASTE(__PASTE(S, T), _MAX)
+#define ST_MIN   __PASTE(__PASTE(S, T), _MIN)
+#define EMPTY    __PASTE(__PASTE(CNUM, T), _EMPTY)
+#define FN(name) __PASTE(__PASTE(cnum, T), __PASTE(_, name))
+
+struct cnum_t FN(from_urange)(ut min, ut max)
+{
+	return (struct cnum_t){ .base = min, .size = (ut)max - min };
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
+	return cnum.size > UT_MAX - (ut)cnum.base;
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
+void FN(intersect_with)(struct cnum_t *dst, struct cnum_t src)
+{
+	*dst = FN(intersect)(*dst, src);
+}
+
+void FN(intersect_with_urange)(struct cnum_t *dst, ut min, ut max)
+{
+	FN(intersect_with)(dst, FN(from_urange)(min, max));
+}
+
+void FN(intersect_with_srange)(struct cnum_t *dst, st min, st max)
+{
+	FN(intersect_with)(dst, FN(from_srange)(min, max));
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
+		return (struct cnum_t){ 0, (ut)UT_MAX };
+	else
+		return FN(normalize)((struct cnum_t){ a.base + b.base, a.size + b.size });
+}
+
+struct cnum_t FN(negate)(struct cnum_t a)
+{
+	if (FN(is_empty)(a))
+		return EMPTY;
+	return FN(normalize)((struct cnum_t){ -((ut)a.base + a.size), a.size });
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
+		return v >= cnum.base || v <= (ut)cnum.base + cnum.size;
+	else
+		return v >= cnum.base && v <= (ut)cnum.base + cnum.size;
+}
+
+bool FN(is_const)(struct cnum_t cnum)
+{
+	return cnum.size == 0;
+}
+
+#undef EMPTY
+#undef cnum_t
+#undef ut
+#undef st
+#undef UT_MAX
+#undef ST_MAX
+#undef ST_MIN
+#undef FN

-- 
2.53.0
