Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121F20299B
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100597; cv=none; b=YvEVkTzhDp6Y0tc92iIOQG2NqLFJTaHn57w9VptTvrueSz+qURU4/wib2z8fToTTWnDEf+w2Y+WAUsv8w7oed8yZQPWzKsEGvJGntUrGcF5sPxhfzXOaKH1ECjhNl1BY0mmm7I7u3GlpFNLg/HosAUT4byIOsbFnanVS2CM3KAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100597; c=relaxed/simple;
	bh=3UizIRaglwJN9NuPKlNJFb9wJHii74fNMZ1jqAMdD7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td9gPtg0c7ldO1yjpZ/xfcinKTpGE7zn6raIaAz/a3450mcSx6Kdj/gRS+uyHv65KFqbIdWI0UmCGvb7GqNXbLgY4KoPzx9xXdNMzKzRCt0ztARcSNRahe3OZD00OzVc9+BsFt2jDHmhY77XUUohUKPKTohk2Wfmouy9I4/r51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kevZr2BA; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kevZr2BA"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137bd9ed2b1so2258207c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100593; x=1780705393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT/m9rJou/4qBic6xZ96O9/cka8KwJqTlVEAKnKxq9A=;
        b=kevZr2BA22zdaZct4RUsVaG/J2OXos8WVGzhE0J8Gk2fc28iJhLRGe1mHIzspIqVKp
         5eeqCRDOrDWpVk1pl2MWFIIUvmNwD6BDwf4nYEkPD5OMHU+/lPxsvT8EySFX5LKrrkt4
         eZ7FgJF9TOtGw277XtmLyUYRamndaBmo67KTBHyp8fXdTJjuc7jg5fQ1UfmQNFTgVZRV
         tzjyoBYY3Sfp6C3WcuLNbfP1MIk8j+k1kDsmKxyA9dw3bSerSfoN+xfcJjbqF5AVr3cS
         Nc3y4R0QU980JwiSSwaRsLFQ+VkyckAZbyg3tklwWGDqtr4/kGXuYaX7JQQQSZ/HP4jM
         7Gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100593; x=1780705393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OT/m9rJou/4qBic6xZ96O9/cka8KwJqTlVEAKnKxq9A=;
        b=ZUfP7VooXdl1w7XU1Q9GyyogmhKvkj36M8db9VAzyQ7fGx9ZOIVcMoRn+Wxrm1n70V
         cayy1gkpmdjjC7VUBj9VaiN0/HHdIQTv15vKO9NWxWPW0SycHK8mdHQUpVO+A8SrtG92
         V/vpVRQg4BcPLO9R8+t3Ha4zBpLsIIliF2CbNSqTvuuFhYpj4t6ePhoiv3LP3m48DaVv
         df2dOyRzuBLqgIFbJJ0Wt1E6L3qthH/2BueFjfZB0CtEM263Fr6uYMHZWCGJ/eGU7Ju6
         B3uGmvw1/iwYA93pYBv6pnG9/+PLfUg0x/jGm6ptULR1dAiHseGJEM/lRELxjpn31s9O
         nKIg==
X-Gm-Message-State: AOJu0YyR+ZXW2UvNbjzWI5flOmy3tJWMGBKRftg0ZqWp7ZYMwHxSoJGf
	weYlYg2jraLJd0rhQUhTgBw6cpV1fnFgEpnWyVJD8XuO/5rV8nTIkSlbTjmLO4X90ntxQGNPUVN
	3yxrGXb6RCTCw
X-Gm-Gg: Acq92OE3yf+MIn9XD1+9asDzV2vxrKouyMueQYHM3YNF7wtLeZuvXyynP/ZOrTRJ+BR
	UODkaJm40zf6Rf4eaGRkQHFfQE8cnpSyJmZR1WfiFexWc9vqalz1LyfDCfgWm7aMD61ZehQJP8J
	HDYXPZ0upVAvyx9XZchf9GD/pg/ZN0g/U0maTQVI3lpjdcUIVTn2uSfY7+wfqY6conO+PMudIsq
	99Kq/nQcWdhPv426nYuuq3BxhPC82HfjZKZmBgDilhZcPfidLNrotiViesISGmm6UHYkAdjIWlC
	aQZemxvhTXUAwXqyzlm0apAEKjkTwtTw9Pc72L6oc7clyRBbGPAdR6AxmkyzowspG7w0hGs9cu6
	iX91AjPTeyqpWJI53wmbrbtt/BA8+1IHUBp5+I94nKA6UyJDUu6F9Wy35WkUaWn0mjBQowyrrPj
	K9CG/Y9MGQ9xdLBkugNV8+lO1q6ldekg==
