Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE94219FC
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860145; cv=none; b=R4o+k7NKQ49FyQrErqZCmuY5D89SwKSxtiQKZI6DG45J9cccmtFZ4JYNKZX9/34RQZ30mmnM5YzOqScNStlK/t3ZZDprtNiOqNIEALSgb+/8tfvgWWA6YFeJn/pMNCEKbAhgz7v+hv43Pxkcpc01blWt66JUYIPMVXJMsMFThAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860145; c=relaxed/simple;
	bh=Lh1cWZyoua8dhlov1pKHlaDLREY/hRCp6dARSvcUotU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgPqALvEnNFFpysqUEpto55wIZbbaCZQ+cYgDYmXjqKOk3QZV5CFvaPG+/7554QSLmVW2qRo+M7yKdm5AigyjD6jQS5tyqsqXhM7dKIZb1dUICmF2mZx2swuQWdBuG64zpDxRCjveHUmmCefX8qYyral562yryMq21QhJ/CvEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqC+rZ2Y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqC+rZ2Y"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc13fb0133so2212465ad.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860142; x=1710464942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D6++xUxvD64ipEi92YPdyv+HOEeUH/sHJwtJKhwLCY=;
        b=YqC+rZ2Y0omZL488e/14I9Kh80qkun56pA0a5jCAwiMvf20h/ENKGy0Lp2mf/LrEUu
         gBVyMTblzIs6LMKUaCdE7f9eydN8LqXHa5FUyFHWlAK2T7AGKFNYE1M8T73U6TvzcW8Q
         RfhtCO4gxVwtj3lqfwqxLcUkIsiib2WKC4POpqoOR8saeDsjoYgUVavKUosD9cOWa5+U
         pXqD16vTKWzKvCao0UcNHM+SDLZpn+JVOEGlCLhHHkYXDhNLSnYzTg7/Y38oB1Ze/hbT
         S1COuFay5ty1VN9qNarkKCuDG3Q1ypa1YX6OXW1gPGpjKzMXbbuHcDET2RIyBRn/mxEj
         uUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860142; x=1710464942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D6++xUxvD64ipEi92YPdyv+HOEeUH/sHJwtJKhwLCY=;
        b=K/7wgNHPNU+1QVvSL2JzCT1CfQhBeMvfZN39JlsWJQkU4XFHw0AngwqzAo1rifihvo
         jbhT2Ruqvk5bO1dKPnFzrEVaRnYBMt3Z1hVJQZXhjy8rU5EqIA45j5w1JYGMR/Nvfy8S
         /tV4VCy/K6qkO99tn0MLs2JUVi9CB4ejWADwhKIRjT/6ZZlMlyRdA8vD8B+gEm+HoAM6
         CacamSrVX3gmKIvDtATpLWn0N5/Qf3XO+hJ5KQZ4fvEULcF3pd0FqM2jKjxwp9UZB+pK
         LqkixPpr7EpD3TVMG0UKaR24CCIho9MYpsWcZK3zyVhSeqZRx/ubREFASS2VHdzA5o27
         GGYg==
X-Gm-Message-State: AOJu0YzwJByD890ltUIrWhfIKKoVTYH9rLnrEjbTi9v+2LOc9GBgoAOl
	fNGZqHZ2yZBQcmDYAPxG3wIdAf2CGZE3q2aqNMVX+0U6bEZmFgNrY5XYFo3i
X-Google-Smtp-Source: AGHT+IEb5Ff0MnhqlTusueikYxMdd/Bze2OZWDejIaWF+sfCU+yKkQtF/zprJoiN+xBfdiuoHHXzMA==
X-Received: by 2002:a17:902:f786:b0:1dc:ad86:8f41 with SMTP id q6-20020a170902f78600b001dcad868f41mr12030785pln.28.1709860142341;
        Thu, 07 Mar 2024 17:09:02 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001db45bae92dsm15276659plg.74.2024.03.07.17.09.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:09:02 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 13/14] selftests/bpf: Add bpf_arena_list test.
Date: Thu,  7 Mar 2024 17:08:11 -0800
Message-Id: <20240308010812.89848-14-alexei.starovoitov@gmail.com>
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

bpf_arena_alloc.h - implements page_frag allocator as a bpf program.
bpf_arena_list.h - doubly linked link list as a bpf program.

Compiled as a bpf program and as native C code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/bpf_arena_alloc.h | 67 ++++++++++++++
 tools/testing/selftests/bpf/bpf_arena_list.h  | 92 +++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_list.c     | 68 ++++++++++++++
 .../testing/selftests/bpf/progs/arena_list.c  | 87 ++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c

