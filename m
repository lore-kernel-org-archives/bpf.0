Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9A3043DE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641077; cv=none; b=ISlehlYmLAX+9Dw/3C0m44WWP7z95cZERo/9j0/tCOxJ7P9UCZxnr9L5MnHc5bYPPz5Vj+DNCV49AhrK/u9xrMAcvOQHLKJ/PTZ1g39QTWk5l0uPg5k6ebriKK/j7n6FMi3oY2JLFfFfpQNzA7C8tt6YMuO42TQptRbmYbveqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641077; c=relaxed/simple;
	bh=cK0iVwaSeW0kMbraQoua1GnZRAd9W/pJWDDmXxvxBY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGss5aBxGbnl4C/23GU3bPlRsScjzxFpsc08fwu0pnvIwe0a+JAB0W8rMV5wGHpA97qNaBONL1viI7o7Hlo8LaxMVoJFFl6hAgpPsjKg6YM2hveZBSqzJgInS/3Op8iG9oZEmJI3MxTyS6aFi2ApryQvRaysxDYxhjoAWX58vZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C4A402DE076A0F; Mon, 28 Sep 2026 17:17:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 19/22] selftests/bpf: Add end-to-end and negative .bpf_cleanup exception tests
Date: Mon, 28 Sep 2026 17:17:41 -0700
Message-ID: <20260929001741.3255990-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

C has no unwinding, so nothing here comes out of the frontend: the frames
that own a resource are written as __naked inline assembly, which spells
out by hand exactly what a frontend emits -- a call site bracketed by two
labels, a landing pad unreachable in the compiler's CFG, and a .bpf_clean=
up
record tying them together. The assembler turns ".long <text label>" into
the same R_BPF_64_NODYLD32 relocation the BPF AsmPrinter emits, so libbpf
and the kernel see an object indistinguishable from a compiler-generated
one.

Call chain: entry -> foo1 -> foo1v -> foo2 -> foo3. foo3 holds a
non-preemptible section and unwinds inside it; foo2 holds an RCU read loc=
k
and has two call sites sharing one pad, one of them its own unwind; foo1v
is a void frame whose pad ends in a jump to a resume block placed after a=
n
unrelated block that ends in a plain exit; foo1 owns nothing and gets no
record; entry is the boundary.

There are also the shapes the kernel refuses:

 - a catch pad, and a pad ambiguous between catch and cleanup
 - a table alongside bpf_throw() or a tagged exception callback
 - a subprogram that can unwind, used as a callback
 - a tail call, a BPF_LD_[ABS|IND] or a gotox in a pad
 - a second unwind while one is in flight, raised in the pad or below it
 - a resume outside a pad, and one in a subprogram the pad called
 - a kfunc stack argument in a pad
 - a jump into a pad from outside it
 - a pad inside another record's call-site range, and a record covering n=
o
   call that can unwind and whose pad nothing reaches
 - a frame leaving through an unwind holding what it did not hold when it
   was entered: a pad dropping a lock its frame never took, one forgettin=
g
   the lock it did take, a subprogram with no pad of its own leaving whil=
e
   it holds one, and a pad dropping a reference the frame never reserved
 - a pad-less unwind inside an RCU read-side region
 - a frame holding a lock or a reference across a call an unwind passes
   through with no record over it, in a subprogram's frame and in the mai=
n
   program's

The test skips rather than fails where the JIT cannot dispatch a landing
pad at all.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  27 +
 .../bpf/prog_tests/exceptions_cleanup.c       |  85 ++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 162 ++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 878 ++++++++++++++++++
 4 files changed, 1152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/exceptions_cleanup.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cle=
