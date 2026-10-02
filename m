Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DD392C29
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945280; cv=none; b=YWs52lIRf4PiY5Q6YvfxG+EBBJ2ImJuOXqgFsme2b/l7l7j1PJnKEr57jbz04EJOwinkhTbyj4Fcd62ddEXKHbiUcAw3Zsk0S8J/PQGG7yVU8A1DA7xD0evy92ro6lIwpV5orX3hOKMSorrQG4Ezbqko0OeWZmFGRYnveI2DWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945280; c=relaxed/simple;
	bh=iyu3r4ZpYtdhtQo2fFtabTOnABd+hKC0BvnNCaJAXLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uscU1jmMlCs+i6rEgOZPBuyhFbiRYQS6KFWRilBfBvFgQMNCBzYtbSDAwQUx+vVYbTvZRAP7KSKyAPfMDRmWmowg7OyZZtL8Taelxz2MRpsy9EAcJmRLsJ5pixeoklY2KqTOgwLn1RN3XOVf5bnZIN1p7f9FChIYtTo8iM5/GiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZjJz/3f; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZjJz/3f"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso3234872a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945278; x=1791550078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9Y8Iwes8AWGfDJL7nS8zaj310eWOVguIMUnWp/QKVQ=;
        b=AZjJz/3fVa6Vpp5jXeTHG3aIWk+2DYZCRyOXy58WAJ88jxdC/YU8yHOvQQRC/Uq/zF
         49vHLSo87fSa0uUqU3cO3Ls8xtm4fQOxuqRGQzG88RbkH27HrmUX0xuLD1191J5H4tAB
         4c56se8ooOTNdSefiXa3D+vZE2tCCYiEFi9H2FEmMHgeSYz/pCJS5U+q0uSvUC9yCwB5
         MvGuJ0xQAkd+8hptAxKA678C8ZOWgPq5MQjPKn94qEtMhSMbj4f/b6J7+NU+rxT+cRoX
         kUvXca3hiJYuZkaMyKe0+VfmWG0Au/XnBhMNbcx/IJllO3EACx7FixSzI3w9ebCtKMwf
         aYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945278; x=1791550078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9Y8Iwes8AWGfDJL7nS8zaj310eWOVguIMUnWp/QKVQ=;
        b=PdcOfYbHshgQGeHKTapzIUV7c4TdFgooqXW7aW0dOsWBJag9QwoFMX7NwTSa+tjyWT
         HZyFeeGJFFx6twbZ3YFHzMrQC2oaepCU8H+imGQm9oj0uAI62POXpcT7l3fh32OLivdF
         E5zWAXPqBz8pMAKvdjDSk3X+Zf3FPjsSCht7nLN8TkB3KHcc9dPiIiMTbRaOXSSMAq59
         dcG0pO6WXRb3j2j6UwKjERZNhjgkbH8KQBUl7kbv3v9B6C8St144PZlL/NVrwU4eD0Yw
         27NTWBmHadq4jWYCIEiOwWEqhmu6CokLLvJPRrSlvVxeVmYSkqHU4EHh5O4R+KQY8J3R
         /IVQ==
X-Gm-Message-State: AFq9FYI8D90xAT823Q3ct9MIOrZRBglFypO2zNk19fB5g/ZUARhrFF2/
	kL17kU5d/Tc+JVakT4JSEzhYQsqxuBGiA+CUHEXiekTxbytPcfZr3BPeG1EzmI7pyxQ=
