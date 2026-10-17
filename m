Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1F3BBA01
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205627; cv=none; b=lDvWIMrCNo1MD5H8L+3n1huUas8ijgj4XMXGMTK3kWu8fVVay8si6mzIorKKLzTIDIPYyfICmS68/g3LkNxnRbDOsxCVKVl328FHR5n1dYjeU7tMOaLBe5LtjGq6n8qTVrmKWKfatQ9cWnM+DDK8685pxVwQ/6tI9OZQ425K/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205627; c=relaxed/simple;
	bh=rAqOZ5VYdRQ4cYWfcdEADartMkntP24iCYH73Qo+T1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz0aZuAvNmRxg1KnzinMSThDZk13i5VRw2DPGsULxX67R9QCw07XuN9iMX4BTnvQRONsiZIo86sW0xhLf/vLdN+kM91yK0GiOVP0JlqyUiztpZWdTeGtiNfyaB9ZZE2Ky2h1XXLfmc5fa+KMXIppfbKIJEkgl9gRsDRs0YDziZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EF30F31B3B017E; Fri, 16 Oct 2026 19:53:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 22/25] selftests/bpf: Add end-to-end and negative .bpf_cleanup exception tests
Date: Fri, 16 Oct 2026 19:53:23 -0700
Message-ID: <20261017025323.1931599-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

C has no unwinding, so the frames that own a resource are written in
inline assembly, spelling out what a frontend emits: a call site between
two labels, a landing pad, and a .bpf_cleanup record tying them
together. Like a frontend, they mostly put nothing, or only a jump to
itself, after a direct call to bpf_unwind() or bpf_unwind_resume(); a
call to a subprog that always unwinds is still followed by the frame's
normal path.

The end-to-end test runs a five-frame call chain whose frames hold an
RCU read lock or have preemption disabled, unwinds it from different
frames, and checks which landing pads ran. It also checks that an fentry
program can attach to a subprog an unwind passes through and an fexit
program cannot.

The negative tests cover the shapes the kernel refuses: catch pads,
unsupported instructions or a second unwind in a pad, resumes outside a
pad, callbacks that can unwind, a table combined with bpf_throw() or an
exception callback, misplaced records, stale stack slots trusted by a
pad, and resources an unwind leaves held or drops twice.

The test skips where the JIT cannot dispatch landing pads.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  27 +
 .../bpf/prog_tests/exceptions_cleanup.c       | 140 ++++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 157 ++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 792 ++++++++++++++++++
 .../bpf/progs/exceptions_cleanup_tracing.c    |  26 +
 5 files changed, 1142 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/exceptions_cleanup.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cle=
anup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
tracing.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
new file mode 100644
index 000000000000..96effd2c1361
--- /dev/null
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef __EXCEPTIONS_CLEANUP_H__
+#define __EXCEPTIONS_CLEANUP_H__
+
+/* progs/exceptions_cleanup.c: one bit per function that reports it ran.=
 */
