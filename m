Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D7353A9B
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984183; cv=none; b=phLgnNoHGM57L44kNyIs1tAjdwgUhQ/ganoucfCfp/Ud1uKFXkRmwq5ATYhjqSx3C7pePzxYnix2YzfZ5hJRyOY0mURisa93beqSwdqxgiagdIGAlpxO+BWlnZYi1woViS5SWlIa8XRS7LDgYaZ029WVgpWkpGIwXTpkRkHksKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984183; c=relaxed/simple;
	bh=10FKfpoauqN2rzMI7nIsLZiiK8/XZx470upWtTyShFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/MIHmScDuavyhqiPvs9eiYjVzk2NmbEQ5s2h67b+c8P9ZPj85NZN1SIKJoxRtMvAy8GYSbS40E10etxEuy4qfwA35zShiEZuxlhxqTFGkoi9WTdp+1Cw4HnPClPfYQ8CUdUeEelRX7S9TqcuDUbYv5qXjdI1D0pV4iAov5rVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8D8D2273BA36D6; Fri, 28 Aug 2026 23:16:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 11/12] selftests/bpf: Test kfuncs returning arena pointers by value
Date: Fri, 28 Aug 2026 23:16:10 -0700
Message-ID: <20260829061610.1699950-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the by-value struct returns a kfunc may now make: two arena
pointers filling R0:R2, and an arena pointer beside a scalar. Two further
cases drop the tag from one member of a struct and one arm of a union,
and stay rejected naming that member, so what decides is the tag rather
than the member being a pointer. The existing cases for a struct and a
nested struct carrying a plain pointer stay rejected as well.

These cases call the kfuncs from C, so the compiler lowers the by-value
return itself, and a struct or union only lands in R0:R2 with the LLVM 23
BPF ABI. An older clang, and gcc, return it through a hidden pointer in
R1 instead, which shifts the arguments along and fails verification. The
file is therefore guarded on LLVM 23, falling back to a dummy test.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  42 ++++++
 .../bpf/progs/aggregate_ret_kfunc_arena.c     | 121 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  32 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  30 +++++
 4 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_arena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index e0b94ed10f94..07d9d6e1d6b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -1,11 +1,53 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "aggregate_ret_func.skel.h"
 #include "aggregate_ret_kfunc.skel.h"
+#include "aggregate_ret_kfunc_arena.skel.h"
+
+static bool testmod_has_arena_tagged_member(void)
+{
+	struct btf *vmlinux_btf, *module_btf =3D NULL;
+	const struct btf_type *t;
+	bool tagged =3D false;
+	__s32 id;
+
+	vmlinux_btf =3D btf__load_vmlinux_btf();
+	if (!vmlinux_btf)
+		return false;
+
+	module_btf =3D btf__load_module_btf("bpf_testmod", vmlinux_btf);
+	if (!module_btf)
+		goto out;
+
+	/* prog_test_ret_arena::a is 'void __arena_tag *': PTR -> TYPE_TAG -> v=
oid */
+	id =3D btf__find_by_name_kind(module_btf, "prog_test_ret_arena", BTF_KI=
ND_STRUCT);
+	if (id <=3D 0)
+		goto out;
+
+	t =3D btf__type_by_id(module_btf, btf_members(btf__type_by_id(module_bt=
f, id))[0].type);
+	if (!t || !btf_is_ptr(t))
+		goto out;
+
+	t =3D btf__type_by_id(module_btf, t->type);
+	tagged =3D t && btf_is_type_tag(t) &&
+		 !strcmp(btf__name_by_offset(module_btf, t->name_off), "arena");
+
+out:
+	btf__free(module_btf);
+	btf__free(vmlinux_btf);
+
+	return tagged;
+}
=20
 void test_aggregate_ret(void)
 {
 	RUN_TESTS(aggregate_ret_func);
 	RUN_TESTS(aggregate_ret_kfunc);
+
+	if (testmod_has_arena_tagged_member())
+		RUN_TESTS(aggregate_ret_kfunc_arena);
+	else
+		test__skip();
 }
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.=
c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
new file mode 100644
index 000000000000..a0f263694a63
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf_arena_common.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2);
+} arena SEC(".maps");
+
+SEC("syscall")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_arena(void *ctx)
+{
+	u32 volatile __arena *page =3D bpf_arena_alloc_pages(&arena, NULL, 1, N=
UMA_NO_NODE, 0);
+	u32 volatile __arena *a, *b;
+	struct prog_test_ret_arena r;
+
+	if (!page)
+		return 1;
+
+	/* Both halves come back in R0:R2, pointing at page and page + 4. */
+	r =3D bpf_kfunc_call_test_ret_arena((u64)page);
+	if (!r.a || !r.b)
+		return 2;
+
+	a =3D (u32 __arena *)r.a;
+	b =3D (u32 __arena *)r.b;
+	*a =3D 1;
+	*b =3D 2;
+	if (*a !=3D 1)
+		return 3;
+	if (*b !=3D 2)
+		return 4;
+
+	page[0] =3D 7;
+	if (*a !=3D 7)
+		return 5;
+	page[1] =3D 9;
+	if (*b !=3D 9)
+		return 6;
+
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_arena_mixed(void *ctx)
+{
+	u32 __arena *page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NO=
DE, 0);
+	struct prog_test_ret_arena_mixed r;
+	u32 volatile __arena *p;
+
+	if (!page)
+		return 1;
+
+	/* An arena pointer in R0 beside a scalar in R2. */
+	r =3D bpf_kfunc_call_test_ret_arena_mixed((u64)page);
+	if (!r.p)
+		return 2;
+	if (r.tag !=3D 0xbeef)
+		return 3;
+
+	p =3D (u32 __arena *)r.p;
+	*p =3D 3;
+	if (*p !=3D 3)
+		return 4;
+
+	return 0;
+}
+
+SEC("syscall")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'b' has type PTR")
+int aggregate_ret_kfunc_arena_untagged_fail(void *ctx)
+{
+	struct prog_test_ret_arena_untagged r;
+
+	r =3D bpf_kfunc_call_test_ret_arena_untagged(0);
+
+	return r.a =3D=3D r.b;
+}
+
+SEC("syscall")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'b' has type PTR")
+int aggregate_ret_kfunc_arena_union_fail(void *ctx)
+{
+	union prog_test_ret_arena_union r;
+
+	r =3D bpf_kfunc_call_test_ret_arena_union(0);
+
+	return r.a =3D=3D r.b;
+}
+
+#else
+
+SEC("socket")
+__description("aggregate_ret_kfunc_arena: needs LLVM 23, dummy test")
+__skip("needs LLVM 23")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index dff1ad6f491f..2380b6cbdead 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -981,6 +981,34 @@ __bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_=
test_ret_ptr(u64 tag)
 	return r;
 }
