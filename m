Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33C3BB124
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773000; cv=none; b=eAdlgEh7B58yVLQzQ1T7Xt9EsSillkBVHCtOac+jIzbWfhljux350hKVViBVrn+ReoSUEjWZjQjZCCB5x6sVMTxHruRvhymi1yhoQ2EeLloRdT6KEuR1Nnf4RHgWhoq3NV1l88ODjssTfqxtiV4f/uRF7LVNUOYl/FIu2RoPfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773000; c=relaxed/simple;
	bh=73Y/6hCSCK84WGOHoIAZv2AtXpAnbJwogsMWt/xVjG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATJ3cbphtgDzVIjm98zhaNwWC4mKYCKYno8zO0TgYiEx1QSqsgEZsXrezR95CAppiYjavuImWO0jiFqkf8i/vwqpL+59ibuPja0zDeScBGt3rt4zTMNAbyz1XwDQ8OzgB0vzV08SzGw1pdxK4KO2kbnt4W0qj1fOYSZXB8evO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=D1Q0CDZS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="D1Q0CDZS"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c859878eb48so284753a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781772999; x=1782377799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97gqEJoV4Gnp5D9f5pbniwJykTL6WUeuhtKnY/ofWOk=;
        b=D1Q0CDZSljQWs2pgFIzxLkn1ioCvyenVbdE0Hjqh0bOj3PL2btQYNaUICNRMDAQPr2
         yt9ZbX5NSED8buOLdeVEdDbWFGK7wpXcO5Y5/Js8DBk7q77aUDdQ8tOhf9VmHQxXSNwe
         hmogF+q5YdiCHKYFCyyqcO1KK3aDGeuXOM5wv8wyBV/u3az/OmB+tLpsFB2WIKbGFtiR
         idY+JMxyLvRmsiBPI0kXbkMTpXm2eD9s+wUl3LUfw4oVYOHkej0eq/N1aK3Dscpik2DO
         R8n/+isQ206ro0oaNLm6qjulvxV4YY3jgtDxxFW9xPqf9UqJ5s8BUjuqVubewKj6a24+
         ZTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772999; x=1782377799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97gqEJoV4Gnp5D9f5pbniwJykTL6WUeuhtKnY/ofWOk=;
        b=HmGqUxmKEF9zLboythoErSuceuPFx4+oimOjyK23xQsKDztdrub/WON4YQhkvkhbOU
         OJqbfBiwSnn1W6FChOik3NX72a/P73HDSqU9k2725SBU5iJa9WWUYUZ38Mf9b+Tmrd10
         OnLeOi19CZyN84tvM5c02ziW7uc6Mh6bc/BbBNu3UvREPUy+zMdGf2gTni9lBDQrecH2
         cyRCFxoxGTkhnNZ5CpDmuowLF3iUDl1ch2Gjfz8BNhsoh1XO3W7YQzTxBn8elBBc8Ood
         QPTDNZIlKqXIEinhUmE1kouK/QoSJJxN4Ffp+YHDsttfr4MhgwculeeoDiHyvBOVCuCN
         gdUQ==
X-Gm-Message-State: AOJu0YxJ1Z/+lIkPI+ungRCIpcmsOCkZuZnXdOZzCUFjiaf7/mUwzqdO
	UJjUExUgzSOwBCPdVF0PQspYidB4BMmMCUU4S6IFO1ZoKlJL/m8Yj6ztFFQEaypDpdyhIfrhdln
	xfdFHv3vJwg==
X-Gm-Gg: Acq92OF40iJnmHRfESW6eGaxMl58b7dXdVAA/BvVWTMljVwl+h203TqJu2f5RmsUIZK
	VlhjoddW55jsMQAbtjWLxSzpzyY2/1E9LiMzvO/QXuObynJf5yObSpkPk/SfRIsMYZ2w+3CuaWh
	PM3TqZXA3DPyU0RNFRSBn82v14uQZcgdl/qWi2N9Wf/zBuCNDXKA9VsvRmMsYTBIYKNAuaFP6yY
	02C41CYYHjzJIEYC3gxCX2zWA0VIyA9HYHwZjRHSqi73zu/t7NXpHIJoAQ+VzY0rHhq74ecq54r
	LLEkG/GBz4XqtqNSfSuN/qeAMH2xW4izIJr+LNJ//XT21eJLOi7IUXbaY8rCoPQzeVy14erHkF4
	2hNHOWQi8Aqd1CjUO3IjGv5V4KJWkHRJu6nu9zMmGdKMhbfzLdJQTOqOW8oCCK6LhWbzaLQdxZK
	e264zOGzdR1XRqHXCQdX2fNbh7SeKHIV6VvcI28WE=
