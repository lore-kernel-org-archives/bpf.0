Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B973F54DD
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851370; cv=none; b=BuNlpLm1a++k1ThvCTySxuIpEZ37SILV6wvJI6dHAeKtw2zIPDfBImUhmMdIBGSqieLvOso29oh6J5Z9q8qb8YZpbvpC7R/Xr/ZPB1U0SKD6oKJoBOBcPgmgkOdq+QGODSuDjkAHz9tS4Km2IMAy45ocVAKBjXJJ6HDGnKaguHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851370; c=relaxed/simple;
	bh=Y0X8WnBbPJdR5TrQ+whMbKD5mrAI1hVzG00GquNesf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AznJdVa1HsUPsyPOnoq0sBM6nxFajpq7OEo7Pel3pOyws+u3hJzz40uoyZi0RWMwR4NlFx9a4iaLFbGEw+CAVrSey2Q7LkR68R5y+ywmd97kL0QLOGNRRD2vKgr8VHRc6DL4aaJ2GpdC/Lfluuc9TP5tZX6Pc+Wyrw4GkVEFBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbgy1Z5z; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbgy1Z5z"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-356337f058aso85934a91.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851363; x=1774456163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF+fNbcnJTnMfl0mMvIc2ISzQ1nmSR1qz2RR527uK/g=;
        b=Xbgy1Z5z6P/XZA5XMzHCP1cpGr6nNzrPP38JTwz9MJkQTzwbyjxUr0iwLWVLIUnSGv
         w71nNPeVZpWXcj5EV6y+wq8pkG9NNDwL7D3WI5W0euar04w++CqOpNhhzoW3MykOJ9oW
         XvadBY+Aa2u0h2YQbT3HGvxZ2fW7VdoGLWDJKGWbQSBM6rMLAbLaMgZtaylC0nvqRB/C
         9Fi5cGvz2PWJ2M+IW/dWtB671HkjYnGLK52O/TUJS2XCPJVfskLqZVvTmtkpZCDRY6jz
         ZpOL2E+ZNWSPuU8G/yy9rP4xrK9tONTGO3UJXbXjNWnzowHcayexWFT8Js1E9KoC0YFJ
         gkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851363; x=1774456163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EF+fNbcnJTnMfl0mMvIc2ISzQ1nmSR1qz2RR527uK/g=;
        b=dxi178T0E+iWX7dJr+3yzZTCy4BLSWEBBJqTXgqnvnX1pLb4To7s7SqiMOyQ+l4/DD
         b/qNFf/nqbv+m3rCcrwgBvb9g4SzvG51QAKEvuBc2QIBTyE9Qn9aOjahXIe4yhZXhDsK
         aunqVcqzT8v/yjeCf9OKl7RZpJyNMOFydd4MRBvTTz7Nnpb4eRiuXtU3pRk4CLdFnXAQ
         RsQnkFYt2Bh+mI7ey0vZhfZSACcjtdREe7bmKX2ABC69bh8L/Z9I752DPsKTYnyNai1b
         b4tdLBTr+LQ9HdR1Py81mlZ2Hm7zL6qGsD/PhE6D0ow9J+0577d1+qFZ0mtZAtC+ueb5
         7lfw==
X-Gm-Message-State: AOJu0YzWo5MKieEQ9KtPJSvY3SgTIQ2hhrpZdjfuIW5/TI5iYopGwYOc
	Prw2ElIn/YASJp4QLLNiLApp6qCSooKrtSqLcAZQkdNP4YB5ZLhb+QwrsWFEsw==
X-Gm-Gg: ATEYQzyiB1uxtXfMa0+o25vkJZMI5+cd+HUw9YsTlD4dWWIQy7N4wa99lIZuGk2dUS/
	Cma65SL8uk8tBWlspPXF84xME0piO4eERnXWmIbHiD44A5rWTFiFAIOgCgibDvbn0dnU3C3vJtH
	elxcVW68jfKv9NvQegmDyObhei4CwlXIhICny8YWJ+42AFSwcc1KURJ5wJVQI/d0l1Cb+yehMQT
	LzQhgY0K3otGnO8yBmo6Ldbnn7+zMS8XxT8S81kCVa2mhpCvrf2rAb6AvhMlqFvBpyX2LuO3V5G
	H7FwnLZtj9vsf+Rru8Pu6ySKG32fCCqhCoMDPmU61TIloQZwR7+kBXt6CF7RfprFmQ4gggeNnvW
	R38FGKMTZ5HcycL8exi73LcS6zodjM1inPvNkrxJyqhrWcRyrBMveDUSiOYWF09b4IfZ7GGBN1p
	l+F+m9v900KR6mORzDmbTFF9wDO9NXK/CJo2B4CXhvcRInnSMs
X-Received: by 2002:a17:90b:28ce:b0:35a:18b1:c239 with SMTP id 98e67ed59e1d1-35bb9e57d09mr3453372a91.10.1773851363358;
        Wed, 18 Mar 2026 09:29:23 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm89370a91.14.2026.03.18.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:22 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v1 1/4] bpf: representation and basic operations on circular numbers
