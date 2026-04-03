Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9C3537EB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190450; cv=none; b=tDljMY0MmZfFFbCkCnDXvL12PgDBUM7p8QR+jc8Rvo3G8/59oWVbWsP4jrZ+9Sr+UWC8QUB1kjIwyMp0pv6gbUcdzhzRxb2BrO9FduURh/pbimN+HaT8pYjn7JZmwmlwQM/yHye3naACTxi6ej6SdRibUyOQ3wRW8e7jKL+s2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190450; c=relaxed/simple;
	bh=IGxkP9iawgVX0KFmZrQNR1DNbcJkVl2+gXCOQNULUJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPOTC45KgWnED6ikgvhHpKRNft6BIWE4vahdMaMtPFMWdPmBt6oL/++V9df5i0Q+DTTsQj2Udur8sLV6BUhIXAuAZfOS97cg5pSe/DTAo44gmKVIQDn3psohA6dRyjRERGX4XmdNTl70UAMW6FikB/PdunRrcWMjXN8TRUhsbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=i1I8gG9j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="i1I8gG9j"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so953223a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775190448; x=1775795248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1O3GZmnyysmmGPoLoYY0x6RnXVp8PVhpx2+1Gu2zrU=;
        b=i1I8gG9jB0bQ6+3a6meB8ifjfFJZBa4rx33DS5y8Uban7hhkuf9qRKfOdJbRv/Wwyr
         sPHLvgDWHRwtn8FiAheuW5nRLTvcvz9NmrRzJ/H36Rwaabx+P/8QGdbu83Z4FRxo9GnE
         GtKtB7JwUFvynuBh5HweVi2yCAn5pQ/zy4tZNgiwBzWB2pMWUiRhl33jlHeWMFj9IOQ6
         X4G6f0ueK9hi2k0w5laj7uFMrnd4f213/GGY3sOvn1ODFydVypVb78ShYLposhlPPt8E
         eG2FVVVuttMs1VdTV/B636C+mwsrzNFTDZ1jCrdnJV13HaOrFSn+u7/zpX4rq5O8WstY
         dSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190448; x=1775795248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E1O3GZmnyysmmGPoLoYY0x6RnXVp8PVhpx2+1Gu2zrU=;
        b=horvrrH0UFlK722aMPIeF76Y+YUXfv0pPUcT0u6mzaFxTz9cNKSWkonrO/021ZPAvw
         9ostGdBkccPjMCVm4VgE3vEfk4XgIUR7C2cXqO46ogF9AVIbdx2Hlpr/nh1LADrSQzZ3
         /vePK8SvrYUbrVLFF4ekp4z5Ai582NP0315HgAJcK33/fEhwCQxO+FGIfXZ88JTaEQhq
         plI3dvH5U7OiQt+mCWFXkqaWCa6X5Do/4M0YpahG7b9A55USAYFL3YLlXnHYgzHHFikW
         fFA0pe8T7nowL5AlbodCM1o0YHXiTAOiC2mf6KVbGTP491DtPmElisZHBzsz9FXwHyPa
         gN2w==
X-Gm-Message-State: AOJu0YyqAf2JMzwF1LFLGiulaALXHiw9Axg404r5aufAeYHQh3xQnT59
	htq+nJF0jfJmJI2oiXg8OpzIi2s/Q+uzDpDacsOwIywHcS+wxfUd5jt7Ww+7pW3898KllWpRizF
	rMga6glMAaQ==
X-Gm-Gg: AeBDiesP8lUecZH90MB30G3ivpsMmGb2k2VySJ0jOnoD6qiQSiCivRVVfkgNBgYw39s
	rXaF7l7Ivplm8T4rVnGcx+IhEwtZBShCPdT/sKyppi9B360SEURxfjnA2PjNDH5GXzCu2etw4Y4
	0JNAfMEeQ7P30uYfqMP+phh1SkcbA/PrKWPqn0cRSypoVmiSLyGhjsUOjUhXbFKwcxdKpUmsO7C
	jAr9lUxxzOzfYPAleWdrayo/CoaR1XeQ9ylgJ2JMLyPXS6zz75ZJBsyiWP1zcbRCIDvAJ66U1Hq
	UobT46bv2fAw+W/SMxFWRGL8zkAfo5s/+IxZmaiecAWelnQS0+eMxeAop2eB4T931TImlsSaN/Z
	ymg62+SRZUjSLmXwXKpA5lyLUbQOWd6H6fUXLTLXaigb76yLKjDjrqlFgQU6AXrdZWZ1SgGHHja
	BX7Q==
X-Received: by 2002:a17:90b:1a8a:b0:35b:9ab6:1d59 with SMTP id 98e67ed59e1d1-35de5c64a15mr1206959a91.13.1775190448225;
        Thu, 02 Apr 2026 21:27:28 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm12970449a91.12.2026.04.02.21.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:27:27 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 6/9] selftests/bpf: Add arena ASAN runtime to libarena
Date: Fri,  3 Apr 2026 00:27:17 -0400
Message-ID: <20260403042720.18862-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403042720.18862-1-emil@etsalapatis.com>
References: <20260403042720.18862-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/include/asan.h     | 124 +++++
 .../selftests/bpf/libarena/include/common.h   |   1 +
 .../selftests/bpf/libarena/src/asan.bpf.c     | 524 ++++++++++++++++++
 .../selftests/bpf/libarena/src/common.bpf.c   |   1 +
 4 files changed, 650 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/testing/selftests/bpf/libarena/include/asan.h
new file mode 100644
index 000000000000..ff6696549723
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/asan.h
@@ -0,0 +1,124 @@
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
+do {					\
+	ASAN_DUMMY_CALLS_SIZE(1, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(2, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(4, (arg));	\
+	ASAN_DUMMY_CALLS_SIZE(8, (arg));	\
+} while (0)
+
+__weak __noasan
+int asan_dummy_call(void) {
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
diff --git a/tools/testing/selftests/bpf/libarena/include/common.h b/tools/testing/selftests/bpf/libarena/include/common.h
index 544a398a0d1e..f48395358d1d 100644
--- a/tools/testing/selftests/bpf/libarena/include/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -39,6 +39,7 @@ struct {
 } arena __weak SEC(".maps");
 
 extern const volatile u32 zero;
+extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
new file mode 100644
index 000000000000..fbb6a2341f4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -0,0 +1,524 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <common.h>
+#include <asan.h>
+
+/*
+ * Address sanitizer (ASAN) for arena-based BPF programs. The
+ * sanitizer tracks valid arena memory and triggers an error
+ * when poisoned memory is read or written to. Starting point
+ * was the KASAN implementation in mm/.
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
+ * [8, 0xff]: Special poison value, can be used to denote specific error modes
+ * (e.g., recently freed vs uninitialized memory).
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
+__weak int asan_report(s8a __arg_arena *addr, size_t sz,
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
+	 * Wraparound is possible for extremely high size. Possible if the size
+	 * is a misinterpreted negative number.
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
+		arena_stderr("error: arena size %lx too large", all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages > all_pages) {
+		arena_stderr("error: globals %lx do not fit in arena %lx", globals_pages, all_pages);
+		return -EINVAL;
+	}
+
+	if (globals_pages + shadow_pages > all_pages) {
+		arena_stderr("error: globals %lx do not leave room for shadow map %lx (arena pages %lx)",
+			globals_pages, shadow_pages, all_pages);
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
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index cbb729290d3c..31acb259ec5a 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <common.h>
+#include <asan.h>
 
 const volatile u32 zero = 0;
 
-- 
2.53.0