X-Received: by 2002:a05:7022:fa0b:b0:12d:b66f:35d7 with SMTP id a92af1059eb24-137d3e11c21mr878816c88.10.1780100592846;
        Fri, 29 May 2026 17:23:12 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Remove __arg_arena from the codebase
Date: Fri, 29 May 2026 20:22:58 -0400
Message-ID: <20260530002259.4505-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530002259.4505-1-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that BPF __arg_arena has been subsumed by __arena, remove
__arg_arena from the codebase. This way the user has one fewer
annotation to worry about.

To remove __arg_arena we remove the typedefs we were previously
using to minimize __arena annotations. This is because __arena
now also includes a BTF type tag, which is ignored for non-pointer
types. As a result, we cannot capture the whole __arena annotation
inside a typedef and need to directly annotate the pointer type when
declaring the variable.

The extra verbosity is worth it because the use of the __arena tag
is intuitive to the programmer and removes the __arg_arena tag that
has been a consistent source of confusion for users. The typedefs
can be reintroduced later (without __arg_arena) once compilers start
supporting BTF type tags for non-pointer types.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 11 ++-
 .../selftests/bpf/bpf_arena_strsearch.h       |  4 +-
 .../bpf/libarena/include/bpf_arena_common.h   |  2 +-
 .../libarena/include/bpf_arena_spin_lock.h    |  6 +-
 .../bpf/libarena/include/libarena/asan.h      |  6 +-
 .../bpf/libarena/include/libarena/buddy.h     | 22 ++---
 .../libarena/selftests/st_asan_buddy.bpf.c    |  4 +-
 .../bpf/libarena/selftests/st_asan_common.h   |  2 +-
 .../bpf/libarena/selftests/st_buddy.bpf.c     |  2 +-
 .../selftests/bpf/libarena/src/asan.bpf.c     | 38 ++++-----
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 80 +++++++++----------
 .../selftests/bpf/libarena/src/common.bpf.c   |  6 +-
 .../selftests/bpf/progs/arena_spin_lock.c     |  1 +
 13 files changed, 84 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing/selftests/bpf/bpf_arena_htab.h
index acc01a876668..eb80d67c3870 100644
--- a/tools/testing/selftests/bpf/bpf_arena_htab.h
+++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
@@ -14,9 +14,8 @@ struct htab {
 	htab_bucket_t *buckets;
 	int n_buckets;
 };
-typedef struct htab __arena htab_t;
 
-static inline htab_bucket_t *__select_bucket(htab_t *htab, __u32 hash)
+static inline htab_bucket_t *__select_bucket(struct htab __arena *htab, __u32 hash)
 {
 	htab_bucket_t *b = htab->buckets;
 
@@ -24,7 +23,7 @@ static inline htab_bucket_t *__select_bucket(htab_t *htab, __u32 hash)
 	return &b[hash & (htab->n_buckets - 1)];
 }
 
-static inline arena_list_head_t *select_bucket(htab_t *htab, __u32 hash)
+static inline arena_list_head_t *select_bucket(struct htab __arena *htab, __u32 hash)
 {
 	return &__select_bucket(htab, hash)->head;
 }
@@ -53,7 +52,7 @@ static int htab_hash(int key)
 	return key;
 }
 
-__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
+__weak int htab_lookup_elem(struct htab __arena *htab __arg_arena, int key)
 {
 	hashtab_elem_t *l_old;
 	arena_list_head_t *head;
@@ -66,7 +65,7 @@ __weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
 	return 0;
 }
 
-__weak int htab_update_elem(htab_t *htab __arg_arena, int key, int value)
+__weak int htab_update_elem(struct htab __arena *htab __arg_arena, int key, int value)
 {
 	hashtab_elem_t *l_new = NULL, *l_old;
 	arena_list_head_t *head;
@@ -90,7 +89,7 @@ __weak int htab_update_elem(htab_t *htab __arg_arena, int key, int value)
 	return 0;
 }
 
