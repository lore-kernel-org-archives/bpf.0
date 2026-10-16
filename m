Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1F49BB52
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175488; cv=none; b=CRVcsQuIRIUoOOA1MlrQXZhkmPtYBB3phpfw4tbAvXaor5oBcdBpqIO3XjAad5n+uTyUGern+jWjCPmO7OzQ2RtkJSw7+xJ+GW5jPM/FntmM+dg5m1iCVw9odOoqkmmspk9sC5VXjWxXfnLVv1an0xWt11HutyqwMpowjZTMBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175488; c=relaxed/simple;
	bh=jiMxWbDIAUx8yrdQhrBWVSjW5pKYSKuAqXspDzkKz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWpTU0zN7lrCKDPATRLhYN52a657FvHjkAUna7BjbhaOKMn0JApK1X/ykD0N9kwD1VOuoI7wA4l0RRyFxV+ihd5hVCatGynjDXKmKZPxL35Dc+/sL7c5lY3+c+aYu7HYvZzfqgst5Mo5Vf/q8KnvV41BElWxdXsNVTzWRUnhbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5D02E31A0DA9EA; Fri, 16 Oct 2026 11:31:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: Test trampoline args of a BPF function at an odd slot
Date: Fri, 16 Oct 2026 11:31:15 -0700
Message-ID: <20261016183115.1135762-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016183039.1132126-1-yonghong.song@linux.dev>
References: <20261016183039.1132126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Attach fentry and fexit programs to two functions of another BPF
program, each taking a struct holding an __int128 at an odd argument
slot:

  - callee_odd(): the struct after a single u64, where arm64 would
    leave a register empty.
  - callee_stack(): the struct after seven u64s, where x86-64 would
    leave a stack slot empty and arm64 a register.

BPF code calls them with the arguments packed in the BPF convention, so
that is where the trampoline has to take them from. The fentry programs
take the arguments with BPF_PROG2(), which reads each from its slots in
ctx[], and the fexit programs check the return value, weighted by slot,
which is only right if the function got its arguments back where its
caller put them. Both take a struct by value, which GCC passes by
reference instead, so they are only built with clang, and callee_stack()
only with a clang that supports stack arguments.

Unlike a kernel function taking an __int128, which s390x passes by
reference, nothing in the test depends on how the arch passes a 16-byte
value, so it runs on s390x as well as on x86_64 and arm64. BPF_PROG2()
reads the struct from its two context slots the way BPF code passed it,
so its halves come out right on big-endian s390x too. The s390 JIT does
not take stack arguments, so callee_stack() is only built for x86 and
arm64, and only callee_odd() is traced on s390x.

Describing the functions to the trampoline by the types of their
arguments, rather than as one u64 per slot, the x86-64 trampoline fails
the test with:

  test_int128_tgt_prog:FAIL:stack:h.lo unexpected stack:h.lo: actual 9 !=3D=
 expected 8
  test_int128_tgt_prog:FAIL:stack:h.hi unexpected stack:h.hi: actual 10 !=
=3D expected 9

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 74 +++++++++++++++++++
 .../bpf/progs/tracing_struct_int128_tgt.c     | 71 ++++++++++++++++++
 .../bpf/progs/tracing_struct_int128_tracer.c  | 50 +++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28_tracer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
index a2da219e1476..a02731bc6573 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -5,6 +5,8 @@
 #include "tracing_struct.skel.h"
 #include "tracing_struct_many_args.skel.h"
 #include "tracing_struct_int128.skel.h"
+#include "tracing_struct_int128_tgt.skel.h"
+#include "tracing_struct_int128_tracer.skel.h"
 #include "tracing_stack_arg_tailcall_tgt.skel.h"
 #include "tracing_stack_arg_tailcall_tracer.skel.h"
=20
@@ -164,6 +166,76 @@ static void test_int128_args(void)
 #endif
 }
