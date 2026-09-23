Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCF260580
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139628; cv=none; b=V6qIXCe5Swf59/cWkf9RNOMKuwbT0m2arByQCJ5dcNng3KsMMQvXv33ALp3oF7+MV2uH6olgvXCIm/eqNPxiOmMFUb/rfnRwi/Lcf6paLcokrk9y0EUC+G+6x1fD/wR1QUkQKMxTLKf1qLTasbU+R11zI/YOzriO1ZUoBJqOpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139628; c=relaxed/simple;
	bh=Ba7kjMtLgamv9FoIpxTLwKXgXqy3vIdLHAMN0UhfEJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkj67bRKEp1enCjClIN0L0bLTLmvdmFkyzSLRJj4fjoSqJVkMS5kLJ0A7lgbXk6lRDCG11U2UOzr0sCMAqqcXaVN9oJld2WEPFClsFPoUtFeKA9uLDdKArcdsKi0lsKVIC+h6yTHcz4WvFJss/T1EpdMHGmzKrauHcX0U13lpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1B4212C8DADC0C; Tue, 22 Sep 2026 22:00:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 19/21] selftests/bpf: Add an end-to-end .bpf_cleanup exception test
Date: Tue, 22 Sep 2026 22:00:24 -0700
Message-ID: <20260923050024.2427021-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
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
non-preemptible section and throws inside it; foo2 holds an RCU read lock
and has two call sites sharing one pad, one of them its own throw; foo1v =
is
a void frame whose pad ends in a jump to a resume block placed after an
unrelated block that ends in a plain exit; foo1 owns nothing and gets no
record; entry is the boundary.

There are also some shapes the kernel refuses -- the ones with no correct
answer, and the ones a pad running on the bpf_throw() walker's stack cann=
ot
express -- plus the return-value rejection that delivering an exception a=
t
the boundary of a program type which constrains its return value produces=
.
The test skips rather than fails where the JIT cannot dispatch a landing
pad at all.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  29 +
 .../bpf/prog_tests/exceptions_cleanup.c       | 128 ++++
 .../selftests/bpf/progs/exceptions_cleanup.c  | 164 +++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 678 ++++++++++++++++++
 4 files changed, 999 insertions(+)
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
index 000000000000..630d2e207119
--- /dev/null
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#ifndef __EXCEPTIONS_CLEANUP_H__
+#define __EXCEPTIONS_CLEANUP_H__
+
+#define THROW_COOKIE		0x100
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
index 000000000000..d9823023ec04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "exceptions_cleanup.h"
+#include "exceptions_cleanup.skel.h"
+#include "exceptions_cleanup_fail.skel.h"
+
+/* foo3 threw: every frame that has a pad ran it. */
+#define PADS_FOO3_THREW \
+	(RAN_FOO3_PREEMPT | RAN_FOO2_RCU | RAN_FOO1V_PREEMPT | RAN_FOO2_DROP)
+
+/* foo2 threw after foo3 returned normally: foo3's pad must not run. */
+#define PADS_FOO2_THREW \
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
+ * A table with more records than the program has instructions: no valid=
 one
+ * can look like that, and it is refused before the kernel allocates for=
 it.
