Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4436654C;
	Mon, 13 Jul 2026 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910662; cv=none; b=hp5g9e+3Brh9Cdiow3Zw3YkRfx5tAnm14KSbB8xMIkY9ZdOhox7sGwpLA+lEaBkAuXJvdXuIMg6vt7OvoNkoUWnKG7hCq3zHrSXDTGKBRYCYArzdBx1OfAXMj/hUOI7x9TIBMtQZziMsw5S2ARoKrLFukIXkIRQ+moy7yypJJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910662; c=relaxed/simple;
	bh=UVd+SUQL+iS7YX0Uk4vjcQu++9x2mwBuyZbeCHa3ysQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO5tms7Z4cuEZNG747LXBNQW3WIog7h70ZZ+gTjwk8s7NjIzDMFY7oCQ2yuZA6lo0unHcbnHpzJYZFTJgOP3UJ2hQZKsKx0/rB8atIhPiaPm3x50G4nFIN8t/XXCqAObW92GVX3dJJ98aYxW7S8YeI5s2uO4Yj4AIc8YaN4cm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvrGkvhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvrGkvhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6871F000E9;
	Mon, 13 Jul 2026 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910660;
	bh=Tx7yR2phZnd2rp1sOS4g3o0yHZkztimrGxZ5dj5pMz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvrGkvhvMcEjm8iA+vMqPyVLIefN9h7W57L7nxtpS06o5nPlp38JbpYSwNsD/Thnd
	 Bj/JYkNXwhv9vhrBFZJgOPfy/m/1BlXmvv9nT5l+Po4tVnK2ofuKJCtgPOWQtbwccH
	 7pzDonUErfMrdKZVl3Myq3jPpCXA793lvy7vNShtKWeGtbYCYDvqRNAMUtgNvGTJGo
	 S2PvJ0hK/lqKCj5a9UqrZFyIJ2YSrgBXd8/i+qDozEtof+DR8XSfUQTpLWkf/3EsV5
	 2pbOWxX98vSWWjoYTsqrQhTdagHuIb0+TxTSWzfz6c678TqIXin52uhFfHsM1d24Uj
	 LM3uq9twPIRfQ==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 4/6] selftests/bpf: Add struct_ops __arena argument tests
Date: Sun, 12 Jul 2026 16:44:12 -1000
Message-ID: <20260713024414.3759854-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713024414.3759854-1-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test_arena member to bpf_testmod_ops3 with an __arena stub argument
and a kfunc that forwards a caller-provided pointer to it. The kfunc
takes an __arena argument, so the verifier hands it a kernel arena
address, which it passes to the callback. The struct_ops entry prologue
rebases that address back to an arena pointer for the callback, so the
test exercises both conversion directions end to end. The callback
dereferences the argument directly and the trigger program verifies the
write and NULL passing. A second program with no arena verifies the
attach rejection.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 61 +++++++++++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 67 +++++++++++++++++++
 .../bpf/progs/struct_ops_arena_fail.c         | 20 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  2 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 6 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
new file mode 100644
index 000000000000..75a3a649060c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+#include <test_progs.h>
+
+#include "struct_ops_arena.skel.h"
+#include "struct_ops_arena_fail.skel.h"
+
+/* Attach a callback with an __arena argument and drive it through the
+ * bpf_testmod_ops3_call_test_arena() kfunc.
+ */
+static void arena_arg(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct struct_ops_arena *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_arena);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.trigger),
+				     &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "trigger_retval");
+
+out:
+	bpf_link__destroy(link);
+	struct_ops_arena__destroy(skel);
+}
+
+/* A program with no arena cannot attach to a member with an __arena
+ * argument.
+ */
+static void arena_arg_fail(void)
+{
+	struct struct_ops_arena_fail *skel;
+
+	skel = struct_ops_arena_fail__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_arena_fail__open_and_load"))
+		return;
+
+	struct_ops_arena_fail__destroy(skel);
+}
+
+/*
+ * Serialized because it attaches the singleton bpf_testmod_ops3, which
+ * test_struct_ops_private_stack also attaches; registering it twice fails
+ * with -EEXIST.
+ */
+void serial_test_struct_ops_arena(void)
+{
+	if (test__start_subtest("arena_arg"))
+		arena_arg();
+	if (test__start_subtest("arena_arg_fail"))
+		arena_arg_fail();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
new file mode 100644
index 000000000000..b748009f94bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	/* page 0 hosts the arena globals, page 1 is for allocations */
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+/* also associates the callback with the arena */
+u64 __arena arena_touch;
+
+SEC("struct_ops/test_arena")
+int test_arena_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[0];
+
+	arena_touch++;
+	if (!ptr)
+		return 0xbee;
+	*ptr += 1;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena = {
+	.test_arena = (void *)test_arena_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+	int ret;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	ret = bpf_testmod_ops3_call_test_arena((u64 *)val);
+	if (ret)
+		return 2;
+	if (*val != 42)
+		return 3;
+
+	/* NULL reaches the callback as NULL */
+	ret = bpf_testmod_ops3_call_test_arena(NULL);
+	if (ret != 0xbee)
+		return 4;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c
new file mode 100644
index 000000000000..4487f025018e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* No arena in the program: attaching to test_arena must be rejected. */
+SEC("struct_ops/test_arena")
+int test_arena_no_arena(unsigned long long *ctx)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_fail = {
+	.test_arena = (void *)test_arena_no_arena,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 9cc10c48a2d6..6930eb1d48dc 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -351,9 +351,15 @@ static int bpf_testmod_test_4(void)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena(u64 *ptr__arena)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
+	.test_arena = bpf_testmod_ops3__test_arena,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -372,6 +378,11 @@ __bpf_kfunc void bpf_testmod_ops3_call_test_2(void)
 	st_ops3->test_2();
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena(u64 *ptr__arena)
+{
+	return st_ops3->test_arena(ptr__arena);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -771,6 +782,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 863fd10f1619..49f9993ec331 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -106,6 +106,8 @@ struct bpf_testmod_ops2 {
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
+	/* Used to test arena pointer arguments. */
+	int (*test_arena)(u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 932acf86c73f..bc2bbe0c8168 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -115,6 +115,7 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 #endif
 
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
+int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.55.0

