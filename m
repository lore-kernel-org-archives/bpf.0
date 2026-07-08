Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FBD3E5562
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541450; cv=none; b=O6cmnGc5SxTKJ3phYBfx6aLivkWHl3kGmY+8TSfUxz36mCyjYq7tI9wO4UeAp+FUmdh7j5uLVjEk/vpZL5ee7sLnaa5FKSMG3W+i1GRR7ws1O+yl9qUBc0+CQGe2iNvPPbnYKkByFBnpjMn5r8a+jyj0zadD0qjNzluazouziqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541450; c=relaxed/simple;
	bh=j7E3vSvVZTDL03b/uid7glR4UEwGM8TyS2TT18wwsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik42PcP/5YqcDyf/Sk3l3CZ03GIKcr3Kghvmp98aO3JFJ6kl7s7pgoO9v7uLfwWgsobeH6xYU7K4jf54UYrJegmwIeEgtNIzL0NlVKqVomT6cO5a9qwSvdejnYX1WFW+N1jbLGMX+XBOdLTErYuZuQaOJiwIg18c2wfNeAbuoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 22EBC1D0B6F9FB; Wed,  8 Jul 2026 13:10:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 11/12] selftests/bpf: Cover tracing on >8 and <=16 byte return targets
Date: Wed,  8 Jul 2026 13:10:36 -0700
Message-ID: <20260708201036.2162000-1-yonghong.song@linux.dev>
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

Tracing attach types differ in whether they need the target's return valu=
e
preserved across the BPF trampoline, which saves and restores only 8 byte=
s
of it. fentry runs before the target returns and never observes the retur=
n
value, so it can attach to a function returning a >8 byte value; fexit,
fmod_ret and fsession read the return value and must keep rejecting such =
a
target.

Add fentry, fexit, fentry_multi and fexit_multi tests that attach to
functions returning a >8 and <=3D16 byte value (a 16-byte struct and an
__int128).

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  | 128 ++++++++++++++++++
 .../selftests/bpf/progs/aggregate_ret_trace.c |  44 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  32 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   5 +
 4 files changed, 209 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_trace=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index 2f1e5c704959..7caf815a2c06 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -8,6 +8,7 @@
 #include "aggregate_ret_run.skel.h"
 #include "aggregate_ret_func.skel.h"
 #include "aggregate_ret_kfunc.skel.h"
