Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2E3A641B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376398; cv=none; b=KmECDg6ZJDPn0VauJ040qdl4Yr6BxHc124KTdUqc51Cl3F1bFjayq9J647/DPqk1Up+1OEny3YliDR/HCiweEKXKhN6d5O1ItlKQffbEK8Pqo8LLfRs8us4Ak0VFYS5XkJCE9A9+3FmDZvS+D3lwB/zjI+kHpwpjjocFsUH10hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376398; c=relaxed/simple;
	bh=XDTvcMXByK63iEglteU1/033CNTJAZ21Pu0QSKqb7Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxBjWLF9Fvp/7ebnwAk6L/VuB2ziSZhIx1bs1iOTAu72n/h45LtLf8vEHCcp6mvqtwDBEbHsBnxb+cyuxR3qEG8emfgnE2CHWUnwd+8jTkTgGypaofDEWnDM4eliGqT6unhgMeOjqG7vRtEIWihfESNTr2xym5O00wWErVNJTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnhBVbtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnhBVbtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B41E1F000FF;
	Fri, 25 Sep 2026 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376397;
	bh=H/e7Fj22AEoPtTkry7kqmhjucnQYFLUEx8Ul8xWz8og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnhBVbtt03HeLwLtsmyLuN+90hhtwQDkfzpa8JvwELFwe8Jv2vgmjvYYWXn6qAw+t
	 8lGNTtqWzgiYbX6pRS91br9ViJC0Sg9y6H2eIk3o60e2Y75/pacJs0HA15x4qysHqz
	 L+s+QGJdZainDMK0HqyhzMID6fdm98DYfkSUrilvePDmv6YlCgLy2vuiJjHgOTF0nW
	 liOE+IEn0gMNDmIFP1C4f+LymtYdGt4+aciI93PSLPc9HB329FacemJo1+aCEZTuDB
	 YbVlVlB/+OMrj4mozK7eux0wL/1XFw/OA0MOWzCdMCVOjIMlx3zgrZffxZFgA02qlc
	 oP6Y1zo2IgZ9A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add linked_externs test for externs in allocated sections
Date: Fri, 25 Sep 2026 15:46:31 -0700
Message-ID: <20260925224631.1490488-2-andrii@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925224631.1490488-1-andrii@kernel.org>
References: <20260925224631.1490488-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two objects that define an arena global each and declare the
other one's as extern, linked into a single skeleton with the
extern-declaring object first.

The skeleton build relinks the linked object twice more, which fixes
up DATASEC offsets from the ELF symbol table, so the test also drives
the libbpf linker directly: it links linked_arena1.bpf.o on its own,
links the result with linked_arena2.bpf.o, checks that no variable in
the .addr_space.1 DATASEC is left extern, and loads the object. The
same is done with linked_maps1/2.bpf.o, which have an extern map in
.maps.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../selftests/bpf/prog_tests/linked_externs.c | 109 ++++++++++++++++++
 .../selftests/bpf/progs/linked_arena1.c       |  22 ++++
 .../selftests/bpf/progs/linked_arena2.c       |  18 +++
 4 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_externs.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_arena1.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_arena2.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 3d92cdca62ed..2e22bb901bf3 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -23,7 +23,7 @@ BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
-		linked_vars.skel.h linked_maps.skel.h 			\
+		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
 		test_usdt.skel.h tracing_multi.skel.h			\
 		tracing_multi_module.skel.h				\
@@ -46,6 +46,7 @@ test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.
 linked_funcs.skel.h-deps := linked_funcs1.bpf.o linked_funcs2.bpf.o
 linked_vars.skel.h-deps := linked_vars1.bpf.o linked_vars2.bpf.o
 linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