-void htab_init(htab_t *htab)
+void htab_init(struct htab __arena *htab)
 {
 	void __arena *buckets = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
 
diff --git a/tools/testing/selftests/bpf/bpf_arena_strsearch.h b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
index f0d575daef5a..10a70667c8bf 100644
--- a/tools/testing/selftests/bpf/bpf_arena_strsearch.h
+++ b/tools/testing/selftests/bpf/bpf_arena_strsearch.h
@@ -3,7 +3,7 @@
 #pragma once
 #include <bpf_arena_common.h>
 
-__noinline int bpf_arena_strlen(const char __arena *s __arg_arena)
+__noinline int bpf_arena_strlen(const char __arena *s)
 {
 	const char __arena *sc;
 
@@ -40,7 +40,7 @@ __noinline int bpf_arena_strlen(const char __arena *s __arg_arena)
  *
  * An opening bracket without a matching close is matched literally.
  */
-__noinline bool glob_match(char const __arena *pat __arg_arena, char const __arena *str __arg_arena)
+__noinline bool glob_match(char const __arena *pat, char const __arena *str)
 {
 	/*
 	 * Backtrack to previous * on mismatch and retry starting one
diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
index 445be3c4edec..9e5b4616f796 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
@@ -38,7 +38,7 @@
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
 #else
-#define __arena
+#define __arena __attribute__((btf_type_tag("arena")))
 #define __arena_global SEC(".addr_space.1")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
 #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index 164638690a4d..ae6b72d15bb6 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -16,10 +16,6 @@
 #define EOPNOTSUPP 95
 #define ETIMEDOUT 110
 
-#ifndef __arena
-#define __arena __attribute__((address_space(1)))
-#endif
-
 extern unsigned long CONFIG_NR_CPUS __kconfig;
 
 /*
@@ -246,7 +242,7 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 }
 
 __noinline __weak
-int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
+int arena_spin_lock_slowpath(arena_spinlock_t __arena *lock, u32 val)
 {
 	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
 	int ret = -ETIMEDOUT;
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/asan.h b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
index eb9fc69d9eb0..900267159292 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
@@ -25,12 +25,10 @@ extern volatile bool asan_report_once;
 
 #ifdef BPF_ARENA_ASAN
 
-typedef s8 __arena s8a;
-
 static inline
-s8a *mem_to_shadow(void __arena __arg_arena *addr)
+s8 __arena *mem_to_shadow(void __arena *addr)
 {
-	return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) +
+	return (s8 __arena *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) +
 			__asan_shadow_memory_dynamic_address);
 }
 
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 00e2437128ef..4d57fc1b5c26 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -2,12 +2,6 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #pragma once
 
-struct buddy_chunk;
-typedef struct buddy_chunk __arena buddy_chunk_t;
-
-struct buddy_header;
-typedef struct buddy_header __arena buddy_header_t;
-
 enum buddy_consts {
 	/*
 	 * Minimum allocation is 1 << BUDDY_MIN_ALLOC_SHIFT.
@@ -68,25 +62,21 @@ struct buddy_chunk {
 	u8		allocated[BUDDY_CHUNK_ITEMS / 8];
 	/* Freelists for O(1) allocation. */
 	u64		freelists[BUDDY_CHUNK_NUM_ORDERS];
-	buddy_chunk_t	*next;
+	struct buddy_chunk __arena	*next;
 };
 
 struct buddy {
-	buddy_chunk_t *first_chunk;		/* Pointer to the chunk linked list. */
+	struct buddy_chunk __arena *first_chunk;		/* Pointer to the chunk linked list. */
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 };
 
-typedef struct buddy __arena buddy_t;
-
 #ifdef __BPF__
 
-int buddy_init(buddy_t *buddy);
-int buddy_destroy(buddy_t *buddy);
-int buddy_free_internal(buddy_t *buddy, u64 free);
-#define buddy_free(buddy, ptr) buddy_free_internal((buddy), (u64)(ptr))
-u64 buddy_alloc_internal(buddy_t *buddy, size_t size);
+int buddy_init(struct buddy __arena *buddy);
+int buddy_destroy(struct buddy __arena *buddy);
+int buddy_free(struct buddy __arena *buddy, void __arena *free);
+u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size);
 #define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
 
-
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
index 97acd50ffa5c..686caba2c643 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
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
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
index 1d3edc4372ac..34a7918cb4cf 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
@@ -9,7 +9,7 @@ static inline void print_asan_map_state(void __arena *addr)
 {
 	arena_stdout("%s:%d ASAN %p -> (val: %x gran: %x set: [%s])",
 			__func__, __LINE__, addr,
-			*(s8a *)(addr), ASAN_GRANULE(addr),
+			*(s8 __arena *)(addr), ASAN_GRANULE(addr),
 			asan_shadow_set(addr) ? "yes" : "no");
 }
 
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
index 79e6f0baabfe..b45a306816c0 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -6,7 +6,7 @@
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
 
-extern buddy_t buddy;
+extern struct buddy __arena buddy;
 
 struct segarr_entry {
 	u8 __arena *block;
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index 64c5b990086c..5135d5c72a46 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -110,7 +110,7 @@ volatile bool asan_report_once = false;
  * to exit due to a missing implementation. Provide a simple implementation
  * just for memset to use it for poisoning/unpoisoning the map.
  */
-__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
+__weak int asan_memset(s8 __arena *dst, s8 val, size_t size)
 {
 	size_t i;
 
@@ -121,9 +121,9 @@ __weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
 }
 
 /* Validate a 1-byte access, always within a single byte. */
-static __always_inline bool memory_is_poisoned_1(s8a *addr)
+static __always_inline bool memory_is_poisoned_1(s8 __arena *addr)
 {
-	s8 shadow_value = *(s8a *)mem_to_shadow(addr);
+	s8 shadow_value = *(s8 __arena *)mem_to_shadow(addr);
 
 	/* Byte is 0, access is valid. */
 	if (likely(!shadow_value))
@@ -139,7 +139,7 @@ static __always_inline bool memory_is_poisoned_1(s8a *addr)
 }
 
 /* Validate a 2- 4-, 8-byte access, shadow spans up to 2 bytes. */
-static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size)
+static __always_inline bool memory_is_poisoned_2_4_8(s8 __arena *addr, u64 size)
 {
 	u64 end = (u64)addr + size - 1;
 
@@ -148,17 +148,17 @@ static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size)
 	 * overflow above ASAN_GRANULE).
 	 */
 	if (likely(ASAN_GRANULE(end) >= size - 1))
