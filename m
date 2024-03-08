Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403A2232B
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860141; cv=none; b=UrwR5O6iTl535/m4F4UwoauGRZ2WSTIXyU1pIUk2rFHG5sEnhPZKbvqBg6jNXQZSqWTNznfV/yK1BWXVUTUPN9CACNPMAh08OdtWi/R/SiLkVFMvD3Q6mwnxUwL+piNCzj3r0FMrTzlRqKSXq99gYgHF+bfxCBhrKk1ZtMIl+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860141; c=relaxed/simple;
	bh=kA2yTMV0+/3p8XHQ/qQ49uA2RGH9sB/8n/S1rReNJn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttBD26z3YZXhiANLgD4Q44m7P6UzydDtK8Ls/qTUwJIUsoobMd1UAT9fHAVFXCpLfsl674qEPTNsU+cQJkLq4Sb5iJI8e/n2fohXSoY/Xu8yObB9nj16BxSpiIqikwrNlzQtF1n0d9W8g6ROkfIEwq0MVIW7lzBhvuFFYbwLMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9H31L+C; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9H31L+C"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e63e9abf6aso282054b3a.2
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860139; x=1710464939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D38ixjnd/0kZdwFwUpxPlsmklHn50Lw3z4sv9DFS4v8=;
        b=N9H31L+CRNAcl/e0ft2XONtCFfBSLoCHaanSuHX1WInnkUdC6Xnh+lDNXxSI0safiP
         5QT5MGhk5Z3jbm1tZApdr4YCgTRGQaMpWgT8NOQfMJeC5nIAxTrq914UTDKKYjwzbCYw
         4BAxDjZ9RpIZG0rSuL2Jvprn9B2ikKgAmp+UY2638PPczU6WKrVEgqY5Pg4KhY/2pSs0
         v1wxQPU/8SXFZknH+vwi4LtMlm8LCvekO8vU3yLMOlSHuoJEPbJpzMA4GxQuEQdCbVRB
         miXSycIxb+nfHsBES6Mp3m+K9kle2Quyf+5JsPWq74SqvLBtQNcHl03PODAwtiaTwZP3
         0JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860139; x=1710464939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D38ixjnd/0kZdwFwUpxPlsmklHn50Lw3z4sv9DFS4v8=;
        b=a9IlYCxgRsAOU/zBEvephO9Z/BcOifvuP99CJsiYI37XTXfiJN6EIcO1zJ4ep8gFpD
         rXM5jFtZLDHN9Y68Yxmo5FCTcFJaztqNc2SN7RREN0nVDpBbVsrAefLoHHsibYuaHRB1
         LYn1JbBmPggu/3KUwWmEFLUzixFO4nm3Y8uK9T1cIU6rzLnDwZ03lqsD4F2ocONWcFc3
         eYyV2w0YeasR4fbwIJjwI+cmOTP+n9bJwIBzBv517m/4JkUx6H7NqZm4tl0xEYLgT0W2
         tZNT2pzz3ST1tIw/Xr6qTkVlurBYOnhBpDeFR31p7W/FFBS/FgUNixa01xRrIdjasG4l
         f/OA==
X-Gm-Message-State: AOJu0YxYcruxRojHrPT74TTdmNRet3zUXix9h5/qs+bR0ZRydXx9hJQk
	fTPPQS7fLkHd1pDszoL/DtcNAd2mYkiLpQycEBB7jrfcpEX+b5kpqz8dzVF5
X-Google-Smtp-Source: AGHT+IG73izPw3autz1dBVVk7fqkmTAZ0Abws1Y2STNRhHYf/EsHDbWJRVw6+giej666KIus6bbojQ==
X-Received: by 2002:aa7:8446:0:b0:6e5:f456:bf0 with SMTP id r6-20020aa78446000000b006e5f4560bf0mr12040285pfn.22.1709860138826;
        Thu, 07 Mar 2024 17:08:58 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006e5933a0da9sm13149770pfb.165.2024.03.07.17.08.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 12/14] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
Date: Thu,  7 Mar 2024 17:08:10 -0800
Message-Id: <20240308010812.89848-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add unit tests for bpf_arena_alloc/free_pages() functionality
and bpf_arena_common.h with a set of common helpers and macros that
is used in this test and the following patches.

Also modify test_loader that didn't support running bpf_prog_type_syscall
programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_arena.c      | 146 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   9 +-
 6 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 0445ac38bc07..f9101651747b 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,3 +10,4 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
