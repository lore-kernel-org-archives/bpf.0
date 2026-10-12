Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A9368D4A
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812264; cv=none; b=keynNXvIaXBoSN+kBeMfdQ4t8ReYDsYuPQ2BjjRpKLLtxAyMqWh3oXir66+PaP9SrVyqONdprfTrapy8uSm6vrfwtDgffrMRCj0zg9MToR3Xk7deD4kaeZzvIM4swfVCFzIgp+4v6GOIuXfkrqM04+9jAW8z8JSZxNDL7EJnZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812264; c=relaxed/simple;
	bh=fwHs8/C6B2SZGwUySDxtxWX27XyhoLU8ENLsW7Idj5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufFnoYTyMunK31RHzQTbU4jlMBqkNTC0jSdFqo4sUlMadXpkyBV4lxeejbZG/XpEg9abR4cmzOS/EbVp+CkPRghIbEzMFhQ2AKEchIiVkn6Ba1abWdsqDyysKKGt2UbeHlKj01Uq92oRVwxbvBJkmuXX383OzNzLCPyKfVbfqwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHERC0Sa; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHERC0Sa"
Received: by mail-oo2-f9.google.com with SMTP id 46e09a7af769-821a4a69647so929654a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812261; x=1792417061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=II+ESs5thb6lefGdi5UPm2OZXn3+y6YGkDg7QAZujGs=;
        b=SHERC0SamM0eu6ZnDdlZ8+7ANW1ztHJoYMViGB0J8HWMCMXjJeLJmb+P8Pd8uYiN2Y
         PlB/baVa8TaqJ7d6U6qUQSLoAXHoA7qZ4KedZ0XYcyz/nQu5JNCVwQWKe2kfUm5usqNo
         eAwaHanvBBPn5IBB36ogETpX6cnxTrUg7jO4GbRj+ZiK+DD2u151xPX+PKxg1j+pOIrh
         AHfLRYWcLdzYDtW9PSb1MJFgeUgs5JEL/Pt0U1QH55RVsheJBIqReBjSjEQdO4fttoCw
         cDaEgUSH0daiwujFsZwyGsdyE6qvtp7Sdk3OhHf7MUW2BYzYZlv1vlAP3GNsKhaLRRsi
         SwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812261; x=1792417061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=II+ESs5thb6lefGdi5UPm2OZXn3+y6YGkDg7QAZujGs=;
        b=uVV9JLXMXMRRJHmB4DZaMV9eJ5vmVFvSSq+8fPSpBxZYuh9/nxeScqdxJ6vNZ6VETv
         KcA12orDjqCZpH5G42bFLtaAu7FtB3PqAMMbGaqMyRHCFzgEhYKC4GugcGSbZMamIWCe
         ndYdpI08/DP+EH3ggyziyk0yxJ2NrHgRz7/jHjUUS/AyIlM6yEOeEqno+TlP0rmgWn92
         rpM2P3e27BOhNEmgLS11YkZ2duom4E76eUgiDoCIg47h/QsSH7uXwHEDQUvfIanWc4ES
         afJJEOaua2EGC3esll4NgYHoE7gOJVHnznB0xK0Ljpmi70suPn6v8xZgSeO3KRIdZmPH
         6aPw==
X-Gm-Message-State: AFq9FYL/aL6j+//Rr6U/f2q2KHvAC6rA9t6yX8ggYJVEJ0dqFyJd/nfN
	QwWT0rqCBKlU6WelLEynfW58aFkfDbuMWMIie0Gza93i3KgtlXXPIM53eV0/8RNcQS0=