diff --git a/tools/testing/selftests/bpf/bpf_arena_alloc.h b/tools/testing/selftests/bpf/bpf_arena_alloc.h
new file mode 100644
index 000000000000..c27678299e0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_alloc.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include "bpf_arena_common.h"
+
+#ifndef __round_mask
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#endif
+#ifndef round_up
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#endif
+
+#ifdef __BPF__
+#define NR_CPUS (sizeof(struct cpumask) * 8)
+
+static void __arena * __arena page_frag_cur_page[NR_CPUS];
+static int __arena page_frag_cur_offset[NR_CPUS];
+
+/* Simple page_frag allocator */
+static inline void __arena* bpf_alloc(unsigned int size)
+{
+	__u64 __arena *obj_cnt;
+	__u32 cpu = bpf_get_smp_processor_id();
+	void __arena *page = page_frag_cur_page[cpu];
+	int __arena *cur_offset = &page_frag_cur_offset[cpu];
+	int offset;
+
+	size = round_up(size, 8);
+	if (size >= PAGE_SIZE - 8)
+		return NULL;
+	if (!page) {
+refill:
+		page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+		if (!page)
+			return NULL;
+		cast_kern(page);
+		page_frag_cur_page[cpu] = page;
+		*cur_offset = PAGE_SIZE - 8;
+		obj_cnt = page + PAGE_SIZE - 8;
+		*obj_cnt = 0;
+	} else {
+		cast_kern(page);
+		obj_cnt = page + PAGE_SIZE - 8;
+	}
+
+	offset = *cur_offset - size;
+	if (offset < 0)
+		goto refill;
+
+	(*obj_cnt)++;
+	*cur_offset = offset;
+	return page + offset;
+}
+
+static inline void bpf_free(void __arena *addr)
+{
+	__u64 __arena *obj_cnt;
+
+	addr = (void __arena *)(((long)addr) & ~(PAGE_SIZE - 1));
+	obj_cnt = addr + PAGE_SIZE - 8;
+	if (--(*obj_cnt) == 0)
+		bpf_arena_free_pages(&arena, addr, 1);
+}
+#else
+static inline void __arena* bpf_alloc(unsigned int size) { return NULL; }
+static inline void bpf_free(void __arena *addr) {}
+#endif
diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
new file mode 100644
index 000000000000..b99b9f408eff
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include "bpf_arena_common.h"
+
+struct arena_list_node;
+
+typedef struct arena_list_node __arena arena_list_node_t;
+
+struct arena_list_node {
+	arena_list_node_t *next;
+	arena_list_node_t * __arena *pprev;
+};
+
+struct arena_list_head {
+	struct arena_list_node __arena *first;
+};
+typedef struct arena_list_head __arena arena_list_head_t;
+
+#define list_entry(ptr, type, member) arena_container_of(ptr, type, member)
+
+#define list_entry_safe(ptr, type, member) \
+	({ typeof(*ptr) * ___ptr = (ptr); \
+	 ___ptr ? ({ cast_kern(___ptr); list_entry(___ptr, type, member); }) : NULL; \
+	 })
+
+#ifndef __BPF__
+static inline void *bpf_iter_num_new(struct bpf_iter_num *it, int i, int j) { return NULL; }
+static inline void bpf_iter_num_destroy(struct bpf_iter_num *it) {}
+static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return true; }
+#define cond_break ({})
+#endif
+
+/* Safely walk link list elements. Deletion of elements is allowed. */
+#define list_for_each_entry(pos, head, member)					\
+	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
+						    typeof(*(pos)), member),	\
+			      (void *)0);					\
+	     pos && ({ ___tmp = (void *)pos->member.next; 1; });		\
+	     cond_break,							\
+	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))
+
+static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
+{
+	arena_list_node_t *first = h->first, * __arena *tmp;
+
+	cast_user(first);
+	cast_kern(n);
+	WRITE_ONCE(n->next, first);
+	cast_kern(first);
+	if (first) {
+		tmp = &n->next;
+		cast_user(tmp);
+		WRITE_ONCE(first->pprev, tmp);
+	}
+	cast_user(n);
+	WRITE_ONCE(h->first, n);
+
+	tmp = &h->first;
+	cast_user(tmp);
+	cast_kern(n);
+	WRITE_ONCE(n->pprev, tmp);
+}
+
+static inline void __list_del(arena_list_node_t *n)
+{
+	arena_list_node_t *next = n->next, *tmp;
+	arena_list_node_t * __arena *pprev = n->pprev;
+
+	cast_user(next);
+	cast_kern(pprev);
+	tmp = *pprev;
+	cast_kern(tmp);
+	WRITE_ONCE(tmp, next);
+	if (next) {
+		cast_user(pprev);
+		cast_kern(next);
+		WRITE_ONCE(next->pprev, pprev);
+	}
+}
+
+#define POISON_POINTER_DELTA 0
+
+#define LIST_POISON1  ((void __arena *) 0x100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void __arena *) 0x122 + POISON_POINTER_DELTA)
+
+static inline void list_del(arena_list_node_t *n)
+{
+	__list_del(n);
+	n->next = LIST_POISON1;
+	n->pprev = LIST_POISON2;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/testing/selftests/bpf/prog_tests/arena_list.c
new file mode 100644
index 000000000000..e61886debab1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <network_helpers.h>
+
+#define PAGE_SIZE 4096
+
+#include "bpf_arena_list.h"
+#include "arena_list.skel.h"
+
+struct elem {
+	struct arena_list_node node;
+	__u64 value;
+};
+
+static int list_sum(struct arena_list_head *head)
+{
+	struct elem __arena *n;
+	int sum = 0;
+
+	list_for_each_entry(n, head, node)
+		sum += n->value;
+	return sum;
+}
+
+static void test_arena_list_add_del(int cnt)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_list *skel;
+	int expected_sum = (u64)cnt * (cnt - 1) / 2;
+	int ret, sum;
+
+	skel = arena_list__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_list__open_and_load"))
+		return;
+
+	skel->bss->cnt = cnt;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_add), &opts);
+	ASSERT_OK(ret, "ret_add");
+	ASSERT_OK(opts.retval, "retval");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+		goto out;
+	}
+	sum = list_sum(skel->bss->list_head);
+	ASSERT_EQ(sum, expected_sum, "sum of elems");
+	ASSERT_EQ(skel->arena->arena_sum, expected_sum, "__arena sum of elems");
+	ASSERT_EQ(skel->arena->test_val, cnt + 1, "num of elems");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_del), &opts);
+	ASSERT_OK(ret, "ret_del");
+	sum = list_sum(skel->bss->list_head);
+	ASSERT_EQ(sum, 0, "sum of list elems after del");
+	ASSERT_EQ(skel->bss->list_sum, expected_sum, "sum of list elems computed by prog");
+	ASSERT_EQ(skel->arena->arena_sum, expected_sum, "__arena sum of elems");
+out:
+	arena_list__destroy(skel);
+}
+
+void test_arena_list(void)
+{
+	if (test__start_subtest("arena_list_1"))
+		test_arena_list_add_del(1);
+	if (test__start_subtest("arena_list_1000"))
+		test_arena_list_add_del(1000);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
new file mode 100644
index 000000000000..cd35b8448435
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+#include "bpf_arena_alloc.h"
+#include "bpf_arena_list.h"
+
+struct elem {
+	struct arena_list_node node;
+	__u64 value;
+};
+
+struct arena_list_head __arena *list_head;
+int list_sum;
+int cnt;
+bool skip = false;
+
+#ifdef __BPF_FEATURE_ARENA_CAST
+long __arena arena_sum;
+int __arena test_val = 1;
+struct arena_list_head __arena global_head;
+#else
+long arena_sum SEC(".arena.1");
+int test_val SEC(".arena.1");
+#endif
+
+int zero;
+
+SEC("syscall")
+int arena_list_add(void *ctx)
+{
+#ifdef __BPF_FEATURE_ARENA_CAST
+	__u64 i;
+
+	list_head = &global_head;
+
+	for (i = zero; i < cnt; cond_break, i++) {
+		struct elem __arena *n = bpf_alloc(sizeof(*n));
+
+		test_val++;
+		n->value = i;
+		arena_sum += i;
+		list_add_head(&n->node, list_head);
+	}
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int arena_list_del(void *ctx)
+{
+#ifdef __BPF_FEATURE_ARENA_CAST
+	struct elem __arena *n;
+	int sum = 0;
+
+	arena_sum = 0;
+	list_for_each_entry(n, list_head, node) {
+		sum += n->value;
+		arena_sum += n->value;
+		list_del(&n->node);
+		bpf_free(n);
+	}
+	list_sum = sum;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

