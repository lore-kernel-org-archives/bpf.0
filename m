Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668B423798
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361861; cv=none; b=kWydkPOvEbt5fN9T+kD32FlKiqxi5EM5PzTeLgNO/DkvLTiipIdTfYFMzwxf3CSJXOfadSb7cVND91Gf+NWMHjqVzXoOQFUAE4ugCmT3JPcqtuNxT2AY4/0usFMr0q/3eWtd86TEJ/jBWHqnLR4w8k3Ev/k7J6hP1zB8RrUqVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361861; c=relaxed/simple;
	bh=vVJw4lUHhdBUz19LYicpEYUsAltyO54KTQLuOSwQBx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyqAU2CnV5lz0NMjVb0yJXDx2PRGz6U92fJcBtBOydkRWbMA9acjJv4hFP7Y46DsAFqS+yQ8gHxpyuckX5j2RYMmjU2lXUm5/RKEW9Cvbqq0XQfwKg623Fnp6rK0mugYtnpWTP+qXob5X8aJf7RAjaTnaBgUbDSkDwM01ZVIQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=v0UpCLIp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="v0UpCLIp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845e363246aso3734572b3a.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783361859; x=1783966659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=v0UpCLIp5VgfLSMItEIKFhF7PBRgtiRd24A4zNJvxtIZs155hI9wGKp4QZugGr9aIL
         83aMs6Q7rDpAb92zGZuYipJ1BXGIJrLHEqXUV1f/koTb0Gy6m7K4vnR/c9zfdKxQn2Hd
         X2mDoUWz81nazQ7eUpBF9KQ2Gj7kJYjXlrZbteKtyuvQvO4MKYbgISJcDVqgH0wrZqeg
         PYquF7LYRDa7VZvBLKsyvHAZSJg8VP2tE5887rGpyisuBktgxghsKwesdb7qYyx5cCiK
         PlFXXnoKYF4qyPr0wb1q0WQQw+yDsSkRN1YBh3+FIrnSHtz9EnpiQoJ90WexXIXiCpKB
         CLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361859; x=1783966659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=sQd47Y+eqWMHam3DlDExWzuVqusNtg2vpvvyTpCxBwVGKcPBEiK37h1FWU7s/us5oJ
         mS1do8XlZF7trNdi/pRaK0Qn7X5VNBTsW4SgNGTvYeWOeAiPAiqWmaNRSKlZWSbK4cIx
         4UvpJJLWfyuozYUJWp3fc7KCvMoOtra4Fyqe3bd+v8hsVtSYsuWSVVyE8kC0hH70sW6U
         3QsHhHAwavqe8Q9OW2VbN1qXSGrnd70Xy2sWsnoLR1oRdHPKq9rZE3rHrFGM59uvfaGE
         mKyINCTulCcYeR8uK/F3zJ5wmd9JTY5JTo1hKd4KMyyDH3G8cGVTIQ9UOfQbKzrkAHtF
         waSQ==
X-Gm-Message-State: AOJu0Yz+MbTXTLHdq2oQDKxC8Y794o5xJW5yHC6/iZzYF0Orhj7NKn0A
	BOL4yKPVjbxOTbri0RTJAj4L2/dxOCwqkT0Ad2XdIo9199KK1zjNuC/Tuik4lFlAJYp0txOXrjp
	/d6Psdvs=
X-Gm-Gg: AfdE7cnrY2KquZS5OYyYHaqnX+t9enp5+jVkRVjb9Wy+9cx+2WLoPsOkyUs//KMYDgq
	ZcfTKPtKKNPUzFuYBrmHr/NPL55CMkxSBmg5AAqxqPBzTqifZF/9v4RGlh0S9cg264BwgGpO2uk
	H8rg9lFma0y8otTxhiyFFDwbhHwFOT8qJ3r3uycTs5NFbQoaGPkL7e0sOxu6F4ALUcHd49vC1rY
	hOWDatqUyLQdkYVJe/c8EXpJp7sJSLPrVJvNYb0HhqzF7vwhZhyWYDP1kwLONl3x3MY7hQA/bzE
	/WOeSWrKpk82THFDKHJbnrIhAQYtcDzoW4u3ns4qyrQuwHODujiZnQjj6kxjcVn0JYczNcdmVFB
	OV1WQSzPht9l6AIVs8e0hsB45YXfT6beCludkXMZrS3B+Ht0uKyxnkQkRN2dbyzDmMkvmCqTnDA
	0wOhvIvxe9636tsJrjikXRZsTP2HeaOilb/7ZPZcybmcU6KR4=
X-Received: by 2002:a05:6a00:3308:b0:846:2f5b:c00 with SMTP id d2e1a72fcca58-84826d7a1a1mr1546861b3a.54.1783361858767;
        Mon, 06 Jul 2026 11:17:38 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498dcsm4192997b3a.30.2026.07.06.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:17:38 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 4/6] selftests/bpf: Add arena-based bitmap data structure
Date: Mon,  6 Jul 2026 14:17:28 -0400
Message-ID: <20260706181730.21731-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706181730.21731-1-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
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

