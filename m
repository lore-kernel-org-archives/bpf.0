Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F113EC825
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445917; cv=none; b=KW1fNa+vEsGZk3EgptKIspXdOUtN3E4dxjE6d1/Xl/hoVa67dKo4NLRWsDQJHHbNObUMbXB3RVlezq0zM+Ox6Wgm2YrDXCHwck5Sof2cxA+2RabuvvmsHFBQArNQsPFgzZ9XafV/Pi5mnaDzL3702MbYFURIPcroiklsFu93tu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445917; c=relaxed/simple;
	bh=ME1dwS9yn/K8kukHwM1/Mrhi8Wr7jphMCfScbAGVz7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLKeGL/IXG4ALCoq51KhpDA5bldBnif1IjYar3kluggzHRSM/ABT5Q1fg6/2puGPROXdnKYus2fgxTif4t6EvA5aTqZ4e/+vIsufSU0O+bUQplTG2UnLG8hydxVr8cBPxB67rBdSUmyTDRQig31ENR2ZonHFA7o9bQdfN5i4C5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 45DB92FDA0C9C1; Thu,  8 Oct 2026 00:51:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 22/23] selftests/bpf: Cover more accepted .bpf_cleanup exception shapes
Date: Thu,  8 Oct 2026 00:51:52 -0700
Message-ID: <20261008075152.3010078-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the shapes the end-to-end test does not reach:

 - a pad reading its frame's callee-saved registers
 - a region ending on a 16-byte instruction
 - a pad ending in _Unwind_Resume rather than bpf_unwind_resume
 - a pad whose first instruction is a nop
 - a pad indexing its frame by a register set before the call
 - two pads with an uncovered frame between them
 - precision chains from a pad back across the resume that led to it,
   and back into the frame the unwind left
 - a frame above an unwind that never returns, whose kept exit is not
   its last instruction
 - a region covering an indirect call, and a subprog calling an
   unwinding one through a pointer it was handed
 - a frame holding a reference across a covered call, released by its
   pad
 - a pad reading a slot its static or global callee wrote before
   unwinding
 - unwinds out of a global subprog called with no record, one returning
   in R0:R2 among them
 - a reference moved into a callee, as rustc does for a by-value
   argument
 - a bpf_unwind() inside a loop, in a subprog and in main
 - a frame's own pad finding r0 zero after its bpf_unwind()
 - an unwind reaching main's exit in a program type that checks r0, out
   of a static callee and out of a global call
 - a pad touching a global of each width and sign a tag can name
 - two speculative walks, into a pad and to an exit in one, loaded
   without CAP_PERFMON; each checks the translated program for the
   barrier, so it cannot pass without the walk

Each shape that runs is driven by __set_global(), __retval() and
__ret_global() through RUN_TESTS().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |   20 +
 .../bpf/prog_tests/exceptions_cleanup.c       |    2 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 1141 +++++++++++++++++
 3 files changed, 1163 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index 96effd2c1361..caa8e7b0cfb0 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -10,6 +10,26 @@
 #define RAN_FOO2_DROP		0x8
 #define RAN_BUMP		0x10
=20
+/* progs/exceptions_cleanup_shapes.c: one bit per landing pad. */
+#define RAN_REGS		0x1
+#define RAN_WIDE_REC		0x2
+#define RAN_RESUME_ALIAS	0x4
+#define RAN_NOP_PAD		0x8
+#define RAN_VAR_STACK		0x10
+#define RAN_GAP_INNER		0x20
+#define RAN_GAP_OUTER		0x40
+#define RAN_PREC_RESUME		0x80
+#define RAN_NO_EXIT_JA		0x100
+#define RAN_CALLX		0x200
+#define RAN_HELD_REF		0x400
+#define RAN_CALLEE_WRITE	0x800
+#define RAN_CALLEE_OFFSET	0x1000
+#define RAN_GLOBAL_WRITE	0x2000
+#define RAN_THROUGH_GLOBAL	0x4000
+#define RAN_OWN_PAD_R0		0x8000
+#define RAN_PAIR_GLOBAL		0x10000
+#define RAN_MOVE		0x20000
+
 #define CLEANUP_REC(begin, end, landing_pad)			\
 	".pushsection .bpf_cleanup,\"a\",@progbits;"		\
 	".long " begin ";"					\
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
index 3e46e17ef9b4..7c5dffd4b861 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
@@ -4,6 +4,7 @@
 #include "exceptions_cleanup.h"
 #include "exceptions_cleanup.skel.h"
 #include "exceptions_cleanup_fail.skel.h"