-		return memory_is_poisoned_1((s8a *)end);
+		return memory_is_poisoned_1((s8 __arena *)end);
 
 	/*
 	 * Otherwise first byte must be fully unpoisoned, and second byte
 	 * must be unpoisoned up to the end of the accessed region.
 	 */
 
-	return *(s8a *)mem_to_shadow(addr) || memory_is_poisoned_1((s8a *)end);
+	return *(s8 __arena *)mem_to_shadow(addr) || memory_is_poisoned_1((s8 __arena *)end);
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
+		if (unlikely(*(s8 __arena *)addr))
 			return addr;
 		addr += 1;
 		size -= 1;
@@ -175,7 +175,7 @@ static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
 	return SHADOW_ALL_ZEROES;
 }
 
-static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
+static __always_inline bool memory_is_poisoned_n(s8 __arena *addr, u64 size)
 {
 	u64 ret;
 	u64 start;
@@ -189,10 +189,10 @@ static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
 	if (likely(ret == SHADOW_ALL_ZEROES))
 		return false;
 
-	return unlikely(ret != end || ASAN_GRANULE(addr + size - 1) >= *(s8a *)end);
+	return unlikely(ret != end || ASAN_GRANULE(addr + size - 1) >= *(s8 __arena *)end);
 }
 
-__weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
+__weak int asan_report(s8 __arena *addr, size_t sz, u32 flags)
 {
 	u32 reported = __sync_val_compare_and_swap(&asan_reported, false, true);
 
@@ -211,7 +211,7 @@ __weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
 	return 0;
 }
 
