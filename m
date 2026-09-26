Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FAA38C426
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398922; cv=none; b=J5zzodq8tidtbrke57QDMCC3y6Ki3xsB1fmin5lPLk+0bKLxyyDmByYYYKxiF5MELYtjp25Xew2ct792ECF9L8RB+nqQ+JlctD9BBlFyb6Z7KK0nrfPqNdTnIacJVgeeKSTh5+uwYAsqF0VcqyFQRK7S7pC0LDkgiDGrReL1xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398922; c=relaxed/simple;
	bh=zBNHM9yYOfCPx7DrnWDO6pFO6ABcZVi4QOxoCWZkhNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak6pdIJ7V/fqNP+F5oKUlIiUU+r4RPrvxiixeZLpUCSimb+P2gescdBKkUhbEjW52PqBrD0OqbXc7rWWMxz9C1JxcNdEJJlIYT2eTvN5d8spUhrqHGbsBwN/eZnZuKRSR2apiheYrvDc0FiO7Xb8GoNd4ygip3kpH3Agf93w1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CE4562D45970E5; Fri, 25 Sep 2026 22:01:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 20/21] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
Date: Fri, 25 Sep 2026 22:01:48 -0700
Message-ID: <20260926050148.2222810-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The end-to-end test walks one call chain with a pad in most of its frames=
.
This adds the shapes that chain does not reach, in the order the new file
has them:

 - what a cleanup table leaves dead
 - a callee called from both a covered and an uncovered site
 - a pad that reads its frame's callee-saved registers
 - a pad in the main program's own frame
 - a covered bpf_unwind() the sweep leaves last
 - a region ending on a 16-byte instruction
 - a pad that reloads from and writes to its own frame
 - a pad terminated by _Unwind_Resume rather than bpf_unwind_resume
 - a pad whose first instruction is a nop
 - a pad that indexes its frame by a register the frame set before the
   unwinding call
 - the same over an unwinding global subprogram
 - a pad that indexes its frame by r0, which no instruction wrote
 - a region covering more than one call that can unwind
 - two pads with an uncovered frame between them

Each of them wants the same three things of a run: an input, a return
value, and the set of landing pads that ran. That is what __set_global(),
__retval() and __ret_global() say, so they say it and RUN_TESTS() does th=
e
rest, which also gives each shape a name of its own in the test output.
The shared-callee shape takes two more programs over the same frame: one
with nothing unwinding, one unwinding from the uncovered site.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  17 +
 .../bpf/prog_tests/exceptions_cleanup.c       |   2 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 665 ++++++++++++++++++
 3 files changed, 684 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index d1d40314035e..49b6806cde82 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -10,6 +10,23 @@
 #define RAN_FOO2_DROP		0x8
 #define RAN_BUMP		0x10
=20
+/* progs/exceptions_cleanup_shapes.c: one bit per shape. */
+#define RAN_SWEEP		0x1
+#define RAN_SHARED		0x2
+#define RAN_REGS		0x4
+#define RAN_MAIN_PAD		0x8
+#define RAN_PAD_FIRST		0x10
+#define RAN_WIDE_REC		0x20
+#define RAN_PAD_STACK		0x40
+#define RAN_RESUME_ALIAS	0x80
+#define RAN_NOP_PAD		0x100
+#define RAN_VAR_STACK		0x200
+#define RAN_GLOBAL_PAD		0x400
+#define RAN_PAD_R0		0x800
+#define RAN_MULTI_CALL		0x1000
+#define RAN_GAP_INNER		0x2000
+#define RAN_GAP_OUTER		0x4000
+
 #define CLEANUP_REC(begin, end, landing_pad)			\
 	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
 	".long " begin ";"					\
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 255f88d35aad..c06ec10359b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -4,6 +4,7 @@
 #include "exceptions_cleanup.h"
 #include "exceptions_cleanup.skel.h"
 #include "exceptions_cleanup_fail.skel.h"
+#include "exceptions_cleanup_shapes.skel.h"
=20
 /* foo3 unwound: every frame that has a pad ran it. */
 #define PADS_FOO3_UNWOUND \
