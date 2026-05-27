Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C33BB122
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866111; cv=none; b=tEtBizPs1nsHUarznfDrisAHcUoPUSk2LMd6Ov7HLr7V502cowYxpwWKGkLntzYHoOarrG6D443bYppD142BegUSKnQqcytwCRHSAxcMPr0u9qbNgNXMAJ+GseAZpgq5ipqqdnmIdAuc+O0AchDuX/xRJrjBOWuIRbU4EdcOhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866111; c=relaxed/simple;
	bh=5ByTPlsnFQpCfUcSMj7HMMVd6dHcLEB3+dHzlM6xYi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/qLpN5PZ7lCMcy4f2Y5FfVPeH8d7oTE8N+d27O7WzwE0R3zrqvL4UGqeIGpQwLAkKOaTbLZIEGlt2AWsdADOwHXJ0DmVOUnVO+1UhgZgo1mba/9aQvpgtYf6kOJ1jRT+Owo0+1DDkZ/xmbUD9AWBMMJypHprnDf38iBHp7ZuHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=g9JROqqY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="g9JROqqY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bc85eda6b6so57791565ad.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866109; x=1780470909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv3NzAEAfv7gYlQI1wvqtcgyVtc+hYsgkN5NB3Jmy8c=;
        b=g9JROqqYDL5OfL15AvX37xRHVVVIUwSptM8N1G7k9FpNVaFW7b1iChuPK008kw43vr
         GGMjbEMAgPOBII/7siITPzkfWoeWP9GDtbJrIHQZ9ve9k0uWUW4naSrAFIB2DuvaRl3x
         hwieUSwIo9iNkOznsZcJneSYDoYoOQUoqBPq3jcEW9/9MC1yifVkvoWPTffH58lF689b
         PYgXBcy6R/RP10cP38c3anCtqHoh+RCfWVz27V83ITH5IT8jIyWlfXLBPJAgZm8RrJD6
         1+GbuZGlm/vOGYeTTSMrwdHY4bmHAMwV5kd5w5DKVIY4mOy7UAQn3afGt49rR5O6pDGR
         d/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866109; x=1780470909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bv3NzAEAfv7gYlQI1wvqtcgyVtc+hYsgkN5NB3Jmy8c=;
        b=mPgxIMukQiB6ooGDrWmdOa+kVs1Ek27pJp1lXVIxWgK9DU2k3oFGebfnwKhVFbJQrS
         F7NBzmO1kIAPjAUcy73DZuRyX5RUqu0GPIINtEZDLY/UCjy/khJPbWfwlfsUF+PzAr77
         tK5nPNZ+ClSVN1tgjbnlj9BZnccXjwP7+GdcgyPpGJXOf4syuqJHLI5l32NO7gdPJ7ln
         pDSbFGqmrQtmr7gym1o/IuyYfreXfIFQOY6Zwu2RKWD63c3nePR1yMTMkO/TYGYy60Xj
         LsCg6vmkmZGE+91XHqNttOgmMy/uFXd97LMsOc+zRFLFGSZmnVnX/V1wv8MajA70aVsz
         EmsQ==
X-Gm-Message-State: AOJu0Ywx9LG0B5uFKLHe/sKJKpGL+upVyf3HbZTXGfGWtixjf9QExS9B
	aWYqQNNrYDus9eWHE+xTqfHn/DW0mN22YlhPFZ8nD4viflvo96re0DXOIgAYAboUN/VRt0O8gHS
	/QRRSRbNKhQ==
X-Gm-Gg: Acq92OF5wpI1bNm6CILD7kAg1R6ylDKYeTQDDfNevnLzPqezTCko7cQrnCULnA8KRCM
	8DLWbc9nAQu6Cfkd1uTVtlDmw2dw0EzOX49++LMERNW9Q1TKN1Tb9D0RUPnCpZl25YZ4dReXvJL
	t4xMOZt8NcXMk6oqY8uuQ/FBGkeqbdEUkjZQDlHeUt9e6u7iyC1NBZQYh0Gyj23X0Iby8g5yaUP
	mVVn4aXS8Jr7Kbw1rE4UGoycZDkboJSk5RuBfxeghvOX7PDe/nOGzaA6TdKyBPdEtCzznMUWsyE
	7/Ilrx7P6ZJd5wTEnJcHZKLkNQiyBzVOmKG8Mh1m2HVB6CDT3c4dC1c+yCxaRTfmDyEY4UU8Z1k
	3UVHhHkmlntQenKPdeMVm/nh9BHcNTrTZV0tHqPUbmE5RdHjf2plR89Nad2/p0xHwD3yrhCenHJ
	qSFca7/aPoDOrf0m8v9sdmtB68
