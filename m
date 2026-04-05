Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53092F0C7E
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408097; cv=none; b=F84hX0f3TEgOqkOAF+6SLWnefVumYeJpQc1v+A5n7y4DO67xG2iaCEMO2ut6rRS7jyzLG9djX9pVycjM1gYyxe/j/hA5hDwrJTH2au+6Rj15v3EIr+uWAqKLYKibR5NnSD4yNxN8Nm4qCg44t6OGmRHIr21mSjDkgITGp8DP5TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408097; c=relaxed/simple;
	bh=ID1WMcgGxPUf8qM8dYqSBbO75rAC9yjd+rGSHmHMbVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyUbawbEml6aYjviy4NUBkJ9/9jA6KUiwvjfr+yy5I6yl5ZT/PWSIHjsW8On5oRot1gPtyYqGiKIaNpXRJTQI8HhpameBcsAEo17qQIfB2dAG/0SUR7fXNyteWyNDw+lzyIH0ix0iW4OjHStdbqnlGE58/lzDiDZ56dLO9nAKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D6ADE361CF2EA; Sun,  5 Apr 2026 09:54:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Add tests for BPF function stack arguments
Date: Sun,  5 Apr 2026 09:54:43 -0700
Message-ID: <20260405165443.837652-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405165300.826241-1-yonghong.song@linux.dev>
References: <20260405165300.826241-1-yonghong.song@linux.dev>
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
 .../selftests/bpf/prog_tests/stack_arg.c      | 132 +++++++++++
 tools/testing/selftests/bpf/progs/stack_arg.c | 212 ++++++++++++++++++
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 164 ++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  65 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  20 +-
 5 files changed, 592 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/t=