-static __always_inline bool check_asan_args(s8a *addr, size_t size,
+static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 					    bool *result)
 {
 	bool valid = true;
@@ -253,7 +253,7 @@ static __always_inline bool check_asan_args(s8a *addr, size_t size,
 static __always_inline bool check_region_inline(intptr_t ptr, size_t size,
 						u32 flags)
 {
-	s8a *addr = (s8a *)(u64)ptr;
+	s8 __arena *addr = (s8 __arena *)(u64)ptr;
 	bool is_poisoned, is_valid;
 
 	if (check_asan_args(addr, size, &is_valid)) {
@@ -305,19 +305,19 @@ static __always_inline bool check_region_inline(intptr_t ptr, size_t size,
 	}                                                             \
 	__hidden void __asan_report_store##size(intptr_t addr)           \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+		asan_report((s8 __arena *)addr, size, ASAN_WRITE);           \
 	}                                                             \
 	__hidden void __asan_report_store##size##_noabort(intptr_t addr) \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+		asan_report((s8 __arena *)addr, size, ASAN_WRITE);           \
 	}                                                             \
 	__hidden void __asan_report_load##size(intptr_t addr)            \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_READ);            \
+		asan_report((s8 __arena *)addr, size, ASAN_READ);            \
 	}                                                             \
 	__hidden void __asan_report_load##size##_noabort(intptr_t addr)  \
 	{                                                             \
-		asan_report((s8a *)addr, size, ASAN_READ);            \
+		asan_report((s8 __arena *)addr, size, ASAN_READ);            \
 	}
 
 DEFINE_ASAN_LOAD_STORE(1);
@@ -385,7 +385,7 @@ void *__asan_memset(void *p, int c, size_t n)
  */
 __hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
 {
-	s8a *shadow;
+	s8 __arena *shadow;
 	size_t len;
 
 	/*
@@ -443,7 +443,7 @@ __hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
 __hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
 {
 	size_t partial = size & ASAN_GRANULE_MASK;
-	s8a *shadow;
+	s8 __arena *shadow;
 	size_t len;
 
 	/*
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 865e00803daa..f4ed4c3abb4b 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -45,12 +45,12 @@ enum {
 	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE
 };
 
-static inline int buddy_lock(buddy_t *buddy)
+static inline int buddy_lock(struct buddy __arena *buddy)
 {
 	return arena_spin_lock(&buddy->lock);
 }
 
-static inline void buddy_unlock(buddy_t *buddy)
+static inline void buddy_unlock(struct buddy __arena *buddy)
 {
 	arena_spin_unlock(&buddy->lock);
 }
@@ -61,7 +61,7 @@ static inline void buddy_unlock(buddy_t *buddy)
  * page alloc kfuncs do not support aligning to a boundary (in this
  * case 1 MiB, see buddy.h on how this is derived).
  */
-static int buddy_reserve_arena_vaddr(buddy_t *buddy)
+static int buddy_reserve_arena_vaddr(struct buddy __arena *buddy)
 {
 	buddy->vaddr = 0;
 
@@ -73,7 +73,7 @@ static int buddy_reserve_arena_vaddr(buddy_t *buddy)
 /*
  * Free up any unused address space. Used only during teardown.
  */
-static void buddy_unreserve_arena_vaddr(buddy_t *buddy)
+static void buddy_unreserve_arena_vaddr(struct buddy __arena *buddy)
 {
 	bpf_arena_free_pages(
 		&arena, (void __arena *)(BUDDY_VADDR_OFFSET + buddy->vaddr),
@@ -94,7 +94,7 @@ static void buddy_unreserve_arena_vaddr(buddy_t *buddy)
  * However, bump allocation must still be atomic because this function
  * is called without the buddy lock from multiple threads concurrently.
  */
-__weak int buddy_alloc_arena_vaddr(buddy_t __arg_arena *buddy, u64 *vaddrp)
+__weak int buddy_alloc_arena_vaddr(struct buddy __arena *buddy, u64 *vaddrp)
 {
 	u64 vaddr, old, new;
 
@@ -134,7 +134,7 @@ static u64 arena_next_pow2(__u64 n)
 }
 
 __weak
-int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool allocated)
+int idx_set_allocated(struct buddy_chunk __arena *chunk, u64 idx, bool allocated)
 {
 	bool already_allocated;
 
@@ -160,7 +160,7 @@ int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool allocated)
 	return 0;
 }
 
-static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocated)
+static int idx_is_allocated(struct buddy_chunk __arena *chunk, u64 idx, bool *allocated)
 {
 	if (unlikely(idx >= BUDDY_CHUNK_ITEMS)) {
 		arena_stderr("getting state of invalid idx (%llu, max %d)\n", idx,
@@ -173,7 +173,7 @@ static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocated)
 }
 
 __weak
-int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
+int idx_set_order(struct buddy_chunk __arena *chunk, u64 idx, u8 order)
 {
 	u8 prev_order;
 
@@ -206,7 +206,7 @@ int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)
 	return 0;
 }
 
-static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
+static u8 idx_get_order(struct buddy_chunk __arena *chunk, u64 idx)
 {
 	u8 result;
 
@@ -223,7 +223,7 @@ static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
 	return (idx & 0x1) ? (result & 0xf) : (result >> 4);
 }
 
-static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
+static void __arena *idx_to_addr(struct buddy_chunk __arena *chunk, size_t idx)
 {
 	u64 address;
 
@@ -246,7 +246,7 @@ static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
 	return (void __arena *)address;
 }
 
-static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
+static struct buddy_header __arena *idx_to_header(struct buddy_chunk __arena *chunk, size_t idx)
 {
 	bool allocated;
 	u64 address;
@@ -283,13 +283,13 @@ static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
 	 * less probable.
 	 */
 
-	return (buddy_header_t *)(address + BUDDY_HEADER_OFF);
+	return (struct buddy_header __arena *)(address + BUDDY_HEADER_OFF);
 }
 
-static void header_add_freelist(buddy_chunk_t *chunk, buddy_header_t *header,
+static void header_add_freelist(struct buddy_chunk __arena *chunk, struct buddy_header __arena *header,
 		u64 idx, u8 order)
 {
-	buddy_header_t *tmp_header;
+	struct buddy_header __arena *tmp_header;
 
 	idx_set_order(chunk, idx, order);
 
@@ -304,10 +304,10 @@ static void header_add_freelist(buddy_chunk_t *chunk, buddy_header_t *header,
 	chunk->freelists[order] = idx;
 }
 
-static void header_remove_freelist(buddy_chunk_t  *chunk,
-				   buddy_header_t *header, u8 order)
+static void header_remove_freelist(struct buddy_chunk __arena  *chunk,
+				   struct buddy_header __arena *header, u8 order)
 {
-	buddy_header_t *tmp_header;
+	struct buddy_header __arena *tmp_header;
 
 	if (header->prev_index != BUDDY_CHUNK_ITEMS) {
 		tmp_header = idx_to_header(chunk, header->prev_index);
@@ -356,10 +356,10 @@ static u64 size_to_order(size_t size)
 }
 
 __weak
-int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_idx,
+int add_leftovers_to_freelist(struct buddy_chunk __arena *chunk, u32 cur_idx,
 		u64 min_order, u64 max_order)
 {
-	buddy_header_t *header;
+	struct buddy_header __arena *header;
 	u64 ord;
 	u32 idx;
 
@@ -381,10 +381,10 @@ int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_idx,
 	return 0;
 }
 
-static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
+static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 {
 	u64 order, ord, min_order, max_order;
-	buddy_chunk_t  *chunk;
+	struct buddy_chunk __arena  *chunk;
 	size_t left;
 	int power2;
 	u64 vaddr;
@@ -561,9 +561,9 @@ static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
 	return chunk;
 }
 
-__weak int buddy_init(buddy_t __arg_arena *buddy)
+__weak int buddy_init(struct buddy __arena *buddy)
 {
-	buddy_chunk_t *chunk;
+	struct buddy_chunk __arena *chunk;
 	int ret;
 
 	if (!asan_ready())
@@ -602,9 +602,9 @@ __weak int buddy_init(buddy_t __arg_arena *buddy)
  * We do not take a lock because we are freeing arena pages, and nobody should
  * be using the allocator at that point in the execution.
  */
-__weak int buddy_destroy(buddy_t __arg_arena *buddy)
+__weak int buddy_destroy(struct buddy __arena *buddy)
 {
-	buddy_chunk_t *chunk, *next;
+	struct buddy_chunk __arena *chunk, *next;
 
 	if (!buddy)
 		return -EINVAL;
@@ -631,9 +631,9 @@ __weak int buddy_destroy(buddy_t __arg_arena *buddy)
 	return 0;
 }
 
-__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order_req)
+__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 {
-	buddy_header_t *header, *tmp_header, *next_header;
+	struct buddy_header __arena *header, *tmp_header, *next_header;
 	u32 idx, tmpidx, retidx;
 	u64 address;
 	u64 order = 0;
@@ -709,9 +709,9 @@ __weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk, int order_req)
 }
 
 /* Scan the existing chunks for available memory. */
-static u64 buddy_alloc_from_existing_chunks(buddy_t *buddy, int order)
+static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int order)
 {
-	buddy_chunk_t *chunk;
+	struct buddy_chunk __arena *chunk;
 	u64 address;
 
 	for (chunk = buddy->first_chunk; chunk != NULL && can_loop;
@@ -728,7 +728,7 @@ static u64 buddy_alloc_from_existing_chunks(buddy_t *buddy, int order)
  * Try an allocation from a newly allocated chunk. Also
  * incorporate the chunk into the linked list.
  */
-static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chunk, int order)
+static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk, int order)
 {
 	u64 address;
 
@@ -750,10 +750,10 @@ static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chunk, int
 	return (u64)address;
 }
 __weak
-u64 buddy_alloc_internal(buddy_t __arg_arena *buddy, size_t size)
+u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
 {
-	buddy_chunk_t *chunk;
 	u64 address = (u64)NULL;
+	struct buddy_chunk __arena *chunk;
 	int order;
 
 	if (!buddy)
@@ -788,20 +788,20 @@ u64 buddy_alloc_internal(buddy_t __arg_arena *buddy, size_t size)
 	 * data is smaller than the header, we must poison any
 	 * unused bytes that were part of the header.
 	 */
-	if (size < BUDDY_HEADER_OFF + sizeof(buddy_header_t))
-		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF,
-			    BUDDY_POISONED, sizeof(buddy_header_t));
+	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
+		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF, BUDDY_POISONED,
+			    sizeof(struct buddy_header __arena));
 
 	asan_unpoison((u8 __arena *)address, size);
 
 	return address;
 }
 
-static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
+static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
-	buddy_header_t *header, *buddy_header;
+	struct buddy_header __arena *header, *buddy_header;
 	u64 idx, buddy_idx, tmp_idx;
-	buddy_chunk_t *chunk;
+	struct buddy_chunk __arena *chunk;
 	bool allocated;
 	u8 order;
 	int ret;
@@ -878,7 +878,7 @@ static __always_inline int buddy_free_unlocked(buddy_t *buddy, u64 addr)
 	return 0;
 }
 