X-Received: by 2002:a17:903:1b70:b0:2bc:cf06:6835 with SMTP id d9443c01a7336-2beb0346047mr233283375ad.8.1779866108983;
        Wed, 27 May 2026 00:15:08 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:08 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/5] selftests/bpf: libarena: make all typedefs pointer-based
Date: Wed, 27 May 2026 03:14:55 -0400
Message-ID: <20260527071457.4598-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071457.4598-1-emil@etsalapatis.com>
References: <20260527071457.4598-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of moving to annotation-free BPF arena code, move all typedefs
in libarena to wrap the pointer of the type instead of the type itself,
e.g., moving from

typedef struct example __arena example_t;

to

typedef struct example * __arena example_t;

This is to properly propagate to the typedef the new btf_type_tag("arena")
added in the __arena annotation. Type tags are only carried by pointer
types. We want to use the tag at BTF parsing time to determine whether
a function argument or return value is arena-based or not, without
having the programmer explicitly add the type tag. This is all possible
by using a typedef'ed pointer type for the argument or return value.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/asan.h      |  8 +-
 .../bpf/libarena/include/libarena/buddy.h     | 18 ++---
 .../libarena/selftests/test_asan_buddy.bpf.c  |  4 +-
 .../bpf/libarena/selftests/test_asan_common.h |  2 +-
 .../bpf/libarena/selftests/test_buddy.bpf.c   |  2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     | 38 ++++-----
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 78 +++++++++----------
 .../selftests/bpf/libarena/src/common.bpf.c   |  4 +-
 8 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/asan.h b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
index eb9fc69d9eb0..247b0f40707a 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
@@ -25,13 +25,13 @@ extern volatile bool asan_report_once;
 
 #ifdef BPF_ARENA_ASAN
 
-typedef s8 __arena s8a;
+typedef s8 __arena *s8a;
 
 static inline
-s8a *mem_to_shadow(void __arena __arg_arena *addr)
+s8a mem_to_shadow(void __arena *addr)
 {
-	return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) +
-			__asan_shadow_memory_dynamic_address);
+	return (s8a)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) +
+		     __asan_shadow_memory_dynamic_address);
 }
 
 __weak __noasan
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 00e2437128ef..1c69817f1540 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -3,10 +3,10 @@
 #pragma once
 
 struct buddy_chunk;
-typedef struct buddy_chunk __arena buddy_chunk_t;
+typedef struct buddy_chunk __arena *buddy_chunk_t;
 
 struct buddy_header;
-typedef struct buddy_header __arena buddy_header_t;
+typedef struct buddy_header __arena *buddy_header_t;
 
 enum buddy_consts {
 	/*
@@ -68,24 +68,24 @@ struct buddy_chunk {
 	u8		allocated[BUDDY_CHUNK_ITEMS / 8];
 	/* Freelists for O(1) allocation. */
 	u64		freelists[BUDDY_CHUNK_NUM_ORDERS];
-	buddy_chunk_t	*next;
+	buddy_chunk_t	next;
 };
 
 struct buddy {
-	buddy_chunk_t *first_chunk;		/* Pointer to the chunk linked list. */
+	buddy_chunk_t first_chunk;		/* Pointer to the chunk linked list. */
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 };
 
-typedef struct buddy __arena buddy_t;
+typedef struct buddy __arena *buddy_t;
 
 #ifdef __BPF__
 
-int buddy_init(buddy_t *buddy);
-int buddy_destroy(buddy_t *buddy);
-int buddy_free_internal(buddy_t *buddy, u64 free);
+int buddy_init(buddy_t buddy);
+int buddy_destroy(buddy_t buddy);
+int buddy_free_internal(buddy_t buddy, u64 free);
 #define buddy_free(buddy, ptr) buddy_free_internal((buddy), (u64)(ptr))