esting/selftests/bpf/prog_tests/stack_arg.c
new file mode 100644
index 000000000000..1af5e5c91e0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "stack_arg.skel.h"
+#include "stack_arg_kfunc.skel.h"
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
+static void test_bpf2bpf(void)
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
+	run_subtest(skel->progs.test_bpf2bpf_ptr_stack_arg, 45);
+	run_subtest(skel->progs.test_bpf2bpf_mix_stack_args, 51);
+	run_subtest(skel->progs.test_bpf2bpf_nesting_stack_arg, 50);
+	run_subtest(skel->progs.test_bpf2bpf_dynptr_stack_arg, 69);
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
+	run_subtest(skel->progs.test_stack_arg_dynptr, 69);
+	run_subtest(skel->progs.test_stack_arg_mem, 151);
+	run_subtest(skel->progs.test_stack_arg_iter, 115);
+	run_subtest(skel->progs.test_stack_arg_const_str, 15);
+	run_subtest(skel->progs.test_stack_arg_timer, 15);
+
+out:
+	stack_arg_kfunc__destroy(skel);
+}
+
+void test_stack_arg(void)
+{
+	if (test__start_subtest("global_many_args"))
+		test_global_many();
+	if (test__start_subtest("async_cb_many_args"))
+		test_async_cb_many();
+	if (test__start_subtest("bpf2bpf"))
+		test_bpf2bpf();
+	if (test__start_subtest("kfunc"))
+		test_kfunc();
+}
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
new file mode 100644
index 000000000000..c6bf89c3a0db
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
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
+struct test_data {
+	long x;
+	long y;
+};
+
+/* 1 + 2 + 3 + 4 + 5 + 10 + 20 =3D 45 */
+__noinline static long func_with_ptr_stack_arg(long a, long b, long c, l=
ong d,
+					       long e, struct test_data *p)
+{
+	return a + b + c + d + e + p->x + p->y;
+}
+
+__noinline long global_ptr_stack_arg(long a, long b, long c, long d, lon=
g e)
+{
+	struct test_data data =3D { .x =3D 10, .y =3D 20 };
+
+	return func_with_ptr_stack_arg(a, b, c, d, e, &data);
+}
+
+SEC("tc")
+int test_bpf2bpf_ptr_stack_arg(void)
+{
+	return global_ptr_stack_arg(1, 2, 3, 4, 5);
+}
+
+/* 1 + 2 + 3 + 4 + 5 + 10 + 6 + 20 =3D 51 */
+__noinline static long func_with_mix_stack_args(long a, long b, long c, =
long d,
+						long e, struct test_data *p,
+						long f, struct test_data *q)
+{
+	return a + b + c + d + e + p->x + f + q->y;
+}
+
+__noinline long global_mix_stack_args(long a, long b, long c, long d, lo=
ng e)
+{
+	struct test_data p =3D { .x =3D 10 };
+	struct test_data q =3D { .y =3D 20 };
+
+	return func_with_mix_stack_args(a, b, c, d, e, &p, e + 1, &q);
+}
+
+SEC("tc")
+int test_bpf2bpf_mix_stack_args(void)
+{
+	return global_mix_stack_args(1, 2, 3, 4, 5);
+}
+
+/*
+ * Nesting test: func_outer calls func_inner, both with struct pointer
+ * as stack arg.
+ *
+ * func_inner: (a+1) + (b+1) + (c+1) + (d+1) + (e+1) + p->x + p->y
+ *           =3D 2 + 3 + 4 + 5 + 6 + 10 + 20 =3D 50
+ */
+__noinline static long func_inner_ptr(long a, long b, long c, long d,
+				      long e, struct test_data *p)
+{
+	return a + b + c + d + e + p->x + p->y;
+}
+
+__noinline static long func_outer_ptr(long a, long b, long c, long d,
+				      long e, struct test_data *p)
+{
+	return func_inner_ptr(a + 1, b + 1, c + 1, d + 1, e + 1, p);
+}
+
+__noinline long global_nesting_ptr(long a, long b, long c, long d, long =
e)
+{
+	struct test_data data =3D { .x =3D 10, .y =3D 20 };
+
+	return func_outer_ptr(a, b, c, d, e, &data);
+}
+
+SEC("tc")
+int test_bpf2bpf_nesting_stack_arg(void)
+{
+	return global_nesting_ptr(1, 2, 3, 4, 5);
+}
+
+/* 1 + 2 + 3 + 4 + 5 + sizeof(pkt_v4) =3D 15 + 54 =3D 69 */
+__noinline static long func_with_dynptr(long a, long b, long c, long d,
+					long e, struct bpf_dynptr *ptr)
+{
+	return a + b + c + d + e + bpf_dynptr_size(ptr);
+}
+
+__noinline long global_dynptr_stack_arg(void *ctx __arg_ctx, long a, lon=
g b,
+					long c, long d)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(ctx, 0, &ptr);
+	return func_with_dynptr(a, b, c, d, d + 1, &ptr);
+}
+
+SEC("tc")
+int test_bpf2bpf_dynptr_stack_arg(struct __sk_buff *skb)
+{
+	return global_dynptr_stack_arg(skb, 1, 2, 3, 4);
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
+int test_global_many_args(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_bpf2bpf_ptr_stack_arg(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_bpf2bpf_mix_stack_args(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_bpf2bpf_nesting_stack_arg(void)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_bpf2bpf_dynptr_stack_arg(struct __sk_buff *skb)
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
index 000000000000..6cc404d57863
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+struct bpf_iter_testmod_seq {
+	u64 :64;
+	u64 :64;
+};
+
+extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64=
 value, int cnt) __ksym;
+extern int *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) _=
_ksym;
+extern void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it=
) __ksym;
+
+struct timer_map_value {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_map_value);
+} kfunc_timer_map SEC(".maps");
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
+/* 1 + 2 + 3 + 4 + 5 + sizeof(pkt_v4) =3D 15 + 54 =3D 69 */
+SEC("tc")
+int test_stack_arg_dynptr(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	return bpf_kfunc_call_stack_arg_dynptr(1, 2, 3, 4, 5, &ptr);
+}
+
+/* 1 + 2 + 3 + 4 + 5 + (1 + 2 + ... + 16) =3D 15 + 136 =3D 151 */
+SEC("tc")
+int test_stack_arg_mem(struct __sk_buff *skb)
+{
+	char buf[16] =3D {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16=
};
+
+	return bpf_kfunc_call_stack_arg_mem(1, 2, 3, 4, 5, buf, sizeof(buf));
+}
+
+/* 1 + 2 + 3 + 4 + 5 + 100 =3D 115 */
+SEC("tc")
+int test_stack_arg_iter(struct __sk_buff *skb)
+{
+	struct bpf_iter_testmod_seq it;
+	u64 ret;
+
+	bpf_iter_testmod_seq_new(&it, 100, 10);
+	ret =3D bpf_kfunc_call_stack_arg_iter(1, 2, 3, 4, 5, &it);
+	bpf_iter_testmod_seq_destroy(&it);
+	return ret;
+}
+
+const char cstr[] =3D "hello";
+
+/* 1 + 2 + 3 + 4 + 5 =3D 15 */
+SEC("tc")
+int test_stack_arg_const_str(struct __sk_buff *skb)
+{
+	return bpf_kfunc_call_stack_arg_const_str(1, 2, 3, 4, 5, cstr);
+}
+
+/* 1 + 2 + 3 + 4 + 5 =3D 15 */
+SEC("tc")
+int test_stack_arg_timer(struct __sk_buff *skb)
+{
+	struct timer_map_value *val;
+	int key =3D 0;
+
+	val =3D bpf_map_lookup_elem(&kfunc_timer_map, &key);
+	if (!val)
+		return 0;
+	return bpf_kfunc_call_stack_arg_timer(1, 2, 3, 4, 5, &val->timer);
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
+SEC("tc")
+int test_stack_arg_dynptr(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_mem(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_iter(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_const_str(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int test_stack_arg_timer(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 061356f10093..4fcdb13e4a9a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -824,6 +824,63 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
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
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_dynptr(u64 a, u64 b, u64 c, u64=
 d, u64 e,
+					       struct bpf_dynptr *ptr)
+{
+	const struct bpf_dynptr_kern *kern_ptr =3D (void *)ptr;
+
+	return a + b + c + d + e + (kern_ptr->size & 0xFFFFFF);
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_mem(u64 a, u64 b, u64 c, u64 d,=
 u64 e,
+					     void *mem, int mem__sz)
+{
+	const unsigned char *p =3D mem;
+	u64 sum =3D a + b + c + d + e;
+	int i;
+
+	for (i =3D 0; i < mem__sz; i++)
+		sum +=3D p[i];
+	return sum;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_iter(u64 a, u64 b, u64 c, u64 d=
, u64 e,
+					      struct bpf_iter_testmod_seq *it__iter)
+{
+	return a + b + c + d + e + it__iter->value;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_const_str(u64 a, u64 b, u64 c, =
u64 d, u64 e,
+						   const char *str__str)
+{
+	return a + b + c + d + e;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_timer(u64 a, u64 b, u64 c, u64 =
d, u64 e,
+					       struct bpf_timer *timer)
+{
+	return a + b + c + d + e;
+}
+
 static struct prog_test_ref_kfunc prog_test_struct =3D {
 	.a =3D 42,
 	.b =3D 108,
@@ -1287,6 +1344,14 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_dynptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_iter)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_const_str)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_timer)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index aa0b8d41e71b..2c1cb118f886 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -26,6 +26,8 @@ struct prog_test_ref_kfunc {
 };
 #endif
=20
+struct bpf_iter_testmod_seq;
+
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -111,7 +113,23 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, _=
_u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
-
+__u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
+			       __u64 e, __u64 f, __u64 g, __u64 h) __ksym;
+__u64 bpf_kfunc_call_stack_arg_ptr(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_pass1 *p) __ksym;
+__u64 bpf_kfunc_call_stack_arg_mix(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_pass1 *p, __u64 f,
+				   struct prog_test_pass1 *q) __ksym;
+__u64 bpf_kfunc_call_stack_arg_dynptr(__u64 a, __u64 b, __u64 c, __u64 d=
, __u64 e,
+				      struct bpf_dynptr *ptr) __ksym;
+__u64 bpf_kfunc_call_stack_arg_mem(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   void *mem, int mem__sz) __ksym;
+__u64 bpf_kfunc_call_stack_arg_iter(__u64 a, __u64 b, __u64 c, __u64 d, =
__u64 e,
+				    struct bpf_iter_testmod_seq *it__iter) __ksym;
+__u64 bpf_kfunc_call_stack_arg_const_str(__u64 a, __u64 b, __u64 c, __u6=
4 d, __u64 e,
+					 const char *str__str) __ksym;
+__u64 bpf_kfunc_call_stack_arg_timer(__u64 a, __u64 b, __u64 c, __u64 d,=
 __u64 e,
+				     struct bpf_timer *timer) __ksym;
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
--=20
2.52.0

