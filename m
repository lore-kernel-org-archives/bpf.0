Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942F3B2FF6
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946242; cv=none; b=mky36cs83k6JIR+10p6WtMLWUqFu5jhO59m/jzfxnf5zdfV1OubhgAQ1jSndHMgZm0RYK8lGXnQWmWx0zfR5SGg+asgLNZWUUQKjxo5XnXts4ttY60P67g/UsGAyXP4McK5otIdSCO+pAZCvTRE0KpltWRYeHJQTuiY+4ufXPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946242; c=relaxed/simple;
	bh=vVJw4lUHhdBUz19LYicpEYUsAltyO54KTQLuOSwQBx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oORBGYsf9u5xTMP3Rx04vQmKxEevQ4NXmHh2/ZmK5Fj+dv1uL0tl/J/rPjslmiySaqntkPJyV35Klv53KrtGJ5B27ifEzGU/b4IHl53XXteUM+uy/Sle1wCcAQsLEP4DtM1sblTGEClWiDlmy4Tt3x8fYhe3Dn7yr1IeOoq8icc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GQwxYKSp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GQwxYKSp"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-923220bf1d5so102629485a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782946240; x=1783551040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=GQwxYKSpQXppQUnOhYdsDxoTgKTrsYakV0Fi3f8kDBhs3wd5liYl8jAbAAqtk021aT
         Tqc4/ugYbtSfXfqjrNMAuLRz+CBu3w8n3PSgPWu45p6dM0fMhUXvDFiY97dgK1JMC97i
         TIKoeawVUySR1Mvn7tCaA2s88i6D3G2sM6Qt2Fyt+XYYnDaRfthaQjyMj0KiCwvaDwAJ
         Po5wDLNXAdo/OlZRzDrr9ciZPIHTuONUOi2uNT0mGoB7vb8mv/Qnw1FPqonrz5AK6x9V
         0Q0rRbBP5Pps+FUof2IRJOesrS2EyL1BYDgBua6mRHEMC4zSswPp5RWmFjktgkoaO5wP
         sOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946240; x=1783551040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wiT6IchzYo0pZI6BwQ69eT32M2XHj1el/xogHD0SjIo=;
        b=QxRpprrvK8lZpaPGYkGs6ZIWtuGQjzB+7jCQx/CG5KrAbyCt/wN6tTfZ3e70rhTV2S
         UCWerEZbrLTy5hNGI8KX5iWqtzW3joMuo/rJIpVNjggP5QjfKN5dyL7zsMNdnheDMgAZ
         2k1UKmFgBTGU8szLIdO6mkQ91VG2hOro+8EF5enw28eBxuwdTgcOqEup0twHEwB5UEy9
         PVUQYz4I2NAANIBbqVTGqsuNWdASYXf5xSxsx1GxMiAna4ltfIEFomCtZcXG0tl81k+P
         yNyzZhMn9oBsPDnJ2W9EN4lnCUI8kXmsye2z5uCzM9sJxEMrV1ABrc82Pw03d4dXDTIc
         /sVw==
X-Gm-Message-State: AOJu0YxcRB0YjzYGncLnTvTKcmqNpe2IeyHUdbDSPvYlSLXQ+9khik0G
	WhlXGcJSrShvvNUeidUo05cpKWQ9R9yvQft/WF5ln28mqXpDA9FS5+W2ueMHrFbI0VN82IBhlgC
	rYT8CRds=
X-Gm-Gg: AfdE7clp47HOaApN8yLpMzPKNWYnBJWwMPWM5XVstLEEBRawMMdU/vZFJ24AWCryTp+
	3uIsTas1/yXinxi6YV7KJBnWQ0dqL8rAZBg8cOMU/Tv1PivwQBjOteFPXe6YtwQY2YRQ9uAujxf
	7zxdLvf17/PbyfWehVBxT24qQ2GlKwNnNwpg5A81fkadYQhNUVQqVWlBuvnFFa2j84FkQyW09rC
	+k2UUszO9LHu0gg3s9y/VyqI2608R70LVdqoEb1+xxqg6qpToTeBvewcq8dOdnJpILvSrRZcIP1
	7VqQnjHJvnzQa+Xr7Jf4BmNinBV9uYhV0ILwaxaZA+QatZaJILl7iMT2rL3b7Br/xWqi3BacqUh
	/e304j9X1KkMQnYVLlTTgmsWK9lt88U8klcE0v9QKvqxj4Mj5DEhpGMprqxxibWlrTA879ypDpU
	De3y/KRoL5e8qQr9xzOx80574DCp1Ub3IA+jQKqg==
X-Received: by 2002:a05:6214:1c81:b0:8e7:efa5:31df with SMTP id 6a1803df08f44-8f423530d68mr42189276d6.34.1782946239692;
        Wed, 01 Jul 2026 15:50:39 -0700 (PDT)
Received: from krios.home.ca.int.haoyugu.com ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm12064736d6.44.2026.07.01.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:50:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Add arena-based bitmap data structure
Date: Wed,  1 Jul 2026 18:50:32 -0400
Message-ID: <20260701225034.12628-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701225034.12628-1-emil@etsalapatis.com>
References: <20260701225034.12628-1-emil@etsalapatis.com>
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