-__weak int buddy_free_internal(buddy_t __arg_arena *buddy, u64 addr)
+__weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	int ret;
 
@@ -893,7 +893,7 @@ __weak int buddy_free_internal(buddy_t __arg_arena *buddy, u64 addr)
 	if (ret)
 		return ret;
 
-	ret = buddy_free_unlocked(buddy, addr);
+	ret = buddy_free_unlocked(buddy, (u64)addr);
 
 	buddy_unlock(buddy);
 
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 544bf9e1cb38..ec9de29e6f3e 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -6,7 +6,7 @@
 
 const volatile u32 zero = 0;
 
-buddy_t buddy;
+struct buddy __arena buddy;
 
 int arena_fls(__u64 word)
 {
@@ -43,9 +43,9 @@ __weak u64 arena_malloc_internal(size_t size)
 	return buddy_alloc_internal(&buddy, size);
 }
 
-__weak void arena_free(void __arg_arena __arena *ptr)
+__weak void arena_free(void __arena *ptr)
 {
-	buddy_free_internal(&buddy, (u64)ptr);
+	buddy_free(&buddy, ptr);
 }
 
 
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index 7236d92d382f..cf7cda79c16c 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include <bpf_arena_common.h>
 #include <bpf_arena_spin_lock.h>
 
 struct {
-- 
2.54.0