-u64 buddy_alloc_internal(buddy_t *buddy, size_t size);
+u64 buddy_alloc_internal(buddy_t buddy, size_t size);
 #define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
 
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
index 71d1885cf2e1..256d62a03ce7 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
@@ -8,7 +8,7 @@
 /* Required for parsing the ASAN call stacks. */
 #include "test_progs_compat.h"
 
-extern buddy_t buddy;
+extern struct buddy __arena buddy;
 
 #ifdef BPF_ARENA_ASAN
 
@@ -54,7 +54,7 @@ static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
  * Factored out because asan_validate_addr is complex enough to cause
  * verification failures if verified with the rest of asan_test_buddy_uaf_single.
  */
-__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool freed)
+__weak int asan_test_buddy_byte(u8 __arena *mem, int i, bool freed)
 {
 	int ret;
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
index 1d3edc4372ac..b360efb8c566 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
@@ -9,7 +9,7 @@ static inline void print_asan_map_state(void __arena *addr)
 {
 	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
 			__func__, __LINE__, addr,
-			*(s8a *)(addr), ASAN_GRANULE(addr),
+			*(s8a)(addr), ASAN_GRANULE(addr),
 			asan_shadow_set(addr) ? "yes" : "no");
 }
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 79e6f0baabfe..b45a306816c0 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -6,7 +6,7 @@
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
 
-extern buddy_t buddy;
+extern struct buddy __arena buddy;
 
 struct segarr_entry {
 	u8 __arena *block;
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index 64c5b990086c..4d81a0dcdd5f 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -110,7 +110,7 @@ volatile bool asan_report_once = false;
  * to exit due to a missing implementation. Provide a simple implementation
  * just for memset to use it for poisoning/unpoisoning the map.
  */
-__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
+__weak int asan_memset(s8a dst, s8 val, size_t size)
 {
 	size_t i;
 
@@ -121,9 +121,9 @@ __weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
 }
 
 /* Validate a 1-byte access, always within a single byte. */
-static __always_inline bool memory_is_poisoned_1(s8a *addr)
+static __always_inline bool memory_is_poisoned_1(s8a addr)
 {
-	s8 shadow_value = *(s8a *)mem_to_shadow(addr);
+	s8 shadow_value = *mem_to_shadow(addr);
 
 	/* Byte is 0, access is valid. */
 	if (likely(!shadow_value))
@@ -139,7 +139,7 @@ static __always_inline bool memory_is_poisoned_1(s8a *addr)
 }
 
 /* Validate a 2- 4-, 8-byte access, shadow spans up to 2 bytes. */
-static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size)
+static __always_inline bool memory_is_poisoned_2_4_8(s8a addr, u64 size)
 {
 	u64 end = (u64)addr + size - 1;
 
@@ -148,17 +148,17 @@ static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size)
 	 * overflow above ASAN_GRANULE).
 	 */
 	if (likely(ASAN_GRANULE(end) >= size - 1))
-		return memory_is_poisoned_1((s8a *)end);
+		return memory_is_poisoned_1((s8a)end);
 
 	/*
 	 * Otherwise first byte must be fully unpoisoned, and second byte
 	 * must be unpoisoned up to the end of the accessed region.
 	 */
 
-	return *(s8a *)mem_to_shadow(addr) || memory_is_poisoned_1((s8a *)end);
+	return *mem_to_shadow(addr) || memory_is_poisoned_1((s8a)end);
 }
 
-__weak bool asan_shadow_set(void __arena __arg_arena *addr)
+__weak bool asan_shadow_set(void __arena *addr)
 {
 	return memory_is_poisoned_1(addr);
 }
