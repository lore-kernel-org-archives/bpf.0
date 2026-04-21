Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4896377ECA
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790251; cv=none; b=jreKwg6Ra2E58ht8ebIovR+3TBYAqqKKNp3wtv5DqHK18YMxH9bn/T1XQwHgKew/wy+htLzyIpXXcQpNKDz2Q3atlg8Rk22zSfOZ8rTk8BSsUt6Hk78Xa2YrBtVctosMRxc5oJn9YyDlg7N64DEc3jK8zIq3UX+dnPLIBVU0bRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790251; c=relaxed/simple;
	bh=RQWlqKXS7SedyUXncIwxdSmBzxDo07edmO0XQkKV+J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WovO2nBFfuJrXzn3ATXreqN6AJSuAoYD76bVSBhfNjAGfuXMQFthhykAjZChefWS03wcTpEQx8E4JPSPNKp6omS1xRz8yRYJlwIvHjdNJxiJ+TayW8VXCzF/y2bcsnvs7vRh/siPKLAOj3fyHCe1Ar3vGhWoRoeHq/VORzTx+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gvV8WYwY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gvV8WYwY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c6df0b9bbso1032933c88.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776790248; x=1777395048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgpY0qogSWPnRoj2zqT84tZ9eP23RH2bg7tFWVPZkLw=;
        b=gvV8WYwYAkl+7hjYcSRR4SGFptUknxt2Y0Oqo/3/qwgZyuxBSoNf8CKZuviAPYf3FD
         HPgcmSUtO8yMiWejPbzaN8Px0RVINIDAWZjA3I8BhQWfHq153EajCpZb6hSFCvC/GD0G
         xzwton4pFYATSvv5ORqj/t+b0l9c6GzQ1Yt9I/9VzOMo4i+q2IbmB9hmrWz1fn9fIROu
         PSyucsMs4G4NvPH+7CWRYLMHTrJHB1fVMZB0HkeS2e61XkdM7Sc+siS9jZinvi81J2/T
         3q7tBPwNi9UDsd6l3a9q7e5JBEDkQcLauLIc8kcV2XD8rSdq9QHgUGInPHDMQm3ig4HU
         D5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790248; x=1777395048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgpY0qogSWPnRoj2zqT84tZ9eP23RH2bg7tFWVPZkLw=;
        b=gar0p0BnA1KxaEwC6uwKZzif5QjjKQfQjLz37qP2D/Lw2Smw9rZIHzgEPlUJnRXsk1
         EzDZEYkLXg7QEmoymGV5HGSy5njrg5bakHlmS4Rk/k0hlVYsFUvrJRdTGfwSmnY+gOmL
         X0wr1V8IKWlWNhJHppqxlHMNgSjb7ZHB5gmjg8eUy5/emk3h5F61iHSgvO8ynLnKjh3t
         Af1zoqx4D5ZdJOvu4Ic5HhbMmaEp8xCPCHHoEBfCugGOjRnkv9yQrZwjrSsbpicimrUc
         ybqc1LgYkd2LBn4wpXo0rwsTcfwyh95lP2ffzdQYPQGXh+BKA3CGWshvuGP5urez14Ex
         NoJA==
X-Gm-Message-State: AOJu0YzSgs7ngJ+TufB8BXdFmH+CXEBEYwofr9qDUPXJgEsSEHgn7Skg
	1D5cjPGKs0UhlUpH4S47pgqUuXd3zCQh52Z0pS3MsEIFSUKBQ4Mpj/Kh6/GNxIAUm/isIXbs1Mc
	vTKV2Vx4q66I0
X-Gm-Gg: AeBDieucDGFBtVXVpB+3i0AJm2+sTKxlK1q5fAWNF5lyrKeXwEiwBpKscea3rEez3OU
	iDs/BxKpMv138tEIkavv3jk2o16Pq8uy7ZwhdLpthcSp5qhPQH3XQRyY2QXBd9F3rNUM749zDqO
	+i0g4nJDnutc7tZpbAyE3rIaNJ6LPI/EWpZj9JbmcGLs3YRmTvlloCvN6QZrX0NNfvLNj9BjSoz
	atT+CQTpFftkwYZMH0kD80Ck3qnbeCYOlJflFrUadzfb40YNIte8eL3GrQvQ7apzU7oYFcJRTk6
	s8HB3VhMCuur5/6XfwVsxD6Fw+92+aURZRKSuOES7lrAquXYDHIeHrrFp1stL4V6v6P+01Fkcoa
	I6g3uo15r0y5RCA5v6TCU93XVsnIUACKQEuvT4uK8eljlfNap9xO0p4A2TtPqHQIfwx9gLQutSu
	RJdyCOCeuo4U1DHCviI1A6ZgDdrKbV+g==
X-Received: by 2002:a05:7023:b0a:b0:12d:b7e5:a67b with SMTP id a92af1059eb24-12db7e5aaafmr736228c88.14.1776790247369;
        Tue, 21 Apr 2026 09:50:47 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::8110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm24514993eec.8.2026.04.21.09.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:50:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v8 4/8] selftests/bpf: Add arena ASAN runtime to libarena