=20
+static void test_int128_tgt_prog(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
+	struct tracing_struct_int128_tracer *tracer =3D NULL;
+	struct tracing_struct_int128_tgt *tgt;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	tgt =3D tracing_struct_int128_tgt__open_and_load();
+	if (!ASSERT_OK_PTR(tgt, "tgt__open_and_load"))
+		return;
+	if (!tgt->rodata->has_struct_arg) {
+		test__skip();
+		goto out;
+	}
+	fd =3D bpf_program__fd(tgt->progs.run);
+
+	tracer =3D tracing_struct_int128_tracer__open();
+	if (!ASSERT_OK_PTR(tracer, "tracer__open"))
+		goto out;
+
+	err =3D bpf_program__set_attach_target(tracer->progs.odd_entry, fd, "ca=
llee_odd");
+	err =3D err ?: bpf_program__set_attach_target(tracer->progs.odd_exit, f=
d, "callee_odd");
+	if (tgt->rodata->has_stack_arg) {
+		err =3D err ?: bpf_program__set_attach_target(tracer->progs.stack_entr=
y, fd,
+							     "callee_stack");
+		err =3D err ?: bpf_program__set_attach_target(tracer->progs.stack_exit=
, fd,
+							     "callee_stack");
+	} else {
+		bpf_program__set_autoload(tracer->progs.stack_entry, false);
+		bpf_program__set_autoload(tracer->progs.stack_exit, false);
+	}
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err =3D tracing_struct_int128_tracer__load(tracer);
+	if (!ASSERT_OK(err, "tracer__load"))
+		goto out;
+	err =3D tracing_struct_int128_tracer__attach(tracer);
+	if (!ASSERT_OK(err, "tracer__attach"))
+		goto out;
+
+	err =3D bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(topts.retval, 0, "retval"=
))
+		goto out;
+
+	ASSERT_EQ(tracer->bss->odd_a, 1, "odd:a");
+	ASSERT_EQ(tracer->bss->odd_lo, 8, "odd:v.lo");
+	ASSERT_EQ(tracer->bss->odd_hi, 9, "odd:v.hi");
+	ASSERT_EQ(tracer->bss->odd_b, 2, "odd:b");
+	ASSERT_EQ(tgt->bss->ret_odd, 52, "odd ret");
+	ASSERT_EQ(tracer->bss->odd_ret, 52, "odd fexit ret");
+
+	if (tgt->rodata->has_stack_arg) {
+		ASSERT_EQ(tracer->bss->stack_g, 7, "stack:g");
+		ASSERT_EQ(tracer->bss->stack_lo, 8, "stack:h.lo");
+		ASSERT_EQ(tracer->bss->stack_hi, 9, "stack:h.hi");
+		ASSERT_EQ(tracer->bss->stack_i, 10, "stack:i");
+		ASSERT_EQ(tgt->bss->ret_stack, 385, "stack ret");
+		ASSERT_EQ(tracer->bss->stack_ret, 385, "stack fexit ret");
+	}
+
+out:
+	tracing_struct_int128_tracer__destroy(tracer);
+	tracing_struct_int128_tgt__destroy(tgt);
+#else
+	test__skip();
+#endif
+}
+
 /*
  * A trampoline on a function of a tail_call_reachable program keeps the=
 tail
  * call counter pointer on its stack, and has to hand the function its s=
tack
@@ -254,6 +326,8 @@ void test_tracing_struct(void)
 		test_struct_many_args();
 	if (test__start_subtest("int128_args"))
 		test_int128_args();
+	if (test__start_subtest("int128_tgt_prog"))
+		test_int128_tgt_prog();
 	if (test__start_subtest("stack_arg_tailcall"))
 		test_stack_arg_tailcall();
 	if (test__start_subtest("union_args"))
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.=
c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
new file mode 100644
index 000000000000..60e997470b59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct int128_arg {
+	__int128 v;
+};
+
+__u64 base;
+__u64 ret_odd, ret_stack;
+
+#if defined(__clang__)
+
+const volatile bool has_struct_arg =3D true;
+
+/* arm64 would want v in x2 and x3, and b in x4. */
+__noinline __u64 callee_odd(__u64 a, struct int128_arg v, __u64 b)
+{
+	return a + (__u64)v.v * 2 + (__u64)((unsigned __int128)v.v >> 64) * 3 +
+	       b * 4;
+}
+
+#else
+
+const volatile bool has_struct_arg =3D false;
+
+#endif
+
+#if defined(__clang__) && \
+	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+/*
+ * x86-64 would want h in its third and fourth stack slots, and arm64 in
+ * its first and second, leaving x7 empty.
+ */
+static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
+				     __u64 e, __u64 f, __u64 g,
+				     struct int128_arg h, __u64 i)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 +
+	       (__u64)h.v * 8 + (__u64)((unsigned __int128)h.v >> 64) * 9 +
+	       i * 10;
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+#endif
+
+SEC("syscall")
+int run(void *ctx)
+{
+#if defined(__clang__)
+	struct int128_arg v =3D { .v =3D ((__int128)(base + 9) << 64) | (base +=
 8) };
+
+	ret_odd =3D callee_odd(base + 1, v, base + 2);
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
+	ret_stack =3D callee_stack(base + 1, base + 2, base + 3, base + 4,
+				 base + 5, base + 6, base + 7, v, base + 10);
+#endif
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_trac=
er.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
new file mode 100644
index 000000000000..5843dc5af9cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct int128_arg {
+	__int128 v;
+};
+
+long odd_a, odd_lo, odd_hi, odd_b, odd_ret;
+
+SEC("fentry/callee_odd")
+int BPF_PROG2(odd_entry, __u64, a, struct int128_arg, v, __u64, b)
+{
+	odd_a =3D a;
+	odd_lo =3D (__u64)v.v;
+	odd_hi =3D (unsigned __int128)v.v >> 64;
+	odd_b =3D b;
+	return 0;
+}
+
+SEC("fexit/callee_odd")
+int odd_exit(unsigned long long *ctx)
+{
+	odd_ret =3D ctx[4];
+	return 0;
+}
+
+long stack_g, stack_lo, stack_hi, stack_i, stack_ret;
+
+SEC("fentry/callee_stack")
+int BPF_PROG2(stack_entry, __u64, a, __u64, b, __u64, c, __u64, d, __u64=
, e,
+	      __u64, f, __u64, g, struct int128_arg, h, __u64, i)
+{
+	stack_g =3D g;
+	stack_lo =3D (__u64)h.v;
+	stack_hi =3D (unsigned __int128)h.v >> 64;
+	stack_i =3D i;
+	return 0;
+}
+
+SEC("fexit/callee_stack")
+int stack_exit(unsigned long long *ctx)
+{
+	stack_ret =3D ctx[10];
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