@@ -82,4 +83,5 @@ void test_exceptions_cleanup(void)
 	exceptions_cleanup__destroy(skel);
=20
 	RUN_TESTS(exceptions_cleanup_fail);
+	RUN_TESTS(exceptions_cleanup_shapes);
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
new file mode 100644
index 000000000000..37a78e035a50
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
@@ -0,0 +1,665 @@
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
+__u64 outer_input =3D 0;
+__u64 magic =3D 0x5eed;
+__u64 pads_ran =3D 0;
+
+/* The callee most of the shapes below unwind out of. */
+static __used __noinline __u64 pc_unwinder(__u64 x)
+{
+	if (x > 100)
+		bpf_unwind();
+	return x + 1;
+}
+
+/* What a cleanup table leaves dead: an unwind's continuation and its ta=
il. */
+static __used __naked __noinline __u64 sweep_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"call bpf_preempt_disable;"
+	"if r6 < 101 goto 6f;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"goto 3f;"
+"4:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"r1 =3D %[pads_ran] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r2 =3D=3D 0 goto 5f;"
+	"call bpf_preempt_enable;"
+	"r0 =3D 7;"
+	"exit;"
+"5:"
+	"r0 =3D 8;"
+	"exit;"
+"3:"					/* dead: only the dead goto reaches it */
+	"r0 =3D 9;"
+	"exit;"
+"6:"					/* live: the ordinary return */
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "4b")
+	:
+	: [ran]"i"(RAN_SWEEP),
+	  __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_SWEEP)
+int entry_sweep(void *ctx)
+{
+	return sweep_frame();
+}
+
+/* A callee on both a covered and an uncovered call: the pad is the site=
's. */
+static __used __noinline __u64 shared_callee(__u64 x)
+{
+	if (x > 100)
+		bpf_unwind();
+	return x + 1;
+}
+
+static __used __naked __noinline __u64 shared_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r1 =3D %[outer_input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"call shared_callee;"		/* uncovered: no pad for its unwind */
+	"call bpf_rcu_read_lock;"
+	"r1 =3D r6;"
+"1:"	"call shared_callee;"		/* cleanup region */
+"2:"
+	"r6 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D r6;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_SHARED), __imm_addr(input), __imm_addr(outer_input),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_SHARED)
+int entry_shared(void *ctx)
+{
+	return shared_frame();
+}
+
+/* The same shape, with no unwind. */
+SEC("?syscall")
+__success __set_global(input, 1) __retval(2)
+__ret_global(pads_ran, 0)
+int entry_shared_quiet(void *ctx)
+{
+	return shared_frame();
+}
+
+/* And the uncovered site unwinding instead: no pad runs. */
+SEC("?syscall")
+__success __set_global(input, 1) __retval(0)
+__ret_global(pads_ran, 0)
+int entry_shared_uncovered(void *ctx)
+{
+	outer_input =3D 101;
+	return shared_frame();
+}
+
+/* A pad that reads r6-r9, which the callee overwrote before it unwound.=
 */
+#define LOAD_MAGIC_REGS						\
+	"r1 =3D %[magic] ll;"					\
+	"r6 =3D *(u64 *)(r1 + 0);"				\
+	"r7 =3D r6;"						\
+	"r7 +=3D 1;"						\
+	"r8 =3D r6;"						\
+	"r8 +=3D 2;"						\
+	"r9 =3D r6;"						\
+	"r9 +=3D 3;"
+
+/* Set @bit only if r6-r9 still hold what LOAD_MAGIC_REGS put there. */
+#define CHECK_MAGIC_REGS(bit)					\
+	"r1 =3D %[magic] ll;"					\
+	"r2 =3D *(u64 *)(r1 + 0);"				\
+	"if r6 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r7 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r8 !=3D r2 goto 9f;"					\
+	"r2 +=3D 1;"						\
+	"if r9 !=3D r2 goto 9f;"					\
+	PAD_RAN(bit)						\
+	"9:"
+
+static __used __naked __noinline __u64 regs_unwinder(void)
+{
+	asm volatile (
+	/* Not this frame's to keep, and that is the point. */
+	"r6 =3D 0xdead;"
+	"r7 =3D 0xbeef;"
+	"r8 =3D 0xcafe;"
+	"r9 =3D 0xf00d;"
+	"call bpf_unwind;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 regs_frame(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"call bpf_preempt_disable;"
+"1:"	"call regs_unwinder;"		/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_REGS),
+	  __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_REGS)
+int entry_regs(void *ctx)
+{
+	return regs_frame();
+}
+
+/* A pad in the main program's frame, which jit_subprogs() makes func[0]=
. */
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_MAIN_PAD)
+__naked int entry_main_pad(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 8f;"
+"1:"	"call regs_unwinder;"		/* cleanup region */
+"2:"
+"8:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_MAIN_PAD), __imm_addr(input),
+	  __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/*
+ * A covered bpf_unwind() the sweep leaves last, behind the exception ca=
llback
+ * patchlet, which has to carry the marks with it.
+ */
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_PAD_FIRST)
+__naked int entry_pad_first(void)
+{
+	asm volatile (
+	LOAD_MAGIC_REGS
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 7f;"
+	"goto 4f;"
+"3:"					/* landing pad, ahead of the call */
+	CHECK_MAGIC_REGS("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+"7:"
+	"r0 =3D 0;"
+	"exit;"
+"4:"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"exit;"				/* dead: swept, leaving the call last */
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_FIRST),
+	  __imm_addr(input), __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/* A region ending on a 16-byte insn, so end - 1 names its second half. =
*/
+static __used __naked __noinline __u64 wide_rec_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"call bpf_rcu_read_lock;"
+	"r1 =3D r6;"
+"1:"	"call shared_callee;"		/* cleanup region begins */
+	"r1 =3D %[magic] ll;"		/* ... and ends on this pair */
+"2:"
+	"r6 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	"r0 =3D r6;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"call bpf_rcu_read_unlock;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_WIDE_REC), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_WIDE_REC)
+int entry_wide_rec(void *ctx)
+{
+	return wide_rec_frame();
+}
+
+/*
+ * A pad that reloads from and stores to its own frame, which arm64 addr=
esses
+ * through the stack pointer.
+ */
+static __used __naked __noinline __u64 pad_stack_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"	/* what the pad will want */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	"r7 =3D *(u64 *)(r10 - 8);"	/* reload it out of the frame */
+	"*(u64 *)(r10 - 16) =3D r7;"	/* and write the frame while here */
+	"r1 =3D %[magic] ll;"
+	"r2 =3D *(u64 *)(r1 + 0);"
+	"if r7 !=3D r2 goto 9f;"
+	"r3 =3D *(u64 *)(r10 - 16);"
+	"if r3 !=3D r2 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_STACK), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_PAD_STACK)
+int entry_pad_stack(void *ctx)
+{
+	return pad_stack_frame();
+}
+
+/* The name LLVM gives the resume: _Unwind_Resume(), which libbpf maps o=
ver. */
+extern void _Unwind_Resume(void *ptr) __ksym;
+
+static __used __noinline void __resume_alias_btf_anchor(void)
+{
+	_Unwind_Resume(NULL);
+}
+
+static __used __naked __noinline __u64 resume_alias_frame(void)
+{
+	asm volatile (
+"1:"	"call regs_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call _Unwind_Resume;"		/* the frontend's name for it */
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_RESUME_ALIAS), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_RESUME_ALIAS)
+int entry_resume_alias(void *ctx)
+{
+	return resume_alias_frame();
+}
+
+/* A pad starting on a nop, which opt_remove_nops() drops after the walk=
. */
+static __used __naked __noinline __u64 nop_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"if r6 < 101 goto 6f;"
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+"6:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad: a nop, then its body */
+	"goto +0;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_NOP_PAD),
+	  __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_NOP_PAD)
+int entry_nop_pad(void *ctx)
+{
+	return nop_pad_frame();
+}
+
+/* A pad that indexes its frame by a register set before the unwinding c=
all. */
+
+/* An unwinder that touches none of r6-r9, so the walk leaves this frame=
. */
+static __used __naked __noinline __u64 var_unwinder(void)
+{
+	asm volatile (
+	"if r1 < 101 goto 1f;"
+	"call bpf_unwind;"
+"1:"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 var_stack_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"	/* the slot the pad will read... */
+	"*(u64 *)(r10 - 16) =3D r1;"	/* ...whichever of the two it is */
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r6 &=3D 1;"			/* an unknown slot number... */
+	"r6 <<=3D 3;"			/* ...as an aligned byte offset */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call var_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"r1 =3D r10;"
+	"r1 +=3D r6;"			/* variable offset into the frame */
+	"r2 =3D *(u64 *)(r1 - 16);"
+	"r3 =3D %[magic] ll;"
+	"r3 =3D *(u64 *)(r3 + 0);"
+	"if r2 !=3D r3 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_VAR_STACK), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_VAR_STACK)
+int entry_var_stack(void *ctx)
+{
+	return var_stack_frame();
+}
+
+/* The same over a global subprogram, which the verifier enters no frame=
 for. */
+__noinline __u64 global_unwinder(__u64 x)
+{
+	if (x > 100)
+		bpf_unwind();
+	return x + 1;
+}
+
+static __used __naked __noinline __u64 global_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"*(u64 *)(r10 - 16) =3D r1;"
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r6 &=3D 1;"
+	"r6 <<=3D 3;"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call global_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r7 =3D r0;"
+	"r1 =3D r10;"
+	"r1 +=3D r6;"
+	"r2 =3D *(u64 *)(r1 - 16);"
+	"r3 =3D %[magic] ll;"
+	"r3 =3D *(u64 *)(r3 + 0);"
+	"if r2 !=3D r3 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_GLOBAL_PAD), __imm_addr(input), __imm_addr(magic),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_GLOBAL_PAD)
+int entry_global_pad(void *ctx)
+{
+	return global_pad_frame();
+}
+
+/* A pad that indexes its frame by r0, which no instruction in it wrote.=
 */
+static __used __naked __noinline __u64 pad_r0_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[magic] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) =3D r1;"	/* the slot the pad will read... */
+	"*(u64 *)(r10 - 16) =3D r1;"	/* ...whichever of the two it is */
+"1:"	"call regs_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r0 &=3D 1;"			/* an unknown slot number... */
+	"r0 <<=3D 3;"			/* ...as an aligned byte offset */
+	"r1 =3D r10;"
+	"r1 +=3D r0;"			/* variable offset into the frame */
+	"r2 =3D *(u64 *)(r1 - 16);"
+	"r3 =3D %[magic] ll;"
+	"r3 =3D *(u64 *)(r3 + 0);"
+	"if r2 !=3D r3 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAD_R0), __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_PAD_R0)
+int entry_pad_r0(void *ctx)
+{
+	return pad_r0_frame();
+}
+
+/* A region over two calls that can unwind, where the second one does. *=
/
+static __used __naked __noinline __u64 multi_call_frame(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+"1:"	"call pc_unwinder;"		/* covered, and returns */
+	"r6 =3D r0;"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"call pc_unwinder;"		/* covered by the same record, unwinds */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad, reached from either call */
+	"r7 =3D r0;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r7;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_MULTI_CALL), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_MULTI_CALL)
+int entry_multi_call(void *ctx)
+{
+	return multi_call_frame();
+}
+
+/* Two pads with an uncovered frame between them. */
+static __used __naked __noinline __u64 gap_inner_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_GAP_INNER), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/* The frame in between, with no record of its own. */
+static __used __noinline __u64 gap_mid(void)
+{
+	return gap_inner_frame() + 1;
+}
+
+static __used __naked __noinline __u64 gap_outer_frame(void)
+{
+	asm volatile (
+"1:"	"call gap_mid;"			/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D r0;"
+	PAD_RAN("%[ran]")
+	"r1 =3D r6;"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_GAP_OUTER), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+/* And one more uncovered frame between the outer pad and the boundary. =
*/
+static __used __noinline __u64 gap_top(void)
+{
+	return gap_outer_frame() + 1;
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_GAP_INNER | RAN_GAP_OUTER)
+int entry_two_pads(void *ctx)
+{
+	return gap_top();
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