+#include "exceptions_cleanup_shapes.skel.h"
 #include "exceptions_cleanup_tracing.skel.h"
=20
 /* foo3 unwound: every frame that has a pad ran it. */
@@ -113,4 +114,5 @@ void test_exceptions_cleanup(void)
 	exceptions_cleanup__destroy(skel);
=20
 	RUN_TESTS(exceptions_cleanup_fail);
+	RUN_TESTS(exceptions_cleanup_shapes);
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
new file mode 100644
index 000000000000..183a8c8b6b13
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
@@ -0,0 +1,1141 @@
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
+__u64 magic =3D 0x5eed;
+__u64 pads_ran =3D 0;
+
+/* Load r6-r9 with values derived from @magic. */
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
+/* A callee that unwinds when its argument is over 100. */
+static __used __noinline __u64 pc_unwinder(__u64 x)
+{
+	if (x > 100)
+		bpf_unwind();
+	return x + 1;
+}
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
+/* A pad that reads r6-r9, which the callee overwrote before it unwound.=
 */
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
+__success __retval(0)
+__ret_global(pads_ran, RAN_REGS)
+int entry_regs(void *ctx)
+{
+	return regs_frame();
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
+"1:"	"call pc_unwinder;"		/* cleanup region begins */
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
+__success __retval(0)
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
+/* Put @magic in both of the slots a variable offset could name. */
+#define FILL_MAGIC_SLOTS					\
+	"r1 =3D %[magic] ll;"					\
+	"r1 =3D *(u64 *)(r1 + 0);"				\
+	"*(u64 *)(r10 - 8) =3D r1;"				\
+	"*(u64 *)(r10 - 16) =3D r1;"
+
+/* Set @bit if the slot @idx names, read at a variable offset, holds it.=
 */
+#define CHECK_VAR_SLOT(idx, bit)				\
+	"r1 =3D r10;"						\
+	"r1 +=3D " idx ";"					\
+	"r2 =3D *(u64 *)(r1 - 16);"				\
+	"r3 =3D %[magic] ll;"					\
+	"r3 =3D *(u64 *)(r3 + 0);"				\
+	"if r2 !=3D r3 goto 9f;"					\
+	PAD_RAN(bit)						\
+	"9:"
+
+/* A callee that unwinds when r1 is at least 101, and touches none of r6=
-r9. */
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
+	FILL_MAGIC_SLOTS
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
+	CHECK_VAR_SLOT("r6", "%[ran]")
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
+/*
+ * A precision chain crossing a resume: the outer frame's pad uses r6 as=
 a
+ * variable stack offset, and the only way into that pad is the resume t=
hat
+ * ends the inner frame's pad, so backtracking goes from the pad through=
 the
+ * inner frame and back to where r6 was bounded.
+ */
+static __used __naked __noinline __u64 prec_inner_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 prec_outer_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r6 &=3D 0x7;"
+	"r0 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r0;"
+	"*(u64 *)(r10 - 16) =3D r0;"
+"1:"	"call prec_inner_frame;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* pad: r6 as a variable stack offset */
+	"r2 =3D r10;"
+	"r2 +=3D -16;"
+	"r2 +=3D r6;"
+	"*(u8 *)(r2 + 0) =3D 1;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PREC_RESUME), __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_PREC_RESUME)
+__log_level(2)
+__msg("frame1: regs=3Dr6 stack=3D before {{[0-9]+}}: (85) call bpf_unwin=
d_resume")
+__msg("frame2: regs=3D stack=3D before {{[0-9]+}}: (85) call bpf_unwind#=
")
+__msg("frame1: regs=3Dr6 stack=3D before {{[0-9]+}}: (57) r6 &=3D 7")
+int entry_prec_across_resume(void *ctx)
+{
+	return prec_outer_frame();
+}
+
+/* Unwinds every time, and no record covers it, so the path simply ends.=
 */
+static __used __naked __noinline __u64 always_unwind(void)
+{
+	asm volatile (
+	"call bpf_unwind;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * A frame with no record of its own above one that always unwinds: noth=
ing
+ * after the call is reachable, so dead code removal would leave it no e=
xit
+ * and no epilogue for the unwind to send it to. One is kept, and since =
this
+ * frame ends in a jump rather than an exit, it is not the last instruct=
ion.
+ */
+static __used __naked __noinline __u64 no_exit_ja_mid(void)
+{
+	asm volatile (
+	"goto 2f;"
+"1:"	"r0 =3D 1;"
+	"exit;"
+"2:"	"call always_unwind;"
+	"goto 1b;"			/* the last insn, and not an exit */
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 no_exit_ja_outer_frame(void)
+{
+	asm volatile (
+"1:"	"call no_exit_ja_mid;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_NO_EXIT_JA), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __retval(0)
+__ret_global(pads_ran, RAN_NO_EXIT_JA)
+int entry_no_exit_ja(void *ctx)
+{
+	return no_exit_ja_outer_frame();
+}
+
+/* gcc has no indirect calls, and only these JITs emit them */
+#if defined(__clang__) && \
+	(defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64))
+
+/*
+ * A region covering an indirect call: a record names a call by its retu=
rn
+ * address, which a callx leaves like any other call.
+ */
+static __used __naked __noinline __u64 callx_region_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r2 =3D %[always_unwind] ll;"
+"1:"	"callx r2;"			/* cleanup region */
+"2:"
+	"call bpf_preempt_enable;"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"call bpf_preempt_enable;"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_CALLX), __imm_addr(always_unwind),
+	  __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __retval(0)
+__ret_global(pads_ran, RAN_CALLX)
+int entry_callx_region(void *ctx)
+{
+	return callx_region_frame();
+}
+
+/*
+ * A subprog calling an unwinding one through a pointer it was handed: n=
othing
+ * after the call runs, but the frame still needs an exit for its epilog=
ue.
+ */
+static __used __naked __noinline __u64 callx_arg_frame(void)
+{
+	asm volatile (
+	"callx r1;"			/* r1 is always_unwind */
+	"r0 =3D 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__success __retval(0)
+__naked int entry_callx_arg(void)
+{
+	asm volatile (
+	"r1 =3D %[always_unwind] ll;"
+	"call callx_arg_frame;"
+	"exit;"
+	:
+	: __imm_addr(always_unwind)
+	: __clobber_all);
+}
+
+#endif /* __clang__ && (x86 || arm64) */
+
+/*
+ * The jump_into_pad shape with the branch dead, so the jump into the pa=
d is
+ * walked only speculatively, reaching the pad's resume outside a pad: a
+ * barrier rather than a refusal. Only a load without CAP_PERFMON walks =
it,
+ * hence the unprivileged run, and the branch is dead by range rather th=
an by
+ * a constant, which const_fold would rewrite into a plain goto before a=
ny
+ * walk.
+ */
+static __used __naked __noinline __u64 dead_jump_into_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r6 &=3D 7;"
+	"if r6 > 7 goto 4f;"		/* never taken: walked speculatively */
+"1:"	"call always_unwind;"		/* cleanup region */
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
+__success __caps_unpriv(CAP_BPF) __success_unpriv
+__xlated_unpriv("nospec")
+int entry_dead_jump_into_pad(void *ctx)
+{
+	return dead_jump_into_pad_frame();
+}
+
+/* Add one to the @w-bit global at @addr. */
+#define BUMP_GLOBAL(w, addr)					\
+	"r1 =3D " addr " ll;"					\
+	"r2 =3D *(u" w " *)(r1 + 0);"				\
+	"r2 +=3D 1;"						\
+	"*(u" w " *)(r1 + 0) =3D r2;"
+
+/*
+ * A pad that touches a global of each width and sign a test tag can nam=
e,
+ * so that __set_global() and __ret_global() are exercised on all four.
+ */
+int tag_i =3D 0;
+unsigned int tag_ui =3D 0;
+long tag_l =3D 0;
+unsigned long tag_ul =3D 0;
+
+static __used __naked __noinline __u64 tag_types_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_unwinder;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	BUMP_GLOBAL("32", "%[tag_i]")
+	BUMP_GLOBAL("32", "%[tag_ui]")
+	BUMP_GLOBAL("64", "%[tag_l]")
+	BUMP_GLOBAL("64", "%[tag_ul]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input), __imm_addr(tag_i), __imm_addr(tag_ui),
+	  __imm_addr(tag_l), __imm_addr(tag_ul)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __retval(0)
+__set_global(input, 101)
+__set_global(tag_i, -23) __set_global(tag_ui, 0xfffffffe)
+__set_global(tag_l, -23) __set_global(tag_ul, 0xfffffffffffffffe)
+__ret_global(tag_i, -22) __ret_global(tag_ui, 0xffffffff)
+__ret_global(tag_l, -22) __ret_global(tag_ul, 0xffffffffffffffff)
+int entry_tag_types(void *ctx)
+{
+	return tag_types_frame();
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} shape_ringbuf SEC(".maps");
+
+/*
+ * A frame holding a reference across a call an unwind comes out of. The=
 record
+ * over the call is what lets it hold one: the pad releases it, where a =
frame
+ * with no record would be left for its epilogue still holding it.
+ */
+static __used __naked __noinline __u64 held_ref_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[shape_ringbuf] ll;"
+	"r2 =3D 8;"
+	"r3 =3D 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 =3D=3D 0 goto 9f;"
+	"r6 =3D r0;"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call pc_unwinder;"		/* cleanup region */
+"2:"
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"goto 9f;"
+"3:"					/* landing pad: release and resume */
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+"9:"
+	"r0 =3D 0;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_HELD_REF), __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard), __imm_addr(shape_ringbuf),
+	  __imm_addr(input), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_HELD_REF)
+int entry_held_ref(void *ctx)
+{
+	return held_ref_frame();
+}
+
+/*
+ * A pad reading a slot its frame's callee wrote before it unwound. The =
write
+ * is there when the pad runs, and the pad has to be verified that way, =
or
+ * the check below is taken as always failing and the bit is never set.
+ */
+static __used __naked __noinline __u64 slot_writer(void)
+{
+	asm volatile (
+	"r2 =3D 42;"
+	"*(u64 *)(r1 + 0) =3D r2;"	/* r1 is the caller's fp-8 */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 < 101 goto 1f;"
+	"call bpf_unwind;"
+"1:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 callee_write_frame(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+"1:"	"call slot_writer;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r1 =3D *(u64 *)(r10 - 8);"
+	"if r1 !=3D 42 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_CALLEE_WRITE), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_CALLEE_WRITE)
+int entry_callee_write(void *ctx)
+{
+	return callee_write_frame();
+}
+
+/*
+ * A precision chain across an unwind: the pad uses a slot the callee wr=
ote as
+ * a variable stack offset, so backtracking follows the slot from the pa=
d back
+ * into the frame the unwind left.
+ */
+static __used __naked __noinline __u64 offset_writer(void)
+{
+	asm volatile (
+	"r2 =3D %[input] ll;"
+	"r3 =3D *(u64 *)(r2 + 0);"
+	"r3 &=3D 8;"
+	"*(u64 *)(r1 + 0) =3D r3;"	/* r1 is the caller's fp-24 */
+	"call bpf_unwind;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 callee_offset_frame(void)
+{
+	asm volatile (
+	FILL_MAGIC_SLOTS
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 24) =3D r1;"
+	"r1 =3D r10;"
+	"r1 +=3D -24;"
+"1:"	"call offset_writer;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r6 =3D *(u64 *)(r10 - 24);"
+	CHECK_VAR_SLOT("r6", "%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_CALLEE_OFFSET), __imm_addr(magic), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_CALLEE_OFFSET)
+__log_level(2)
+__msg("frame1: regs=3D stack=3D-24 before {{[0-9]+}}: (85) call bpf_unwi=
nd#")
+__msg("frame2: regs=3D stack=3D before {{[0-9]+}}: (7b) *(u64 *)(r1 +0) =
=3D r3")
+__msg("frame2: regs=3Dr3 stack=3D before {{[0-9]+}}: (57) r3 &=3D 8")
+int entry_callee_offset(void *ctx)
+{
+	return callee_offset_frame();
+}
+
+/* The same through a global subprog. */
+__noinline int global_slot_writer(__u64 *p)
+{
+	if (!p)
+		return 0;
+	*p =3D 42;
+	if (input > 100)
+		bpf_unwind();
+	return 0;
+}
+
+static __used __naked __noinline __u64 global_write_frame(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"*(u64 *)(r10 - 8) =3D r1;"
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+"1:"	"call global_slot_writer;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"r1 =3D *(u64 *)(r10 - 8);"
+	"if r1 !=3D 42 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_GLOBAL_WRITE), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_GLOBAL_WRITE)
+int entry_global_write(void *ctx)
+{
+	return global_write_frame();
+}
+
+/*
+ * An unwind raised in a global subprog, called with no record over the =
call
+ * from a frame whose own caller has a pad. The global subprog is verifi=
ed on
+ * its own, so the unwind is taken from the state its call returns in, a=
nd it
+ * has to go on to that pad.
+ */
+__noinline int global_unwinder(int x)
+{
+	if (x > 100)
+		bpf_unwind();
+	return 0;
+}
+
+static __used __naked __noinline __u64 through_global_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"call global_unwinder;"		/* no record */
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 over_global_frame(void)
+{
+	asm volatile (
+"1:"	"call through_global_frame;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_THROUGH_GLOBAL), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_THROUGH_GLOBAL)
+int entry_through_global(void *ctx)
+{
+	return over_global_frame();
+}
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+/*
+ * The same, with the global subprog returning in R0:R2: its unwind leav=
es
+ * R2 checked as a return value too, though its caller never reads eithe=
r.
+ */
+struct u64_pair {
+	__u64 a;
+	__u64 b;
+};
+
+__noinline struct u64_pair global_pair_unwinder(int x)
+{
+	struct u64_pair p =3D { x, x + 1 };
+
+	if (x > 100)
+		bpf_unwind();
+	return p;
+}
+
+static __used __naked __noinline __u64 through_pair_global_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"call global_pair_unwinder;"	/* no record */
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 over_pair_global_frame(void)
+{
+	asm volatile (
+"1:"	"call through_pair_global_frame;"	/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	PAD_RAN("%[ran]")
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_PAIR_GLOBAL), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_PAIR_GLOBAL)
+int entry_pair_global_unwind(void *ctx)
+{
+	return over_pair_global_frame();
+}
+
+#endif /* __clang_major__ >=3D 23 */
+
+/*
+ * A reference moved into a callee: the caller reserves a record and han=
ds it
+ * over with a plain call, as rustc emits for 'consume(rec)' -- it has n=
othing
+ * left to drop -- and the callee drops it on return and, from its pad, =
on an
+ * unwind.
+ */
+static __used __naked __noinline __u64 consume_frame(void)
+{
+	asm volatile (
+	"r6 =3D r1;"			/* the record, now owned here */
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+"1:"	"call global_unwinder;"		/* cleanup region */
+"2:"
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad: drop glue */
+	PAD_RAN("%[ran]")
+	"r1 =3D r6;"
+	"r2 =3D 0;"
+	"call %[bpf_ringbuf_discard];"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_MOVE), __imm_addr(pads_ran), __imm_addr(input),
+	  __imm(bpf_ringbuf_discard)
+	: __clobber_all);
+}
+
+static __used __naked __noinline __u64 move_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[shape_ringbuf] ll;"
+	"r2 =3D 8;"
+	"r3 =3D 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 =3D=3D 0 goto 1f;"
+	"r1 =3D r0;"
+	"call consume_frame;"		/* the record moves: no record here */
+"1:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(shape_ringbuf), __imm(bpf_ringbuf_reserve)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
+__ret_global(pads_ran, RAN_MOVE)
+int entry_move_into_callee(void *ctx)
+{
+	return move_frame();
+}
+
+/*
+ * A bpf_unwind() inside a loop, with no pad between it and the main pro=
gram.
+ * The main program's frame returns from where the unwind left it, not f=
rom
+ * the loop in the subprog.
+ */
+static __used __naked __noinline __u64 loop_unwinder(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
+"1:"
+	"r1 =3D %[input] ll;"
+	"r1 =3D *(u64 *)(r1 + 0);"
+	"if r1 !=3D r6 goto 2f;"
+	"call bpf_unwind;"
+"2:"
+	"r6 +=3D 1;"
+	"if r6 < 4 goto 1b;"
+	"r0 =3D 1;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 2) __retval(0)
+int entry_unwind_in_loop(void *ctx)
+{
+	return loop_unwinder();
+}
+
+/*
+ * The loop in the main program itself, around a call that unwinds on on=
e
+ * trip. The unwind returns from the main frame at that call, inside the=
 loop,
+ * where no checkpoint need have been made yet.
+ */
+static __used __naked __noinline __u64 unwind_on_match(void)
+{
+	asm volatile (
+	"r2 =3D %[input] ll;"
+	"r2 =3D *(u64 *)(r2 + 0);"
+	"if r1 !=3D r2 goto 1f;"
+	"call bpf_unwind;"
+"1:"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 2) __retval(0)
+__naked int entry_unwind_out_of_main_loop(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
+"1:"
+	"r1 =3D r6;"
+	"call unwind_on_match;"
+	"r6 +=3D 1;"
+	"if r6 < 4 goto 1b;"
+	"r0 =3D 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* A frame's own pad, reached from its bpf_unwind(), finds r0 zero. */
+static __used __naked __noinline __u64 own_pad_r0_frame(void)
+{
+	asm volatile (
+"1:"	"call bpf_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 1;"
+	"exit;"
+"3:"					/* landing pad */
+	"if r0 !=3D 0 goto 9f;"
+	PAD_RAN("%[ran]")
+"9:"
+	"call bpf_unwind_resume;"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: [ran]"i"(RAN_OWN_PAD_R0), __imm_addr(pads_ran)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __retval(0)
+__ret_global(pads_ran, RAN_OWN_PAD_R0)
+int entry_own_pad_r0(void *ctx)
+{
+	return own_pad_r0_frame();
+}
+
+/* A pad whose speculative walk reaches an exit: a barrier, not a refusa=
l. */
+static __used __naked __noinline __u64 spec_exit_pad_frame(void)
+{
+	asm volatile (
+	"r1 =3D %[input] ll;"
+	"r6 =3D *(u64 *)(r1 + 0);"
+	"r6 &=3D 7;"
+"1:"	"call always_unwind;"		/* cleanup region */
+"2:"
+	"r0 =3D 0;"
+	"exit;"
+"3:"					/* landing pad */
+	"if r6 > 7 goto 4f;"		/* never taken: walked speculatively */
+	"call bpf_unwind_resume;"
+"4:"
+	"exit;"
+	CLEANUP_REC("1b", "2b", "3b")
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __caps_unpriv(CAP_BPF) __success_unpriv
+__xlated_unpriv("nospec")
+int entry_spec_exit_pad(void *ctx)
+{
+	return spec_exit_pad_frame();
+}
+
+/*
+ * An unwind reaching main's exit in a program type that checks r0: its
+ * precision is backtracked past an earlier call to the insn that unwoun=
d.
+ */
+static __used __naked __noinline __u64 plain_frame(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?cgroup/skb")
+__success
+__naked int entry_unwind_to_checked_exit(void)
+{
+	asm volatile (
+	"call plain_frame;"
+	"call always_unwind;"
+	"r0 =3D 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * The same, out of a global call, which r6 =3D 0 keeps from being the s=
tate's
+ * first insn, where backtracking would stop. The verifier_bug_if() this
+ * guards against only logs, so the level 2 log is checked.
+ */
+__noinline int global_always_unwind(void)
+{
+	bpf_unwind();
+	return 0;
+}
+
+SEC("?cgroup/skb")
+__success __log_level(2) __not_msg("verifier bug")
+__naked int entry_global_unwind_to_checked_exit(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
+	"call global_always_unwind;"
+	"r0 =3D 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

