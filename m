Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09C21A1C
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860148; cv=none; b=ksDsdrLfFLzDxjjDw2D6aX/XKvT6oAU+RDhHZFLUJM/Z8xuuFPMqlzFgZM/BUYg2PPhHLdsoE+SUt9OFHzE0u0+U+A+zjpsgSid5jl4hf1dAY6jkaPYwvlqpX+4/G1xokzKM/NbcPBEAnBcZVJGNcnR4XRvGEZaKC/J4r/mBWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860148; c=relaxed/simple;
	bh=fzazxGlA40/MdKpenHo/R5zuHc74e+DUZVH8FGgpiOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as+UfN+r8feebtYihaARHl28PAQXePA5QvlWSY/lRVAkGDxYy2OCdxt2sPbjQp+K/BgdCWEtwV4iMCx1YH59br23JtIs6ayXH+hV2gDBkMOLgyTHH3yAyc37AcjpGSza+3U9IdmOJhgMAilWtYkfpwsOd30qNZkdY9enuVQ+d3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j47hm7KG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j47hm7KG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so11622865ad.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860146; x=1710464946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpi4QqlrH6Gb27ghrZwkx18ctzPDyLw0H9dN/ovouKs=;
        b=j47hm7KGCvGh0026Wt0ocjQQdxujFBDvaFb9whtXrxCvNzf+WIFt00htRvC0BelefT
         4jTFP+VKa744t7cUW0RFYPvAsVmBIx0XimzSodFGsEGLwbthYBr/GSmVh7+jPVBQItW5
         7T9cXYK8O4ZreQyDW/jrCbdlQJpdPMcej196wh3hPP0iGmQnRBY+9Ip5KznDCfcAd+/k
         v+VNhZfsDAabh6hBxkfMJr5cvj/vmRO80D1Yp89q4rTexfZzUUEOmRN+BB60spS/AL/B
         S9U3jMtKmkoZ7vL9n6/r85UFt8QTGT9t30kdgqMPygD7Pk00nZ/XtJQo5vBNMUJ1pYV+
         M68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860146; x=1710464946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpi4QqlrH6Gb27ghrZwkx18ctzPDyLw0H9dN/ovouKs=;
        b=ImIqPw3DGk/Rh7XF44qjxHFKvfIgaakPPLSjjuWcQsGYdS6oRtYEK+oosqDmHr+BUB
         EExASP2UgwNHF5vIkh96/f0O+uNIfc/zSuSPACVcfIJYRJOPf7y11yDdn1cmHjWZZw6W
         4jWAOl2qastBDtPh1a9CXvV5uvI1zRvfW2VfQxm6TPMwJkt0griEbG1xSb/KJxXe5kuh
         xS6t3sgpAkHdZfJlgnDfq2n6Fmo7zdbdRLweKCt6VUT/+oNmvovHLMZfTNRZmqCZJWpf
         k7DpJYZNRlVz4CDB/dIAxfAiw/d5NGz/Hr2p51KJe2VoZHCwy+oIeNClJa2cDzrW8+3C
         /rOg==
X-Gm-Message-State: AOJu0Yxl29Q48e2Dl9xuSeZv8rFUxn9rXJnQBwIJj3aSQTitUxciekae
	NJJmEb6CFP2uua+jwWnwv5eYBjSr1kdvaz1z+oKW/1bN2b5n/YtqIBL3jPBR
X-Google-Smtp-Source: AGHT+IGdZhV5bxBeeUmmwgSlzXQMYoimx5PGXPGrr8Ve7jtmllA3H42p0lrX2YJCWZIhgzqDqaeLuw==
X-Received: by 2002:a17:903:11c3:b0:1dc:d8de:5664 with SMTP id q3-20020a17090311c300b001dcd8de5664mr11335910plh.33.1709860145857;
        Thu, 07 Mar 2024 17:09:05 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001d9641003cfsm14286578plf.142.2024.03.07.17.09.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:09:05 -0800 (PST)
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
Subject: [PATCH v3 bpf-next 14/14] selftests/bpf: Add bpf_arena_htab test.
Date: Thu,  7 Mar 2024 17:08:12 -0800
Message-Id: <20240308010812.89848-15-alexei.starovoitov@gmail.com>
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

bpf_arena_htab.h - hash table implemented as bpf program

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++++++++++++++++
 .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++++++++++++++
 .../testing/selftests/bpf/progs/arena_htab.c  |  48 +++++++++
 .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
 6 files changed, 243 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index f9101651747b..d8ade15e2789 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -11,3 +11,4 @@ fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_mu
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
 verifier_arena                                   # JIT does not support arena
+arena_htab                                       # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index aa8a620f3318..f4a2f66a683d 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -5,3 +5,4 @@ get_stack_raw_tp                         # user_stack corrupted user stack
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
 verifier_iterating_callbacks
 verifier_arena                           # JIT does not support arena
