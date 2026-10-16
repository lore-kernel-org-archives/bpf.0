Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DE48DB4B
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175491; cv=none; b=ii2rzw4/DygCxNpn4lXBrybo8io9kiSaRFxbCS8rckveJr91GsCprC+RD52+rnLY1jhGRiI3Lslw3O38wDqdbYsoxuhpaBmRi9QyscakJKsnpUyu6ZmQiiEvQnodSheJhzuOyToX3HJvujvbZQ6JM4wXGxXm9XfTujKhAKO2gQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175491; c=relaxed/simple;
	bh=JXuBYIgL7CwHSH7wtpNNuYJ4s8d4EBdKARxYJC+OzLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZccesRVmcwLG6TPnglLtv/jjo7/H+Nz8Anpr5NcS1BbwYs/GtRzd402mvPwF8HmNxwlSM/gstLLtT/pezWuSyv8idMp99TIwpPfHkITLu0PY4r5TXzH1cPyNQHMHVzMTh5bshjbAn5zv8OT8zSvLj83QLEunKzPRDV+Ji6RBlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 98D4F31A0DB0A5; Fri, 16 Oct 2026 11:31:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: Test trampolines on more BPF functions with stack args
Date: Fri, 16 Oct 2026 11:31:25 -0700
Message-ID: <20261016183125.1136468-1-yonghong.song@linux.dev>
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

Add two functions to the BPF target program of the int128_tgt_prog test.

callee_split() takes a struct holding an __int128 after five u64s, so
on x86-64 it is passed split between r9 and the stack. fentry and fexit
programs check that the trampoline takes it from there and hands it back
there.

callee_unreliable() takes six u64-sized arguments, the first a plain
pointer, which makes its BTF unreliable while the sixth is still passed
on the stack. The new tgt_prog_unreliable subtest checks that an fentry
program cannot be attached to it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 62 +++++++++++++++++++
 .../bpf/progs/tracing_struct_int128_tgt.c     | 32 +++++++++-
 .../bpf/progs/tracing_struct_int128_tracer.c  | 27 ++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
index a02731bc6573..de358f335d98 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -194,9 +194,15 @@ static void test_int128_tgt_prog(void)
 							     "callee_stack");
 		err =3D err ?: bpf_program__set_attach_target(tracer->progs.stack_exit=
, fd,
 							     "callee_stack");
+		err =3D err ?: bpf_program__set_attach_target(tracer->progs.split_entr=
y, fd,
+							     "callee_split");
+		err =3D err ?: bpf_program__set_attach_target(tracer->progs.split_exit=
, fd,
+							     "callee_split");
 	} else {
 		bpf_program__set_autoload(tracer->progs.stack_entry, false);
 		bpf_program__set_autoload(tracer->progs.stack_exit, false);
+		bpf_program__set_autoload(tracer->progs.split_entry, false);
+		bpf_program__set_autoload(tracer->progs.split_exit, false);
 	}
 	if (!ASSERT_OK(err, "set_attach_target"))
 		goto out;
@@ -226,6 +232,13 @@ static void test_int128_tgt_prog(void)
 		ASSERT_EQ(tracer->bss->stack_i, 10, "stack:i");
 		ASSERT_EQ(tgt->bss->ret_stack, 385, "stack ret");
 		ASSERT_EQ(tracer->bss->stack_ret, 385, "stack fexit ret");
+
+		ASSERT_EQ(tracer->bss->split_e, 5, "split:e");
+		ASSERT_EQ(tracer->bss->split_lo, 8, "split:h.lo");
+		ASSERT_EQ(tracer->bss->split_hi, 9, "split:h.hi");
+		ASSERT_EQ(tracer->bss->split_i, 10, "split:i");
+		ASSERT_EQ(tgt->bss->ret_split, 246, "split ret");
+		ASSERT_EQ(tracer->bss->split_ret, 246, "split fexit ret");
 	}
=20
 out:
@@ -236,6 +249,53 @@ static void test_int128_tgt_prog(void)
 #endif
 }
