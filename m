Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C724FC8E9
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107727; cv=none; b=nKcVEhwderBPZc1ARSh/F0PMp2mgW49Wrl9bxioEBpLegU9fotTk4Wp21TZEOUm6/pxzQU9Ppl1RPADnNQfFAbHJbOkAtZ+NoWZ0R87SWe95aC20CQ5YidnTfKkWmbKSwIZQkG7HXgFHq0ejqiYCU+HNbanePHerf3EKaXaY7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107727; c=relaxed/simple;
	bh=n+MLqjRiYWH/xEoDTZIFRu6ZeXvxfba7jYrgzrfQh3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jix5bzxfHYAd3Xnlprv9vSG8PPn/CuQ197bkZonEJdzLq6AItVuf9PumUJQpWY5YmNeyiuET6ylUbC7vELiJDUv67z8E/ExUCl0S8MlD51m7VNR8WDeaCWXvunEKk78AElyBag9VFtkMaif6oI2/rAqduYrsyGAwwGPNOTFVI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4wZKqD3; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4wZKqD3"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-824040a3379so1684906a34.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107724; x=1792712524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9eYDk3VrqIOowUUitSbG5/mvDEVOa/c7nHWPug5G5I=;
        b=I4wZKqD3NHH3WMLFW+oyqJ3xTUk9WvT5I3n+JHGwvsnhSDBkoxh13/yUD+89uIHAf6
         t70MmRxL5H1SIlHkMdbccEKvyrV7gArJf0FMWwzAwjfM3WIjV3Ack/Rw7+1qjPHQtydm
         GL6f2Xz/TLtw4PisX8P/J35/IYnljgCWeo2LdWCKdEo0efY9gRJ3a1wanu3tu9Z9rhCM
         DkEskklXfhCSAWh/CDVZM+E2Pci2NBgHHqBCKMt0qMh6/wK0EVWX4Di7SHGxJ/YTXq48
         itX+Q9XeetrUiMRmY6mOWVgwTiIDmmLnlOgB8OL0pRw6ZeEGwBeYb2V82e03wESvywNU
         5Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107724; x=1792712524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9eYDk3VrqIOowUUitSbG5/mvDEVOa/c7nHWPug5G5I=;
        b=ubYYtQfZhfiDy6RUlrHXVoZK1V0xx9ODRfupab/1DMC9Tf+I7JkUw9cZ63ZK5dNSo+
         KSclfbodOrow//5J570IMLjFNbSU/sw7JaKRIK/R37K+HGiqMLar7LebRywqk+uHELKl
         wPgzrvpIqYW76w5HQgc/oIawl+EU0PrGUq1BOoYtQ8OHxwSspjMbPDTej2neNLuxVjqE
         VAFoxzRPg/189CROjO6Mx7XkSX56MJeyaU/qEhahzWCxLgzSIBoo7A2P+AUj8rE2OO0W
         M8a/6DBl+swcKGe2foFsZyghO3q3ljICo36qatggURUWEWgwhsGUgTcoJDVSF3RHYZi/
         enqQ==
X-Gm-Message-State: AFq9FYLc7yj5tU6mAot/Dwlmkf16xbHSwzwAeFeiCM81Z97LfxVg826R
	aZnrKxMxBR8HeWRqPUfR2IV3FtANKr/vlG7heW/Z7MOpoOH7/GZlTsSA7gfzFh1ve1A=
