Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9C2EC090
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931963; cv=none; b=bzIYZVDXe3ILMqrOU4suuTOfitJaf0SsDo9It41rdaipjnqDPWjlYjWm+aP6KwF9htMFKgFN7GOh7XZH2x22rgyr+JJUrAggubfTfYNdrCC1COuc3xQTO2f2DHAnfcVI8EzRCzrO+X7IX9oE7fzKwtkfLhTZXoX9HLC4Job7ZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931963; c=relaxed/simple;
	bh=vVJw4lUHhdBUz19LYicpEYUsAltyO54KTQLuOSwQBx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f37iz6hz41TibZULCq/B4sk3fKRLkhztjvq+ressOftq4S+7FdAtqjFKxekL3p4JtqS/+qEZ9fqUp1H6tdnZzukNjpXKkziO8ySTr7DQsO3yMi6stn04M/5FxBL3OHhB81Emxl5QieZSPH34kRGfBeiHmlHdPpkiSlA47WkRkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OV9g0vbR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OV9g0vbR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6c4a867cso54609085a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782931961; x=1783536761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=OV9g0vbR0uhMYEUaqVSpY7YAba7LNiLFtZczX/7TEcB6kv5mOP/vuTOMKnKudJAdSc
         BvG1xoeEMm9cc/xt+Ih4HAEKyepvjk7TEomuja5uEGZ3lVZF/9UV0q2TdBvjW8iHtgg7
         fBFEBvfT12RbabpZrUX7KC77S93NXUgH32RxzQTu7u/xgEIDh+Plfg0xA7ipizO0lRzt
         GlJLT+B5+IiorUApEsrKshQaNuzl40eI6PmuS0otEtuQL/rih3EpPz6+sS1+/z55giPP
         lt19wDpl2+Bb9JzzZTa4nR/vdyvIVcPGqcyJeeNYQfQgMAjlfCEua5Nabd9FPA999f5o
         6rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931961; x=1783536761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=VPQnUmQac6dVG5FsQuytE9q9XPTtkMiX3U65zjW0+Ea0dAPN1E7JwGmm0fe1r7zlGn
         jBvib8Ii+vTKOlj9GcjI5pXszFzDuvrVArQTVlHEx4XgOR/70whoK7WYERT3bEa+iiso
         55mlFoIcR+GI0mi9ckowV8aiUU+Q+nGiedM1gRbduwTVgrp5ml/BnUjWA5ohJLuIjMxo
         geE/LtiyAKS8Quu5A8fm3+KEt/Zhe2ehhDPUMPhXC+0xOUma+w00JS9arDAEOnNTNH2D
         0c1u3xubJPDPKi2Np4dTW3CNatklSX2GWcdGVfgc0vl687G+8PIUPaZin5m8Urzb1zQ2
         QtsA==
X-Gm-Message-State: AOJu0YxBw26gSn5XW+ABYRlCe8aY+PpNBcg3qonjTIarnMIk8o7kK0oc
	5+fWCOaEttV8Mfq/IAJxtYZUSy6ljuEcX1witQf1V1TSqmUPnMZGa5eci4xOXbv1IRLy95Pe9C1
	KeuZ6yl4=
X-Gm-Gg: AfdE7ckVYFfn+02G4+Z3kZi2PWsFcksa81T30eId7ef0tgXtDMCMgBb05V77SBv5mhA
	nXLejGtNLiShfIjCJ0VJRJNBCwzfqaRV6AxTVE1xYAFoU6XDkTRngmvQ2tU7tEjVtYxpZazDdDm
	GFbrB8mUagFnodv9bfPxv8O5H+dbVJy0P5HTFvnnUXydrKC0tQAFebk7VdK7JtJFzUheTEDWZUg
	pmxqO51dQxVV+QOgIRdP30vZxP7F134mZY9lz4hEZgX2cu7iqtHwFVsyfiUBRWorkhjxnfFjgbs
	gsD15+w1M3PtkQSmWFu8ey3cQ9DqsDZaWpqs7i+P2DwkWuQCLJXCwpicV3DJ7y0M0FOW8ICvewT
	3piz47pfEFs57KXiVFeGMxvop5iXBBvlUO8cx2WK0rsHaYFBFXkl9ya+VQEW5JIHC4sRMk9u6zr
	lBlT4WvLdip6lCvxtsYxnQqpcokok3TlQVwRmy1JISZL+DLLiB
X-Received: by 2002:a05:620a:40d4:b0:915:7732:ea7c with SMTP id af79cd13be357-92e7b3e89acmr319468185a.43.1782931960948;
        Wed, 01 Jul 2026 11:52:40 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801949d9sm12876685a.36.2026.07.01.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 11:52:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add arena-based bitmap data structure
Date: Wed,  1 Jul 2026 14:52:33 -0400
Message-ID: <20260701185235.4516-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701185235.4516-1-emil@etsalapatis.com>
References: <20260701185235.4516-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an arena-based word-aligned bitmap data struture. The
structure is useful as a building block, e.g., sched-ext
uses it to represent cpumask structures.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/bitmap.h    |  34 +++
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 245 ++++++++++++++++++
 2 files changed, 279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
