Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC883AFCE3
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541447; cv=none; b=q03/24y9GMDhjN8Oad2sNXWp6tEUGzHNuhfrCBBy3COIVVN/n4xDutqLnjbGSifnOxixM9FdLCltLwsHjq616qV7ee5WFYOLfFhLzDGBixnb5OxNe+igKr8f7dcAEodc1ww6EeEQ9vUL6lXefJbw70twz0s0pWg6L+rGWQz+dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541447; c=relaxed/simple;
	bh=xh98FGcKccH7TqzrAFbAa2esqDLEtm712CRrqpNkDpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOW/5GQrctoYvpJjnj0MNnh/bzN/vg0KehgbJnYdCTj5k6OlU8V+Q895Ta24pbtE3iI27tWYCWDRk9DvgEY3FIE+7DbLIGtJDzXDPdmUonqVENLrZRo9x1IEfVNfemlpYoceXFyWKaZkl3fnCW0BlKy9ywS4OefVSfwSV0dMfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D87AE1D0B6F972; Wed,  8 Jul 2026 13:10:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 09/12] selftests/bpf: Add C tests for 16-byte returns in R0:R2
Date: Wed,  8 Jul 2026 13:10:25 -0700
Message-ID: <20260708201025.2160583-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add selftests that exercise a 16-byte return value passed in the R0:R2
register pair, expressed in C so they rely on the compiler lowering the
register-pair return. Tests include an __int128 return (from a subprogram
and a kfunc), a 16-byte struct return (from static and global subprograms
and a kfunc) and a 16-byte union return.

The R0:R2 return convention is only emitted by LLVM 23 and newer, so the
programs are gated on __clang_major__ >=3D 23; with an older compiler the=
y
return a sentinel and the "int128_c", "struct_c", "global_struct_c",
"kfunc_struct_c" and "union_c" subtests are skipped.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 96 ++++++++++++++++++
 .../bpf/progs/aggregate_ret_int128_c.c        | 48 +++++++++
 .../bpf/progs/aggregate_ret_struct_c.c        | 98 +++++++++++++++++++
 .../bpf/progs/aggregate_ret_union_c.c         | 51 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 14 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 11 +++
 6 files changed, 318 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_ret.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_int12=