+#include "aggregate_ret_trace.skel.h"
=20
 /*
  * Run one program and check its result. The program returns 0 on succes=
s, or
@@ -37,6 +38,131 @@ static void run_prog(struct bpf_program *prog, bool m=
ay_skip)
 	ASSERT_EQ(topts.retval, 0, "aggregate_ret_result");
 }
=20
+/*
+ * Multi-attach (BPF_TRACE_*_MULTI) requires CONFIG_HAVE_SINGLE_FTRACE_D=
IRECT_OPS,
+ * which today only x86_64 selects. Otherwise bpf_tracing_multi_attach()=
 returns
+ * -EOPNOTSUPP unconditionally.
+ */
+static bool tracing_multi_supported(struct bpf_program *prog)
+{
+	const char *small_pat =3D "bpf_testmod:bpf_testmod_trampoline_count_tes=
t";
+	struct bpf_link *link;
+
+	link =3D bpf_program__attach_tracing_multi(prog, small_pat, NULL);
+	if (libbpf_get_error(link) =3D=3D -EOPNOTSUPP)
+		return false;
+	bpf_link__destroy(link);
+	return true;
+}
+
+static void test_tracing_attach_types(void)
+{
+	const char *i128_pat =3D "bpf_testmod:bpf_testmod_aggregate_ret_i128_fn=
";
+	int err;
+
+	if (test__start_subtest("trace_fentry")) {
+		struct aggregate_ret_trace *trace =3D NULL;
+
+		trace =3D aggregate_ret_trace__open();
+		if (!ASSERT_OK_PTR(trace, "trace_fentry_open"))
+			return;
+
+		bpf_program__set_autoload(trace->progs.fexit_bpf_testmod_aggregate_ret=
_fn, false);
+		bpf_program__set_autoload(trace->progs.fentry_multi, false);
+		bpf_program__set_autoload(trace->progs.fexit_multi, false);
+
+		err =3D aggregate_ret_trace__load(trace);
+		if (!ASSERT_OK(err, "trace_fentry_load"))
+			goto destroy_trace_fentry;
+
+		err =3D aggregate_ret_trace__attach(trace);
+		if (!ASSERT_OK(err, "trace_fentry_attach"))
+			goto destroy_trace_fentry;
+
+		ASSERT_OK(trigger_module_test_read(1), "trace_fentry_trigger");
+		ASSERT_EQ(trace->bss->fentry_hit, 1, "trace_fentry_hit");
+
+destroy_trace_fentry:
+		aggregate_ret_trace__destroy(trace);
+	}
+
+	if (test__start_subtest("trace_fexit_reject")) {
+		struct aggregate_ret_trace *trace =3D NULL;
+
+		trace =3D aggregate_ret_trace__open();
+		if (!ASSERT_OK_PTR(trace, "trace_fexit_open"))
+			return;
+
+		bpf_program__set_autoload(trace->progs.fentry_bpf_testmod_aggregate_re=
t_fn, false);
+		bpf_program__set_autoload(trace->progs.fentry_multi, false);
+		bpf_program__set_autoload(trace->progs.fexit_multi, false);
+
+		err =3D aggregate_ret_trace__load(trace);
+		ASSERT_EQ(err, -EOPNOTSUPP, "trace_fexit_load");
+
+		aggregate_ret_trace__destroy(trace);
+	}
+
+	if (test__start_subtest("trace_fentry_multi")) {
+		struct aggregate_ret_trace *trace =3D NULL;
+		struct bpf_link *link;
+
+		trace =3D aggregate_ret_trace__open();
+		if (!ASSERT_OK_PTR(trace, "trace_fentry_multi_open"))
+			return;
+
+		bpf_program__set_autoload(trace->progs.fentry_bpf_testmod_aggregate_re=
t_fn, false);
+		bpf_program__set_autoload(trace->progs.fexit_bpf_testmod_aggregate_ret=
_fn, false);
+		bpf_program__set_autoload(trace->progs.fexit_multi, false);
+
+		if (!ASSERT_OK(aggregate_ret_trace__load(trace), "trace_fentry_multi_l=
oad"))
+			goto destroy_fentry_multi;
+
+		if (!tracing_multi_supported(trace->progs.fentry_multi)) {
+			test__skip();
+			goto destroy_fentry_multi;
+		}
+
+		link =3D bpf_program__attach_tracing_multi(trace->progs.fentry_multi, =
i128_pat, NULL);
+		if (!ASSERT_OK_PTR(link, "trace_fentry_multi_attach"))
+			goto destroy_fentry_multi;
+
+		ASSERT_OK(trigger_module_test_read(1), "trace_fentry_multi_trigger");
+		ASSERT_EQ(trace->bss->fentry_multi_hit, 1, "trace_fentry_multi_hit");
+
+		bpf_link__destroy(link);
+destroy_fentry_multi:
+		aggregate_ret_trace__destroy(trace);
+	}
+
+	if (test__start_subtest("trace_fexit_multi_reject")) {
+		struct aggregate_ret_trace *trace =3D NULL;
+		struct bpf_link *link;
+
+		trace =3D aggregate_ret_trace__open();
+		if (!ASSERT_OK_PTR(trace, "trace_fexit_multi_open"))
+			return;
+
+		bpf_program__set_autoload(trace->progs.fentry_bpf_testmod_aggregate_re=
t_fn, false);
+		bpf_program__set_autoload(trace->progs.fexit_bpf_testmod_aggregate_ret=
_fn, false);
+		bpf_program__set_autoload(trace->progs.fentry_multi, false);
+
+		if (!ASSERT_OK(aggregate_ret_trace__load(trace), "trace_fexit_multi_lo=
ad"))
+			goto destroy_fexit_multi;
+
+		if (!tracing_multi_supported(trace->progs.fexit_multi)) {
+			test__skip();
+			goto destroy_fexit_multi;
+		}
+
+		link =3D bpf_program__attach_tracing_multi(trace->progs.fexit_multi, i=
128_pat, NULL);
+		ASSERT_EQ(libbpf_get_error(link), -EOPNOTSUPP, "trace_fexit_multi_reje=
ct");
+		bpf_link__destroy(link);
+destroy_fexit_multi:
+		aggregate_ret_trace__destroy(trace);
+	}
+}
+
 void test_aggregate_ret(void)
 {
 	struct aggregate_ret_struct_c *skel_struct_c;
@@ -118,4 +244,6 @@ void test_aggregate_ret(void)
=20
 	RUN_TESTS(aggregate_ret_func);
 	RUN_TESTS(aggregate_ret_kfunc);
+
+	test_tracing_attach_types();
 }
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_trace.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_trace.c
new file mode 100644
index 000000000000..ff9fd4036121
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_trace.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_testmod_aggregate_ret {
+	__u64 lo;
+	__u64 hi;
+};
+
+int fentry_hit;
+int fexit_hit;
+int fentry_multi_hit;
+
+SEC("fentry/bpf_testmod:bpf_testmod_aggregate_ret_fn")
+int BPF_PROG2(fentry_bpf_testmod_aggregate_ret_fn, __u64, lo, __u64, hi)
+{
+	fentry_hit++;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod:bpf_testmod_aggregate_ret_fn")
+int BPF_PROG2(fexit_bpf_testmod_aggregate_ret_fn, __u64, lo, __u64, hi,
+	      struct bpf_testmod_aggregate_ret, ret)
+{
+	fexit_hit +=3D ret.lo =3D=3D lo && ret.hi =3D=3D hi;
+	return 0;
+}
+
+SEC("fentry.multi/bpf_testmod:bpf_testmod_aggregate_ret_i128_fn")
+int BPF_PROG(fentry_multi)
+{
+	fentry_multi_hit++;
+	return 0;
+}
+
+SEC("fexit.multi/bpf_testmod:bpf_testmod_aggregate_ret_i128_fn")
+int BPF_PROG(fexit_multi)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index c9e211d8a719..b558c538400e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -469,12 +469,34 @@ noinline void bpf_testmod_stacktrace_test_1(void)
 }
=20
 int bpf_testmod_fentry_ok;
+u64 bpf_testmod_aggregate_ret_seen;
=20
 noinline int bpf_testmod_trampoline_count_test(void)
 {
 	return 0;
 }
=20
+__noclone noinline struct bpf_testmod_aggregate_ret
+bpf_testmod_aggregate_ret_fn(u64 lo, u64 hi)
+{
+	struct bpf_testmod_aggregate_ret ret =3D {
+		.lo =3D lo,
+		.hi =3D hi,
+	};
+
+	bpf_testmod_aggregate_ret_seen +=3D lo + hi;
+	return ret;
+}
+
+__noclone noinline __int128
+bpf_testmod_aggregate_ret_i128_fn(u64 lo, u64 hi)
+{
+	__int128 ret =3D ((__int128)hi << 64) | lo;
+
+	bpf_testmod_aggregate_ret_seen +=3D lo + hi;
+	return ret;
+}
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -492,6 +514,8 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
 	struct bpf_testmod_struct_arg_5 struct_arg5 =3D {23, 24, 25, 26};
 	union bpf_testmod_union_arg_1 union_arg1 =3D { .arg =3D {1} };
 	union bpf_testmod_union_arg_2 union_arg2 =3D { .arg =3D {2, 3} };
+	struct bpf_testmod_aggregate_ret agg_ret;
+	__int128 agg_i128;
 	int i =3D 1;
=20
 	while (bpf_testmod_return_ptr(i))
@@ -534,6 +558,14 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
=20
 	trace_bpf_testmod_test_nullable_bare_tp(NULL);
=20
+	agg_ret =3D bpf_testmod_aggregate_ret_fn(len, off);
+	if (agg_ret.lo =3D=3D U64_MAX && agg_ret.hi =3D=3D U64_MAX)
+		goto out;
+
+	agg_i128 =3D bpf_testmod_aggregate_ret_i128_fn(len, off);
+	if (agg_i128 =3D=3D (__int128)-1)
+		goto out;
+
 	/* Magic number to enable writable tp */
 	if (len =3D=3D 64) {
 		struct bpf_testmod_test_writable_ctx writable =3D {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 863fd10f1619..4dcbfd64de62 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -25,6 +25,11 @@ struct bpf_testmod_test_writable_ctx {
 	int val;
 };
=20
+struct bpf_testmod_aggregate_ret {
+	__u64 lo;
+	__u64 hi;
+};
+
 /* BPF iter that returns *value* *n* times in a row */
 struct bpf_iter_testmod_seq {
 	s64 value;
--=20
2.53.0-Meta

