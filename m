Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0273395ADB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215866; cv=none; b=at3h+QJUQJElee9IzKMUgZBoRL27WWUPva7yCLbP9ilHxP4Ap7/rB9Mw7yiwvzluQSSymWr0qbRzNPzF6heoXXNsis50NYZTNTGjSBBKXVwaRxNmLOVvALn/ODYRalPJrjKDXPLc/Xzm5TDkBICh9xkyP+sveIQxQhlUyng3qLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215866; c=relaxed/simple;
	bh=PIXKOozxIZuUGJNPAFNE1y0w/egcm2kxHPC45j6Q93c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L925MvlQx06PksZDK4sBymrR8DScBS8tKkiSGPUvjutDpCh3GVnRIfyRzrfrWTbcY0ZGu+9eaN94G2cKkW/BwKpDIvHWKLijyOFgN6dA0jNGul3N+7YtWmCgV7r5i6nAvLJuxq2Lv79FZBL+XpQtYmjna8k/JpI/d817dH03210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 85CC622CA31DF5; Sat,  8 Aug 2026 12:04:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 10/13] selftests/bpf: Add C tests for 16-byte returns in R0:R2
Date: Sat,  8 Aug 2026 12:04:13 -0700
Message-ID: <20260808190413.1902293-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add selftests that exercise a 16-byte return value passed in the R0:R2
register pair, written in C so that they depend on the compiler lowering
the register-pair return. Covered are an __int128 return, a 16-byte struc=
t
return (from a static and from a global subprogram) and a 16-byte union
return, plus __int128 and 16-byte struct returns from a kfunc, for which
bpf_kfunc_call_test_i128() and bpf_kfunc_call_test_ret_pair() are added t=
o
bpf_testmod.

The R0:R2 convention is only emitted by LLVM 23 and newer. Each object
records in a read-only has_reg_pair_ret flag which compiler built it; whe=
re
that is false the programs are stubs and subtests report a skip rather th=
an
a pass.

The two kfunc subtests further depend on the JIT: bpf_add_kfunc_call()
rejects a kfunc returning more than 8 bytes with -EOPNOTSUPP where
bpf_jit_supports_kfunc_ret_reg_pair() is false. Those calls therefore liv=
e
in an object of their own, and that load failing with -EOPNOTSUPP is what
turns the two subtests into skips, so no list of the JITs implementing th=
e
pair needs to be kept here. A register-pair return from a BPF subprogram
needs no JIT support, so the remaining subtests run everywhere.

bpf_kfunc_call_test_i128() is guarded by __SIZEOF_INT128__, which the
compiler only defines on 64-bit targets. A return value in R0:R2 is
supported on 64-bit architectures only, so the guard is there to keep
bpf_testmod building on a 32-bit target, not to make the test run there.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 122 ++++++++++++++++++
 .../bpf/progs/aggregate_ret_int128_c.c        |  48 +++++++
 .../bpf/progs/aggregate_ret_kfunc_c.c         |  66 ++++++++++
 .../bpf/progs/aggregate_ret_struct_c.c        |  82 ++++++++++++
 .../bpf/progs/aggregate_ret_union_c.c         |  58 +++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  23 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 ++
 7 files changed, 412 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_ret.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_int12=
