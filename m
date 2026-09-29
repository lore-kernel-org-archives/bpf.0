Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0C2F7F13
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641076; cv=none; b=oTeGW+ViJdzOzL4EykEyG0m/O4Mz3PXc07pAC4c+Y7GDhRIM8klTIeeDYVtJ4GAYo5C7/+lW6xF5li7tGvzBcEqo9AccK7cv9Y0Uft57dz18ARQyMvqTYR7REesYYutJpGKz/x/LD5LE1tJXHRIsNYrxvVL99IRnnXKh8zD4TZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641076; c=relaxed/simple;
	bh=K0/+8ZFmblQnH5NZBtc775KWjHCquBg58LqkECyhJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbvq7a19YlgLJU2J097CbrRscG/QPpfGxFL3j7jWD1FRwvXwv4Ud5z18B7Nl7dc9V8WOSXAluga5Fsr10qdrIjjjJSqyBQGOcaZKnd2clWl0ccaEi7Zcr0sSyb5p937OdzjdEUsmhPjMVRZiWSuUH6LbwmcA9Mf9ND4VjWIaOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 10D8E2DE076A5D; Mon, 28 Sep 2026 17:17:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 21/22] selftests/bpf: Cover more accepted .bpf_cleanup exception shapes
Date: Mon, 28 Sep 2026 17:17:52 -0700
Message-ID: <20260929001752.3256460-1-yonghong.song@linux.dev>
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

The end-to-end test walks one call chain with a pad in most of its frames=
.
This adds the shapes it does not reach, in the order the new file has
them:

 - a pad that reads its frame's callee-saved registers
 - a region ending on a 16-byte instruction
 - a pad terminated by _Unwind_Resume rather than bpf_unwind_resume
 - a pad whose first instruction is a nop
 - a pad that indexes its frame by a register the frame set before the
   unwinding call
 - two pads with an uncovered frame between them
 - a precision chain crossing a resume
 - a frame above an unwind that never returns, keeping no exit of its own=
,
   ending in a jump rather than an exit so the one to keep is not the las=
t
   instruction
 - a region covering an indirect call
 - a pad reached only by a speculative walk, which is loaded but not run
 - a pad that touches a global of each width and sign a tag can name
 - a frame holding a reference across a covered call, its pad the only
   place that releases it

Each shape that runs wants the same three things: an input, a return
value, and the set of landing pads that ran. That is what __set_global(),
__retval() and __ret_global() say, so they say it and RUN_TESTS() does th=
e
rest, which also gives each shape a name of its own in the test output.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/exceptions_cleanup.h        |  12 +
 .../bpf/prog_tests/exceptions_cleanup.c       |   2 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 607 ++++++++++++++++++
 3 files changed, 621 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

diff --git a/tools/testing/selftests/bpf/exceptions_cleanup.h b/tools/tes=
ting/selftests/bpf/exceptions_cleanup.h
index d1d40314035e..616b479238c7 100644
--- a/tools/testing/selftests/bpf/exceptions_cleanup.h
+++ b/tools/testing/selftests/bpf/exceptions_cleanup.h
@@ -10,6 +10,18 @@
 #define RAN_FOO2_DROP		0x8
 #define RAN_BUMP		0x10
=20
+/* progs/exceptions_cleanup_shapes.c: one bit per shape. */
+#define RAN_REGS		0x1
+#define RAN_WIDE_REC		0x2
+#define RAN_RESUME_ALIAS	0x4
+#define RAN_NOP_PAD		0x8
+#define RAN_VAR_STACK		0x10
+#define RAN_GAP_INNER		0x20
+#define RAN_GAP_OUTER		0x40
+#define RAN_NO_EXIT_JA		0x80
+#define RAN_CALLX		0x100
+#define RAN_HELD_REF		0x200
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
index 000000000000..1978fd1102f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
@@ -0,0 +1,607 @@
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
+/* The callee most of the shapes below unwind out of. */
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
+ * A precision chain crossing a resume: r6 is kept across a call whose o=
nly
+ * way back is the callee's pad, then used as a variable stack offset.
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
+	"call prec_inner_frame;"	/* comes back only through the pad */
+	"r2 =3D r10;"
+	"r2 +=3D -16;"
+	"r2 +=3D r6;"			/* variable stack offset: r6 must be precise */
+	"*(u8 *)(r2 + 0) =3D 1;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm_addr(input)
+	: __clobber_all);
+}
+
+SEC("?syscall")
+__success __set_global(input, 101) __retval(0)
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
+ * after the call is reachable, so it keeps no exit and gets no epilogue=
.
+ * This one ends in a jump rather than an exit, so the exit to keep is n=
ot
+ * the last instruction.
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
+int entry_no_exit_ja_mid(void *ctx)
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
+static __used __naked __noinline __u64 callx_unwinder(void)
+{
+	asm volatile (
+	"call bpf_unwind;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked __noinline __u64 callx_region_frame(void)
+{
+	asm volatile (
+	"call bpf_preempt_disable;"
+	"r2 =3D %[callx_unwinder] ll;"
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
+	: [ran]"i"(RAN_CALLX), __imm_addr(callx_unwinder),
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
+#endif /* __clang__ && (x86 || arm64) */
+
+/*
+ * The jump_into_pad shape with the branch statically dead, so only a
+ * speculative walk reaches the pad: a barrier rather than a refusal.
+ */
+static __used __naked __noinline __u64 dead_jump_into_pad_frame(void)
+{
+	asm volatile (
+	"r6 =3D 0;"
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
+	::: __clobber_all);
+}
+
+SEC("?syscall")
+__success
+int dead_jump_into_pad(void *ctx)
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

