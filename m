Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5A326958
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537794; cv=none; b=X7T82jXXh8ztT/crGNEIuZGd2LssNB3EJfvJEDirXjlqkwna3khxMghr2zF5tXn6iaeIRTf/ethjB691O0SB7GzY7pgccFSfLaD1vo+XapoVLPCTROhMDsJAKnf0fJUSL1Wq50aIKYa0oMW7zWyNkpzBPOw0rNFlWUqxo7U4n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537794; c=relaxed/simple;
	bh=r1c8FXsNGWbxLhCwaM076uZhUsAM1yQCjQdsao4ieXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZMeC0tsq0lOGFQq4VzculECXvO+UojjNWk2w2DM9wrT8aSNPXFAx6UO7R2Ov4DrkEMooib3mZv5WIUiiJ+Lal0mXotqFCjYdDZCv+S03ykGxMSNxHPPZpdxSOiTIYiJReYwWarj6XwPAyL88ppb+oh/V/K4S6fcfzB66WGSUKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=eKmVMMeW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="eKmVMMeW"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5032e15525aso10392271cf.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537790; x=1770142590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv5w3LnVIRnGyfYqOnrkrLWQonCJcg4awAhy7e+rDd8=;
        b=eKmVMMeW5hptWcuzG61aNTXiCWlCo0Qq1QNUDdOPvoFsqqIU0YzzMX05tkN+1zw3DW
         HhHC8S1Uxu2TqV5uNPTvANw8A3BhispNpySGPiAlsYl+Zk0IG6sTX0DV6w2o+oV4t9Zk
         NIASrejcJAEjMf7IX4GmrVKb/Wpl23mdVBTv1oSTHdOhUGn0WtxyuauV9+sLpBFNk2hk
         PTFCsp+33c4BCFkwDFRliM+tKZgOgBRUydZUKggKk9hoNKDVg/QAXWDxbK1bm7ocokVY
         0KcIowkqqS+ESxVuhqUeFjh5JQ/eEQVbktQdXFLsTnInoY//vV1OhmI5NB8eCbQaCMzw
         pNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537790; x=1770142590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vv5w3LnVIRnGyfYqOnrkrLWQonCJcg4awAhy7e+rDd8=;
        b=e1+XMLoqrI6xOxHCc8coM8N7XP5MkYD4AZOjdyoQuGB4rM9Ax+wZAYLIPaQl/kSBUa
         Eut0fZ38QuTE6yp5L2/LxOpqsGiDCpJ747BRu/u+f5jU9BrEcLUXTtS6Lc9CA867UcEg
         BwScB9IFth+OZirXOpEYFQ6da5zSlSai/tmYi1dUISu3fUsEFa0xlv7fu6V3Eq0edC9T
         x9WDLAGV2MRhKk5FovfNqUI82iR2SWX8Q3LEn/O/hWB+xcj7+YUZFikz+mrkt9snqLaM
         J9fj8lelKqL0sXK3KQvq6aTmt15heVnal6jsk9Ok1nGBQVQlY6PVaQ9AysA5BY8JFUcz
         oVag==
X-Gm-Message-State: AOJu0Yw0U5sK65enotcTzLHQYI9Qp5Jjm0NyFazZg56Qr2GNWINGFAs5
	7bVN0OkhhZiISWuF5CwpuCLJvgr1nUL477vz/3Q2h4G+sg4dXwn1hcH4F2Yu5McvMvo0RJA1sPS
	B4+Rj
X-Gm-Gg: AZuq6aJEtRAAwJItSTqBLeyKnK6b0f2kwfJ++RHwluJxPf0nUX+xQbxdWf/+hnF55Xc
	H9DTVWGlma1teiW3+mGZyqSHYo1kq8CQKGnpDZY99qO3gXS6Dp6HHmrijYt87HYKFIJeNVvLVMX
	1iWl0+VSq+QS8QohRjv775bs9KVvW5WoGkTMzNszQmPWpn+i8Qho9FoIkIkI2pdwYs1gP9GXPaT
	5st/6V+MFhcshgOhRmXHdTSrnjCBfT4HqfbBl2A9Y83bqarLzGHvLh6BGJgJHWlc8RBTQ6HNlc/
	gi/QZH+hpEiexAWxaA1CQkjVF5fVG+ZDpD3WeHbaLxfsFsXVyP2T9bI1vUZc5YgMO0JSDVnpHaf
	GAlnEc9Wauad/7Tk2gVF9xDzp0QhAHU1oYFWz8cmn12B/QklQBsF3qmilJ2o8uOZhvycBJqB26F
	KM6ngNm74e0g==
