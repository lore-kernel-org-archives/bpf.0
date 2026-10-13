Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513E379EE7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879652; cv=none; b=PTfDcVTS67VF5pLTy4e+TXDc77S6jlNTxaV5Jkh2slST/Wwb13N6H+hGdNVPxa0Eefkm52C2FQD2R/OOb3OC3Y8IV1BFivvxxn4weeqUabnJXczVGvvGKVRIFDHzcfPvzQ1sl0wDvhOjfZjvxFiab+Aj0N2Kj8z3pbuDpqc3puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879652; c=relaxed/simple;
	bh=Ci+ER653FEUhmm/J+Vyl8IIiS+ifMeur7VwPGMVKR40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVpcqVtVLRIaAp+YBRM4qTmUFaAVWnrtr0A2kvsY0K5Q3p5u1DcSFFzsphG0zYXgZ8tm0tAEytkXaD5ggrH+EyB7rfF428l1/Ius+DNbyHa2gkc0KypfDbgRIVqpI5pSxNblWSOXRXen2x6ZD0OsBG4cGiJD0cOPQwHW4m06YAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZifS/kD; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZifS/kD"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-4f6dcc0e8ccso2615919b6e.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879649; x=1792484449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQY9HB5KMJHXKrhMall/o4G9gZbpg8sp/WbBpaW702c=;
        b=bZifS/kDyFdBQCdByXC5si+isdtkh5VZaXl2JivUo3wjoIDvh73qbSlqn1H3Ia4e2D
         PIWTMsuTGOa0FVR3byVjUeaq6MwLl+Pv4eH8fD1i6pG1E5Z2mGnqEtL/zxRtePHH5pCc
         XP7dMy//92xwVTu8QSKecSUDsJyR0VfMafzKUYywy9/olM6RrYwsFIgHw6NRivJIWKrM
         T0nQfi5VidRXz4O6Rnd82ZRrr9kwXeC8XZGOsigWpHy04GugrZJ5A1A8EI6t/n+kjfwd
         tgfBwvL3ZijRtqbPFuaIAddyYI0JPEXdQ7kvrZU0M6b7EOxEA0mlkZRNC6L120tr0QeH
         0msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879649; x=1792484449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQY9HB5KMJHXKrhMall/o4G9gZbpg8sp/WbBpaW702c=;
        b=XKbbWZ/gag6sWxUgv0lyxY7UsolIQ6qgCyvPu9m7JWqY5VvUYXsVI99BFfGAQDZnTm
         ns6t8UbkbgBxcR0+qJRFUoXdMYDgpY0k42JG/BZMmDth2Ec/hFsB/pQ9nUX+T32cIPRn
         DILOQJwNOt4ILsXgiwIoM7xmWim5p3idjzemPe4CAqvGelvG1P0CLQThG1o7k27tZ8qo
         Y1voVJWEHHnNQG8KhMtRva5YoBh1bwzsQmegU+W/W+lmQ7O649vcjtuqjQmOw6RORTiH
         siyDFznwPMvq3UwjyJxnSs+4sqY5D1pypv2czJ2BCe/GSZd61ghLQGhSpPzaZLIiRQbm
         NG3Q==
X-Gm-Message-State: AFq9FYIxF+fsnMZuDGDu59+jcdl5i+bzUmGpjNH3IIzYm8AqBupKEnIA
	WRorXRaemsr+SQVut3gjUYS56LBJxLphNrFsfG44Yv2DRdPHFr7CRbdVYuMWmhWgYUM=
X-Gm-Gg: AYBFou09AJ5J9Z8DXWl6vmdIKkLPUHr7ZSs3ZuxgM1xddKUzQyUXalg62gvtQXIyAF6
	tSYMra4qi7DtVB2/5RyTwltP3ZwCYBP1UVws3vsKpg30Ub8TOZXOQ69m3Lgq558LyM+YS3gSzmg
	OEHB72OgGUIrKdEgEzrUGi+Ld952QEtO4Rg4U8Gh7kbNv2Q65yP9EfS6cMs1IP06k1owHX9aHog
	8b3VHbInMxgCETbE4g4ueYfjfKzyMhPJdoQ+zxU7LXP8VndGoMlWCDwpx8bFyt22BkxxO/Jx7Uu
	mHGZMhjZxQNNz2TM0SkvRvVf+9INgVNioFGpjlpWUXVXZv8uvoqJG03JomiaIBDL6aAFE279aac
	AY9f2ftBGdrfgaQ73yLe8S5SK90En9+gpDQZ1kIlDf2npkQ1pHv2IqiZAt9nwN0pf+h7ZXyplF8
	Waoukgtz1VQ7nHBYWA99AmgbuT9kBQMqrn7a2sCzIpvskZqrsCtNkBb4nwTeEqgat1jMW2FJAds
	HAN53Var0rakxMi0ca+jQx4qfgR9C44wWtOSBnidvWlcx0fIBqWnpmJehgDqlj+5xbIqFktlTXH
	5Bnw7Q==
X-Received: by 2002:a05:6808:130a:b0:4f5:dc0d:e013 with SMTP id 5614622812f47-50b518dd554mr7822551b6e.4.1791879649309;
        Tue, 13 Oct 2026 01:20:49 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1a325a38sm14182236b6e.12.2026.10.13.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 09/13] selftests/bpf: Test arena binding by libbpf
Date: Tue, 13 Oct 2026 10:20:04 +0200
Message-ID: <20261013082012.1107446-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9138; h=from:subject; bh=Ci+ER653FEUhmm/J+Vyl8IIiS+ifMeur7VwPGMVKR40=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy/kCrD8WejDf0VA+c0jkD5+l0uqIsM+Xtu2U9Oq98EVd 4LNYRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbC94GRoUktX7It91G1akPdrBPbW/ 7NvfvyQqLaYUYVZUWTqU5KBowM3S3+ecvzst/pvV2v//SgrsTZU0VxVxaEubec+m26O+4zDwA=
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
 .../bpf/prog_tests/test_struct_ops_arena.c    | 48 ++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 10 ---
 .../selftests/bpf/progs/arena_noarena.c       | 39 +++++++++++
 .../bpf/progs/struct_ops_arena_autobind.c     | 64 +++++++++++++++++++
 .../bpf/progs/verifier_arena_scalar.c         | 13 ----
 6 files changed, 153 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 1cc1b3df13bc..149b130f8cdb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -14,6 +14,7 @@
 #include "struct_ops_arena_member_fail__mismatch_mem.skel.h"
 #include "struct_ops_arena_member_fail__write.skel.h"
 #include "struct_ops_arena_member_fail__no_arena.skel.h"
+#include "struct_ops_arena_autobind.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -168,6 +169,51 @@ static void arena_member(void)
 	struct_ops_arena_member__destroy(skel);
 }
 
+/* @prog_fd lists exactly one map, the one with @map_id. */
+static void assert_prog_map(int prog_fd, __u32 map_id, const char *name)
+{
+	__u32 map_ids[2] = {}, len = sizeof(struct bpf_prog_info);
+	struct bpf_prog_info info = {
+		.nr_map_ids = ARRAY_SIZE(map_ids),
+		.map_ids = ptr_to_u64(map_ids),
+	};
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
+	if (!ASSERT_OK(err, name))
+		return;
+	if (!ASSERT_EQ(info.nr_map_ids, 1, name))
+		return;
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
@@ -213,6 +259,8 @@ void serial_test_struct_ops_arena(void)
 		RUN_TESTS(struct_ops_arena_member_fail__write);
 		RUN_TESTS(struct_ops_arena_member_fail__no_arena);
 	}
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