X-Received: by 2002:a05:6300:6681:b0:398:7df5:2dae with SMTP id adf61e73a8af0-3b9e5517917mr3696430637.9.1781772998560;
        Thu, 18 Jun 2026 01:56:38 -0700 (PDT)
Received: from krios (S0106d8b37028eeb5.vc.shawcable.net. [24.84.91.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c88c6c2b2easm2524404a12.27.2026.06.18.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:56:38 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/5] selftests/bpf: Add arena-based bitmap data structure
Date: Thu, 18 Jun 2026 04:56:25 -0400
Message-ID: <20260618085626.19633-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618085626.19633-1-emil@etsalapatis.com>
References: <20260618085626.19633-1-emil@etsalapatis.com>
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
 .../bpf/libarena/include/libarena/bitmap.h    |  31 +++
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 191 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
new file mode 100644
index 000000000000..11623a82e66a
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
@@ -0,0 +1,31 @@
+#pragma once
+
+#define BITS_PER_BYTE		8
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
+#define BITS_PER_LONG		(sizeof(long) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	(((nr) + BITS_PER_LONG - 1) / BITS_PER_LONG)
+#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
+
+struct bitmap {
+	u64 bits[0];
+};
+
+struct bitmap __arena *bmp_alloc(size_t bits);
+void bmp_free(struct bitmap __arena *bmp);
+
+void bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
+void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
+bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp);
+bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp);
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
index 000000000000..a8ca814aa0c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
@@ -0,0 +1,191 @@
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
+	size_t size = BITS_TO_LONGS(bits) * sizeof(bmp->bits[0]);
+
+	/* Assume long-aligned masks. */
+	if (bits % BITS_PER_LONG)
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
+void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
+{
+	bmp->bits[BIT_WORD(bit)] |= BIT_MASK(bit);
+}
+
+__weak
+void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
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
+	u64 actual;
+
+	do {
+		u64 old = bmp->bits[idx];
+
+		if (!(old & val))
+			return false;
+
+		u64 new = old & ~val;
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
+void bmp_clear(size_t bits, struct bitmap __arena *bmp)
+{
+	size_t nwords = BITS_TO_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		bmp->bits[i] = 0;
+}
+
+static __always_inline u64 bmp_last_word_mask(size_t bits)
+{
+	u32 rem = bits % BITS_PER_LONG;
+
+	return rem ? (1ULL << rem) - 1 : ~0ULL;
+}
+
+__weak
+void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2)
+{
+	size_t nwords = BITS_TO_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src1->bits[i] & src2->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __arena *src1, struct bitmap __arena *src2)
+{
+	size_t nwords = BITS_TO_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src1->bits[i] | src2->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+bool bmp_empty(size_t bits, struct bitmap __arena *bmp)
+{
+	size_t nwords = BITS_TO_LONGS(bits);
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
+	size_t nwords = BITS_TO_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		dst->bits[i] = src->bits[i];
+
+	if (nwords && bits % BITS_PER_LONG)
+		dst->bits[nwords - 1] &= bmp_last_word_mask(bits);
+}
+
+__weak
+bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap __arena *small)
+{
+	size_t nwords = BITS_TO_LONGS(bits);
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
+	size_t nwords = BITS_TO_LONGS(bits);
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
+	size_t nwords = BITS_TO_LONGS(bits);
+	volatile u32 i;
+
+	for (i = zero; i < nwords && can_loop; i++)
+		arena_stderr("%016llx ", bmp->bits[i]);
+}
-- 
2.54.0

