Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A3265CA8
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093302; cv=none; b=IAnW9FZ1YG+GUAUBcdpjHBz1HG9MbWmjirRZa6pYanNGWtr3o+EKyP/6reWZWRVVjQ9idcJgJKIMudWKPEsiUYl+SLjAu8FiV2QHiB4PZdllA+9NKp4XiWJheM8zz03cFUno0P8c7HlUiSMkJoiWA9cUSlIZ0wDLtT7oUpLe/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093302; c=relaxed/simple;
	bh=CsxSKtAu8YK9gNjNfce/FvhNfPp7AUxq/IX7bP238wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBym9zzt6h32/nfccQA5kFHiwQ8o2d2PZOM7VyHD73/CfvWvX1R1HVshukQ1N4cINmAEacZcJ9qWo5A0GOAaIsdiA5FTpb0mnOi92F0LvzgKciABXsmUW2qa2cMF+bZuPqWU4tkbQ7v2kNkzZOyExdupcwt6vdRrjiWX0tiVW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 84B3F3328054F; Wed,  1 Apr 2026 18:28:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 08/10] selftests/bpf: Add tests for BPF function stack arguments
Date: Wed,  1 Apr 2026 18:28:08 -0700
Message-ID: <20260402012808.3921472-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add selftests covering stack argument passing for both BPF-to-BPF
subprog calls and kfunc calls with more than 5 arguments. All tests
are guarded by __BPF_FEATURE_STACK_ARGUMENT and __TARGET_ARCH_x86.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/stack_arg.c      | 143 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stack_arg.c | 111 ++++++++++++++
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  59 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  22 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   7 +
 5 files changed, 342 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/t=
