Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA63B47CA
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994186; cv=none; b=DUEvXMAD20jTEsD3pCIDKGzNBPhfPbKdZr2SSbK3JbmOtV80EpTfMkC4jhvL/S4WkJWLycOyG+qfhJ7P0VNpgvoeS28gAFmP+B+z2HSAKKBSW7A8FPp550baIs+xwWnDDLjca2Lc1qFByCbNPXZgtwnFYMB0RsBXu0vKikdFnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994186; c=relaxed/simple;
	bh=429xQOvEBFCjm9LV+CS5Rx+SUuxAkpGIFJ1KcVj+a2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOSzdylGL7kOcR1SfUhWH6quLyJJ8BXRCdgR4Qkl/aQ+CxOZWY3HnK7ZfB1uQmHouNacxMs04MgCMqPNNQuYS2hDo4o8lF7UdhmTLgiLhJDapDkHOs3vgVWqdDKS3PFs/NZC30hMzTUwKkpazMmnM2Pnu4gzh5lqAftP5HITXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gOSyX9D1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gOSyX9D1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38f620399a0so3309564a91.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994184; x=1787598984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItRtt45Idhaw8OdyPawqlqj1V3qPrgThh6wy4qmbEWE=;
        b=gOSyX9D1/B81DN8u1B0h26oLyxdzkHffLl2fl2yGIPqqWH5l9FNq7Jw96Ay4YpxHsH
         blyqAKWnM9DwEFgIDAlLzjuszfM3sf1wGlssz+XmK7CIswkVVmIiZ8+avJxVzwhFJluH
         FyJ225cZn8PUYPfpC/G2Y7w1nyF3rK7ilCXj7XBajPJ6FsHcWhKaIJDs+Q2+njrt9S/D
         Slwu/nOHU5W4XutPl55dx2QcM5ShZVH32pxy9vgslbR03rQx0PkmQTNIzFWR/ZmGxu1R
         i6B03jmnuUWePhqBCmhD8ZlcnBwNYOnyXB48s5CHzi6DNZNoMBl/q72hf7jboch6B9YI
         ZLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994184; x=1787598984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItRtt45Idhaw8OdyPawqlqj1V3qPrgThh6wy4qmbEWE=;
        b=jyl3cAsb0ebXTqtCZDTgnPmmtXWNGVqS7mYH9s+pPS0v+wEN7FpFiyUSre2Z0i4cxf
         2H5PHZVf1+uRTzj+ddXTXh7pxFHfF2lTDn3G7I0XNFWZb9XdCrqx9glNf1wZCveX0+RO
         QyCTTGEa6azr6A4kRPLAsQuorw80Q+xLR3By1Tlza4BcYNFYrPu9jadPQvARDHHyfpEy
         kNtENsR0eKmync2biBRDuyY6CL7x+V652hoiRuotToDonsoHxBOmsDYhk+ubChJo+Rdl
         6WU4qxaVNMjdD5Qtnp//GMPkLL1h78zw4P9gnL5BqqU39qKMk1J+7fYs+qMto2eBIsJu
         a9iA==
X-Gm-Message-State: AOJu0YxwwZvwExM1sTuOrZg/U/o/w+koLikAiYF6+/JRCJDcp5fvz3JD
	w6y9pKMa9jGRpEz6jth7Vgh57Fcj4ecZfKmTjuajfB0KzA/Rre/LBHPe+IbfLE2LugXcm52pfwq
	t1p3H1kg=
X-Gm-Gg: AR+sD11yC8ojJSZiAACkirxqzWEhFpVByN9mzEPPfj5piIAKfkcIZLvI9Bhbfw4EZpM
	keePZW2iRXXMjQvL1HfgwkHnQK2u4WXHeCNQyFcxf8EsbTX/r2gbYdjKMdmrSQ+ITolrG4CPq9j
	LWV78H1JwXsUtf9eHgBD2j+ROI6fD9ztd4+oowcQNmkOMYUjaSX0a7iF8nceg/P9BFCy0Zm6T8U
	d6iIrCPPVxtVPcteMof0fPJwMyBkiHWS8DZEmLVR5ceeXZoUcLbibjngVbfTbI3ADQR4LOiMJYi
	qFk4s41c06gZHLqUIc5IN3eszTvPPgum5iYOx5YuzVH4uArd13ek1+i4gYHvQGZ9IrFkdVD7YXG
	cpsXoRXp2hkuQgzUt2RRENFbVqZ9zmgP2Pv8Dfw2KiZZuVe9ALXQLqIyMz9iq8YViAFy+p4hxqy
	Li7GRkez186m9yT8MicI/M14U3KOfH6VGU2EBBs3JdLNi9/JjkFmqooFn0Mc+GyZtnytSX+z5kR
	WOFf7sc7osdmM/xOQMaVIs=