8_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_struc=
t_c.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_union=
_c.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
new file mode 100644
index 000000000000..e4317399d711
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "aggregate_ret_int128_c.skel.h"
+#include "aggregate_ret_struct_c.skel.h"
+#include "aggregate_ret_union_c.skel.h"
+#include "aggregate_ret_kfunc_c.skel.h"
+
+static void run_prog(struct bpf_program *prog, bool supported)
+{
+	char buf[64] =3D {};
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in =3D buf,
+		    .data_size_in =3D sizeof(buf),
+		    .repeat =3D 1,
+	);
+
+	if (!supported) {
+		test__skip();
+		return;
+	}
+
+	prog_fd =3D bpf_program__fd(prog);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+
+	ASSERT_EQ(topts.retval, 0, "aggregate_ret_result");
+}
+
+static void test_int128_c(void)
+{
+	struct aggregate_ret_int128_c *skel;
+
+	skel =3D aggregate_ret_int128_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_int128_c_open_load"))
+		return;
+
+	if (test__start_subtest("int128_c"))
+		run_prog(skel->progs.aggregate_ret_int128_c_test,
+			 skel->rodata->has_reg_pair_ret);
+
+	aggregate_ret_int128_c__destroy(skel);
+}
+
+static void test_struct_c(void)
+{
+	struct aggregate_ret_struct_c *skel;
+
+	skel =3D aggregate_ret_struct_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_struct_c_open_load"))
+		return;
+
+	if (test__start_subtest("struct_c"))
+		run_prog(skel->progs.aggregate_ret_struct_c_test,
+			 skel->rodata->has_reg_pair_ret);
+
+	if (test__start_subtest("global_struct_c"))
+		run_prog(skel->progs.aggregate_ret_global_struct_c_test,
+			 skel->rodata->has_reg_pair_ret);
+
+	aggregate_ret_struct_c__destroy(skel);
+}
+
+static void test_union_c(void)
+{
+	struct aggregate_ret_union_c *skel;
+
+	skel =3D aggregate_ret_union_c__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_union_c_open_load"))
+		return;
+
+	if (test__start_subtest("union_c"))
+		run_prog(skel->progs.aggregate_ret_union_c_test,
+			 skel->rodata->has_reg_pair_ret);
+
+	aggregate_ret_union_c__destroy(skel);
+}
+
+static void test_kfunc_c(void)
+{
+	struct aggregate_ret_kfunc_c *skel;
+	bool supported;
+	int err;
+
+	skel =3D aggregate_ret_kfunc_c__open();
+	if (!ASSERT_OK_PTR(skel, "skel_kfunc_c_open"))
+		return;
+
+	supported =3D skel->rodata->has_reg_pair_ret;
+
+	/*
+	 * Where the JIT cannot hand the second half of a >8-byte kfunc return
+	 * back in R0:R2, bpf_add_kfunc_call() rejects the call with
+	 * -EOPNOTSUPP. Asking the kernel keeps this test free of a list of the
+	 * JITs that can, which would have to be updated as the rest of them
+	 * learn.
+	 */
+	err =3D aggregate_ret_kfunc_c__load(skel);
+	if (err =3D=3D -EOPNOTSUPP)
+		supported =3D false;
+	else if (!ASSERT_OK(err, "skel_kfunc_c_load"))
+		goto out;
+
+	if (test__start_subtest("kfunc_int128_c"))
+		run_prog(skel->progs.aggregate_ret_kfunc_int128_c_test, supported);
+
+	if (test__start_subtest("kfunc_struct_c"))
+		run_prog(skel->progs.aggregate_ret_kfunc_struct_c_test, supported);
+
+out:
+	aggregate_ret_kfunc_c__destroy(skel);
+}
+
+void test_aggregate_ret(void)
+{
+	test_int128_c();
+	test_struct_c();
+	test_union_c();
+	test_kfunc_c();
+}
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c b=
/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
new file mode 100644
index 000000000000..f2e09c8be0be
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+const volatile bool has_reg_pair_ret =3D true;
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+typedef unsigned __int128 u128;
+
+static __noinline u128 make_i128(__u64 a, __u64 b)
+{
+	return ((u128)(a + b) << 64) | (a - b);
+}
+
+SEC("tc")
+int aggregate_ret_int128_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v;
+
+	v =3D make_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a + b)
+		return 1;
+	if ((__u64)v !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+const volatile bool has_reg_pair_ret =3D false;
+
+SEC("tc")
+int aggregate_ret_int128_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c b/=
tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
new file mode 100644
index 000000000000..fd000620f314
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+const volatile bool has_reg_pair_ret =3D true;
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+typedef unsigned __int128 u128;
+
+SEC("tc")
+int aggregate_ret_kfunc_int128_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v;
+
+	v =3D bpf_kfunc_call_test_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a + b)
+		return 1;
+	if ((__u64)v !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_ret_pair p;
+
+	p =3D bpf_kfunc_call_test_ret_pair(a, b);
+	if (p.hi !=3D a + b)
+		return 1;
+	if (p.lo !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+const volatile bool has_reg_pair_ret =3D false;
+
+SEC("tc")
+int aggregate_ret_kfunc_int128_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c b=
/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
new file mode 100644
index 000000000000..5296e41da3f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_struct_c.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+const volatile bool has_reg_pair_ret =3D true;
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+struct pair {
+	__u64 hi;	/* R0 */
+	__u64 lo;	/* R2 */
+};
+
+static __noinline struct pair make_pair(__u64 a, __u64 b)
+{
+	struct pair p =3D { .hi =3D a + b, .lo =3D a - b };
+
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p;
+
+	p =3D make_pair(a, b);
+	if (p.hi !=3D a + b)
+		return 1;
+	if (p.lo !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+__noinline struct pair make_pair_global(__u64 a, __u64 b)
+{
+	struct pair p =3D { .hi =3D a + b, .lo =3D a - b };
+
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_global_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p;
+
+	p =3D make_pair_global(a, b);
+	if (p.hi !=3D a + b)
+		return 1;
+	if (p.lo !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+const volatile bool has_reg_pair_ret =3D false;
+
+SEC("tc")
+int aggregate_ret_struct_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_global_struct_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c b/=
tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c
new file mode 100644
index 000000000000..5547fa6cbd49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_union_c.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+const volatile bool has_reg_pair_ret =3D true;
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+union pair {
+	__u64 halves[2];
+	struct {
+		__u64 lo;	/* R0 */
+		__u64 hi;	/* R2 */
+	} parts;
+};
+
+static __noinline union pair make_pair(__u64 a, __u64 b)
+{
+	union pair p;
+
+	p.halves[0] =3D a + b;
+	p.halves[1] =3D a - b;
+	return p;
+}
+
+SEC("tc")
+int aggregate_ret_union_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	union pair p;
+
+	p =3D make_pair(a, b);
+	if (p.parts.lo !=3D a + b)
+		return 1;
+	if (p.parts.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+const volatile bool has_reg_pair_ret =3D false;
+
+SEC("tc")
+int aggregate_ret_union_c_test(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index a6133f7521f3..1c26905cec41 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -939,6 +939,25 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
 	return 0;
 }
=20
+/*
+ * A 16-byte return value in R0:R2 is only supported on 64-bit architect=
ures,
+ * which are also the only ones where the compiler defines __SIZEOF_INT1=
28__.
+ * Guard the kfunc so that the module still builds on a 32-bit target.
+ */
+#ifdef __SIZEOF_INT128__
+__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
+{
+	return (__int128)(((unsigned __int128)(a + b) << 64) | (a - b));
+}
+#endif
+
+__bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(u64 a=
, u64 b)
+{
+	struct prog_test_ret_pair r =3D { .hi =3D a + b, .lo =3D a - b };
+
+	return r;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
 					 u64 e, u64 f, u64 g, u64 h,
 					 u64 i, u64 j)
@@ -1472,6 +1491,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
+#ifdef __SIZEOF_INT128__
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
+#endif
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index c4383acb53c1..b190917f36b8 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -55,6 +55,15 @@ struct prog_test_big_arg {
 	__u64 b;
 };
=20
+/*
+ * A 16-byte struct returned by value from a kfunc: .hi comes back in R0=
 and
+ * .lo in R2.
+ */
+struct prog_test_ret_pair {
+	__u64 hi;
+	__u64 lo;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -130,6 +139,10 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, _=
_u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
+#ifdef __SIZEOF_INT128__
+__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
+#endif
+struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(__u64 a, __u64 b)=
 __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
 			       __u64 i, __u64 j) __ksym;
--=20
2.53.0-Meta