X-Gm-Gg: AYBFou3O9YMIPlI0W2mGkMmUyekWDsHTxFR8zSKZ5yzWP08m3TLd7o+HVY/hongY5wA
	25QbrCZi8sw3kECZK/Nh2W2xszLg6pDkEI5NhruimzvcqrOu8EyO80e/gzp4Ul6EmpXA0UGBfma
	gvS9mayDTTh0Caokl7+Xno+QKkHcOh1AtyqzdqDvHMn8JIc+IOEpDEOWuVUcSVwsUYC65PoYBdX
	qCNlOYuPzQ+IUJx8qOUC6LuN4q4/bYIuf7h8kDyrUz6IeBG25oOufVwcS00GXfASkQ6egPaI7ac
	czAJ9hejQJjGNf/I+O/pKsb20D+h1k0OWWrk2iA1qCRj21rSBVPjpV1FSoouowXqTFiDQMMcIRF
	Dt9mpjKLPItSiiUL9zOFFGKj2xWwR8q0mVI4qlg69CrwM2ZRCAT7rrbtKI62dd+ysNHYwK9MbNl
	xgML9R21WuCgfn3WrZ4R+DpF5J6CuB8rs3jZ+VGInylMubfPYMGnX06cUrRXIj8h1UDmooT3dZA
	2iUUoyk7430mrquJNKHACPMwGtxH5lTCb4+AAB87SuMw5XuVZUBii8TpUjrPEP797RBA3n/TXou
	b9BNDQ==
X-Received: by 2002:a05:6830:63cc:b0:80c:d34f:5f61 with SMTP id 46e09a7af769-83097c6961fmr8294709a34.26.1791812261563;
        Mon, 12 Oct 2026 06:37:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8367ada5b6fsm3322568a34.21.2026.10.12.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/10] selftests/bpf: Test arena binding by libbpf
Date: Mon, 12 Oct 2026 15:37:04 +0200
Message-ID: <20261012133711.4030594-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9159; h=from:subject; bh=fwHs8/C6B2SZGwUySDxtxWX27XyhoLU8ENLsW7Idj5k=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7Xt0lPrPS7p1TrvObxH96/r+a8JLt96XuVlmL5MNvL5 UWHUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInMFWBkeFDLtHFhZsOcRqOyKW2HX2 hezaio+7FowTfutJZdS6rDahn+B03c9tRuycePG3d8178ofmZ957uXB1iEyuJc3djUTzPy8wAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Attach a struct_ops callback with an __arena argument from an object
whose programs never refer to the arena and drive it through the kernel,
and check that an unrelated program of the object got the arena among
its maps as well.

Two existing programs expected to fail for want of an arena while living
next to an arena map, the kfunc argument case in arena_kfunc.c and the
scalar access case in verifier_arena_scalar.c. They load now, so move
them to an object without an arena map, where the kernel checks still
apply.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 47 ++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 10 ---
 .../selftests/bpf/progs/arena_noarena.c       | 39 +++++++++++
 .../bpf/progs/struct_ops_arena_autobind.c     | 64 +++++++++++++++++++
 .../bpf/progs/verifier_arena_scalar.c         | 13 ----
 6 files changed, 152 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 1a7fe0d6c5a4..a45b360b4c65 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -12,6 +12,7 @@
 #include "struct_ops_arena_member_fail__mismatch.skel.h"
 #include "struct_ops_arena_member_fail__write.skel.h"
 #include "struct_ops_arena_member_fail__no_arena.skel.h"
+#include "struct_ops_arena_autobind.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -144,6 +145,50 @@ static void arena_member(void)
 	struct_ops_arena_member__destroy(skel);
 }
 
