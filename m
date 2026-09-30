Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCD3DBD51
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796732; cv=none; b=uPfahGkREdtLW6R17KhvbPKH54iGzngCzKHNfh+B5N8CgNBupfFq6l98Hvx3iwCSATNAkij9KSQNN//PXu2INaU1oTGZAXinwjY0pmv+/Qh9C0Mp+1t89+OF38flHojDxK5XiiWrx/fFm5PL132e2VoLaopBZTnsRuuCBuBT7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796732; c=relaxed/simple;
	bh=Sl+NLmrPIZovkRYbmsQGnMPWUHWHRLexqKUSZqHz0gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHHXtcowwJS6w8SDHLcANT/qSRyp5rG2+ejJiIJqdVI3RaSYDwVJwU1oeH/6rS9T8GxCIjp/YuT+wGRbngnf15dp4WSiG6joA5iZf7kUnQZoA0zt8TbFhGuU/ZCTvY/kFDUgdAgsgCnj4uM8RQN0zzAHpBmmqQ2OUDMEkozJPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqEqi5kn; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqEqi5kn"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2c7eb3b8cso11077445ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796730; x=1791401530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kRo+jw0TCvn6U4F82jY6zcxAj0CWW6zUCCLKcWadfQ=;
        b=AqEqi5knk+13gMMDIFn8zbw6ISxDznA4tWCWu9+G1anJeWKfKlTG2D9SejbLapsDSq
         +eGnguBZfk+y9lcm2/abmlBcP1ivigfqm+Jfj4utNSAXuP7xaRxitq3B6WDvQszvw7Oz
         djg1jtntuitB7HNRGePcwTCAuTAOFNyq4YoE6CVpgBBHpdpMY/YuE865SFhPX2NBpzwM
         rYMyhdupPJTKZxW5uul3WrXxZYPiKb2zKJrDgEAuclYRDRDmgFyNnfrgxKduXJthg8vR
         7B3S9FA/Diopmq30eEpkLVLR1Zpj9KZkcXHzDNQ2f0OmXn5JiCJWPMAaL5QNv0UjNqz3
         NcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796730; x=1791401530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kRo+jw0TCvn6U4F82jY6zcxAj0CWW6zUCCLKcWadfQ=;
        b=NJzh/44dIUEebHb6tFZQ0cYQm3XwNzPkh02DXHFDQggckQ/CirID9af6vibCuUg/Go
         6UOxkzbUERgdhLWGe4BTLj0nJjKFxA8vbrxu0BNx9zzoh0VfStR4injCb+I7HbBlwwe+
         2R8/UkC3qIVrOFT0noV1upnpdQtVV+an94M0UL2hfVQky5jKLaV8K4l/htoTHmdt+nNT
         RFFg2lZpYu1Dw+FtrhUylyTQEfIxZwFq4qBvXnZ86Uw6Mjf72WH0DpsrioSdh/5K8c+5
         aNN69tTtruuya7uJ7eSJQA3JWEpz82mxhA43HcOvxL5v2OK3Rny6A8jPT3mxfO157LJX
         k7bA==
X-Gm-Message-State: AFq9FYK69Owx0bTZJJWZoRNKwLvLDJ0hDH46NLehZepeEuEP6zlMqcZe
	Q5wi2Mz/E61XvE+raMKul2VmRcMxui/Qmav/sEJegV1npBsIdQ1yXM7jgSVce4TZ
X-Gm-Gg: AYBFou1jWJhpEtP30gJdHwnjTJHieenI9nrZhB+HShizo/BuapQg3jIJAtKJg3ln9hs
	vlt2SS3KUihk3CnElO2vI5nSsPfoAA37fuCo6VDcnknOvh5ooSEGnbK6+hv5wCXnZlVIoJ3e02o
	hqOAuuvA24pgG1Eyn2KhVj1gpCzsUnKPOddmRLffAgs/GRsw6l86O0Ri2qGmq30bFjsDE0DlC0v
	qFANsyLsl79iBKprJrp6HIhX+5WK0N0UmjEkc5sibLS+CB8dJn7HRSDpSvBWav5fxmWHHMvZa7Q
	r/Vx9ZZEFNgV0IIAT1ltiGTcn+eksnYw1F2d2Y3cYhSddPYOs3V2GbIiO+mOXgJINMBYvxqABiL
	GvItffm2MwVQTEiV9l3PxbRMfv0LjvZOY2G4qOjupZ66avX9EbopVhbsrxaYOzxzQ+LMxVLL0aI
	s20/DJwofSwJ6yD9N7X3vU+DacwJv/eyaEde8LdknOWec4ipSKKRSWapGlv0W9jmm6JoZa+K5vu
	2cWHYY8HIcTsXVOhH/h6L8h0Uh8vtHQ//LZU/T50Q+iWff7875eHO58YaFv4qh0oR9XJgmoYefx
	tZU65bdUKNyYT1Bbhb2ToqfmNFSZTQz2Po8QTCRQmNuQ
X-Received: by 2002:a17:90b:5447:b0:3a4:9b8b:2ab9 with SMTP id 98e67ed59e1d1-3a4d11dcd85mr2102348a91.8.1790796729790;
        Wed, 30 Sep 2026 12:32:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f3ff67cfsm720437a91.0.2026.09.30.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:32:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 13/14] selftests/bpf: Add test for global data in arena
Date: Wed, 30 Sep 2026 19:31:26 +0000
Message-ID: <20260930193127.2181684-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../selftests/bpf/prog_tests/data_in_arena.c  | 146 ++++++++++++++++++
 .../selftests/bpf/progs/data_in_arena.c       | 107 +++++++++++++
 .../selftests/bpf/progs/data_in_arena_decl.c  |  37 +++++
 .../bpf/progs/data_in_arena_extern.c          |  20 +++
 .../selftests/bpf/progs/data_in_arena_fail.c  |  20 +++
 6 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_decl.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_extern.c
 create mode 100644 tools/testing/selftests/bpf/progs/data_in_arena_fail.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 2e22bb901bf3..d9ddd1d86f89 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -20,7 +20,8 @@ ifneq ($(BPF_CC),)
 BPF_SRCS := $(notdir $(wildcard progs/*.c))
 BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
 
-SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c	\
+		  data_in_arena_extern.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
diff --git a/tools/testing/selftests/bpf/prog_tests/data_in_arena.c b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
new file mode 100644
index 000000000000..bccfb0110b94
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/data_in_arena.c
@@ -0,0 +1,146 @@
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
-- 
2.55.0