anup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
fail.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
new file mode 100644
index 000000000000..d1d40314035e
--- /dev/null
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef __EXCEPTIONS_CLEANUP_H__
+#define __EXCEPTIONS_CLEANUP_H__
+
+/* progs/exceptions_cleanup.c: one bit per frame that reports it ran. */
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
index 000000000000..255f88d35aad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "exceptions_cleanup.h"
+#include "exceptions_cleanup.skel.h"
+#include "exceptions_cleanup_fail.skel.h"
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
+	exceptions_cleanup__destroy(skel);
+
+	RUN_TESTS(exceptions_cleanup_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/too=
ls/testing/selftests/bpf/progs/exceptions_cleanup.c
new file mode 100644
index 000000000000..2b22a05a0ded
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -0,0 +1,162 @@
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
+		 * r0 at pad entry is whatever the walker leaves
+		 * there, carried across the call in a callee-saved
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
+__u64 never =3D 0;
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
+"4:"
+	"r0 =3D 0;"
+	"exit;"
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
+	"exit;"
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
+"9:"					/* shared resume block */
+	"call bpf_unwind_resume;"
+	"exit;"
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
+	"r1 =3D 0;"
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
index 000000000000..76cca8dc45a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
@@ -0,0 +1,878 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
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
+	"r1 =3D 1;"
+	"call bpf_unwind;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static int unwinding_cb(__u32 idx, void *ctx)
+{
+	bpf_unwind();
+	return 0;
+}
+
+static __used __naked __noinline __u64 cb_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call unwinding_cb;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("may unwind and is used as a callback")
+int callback_may_unwind(void *ctx)
+{
+	bpf_loop(1, unwinding_cb, NULL, 0);
+	return cb_frame();
+}
+
+/* A pad that reaches both a resume and a plain exit. */
+static __used __naked __noinline __u64 ambiguous_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"
+	"call bpf_preempt_disable;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad: two ways out */
+	"call bpf_preempt_enable;"
+	"if r6 > 10 goto 4f;"
+	"call bpf_unwind_resume;"
+	"exit;"
+"4:"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("a catch pad is not supported yet")
+int ambiguous_landing_pad(void *ctx)
+{
+	return ambiguous_pad_frame();
+}
+
+/* A second bpf_unwind() from inside a landing pad. */
+static __used __naked __noinline __u64 unwind_in_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_unwind;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad that unwinds again */
+	"call bpf_preempt_enable;"
+	"r1 =3D 2;"
+	"call bpf_unwind;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("starts a second unwind while one is in flight")
+int unwind_from_landing_pad(void *ctx)
+{
+	return unwind_in_pad_frame();
+}
+
+__noinline int unused_exc_cb(u64 cookie)
+{
+	return 0;
+}
+
+static __used __naked __noinline __u64 cb_and_table_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 9;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__exception_cb(unused_exc_cb)
+__failure __msg("cannot be combined with an exception callback")
+int table_with_exception_cb(void *ctx)
+{
+	return cb_and_table_frame();
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
+	"exit;"
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
+	"exit;"
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
+/*
+ * A pad calling a global subprogram that can throw. The throw is refuse=
d
+ * wherever it sits: the scan covers the subprograms too, not just the m=
ain
+ * program, so this never reaches the rules about pads.
+ */
+__noinline void pad_callee_that_throws(void)
+{
+	if (never)
+		bpf_throw(0);
+}
+
+static __used __naked __noinline __u64 pad_calls_thrower_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 11;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call pad_callee_that_throws;"	/* ...which can throw: refused */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("cannot be combined with bpf_throw")
+int pad_calls_thrower(void *ctx)
+{
+	return pad_calls_thrower_frame();
+}
+
+static __used __naked __noinline __u64 catch_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 12;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* catch pad: no resume, it stops here */
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is not supported yet, only cleanup pads that resume")
+int catch_landing_pad(void *ctx)
+{
+	return catch_pad_frame();
+}
+
+/* A bpf_unwind_resume() outside any landing pad. */
+static __used __naked __noinline __u64 stray_resume_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 13;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("is not in a landing pad")
+int resume_outside_pad(void *ctx)
+{
+	/* Never taken, but reachable, which is all the verifier needs. */
+	if (never)
+		bpf_unwind_resume(NULL);
+	return stray_resume_frame();
+}
+
+/* A bpf_unwind_resume() in a subprogram a landing pad calls. */
+static __used __naked __noinline void resume_in_callee(void)
+{
+	asm volatile (
+	"call bpf_unwind_resume;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 pad_calls_resumer_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 14;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"call resume_in_callee;"	/* ...which resumes: refused */
+	"call bpf_unwind_resume;"
+	"exit;"
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
+	"exit;"
+"5:"					/* second pad */
+	"call bpf_preempt_enable;"
+	"call bpf_unwind_resume;"
+	"exit;"
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
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm(bpf_tail_call), __imm_addr(tc_map)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("and is in a landing pad")
+int tail_call_in_pad(void *ctx)
+{
+	return tail_call_pad_frame();
+}
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+/*
+ * A kfunc by-value argument that runs past the argument registers, in a
+ * landing pad. The pad is not what refuses it. The C call gives the ext=
ern
+ * its BTF.
+ */
+static __used __noinline void __nofit_btf_anchor(void)
+{
+	struct prog_test_pair_arg s =3D {};
+
+	bpf_kfunc_call_test_pair_arg_nofit(1, 2, 3, 4, s);
+}
+
+static __used __naked __noinline __u64 kfunc_arg_pad_frame(void)
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
+	"call bpf_kfunc_call_test_pair_arg_nofit;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("stack arg1 is not initialized")
+int kfunc_stack_arg_in_pad(void *ctx)
+{
+	return kfunc_arg_pad_frame();
+}
+
+#endif /* __BPF_FEATURE_STACK_ARGUMENT */
+
+/* A landing pad entered by ordinary control flow, with no unwind in fli=
ght. */
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
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("runs both inside and outside a landing pad")
+int jump_into_pad(void *ctx)
+{
+	return jump_into_pad_frame();
+}
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+/*
+ * An indirect jump in a landing pad. A jump table entry is an offset fr=
om
+ * the program's section symbol, which has to be spelled in quotes here.
+ */
+static __used __naked __noinline void gotox_unwinder(void)
+{
+	asm volatile (
+	"r1 =3D 15;"
+	"call bpf_unwind;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("and is in a landing pad")
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
+"1:"	"call gotox_unwinder;"		/* cleanup region */
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
+	 * vmlinux.h rules out. dst_reg is the other nibble on a big-endian
+	 * target.
+	 */
+#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
+	".byte 0x0d, 0x20, 0, 0, 0, 0, 0, 0;"
+#else
+	".byte 0x0d, 0x02, 0, 0, 0, 0, 0, 0;"
+#endif
+"l0_%=3D:"
+	"call bpf_unwind_resume;"
+	"exit;"
+"l1_%=3D:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+#endif /* x86 || arm64 */
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
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?tc")
+__failure __msg("and is in a landing pad")
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
+ * unwind would rewrite the frames the first is walking.
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
+	"exit;"
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
+	"exit;"
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
+	"exit;"
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
+ * An unwind with no landing pad leaves the frame with nothing run on th=
e way
+ * out, so what the frame holds is checked as it would be at a plain exi=
t.
+ */
+SEC("?syscall")
+__failure __msg("an unwind with no landing pad cannot be used inside bpf=
_rcu_read_lock-ed region")
+int unwind_no_pad_rcu(void *ctx)
+{
+	bpf_rcu_read_lock();
+	bpf_unwind();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+/*
+ * A frame leaves through an unwind holding what it did not hold when it=
 was
+ * entered. The frames above it resume at pads whose state was taken at =
their
+ * call, so they would be wrong about it.
+ */
+static __used __naked __noinline __u64 pad_drops_caller_lock_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: drops a lock it never took */
+	"call bpf_rcu_read_unlock;"
+	"call bpf_unwind_resume;"
+	"exit;"
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
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("a resume does not leave the frame's bpf_rcu_read_lock s=
tate as it found it")
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
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("a resume does not leave the frame's bpf_rcu_read_lock s=
tate as it found it")
+int pad_keeps_own_lock(void *ctx)
+{
+	return pad_keeps_own_lock_frame();
+}
+
+/* And a subprog with no pad at all, leaving through an unwind holding o=
ne. */
+static __used __naked __noinline __u64 no_pad_keeps_own_lock_frame(void)
+{
+	asm volatile (
+	"call bpf_rcu_read_lock;"
+	"call bpf_unwind;"		/* no record covers it */
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure
+__msg("no landing pad does not leave the frame's bpf_rcu_read_lock state=
")
+int no_pad_keeps_own_lock(void *ctx)
+{
+	return no_pad_keeps_own_lock_frame();
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} unwind_ringbuf SEC(".maps");
+
+/*
+ * Always unwinds, so its caller is never returned to on the modelled pa=
th --
+ * which is what keeps the release below out of the caller's post-call c=
ode.
+ * Its pad discards the record the caller reserved.
+ */
+static __used __naked __noinline __u64 pad_drops_caller_ref_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"			/* the caller's reserved record */
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: drops what it never acquired */
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"call bpf_unwind_resume;"
+	"exit;"
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
+	"exit;"
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
+__failure __msg("a resume does not leave the frame's references as it fo=
und it")
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
+ * whatever it acquired is never released. It has to hold what it entere=
d with
+ * at every such call.
+ */
+static __used __naked __noinline __u64 pad_resumes_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad */
+	"call bpf_unwind_resume;"
+	"exit;"
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
+__failure
+__msg("through this call does not leave the frame's bpf_rcu_read_lock st=
ate")
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
+__failure __msg("an unwind through this call keeps the reference id=3D")
+int unwind_through_call_keeps_ref(void *ctx)
+{
+	return uncovered_holds_ref_frame();
+}
+
+/* The main program's frame is passed by the same way. */
+SEC("?syscall")
+__failure __msg("an unwind through this call keeps the reference id=3D")
+int unwind_through_call_main_keeps_ref(void *ctx)
+{
+	void *rec;
+
+	rec =3D bpf_ringbuf_reserve(&unwind_ringbuf, 8, 0);
+	if (!rec)
+		return 0;
+	pad_resumes_frame();		/* no record covers this call */
+	bpf_ringbuf_discard(rec, 0);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