esting/selftests/bpf/prog_tests/stack_arg.c
new file mode 100644
index 000000000000..86b8025f5541
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "stack_arg.skel.h"
+#include "stack_arg_kfunc.skel.h"
+
+static void test_nesting(void)
+{
+	struct stack_arg *skel;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+
+	skel =3D stack_arg__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+
+	err =3D stack_arg__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+
+	skel->bss->a =3D 0;
+	skel->bss->b =3D 0;
+	skel->bss->c =3D 0;
+	skel->bss->d =3D 0;
+	skel->bss->e =3D 0;
+	skel->bss->f =3D 6;
+	skel->bss->g =3D 7;
+	skel->bss->i =3D 8;
+
+	prog_fd =3D bpf_program__fd(skel->progs.test);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 29, "retval");
+
+out:
+	stack_arg__destroy(skel);
+}
+
+static void run_subtest(struct bpf_program *prog, int expected)
+{
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+
+	prog_fd =3D bpf_program__fd(prog);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, expected, "retval");
+}
+
+static void test_global_many(void)
+{
+	struct stack_arg *skel;
+
+	skel =3D stack_arg__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+
+	if (!ASSERT_OK(stack_arg__load(skel), "load"))
+		goto out;
+
+	run_subtest(skel->progs.test_global_many_args, 36);
+
+out:
+	stack_arg__destroy(skel);
+}
+
+static void test_async_cb_many(void)
+{
+	struct stack_arg *skel;
+
+	skel =3D stack_arg__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+
+	if (!ASSERT_OK(stack_arg__load(skel), "load"))
+		goto out;
+
+	run_subtest(skel->progs.test_async_cb_many_args, 0);
+
+out:
+	stack_arg__destroy(skel);
+}
+
+static void test_kfunc(void)
+{
+	struct stack_arg_kfunc *skel;
+
+	skel =3D stack_arg_kfunc__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+
+	if (!ASSERT_OK(stack_arg_kfunc__load(skel), "load"))
+		goto out;
+
+	run_subtest(skel->progs.test_stack_arg_scalar, 36);
+	run_subtest(skel->progs.test_stack_arg_ptr, 45);
+	run_subtest(skel->progs.test_stack_arg_mix, 51);
+
+out:
+	stack_arg_kfunc__destroy(skel);
+}
+
+void test_stack_arg(void)
+{
+	if (test__start_subtest("nesting"))
+		test_nesting();
+	if (test__start_subtest("global_many_args"))
+		test_global_many();
+	if (test__start_subtest("async_cb_many_args"))
+		test_async_cb_many();
+	if (test__start_subtest("kfunc"))
+		test_kfunc();
+}
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
new file mode 100644
index 000000000000..c139a699fc3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+
+#define CLOCK_MONOTONIC 1
+
+long a, b, c, d, e, f, g, i;
+
+struct timer_elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} timer_map SEC(".maps");
+
+int timer_result;
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+__noinline static long func_b(long a, long b, long c, long d,
+			      long e, long f, long g, long h)
+{
+	return a + b + c + d + e + f + g + h;
+}
+
+__noinline static long func_a(long a, long b, long c, long d,
+			      long e, long f, long g, long h)
+{
+	return func_b(a + 1, b + 1, c + 1, d + 1,
+		      e + 1, f + 1, g + 1, h + 1);
+}
+
+SEC("tc")
+int test(void)
+{
+	return func_a(a, b, c, d, e, f, g, i);
+}
+
+__noinline static int static_func_many_args(int a, int b, int c, int d,
+					    int e, int f, int g, int h)
+{
+	return a + b + c + d + e + f + g + h;
+}
+
+__noinline int global_calls_many_args(int a, int b, int c)
+{
+	return static_func_many_args(a, b, c, 4, 5, 6, 7, 8);
+}
+
+SEC("tc")
+int test_global_many_args(void)
+{
+	return global_calls_many_args(1, 2, 3);
+}
+
+static int timer_cb_many_args(void *map, int *key, struct bpf_timer *tim=
er)
+{
+	timer_result =3D static_func_many_args(10, 20, 30, 40, 50, 60, 70, 80);
+	return 0;
+}
+
+SEC("tc")
+int test_async_cb_many_args(void)
+{
+	struct timer_elem *elem;
+	int key =3D 0;
+
+	elem =3D bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return -1;
+
+	bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(&elem->timer, timer_cb_many_args);
+	bpf_timer_start(&elem->timer, 1, 0);
+	return 0;
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+SEC("tc")
+int test(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_global_many_args(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_async_cb_many_args(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/=
testing/selftests/bpf/progs/stack_arg_kfunc.c
new file mode 100644
index 000000000000..a440e9b42a4a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+SEC("tc")
+int test_stack_arg_scalar(struct __sk_buff *skb)
+{
+	return bpf_kfunc_call_stack_arg(1, 2, 3, 4, 5, 6, 7, 8);
+}
+
+SEC("tc")
+int test_stack_arg_ptr(struct __sk_buff *skb)
+{
+	struct prog_test_pass1 p =3D { .x0 =3D 10, .x1 =3D 20 };
+
+	return bpf_kfunc_call_stack_arg_ptr(1, 2, 3, 4, 5, &p);
+}
+
+SEC("tc")
+int test_stack_arg_mix(struct __sk_buff *skb)
+{
+	struct prog_test_pass1 p =3D { .x0 =3D 10 };
+	struct prog_test_pass1 q =3D { .x1 =3D 20 };
+
+	return bpf_kfunc_call_stack_arg_mix(1, 2, 3, 4, 5, &p, 6, &q);
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+SEC("tc")
+int test_stack_arg_scalar(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_ptr(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_mix(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 061356f10093..d88ab1dc5106 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -824,6 +824,25 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
 	return 0;
 }
=20
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
+					 u64 e, u64 f, u64 g, u64 h)
+{
+	return a + b + c + d + e + f + g + h;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_ptr(u64 a, u64 b, u64 c, u64 d,=
 u64 e,
+					     struct prog_test_pass1 *p)
+{
+	return a + b + c + d + e + p->x0 + p->x1;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_mix(u64 a, u64 b, u64 c, u64 d,=
 u64 e,
+					     struct prog_test_pass1 *p, u64 f,
+					     struct prog_test_pass1 *q)
+{
+	return a + b + c + d + e + p->x0 + f + q->x1;
+}
+
 static struct prog_test_ref_kfunc prog_test_struct =3D {
 	.a =3D 42,
 	.b =3D 108,
@@ -1287,6 +1306,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index aa0b8d41e71b..f93cf2db12b2 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -111,6 +111,13 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, _=
_u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
+__u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
+			       __u64 e, __u64 f, __u64 g, __u64 h) __ksym;
+__u64 bpf_kfunc_call_stack_arg_ptr(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_pass1 *p) __ksym;
+__u64 bpf_kfunc_call_stack_arg_mix(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_pass1 *p, __u64 f,
+				   struct prog_test_pass1 *q) __ksym;
=20
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
--=20
2.52.0

