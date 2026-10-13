Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48618524AE5
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911394; cv=none; b=sDfPTRBPhJ+b50wBgDzBUaDkcFN67xHocTTbAC8ylNxqkNx2xy73SjDvgxrBEP/x8fy1K/VNeDD3H0x57NE+Jc7QdsHUQzjMmx9cNvygisp+ssIqJsNwrFSOAhH/B+ImZ0tW4eN437xj9K6dPHINO62VbILTIUkkuxUNkKj+evU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911394; c=relaxed/simple;
	bh=gREkkisWIwGatiyMUF0+RNeC70n1HBBqFspgpC5s914=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRQB/y+xvI/FoXOBanOha7ODXqAK2Hib2ENxfp7IC/4sT8lhwMAOUA4J+20EjlT8b6KNYqlxPaWt3MN//HfCf2sz1CgHf2/xSwzfgZnG1OruvV3XpzBcSFTRrwqz7Cx/aDLUrJUeSPZVNNKGr7Tbn/dNhk4grVEPEcawUDjfMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 57B2B30FB5C41D; Tue, 13 Oct 2026 10:09:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 02/11] selftests/bpf: Test trampoline stack args in a program that can tail call
Date: Tue, 13 Oct 2026 10:09:22 -0700
Message-ID: <20261013170922.2129381-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test the previous patch with a target program made of two call chains:

	run() -> call_stack() -> callee_stack(a, b, c, d, e, f, g, h)
	run() -> subprog_tail() -> bpf_tail_call()

callee_stack() takes eight u64 arguments, so g and h are passed on the
stack. Because run() can reach a tail call, a trampoline on any function
of the program keeps the tail call counter pointer. callee_stack()
itself does not lead to the tail call, which is why the verifier still
lets it take stack arguments.

Attach fentry and fexit programs to callee_stack(). The fentry program
checks that it sees g and h, and the test checks the value that
callee_stack() returns when the fexit trampoline calls it.

Without the previous patch, the function takes the counter pointer for
its first stack argument:

  test_stack_arg_tailcall:FAIL:stack ret unexpected stack ret: actual -35=
9789677662885869 !=3D expected 204
  test_stack_arg_tailcall:FAIL:stack fexit ret unexpected stack fexit ret=
: actual -359789677662885869 !=3D expected 204

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 59 +++++++++++++++++++
 .../progs/tracing_stack_arg_tailcall_tgt.c    | 59 +++++++++++++++++++
 .../progs/tracing_stack_arg_tailcall_tracer.c | 23 ++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_t=
ailcall_tgt.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_stack_arg_t=
ailcall_tracer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
index 15b95d0235b5..8086586d3e19 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -5,6 +5,8 @@
 #include "tracing_struct.skel.h"
 #include "tracing_struct_many_args.skel.h"
 #include "tracing_struct_int128.skel.h"
+#include "tracing_stack_arg_tailcall_tgt.skel.h"
+#include "tracing_stack_arg_tailcall_tracer.skel.h"
=20
 static void test_struct_args(void)
 {
@@ -146,6 +148,61 @@ static void test_int128_args(void)
 #endif
 }
=20
+/*
+ * A trampoline on a function of a tail_call_reachable program keeps the=
 tail
+ * call counter pointer on its stack, and has to hand the function its s=
tack
+ * arguments past it.
+ */
+static void test_stack_arg_tailcall(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__)
+	struct tracing_stack_arg_tailcall_tracer *tracer =3D NULL;
+	struct tracing_stack_arg_tailcall_tgt *tgt;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, fd;
+
+	tgt =3D tracing_stack_arg_tailcall_tgt__open_and_load();
+	if (!ASSERT_OK_PTR(tgt, "tgt__open_and_load"))
+		return;
+	if (!tgt->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+	fd =3D bpf_program__fd(tgt->progs.run);
+
+	tracer =3D tracing_stack_arg_tailcall_tracer__open();
+	if (!ASSERT_OK_PTR(tracer, "tracer__open"))
+		goto out;
+
+	err =3D bpf_program__set_attach_target(tracer->progs.stack_entry, fd, "=
callee_stack");
+	err =3D err ?: bpf_program__set_attach_target(tracer->progs.stack_exit,=
 fd, "callee_stack");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err =3D tracing_stack_arg_tailcall_tracer__load(tracer);
+	if (!ASSERT_OK(err, "tracer__load"))
+		goto out;
+	err =3D tracing_stack_arg_tailcall_tracer__attach(tracer);
+	if (!ASSERT_OK(err, "tracer__attach"))
+		goto out;
+
+	err =3D bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run") || !ASSERT_EQ(topts.retval, 0, "retval"=
))
+		goto out;
+
+	ASSERT_EQ(tracer->bss->stack_g, 7, "stack:g");
+	ASSERT_EQ(tracer->bss->stack_h, 8, "stack:h");
+	ASSERT_EQ(tgt->bss->ret_stack, 204, "stack ret");
+	ASSERT_EQ(tracer->bss->stack_ret, 204, "stack fexit ret");
+
+out:
+	tracing_stack_arg_tailcall_tracer__destroy(tracer);
+	tracing_stack_arg_tailcall_tgt__destroy(tgt);
+#else
+	test__skip();
+#endif
+}
+
 static void test_union_args(void)
 {
 	struct tracing_struct *skel;
@@ -181,6 +238,8 @@ void test_tracing_struct(void)
 		test_struct_many_args();
 	if (test__start_subtest("int128_args"))
 		test_int128_args();
+	if (test__start_subtest("stack_arg_tailcall"))
+		test_stack_arg_tailcall();
 	if (test__start_subtest("union_args"))
 		test_union_args();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall=
_tgt.c b/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_tgt=
.c
new file mode 100644
index 000000000000..5fde710c4e37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_tgt.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__u64 base;
+__u64 ret_stack;
+
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+/* g and h are on the stack, for the x86-64 kernel convention too. */
+static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
+				     __u64 e, __u64 f, __u64 g, __u64 h)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
+}
+
+/* No stack args of its own, so it can share a program with a tail call.=
 */
+static __noinline __u64 call_stack(__u64 x)
+{
+	return callee_stack(x + 1, x + 2, x + 3, x + 4, x + 5, x + 6, x + 7,
+			    x + 8);
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+#endif
+
+/* Makes the program tail_call_reachable, though callee_stack() is not. =
*/
+static __noinline int subprog_tail(void *ctx)
+{
+	int ret =3D 0;
+
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	barrier_var(ret);
+	return ret;
+}
+
+SEC("syscall")
+int run(void *ctx)
+{
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+	ret_stack =3D call_stack(base);
+#endif
+	return subprog_tail(ctx);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall=
_tracer.c b/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_=
tracer.c
new file mode 100644
index 000000000000..1800e7b7afe2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_stack_arg_tailcall_tracer=
.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+long stack_g, stack_h, stack_ret;
+
+SEC("fentry/callee_stack")
+int stack_entry(unsigned long long *ctx)
+{
+	stack_g =3D ctx[6];
+	stack_h =3D ctx[7];
+	return 0;
+}
+
+SEC("fexit/callee_stack")
+int stack_exit(unsigned long long *ctx)
+{
+	stack_ret =3D ctx[8];
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

