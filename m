Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58F3612E7
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015960; cv=none; b=jEzw4Pkelbay4nkOKRiCnxMxR8x/J5U7zTpDf3kp+0cNY/Q5vF02jJzlqPXMeSbQE9oLupUQz9atx1xLmCsiTzXsu9tyzeJ1vk5NXV8hdQQpLhz+e0/iyTg1c44LF7EjPSDFFXBLhyVB5st82Kl6Cjvv78Mxg4vSXQMofAem+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015960; c=relaxed/simple;
	bh=DJKOT7sjqfLWe9s9ye+a9xfGV8J5Z3k1D0fJAdhFfX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg7ky9FJ9ct/jqEcYb+dk6oDC02/+StQ5w0n7uc35i3X6orgpj2D//SV5D7wP/Vb7wqzXD/aO7v7jLLI3u54FwL4ZS9QK0nsYDmUFTcnyq9vvzT9c7Y0eqEhXnmQwuLmZgGnuDjTitxFvMHU22scARAnVr1VX2/n1tVTt6986lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VOeE8umu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VOeE8umu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce49785a0so1551570b3a.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776015957; x=1776620757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUMIASdwGokYZAj6wdFVXrQnCMk/ommf1gMbY2Oq4/M=;
        b=VOeE8umuxPovppavkv5AqHUBjux3HXQUiv0Lu85q8uEivKXTzOkeILlmIe5O56ihOe
         mlz8UiAanGZkxmmVPJqYKf+COo8N9D55OX8067dFlc4Z7pqVgmR1zR+JLggqB74a/7NL
         aL8aetjxYdmQRiiuEqgQZxSvkQSGXxdUGn/XqXhocGjPo325uQIGcTcye4jGzAL2vhAc
         5CszMMS7qSykG/MT0JQlG5E5jlwwppC7hdnIN2sCx+9wjVGwbMydNfX6NBY7Fjxynt0+
         4TsK2GnyZRgV11H9inEKwHWI7p8WuLPfW2BS/jwzVrUI0E6OBZQ/U+NecK+JohyHVkHP
         hQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015957; x=1776620757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUMIASdwGokYZAj6wdFVXrQnCMk/ommf1gMbY2Oq4/M=;
        b=nXrlZcL3pqr3HceveTugTddngoPbjbOhRwCIir9W+eDvrU4BnBHWg6Q3xeVT5ClZs4
         67/OVroKUu6Glkf8wKWBchJgQkntfeLtGLDCAVjufVqq0UL4O8eKUepLNGQBgbu/DxIN
         pUmFjt0euBcVS79ThlOHrd3xnzuE1Q/zMN9SWvp9SkSIIJBeqBvKh8m9OWhAZ1bPSJbo
         DbhSVv2e0EyAIve11kDLofeQwkKOeOFc5exNeXIhuiVGzoBWiqqzBzXCqIi/ML7pxjD7
         7ar0sCA5XxYuzjartL5j0VoAcoHIksQBESOuK0/1g+76KXnxRt4KL0Tf78EfgXt6kIHj
         7WEw==
X-Gm-Message-State: AOJu0YzX/6TbsFbjj89rPu03QvI177ve/aw62dUt9YR0E2xTU6212aoI
	Ubz8a6sD4t8rSAAbZqp7FSP+fWhJMc3UVNelNVFXIYI80m5H4Qn+IbxlrVDEGr6qIxBbT3yQr/X
	cNmVjupk=
X-Gm-Gg: AeBDievL3dJgZY5Jv8LZcdBqY5WNE2coR1vaHS92Pl7FPjw1wkBilqlcVWs3wJrYzfB
	KCunuoBsfVeDCO8/hP7i4iiwr9FGoKKlDI8C39fqTrxr4K/tPIRlMPntO6aPyrc8y1BKmPyO3yF
	Hks+4jS9nfoBc5V0la7C9NAz7JLW46Od+hWkilTgq+ni0h6kTCcgX2OGJsNeHvoOiugB8PH+30C
	o5OnbQx1I08rdMOO7IicLNNj9t/Lg/mqHe10TtD5Q1Sg1EiACnsXRoEN9QG2CqQ41V2wrFyzfJW
	FSuwcN8vPt1PML7hvWFEWAvXE4xQpKaEr/c8jplMLfoLNC7THMilbjWRv4O5OGjBHoo0YSK7sqi
	vjBKnLdkbY8eQbRrE4TrKRxxT5KrOA6Fw0/8cmhr28JXt77knmht2V7gigFvhYcwWk+XtwuOAfy
	wLIg==