X-Received: by 2002:a17:90b:4fce:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3955a3dd55fmr2892814a91.1.1786994183974;
        Mon, 17 Aug 2026 12:16:23 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 4/6] selftests/bpf: libarena: Add calloc() call
Date: Mon, 17 Aug 2026 15:16:14 -0400
Message-ID: <20260817191616.11071-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena memory allocator currently does not provide the
option to zero-initialize the allocated memory. Provide
a calloc() operation that calls memset() on the returned
memory. Reuse naive memset implementation already present
in the arena ASAN code for now. Subsequent patches will
optimize the function.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/common.h    | 18 +++++++++++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 21 ++-------------
 .../selftests/bpf/libarena/src/common.bpf.c   | 27 ++++++++++++++++++-
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index 931ace9a49e2..d32a51ff5e7f 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -49,6 +49,7 @@ extern volatile u64 asan_violated;
 int arena_fls(__u64 word);
 
 void __arena *arena_malloc(size_t size);
+void __arena *arena_calloc(size_t ncount, size_t size);
 void arena_free(void __arena *ptr);
 
 /*
@@ -61,6 +62,23 @@ void arena_free(void __arena *ptr);
  */
 #define arena_subprog_init() do { asm volatile ("" :: "r"(&arena)); } while (0)
 
+/*
+ * BPF does not currently support the memset intrinsics. for large
+ * sequential copies, or assignments of large data structures,
+ * the frontend will generate an intrinsic that causes the BPF
+ * backend to exit due to a missing implementation. Provide
+ * implementations for the intrinsic.
+ */
+static inline int arena_memset(s8 __arena *dst, s8 val, size_t size)
+{
+	size_t i;
+
+	for (i = zero; i < size && can_loop; i++)
+		dst[i] = val;
+
+	return 0;
+}
+
 #else /* ! __BPF__ */
 
 #include <stdint.h>
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index 5135d5c72a46..de656b69d13a 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -103,23 +103,6 @@ volatile bool asan_inited = false;
  */
 volatile bool asan_report_once = false;
 
-/*
- * BPF does not currently support the memset/memcpy/memcmp intrinsics.
- * For large sequential copies, or assignments of large data structures,
- * the frontend will generate an intrinsic that causes the BPF backend
- * to exit due to a missing implementation. Provide a simple implementation
- * just for memset to use it for poisoning/unpoisoning the map.
- */
-__weak int asan_memset(s8 __arena *dst, s8 val, size_t size)
-{
-	size_t i;
-
-	for (i = zero; i < size && can_loop; i++)
-		dst[i] = val;
-
-	return 0;
-}
-
 /* Validate a 1-byte access, always within a single byte. */
 static __always_inline bool memory_is_poisoned_1(s8 __arena *addr)
 {
@@ -422,7 +405,7 @@ __hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
 	shadow = mem_to_shadow(addr);
 	len = size >> ASAN_SHADOW_SHIFT;
 
-	asan_memset(shadow, val, len);
+	arena_memset(shadow, val, len);
 
 	return 0;
 }
@@ -463,7 +446,7 @@ __hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
 	shadow = mem_to_shadow(addr);
 	len = size >> ASAN_SHADOW_SHIFT;
 
-	asan_memset(shadow, 0, len);
+	arena_memset(shadow, 0, len);
 
 	/*
 	 * If we are allocating a non-granule aligned region, we need to adjust
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 569f0f64d518..785d4872cb49 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <limits.h>
+
 #include <libarena/common.h>
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
@@ -48,10 +50,33 @@ __weak void __arena *arena_malloc(size_t size)
 	return buddy_alloc(&buddy, size);
 }
 
+__weak void __arena *arena_calloc(size_t ncount, size_t size)
+{
+	void __arena *mem;
+	size_t total;
+
+	/*
+	 * Ideally we'd be using __builtin_mul_overflow here,
+	 * but the BPF compiler backend doesn't implement __multi3.
+	 * There are ways to optimize the division away from the
+	 * overflow check, but any costs are dwarfed by the
+	 * buddy_alloc() call. Keep it simple for now.
+	 */
+	if (unlikely(ncount && size >= ULLONG_MAX / ncount))
+		return NULL;
+
+	total = ncount * size;
+
+	mem = buddy_alloc(&buddy, total);
+	if (likely(mem))
+		arena_memset(mem, 0, total);
+
+	return mem;
+}
+
 __weak void arena_free(void __arena *ptr)
 {
 	buddy_free(&buddy, ptr);
 }
 
-
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