+#define RAN_FOO3_PREEMPT	0x1
+#define RAN_FOO2_RCU		0x2
+#define RAN_FOO1V_PREEMPT	0x4
+#define RAN_FOO2_DROP		0x8
+#define RAN_BUMP		0x10
+
+#define CLEANUP_REC(begin, end, landing_pad)			\
+	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
+	".long " begin ";"					\
+	".long " end ";"					\
+	".long " landing_pad ";"				\
+	".popsection;"
+
+/* Set a bit in @pads_ran. */
+#define PAD_RAN(bit)						\
+	"r1 =3D %[pads_ran] ll;"					\
+	"r2 =3D *(u64 *)(r1 + 0);"				\
+	"r2 |=3D " bit ";"					\
+	"*(u64 *)(r1 + 0) =3D r2;"
+
+#endif /* __EXCEPTIONS_CLEANUP_H__ */
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
new file mode 100644
index 000000000000..d8320ed3294f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "exceptions_cleanup.h"
+#include "exceptions_cleanup.skel.h"
+#include "exceptions_cleanup_fail.skel.h"
+#include "exceptions_cleanup_tracing.skel.h"
+
+/* foo3 unwound: every frame that has a pad ran it. */
+#define PADS_FOO3_UNWOUND \
+	(RAN_FOO3_PREEMPT | RAN_FOO2_RCU | RAN_FOO1V_PREEMPT | RAN_FOO2_DROP)
+
+/* foo2 unwound after foo3 returned normally: foo3's pad must not run. *=
/
+#define PADS_FOO2_UNWOUND \
+	(RAN_FOO2_RCU | RAN_FOO1V_PREEMPT | RAN_FOO2_DROP)
+
+static void run(struct exceptions_cleanup *skel, __u64 input, __u32 retv=
al,
+		__u64 pads)
+{
+	__u64 ctx =3D 0;
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in =3D &ctx,
+		    .ctx_size_in =3D sizeof(ctx),
+	);
+
+	skel->bss->input =3D input;
+	skel->bss->pads_ran =3D 0;
+	skel->bss->result =3D 0;
+
+	err =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.entry), &top=
ts);
+	if (!ASSERT_OK(err, "run"))
+		return;
+	ASSERT_EQ(topts.retval, retval, "retval");
+	/* bump() is not a landing pad; it sets its bit on every run. */
+	ASSERT_EQ(skel->bss->pads_ran, pads | RAN_BUMP, "pads_ran");
+}
+
+/*
+ * Tracing programs against foo1(), which an unwind passes through. fexi=
t
+ * keeps a trampoline frame between foo1() and its caller that the unwin=
d
+ * cannot walk past, so it is refused; fentry leaves none, so foo3 can s=
till
+ * unwind through foo1() with it attached.
+ */
+static void test_tracing(struct exceptions_cleanup *tgt)
+{
+	struct exceptions_cleanup_tracing *skel;
+	int tgt_fd =3D bpf_program__fd(tgt->progs.entry);
+	char log[8192] =3D {};
+	int err;
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		    .kernel_log_buf =3D log,
+		    .kernel_log_size =3D sizeof(log));
+
+	skel =3D exceptions_cleanup_tracing__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "tracer open"))
+		return;
+	bpf_program__set_autoload(skel->progs.fentry_unwinding_subprog, true);
+	err =3D bpf_program__set_attach_target(skel->progs.fentry_unwinding_sub=
prog,
+					     tgt_fd, "foo1");
+	if (!ASSERT_OK(err, "fentry target"))
+		goto out;
+	err =3D exceptions_cleanup_tracing__load(skel);
+	if (!ASSERT_OK(err, "fentry load"))
+		goto out;
+	err =3D exceptions_cleanup_tracing__attach(skel);
+	if (!ASSERT_OK(err, "fentry attach"))
+		goto out;
+	run(tgt, 101, 0, PADS_FOO3_UNWOUND);
+	ASSERT_EQ(skel->bss->fentry_hits, 1, "fentry_hits");
+	exceptions_cleanup_tracing__destroy(skel);
+
+	skel =3D exceptions_cleanup_tracing__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "tracer open"))
+		return;
+	bpf_program__set_autoload(skel->progs.fexit_unwinding_subprog, true);
+	err =3D bpf_program__set_attach_target(skel->progs.fexit_unwinding_subp=
rog,
+					     tgt_fd, "foo1");
+	if (!ASSERT_OK(err, "fexit target"))
+		goto out;
+	err =3D exceptions_cleanup_tracing__load(skel);
+	ASSERT_EQ(err, -EINVAL, "fexit load");
+	ASSERT_HAS_SUBSTR(log, "Cannot attach fexit, fmod_ret or fsession to fo=
o1",
+			  "fexit log");
+out:
+	exceptions_cleanup_tracing__destroy(skel);
+}
+
+void test_exceptions_cleanup(void)
+{
+	char log[8192] =3D {};
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		    .kernel_log_buf =3D log,
+		    .kernel_log_size =3D sizeof(log));
+	struct exceptions_cleanup *skel;
+	int err;
+
+	skel =3D exceptions_cleanup__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	err =3D exceptions_cleanup__load(skel);
+	if (err) {
+		if (err =3D=3D -EOPNOTSUPP &&
+		    strstr(log, "exception cleanup needs a JIT that can dispatch landi=
ng pads")) {
+			printf("%s:SKIP:JIT cannot dispatch exception cleanup landing pads\n"=
,
+			       __func__);
+			test__skip();
+		} else if (!ASSERT_OK(err, "load")) {
+			fprintf(stderr, "%s", log);
+		}
+		exceptions_cleanup__destroy(skel);
+		return;
+	}
+
+	/* No unwind: foo3 returns 1 ^ 1 =3D=3D 0, foo2 adds one, no pad runs. =
*/
+	if (test__start_subtest("no_unwind"))
+		run(skel, 1, 1, 0);
+
+	/* foo3 unwinds; every pad runs and entry returns zero. */
+	if (test__start_subtest("unwind_from_foo3"))
+		run(skel, 101, 0, PADS_FOO3_UNWOUND);
+
+	/*
+	 * foo3 returns 2 ^ 1 =3D=3D 3, so foo2 unwinds from its own second reg=
ion;
+	 * foo3's frame is long gone, so its pad must not run.
+	 */
+	if (test__start_subtest("unwind_from_foo2"))
+		run(skel, 2, 0, PADS_FOO2_UNWOUND);
+
+	if (test__start_subtest("tracing_unwinding_subprog"))
+		test_tracing(skel);
+
+	exceptions_cleanup__destroy(skel);
+
+	RUN_TESTS(exceptions_cleanup_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/too=
ls/testing/selftests/bpf/progs/exceptions_cleanup.c
new file mode 100644
index 000000000000..24523ee05acf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_unwind();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume(NULL);
+}
+
+__u64 input =3D 0;
+__u64 pads_ran =3D 0;
+__u64 result =3D 0;
+__u64 never =3D 0;
+
+static __used __noinline __u64 foo3(__u64 x)
+{
+	bpf_preempt_disable();
+	if (x > 100)
+		asm volatile (
+	"1:"	"call bpf_unwind;"		/* cleanup region */
+	"2:"
+		"goto 3f;"
+	"4:"					/* landing pad */
+		/*
+		 * r0 at pad entry is the zero the fixups put after the
+		 * bpf_unwind() call. It is kept in a callee-saved
+		 * register and handed to the resume, the way a
+		 * compiler-emitted pad passes the exception pointer to
+		 * _Unwind_Resume. The kfunc takes it and ignores it, and
+		 * the two pads below do without the shuffle.
+		 */
+		"r7 =3D r0;"
+		"call bpf_preempt_enable;"
+		PAD_RAN("%[ran]")
+		"r1 =3D r7;"
+		"call bpf_unwind_resume;"
+	"3:"
+		CLEANUP_REC("1b", "2b", "4b")
+		:
+		: [ran]"i"(RAN_FOO3_PREEMPT),
+		  __imm_addr(pads_ran)
+		: __clobber_all);
+	bpf_preempt_enable();
+	return x ^ 1;
+}
+
+static __used __naked __noinline void drop_glue(void)
+{
+	asm volatile (
+	PAD_RAN("%[ran]")
+	"exit;"
+	:
+	: [ran]"i"(RAN_FOO2_DROP), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 foo2(void)
+{
+	asm volatile (
+	"r6 =3D r1;"
+	"call bpf_rcu_read_lock;"
+	"r1 =3D r6;"
+"1:"	"call foo3;"			/* cleanup region #1 */
+"2:"
+	"r6 =3D r0;"
+	"if r6 =3D=3D 0 goto 5f;"
+"3:"	"call bpf_unwind;"		/* cleanup region #2 */
+"4:"	"goto 4b;"
+"5:"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D r6;"
+	"r0 +=3D 1;"
+	"exit;"
+"6:"					/* landing pad, shared by both regions */
+	"call drop_glue;"
+	"call bpf_rcu_read_unlock;"
+	PAD_RAN("%[ran_rcu]")
+	"call bpf_unwind_resume;"
+	"exit;"				/* never reached, kept for coverage */
+	CLEANUP_REC("1b", "2b", "6b")
+	CLEANUP_REC("3b", "4b", "6b")
+	:
+	: [ran_rcu]"i"(RAN_FOO2_RCU),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+static __used __naked __noinline void foo1v(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call foo2;"			/* cleanup region */
+"2:"
+	"r6 =3D r0;"
+	"call bpf_preempt_enable;"
+	"r1 =3D %[result] ll;"
+	"*(u64 *)(r1 + 0) =3D r6;"
+	"goto 7f;"
+"8:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"goto 9f;"
+"7:"					/* the frame's own exit block */
+	"r0 =3D 0;"
+	"exit;"
+"9:"					/* resume block, after the frame's exit */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "8b")
+	:
+	: [ran]"i"(RAN_FOO1V_PREEMPT), __imm_addr(input),
+	  __imm_addr(result), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * A frame with no cleanup record: an unwind leaving it runs no pad. The
+ * unwind never fires -- @never is global -- and the bit marks the retur=
n path.
+ */
+static __used __naked __noinline void bump(void)
+{
+	asm volatile (
+	PAD_RAN("%[ran]")
+	"r1 =3D %[never] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 =3D=3D 0 goto 1f;"
+	"call bpf_unwind;"
+"1:"
+	"exit;"				/* r0 deliberately left alone */
+	:
+	: [ran]"i"(RAN_BUMP), __imm_addr(never), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+__noinline __u64 foo1(void)
+{
+	bump();
+	foo1v();
+	return result;
+}
+
+SEC("syscall")
+int entry(void *ctx)
+{
+	return foo1();
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
new file mode 100644
index 000000000000..18d45395425f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
@@ -0,0 +1,792 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+__u64 input =3D 0;
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_throw(0);
+	bpf_unwind();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_unwind_resume(NULL);
+}
+
+/* An unwind raised in a callee, which is how a cleanup region gets one.=
 */
+static __used __naked __noinline __u64 inner_unwind(void)
+{
+	asm volatile (
+	"call bpf_unwind;"
+	::: __clobber_all);
+}
+
+static int unwinding_cb(__u32 idx, void *ctx)
+{
+	bpf_unwind();
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("may unwind and is used as a callback")
+int callback_may_unwind(void *ctx)
+{
+	bpf_loop(1, unwinding_cb, NULL, 0);
+	return 0;
+}
+
+__noinline int unused_exc_cb(u64 cookie)
+{
+	return 0;
+}
+
+/* A frame with a table and a pad, for tests whose refusal lies elsewher=
e. */
+static __used __naked __noinline __u64 table_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"				/* never reached, kept for coverage */
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__exception_cb(unused_exc_cb)
+__failure __msg("cannot be combined with an exception callback")
+int table_with_exception_cb(void *ctx)
+{
+	return table_frame();
+}
+
+/*
+ * A throw and a table, with no callback tagged: the default callback is
+ * appended too late to stand in for the throw, so the program is scanne=
d
+ * for one instead.
+ */
+static __used __naked __noinline __u64 throw_and_table_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("cannot be combined with bpf_throw")
+int table_with_throw(void *ctx)
+{
+	if (input)
+		bpf_throw(0);
+	return throw_and_table_frame();
+}
+
+__u64 never;
+
+/*
+ * A pad calling a global subprogram that can unwind. The subprogram is
+ * verified on its own, so the pad rule is what refuses it.
+ */
+__noinline void pad_callee_that_unwinds(void)
+{
+	if (never)
+		bpf_unwind();
+}
+
+static __used __naked __noinline __u64 pad_calls_unwinder_frame(void)
+{
+	asm volatile (
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call pad_callee_that_unwinds;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("which can unwind while an unwind is in flight")
+int pad_calls_unwinder(void *ctx)
+{
+	return pad_calls_unwinder_frame();
+}
+
+static __used __naked __noinline __u64 catch_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"	"goto 2b;"
+"3:"					/* catch pad: no resume, it stops here */
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("ends a landing pad: a catch pad is not supported yet")
+int catch_landing_pad(void *ctx)
+{
+	return catch_pad_frame();
+}
+
+/* A bpf_unwind_resume() outside any landing pad. */
+SEC("?syscall")
+__failure __msg("is not in a landing pad")
+int resume_outside_pad(void *ctx)
+{
+	/* Never taken, but reachable, which is all the verifier needs. */
+	if (never)
+		bpf_unwind_resume(NULL);
+	return table_frame();
+}
+
+/* A bpf_unwind_resume() in a subprogram a landing pad calls. */
+static __used __naked __noinline void resume_in_callee(void)
+{
+	asm volatile (
+	"call bpf_unwind_resume;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 pad_calls_resumer_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"	"goto 2b;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call resume_in_callee;"	/* ...which resumes: refused */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is not in a landing pad")
+int resume_in_pad_callee(void *ctx)
+{
+	return pad_calls_resumer_frame();
+}
+
+static __used __naked __noinline __u64 nested_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_unwind;"		/* first cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* first pad, second region's call */
+	"call bpf_preempt_enable;"
+"4:"
+	"call bpf_unwind_resume;"
+"5:"					/* second pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	CLEANUP_REC("3b", "4b", "5b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is inside the call-site range of")
+int nested_landing_pad(void *ctx)
+{
+	return nested_pad_frame();
+}
+
+/* A tail call in a landing pad: the frame would never reach its resume.=
 */
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} tc_map SEC(".maps");
+
+static __used __naked __noinline __u64 tail_call_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r1 =3D r6;"
+	"r2 =3D %[tc_map] ll;"
+	"r3 =3D 0;"
+	"call %[bpf_tail_call];"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm(bpf_tail_call), __imm_addr(tc_map)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is a tail call, which replaces the frame, and is in a l=
anding pad")
+int tail_call_in_pad(void *ctx)
+{
+	return tail_call_pad_frame();
+}
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+/*
+ * A pad reading an incoming stack argument after its own bpf_unwind(): =
the
+ * call clobbered the register the JIT keeps it in. Every parameter is u=
sed,
+ * so the caller passes them all, and summed before the call, so the pad=
's is
+ * the only stack argument load after it.
+ */
+static __used __noinline __u64 stack_arg_pad_frame(__u64 a, __u64 b, __u=
64 c,
+						   __u64 d, __u64 e, __u64 f)
+{
+	__u64 sum =3D a + b + c + d + e + f;
+
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"goto 4f;"
+"3:"					/* landing pad */
+	"r0 =3D *(u64 *)(r11 + 8);"
+	"call bpf_unwind_resume;"
+"4:"
+	CLEANUP_REC("1b", "2b", "3b")
+	: "+r"(sum) :: __clobber_common);
+	return sum;
+}
+
+SEC("?syscall")
+__failure __msg("r11 load must be before any r11 store or call insn")
+int stack_arg_load_in_pad(void *ctx)
+{
+	return stack_arg_pad_frame(1, 2, 3, 4, 5, 6);
+}
+
+#endif /* __BPF_FEATURE_STACK_ARGUMENT */
+
+/*
+ * A landing pad entered by ordinary control flow, with no unwind in fli=
ght:
+ * that path reaches the pad's resume outside a pad. Only the in_pad
+ * comparison in func_states_equal() keeps it from being pruned against =
the
+ * pad's own visit of that instruction.
+ */
+static __used __naked __noinline __u64 jump_into_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"if r6 > 7 goto 4f;"		/* an ordinary branch into the pad */
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+"4:"					/* ... and its second instruction */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is not in a landing pad")
+__flag(BPF_F_TEST_STATE_FREQ)
+int jump_into_pad(void *ctx)
+{
+	return jump_into_pad_frame();
+}
+
+#if defined(__clang__) && \
+	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64))
+
+/*
+ * An indirect jump in a landing pad. A jump table entry is an offset fr=
om
+ * the program's section symbol, which has to be spelled in quotes here.
+ */
+SEC("?syscall")
+__failure __msg("is an indirect jump")
+__naked void gotox_in_pad(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+"jt0_%=3D:"
+	".quad l0_%=3D - \"?syscall\";"
+	".quad l1_%=3D - \"?syscall\";"
+	".size jt0_%=3D, 16;"
+	".global jt0_%=3D;"
+	".popsection;"
+
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r1 =3D jt0_%=3D ll;"
+	"r1 +=3D 8;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	/*
+	 * gotox r2, as raw bytes: the mnemonic only reached the LLVM
+	 * assembler in llvm 22, and BPF_RAW_INSN() needs <linux/bpf.h>, which
+	 * vmlinux.h rules out.
+	 */
+	".byte 0x0d, 0x02, 0, 0, 0, 0, 0, 0;"
+"l0_%=3D:"
+	"call bpf_unwind_resume;"
+"l1_%=3D:"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+#endif /* __clang__ && (x86 || arm64) */
+
+/* A BPF_LD_[ABS|IND] in a pad: a failed load leaves without resuming. *=
/
+static __used __naked __noinline __u64 ld_abs_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"			/* the skb BPF_LD_ABS reads */
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r0 =3D *(u32 *)skb[0];"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?tc")
+__failure __msg("is a BPF_LD_[ABS|IND], which can leave through the epil=
ogue")
+__naked void ld_abs_in_pad(void)
+{
+	asm volatile (
+	"call ld_abs_pad_frame;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * A subprogram a landing pad calls, which unwinds on its own. The secon=
d
+ * unwind would rewrite return addresses the first has already redirecte=
d.
+ */
+static __used __naked __noinline __u64 own_pad_callee(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* its landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 pad_calls_own_pad_frame(void)
+{
+	asm volatile (
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad, which calls the above */
+	"call own_pad_callee;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("starts a second unwind while one is in flight")
+int unwind_in_pad_callee(void *ctx)
+{
+	return pad_calls_own_pad_frame();
+}
+
+/* A record whose range holds no call that can unwind. */
+static __used __naked __noinline __u64 nounwind_rec_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call bpf_preempt_enable;"	/* cleanup region: nounwind */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad, reached by nothing */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("unreachable insn")
+int nounwind_region(void *ctx)
+{
+	return nounwind_rec_frame();
+}
+
+/*
+ * An unwind with no landing pad in the main program returns from it, so=
 what
+ * it holds is checked there, as at a plain exit.
+ */
+SEC("?syscall")
+__failure __msg("bpf_unwind cannot be used inside bpf_rcu_read_lock-ed r=
egion")
+int unwind_no_pad_rcu(void *ctx)
+{
+	bpf_rcu_read_lock();
+	bpf_unwind();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+/*
+ * Lock and reference state is the program's, not a frame's: an unwind c=
arries
+ * it through every pad it runs, and what is still held when the main pr=
ogram
+ * returns is refused there. A pad that drops what its caller holds is f=
ine;
+ * the caller's own pad dropping it again is not.
+ */
+static __used __naked __noinline __u64 pad_drops_caller_lock_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"	"goto 2b;"
+"3:"					/* pad: drops a lock it never took */
+	"call bpf_rcu_read_unlock;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 caller_holds_lock_frame(void)
+{
+	asm volatile (
+	"call bpf_rcu_read_lock;"
+"1:"	"call pad_drops_caller_lock_frame;"
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad */
+	"call bpf_rcu_read_unlock;"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("unmatched rcu read unlock")
+int pad_drops_caller_lock(void *ctx)
+{
+	return caller_holds_lock_frame();
+}
+
+/* The other way round: a pad that does not drop what its own frame took=
. */
+static __used __naked __noinline __u64 pad_keeps_own_lock_frame(void)
+{
+	asm volatile (
+	"call bpf_rcu_read_lock;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: forgets the unlock */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("bpf_unwind cannot be used inside bpf_rcu_read_lock-ed r=
egion")
+int pad_keeps_own_lock(void *ctx)
+{
+	return pad_keeps_own_lock_frame();
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} unwind_ringbuf SEC(".maps");
+
+/*
+ * Always unwinds, so its caller is never returned to on the modelled pa=
th,
+ * and the caller's post-call code, which never releases the record, is =
not
+ * walked. Its pad discards the record the caller reserved.
+ */
+static __used __naked __noinline __u64 pad_drops_caller_ref_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"			/* the caller's reserved record */
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"	"goto 2b;"
+"3:"					/* pad: drops what it never acquired */
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+/* And this frame's own pad drops it a second time. */
+static __used __naked __noinline __u64 caller_holds_ref_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[unwind_ringbuf] ll;"
+	"r2 =3D 8;"
+	"r3 =3D 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 =3D=3D 0 goto 9f;"
+	"r6 =3D r0;"
+	"r1 =3D r6;"
+"1:"	"call pad_drops_caller_ref_frame;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad */
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"call bpf_unwind_resume;"
+"9:"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),
+	  __imm_addr(unwind_ringbuf)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("R1 type=3Dscalar expected=3Dringbuf_mem")
+int pad_drops_caller_ref(void *ctx)
+{
+	return caller_holds_ref_frame();
+}
+
+/*
+ * A frame an unwind returns through without a pad is abandoned where it=
 made
+ * the call: the JIT sends it to its epilogue, so nothing of it runs aga=
in and
+ * whatever it acquired is never released -- which the main program's ex=
it
+ * then finds still held.
+ */
+static __used __naked __noinline __u64 pad_resumes_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"	"goto 2b;"
+"3:"					/* pad */
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 uncovered_holds_lock_frame(void)
+{
+	asm volatile (
+	"call bpf_rcu_read_lock;"
+	"call pad_resumes_frame;"	/* no record covers this call */
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("bpf_unwind cannot be used inside bpf_rcu_read_lock-ed r=
egion")
+int unwind_through_call_keeps_lock(void *ctx)
+{
+	return uncovered_holds_lock_frame();
+}
+
+static __used __naked __noinline __u64 uncovered_holds_ref_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[unwind_ringbuf] ll;"
+	"r2 =3D 8;"
+	"r3 =3D 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 =3D=3D 0 goto 9f;"
+	"r6 =3D r0;"
+	"call pad_resumes_frame;"	/* no record covers this call */
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+"9:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),
+	  __imm_addr(unwind_ringbuf)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("Unreleased reference id=3D")
+int unwind_through_call_keeps_ref(void *ctx)
+{
+	return uncovered_holds_ref_frame();
+}
+
+/*
+ * A callee writes its caller's stack through a pointer argument, then
+ * unwinds. The caller's pad runs after that write, so it cannot keep tr=
usting
+ * the slot to hold the zero it held at the call.
+ */
+static __used __naked __noinline __u64 stack_writer(void)
+{
+	asm volatile (
+	"r2 =3D 0x10000000;"
+	"*(u64 *)(r1 + 0) =3D r2;"	/* r1 is the caller's fp-8 */
+	"call bpf_unwind;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 stale_stack_frame(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r6;"
+	"*(u64 *)(r10 - 64) =3D r6;"
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+"1:"	"call stack_writer;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: fp-8 as an offset into fp-64 */
+	"r1 =3D *(u64 *)(r10 - 8);"
+	"r2 =3D r10;"
+	"r2 +=3D -64;"
+	"r2 +=3D r1;"
+	"r0 =3D *(u8 *)(r2 + 0);"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("invalid read from stack R2 off=3D268435392 size=3D1")
+int stale_stack_pad(void *ctx)
+{
+	return stale_stack_frame();
+}
+
+/* The same through a global subprog, which is not walked from its calle=
r. */
+__noinline int global_stack_writer(__u64 *p)
+{
+	if (!p)
+		return 0;
+	*p =3D 0x10000000;
+	bpf_unwind();
+	return 0;
+}
+
+static __used __naked __noinline __u64 global_stale_stack_frame(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r6;"
+	"*(u64 *)(r10 - 64) =3D r6;"
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+"1:"	"call global_stack_writer;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: fp-8 as an offset into fp-64 */
+	"r1 =3D *(u64 *)(r10 - 8);"
+	"r2 =3D r10;"
+	"r2 +=3D -64;"
+	"r2 +=3D r1;"
+	"r0 =3D *(u8 *)(r2 + 0);"
+	"call bpf_unwind_resume;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("math between fp pointer and register with unbounded min=
 value")
+int global_stale_stack_pad(void *ctx)
+{
+	return global_stale_stack_frame();
+}
+
+/* gcc has no indirect calls, and only these JITs emit them */
+#if defined(__clang__) && \
+	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64))
+
+/*
+ * A callback calling an unwinding subprog through a pointer it read fro=
m its
+ * caller's stack: it neither calls nor takes the address of inner_unwin=
d, so
+ * only the marking of every subprog with a callx makes it might_unwind.
+ */
+static __used __naked __noinline int callx_cb(void)
+{
+	asm volatile (
+	"r1 =3D *(u64 *)(r2 + 0);"
+	"callx r1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("may unwind and is used as a callback")
+__naked int callback_callx_may_unwind(void)
+{
+	asm volatile (
+	"r1 =3D %[inner_unwind] ll;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r1 =3D 1;"
+	"r2 =3D %[callx_cb] ll;"
+	"r3 =3D r10;"
+	"r3 +=3D -8;"
+	"r4 =3D 0;"
+	"call %[bpf_loop];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(inner_unwind), __imm_addr(callx_cb), __imm(bpf_loop)
+	: __clobber_all);
+}
+
+#endif /* __clang__ && (x86 || arm64) */
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_tracing=
.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_tracing.c
new file mode 100644
index 000000000000..9fbc06d0bec4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_tracing.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/*
+ * Tracing programs aimed at foo1() of progs/exceptions_cleanup.c, a sub=
prog
+ * an unwind passes through. The attach target is set at load time.
+ */
+SEC("?fexit")
+int BPF_PROG(fexit_unwinding_subprog)
+{
+	return 0;
+}
+
+int fentry_hits;
+
+SEC("?fentry")
+int BPF_PROG(fentry_unwinding_subprog)
+{
+	fentry_hits++;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