X-Received: by 2002:a05:6a00:2410:b0:82c:9126:320c with SMTP id d2e1a72fcca58-82f0c134898mr11585513b3a.3.1776015956662;
        Sun, 12 Apr 2026 10:45:56 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0df08c09sm8524099b3a.9.2026.04.12.10.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:45:56 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v7 6/9] selftests/bpf: Add arena ASAN runtime to libarena
Date: Sun, 12 Apr 2026 13:45:43 -0400
Message-ID: <20260412174546.18684-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an address sanitizer (ASAN) runtime to the arena library. The
ASAN runtime implements the functions injected into BPF binaries
by LLVM sanitization when ASAN is enabled during compilation.

The runtime also includes functions called explicitly by memory
allocation code to mark memory as poisoned/unpoisoned to ASAN.
This code is a no-op when sanitization is turned off.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/asan.h     | 118 ++++
 .../selftests/bpf/libarena/include/common.h   |   1 +
 .../selftests/bpf/libarena/src/asan.bpf.c     | 559 ++++++++++++++++++
 3 files changed, 678 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/testing/selftests/bpf/libarena/include/asan.h
new file mode 100644
index 000000000000..7ad1f6997c06
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/asan.h
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+struct asan_init_args {
+	u64 arena_all_pages;
+	u64 arena_globals_pages;
+};
+
+int asan_init(struct asan_init_args *args);
+
+extern volatile u64 __asan_shadow_memory_dynamic_address;
+extern volatile u32 asan_reported;
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
+typedef s8 __arena s8a;
+
+static inline
+s8a *mem_to_shadow(void __arena __arg_arena *addr)
+{
+	return (s8a *)(((u32)(u64)addr >> ASAN_SHADOW_SHIFT) +
+			__asan_shadow_memory_dynamic_address);
+}
+
+__weak __noasan
+bool asan_ready(void)
+{
+	return __asan_shadow_memory_dynamic_address;
+}
+
+int asan_poison(void __arena *addr, s8 val, size_t size);
+int asan_unpoison(void __arena *addr, size_t size);
+bool asan_shadow_set(void __arena *addr);
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
+void __asan_storeN(void *addr, ssize_t size);
+void __asan_storeN_noabort(void *addr, ssize_t size);
+void __asan_loadN(void *addr, ssize_t size);
+void __asan_loadN_noabort(void *addr, ssize_t size);
+
+/*
+ * Force LLVM to emit BTF information for the stubs,
+ * because the ASAN pass in LLVM by itself doesn't.
+ */
+#define ASAN_LOAD_STORE_SIZE(size)		\
+	__asan_store##size,			\
+	__asan_store##size##_noabort,		\
+	__asan_load##size,			\
+	__asan_load##size##_noabort,		\
+	__asan_report_store##size,		\
+	__asan_report_store##size##_noabort,	\
+	__asan_report_load##size,		\
+	__asan_report_load##size##_noabort
+
+/*
+ * Force LLVM to generate BTF information for the ASAN function
+ * declarations without invoking them. The used attribute prevents
+ * the function pointer table from being optimized out by the
+ * compiler.
+ */
+__attribute__((used))
+static void (*__asan_btf_anchors[])(void *) = {
+	ASAN_LOAD_STORE_SIZE(1),
+	ASAN_LOAD_STORE_SIZE(2),
+	ASAN_LOAD_STORE_SIZE(4),
+	ASAN_LOAD_STORE_SIZE(8)
+};
+
+__attribute__((used))
+static void (*__asan_btf_anchors_n[])(void *, ssize_t) = {
+	__asan_storeN,
+	__asan_storeN_noabort,
+	__asan_loadN,
+	__asan_loadN_noabort
+};
+
+#else /* BPF_ARENA_ASAN */
+
+static inline int asan_poison(void __arena *addr, s8 val, size_t size) { return 0; }
+static inline int asan_unpoison(void __arena *addr, size_t size) { return 0; }
+static inline bool asan_shadow_set(void __arena *addr) { return 0; }
+__weak bool asan_ready(void) { return true; }
+
+#endif /* BPF_ARENA_ASAN */
+
+#endif /* __BPF__ */
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
index f1cf34e34ae5..ccfc2bb94e59 100644
--- a/tools/testing/selftests/bpf/libarena/include/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -38,6 +38,7 @@ struct {
 } arena __weak SEC(".maps");
 
 extern const volatile u32 zero;
+extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
new file mode 100644
index 000000000000..fff12ff50f26
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <common.h>
+#include <asan.h>
+
+
+enum {
+	/*
+	 * Is the access checked by check_region_inline
+	 * a read or a write?
+	 */
+	ASAN_READ		= 0x0U,
+	ASAN_WRITE		= 0x1U,
+};
+
+/*
+ * Address sanitizer (ASAN) for arena-based BPF programs, inspired
+ * by KASAN.
+ *
+ * The API
+ * -------
+ *
+ * The implementation includes two kinds of components: Implementation
+ * of ASAN hooks injected by LLVM into the program, and API calls that
+ * allocators use to mark memory as valid or invalid. The full list is:
+ *
+ * LLVM stubs:
+ *
+ * void __asan_{load, store}<size>(void *addr)
+ *	Checks whether an access is valid. All variations covered
+ *	by check_region_inline().
+ *
+ * void __asan_{store, load}((void *addr, ssize_t size)
+ *
+ * void __asan_report_{load, store}<size>(void *addr)
+ *	Report an access violation for the program. Used when LLVM
+ *	uses direct code generation for shadow map checks.
+ *
+ * void *__asan_memcpy(void *d, const void *s, size_t n)
+ * void *__asan_memmove(void *d, const void *s, size_t n)
+ * void *__asan_memset(void *p, int c, size_t n)
+ *	Hooks for ASAN instrumentation of the LLVM mem* builtins.
+ *	Currently unimplemented just like the builtins themselves.
+ *
+ * API methods:
+ *
+ * asan_init()
+ *	Initialize the ASAN map for the arena.
+ *
+ * asan_poison()
+ *	Mark a region of memory as poisoned. Accessing poisoned memory
+ *	causes asan_report() to fire. Invoked during free().
+ *
+ * asan_unpoison()
+ *	Mark a region as unpoisoned after alloc().
+ *
+ * asan_shadow_set()
+ *	Check a byte's validity directly.
+ *
+ * The Algorithm In Brief
+ * ----------------------
+ * Each group of 8 bytes is mapped to a "granule" in the shadow map. This
+ * granule is the size of the byte and describes which bytes are valid.
+ * Possible values are:
+ *
+ * 0: All bytes are valid. Makes checks in the middle of an allocated region
+ * (most of them) fast.
+ * (0, 7]: How many consecutive bytes are valid, starting from the lowest one.
+ * The tradeoff is that we can't poison individual bytes in the middle of a
+ * valid region.
+ * [0x80, 0xff]: Special poison values, can be used to denote specific error
+ * modes (e.g., recently freed vs uninitialized memory).
+ *
+ * The mapping between a memory location and its shadow is:
+ * shadow_addr = shadow_base + (addr >> 3). We retain the 8:1 data:shadow
+ * ratio of existing ASAN implementations as a compromise between tracking
+ * granularity and space usage/scan overhead.
+ */
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
+volatile u32 asan_reported = false;
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
+ * For large sequential copies, or assignments of large data structures,
+ * the frontend will generate an intrinsic that causes the BPF backend
+ * to exit due to a missing implementation. Provide a simple implementation
+ * just for memset to use it for poisoning/unpoisoning the map.
+ */
+__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
+{
+	size_t i;
+
+	for (i = zero; i < size && can_loop; i++)
+		dst[i] = val;
+
+	return 0;
+}
+
+/* Validate a 1-byte access, always within a single byte. */
+static __always_inline bool memory_is_poisoned_1(s8a *addr)
+{
+	s8 shadow_value = *(s8a *)mem_to_shadow(addr);
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
+/* Validate a 2- 4-, 8-byte access, shadow spans up to 2 bytes. */
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
+	return *(s8a *)mem_to_shadow(addr) || memory_is_poisoned_1((s8a *)end);
+}
+
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
+	return unlikely(ret != end || ASAN_GRANULE(addr + size - 1) >= *(s8a *)end);
+}
+
+__weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
+{
+	u32 reported = __sync_val_compare_and_swap(&asan_reported, false, true);
+
+	/* Only report the first ASAN violation. */
+	if (reported && asan_report_once)
+		return 0;
+
+	asan_violated = (u64)addr;
+
+	if (asan_emit_stack) {
+		arena_stderr("Memory violation for address %p (0x%lx) for %s of size %ld",
+				addr, (u64)addr,
+				(flags & ASAN_WRITE) ? "write" : "read",
+				sz);
+		bpf_stream_print_stack(BPF_STDERR);
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
+	 * Wraparound is possible for values close to the the edge of the
+	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
+	 *
+	 *
+	 * The wraparound detection below works for small sizes. check_asan_args is
+	 * always called from the builtin ASAN checks, so 1 <= size <= 64. Even
+	 * for storeN/loadN that we do not expect to encounter the intrinsics will
+	 * not have a large enough size that:
+	 *
+	 * - addr + size  > MAX_U32
+	 * - (u32)(addr + size) > (u32) addr
+	 *
+	 * which would defeat wraparound detection.
+	 */
+	if (unlikely((u32)(u64)(addr + size) < (u32)(u64)addr))
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
+						u32 flags)
+{
+	s8a *addr = (s8a *)(u64)ptr;
+	bool is_poisoned, is_valid;
+
+	if (check_asan_args(addr, size, &is_valid)) {
+		if (!is_valid)
+			asan_report(addr, size, flags);
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
+		asan_report(addr, size, flags);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __alias is not supported for BPF so define *__noabort() variants as wrappers.
+ */
+#define DEFINE_ASAN_LOAD_STORE(size)                                  \
+	__hidden void __asan_store##size(void *addr)                  \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_WRITE);          \
+	}                                                             \
+	__hidden void __asan_store##size##_noabort(void *addr)        \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_WRITE);          \
+	}                                                             \
+	__hidden void __asan_load##size(void *addr)                   \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_READ);           \
+	}                                                             \
+	__hidden void __asan_load##size##_noabort(void *addr)         \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_READ);           \
+	}                                                             \
+	__hidden void __asan_report_store##size(void *addr)           \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+	}                                                             \
+	__hidden void __asan_report_store##size##_noabort(void *addr) \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+	}                                                             \
+	__hidden void __asan_report_load##size(void *addr)            \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_READ);            \
+	}                                                             \
+	__hidden void __asan_report_load##size##_noabort(void *addr)  \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_READ);            \
+	}
+
+DEFINE_ASAN_LOAD_STORE(1);
+DEFINE_ASAN_LOAD_STORE(2);
+DEFINE_ASAN_LOAD_STORE(4);
+DEFINE_ASAN_LOAD_STORE(8);
+
+void __asan_storeN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_WRITE);
+}
+
+void __asan_storeN_noabort(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_WRITE);
+}
+
+void __asan_loadN(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_READ);
+}
+
+void __asan_loadN_noabort(void *addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_READ);
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
+	arena_stderr("ASAN: Unexpected %s call", __func__);
+	return NULL;
+}
+
+void *__asan_memmove(void *d, const void *s, size_t n)
+{
+	arena_stderr("ASAN: Unexpected %s call", __func__);
+	return NULL;
+}
+
+void *__asan_memset(void *p, int c, size_t n)
+{
+	arena_stderr("ASAN: Unexpected %s call", __func__);
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
+	 * memory to the application that has a granule-aligned starting address,
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
+ * down, then partially poison the last granule if necessary.
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
+__weak __noasan int asan_init(struct asan_init_args *args)
+{
+	u64 globals_pages = args->arena_globals_pages;
+	u64 all_pages = args->arena_all_pages;
+	u64 shadow_map, shadow_pgoff;
+	u64 shadow_pages;
+
+	if (asan_inited)
+		return 0;
+
+	/*
+	 * Round up the shadow map size to the nearest page.
+	 */
+	shadow_pages = all_pages >> ASAN_SHADOW_SHIFT;
+	if ((all_pages & ((1 << ASAN_SHADOW_SHIFT) - 1)))
+		shadow_pages += 1;
+
+	/*
+	 * Make sure the numbers provided by userspace are sane.
+	 */
+	if (all_pages > (1ULL << 32) / __PAGE_SIZE) {
+		arena_stderr("error: arena size %lx too large", all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages > all_pages) {
+		arena_stderr("error: globals %lx do not fit in arena %lx",
+				globals_pages, all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages + shadow_pages >= all_pages) {
+		arena_stderr("error: globals %lx do not leave room for shadow map %lx "
+				"(arena pages %lx)",
+				globals_pages, shadow_pages, all_pages);
+		return -EINVAL;
+	}
+
+	shadow_pgoff = all_pages - shadow_pages - globals_pages;
+	__asan_shadow_memory_dynamic_address = shadow_pgoff * __PAGE_SIZE;
+
+	/*
+	 * Allocate the last (1/ASAN_SHADOW_SCALE)th of an arena's pages for the map
+	 * We find the offset and size from the arena map.
+	 *
+	 * The allocated map pages are zeroed out, meaning all memory is marked as valid
+	 * even if it's not allocated already. This is expected: Since the actual memory
+	 * pages are not allocated, accesses to it will trigger page faults and will be
+	 * reported through BPF streams. Any pages allocated through bpf_arena_alloc_pages
+	 * should be poisoned by the allocator right after the call succeeds.
+	 */
+	shadow_map = (u64)bpf_arena_alloc_pages(
+		&arena, (void __arena *)__asan_shadow_memory_dynamic_address,
+		shadow_pages, NUMA_NO_NODE, 0);
+	if (!shadow_map) {
+		arena_stderr("Could not allocate shadow map\n");
+
+		__asan_shadow_memory_dynamic_address = 0;
+
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
2.53.0