=20
+__bpf_kfunc struct prog_test_ret_arena bpf_kfunc_call_test_ret_arena(u64=
 addr)
+{
+	struct prog_test_ret_arena r =3D { .a =3D (void *)addr, .b =3D (void *)=
(addr + 4) };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_arena_mixed bpf_kfunc_call_test_ret_are=
na_mixed(u64 addr)
+{
+	struct prog_test_ret_arena_mixed r =3D { .p =3D (void *)addr, .tag =3D =
0xbeef };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_arena_untagged bpf_kfunc_call_test_ret_=
arena_untagged(u64 addr)
+{
+	struct prog_test_ret_arena_untagged r =3D { .a =3D (void *)addr, .b =3D=
 NULL };
+
+	return r;
+}
+
+__bpf_kfunc union prog_test_ret_arena_union bpf_kfunc_call_test_ret_aren=
a_union(u64 addr)
+{
+	union prog_test_ret_arena_union r =3D { .a =3D (void *)addr };
+
+	return r;
+}
+
 __bpf_kfunc struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(u=
64 tag)
 {
 	struct prog_test_ret_nested r =3D { .in =3D { .p =3D NULL }, .tag =3D t=
ag };
@@ -1574,6 +1602,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_fastcall, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena_mixed)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena_untagged)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arena_union)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_nested)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr_arr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr_struct)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 9202c31ba6c9..b213ef14848b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -26,6 +26,12 @@ struct prog_test_ref_kfunc {
 };
 #endif
=20
+#if __has_attribute(btf_type_tag)
+#define __arena_tag __attribute__((btf_type_tag("arena")))
+#else
+#define __arena_tag
+#endif
+
 struct bpf_iter_testmod_seq;
=20
 struct prog_test_pass1 {
@@ -70,6 +76,26 @@ struct prog_test_ret_ptr {	/* 16 bytes: contains a poi=
nter */
 	__u64 tag;
 };
=20
+struct prog_test_ret_arena {	/* 16 bytes: two arena pointers */
+	void __arena_tag *a;
+	void __arena_tag *b;
+};
+
+struct prog_test_ret_arena_mixed {	/* 16 bytes: an arena pointer and a s=
calar */
+	void __arena_tag *p;
+	__u64 tag;
+};
+
+struct prog_test_ret_arena_untagged {	/* 16 bytes: 'b' lacks the arena t=
ag */
+	void __arena_tag *a;
+	void *b;
+};
+
+union prog_test_ret_arena_union {	/* 8 bytes: 'b' lacks the arena tag */
+	void __arena_tag *a;
+	void *b;
+};
+
 struct prog_test_ret_nested {	/* 16 bytes: the pointer hides one level d=
own */
 	struct {
 		void *p;
@@ -200,6 +226,10 @@ struct prog_test_ret_nested bpf_kfunc_call_test_ret_=
nested(__u64 tag) __ksym;
 struct prog_test_ret_ptr_arr bpf_kfunc_call_test_ret_ptr_arr(void) __ksy=
m;
 struct prog_test_ret_arr_struct bpf_kfunc_call_test_ret_arr_struct(void)=
 __ksym;
 struct prog_test_ret_arr2d bpf_kfunc_call_test_ret_arr2d(void) __ksym;
+struct prog_test_ret_arena bpf_kfunc_call_test_ret_arena(__u64 addr) __k=
sym;
+struct prog_test_ret_arena_mixed bpf_kfunc_call_test_ret_arena_mixed(__u=
64 addr) __ksym;
+struct prog_test_ret_arena_untagged bpf_kfunc_call_test_ret_arena_untagg=
ed(__u64 addr) __ksym;
+union prog_test_ret_arena_union bpf_kfunc_call_test_ret_arena_union(__u6=
4 addr) __ksym;
 struct prog_test_ret_deep bpf_kfunc_call_test_ret_deep(__u64 v) __ksym;
 struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
--=20
2.53.0-Meta