@@ -166,7 +166,7 @@ __weak bool asan_shadow_set(void __arena __arg_arena *addr)
 static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
 {
 	while (size && can_loop) {
-		if (unlikely(*(s8a *)addr))
+		if (unlikely(*(s8a)addr))
 			return addr;
 		addr += 1;
 		size -= 1;
@@ -175,7 +175,7 @@ static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
 	return SHADOW_ALL_ZEROES;
 }
 
-static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
+static __always_inline bool memory_is_poisoned_n(s8a addr, u64 size)
 {
 	u64 ret;
 	u64 start;
@@ -189,10 +189,10 @@ static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
 	if (likely(ret == SHADOW_ALL_ZEROES))
 		return false;
 
-	return unlikely(ret != end || ASAN_GRANULE(addr + size - 1) >= *(s8a *)end);
+	return unlikely(ret != end || ASAN_GRANULE(addr + size - 1) >= *(s8a)end);
 }
 
-__weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
+__weak int asan_report(s8a addr, size_t sz, u32 flags)
 {
 	u32 reported = __sync_val_compare_and_swap(&asan_reported, false, true);
 
@@ -211,7 +211,7 @@ __weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
 	return 0;
 }
 
-static __always_inline bool check_asan_args(s8a *addr, size_t size,
+static __always_inline bool check_asan_args(s8a addr, size_t size,
 					    bool *result)
 {
 	bool valid = true;
@@ -253,7 +253,7 @@ static __always_inline bool check_asan_args(s8a *addr, size_t size,
 static __always_inline bool check_region_inline(intptr_t ptr, size_t size,
 						u32 flags)
 {
-	s8a *addr = (s8a *)(u64)ptr;
+	s8a addr = (s8a)(u64)ptr;
 	bool is_poisoned, is_valid;
 
 	if (check_asan_args(addr, size, &is_valid)) {
@@ -305,19 +305,19 @@ static __always_inline bool check_region_inline(intptr_t ptr, size_t size,
 	}                                                             \
 	__hidden void __asan_report_store##size(intptr_t addr)           \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+		asan_report((s8a)addr, size, ASAN_WRITE);            \
 	}                                                             \
 	__hidden void __asan_report_store##size##_noabort(intptr_t addr) \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+		asan_report((s8a)addr, size, ASAN_WRITE);            \
 	}                                                             \
 	__hidden void __asan_report_load##size(intptr_t addr)            \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_READ);            \
+		asan_report((s8a)addr, size, ASAN_READ);             \
 	}                                                             \
 	__hidden void __asan_report_load##size##_noabort(intptr_t addr)  \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_READ);            \
+		asan_report((s8a)addr, size, ASAN_READ);             \
 	}
 
 DEFINE_ASAN_LOAD_STORE(1);
@@ -385,7 +385,7 @@ void *__asan_memset(void *p, int c, size_t n)
  */
 __hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
 {
-	s8a *shadow;
+	s8a shadow;
 	size_t len;
 
 	/*
@@ -443,7 +443,7 @@ __hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
 __hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
 {
 	size_t partial = size & ASAN_GRANULE_MASK;
-	s8a *shadow;
+	s8a shadow;
 	size_t len;
 
 	/*
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 865e00803daa..2e565327b748 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -45,12 +45,12 @@ enum {
 	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE
 };
 
-static inline int buddy_lock(buddy_t *buddy)
+static inline int buddy_lock(buddy_t buddy)
 {
 	return arena_spin_lock(&buddy->lock);
 }
 
-static inline void buddy_unlock(buddy_t *buddy)
+static inline void buddy_unlock(buddy_t buddy)
 {
 	arena_spin_unlock(&buddy->lock);
 }
@@ -61,7 +61,7 @@ static inline void buddy_unlock(buddy_t *buddy)
  * page alloc kfuncs do not support aligning to a boundary (in this
  * case 1 MiB, see buddy.h on how this is derived).
  */
-static int buddy_reserve_arena_vaddr(buddy_t *buddy)
+static int buddy_reserve_arena_vaddr(buddy_t buddy)
 {
 	buddy->vaddr = 0;
 
@@ -73,7 +73,7 @@ static int buddy_reserve_arena_vaddr(buddy_t *buddy)
 /*
  * Free up any unused address space. Used only during teardown.
  */
-static void buddy_unreserve_arena_vaddr(buddy_t *buddy)
+static void buddy_unreserve_arena_vaddr(buddy_t buddy)
 {
 	bpf_arena_free_pages(
 		&arena, (void __arena *)(BUDDY_VADDR_OFFSET + buddy->vaddr),
@@ -94,7 +94,7 @@ static void buddy_unreserve_arena_vaddr(buddy_t *buddy)
  * However, bump allocation must still be atomic because this function
  * is called without the buddy lock from multiple threads concurrently.
  */
-__weak int buddy_alloc_arena_vaddr(buddy_t __arg_arena *buddy, u64 *vaddrp)
+__weak int buddy_alloc_arena_vaddr(buddy_t buddy, u64 *vaddrp)
 {
 	u64 vaddr, old, new;
 
@@ -134,7 +134,7 @@ static u64 arena_next_pow2(__u64 n)
 }
 
 __weak
-int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool allocated)
+int idx_set_allocated(buddy_chunk_t chunk, u64 idx, bool allocated)
 {
 	bool already_allocated;
 
@@ -160,7 +160,7 @@ int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool allocated)
 	return 0;
 }
 
-static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocated)
+static int idx_is_allocated(buddy_chunk_t chunk, u64 idx, bool *allocated)
 {
 	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
 		arena_stderr("getting state of invalid idx (%llu, max %d)\n", idx,
@@ -173,7 +173,7 @@ static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocated)
 }
 
 __weak
-int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
+int idx_set_order(buddy_chunk_t chunk, u64 idx, u8 order)
 {
 	u8 prev_order;
 
@@ -206,7 +206,7 @@ int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
 	return 0;
 }
 
-static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
+static u8 idx_get_order(buddy_chunk_t chunk, u64 idx)
 {
 	u8 result;
 
@@ -223,7 +223,7 @@ static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
 	return (idx & 0x1) ? (result & 0xf) : (result >> 4);
 }
 
-static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
+static void __arena *idx_to_addr(buddy_chunk_t chunk, size_t idx)
 {
 	u64 address;
 
@@ -246,7 +246,7 @@ static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
 	return (void __arena *)address;
 }
 
-static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
+static buddy_header_t idx_to_header(buddy_chunk_t chunk, size_t idx)
 {
 	bool allocated;
 	u64 address;
@@ -283,13 +283,13 @@ static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
 	 * less probable.
 	 */
 
-	return (buddy_header_t *)(address + BUDDY_HEADER_OFF);
+	return (buddy_header_t)(address + BUDDY_HEADER_OFF);
 }
 
-static void header_add_freelist(buddy_chunk_t *chunk, buddy_header_t *header,
+static void header_add_freelist(buddy_chunk_t chunk, buddy_header_t header,
 		u64 idx, u8 order)
 {
-	buddy_header_t *tmp_header;
+	buddy_header_t tmp_header;
 
 	idx_set_order(chunk, idx, order);
 
@@ -304,10 +304,10 @@ static void header_add_freelist(buddy_chunk_t *chunk, buddy_header_t *header,
 	chunk->freelists[order] = idx;
 }
 
-static void header_remove_freelist(buddy_chunk_t  *chunk,
-				   buddy_header_t *header, u8 order)
+static void header_remove_freelist(buddy_chunk_t chunk,
+				   buddy_header_t header, u8 order)
 {
-	buddy_header_t *tmp_header;
+	buddy_header_t tmp_header;
 
 	if (header->prev_index != BUDDY_CHUNK_ITEMS) {
 		tmp_header = idx_to_header(chunk, header->prev_index);
@@ -356,10 +356,10 @@ static u64 size_to_order(size_t size)
 }
 
 __weak
-int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_idx,
+int add_leftovers_to_freelist(buddy_chunk_t chunk, u32 cur_idx,
 		u64 min_order, u64 max_order)
 {
-	buddy_header_t *header;
+	buddy_header_t header;
 	u64 ord;
 	u32 idx;
 
@@ -381,10 +381,10 @@ int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_idx,
 	return 0;
 }
 
-static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
+static buddy_chunk_t buddy_chunk_get(buddy_t buddy)
 {
 	u64 order, ord, min_order, max_order;
-	buddy_chunk_t  *chunk;
+	buddy_chunk_t chunk;
 	size_t left;
 	int power2;
 	u64 vaddr;
@@ -561,9 +561,9 @@ static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
 	return chunk;
 }
 
-__weak int buddy_init(buddy_t __arg_arena *buddy)
+__weak int buddy_init(buddy_t buddy)
 {
-	buddy_chunk_t *chunk;
+	buddy_chunk_t chunk;
 	int ret;
 
 	if (!asan_ready())
@@ -602,9 +602,9 @@ __weak int buddy_init(buddy_t __arg_arena *buddy)
  * We do not take a lock because we are freeing arena pages, and nobody should
  * be using the allocator at that point in the execution.
  */
-__weak int buddy_destroy(buddy_t __arg_arena *buddy)
+__weak int buddy_destroy(buddy_t buddy)
 {
-	buddy_chunk_t *chunk, *next;
+	buddy_chunk_t chunk, next;
 
 	if (!buddy)
 		return -EINVAL;
@@ -631,9 +631,9 @@ __weak int buddy_destroy(buddy_t __arg_arena *buddy)
 	return 0;
 }
 
-__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order_req)
+__weak u64 buddy_chunk_alloc(buddy_chunk_t chunk, int order_req)
 {
-	buddy_header_t *header, *tmp_header, *next_header;
+	buddy_header_t header, tmp_header, next_header;
 	u32 idx, tmpidx, retidx;
 	u64 address;
 	u64 order = 0;
@@ -709,9 +709,9 @@ __weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order_req)
 }
 
 /* Scan the existing chunks for available memory. */
-static u64 buddy_alloc_from_existing_chunks(buddy_t *buddy, int order)
+static u64 buddy_alloc_from_existing_chunks(buddy_t buddy, int order)
 {
-	buddy_chunk_t *chunk;
+	buddy_chunk_t chunk;
 	u64 address;
 
 	for (chunk = buddy->first_chunk; chunk != NULL && can_loop;
@@ -728,7 +728,7 @@ static u64 buddy_alloc_from_existing_chunks(buddy_t *buddy, int order)
  * Try an allocation from a newly allocated chunk. Also
  * incorporate the chunk into the linked list.
  */
-static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chunk, int order)
+static u64 buddy_alloc_from_new_chunk(buddy_t buddy, buddy_chunk_t chunk, int order)
 {
 	u64 address;
 
@@ -750,9 +750,9 @@ static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chunk, int
 	return (u64)address;
 }
 __weak
-u64 buddy_alloc_internal(buddy_t __arg_arena *buddy, size_t size)
+u64 buddy_alloc_internal(buddy_t buddy, size_t size)
 {
-	buddy_chunk_t *chunk;
+	buddy_chunk_t chunk;
 	u64 address = (u64)NULL;
 	int order;
 
@@ -788,20 +788,20 @@ u64 buddy_alloc_internal(buddy_t __arg_arena *buddy, size_t size)
 	 * data is smaller than the header, we must poison any
 	 * unused bytes that were part of the header.
 	 */
-	if (size < BUDDY_HEADER_OFF + sizeof(buddy_header_t))
+	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
 		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF,
-			    BUDDY_POISONED, sizeof(buddy_header_t));
+			    BUDDY_POISONED, sizeof(struct buddy_header));
 
 	asan_unpoison((u8 __arena *)address, size);
 
 	return address;
 }
 
-static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
+static __always_inline int buddy_free_unlocked(buddy_t buddy, u64 addr)
 {
-	buddy_header_t *header, *buddy_header;
+	buddy_header_t header, buddy_header;
 	u64 idx, buddy_idx, tmp_idx;
-	buddy_chunk_t *chunk;
+	buddy_chunk_t chunk;
 	bool allocated;
 	u8 order;
 	int ret;
@@ -815,7 +815,7 @@ static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
 	}
 
 	/* Get (chunk, idx) out of the address. */
-	chunk = (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	chunk = (buddy_chunk_t)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
 	idx = (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
 
 	/* Mark the block as unallocated so we can access the header. */
@@ -878,7 +878,7 @@ static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
 	return 0;
 }
 
-__weak int buddy_free_internal(buddy_t __arg_arena *buddy, u64 addr)
+__weak int buddy_free_internal(buddy_t buddy, u64 addr)
 {
 	int ret;
 
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 544bf9e1cb38..96220c86a533 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -6,7 +6,7 @@
 
 const volatile u32 zero = 0;
 
-buddy_t buddy;
+struct buddy __arena buddy;
 
 int arena_fls(__u64 word)
 {
@@ -43,7 +43,7 @@ __weak u64 arena_malloc_internal(size_t size)
 	return buddy_alloc_internal(&buddy, size);
 }
 
-__weak void arena_free(void __arg_arena __arena *ptr)
+__weak void arena_free(void __arena *ptr)
 {
 	buddy_free_internal(&buddy, (u64)ptr);
 }
-- 
2.54.0