X-Gm-Gg: AYBFou0qCL0wdXyLkH1jA5Bp6dU7aCt1Lt35IA4wlK7upjQkoRFOTLJ84OQ8vzOWq5k
	8SA/nzFW9eaJAzcyEU68+SqgkwvmzaIpZTr7d56CnsY8oZrQ9l3THr4JX2IeRIqTHrlObOdwh4h
	NkGF4IjgC/Ed+lYu1AYgNj1l1FUuiGyWeS7ujnQaQIUA8q4FgmzO7ZFSstMG2bHlfSPzLlDvUWn
	VVkzrGbvnuQseT1R+siC8P0pUpEND5dKxt+s74kVpx7TXlpbdsqPeUqS+l/x1E/a7dTRF3g/nZh
	kRH1c5Y2Qb03eADm85BmZH9+paJixvb9NtYLzav+pCNeiTpfr8vMVYDvTZ6iwXQLl64J/qrhsf+
	8aZju1zuITqT+NpAKQn6rUNRqMcBLCz8sIBG17SNTXMZNiDJ57WwKj5scP1ngktPmwGrd5ZI4Id
	CPmB83EPWM0Aztrs4LfVqwfizB88AlbAkkSUph568D91iBF04sBGTLg8XP1rYVTNS1iF0Y0KsyN
	aw7LppDCfD+8OzRfspKHUDuP4gzNlOXlKMiqjM3VRNDvCSd8L6HnonoodiZPwWjFcU7tMVf4sbK
	9j9NZbHAp6DSXr9Y8OmYoYu4NdEKpmPlQVJbBAdrxbQ=
X-Received: by 2002:a17:90b:3b50:b0:3a4:7023:785f with SMTP id 98e67ed59e1d1-3a6ce855855mr1019962a91.51.1790945277764;
        Fri, 02 Oct 2026 05:47:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6d432fc0dsm3592466a91.7.2026.10.02.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Add test for global data in arena
Date: Fri,  2 Oct 2026 12:47:13 +0000
Message-ID: <20261002124714.180012-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Load the program that reads and writes .data, .bss and .rodata from
the object with .arena.data section. Check that initial values set
through the skeleton reach the program and that the values written by
the program are seen through the skeleton.

Also check:
- alignment of a section.
- pointers to data and to a const string that are stored in data and
  in read-only data, next to a pointer to a function that callx uses.
- bpf_strncmp() with a string literal, bpf_printk() and BPF_SNPRINTF().
- an object that has an arena map and __arena variables.
- the load fails when a pointer in data points to a section that is
  not in arena or to a variable of the kernel.
- the load fails when there are pointers in data and the arena is
  pinned or reused.