+ */
+static void test_cleanup_info_cnt(void)
+{
+	struct bpf_insn insns[] =3D {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_cleanup_info rec =3D {
+		.begin_off =3D 0,
+		.end_off =3D 1,
+		.landing_pad_off =3D 1,
+	};
+	char log[512] =3D {};
+
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .log_buf =3D log,
+		    .log_size =3D sizeof(log),
+		    .log_level =3D 1,
+		    .cleanup_info =3D &rec,
+		    .cleanup_info_cnt =3D 1 << 20,
+		    .cleanup_info_rec_size =3D sizeof(rec));
+	int fd;
+
+	fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
+			   insns, ARRAY_SIZE(insns), &opts);
+	if (!ASSERT_LT(fd, 0, "load")) {
+		close(fd);
+		return;
+	}
+	/*
+	 * Turned away on the count, rather than on whatever the records past
+	 * the one below happen to hold.
+	 */
+	ASSERT_HAS_SUBSTR(log, "cleanup info has 1048576 records for 2 instruct=
ions",
+			  "log");
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
+	/* No throw: foo3 returns 1 ^ 1 =3D=3D 0, foo2 adds one, no pad runs. *=
/
+	if (test__start_subtest("no_throw"))
+		run(skel, 1, 1, 0);
+
+	/* foo3 throws; every pad runs and the cookie is delivered at entry. */
+	if (test__start_subtest("throw_from_foo3"))
+		run(skel, 101, THROW_COOKIE, PADS_FOO3_THREW);
+
+	/*
+	 * foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second regi=
on;
+	 * foo3's frame is long gone, so its pad must not run.
+	 */
+	if (test__start_subtest("throw_from_foo2"))
+		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
+
+	exceptions_cleanup__destroy(skel);
+
+	RUN_TESTS(exceptions_cleanup_fail);
+
+	if (test__start_subtest("cleanup_info_cnt"))
+		test_cleanup_info_cnt();
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup.c b/too=
ls/testing/selftests/bpf/progs/exceptions_cleanup.c
new file mode 100644
index 000000000000..3b7966357912
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "exceptions_cleanup.h"
+
+static __used __noinline void __kfunc_btf_anchor(void)
+{
+	bpf_throw(0);
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume();
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
+		"r1 =3D %[cookie];"
+	"1:"	"call bpf_throw;"		/* cleanup region */
+	"2:"
+		"goto 3f;"
+	"4:"					/* landing pad */
+		/*
+		 * r0 at pad entry is whatever the walker leaves
+		 * there, carried across the call in a callee-saved
+		 * register and handed to the resume, the way a
+		 * compiler-emitted pad passes the exception pointer to
+		 * _Unwind_Resume. The kfunc ignores it, and the two pads
+		 * below do without the shuffle.
+		 */
+		"r7 =3D r0;"
+		"call bpf_preempt_enable;"
+		PAD_RAN("%[ran]")
+		"r1 =3D r7;"
+		"call bpf_unwind_resume;"
+	"3:"
+		CLEANUP_REC("1b", "2b", "4b")
+		:
+		: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_FOO3_PREEMPT),
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
+	"r1 =3D %[cookie];"
+"3:"	"call bpf_throw;"		/* cleanup region #2 */
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
+	: [cookie]"i"(THROW_COOKIE), [ran_rcu]"i"(RAN_FOO2_RCU),
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
+ * A frame with no cleanup record: an exception leaving it runs no pad. =
The
+ * throw never fires -- @never is global -- and the bit marks the return=
 path.