8_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_struc=
t_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_union=
_c.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
new file mode 100644
index 000000000000..d4ecc19684ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "aggregate_ret_int128_c.skel.h"
+#include "aggregate_ret_struct_c.skel.h"
+#include "aggregate_ret_union_c.skel.h"
+
+/*
+ * Run one program and check its result. The program returns 0 on succes=
s, or
+ * 1..4 identifying which half of which aggregate (R0:R2) return value c=
ame back
+ * wrong. A return of -1 means the program was built with an LLVM that l=
acks
+ * R0:R2 16-byte return support, in which case the subtest is skipped.
+ */
+static void run_prog(struct bpf_program *prog, bool may_skip)
+{
+	char buf[64] =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D buf,
+		.data_size_in =3D sizeof(buf),
+		.repeat =3D 1,
+	);
+	int err;
+
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+
+	if (may_skip && (int)topts.retval =3D=3D -1) {
+		test__skip();
+		return;
+	}
+
+	ASSERT_EQ(topts.retval, 0, "aggregate_ret_result");
+}
+
+void test_aggregate_ret(void)
+{
+	struct aggregate_ret_struct_c *skel_struct_c;
+	struct aggregate_ret_union_c *skel_union_c;
+	struct aggregate_ret_int128_c *skel_c;
+
+	skel_c =3D aggregate_ret_int128_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel_c, "skel_c_open_load"))
+		return;
+
+	/* C variant (__int128): relies on LLVM 23 R0:R2 codegen, skipped other=
wise. */
+	if (test__start_subtest("int128_c"))
+		run_prog(skel_c->progs.aggregate_ret_test, true);
+
+	aggregate_ret_int128_c__destroy(skel_c);
+
+	skel_struct_c =3D aggregate_ret_struct_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel_struct_c, "skel_struct_c_open_load"))
+		return;
+
+	/*
+	 * C variant returning a 16-byte struct by value: exercises the struct
+	 * branch of bpf_ret_reg_pair(). Also LLVM 23 only.
+	 */
+	if (test__start_subtest("struct_c"))
+		run_prog(skel_struct_c->progs.aggregate_ret_struct_c_test, true);
+
+	/*
+	 * Same 16-byte struct return, but from a global (non-static) callee:
+	 * exercises the compiler lowering a global struct-returning function t=
o
+	 * R0:R2 and the verifier's global return path end to end. Also LLVM 23
+	 * only.
+	 */
+	if (test__start_subtest("global_struct_c"))
+		run_prog(skel_struct_c->progs.aggregate_ret_global_struct_c_test, true=
);
+
+	/*
+	 * Same 16-byte struct, but returned by value from a kfunc: exercises
+	 * the struct branch of check_kfunc_call() and the JIT RDX->R2 move.
+	 * Also LLVM 23 only.
+	 */
+	if (test__start_subtest("kfunc_struct_c"))
+		run_prog(skel_struct_c->progs.aggregate_ret_kfunc_struct_c_test, true)=
;
+
+	aggregate_ret_struct_c__destroy(skel_struct_c);
+
+	skel_union_c =3D aggregate_ret_union_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel_union_c, "skel_union_c_open_load"))
+		return;
+
+	/*
+	 * C variant returning a 16-byte union by value: exercises the union BT=
F
+	 * kind through the same struct branch of bpf_ret_reg_pair().
+	 * Also LLVM 23 only.
+	 */
+	if (test__start_subtest("union_c"))
+		run_prog(skel_union_c->progs.aggregate_ret_union_c_test, true);
+
+	aggregate_ret_union_c__destroy(skel_union_c);
+}
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c b=
/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
new file mode 100644
index 000000000000..0b0c4fa52b62
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if __clang_major__ >=3D 23
+
+typedef unsigned __int128 u128;
+
+static __attribute__((noinline)) u128 make_i128(__u64 a, __u64 b)
+{
+	return ((u128)a << 64) | b;
+}
+
+SEC("tc")
+int aggregate_ret_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	u128 v;
+
+	v =3D make_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a)
+		return 1;
+	if ((__u64)v !=3D b)
+		return 2;
+
+	v =3D bpf_kfunc_call_test_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a)
+		return 3;
+	if ((__u64)v !=3D b)
+		return 4;
+
+	return 0;
+}
+
+#else
+
+SEC("tc")
+int aggregate_ret_test(struct __sk_buff *skb)
+{
+	return -1;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c b=
/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
new file mode 100644
index 000000000000..ad8d44755d24
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if __clang_major__ >=3D 23
+
+struct pair {
+	__u64 hi;
+	__u64 lo;
+};
+
+static __attribute__((noinline)) struct pair make_pair(__u64 a, __u64 b)
+{
+	struct pair p =3D { .hi =3D a, .lo =3D b };
+
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	struct pair p;
+
+	p =3D make_pair(a, b);
+	if (p.hi !=3D a)
+		return 1;
+	if (p.lo !=3D b)
+		return 2;
+
+	return 0;
+}
+
+__attribute__((noinline)) struct pair make_pair_global(__u64 a, __u64 b)
+{
+	struct pair p =3D { .hi =3D a, .lo =3D b };
+
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_global_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xcafef00dULL;
+	struct pair p;
+
+	p =3D make_pair_global(a, b);
+	if (p.hi !=3D a)
+		return 1;
+	if (p.lo !=3D b)
+		return 2;
+
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xfeedfaceULL;
+	struct bpf_kfunc_ret_ll p;
+
+	p =3D bpf_kfunc_call_test_ret_ll(a, b);
+	if (p.a !=3D a)
+		return 1;
+	if (p.b !=3D b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+SEC("tc")
+int aggregate_ret_struct_c_test(struct __sk_buff *skb)
+{
+	return -1;
+}
+
+SEC("tc")
+int aggregate_ret_global_struct_c_test(struct __sk_buff *skb)
+{
+	return -1;
+}
+
+SEC("tc")
+int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
+{
+	return -1;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c b/=
tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c
new file mode 100644
index 000000000000..53e21753291b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#if __clang_major__ >=3D 23
+
+union pair {
+	__u64 halves[2];
+	struct {
+		__u64 lo;
+		__u64 hi;
+	} parts;
+};
+
+static __attribute__((noinline)) union pair make_pair(__u64 a, __u64 b)
+{
+	union pair p;
+
+	p.parts.lo =3D a;
+	p.parts.hi =3D b;
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_union_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	union pair p;
+
+	p =3D make_pair(a, b);
+	if (p.parts.lo !=3D a)
+		return 1;
+	if (p.parts.hi !=3D b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+SEC("tc")
+int aggregate_ret_union_c_test(struct __sk_buff *skb)
+{
+	return -1;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..3511a4873d6c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -825,6 +825,18 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
 	return 0;
 }
=20
+__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
+{
+	return ((__int128)a << 64) | b;
+}
+
+__bpf_kfunc struct bpf_kfunc_ret_ll bpf_kfunc_call_test_ret_ll(u64 a, u6=
4 b)
+{
+	struct bpf_kfunc_ret_ll r =3D { .a =3D a, .b =3D b };
+
+	return r;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
 					 u64 e, u64 f, u64 g, u64 h,
 					 u64 i, u64 j)
@@ -1358,6 +1370,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ll)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c36bb911defa..34d0a352e70d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -55,6 +55,15 @@ struct prog_test_big_arg {
 	__u64 b;
 };
=20
+/*
+ * A 16-byte struct returned by value from a kfunc, returned in the R0:R=
2
+ * register pair.
+ */
+struct bpf_kfunc_ret_ll {	/* 16 bytes: R0:R2 */
+	__u64 a;
+	__u64 b;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -118,6 +127,8 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __=
u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
+__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
+struct bpf_kfunc_ret_ll bpf_kfunc_call_test_ret_ll(__u64 a, __u64 b) __k=
sym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
 			       __u64 i, __u64 j) __ksym;
--=20
2.53.0-Meta