+/* @prog_fd lists exactly one map, the one with @map_id. */
+static void assert_prog_map(int prog_fd, __u32 map_id, const char *name)
+{
+	__u32 map_ids[2], len = sizeof(struct bpf_prog_info);
+	struct bpf_prog_info info = {
+		.nr_map_ids = ARRAY_SIZE(map_ids),
+		.map_ids = ptr_to_u64(map_ids),
+	};
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
+	if (!ASSERT_OK(err, name))
+		return;
+	ASSERT_EQ(info.nr_map_ids, 1, name);
+	ASSERT_EQ(map_ids[0], map_id, name);
+}
+
+/*
+ * libbpf binds the arena of an object to every program in it: a callback
+ * with an __arena argument loads without referring to the arena, and an
+ * unrelated program gets the arena as well.
+ */
+static void arena_autobind(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int err;
+
+	skel = struct_ops_arena_autobind__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open_and_load"))
+		return;
+
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	assert_prog_map(bpf_program__fd(skel->progs.test_arena_cb), info.id, "test_arena_cb");
+	assert_prog_map(bpf_program__fd(skel->progs.unrelated), info.id, "unrelated");
+
+	attach_and_trigger(skel->maps.testmod_arena_autobind, skel->progs.trigger);
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
 /* The same through the vmlinux.h rendering of the members, which takes casts. */
 static void arena_member_render(void)
 {
@@ -186,6 +231,8 @@ void serial_test_struct_ops_arena(void)
 	RUN_TESTS(struct_ops_arena_member_fail__mismatch);
 	RUN_TESTS(struct_ops_arena_member_fail__write);
 	RUN_TESTS(struct_ops_arena_member_fail__no_arena);
+	if (test__start_subtest("arena_autobind"))
+		arena_autobind();
 #else
 	test__skip();
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..6df440d82675 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "arena_kfunc.skel.h"
+#include "arena_noarena.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
 #include "cb_refs.skel.h"
@@ -193,6 +194,7 @@ static void run_tests_aux(const char *skel_name,
 } while (0)
 
 void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
+void test_arena_noarena(void)                 { RUN_TESTS(arena_noarena); }
 
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 96f7aacf4d9f..a049d6371d09 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -192,16 +192,6 @@ int arena_arg_unpopulated(void *ctx)
 	return 0;
 }
 
-SEC("syscall")
-__arch_x86_64
-__arch_arm64
-__failure __msg("arena pointer requires a program with an associated arena")
-int arena_arg_no_arena(void *ctx)
-{
-	bpf_kfunc_arena_arg_test((u64 *)1);
-	return 0;
-}
-
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
diff --git a/tools/testing/selftests/bpf/progs/arena_noarena.c b/tools/testing/selftests/bpf/progs/arena_noarena.c
new file mode 100644
index 000000000000..edbd40cd5be8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_noarena.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/*
+ * Programs without an arena. They cannot share an object with an arena map,
+ * libbpf binds the arena of an object to every program in it.
+ */
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__failure __msg("arena pointer requires a program with an associated arena")
+int arena_arg_no_arena(void *ctx)
+{
+	bpf_kfunc_arena_arg_test((u64 *)1);
+	return 0;
+}
+
+SEC("syscall")
+__flag(BPF_F_ARENA_SCALAR)
+__arch_x86_64
+__arch_arm64
+__description("arena_scalar: no arena, no access through a number")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void no_arena(void)
+{
+	asm volatile ("					\
+	r6 = 0x100000000000 ll;				\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
new file mode 100644
index 000000000000..495faa0f4a8b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
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
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/*
+ * Neither the callback nor the unrelated program refers to the arena. libbpf
+ * binds it to them all the same, so the callback can use the __arena argument
+ * the kernel hands it.
+ */
+SEC("struct_ops/test_arena")
+int test_arena_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[0];
+
+	*ptr += 1;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_autobind = {
+	.test_arena = (void *)test_arena_cb,
+};
+
+SEC("syscall")
+int unrelated(void *ctx)
+{
+	return 0;
+}
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	if (bpf_testmod_ops3_call_test_arena((u64 *)val))
+		return 2;
+	if (*val != 42)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
index bebc37f501b7..a4f15eb21809 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
@@ -735,19 +735,6 @@ __naked void no_flag(void)
 	: __clobber_all);
 }
 
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: no arena, no access through a number")
-__failure __msg("R6 invalid mem access 'scalar'")
-__naked void no_arena(void)
-{
-	asm volatile ("					\
-	r6 = 0x100000000000 ll;				\
-	r0 = *(u64 *)(r6 + 0);				\
-	exit;						\
-"	::: __clobber_all);
-}
-
 SEC("syscall")
 __arena_scalar
 __description("arena_scalar: pointer that is NULL is an address in arena")
-- 
2.53.0-Meta