+ */
+static __used __naked __noinline void bump(void)
+{
+	asm volatile (
+	PAD_RAN("%[ran]")
+	"r1 =3D %[never] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 =3D=3D 0 goto 1f;"
+	"r1 =3D 0;"
+	"call bpf_throw;"
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
index 000000000000..a7569f98a98d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
@@ -0,0 +1,678 @@
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
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_unwind_resume();
+}
+
+/*
+ * 1. A subprogram that may unwind, also used as a helper callback:
+ * bpf_loop()'s own kernel frame would end the walk before it found a
+ * boundary.
+ */
+static int throwing_cb(__u32 idx, void *ctx)
+{
+	bpf_throw(0xbad);
+	return 0;
+}
+
+static __used __naked __noinline __u64 cb_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call throwing_cb;"		/* cleanup region */
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
+	bpf_loop(1, throwing_cb, NULL, 0);
+	return cb_frame();
+}
+
+/*
+ * 2. A landing pad that reaches both an unwind resume and a plain exit.=
 The
+ * walk takes both, and the exit is refused the same way a catch pad's i=
s.
+ */
+static __used __naked __noinline __u64 inner_throw(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"call bpf_throw;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 ambiguous_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"
+	"call bpf_preempt_disable;"
+"1:"	"call inner_throw;"		/* cleanup region */
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
+/*
+ * 3. A throw from inside a landing pad: a second walk over the frames t=
he
+ * first one is in the middle of discarding.
+ */
+static __used __naked __noinline __u64 throw_in_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_throw;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad that throws again */
+	"call bpf_preempt_enable;"
+	"r1 =3D 2;"
+	"call bpf_throw;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("throws while an exception is in flight")
+int throw_from_landing_pad(void *ctx)
+{
+	return throw_in_pad_frame();
+}
+
+/*
+ * 4. A cleanup table in a program that also installs an exception callb=
ack,
+ * two different answers to what runs on the way out.
+ */
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
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+__u64 never;
+
+/*
+ * 5. A landing pad that calls a global subprogram which can throw. Not =
case 3:
+ * the verifier does not walk a global subprogram, so the throw inside i=
t is
+ * never reached, and what refuses the call is subprog_info.might_throw.
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
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+__failure __msg("which can throw while an exception is in flight")
+int pad_calls_thrower(void *ctx)
+{
+	return pad_calls_thrower_frame();
+}
+
+/*
+ * 6. A catch pad: it ends in a plain exit rather than a resume, and a w=
alker
+ * that calls pads as subroutines cannot hand a frame back its own execu=
tion.
+ */
+static __used __naked __noinline __u64 catch_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 12;"
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+/*
+ * 7. An exception reaching the boundary of a program type that constrai=
ns its
+ * return value: delivery makes the cookie that return value, and fentry=
 has
+ * to return 0.
+ */
+static __used __naked __noinline __u64 boundary_throw_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 7;"
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+SEC("?fentry/bpf_fentry_test1")
+__failure __msg("the register R1 has smin=3D7 smax=3D7 should have been =
in [0, 0]")
+int boundary_delivers(void *ctx)
+{
+	return boundary_throw_frame();
+}
+
+/*
+ * 8. A bpf_unwind_resume() outside any landing pad. Both JITs lower it =
as the
+ * way back out of a pad, which in ordinary code leaves a live frame sta=
nding
+ * with its epilogue skipped; no exception is in flight when the walk ge=
ts
+ * there.
+ */
+static __used __naked __noinline __u64 stray_resume_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r1 =3D 13;"
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+__failure __msg("reached without an exception in flight")
+int resume_outside_pad(void *ctx)
+{
+	/* Never taken, but reachable, which is all the verifier needs. */
+	if (never)
+		bpf_unwind_resume();
+	return stray_resume_frame();
+}
+
+/*
+ * 9. A bpf_unwind_resume() in a subprogram a landing pad calls. An exce=
ption is
+ * in flight, so what refuses it is the frame it is in: a resume reaches=
 the
+ * walker only from the frame whose pad the walker called.
+ */
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
+"1:"	"call bpf_throw;"		/* cleanup region */
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
+__failure __msg("is in frame 2, not frame 1 whose landing pad the except=
ion entered")
+int resume_in_pad_callee(void *ctx)
+{
+	return pad_calls_resumer_frame();
+}
+
+/*
+ * 10. A bpf_unwind_resume() in a program carrying no cleanup table, whe=
re
+ * that static rule does not run at all. do_check() refuses it on the st=
ate
+ * not unwinding, and has to: the JITs lower every one of these the same=
 way.
+ */
+static __used __naked __noinline __u64 no_table_resume_frame(void)
+{
+	asm volatile (
+	"call bpf_unwind_resume;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("reached without an exception in flight")
+int resume_without_table(void *ctx)
+{
+	return no_table_resume_frame();
+}
+
+/*
+ * 11. A landing pad that is itself a covered call site, so an exception=
 out
+ * of it would have nowhere to go. Hand-written only: LLVM sinks a funct=
ion's
+ * pads past every range it emits.
+ */
+static __used __naked __noinline __u64 nested_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_throw;"		/* first cleanup region */
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
+/*
+ * 12. A tail call in a landing pad: it unwinds the prologue off the sta=
ck
+ * pointer, which in a pad is the walker's.
+ */
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
+"1:"	"call inner_throw;"		/* cleanup region */
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
+__failure __msg("is in an exception cleanup landing pad")
+int tail_call_in_pad(void *ctx)
+{
+	return tail_call_pad_frame();
+}
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+/*
+ * 13. A call that passes an argument on the stack, in a landing pad: th=
e
+ * outgoing area the callee reads is not the one the caller wrote, the f=
rame
+ * being the unwinding one and the stack pointer the walker's.
+ */
+static __used __noinline __u64 six_args(__u64 a, __u64 b, __u64 c, __u64=
 d,
+					__u64 e, __u64 f)
+{
+	return a + b + c + d + e + f;
+}
+
+static __used __naked __noinline __u64 stack_arg_pad_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+"1:"	"call inner_throw;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	"r1 =3D 1;"
+	"r2 =3D 2;"
+	"r3 =3D 3;"
+	"r4 =3D 4;"
+	"r5 =3D 5;"
+	"*(u64 *)(r11 - 8) =3D 6;"	/* the sixth argument */
+	"call six_args;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("on-stack call argument in an exception cleanup landing =
pad")
+int stack_arg_in_pad(void *ctx)
+{
+	return stack_arg_pad_frame();
+}
+
+/*
+ * 14. The same, reached the other way: a kfunc whose by-value argument =
runs
+ * past the five argument registers, where the JIT fills the outgoing ar=
ea and
+ * the rule above has no store to catch. The C call gives the extern its=
 BTF.
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
+"1:"	"call inner_throw;"		/* cleanup region */
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
+__failure __msg("calls a kfunc with an on-stack argument in an exception=
 cleanup landing pad")
+int kfunc_stack_arg_in_pad(void *ctx)
+{
+	return kfunc_arg_pad_frame();
+}
+
+#endif /* __BPF_FEATURE_STACK_ARGUMENT */
+
+/*
+ * 15. A landing pad entered by ordinary control flow, arriving with non=
e of
+ * what the walker sets up. The instruction it lands on would have to ru=
n both
+ * with an exception in flight and without, which the walk refuses.
+ */
+static __used __naked __noinline __u64 jump_into_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"if r6 > 7 goto 4f;"		/* an ordinary branch into the pad */
+"1:"	"call inner_throw;"		/* cleanup region */
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
+__failure __msg("runs both inside and outside an exception cleanup landi=
ng pad")
+int jump_into_pad(void *ctx)
+{
+	return jump_into_pad_frame();
+}
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+/*
+ * 16. An indirect jump in a landing pad: the pad does not own the stack=
 its
+ * targets would run on. A jump table entry is an offset from the progra=
m's
+ * section symbol, which has to be spelled in quotes here.
+ */
+static __used __naked __noinline void gotox_thrower(void)
+{
+	asm volatile (
+	"r1 =3D 15;"
+	"call bpf_throw;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__failure __msg("indirect jump at insn")
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
+"1:"	"call gotox_thrower;"		/* cleanup region */
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
+/*
+ * 17. A BPF_LD_[ABS|IND] in a landing pad. A failed load leaves the
+ * subprogram through the hidden "r0 =3D 0; exit" gen_ld_abs() patches i=
n, and
+ * that exit is the epilogue, which unwinds a stack the pad does not own=
.
+ */
+static __used __naked __noinline __u64 ld_abs_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"			/* the skb BPF_LD_ABS reads */
+"1:"	"call inner_throw;"		/* cleanup region */
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
+__failure __msg("is in an exception cleanup landing pad")
+__naked void ld_abs_in_pad(void)
+{
+	asm volatile (
+	"call ld_abs_pad_frame;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * 18. A bpf_unwind_resume() in a subprogram a landing pad called, which=
 has a
+ * pad of its own and reached it by ordinary control flow. Not case 9: a=
n
+ * exception is in flight, but this is not the frame whose pad the walke=
r ran.
+ */
+static __used __naked __noinline __u64 own_pad_callee(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 =3D=3D 0 goto 3f;"		/* an ordinary branch into its pad */
+"1:"	"call bpf_preempt_disable;"	/* cleanup region: nothing that throws =
*/
+	"call bpf_preempt_enable;"
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* its landing pad */
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 pad_calls_own_pad_frame(void)
+{
+	asm volatile (
+"1:"	"call inner_throw;"		/* cleanup region */
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
+__failure __msg("is in frame 2, not frame 1 whose landing pad the except=
ion entered")
+int resume_in_callee_own_pad(void *ctx)
+{
+	return pad_calls_own_pad_frame();
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