X-Gm-Gg: AYBFou3dZhziJt0Lf4XHpG5Fxb+hPon5yDOSbSypZ6dMWXTriYZzJBJ+aXZuuE/lJdC
	rutrKcxVOBdmWMtubLI2V4b9WLsYNCZei30j6hm3g+CQKMMi+acJRoR+A3y/qYWbuzkbIfMIx8h
	QcL7xwBDUtxmRzhYjPRG8hEMAa9A2BaHv9Q6+eQ8eLSaoD20YMMixYq4K4o0nxN3nDNOfDAmUl6
	ENRaSKQvZ7+QQYOUOLyJDwvtwu6O3VG7rOvcSiDqWQaVRwq/GzgatCWee9BrJU0ZjILiTEwHqfA
	OgTRvfzWUcFA/3XLIdcXgm3qP53GmuWeBS5hSXyZY7zFATWSZ7ROOt8S9xKb37tIkrYl+TKBxJD
	35vd7kJZoSnMJAYTiAsjRbFOi73wBdx4WECjVdgKdMwh2YOWHoctNO0QNG/sPMAJLnSnnHduAbe
	5qQwt8nhJqlzWlAFGOaB0Y9Iijbx4a5xzk4fwxywaln6j3CaDU1UMdDsHsvlV+0cj6wB4FR83D2
	6jpg7KWQxOm6Fp5jJXuy/7FJmvywkV0MvEzgd5Uefzg856P++qxKXUBeC0rp9W223VmDrzMAgxq
	i7np
X-Received: by 2002:a05:6808:199b:b0:4b9:a88b:888b with SMTP id 5614622812f47-50c532f3672mr25197183b6e.33.1792107724461;
        Thu, 15 Oct 2026 16:42:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388288ad5bsm287151b6e.2.2026.10.15.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 11/15] selftests/bpf: Test arena binding by libbpf
Date: Fri, 16 Oct 2026 01:41:17 +0200
Message-ID: <20261015234125.3152346-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10117; h=from:subject; bh=n+MLqjRiYWH/xEoDTZIFRu6ZeXvxfba7jYrgzrfQh3E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Os9O8RLLgRwJUeKZK2Kdt5x+hfPuor8N/mtJanf3S/F Old0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCI5Fxn+2TKqFIn9sEib2DGBoTRA/m 7An8bfZ1YuiLeTqH74kSmVj+G/g+kun3kHHivs2/xOa3JzCOOMJ9GrjAqVdhivv6q6cmM4LwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Attach a struct_ops callback with an __arena argument from an object
whose programs never refer to the arena and drive it through the kernel,
and check that an unrelated program of the object got the arena among
its maps as well. Load the same object through bpf_object__prepare()
and bpf_program__clone() too, the way veristat loads programs.

Two existing programs expected to fail for want of an arena while living
next to an arena map, the kfunc argument case in arena_kfunc.c and the
scalar access case in verifier_arena_scalar.c. They load now, so move
them to an object without an arena map, where the kernel checks still
apply.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 77 +++++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 10 ---
 .../selftests/bpf/progs/arena_noarena.c       | 39 ++++++++++
 .../bpf/progs/struct_ops_arena_autobind.c     | 64 +++++++++++++++
 .../bpf/progs/verifier_arena_scalar.c         | 13 ----
 6 files changed, 182 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index e828ab9124c0..e5f42b88ec95 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -13,6 +13,7 @@
 #include "struct_ops_arena_member_fail__mismatch_mem.skel.h"
 #include "struct_ops_arena_member_fail__write.skel.h"
 #include "struct_ops_arena_member_fail__no_arena.skel.h"
+#include "struct_ops_arena_autobind.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -145,6 +146,78 @@ static void arena_member(void)
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
+/*
+ * The same binding through bpf_object__prepare() and bpf_program__clone(), the
+ * way veristat loads a program: the arena takes slot 0 of a continuous
+ * fd_array, next to the module BTF of the kfunc the trigger calls.
+ */
+static void arena_autobind_clone(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_program *prog;
+	int err, fd;
+
+	skel = struct_ops_arena_autobind__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "prepare"))
+		goto out;
+	bpf_object__for_each_program(prog, skel->obj) {
+		fd = bpf_program__clone(prog, NULL);
+		if (ASSERT_GE(fd, 0, bpf_program__name(prog)))
+			close(fd);
+	}
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
 /* The same through the vmlinux.h rendering of the members, which takes casts. */
 static void arena_member_render(void)
 {
@@ -197,6 +270,10 @@ void serial_test_struct_ops_arena(void)
 		/* so that the missing member tests show up as skipped */
 		test__skip();
 	}
+	if (test__start_subtest("arena_autobind"))
+		arena_autobind();
+	if (test__start_subtest("arena_autobind_clone"))
+		arena_autobind_clone();
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