Date: Wed, 18 Mar 2026 09:28:58 -0700
Message-ID: <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This commit adds basic definitions for cnum32/cnum64.
This is a unified numeric range representation for signed and unsigned
domains. Inspired by an old post from Shung-Hsi Yu [1] and paper [2].
Operations correctness is verified using cbmc model checker,
tests source code can be found in a separate repo [3].

[1] https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
[2] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
[3] https://github.com/eddyz87/cnum-verif/tree/master

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/cnum.h   |  60 +++++++++++++++++
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/cnum.c      | 115 ++++++++++++++++++++++++++++++++
 kernel/bpf/cnum_defs.h | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+), 1 deletion(-)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
new file mode 100644
index 0000000000000000000000000000000000000000..c38142d3cee11185018e34e669800f1d72865e57
--- /dev/null
+++ b/include/linux/cnum.h
@@ -0,0 +1,60 @@
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
+struct cnum32 cnum32_from_urange(u32 min, u32 max);
+struct cnum32 cnum32_from_srange(s32 min, s32 max);
+u32 cnum32_umin(struct cnum32 cnum);
+u32 cnum32_umax(struct cnum32 cnum);
+s32 cnum32_smin(struct cnum32 cnum);
+s32 cnum32_smax(struct cnum32 cnum);
+bool cnum32_intersect(struct cnum32 a, struct cnum32 b, struct cnum32 *out);
+bool cnum32_contains(struct cnum32 cnum, u32 v);
+
+/* Same as cnum32 but for 64-bit ranges */
+struct cnum64 {
+	u64 base;
+	u64 size;
+};
+
+struct cnum64 cnum64_from_urange(u64 min, u64 max);
+struct cnum64 cnum64_from_srange(s64 min, s64 max);
+u64 cnum64_umin(struct cnum64 cnum);
+u64 cnum64_umax(struct cnum64 cnum);
+s64 cnum64_smin(struct cnum64 cnum);
+s64 cnum64_smax(struct cnum64 cnum);
+bool cnum64_intersect(struct cnum64 a, struct cnum64 b, struct cnum64 *out);
+bool cnum64_contains(struct cnum64 cnum, u64 v);
+
+struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
+bool cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b, struct cnum64 *out);
+
+#endif /* _LINUX_CNUM_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99ba31a9daf08a29de0f3a162ba89f..b6647a3cca8b5db2283c01d155c82190824701c0 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o cnum.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
new file mode 100644
index 0000000000000000000000000000000000000000..da50a40e79ace924bfa9acf5eac6e6a76b39ccab
--- /dev/null
+++ b/kernel/bpf/cnum.c
@@ -0,0 +1,115 @@
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
+bool cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b, struct cnum64 *out)
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
+			return false;
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
+			return false;
+		t.size -= d;
+	}
+	*out = t;
+	return true;
+}
diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
new file mode 100644
index 0000000000000000000000000000000000000000..f8f439a52bdb11eb1703e855739ecac92a04fe33
--- /dev/null
+++ b/kernel/bpf/cnum_defs.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#ifndef T
+#error "Define T (bit width: 8, 16, 32, 64) before including cnum_defs.h"
+#endif
+
+#include <linux/cnum.h>
+#include <linux/limits.h>
+#include <linux/minmax.h>
+#include <linux/compiler_types.h>
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
+	return (struct cnum_t){ .base = min, .size = max - min };
+}
+
+struct cnum_t FN(from_srange)(st min, st max)
+{
+	ut size = (ut)max - (ut)min;
+	ut base = size == UT_MAX ? ST_MIN : (ut)min;
+
+	return (struct cnum_t){ .base = base, .size = size };
+}
+
+/* True if this cnum represents two unsigned ranges. */
+static inline bool FN(urange_overflow)(struct cnum_t cnum)
+{
+	/* Same as cnum.base + cnum.size > UT_MAX but avoids overflow */
+	return cnum.size > UT_MAX - cnum.base;
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
+bool FN(intersect)(struct cnum_t a, struct cnum_t b, struct cnum_t *out)
+{
+	struct cnum_t b1;
+	ut dbase;
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
+			*out = a.size < b.size ? a : b;
+			return true;
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
+			out->base = a.base;
+			out->size = min(a.size, (ut)(b1.base + b1.size));
+			return true;
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
+		out->base = b.base;
+		out->size = min((ut)(a.size - dbase), b.size);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+bool FN(contains)(struct cnum_t cnum, ut v)
+{
+	if (FN(urange_overflow)(cnum))
+		return v >= cnum.base || v <= (ut)(cnum.base + cnum.size);
+	else
+		return v >= cnum.base && v <= (ut)(cnum.base + cnum.size);
+}
+
+#undef cnum_t
+#undef ut
+#undef st
+#undef UT_MAX
+#undef ST_MAX
+#undef ST_MIN
+#undef FN

-- 
2.51.1