+arena_htab                               # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/bpf_arena_htab.h b/tools/testing/selftests/bpf/bpf_arena_htab.h
new file mode 100644
index 000000000000..acc01a876668
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_htab.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+#include <errno.h>
+#include "bpf_arena_alloc.h"
+#include "bpf_arena_list.h"
+
+struct htab_bucket {
+	struct arena_list_head head;
+};
+typedef struct htab_bucket __arena htab_bucket_t;
+
+struct htab {
+	htab_bucket_t *buckets;
+	int n_buckets;
+};
+typedef struct htab __arena htab_t;
+
+static inline htab_bucket_t *__select_bucket(htab_t *htab, __u32 hash)
+{
+	htab_bucket_t *b = htab->buckets;
+
+	cast_kern(b);
+	return &b[hash & (htab->n_buckets - 1)];
+}
+
+static inline arena_list_head_t *select_bucket(htab_t *htab, __u32 hash)
+{
+	return &__select_bucket(htab, hash)->head;
+}
+
+struct hashtab_elem {
+	int hash;
+	int key;
+	int value;
+	struct arena_list_node hash_node;
+};
+typedef struct hashtab_elem __arena hashtab_elem_t;
+
+static hashtab_elem_t *lookup_elem_raw(arena_list_head_t *head, __u32 hash, int key)
+{
+	hashtab_elem_t *l;
+
+	list_for_each_entry(l, head, hash_node)
+		if (l->hash == hash && l->key == key)
+			return l;
+
+	return NULL;
+}
+
+static int htab_hash(int key)
+{
+	return key;
+}
+
+__weak int htab_lookup_elem(htab_t *htab __arg_arena, int key)
+{
+	hashtab_elem_t *l_old;
+	arena_list_head_t *head;
+
+	cast_kern(htab);
+	head = select_bucket(htab, key);
+	l_old = lookup_elem_raw(head, htab_hash(key), key);
+	if (l_old)
+		return l_old->value;
+	return 0;
+}
+
+__weak int htab_update_elem(htab_t *htab __arg_arena, int key, int value)
+{
+	hashtab_elem_t *l_new = NULL, *l_old;
+	arena_list_head_t *head;
+
+	cast_kern(htab);
+	head = select_bucket(htab, key);
+	l_old = lookup_elem_raw(head, htab_hash(key), key);
+
+	l_new = bpf_alloc(sizeof(*l_new));
+	if (!l_new)
+		return -ENOMEM;
+	l_new->key = key;
+	l_new->hash = htab_hash(key);
+	l_new->value = value;
+
+	list_add_head(&l_new->hash_node, head);
+	if (l_old) {
+		list_del(&l_old->hash_node);
+		bpf_free(l_old);
+	}
+	return 0;
+}
+
+void htab_init(htab_t *htab)
+{
+	void __arena *buckets = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+
+	cast_user(buckets);
+	htab->buckets = buckets;
+	htab->n_buckets = 2 * PAGE_SIZE / sizeof(struct htab_bucket);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_htab.c b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
new file mode 100644
index 000000000000..0766702de846
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <network_helpers.h>
+
+#include "arena_htab_asm.skel.h"
+#include "arena_htab.skel.h"
+
+#define PAGE_SIZE 4096
+
+#include "bpf_arena_htab.h"
+
+static void test_arena_htab_common(struct htab *htab)
+{
+	int i;
+
+	printf("htab %p buckets %p n_buckets %d\n", htab, htab->buckets, htab->n_buckets);
+	ASSERT_OK_PTR(htab->buckets, "htab->buckets shouldn't be NULL");
+	for (i = 0; htab->buckets && i < 16; i += 4) {
+		/*
+		 * Walk htab buckets and link lists since all pointers are correct,
+		 * though they were written by bpf program.
+		 */
+		int val = htab_lookup_elem(htab, i);
+
+		ASSERT_EQ(i, val, "key == value");
+	}
+}
+
+static void test_arena_htab_llvm(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_htab *skel;
+	struct htab *htab;
+	size_t arena_sz;
+	void *area;
+	int ret;
+
+	skel = arena_htab__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_htab__open_and_load"))
+		return;
+
+	area = bpf_map__initial_value(skel->maps.arena, &arena_sz);
+	/* fault-in a page with pgoff == 0 as sanity check */
+	*(volatile int *)area = 0x55aa;
+
+	/* bpf prog will allocate more pages */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_htab_llvm), &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+		goto out;
+	}
+	htab = skel->bss->htab_for_user;
+	test_arena_htab_common(htab);
+out:
+	arena_htab__destroy(skel);
+}
+
+static void test_arena_htab_asm(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_htab_asm *skel;
+	struct htab *htab;
+	int ret;
+
+	skel = arena_htab_asm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_htab_asm__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_htab_asm), &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+	htab = skel->bss->htab_for_user;
+	test_arena_htab_common(htab);
+	arena_htab_asm__destroy(skel);
+}
+
+void test_arena_htab(void)
+{
+	if (test__start_subtest("arena_htab_llvm"))
+		test_arena_htab_llvm();
+	if (test__start_subtest("arena_htab_asm"))
+		test_arena_htab_asm();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
new file mode 100644
index 000000000000..b7bb712cacfd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -0,0 +1,48 @@
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
+} arena SEC(".maps");
+
+#include "bpf_arena_htab.h"
+
+void __arena *htab_for_user;
+bool skip = false;
+
+int zero = 0;
+
+SEC("syscall")
+int arena_htab_llvm(void *ctx)
+{
+#if defined(__BPF_FEATURE_ARENA_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	struct htab __arena *htab;
+	__u64 i;
+
+	htab = bpf_alloc(sizeof(*htab));
+	cast_kern(htab);
+	htab_init(htab);
+
+	/* first run. No old elems in the table */
+	for (i = zero; i < 1000; i++)
+		htab_update_elem(htab, i, i);
+
+	/* should replace all elems with new ones */
+	for (i = zero; i < 1000; i++)
+		htab_update_elem(htab, i, i);
+	cast_user(htab);
+	htab_for_user = htab;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_htab_asm.c b/tools/testing/selftests/bpf/progs/arena_htab_asm.c
new file mode 100644
index 000000000000..6cd70ea12f0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_htab_asm.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#define BPF_ARENA_FORCE_ASM
+#define arena_htab_llvm arena_htab_asm
+#include "arena_htab.c"
-- 
2.43.0