+verifier_arena                                   # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index cb810a98e78f..aa8a620f3318 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -4,3 +4,4 @@ exceptions				 # JIT does not support calling kfunc bpf_throw				       (excepti
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
+verifier_arena                           # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
new file mode 100644
index 000000000000..bcf195c64a45
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+#endif
+
+#ifndef NUMA_NO_NODE
+#define	NUMA_NO_NODE	(-1)
+#endif
+
+#ifndef arena_container_of
+#define arena_container_of(ptr, type, member)			\
+	({							\
+		void __arena *__mptr = (void __arena *)(ptr);	\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
+#ifdef __BPF__ /* when compiled as bpf program */
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+/*
+ * for older kernels try sizeof(struct genradix_node)
+ * or flexible:
+ * static inline long __bpf_page_size(void) {
+ *   return bpf_core_enum_value(enum page_size_enum___l, __PAGE_SIZE___l) ?: sizeof(struct genradix_node);
+ * }
+ * but generated code is not great.
+ */
+#endif
+
+#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#define __arena __attribute__((address_space(1)))
+#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
+#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
+#else
+#define __arena
+#define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
+#define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
+#endif
+
+void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
+				    int node_id, __u64 flags) __ksym __weak;
+void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
+
+#else /* when compiled as user space code */
+
+#define __arena
+#define __arg_arena
+#define cast_kern(ptr) /* nop for user space */
+#define cast_user(ptr) /* nop for user space */
+__weak char arena[1];
+
+#ifndef offsetof
+#define offsetof(type, member)  ((unsigned long)&((type *)0)->member)
+#endif
+
+static inline void __arena* bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt,
+						  int node_id, __u64 flags)
+{
+	return NULL;
+}
+static inline void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt)
+{
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9c6072a19745..985273832f89 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -4,6 +4,7 @@
 
 #include "cap_helpers.h"
 #include "verifier_and.skel.h"
+#include "verifier_arena.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
@@ -118,6 +119,7 @@ static void run_tests_aux(const char *skel_name,
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
+void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
new file mode 100644
index 000000000000..5540b05ff9ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*/
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
+} arena SEC(".maps");
+
+SEC("syscall")
+__success __retval(0)
+int basic_alloc1(void *ctx)
+{
+#if defined(__BPF_FEATURE_ARENA_CAST)
+	volatile int __arena *page1, *page2, *no_page, *page3;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	*page1 = 1;
+	page2 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+	*page2 = 2;
+	no_page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 3;
+	if (*page1 != 1)
+		return 4;
+	if (*page2 != 2)
+		return 5;
+	bpf_arena_free_pages(&arena, (void __arena *)page2, 1);
+	if (*page1 != 1)
+		return 6;
+	if (*page2 != 0) /* use-after-free should return 0 */
+		return 7;
+	page3 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page3)
+		return 8;
+	*page3 = 3;
+	if (page2 != page3)
+		return 9;
+	if (*page1 != 1)
+		return 10;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int basic_alloc2(void *ctx)
+{
+#if defined(__BPF_FEATURE_ARENA_CAST)
+	volatile char __arena *page1, *page2, *page3, *page4;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	page2 = page1 + __PAGE_SIZE;
+	page3 = page1 + __PAGE_SIZE * 2;
+	page4 = page1 - __PAGE_SIZE;
+	*page1 = 1;
+	*page2 = 2;
+	*page3 = 3;
+	*page4 = 4;
+	if (*page1 != 1)
+		return 1;
+	if (*page2 != 2)
+		return 2;
+	if (*page3 != 0)
+		return 3;
+	if (*page4 != 0)
+		return 4;
+	bpf_arena_free_pages(&arena, (void __arena *)page1, 2);
+	if (*page1 != 0)
+		return 5;
+	if (*page2 != 0)
+		return 6;
+	if (*page3 != 0)
+		return 7;
+	if (*page4 != 0)
+		return 8;
+#endif
+	return 0;
+}
+
+struct bpf_arena___l {
+        struct bpf_map map;
+} __attribute__((preserve_access_index));
+
+SEC("syscall")
+__success __retval(0) __log_level(2)
+int basic_alloc3(void *ctx)
+{
+	struct bpf_arena___l *ar = (struct bpf_arena___l *)&arena;
+	volatile char __arena *pages;
+
+	pages = bpf_arena_alloc_pages(&ar->map, NULL, ar->map.max_entries, NUMA_NO_NODE, 0);
+	if (!pages)
+		return 1;
+	return 0;
+}
+
+SEC("iter.s/bpf_map")
+__success __log_level(2)
+int iter_maps1(struct bpf_iter__bpf_map *ctx)
+{
+	struct bpf_map *map = ctx->map;
+
+	if (!map)
+		return 0;
+	bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
+	return 0;
+}
+
+SEC("iter.s/bpf_map")
+__failure __msg("expected pointer to STRUCT bpf_map")
+int iter_maps2(struct bpf_iter__bpf_map *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+
+	bpf_arena_alloc_pages((void *)seq, NULL, 1, 0, 0);
+	return 0;
+}
+
+SEC("iter.s/bpf_map")
+__failure __msg("untrusted_ptr_bpf_map")
+int iter_maps3(struct bpf_iter__bpf_map *ctx)
+{
+	struct bpf_map *map = ctx->map;
+
+	if (!map)
+		return 0;
+	bpf_arena_alloc_pages(map->inner_map_meta, NULL, map->max_entries, 0, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index ba57601c2a4d..524c38e9cde4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -501,7 +501,7 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
 	}
 }
 
-static int do_prog_test_run(int fd_prog, int *retval)
+static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
 {
 	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
 	__u8 tmp_in[TEST_DATA_LEN] = {};
@@ -514,6 +514,10 @@ static int do_prog_test_run(int fd_prog, int *retval)
 		.repeat = 1,
 	);
 
+	if (empty_opts) {
+		memset(&topts, 0, sizeof(struct bpf_test_run_opts));
+		topts.sz = sizeof(struct bpf_test_run_opts);
+	}
 	err = bpf_prog_test_run_opts(fd_prog, &topts);
 	saved_errno = errno;
 
@@ -649,7 +653,8 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
 
-		do_prog_test_run(bpf_program__fd(tprog), &retval);
+		do_prog_test_run(bpf_program__fd(tprog), &retval,
+				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
 		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
-- 
2.43.0