=20
+/*
+ * A static function whose BTF is unreliable gets a trampoline that only=
 knows
+ * of the register arguments, so one taking stack arguments must be refu=
sed.
+ */
+static void test_tgt_prog_unreliable(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__)
+	struct tracing_struct_int128_tracer *tracer =3D NULL;
+	struct tracing_struct_int128_tgt *tgt;
+	char log_buf[4096] =3D {};
+	struct bpf_program *prog;
+	int err, fd;
+
+	tgt =3D tracing_struct_int128_tgt__open_and_load();
+	if (!ASSERT_OK_PTR(tgt, "tgt__open_and_load"))
+		return;
+	if (!tgt->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+	fd =3D bpf_program__fd(tgt->progs.run);
+
+	tracer =3D tracing_struct_int128_tracer__open();
+	if (!ASSERT_OK_PTR(tracer, "tracer__open"))
+		goto out;
+
+	bpf_object__for_each_program(prog, tracer->obj)
+		bpf_program__set_autoload(prog, false);
+	bpf_program__set_autoload(tracer->progs.unreliable_entry, true);
+	bpf_program__set_log_buf(tracer->progs.unreliable_entry, log_buf, sizeo=
f(log_buf));
+	err =3D bpf_program__set_attach_target(tracer->progs.unreliable_entry, =
fd,
+					     "callee_unreliable");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err =3D tracing_struct_int128_tracer__load(tracer);
+	ASSERT_ERR(err, "tracer__load");
+	ASSERT_HAS_SUBSTR(log_buf, "unreliable BTF and stack arguments", "log")=
;
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
@@ -328,6 +388,8 @@ void test_tracing_struct(void)
 		test_int128_args();
 	if (test__start_subtest("int128_tgt_prog"))
 		test_int128_tgt_prog();
+	if (test__start_subtest("tgt_prog_unreliable"))
+		test_tgt_prog_unreliable();
 	if (test__start_subtest("stack_arg_tailcall"))
 		test_stack_arg_tailcall();
 	if (test__start_subtest("union_args"))
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.=
c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
index 60e997470b59..2561422c25dd 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
@@ -8,7 +8,7 @@ struct int128_arg {
 };
=20
 __u64 base;
-__u64 ret_odd, ret_stack;
+__u64 ret_odd, ret_stack, ret_split, ret_unreliable;
=20
 #if defined(__clang__)
=20
@@ -46,6 +46,28 @@ static __noinline __u64 callee_stack(__u64 a, __u64 b,=
 __u64 c, __u64 d,
 	       i * 10;
 }
=20
+/*
+ * x86-64 BPF code passes h split between r9 and its first stack slot;
+ * arm64 passes it in x5 and x6, so nothing is split there.
+ */
+static __noinline __u64 callee_split(__u64 a, __u64 b, __u64 c, __u64 d,
+				     __u64 e, struct int128_arg h, __u64 i)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + (__u64)h.v * 6 +
+	       (__u64)((unsigned __int128)h.v >> 64) * 7 + i * 8;
+}
+
+/*
+ * A plain pointer makes the BTF of a static function unreliable, but f =
is
+ * still passed on the stack. The store keeps p a pointer.
+ */
+static __noinline __u64 callee_unreliable(__u64 *p, __u64 b, __u64 c, __=
u64 d,
+					  __u64 e, __u64 f)
+{
+	*p +=3D 1;
+	return *p + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
+}
+
 #else
=20
 const volatile bool has_stack_arg =3D false;
@@ -63,6 +85,14 @@ int run(void *ctx)
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 	ret_stack =3D callee_stack(base + 1, base + 2, base + 3, base + 4,
 				 base + 5, base + 6, base + 7, v, base + 10);
+	ret_split =3D callee_split(base + 1, base + 2, base + 3, base + 4,
+				 base + 5, v, base + 10);
+	{
+		__u64 x =3D base;
+
+		ret_unreliable =3D callee_unreliable(&x, base + 2, base + 3,
+						   base + 4, base + 5, base + 6);
+	}
 #endif
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_trac=
er.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
index 5843dc5af9cf..fc81c2eea4a8 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tracer.c
@@ -47,4 +47,31 @@ int stack_exit(unsigned long long *ctx)
 	return 0;
 }
=20
+long split_e, split_lo, split_hi, split_i, split_ret;
+
+SEC("fentry/callee_split")
+int BPF_PROG2(split_entry, __u64, a, __u64, b, __u64, c, __u64, d, __u64=
, e,
+	      struct int128_arg, h, __u64, i)
+{
+	split_e =3D e;
+	split_lo =3D (__u64)h.v;
+	split_hi =3D (unsigned __int128)h.v >> 64;
+	split_i =3D i;
+	return 0;
+}
+
+SEC("fexit/callee_split")
+int split_exit(unsigned long long *ctx)
+{
+	split_ret =3D ctx[8];
+	return 0;
+}
+
+/* Refused: the trampoline would lose the stack argument. */
+SEC("?fentry/callee_unreliable")
+int unreliable_entry(unsigned long long *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