Date: Tue, 21 Apr 2026 12:50:33 -0400
Message-ID: <20260421165037.4736-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421165037.4736-1-emil@etsalapatis.com>
References: <20260421165037.4736-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/include/asan.h     | 103 ++++
 .../selftests/bpf/libarena/include/common.h   |   1 +
 .../selftests/bpf/libarena/src/asan.bpf.c     | 553 ++++++++++++++++++
 3 files changed, 657 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/asan.h b/tools/testing/selftests/bpf/libarena/include/asan.h
new file mode 100644
index 000000000000..eb9fc69d9eb0
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/asan.h
@@ -0,0 +1,103 @@
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
+	void __asan_store##size(intptr_t addr);				\
+	void __asan_store##size##_noabort(intptr_t addr);	\
+	void __asan_load##size(intptr_t addr);				\
+	void __asan_load##size##_noabort(intptr_t addr);	\
+	void __asan_report_store##size(intptr_t addr);			\
+	void __asan_report_store##size##_noabort(intptr_t addr);		\
+	void __asan_report_load##size(intptr_t addr);			\
+	void __asan_report_load##size##_noabort(intptr_t addr);
+
+DECLARE_ASAN_LOAD_STORE_SIZE(1);
+DECLARE_ASAN_LOAD_STORE_SIZE(2);
+DECLARE_ASAN_LOAD_STORE_SIZE(4);
+DECLARE_ASAN_LOAD_STORE_SIZE(8);
+
+void __asan_storeN(intptr_t addr, ssize_t size);
+void __asan_storeN_noabort(intptr_t addr, ssize_t size);
+void __asan_loadN(intptr_t addr, ssize_t size);
+void __asan_loadN_noabort(intptr_t addr, ssize_t size);
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
+__attribute__((used))
+static void (*__asan_btf_anchors[])(intptr_t) = {
+	ASAN_LOAD_STORE_SIZE(1),
+	ASAN_LOAD_STORE_SIZE(2),
+	ASAN_LOAD_STORE_SIZE(4),
+	ASAN_LOAD_STORE_SIZE(8),
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
index 0146a0858111..7b2a91b85978 100644
--- a/tools/testing/selftests/bpf/libarena/include/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/common.h
@@ -38,6 +38,7 @@ struct {
 } arena __weak SEC(".maps");
 
 extern const volatile u32 zero;
+extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
new file mode 100644
index 000000000000..7e0aaab3803f
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -0,0 +1,553 @@
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
+ * void __asan_{load, store}<size>(intptr_t addr)
+ *	Checks whether an access is valid. All variations covered
+ *	by check_region_inline().
+ *
+ * void __asan_{store, load}((intptr_t addr, ssize_t size)
+ *
+ * void __asan_report_{load, store}<size>(intptr_t addr)
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
+	arena_stderr("Memory violation for address %p (0x%lx) for %s of size %ld\n",
+			addr, (u64)addr,
+			(flags & ASAN_WRITE) ? "write" : "read",
+			sz);
+	bpf_stream_print_stack(BPF_STDERR);
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
+static __always_inline bool check_region_inline(intptr_t ptr, size_t size,
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
+	__hidden void __asan_store##size(intptr_t addr)                  \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_WRITE);          \
+	}                                                             \
+	__hidden void __asan_store##size##_noabort(intptr_t addr)        \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_WRITE);          \
+	}                                                             \
+	__hidden void __asan_load##size(intptr_t addr)                   \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_READ);           \
+	}                                                             \
+	__hidden void __asan_load##size##_noabort(intptr_t addr)         \
+	{                                                             \
+		check_region_inline(addr, size, ASAN_READ);           \
+	}                                                             \
+	__hidden void __asan_report_store##size(intptr_t addr)           \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+	}                                                             \
+	__hidden void __asan_report_store##size##_noabort(intptr_t addr) \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_WRITE);           \
+	}                                                             \
+	__hidden void __asan_report_load##size(intptr_t addr)            \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_READ);            \
+	}                                                             \
+	__hidden void __asan_report_load##size##_noabort(intptr_t addr)  \
+	{                                                             \
+		asan_report((s8a *)addr, size, ASAN_READ);            \
+	}
+
+DEFINE_ASAN_LOAD_STORE(1);
+DEFINE_ASAN_LOAD_STORE(2);
+DEFINE_ASAN_LOAD_STORE(4);
+DEFINE_ASAN_LOAD_STORE(8);
+
+void __asan_storeN(intptr_t addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_WRITE);
+}
+
+void __asan_storeN_noabort(intptr_t addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_WRITE);
+}
+
+void __asan_loadN(intptr_t addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_READ);
+}
+
+void __asan_loadN_noabort(intptr_t addr, ssize_t size)
+{
+	check_region_inline(addr, size, ASAN_READ);
+}
+
+/*
+ * We currently do not sanitize globals.
+ */
+void __asan_register_globals(intptr_t globals, size_t n)
+{
+}
+
+void __asan_unregister_globals(intptr_t globals, size_t n)
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