+linked_arena.skel.h-deps := linked_arena1.bpf.o linked_arena2.bpf.o
 # In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
 # but that's created as a side-effect of the skel.h generation.
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
new file mode 100644
index 000000000000..29358c82dc35
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "linked_arena.skel.h"
+
+static void test_skel(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct linked_arena *skel;
+	int err;
+
+	skel = linked_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	ASSERT_EQ(skel->arena->a_val, 1, "a_val_init");
+	ASSERT_EQ(skel->arena->b_val, 2, "b_val_init");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.sum1), &opts);
+	ASSERT_OK(err, "sum1_run");
+	ASSERT_EQ(opts.retval, 1 + 2, "sum1_retval");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bump2), &opts);
+	ASSERT_OK(err, "bump2_run");
+	ASSERT_EQ(opts.retval, 11 + 22, "bump2_retval");
+
+	ASSERT_EQ(skel->arena->a_val, 11, "a_val");
+	ASSERT_EQ(skel->arena->b_val, 22, "b_val");
+
+	linked_arena__destroy(skel);
+}
+
+static int link_objs(const char *out, const char *in1, const char *in2)
+{
+	struct bpf_linker *linker;
+	int err;
+
+	linker = bpf_linker__new(out, NULL);
+	if (!ASSERT_OK_PTR(linker, "linker_new"))
+		return -EINVAL;
+
+	err = bpf_linker__add_file(linker, in1, NULL);
+	if (!ASSERT_OK(err, in1))
+		goto cleanup;
+	if (in2) {
+		err = bpf_linker__add_file(linker, in2, NULL);
+		if (!ASSERT_OK(err, in2))
+			goto cleanup;
+	}
+	err = bpf_linker__finalize(linker);
+	ASSERT_OK(err, "finalize");
+
+cleanup:
+	bpf_linker__free(linker);
+	return err;
+}
+
+/* link in1 on its own first, then link the result with in2 */
+static void test_relink(const char *in1, const char *in2, const char *sec_name)
+{
+	char out1[] = "/tmp/linked_externs.XXXXXX", out2[] = "/tmp/linked_externs.XXXXXX";
+	const struct btf_var_secinfo *vi;
+	struct bpf_object *obj = NULL;
+	const struct btf_type *t;
+	struct btf *btf;
+	int i, id, n;
+
+	close(mkstemp(out1));
+	close(mkstemp(out2));
+
+	if (!ASSERT_OK(link_objs(out1, in1, NULL), "link_stage1") ||
+	    !ASSERT_OK(link_objs(out2, out1, in2), "link_stage2"))
+		goto cleanup;
+
+	obj = bpf_object__open_file(out2, NULL);
+	if (!ASSERT_OK_PTR(obj, "obj_open"))
+		goto cleanup;
+
+	btf = bpf_object__btf(obj);
+	id = btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
+	if (!ASSERT_GT(id, 0, "find_datasec"))
+		goto cleanup;
+
+	t = btf__type_by_id(btf, id);
+	vi = btf_var_secinfos(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; i++) {
+		t = btf__type_by_id(btf, vi[i].type);
+		ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_resolved");
+	}
+
+	ASSERT_OK(bpf_object__load(obj), "obj_load");
+
+cleanup:
+	bpf_object__close(obj);
+	unlink(out1);
+	unlink(out2);
+}
+
+void test_linked_externs(void)
+{
+	if (test__start_subtest("skel_arena"))
+		test_skel();
+	if (test__start_subtest("relink_arena"))
+		test_relink("linked_arena1.bpf.o", "linked_arena2.bpf.o", ".addr_space.1");
+	if (test__start_subtest("relink_maps"))
+		test_relink("linked_maps1.bpf.o", "linked_maps2.bpf.o", ".maps");
+}
diff --git a/tools/testing/selftests/bpf/progs/linked_arena1.c b/tools/testing/selftests/bpf/progs/linked_arena1.c
new file mode 100644
index 000000000000..3e8788dec1d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_arena1.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1); /* number of pages */
+} arena SEC(".maps");
+
+long __arena a_val = 1;
+extern long __arena b_val; /* defined in linked_arena2.c */
+
+SEC("syscall")
+int sum1(void *ctx)
+{
+	return a_val + b_val;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_arena2.c b/tools/testing/selftests/bpf/progs/linked_arena2.c
new file mode 100644
index 000000000000..d0bcdf18a4b6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_arena2.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+long __arena b_val = 2;
+extern long __arena a_val; /* defined in linked_arena1.c */
+
+SEC("syscall")
+int bump2(void *ctx)
+{
+	a_val += 10;
+	b_val += 20;
+	return a_val + b_val;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