new file mode 100644
index 000000000000..cf6b63f5d9a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
@@ -0,0 +1,34 @@
+#pragma once
+
+#define BITS_PER_BYTE		8
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
+#define BITS_PER_LONG_LONG	(sizeof(long long) * BITS_PER_BYTE)
+#define BITS_TO_LONG_LONGS(nr)	(((nr) + BITS_PER_LONG_LONG - 1) / BITS_PER_LONG_LONG)
+#define BIT_MASK(nr)		(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG_LONG)
+
+struct bitmap {
+	u64 bits[0];
+};
+
+struct bitmap __arena *bmp_alloc(size_t bits);
+void bmp_free(struct bitmap __arena *bmp);
+
+void __bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
+void __bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
+void bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
+void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
+bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp);
+bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp);
+bool bmp_test_and_set_bit(u32 bit, struct bitmap __arena *bmp);
+
+void bmp_clear(size_t bits, struct bitmap __arena *bmp);
+void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2);
+void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2);
+bool bmp_empty(size_t bits, struct bitmap __arena *bmp);
+void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src);
+
+bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bitmap __arena *arg2);
+bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap __arena *small);
+void bmp_print(size_t bits, struct bitmap __arena *bmp);
diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
new file mode 100644
index 000000000000..80e814401fb9
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/*
+ * Copyright (c) 2025-2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025-2026 Emil Tsalapatis <emil@etsalapatis.com>
+ */
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/bitmap.h>
+
+__weak
+struct bitmap __arena *bmp_alloc(size_t bits)
+{
+	struct bitmap __arena *bmp;
+	size_t size = BITS_TO_LONG_LONGS(bits) * sizeof(bmp->bits[0]);
+
+	/* Assume long-aligned masks. */
+	if (bits % BITS_PER_LONG_LONG)
+		return NULL;
+
+	bmp = (struct bitmap __arena *)arena_malloc(size);
+	if (!bmp)
+		return NULL;
+
+	bmp_clear(bits, bmp);
+
+	return bmp;
+}
+
+__weak
+void bmp_free(struct bitmap __arena *bmp)
+{
+	arena_free(bmp);
+}
+
+__weak
+void __bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	bmp->bits[BIT_WORD(bit)] |= BIT_MASK(bit);
+}
+
+__weak
+void __bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	bmp->bits[BIT_WORD(bit)] &= ~BIT_MASK(bit);
+}
+
+__weak
+bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
+}
+
+__weak
+bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	u64 val = BIT_MASK(bit);
+	u32 idx = BIT_WORD(bit);
+	u64 old, new, actual;
+
+	do {
+		old = bmp->bits[idx];
+
+		if (!(old & val))
+			return false;
+
+		new = old & ~val;
+		actual = cmpxchg(&bmp->bits[idx], old, new);
+
+		if (actual == old)
+			return true;
+
+	} while (can_loop);
+
+	return false;
+}
+
+__weak
+bool bmp_test_and_set_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	u64 val = BIT_MASK(bit);
+	u32 idx = BIT_WORD(bit);
+	u64 old, new, actual;
+
+	do {
+		old = bmp->bits[idx];
+
+		if ((old & val))
+			return true;
+
+		new = old | val;
+		actual = cmpxchg(&bmp->bits[idx], old, new);
+
+		if (actual == old)
+			return false;
+
+	} while (can_loop);
+
+	return false;
+}
+
+__weak
+void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	u64 val = BIT_MASK(bit);
+	u32 idx = BIT_WORD(bit);
+	u64 old, new, actual;
+
+	do {
+		old = bmp->bits[idx];
+		new = old & ~val;
+		actual = cmpxchg(&bmp->bits[idx], old, new);
+
+	} while (actual != old && can_loop);
+}
+
+__weak
+void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	u64 val = BIT_MASK(bit);
+	u32 idx = BIT_WORD(bit);
+	u64 old, new, actual;
+
+	do {
+		old = bmp->bits[idx];
+		new = old | val;
+		actual = cmpxchg(&bmp->bits[idx], old, new);
+
+	} while (actual != old && can_loop);
+}
+
+__weak
+void bmp_clear(size_t bits, struct bitmap __arena *bmp)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		bmp->bits[i] = 0;
+}
+
+static __always_inline u64 bmp_last_word_mask(size_t bits)
+{
+	u32 rem = bits % BITS_PER_LONG_LONG;
+
+	return rem ? (1ULL << rem) - 1 : ~0ULL;
+}
+
+__weak
+void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src1->bits[i] & src2->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src1->bits[i] | src2->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+bool bmp_empty(size_t bits, struct bitmap __arena *bmp)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++) {
+		u64 mask = (i == nwords - 1) ? bmp_last_word_mask(bits) : ~0ULL;
+
+		if (bmp->bits[i] & mask)
+			return false;
+	}
+
+	return true;
+}
+
+__weak
+void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap __arena *small)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++) {
+		u64 mask = (i == nwords - 1) ? bmp_last_word_mask(bits) : ~0ULL;
+
+		if (~big->bits[i] & small->bits[i] & mask)
+			return false;
+	}
+
+	return true;
+}
+
+__weak
+bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bitmap __arena *arg2)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++) {
+		u64 mask = (i == nwords - 1) ? bmp_last_word_mask(bits) : ~0ULL;
+
+		if (arg1->bits[i] & arg2->bits[i] & mask)
+			return true;
+	}
+
+	return false;
+}
+
+__weak
+void bmp_print(size_t bits, struct bitmap __arena *bmp)
+{
+	size_t nwords = BITS_TO_LONG_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		arena_stderr("%016llx ", bmp->bits[i]);
+}
-- 
2.54.0