X-Received: by 2002:ac8:5ac2:0:b0:4ed:b441:d866 with SMTP id d75a77b69052e-5032fb1e141mr33911811cf.65.1769537790045;
        Tue, 27 Jan 2026 10:16:30 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:29 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 06/13] selftests: bpf: Add arena ASAN runtime to libarena
Date: Tue, 27 Jan 2026 13:16:02 -0500
Message-ID: <20260127181610.86376-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add an address sanitizer (ASAN) runtime to the arena library. The
ASAN runtime implements the functions injected into BPF binaries
by LLVM sanitization is supported and enabled.

The runtime also includes functions called explicitly by memory
allocation code to mark memory as poisoned/unpoisoned to ASAN.
This code is a no-op when sanitization is turned off.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 .../selftests/bpf/libarena/include/asan.h     | 133 +++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 463 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 96b4a7e37427..3d176d3b2cc1 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -49,3 +49,4 @@ verification_cert.h
 *.BTF_ids
 *.BTF.base
 libarena/test_libarena
+libarena/test_libarena_asan
diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/testing/selftests/bpf/libarena/include/asan.h
new file mode 100644
index 000000000000..be50b23fb491
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/asan.h
@@ -0,0 +1,133 @@
+#pragma once
+
+struct asan_init_args {
+	u64 arena_all_pages;
+	u64 arena_globals_pages;
+};
+
+int asan_init(struct asan_init_args *args);
+
+/* Parameters usable by userspace. */
+extern volatile u64 __asan_shadow_memory_dynamic_address;
+extern volatile bool asan_reported;
+extern volatile bool asan_inited;
+extern volatile bool asan_report_once;
+extern volatile bool asan_emit_stack;
+
+#ifdef __BPF__
+
+#define ASAN_SHADOW_SHIFT 3
+#define ASAN_SHADOW_SCALE (1ULL << ASAN_SHADOW_SHIFT)
+#define ASAN_GRANULE_MASK ((1ULL << ASAN_SHADOW_SHIFT) - 1)
+#define ASAN_GRANULE(addr) ((s8)((u32)(u64)((addr)) & ASAN_GRANULE_MASK))
+
+#define __noasan __attribute__((no_sanitize("address"))) 
+
+#ifdef BPF_ARENA_ASAN
+
+/* 
+ * Defined as char * to get 1-byte granularity for pointer arithmetic.
+ */
+typedef s8 __arena s8a;
+
+/*
+ * Address to shadow map translation.
+ */
+static inline 
+s8a *mem_to_shadow(void __arena __arg_arena *addr)
+{
+	return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) + __asan_shadow_memory_dynamic_address);
+}
+
+/*
+ * Helper for directly reading the shadow map.
+ */
+static inline __noasan
+s8 asan_shadow_value(void __arena __arg_arena *addr) 
+{
+	return *(s8a *)mem_to_shadow(addr);
+}
+
+__weak __noasan
+bool asan_ready(void)
+{
+	return __asan_shadow_memory_dynamic_address;
+}
+
+/*
+ * Shadow map manipulation helpers.
+ */
+int asan_poison(void __arena *addr, s8 val, size_t size);
+int asan_unpoison(void __arena *addr, size_t size);
+bool asan_shadow_set(void __arena *addr);
+s8 asan_shadow_value(void __arena *addr);
+
+/*
+ * Dummy calls to ensure the ASAN runtime's BTF information is present
+ * in every object file when compiling the runtime and local BPF code
+ * separately. The runtime calls are injected into the LLVM IR file 
+ */
+#define DECLARE_ASAN_LOAD_STORE_SIZE(size)				\
+	void __asan_store##size(void *addr);				\
+	void __asan_store##size##_noabort(void *addr);	\
+	void __asan_load##size(void *addr);				\
+	void __asan_load##size##_noabort(void *addr);	\
+	void __asan_report_store##size(void *addr);			\
+	void __asan_report_store##size##_noabort(void *addr);		\
+	void __asan_report_load##size(void *addr);			\
+	void __asan_report_load##size##_noabort(void *addr);		
+
+DECLARE_ASAN_LOAD_STORE_SIZE(1);
+DECLARE_ASAN_LOAD_STORE_SIZE(2);
+DECLARE_ASAN_LOAD_STORE_SIZE(4);
+DECLARE_ASAN_LOAD_STORE_SIZE(8);
+
+#define DECLARE_ASAN_LOAD_STORE(size)				\
+	void __asan_store##size(void *addr);			\
+	void __asan_store##size##_noabort(void *addr);		\
+	void __asan_load##size(void *addr);			\
+	void __asan_load##size##_noabort(void *addr);		\
+	void __asan_report_store##size(void *addr);		\
+	void __asan_report_store##size##_noabort(void *addr);	\
+	void __asan_report_load##size(void *addr);		\
+	void __asan_report_load##size##_noabort(void *addr);		
+
+#define ASAN_DUMMY_CALLS_SIZE(size, arg)		\
+do {							\
+	__asan_store##size((arg));			\
+	__asan_store##size##_noabort((arg));		\
+	__asan_load##size((arg));			\
+	__asan_load##size##_noabort((arg));		\
+	__asan_report_store##size((arg));		\
+	__asan_report_store##size##_noabort((arg));	\
+	__asan_report_load##size((arg));		\
+	__asan_report_load##size##_noabort((arg));	\
+} while (0)	
+
+#define ASAN_DUMMY_CALLS_ALL(arg)	\
+do { 					\
+	ASAN_DUMMY_CALLS_SIZE(1, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(2, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(4, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(8, (arg));	\
+} while (0)
+
+__weak __attribute__((no_sanitize_address))
+int asan_dummy_call() {
+	/* Use the shadow map base to prevent it from being optimized out. */
+	if (__asan_shadow_memory_dynamic_address) 
+		ASAN_DUMMY_CALLS_ALL(NULL);
+
+	return 0;
+}
+#else /* BPF_ARENA_ASAN */
+
+static inline int asan_poison(void __arena *addr, s8 val, size_t size) { return 0; }
+static inline int asan_unpoison(void __arena *addr, size_t size) { return 0; }
+static inline bool asan_shadow_set(void __arena *addr) { return 0; }
+static inline s8 asan_shadow_value(void __arena *addr) { return 0; }
+__weak bool asan_ready(void) { return true; }
+
+#endif /* BPF_ARENA_ASAN */
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
new file mode 100644
index 000000000000..34b62c6e0aae
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -0,0 +1,463 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+#include <common.h>
+#include <asan.h>
+
+#ifdef BPF_ARENA_ASAN
+
+#pragma clang attribute push(__attribute__((no_sanitize("address"))), \
+			     apply_to = function)
+
+#define SHADOW_ALL_ZEROES ((u64)-1)
+
+/*
+ * Canary variable for ASAN violations. Set to the offending address.
+ */
+volatile u64 asan_violated = 0;
+
+/*
+ * Shadow map occupancy map.
+ */
+volatile u64 __asan_shadow_memory_dynamic_address;
+
+volatile bool asan_reported = false;
+volatile bool asan_inited = false;
+
+/*
+ * Set during program load.
+ */
+volatile bool asan_report_once = false;
+volatile bool asan_emit_stack = false;
+
+/*
+ * BPF does not currently support the memset/memcpy/memcmp intrinsics.
+ */
+__always_inline int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
+{
+	int i;
+
+	/*
+	 * Switching this to a may_goto confuses the verifier and
+	 * prevents verification on bpf-next as of late December 2025.
+	 */
+	bpf_for(i, 0, size) {
+		dst[i] = val;
+	}
+
+	return 0;
+}
+
+/* Validate a 1-byte access, always within a single byte. */
+static __always_inline bool memory_is_poisoned_1(s8a *addr)
+{
+	s8 shadow_value = asan_shadow_value(addr);
+
+	/* Byte is 0, access is valid. */
+	if (likely(!shadow_value))
+		return false;
+
+	/* 
+	 * Byte is non-zero. Access is valid if granule offset in [0, shadow_value),
+	 * so the memory is poisoned if shadow_value is negative or smaller than
+	 * the granule's value.
+	 */
+
+	return ASAN_GRANULE(addr) >= shadow_value;
+}
+
+/* Validate a 2- 4-, 8-byte access, spans up to 2 bytes. */
+static __always_inline bool memory_is_poisoned_2_4_8(s8a *addr, u64 size)
+{
+	u64 end = (u64)addr + size - 1;
+
+	/*
+	 * Region fully within a single byte (addition didn't
+	 * overflow above ASAN_GRANULE).
+	 */
+	if (likely(ASAN_GRANULE(end) >= size - 1))
+		return memory_is_poisoned_1((s8a *)end);
+
+	/*
+	 * Otherwise first byte must be fully unpoisoned, and second byte
+	 * must be unpoisoned up to the end of the accessed region.
+	 */
+
+	return asan_shadow_value(addr) || memory_is_poisoned_1((s8a *)end);
+}
+
+/*
+ * Explicit ASAN check.
+ */
+__weak bool asan_shadow_set(void __arena __arg_arena *addr)
+{
+	return memory_is_poisoned_1(addr);
+}
+
+static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
+{
+	while (size && can_loop) {
+		if (unlikely(*(s8a *)addr))
+			return addr;
+		addr += 1;
+		size -= 1;
+	}
+
+	return SHADOW_ALL_ZEROES;
+}
+
+static __always_inline bool memory_is_poisoned_n(s8a *addr, u64 size)
+{
+	u64 ret;
+	u64 start;
+	u64 end;
+
+	/* Size of [start, end] is end - start + 1. */
+	start = (u64)mem_to_shadow(addr);
+	end = (u64)mem_to_shadow(addr + size - 1);
+
+	ret = first_nonzero_byte(start, (end - start) + 1);
+	if (likely(ret == SHADOW_ALL_ZEROES))
+		return false;
+
+	return __builtin_expect(ret != end || ASAN_GRANULE(addr + size - 1) >=
+						      *(s8a *)end, false);
+}
+
+static __always_inline int asan_report(s8a __arg_arena *addr, size_t sz,
+				       bool write)
+{
+	/* Only report the first ASAN violation. */
+	if (asan_reported && asan_report_once)
+		return 0;
+
+	asan_reported = true;
+
+	asan_violated = (u64)addr;
+
+	if (asan_emit_stack) {
+		arena_stderr("Memory violation for address %p (0x%lx) for %s of size %ld",
+				addr, (u64)addr, write ? "write" : "read", sz);
+		bpf_stream_print_stack();
+	}
+
+	return 0;
+}
+
+static __always_inline bool check_asan_args(s8a *addr, size_t size,
+					    bool *result)
+{
+	bool valid = true;
+
+	/* Size 0 accesses are valid even if the address is invalid. */
+	if (unlikely(size == 0))
+		goto confirmed_valid;
+
+	/*
+	 * Wraparound is possible for extremely high size. Possible if the size
+	 * is a misinterpreted negative number.
+	 */
+	if (unlikely(addr + size < addr))
+		goto confirmed_invalid;
+
+	return false;
+
+confirmed_invalid:
+	valid = false;
+
+	/* FALLTHROUGH */
+confirmed_valid:
+	*result = valid;
+
+	return true;
+}
+
+static __always_inline bool check_region_inline(void *ptr, size_t size,
+						bool write)
+{
+	s8a *addr = (s8a *)(u64)ptr;
+	bool is_poisoned, is_valid;
+
+	if (check_asan_args(addr, size, &is_valid)) {
+		if (!is_valid)
+			asan_report(addr, size, write);
+		return is_valid;
+	}
+
+	switch (size) {
+	case 1:
+		is_poisoned = memory_is_poisoned_1(addr);
+		break;
+	case 2:
+	case 4:
+	case 8:
+		is_poisoned = memory_is_poisoned_2_4_8(addr, size);
+		break;
+	default:
+		is_poisoned = memory_is_poisoned_n(addr, size);
+	}
+
+	if (is_poisoned) {
+		asan_report(addr, size, write);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __alias is not supported for BPF so define *__noabort() variants as wrappers.
+ */
+#define DEFINE_ASAN_LOAD_STORE(size)                                           \
+	__hidden void __asan_store##size(void *addr)                           \
+	{                                                                      \
+		check_region_inline(addr, size, true);                         \
+	}                                                                      \
+	__hidden void __always_inline __asan_store##size##_noabort(void *addr) \
+	{                                                                      \
+		check_region_inline(addr, size, true);                         \
+	}                                                                      \
+	__hidden void __asan_load##size(void *addr)                            \
+	{                                                                      \
+		check_region_inline(addr, size, false);                        \
+	}                                                                      \
+	__hidden void __asan_load##size##_noabort(void *addr)                  \
+	{                                                                      \
+		check_region_inline(addr, size, false);                        \
+	}                                                                      \
+	__hidden void __asan_report_store##size(void *addr)                    \
+	{                                                                      \
+		asan_report((s8a *)addr, size, true);                          \
+	}                                                                      \
+	__hidden void __asan_report_store##size##_noabort(void *addr)          \
+	{                                                                      \
+		asan_report((s8a *)addr, size, true);                          \
+	}                                                                      \
+	__hidden void __asan_report_load##size(void *addr)                     \
+	{                                                                      \
+		asan_report((s8a *)addr, size, false);                         \
+	}                                                                      \
+	__hidden void __asan_report_load##size##_noabort(void *addr)           \
+	{                                                                      \
+		asan_report((s8a *)addr, size, false);                         \
+	}
+
+DEFINE_ASAN_LOAD_STORE(1);
+DEFINE_ASAN_LOAD_STORE(2);
+DEFINE_ASAN_LOAD_STORE(4);
+DEFINE_ASAN_LOAD_STORE(8);
+
+void __asan_storeN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, true);
+}
+
+void __asan_loadN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, false);
+}
+
+/*
+ * We currently do not sanitize globals.
+ */
+void __asan_register_globals(void *globals, size_t n)
+{
+}
+
+void __asan_unregister_globals(void *globals, size_t n)
+{
+}
+
+/*
+ * We do not currently have memcpy/memmove/memset intrinsics
+ * in LLVM. Do not implement sanitization.
+ */
+void *__asan_memcpy(void *d, const void *s, size_t n)
+{
+	return NULL;
+}
+
+void *__asan_memmove(void *d, const void *s, size_t n)
+{
+	return NULL;
+}
+
+void *__asan_memset(void *p, int c, size_t n)
+{
+	return NULL;
+}
+
+/*
+ * Poisoning code, used when we add more freed memory to the allocator by:
+ * 	a) pulling memory from the arena segment using bpf_arena_alloc_pages()
+ * 	b) freeing memory from application code
+ */
+__hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t size)
+{
+	s8a *shadow;
+	size_t len;
+
+	/*
+	 * Poisoning from a non-granule address makes no sense: We can only allocate
+	 * memory to the application that with a granule-aligned starting address,
+	 * and bpf_arena_alloc_pages returns page-aligned memory. A non-aligned
+	 * addr then implies we're freeing a different address than the one we
+	 * allocated.
+	 */
+	if (unlikely((u64)addr & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	/*
+	 * We cannot free an unaligned region because it'd be possible that we
+	 * cannot describe the resulting poisoning state of the granule in 
+	 * the ASAN encoding.
+	 *
+	 * Every granule represents a region of memory that looks like the
+	 * following (P for poisoned bytes, C for clear):
+	 *
+	 * <Clear>  <Poisoned>
+	 * [ C C C ... P P ]
+	 *
+	 * The value of the granule's shadow map is the number of clear bytes in
+	 * it. We cannot represent granules with the following state:
+	 *
+	 * [ P P ... C C ... P P ]
+	 *
+	 * That would be possible if we could free unaligned regions, so prevent that.
+	 * 
+	 */
+	if (unlikely(size & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	shadow = mem_to_shadow(addr);
+	len = size >> ASAN_SHADOW_SHIFT;
+
+	asan_memset(shadow, val, len);
+
+	return 0;
+}
+
+/*
+ * Unpoisoning code for marking memory as valid during allocation calls.
+ *
+ * Very similar to asan_poison, except we need to round up instead of
+ * down, the partially poison the last granule if necessary.
+ *
+ * Partial poisoning is useful for keeping the padding poisoned. Allocations
+ * are granule-aligned, so we we're reserving granule-aligned sizes for the
+ * allocation. However, we want to still treat accesses to the padding as 
+ * invalid. Partial poisoning takes care of that. Freeing and poisoning the
+ * memory is still done in granule-aligned sizes and repoisons the already
+ * poisoned padding.
+ */
+__hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
+{
+	size_t partial = size & ASAN_GRANULE_MASK;
+	s8a *shadow;
+	size_t len;
+
+	/*
+	 * We cannot allocate in the middle of the granule. The ASAN shadow
+	 * map encoding only describes regions of memory where every granule
+	 * follows this format (P for poisoned, C for clear):
+	 *
+	 * <Clear>  <Poisoned>
+	 * [ C C C ... P P ]
+	 *
+	 * This is so we can use a single number in [0, ASAN_SHADOW_SCALE)
+	 * to represent the poison state of the granule.
+	 */
+	if (unlikely((u64)addr & ASAN_GRANULE_MASK))
+		return -EINVAL;
+
+	shadow = mem_to_shadow(addr);
+	len = size >> ASAN_SHADOW_SHIFT;
+
+	asan_memset(shadow, 0, len);
+
+	/* 
+	 * If we are allocating a non-granule aligned region, we need to adjust
+	 * the last byte of the shadow map to list how many bytes in the granule
+	 * are unpoisoned. If the region is aligned, then the memset call above
+	 * was enough.
+	 */
+	if (partial)
+		shadow[len] = partial;
+
+	return 0;
+}
+
+/*
+ * Initialize ASAN state when necessary. Triggered from userspace before
+ * allocator startup.
+ */
+SEC("syscall")
+__hidden __noasan int asan_init(struct asan_init_args *args)
+{
+	u64 globals_pages = args->arena_globals_pages;
+	u64 all_pages = args->arena_all_pages;
+	u64 shadowmap, shadow_pgoff;
+	u64 shadow_pages;
+
+	if (asan_inited)
+		return 0;
+
+	/* 
+	 * Round up the shadow map size to the nearest page.
+	 */
+	shadow_pages = all_pages >> ASAN_SHADOW_SHIFT;
+	if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) -1 )))
+		shadow_pages += 1;
+
+	/*
+	 * Make sure the numbers provided by userspace are sane.
+	 */
+	if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
+		bpf_printk("error: arena size %lx too large", all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages > all_pages) {
+		bpf_printk("error: globals %lx do not fit in arena %lx", globals_pages, all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages + shadow_pages > all_pages) {
+		bpf_printk("error: globals %lx do not leave room for shadow map %lx (arena pages %lx)",
+			globals_pages, shadow_pages, all_pages);
+		return -EINVAL;
+	}
+
+	shadow_pgoff = all_pages - shadow_pages - globals_pages;
+	__asan_shadow_memory_dynamic_address = shadow_pgoff * __PAGE_SIZE;
+
+	/* 
+	 * Allocate the last (1/ASAN_GRANULE_SIZE)th of an arena's pages for the map
+	 * We find the offset and size from the arena map.
+	 *
+	 * The allocated map pages are zeroed out, meaning all memory is marked as valid
+	 * even if it's not allocated already. This is expected: Since the actual memory
+	 * pages are not allocated, accesses to it will trigger page faults and will be
+	 * reported through BPF streams. Any pages allocated through bpf_arena_alloc_pages
+	 * should be poisoned by the allocator right after the call succeeds.
+	 */
+	shadowmap = (u64)bpf_arena_alloc_pages(
+		&arena, (void __arena *)__asan_shadow_memory_dynamic_address,
+		shadow_pages, NUMA_NO_NODE, 0);
+	if (!shadowmap) {
+		arena_stderr("Could not allocate shadow map\n");
+		return -ENOMEM;
+	}
+
+	asan_inited = true;
+
+	return 0;
+}
+
+#pragma clang attribute pop
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