- the open fails when there are __arena variables and no arena map.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../selftests/bpf/prog_tests/data_in_arena.c  | 191 ++++++++++++++++++
 .../selftests/bpf/progs/data_in_arena.c       | 107 ++++++++++
 .../selftests/bpf/progs/data_in_arena_decl.c  |  37 ++++
 .../bpf/progs/data_in_arena_extern.c          |  20 ++
 .../selftests/bpf/progs/data_in_arena_fail.c  |  20 ++
 .../selftests/bpf/progs/data_in_arena_nomap.c |  20 ++
 7 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 2e22bb901bf3..765666a64b89 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -20,7 +20,8 @@ ifneq ($(BPF_CC),)
 BPF_SRCS := $(notdir $(wildcard progs/*.c))
 BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
 
-SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c	\
+		  data_in_arena_extern.c data_in_arena_nomap.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
new file mode 100644
index 000000000000..86dc6798bbde
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "data_in_arena.skel.h"
+#include "data_in_arena_decl.skel.h"
+#include "data_in_arena_fail.skel.h"
+
+static int run_prog(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &topts), "test_run"))
+		return -1;
+	return topts.retval;
+}
+
+static void run(struct data_in_arena *skel, int counter)
+{
+	int i;
+
+	ASSERT_EQ(run_prog(skel->progs.use_data), counter + 7 + 1 + 2, "retval");
+	ASSERT_EQ(skel->bss->sum, counter + 7 + 1 + 2, "sum");
+	ASSERT_EQ(skel->data->counter, counter + 1, "counter");
+	ASSERT_EQ(skel->data->pair[1], 5, "pair[1]");
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(skel->bss->table[i], 10 * (i + 1) + i, "table");
+}
+
+static void test_in_arena(void)
+{
+	struct bpf_map_info info = {};
+	struct data_in_arena *skel;
+	__u32 len = sizeof(info);
+	struct bpf_map *arena;
+	size_t sz;
+
+	skel = data_in_arena__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	arena = bpf_object__find_map_by_name(skel->obj, "arena");
+	if (!ASSERT_OK_PTR(arena, "arena"))
+		goto out;
+	ASSERT_EQ(bpf_map__type(arena), BPF_MAP_TYPE_ARENA, "arena type");
+	ASSERT_EQ(bpf_map__max_entries(arena), 1, "arena pages");
+	ASSERT_OK(bpf_map__set_max_entries(arena, 8), "arena resize");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.data), "data autocreate");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.bss), "bss autocreate");
+	ASSERT_FALSE(bpf_map__autocreate(skel->maps.rodata), "rodata autocreate");
+	ASSERT_EQ(bpf_map__set_autocreate(skel->maps.data, true), -EOPNOTSUPP, "set_autocreate");
+	ASSERT_EQ(bpf_map__set_value_size(skel->maps.bss, 4096), -EOPNOTSUPP, "set_value_size");
+	ASSERT_EQ(bpf_map__initial_value(skel->maps.data, &sz), skel->data, "initial_value");
+	ASSERT_EQ(sz, sizeof(*skel->data), "initial_value size");
+
+	/* initial values are set the usual way */
+	skel->data->counter = 100;
+
+	if (!ASSERT_OK(data_in_arena__load(skel), "load"))
+		goto out;
+	/* there are no maps behind the sections */
+	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.data), &info, &len), "data map");
+	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.bss), &info, &len), "bss map");
+	ASSERT_ERR(bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.rodata), &info, &len),
+		   "rodata map");
+	run(skel, 100);
+
+	/* pointers to data next to pointers to functions */
+	ASSERT_EQ(run_prog(skel->progs.use_ops), 42 + 1 + 'e', "use_ops");
+	ASSERT_EQ(skel->data->counter, 102, "counter");
+
+	/* alignment of sections and pointers to data in data */
+	ASSERT_EQ((unsigned long)&skel->bss->aligned64 % 64, 0, "alignment");
+	ASSERT_EQ(run_prog(skel->progs.use_ptrs), 0, "use_ptrs");
+	ASSERT_EQ(skel->data->x, 43, "x");
+	ASSERT_EQ(skel->bss->aligned64.v[7], 7, "aligned64");
+	ASSERT_EQ(skel->data->px, &skel->data->x, "px");
+
+	/* format strings of bpf_printk() and BPF_SNPRINTF() */
+	ASSERT_EQ(run_prog(skel->progs.use_printk), sizeof("43-7"), "use_printk");
+	ASSERT_STREQ(skel->bss->out, "43-7", "out");
+out:
+	data_in_arena__destroy(skel);
+}
+
+/* The object has an arena map and __arena variables */
+static void test_declared_arena(void)
+{
+	struct data_in_arena_decl *skel;
+	struct bpf_map *map;
+	int arenas = 0;
+
+	skel = data_in_arena_decl__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_object__for_each_map(map, skel->obj)
+		arenas += bpf_map__type(map) == BPF_MAP_TYPE_ARENA;
+	ASSERT_EQ(arenas, 1, "no second arena");
+	skel->data->counter = 6;
+	if (!ASSERT_OK(data_in_arena_decl__load(skel), "load"))
+		goto out;
+	ASSERT_EQ(run_prog(skel->progs.use_data), 6 + 7 + 11, "retval");
+	ASSERT_EQ(run_prog(skel->progs.use_data), 7 + 7 + 12, "retval");
+	ASSERT_EQ(skel->bss->sum, 7 + 7 + 12, "sum");
+	ASSERT_EQ(skel->data->counter, 8, "counter");
+out:
+	data_in_arena_decl__destroy(skel);
+}
+
+/* A pointer in data that can't be made an address of arena fails the load */
+static void test_ptr_to_map(void)
+{
+	struct data_in_arena_fail *skel;
+
+	skel = data_in_arena_fail__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	ASSERT_ERR(data_in_arena_fail__load(skel), "load");
+	data_in_arena_fail__destroy(skel);
+}
+
+/* So does a pointer to a variable of the kernel. There is no skeleton: the open fails. */
+static void test_ptr_to_extern(void)
+{
+	struct bpf_object *obj;
+
+	obj = bpf_object__open_file("./data_in_arena_extern.bpf.o", NULL);
+	if (!ASSERT_ERR_PTR(obj, "open"))
+		bpf_object__close(obj);
+}
+
+/* __arena variables and no arena map. There is no skeleton: the open fails. */
+static void test_arena_var_no_map(void)
+{
+	struct bpf_object *obj;
+
+	obj = bpf_object__open_file("./data_in_arena_nomap.bpf.o", NULL);
+	if (!ASSERT_ERR_PTR(obj, "open"))
+		bpf_object__close(obj);
+}
+
+/* The address of an arena that libbpf doesn't create is not known. No pointers in data then. */
+static void test_not_my_arena(bool pin)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+	struct data_in_arena *skel;
+	struct bpf_map *arena;
+	int fd = -1;
+
+	skel = data_in_arena__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	arena = bpf_object__find_map_by_name(skel->obj, "arena");
+	if (!ASSERT_OK_PTR(arena, "arena"))
+		goto out;
+	if (pin) {
+		ASSERT_OK(bpf_map__set_pin_path(arena, "/sys/fs/bpf/data_in_arena"), "pin_path");
+	} else {
+		fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0, 1, &opts);
+		if (!ASSERT_GE(fd, 0, "map_create"))
+			goto out;
+		ASSERT_OK(bpf_map__reuse_fd(arena, fd), "reuse_fd");
+	}
+	ASSERT_EQ(data_in_arena__load(skel), -ENOTSUP, "load");
+out:
+	if (fd >= 0)
+		close(fd);
+	data_in_arena__destroy(skel);
+}
+
+void test_data_in_arena(void)
+{
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	/* other JITs don't take BPF_F_ARENA_SCALAR */
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("arena"))
+		test_in_arena();
+	if (test__start_subtest("declared_arena"))
+		test_declared_arena();
+	if (test__start_subtest("ptr_to_map"))
+		test_ptr_to_map();
+	if (test__start_subtest("ptr_to_extern"))
+		test_ptr_to_extern();
+	if (test__start_subtest("arena_var_no_map"))
+		test_arena_var_no_map();
+	if (test__start_subtest("pinned_arena"))
+		test_not_my_arena(true);
+	if (test__start_subtest("reused_arena"))
+		test_not_my_arena(false);
+}
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena.c b/tools/testing/selftests/bpf/progs/data_in_arena.c
new file mode 100644
index 000000000000..ce3838327d6f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* global data of the object is in arena */
+char data_in_arena SEC(".arena.data");
+
+int counter = 5;
+long pair[2] = { 1, 2 };
+int x = 42;
+long sum;
+long table[4];
+struct {
+	long v[8];
+} aligned64 __attribute__((aligned(64)));
+const volatile int ro = 7;
+const volatile long ro_table[4] = { 10, 20, 30, 40 };
+
+/* const strings stay in a map for helpers and kfuncs, a copy of them is in arena */
+const char hello[] SEC(".rodata.str.hello") = "hello";
+
+/* pointers to data that are stored in data */
+int *px = &x;
+const char *str = hello;
+int *const volatile cpx SEC(".data.rel.ro") = &x;
+
+SEC("syscall")
+int use_data(void *ctx)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		table[i] = ro_table[i] + i;
+	sum = counter + ro + pair[0] + pair[1];
+	counter++;
+	__sync_fetch_and_add(&pair[1], 3);
+	return sum;
+}
+
+typedef int (*op_fn)(int);
+
+static __noinline int add1(int v)
+{
+	return v + 1;
+}
+
+/*
+ * Pointers to functions and to data in read-only data of a program with callx.
+ * Volatile, so that the compiler doesn't replace the pointers with what
+ * they point to.
+ */
+static const volatile struct {
+	op_fn fn;
+	int *data;
+	const char *name;
+} ops SEC(".data.rel.ro") = { add1, &x, hello };
+
+SEC("syscall")
+int use_ops(void *ctx)
+{
+	/* a program has the arena when its code refers to it */
+	counter++;
+	return ops.fn(*ops.data) + ops.name[1];
+}
+
+SEC("syscall")
+int use_ptrs(void *ctx)
+{
+	unsigned long addr = (unsigned long)&aligned64;
+	char local[4] = "abc";
+
+	/* hide the address from the compiler, it knows that '& 63' is 0 */
+	asm volatile ("" : "+r"(addr));
+	if (addr & 63)
+		return 1;
+	aligned64.v[7] = 7;
+	if (*px != 42)
+		return 2;
+	*px = 43;
+	if (x != 43 || *cpx != 43)
+		return 3;
+	if (str[0] != 'h' || str[4] != 'o' || str[5])
+		return 4;
+	/* the literal is in a map */
+	if (bpf_strncmp(local, sizeof(local), "abc"))
+		return 5;
+	return 0;
+}
+
+char out[16];
+
+/* format strings are in a map */
+SEC("syscall")
+int use_printk(void *ctx)
+{
+	char buf[sizeof(out)];
+	int i, n;
+
+	bpf_printk("counter %d", counter);
+	n = BPF_SNPRINTF(buf, sizeof(buf), "%d-%d", x, ro);
+	for (i = 0; i < sizeof(out); i++)
+		out[i] = buf[i];
+	return n;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_decl.c b/tools/testing/selftests/bpf/progs/data_in_arena_decl.c
new file mode 100644
index 000000000000..01bc4fea8f0c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_decl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 4);
+} arena SEC(".maps");
+
+/* global data of the object is in arena */
+char data_in_arena SEC(".arena.data");
+
+int counter = 5;
+long sum;
+const volatile int ro = 7;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+int __arena avar = 11;
+#else
+int avar = 11;
+#endif
+
+SEC("syscall")
+int use_data(void *ctx)
+{
+	sum = counter + ro + avar;
+	counter++;
+	avar++;
+	return sum;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_extern.c b/tools/testing/selftests/bpf/progs/data_in_arena_extern.c
new file mode 100644
index 000000000000..dc1ad5ca3bdd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_extern.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* global data of the object is in arena */
+char data_in_arena SEC(".arena.data");
+
+extern const int bpf_prog_active __ksym;
+
+/* the variable of the kernel is not in arena */
+const void *kp = &bpf_prog_active;
+
+SEC("syscall")
+int ptr_to_extern(void *ctx)
+{
+	return *(int *)kp;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_fail.c b/tools/testing/selftests/bpf/progs/data_in_arena_fail.c
new file mode 100644
index 000000000000..ad8afe9afc96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_fail.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* global data of the object is in arena */
+char data_in_arena SEC(".arena.data");
+
+int x = 42;
+/* the table is read-only data with pointers. It's not in arena. */
+int *const volatile tbl[1] SEC(".data.rel.ro") = { &x };
+int *const volatile *pp = tbl;
+
+SEC("syscall")
+int ptr_to_map(void *ctx)
+{
+	return **pp;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
new file mode 100644
index 000000000000..da27a8f10d6f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+/* global data of the object is in arena */
+char data_in_arena SEC(".arena.data");
+
+int counter = 5;
+/* needs an arena map that is declared. The one that libbpf creates won't do. */
+int __arena avar = 11;
+
+SEC("syscall")
+int arena_var(void *ctx)
+{
+	return avar + counter;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

