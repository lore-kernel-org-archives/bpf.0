Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316F1DED49
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407023; cv=none; b=lK6yXVvC+qXxzE7e6WgxbJKRh8Flmc/waGrHjMJOWDPcpL1F3FraEKWqWuWyx5Pe/nS/4Fbk27Byl8GE6iemOdpsman4X7GEVP1MK75ErGGZ/EH08GfNLs0jnDA5dJQ6LV8XrFTysDUSVzWk4hHj34ffpOcuKA9dOSF/XZg+SUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407023; c=relaxed/simple;
	bh=f763dgpFoC1DdFrzIj3RJpuRxpGZ6gsAlEVE4E+7Xg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxToQxVQEWaYwA8UrRKZOVT4G95dGfHRlyMrscHvCR7G3RXrAEYk5vDrB+3PFneprLJF2TUXWp9SuoNaBCMTOJUDG1tOAaoWcaiZZrCigh8hk4NEvZO8aL75oNLsaygOLRTW7F+yjpl9IuAN3ay2P8Pu+3qPKJtlPUX7BPaO4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 155AD233CF2827; Mon, 10 Aug 2026 17:10:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 11/13] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
Date: Mon, 10 Aug 2026 17:10:08 -0700
Message-ID: <20260811001008.2383983-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811000911.2378679-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add inline-asm tests, which do not depend on the compiler lowering a
register-pair return and so run regardless of the LLVM version, covering
what the C tests cannot reach. aggregate_ret_func.c exercises BPF-to-BPF
returns: a global subprogram whose R2 the caller may read, ones that leav=
e
R2 uninitialised or holding a pointer, a static subprogram whose R2 stays
precise under backtracking, R2 liveness across a call, and a >8 byte retu=
rn
at program exit. Six kfuncs returning aggregates by value are added to
bpf_testmod, and aggregate_ret_run.c calls them from inline asm to check
what comes back in R0:R2.

A negative arena test is added as well: a global subprogram with a
register-pair return that leaves an arena pointer in R2 is rejected, sinc=
e
an arena pointer is only a valid return value when it is returned in R0
alone.

Three cases cover the boundaries of the new convention:

 - A return value larger than 16 bytes does not fit in R0:R2 and is
   rejected by btf_distill_func_proto(), ahead of the KF_FASTCALL and
   JIT-capability checks; one of the new kfuncs returns a 24-byte struct
   for this. The equivalent for a BPF subprogram cannot be written in C:
   from LLVM 23 on, a by-value return larger than 16 bytes is lowered to =
an
   sret pointer argument and the BTF the verifier reads says the function
   returns void, so the size bound in btf_validate_return_type() only
   guards hand-crafted BTF.

 - A static subprogram returning a struct that contains a pointer is
   accepted, and the caller can use the returned pointer. Unlike a global
   subprogram, whose caller models the return as an opaque scalar pair, a
   static one is verified inline, so prepare_func_exit() hands the caller
   real register state and the pointer stays tracked.

 - An extension cannot replace a function returning more than 8 bytes.
   btf_check_type_match() does not catch this, since it compares return
   types by btf_type->info alone and both an __int128 and a __u64 are
   BTF_KIND_INT with no vlen, so the rejection has to come from
   bpf_check_attach_target(). The test reuses the freplace failure harnes=
s
   in fexit_bpf2bpf.c, with aggregate_ret_target.c providing a target who=
se
   global subprogram returns in R0:R2.

The kfunc tests need the JIT to place the second half of a return value
into R2, which bpf_add_kfunc_call() only allows where
bpf_jit_supports_kfunc_ret_reg_pair() is true. In aggregate_ret_kfunc.c t=
he
two tests that depend on getting past that check are tagged
__arch_x86_64/__arch_arm64/__arch_riscv64; the others are rejected earlie=
r
(on KF_FASTCALL, on a >16 byte return, and on reading R2 after an 8-byte
struct return). In aggregate_ret_run.c the kfunc-calling programs are
dropped from the object when the load reports -EOPNOTSUPP and their
subtests are skipped, and the __int128 inline-asm test is split into a
BPF-to-BPF half, which needs no JIT capability and runs everywhere, and a
kfunc half.

Five of the six new kfuncs return a struct or union by value and take
arguments, so they join the x86_64/arm64 guard added in the previous patc=
h;
see the comment there. That includes the one returning only 8 bytes: s390=
x
hands back a by-value aggregate through an sret pointer whatever its size=
,
so its declared arguments are displaced just the same and pahole skips th=
e
function. The sixth returns 24 bytes but takes no argument, leaving nothi=
ng
for the sret pointer to displace, and pahole does encode it there.
Both objects calling the guarded kfuncs reference every one of them from
__kfunc_btf_root(), so neither can load at all where those kfuncs are
absent; the aggregate_ret_kfunc tests and the four aggregate_ret_run
subtests are skipped as a group elsewhere. aggregate_ret_func.c calls no
kfunc and keeps running everywhere.

R0 holds bytes 0..7 of a return value and R2 bytes 8..15, so where a memb=
er
sits inside a register depends on the endianness of the target. The check=
s
in aggregate_ret_run.c that read a member out of half a register are buil=
t
for a little-endian target only; arm64 is the one JIT implementing the pa=
ir
that can be built big endian, and that configuration is left for later.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  58 +++
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  15 +
 .../selftests/bpf/progs/aggregate_ret_func.c  | 420 ++++++++++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c | 126 ++++++
 .../selftests/bpf/progs/aggregate_ret_run.c   | 178 ++++++++
 .../bpf/progs/aggregate_ret_target.c          |  29 ++
 .../selftests/bpf/progs/freplace_ret_pair.c   |  20 +
 .../selftests/bpf/progs/verifier_arena.c      |  38 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  55 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  35 ++
 10 files changed, 974 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_targe=
t.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_ret_pair.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index bd18bad17472..8be64d01ff4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -5,6 +5,9 @@
 #include "aggregate_ret_struct_c.skel.h"
 #include "aggregate_ret_union_c.skel.h"
 #include "aggregate_ret_kfunc_c.skel.h"
+#include "aggregate_ret_run.skel.h"
+#include "aggregate_ret_func.skel.h"
+#include "aggregate_ret_kfunc.skel.h"
=20
 /*
  * The bpf_testmod kfuncs returning more than 8 bytes are only built on =
x86_64
@@ -139,10 +142,65 @@ static void test_kfunc_c(void)
 	aggregate_ret_kfunc_c__destroy(skel);
 }
=20
+static void test_run(void)
+{
+	struct aggregate_ret_run *skel;
+	bool kfunc_ok =3D true;
+	int err;
+
+	/*
+	 * Every program in this object shares __kfunc_btf_root(), so where the
+	 * testmod kfuncs are absent the object cannot load at all -- including
+	 * for the kfunc-free "asm" subtest.
+	 */
+	if (!has_ret_pair_kfuncs()) {
+		run_subtest("asm", NULL, false);
+		run_subtest("asm_kfunc", NULL, false);
+		run_subtest("struct", NULL, false);
+		run_subtest("union", NULL, false);
+		return;
+	}
+
+	skel =3D aggregate_ret_run__open();
+	if (!ASSERT_OK_PTR(skel, "skel_run_open"))
+		return;
+
+	err =3D aggregate_ret_run__load(skel);
+	if (err =3D=3D -EOPNOTSUPP) {
+		kfunc_ok =3D false;
+		aggregate_ret_run__destroy(skel);
+
+		skel =3D aggregate_ret_run__open();
+		if (!ASSERT_OK_PTR(skel, "skel_run_reopen"))
+			return;
+
+		bpf_program__set_autoload(skel->progs.aggregate_ret_asm_kfunc_test, fa=
lse);
+		bpf_program__set_autoload(skel->progs.aggregate_ret_struct_test, false=
);
+		bpf_program__set_autoload(skel->progs.aggregate_ret_union_test, false)=
;
+
+		err =3D aggregate_ret_run__load(skel);
+	}
+	if (!ASSERT_OK(err, "skel_run_load"))
+		goto out;
+
+	run_subtest("asm", skel->progs.aggregate_ret_asm_test, true);
+	run_subtest("asm_kfunc", skel->progs.aggregate_ret_asm_kfunc_test, kfun=
c_ok);
+	run_subtest("struct", skel->progs.aggregate_ret_struct_test, kfunc_ok);
+	run_subtest("union", skel->progs.aggregate_ret_union_test, kfunc_ok);
+
+out:
+	aggregate_ret_run__destroy(skel);
+}
+
 void test_aggregate_ret(void)
 {
 	test_int128_c();
 	test_struct_c();
 	test_union_c();
 	test_kfunc_c();
+	test_run();
+
+	RUN_TESTS(aggregate_ret_func);
+	if (has_ret_pair_kfuncs())
+		RUN_TESTS(aggregate_ret_kfunc);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 2523c07a16c6..0b54f911015c 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -441,6 +441,19 @@ static void test_func_replace_int_with_void(void)
 				     " doesn't match type INT of global_func2()");
 }
=20
+static void test_func_replace_ret_pair(void)
+{
+	const char *msg =3D "Cannot replace function agg_ret_target_func with a=
 >8 byte return";
+
+	/*
+	 * An extension cannot replace a function whose return value comes back
+	 * in the R0:R2 pair: the extension's own return is capped at 8 bytes,
+	 * so it would leave R2 stale for the target's callers.
+	 */
+	test_obj_load_failure_common("freplace_ret_pair.bpf.o",
+				     "./aggregate_ret_target.bpf.o", msg);
+}
+
 static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 {
 	struct bpf_prog_info info =3D {};
@@ -660,6 +673,8 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace_progmap();
 	if (test__start_subtest("freplace_int_with_void"))
 		test_func_replace_int_with_void();
+	if (test__start_subtest("freplace_ret_pair"))
+		test_func_replace_ret_pair();
 	if (test__start_subtest("freplace_void"))
 		test_func_replace_void();
 	if (test__start_subtest("sleepable_fentry_to_xdp"))
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
new file mode 100644
index 000000000000..0bc18450a46e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+typedef unsigned __int128 u128;
+
+__naked u128 global_agg_good(void)
+{
+	asm volatile (
+	"r0 =3D 0x1234;"	/* low 64 bits */
+	"r2 =3D 0x5678;"	/* high 64 bits */
+	"exit;"
+	);
+}
+
+__naked u128 global_agg_bad(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"exit;"
+	);
+}
+
+__naked u128 global_agg_bad_ptr(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D r10;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_ret_global(void *ctx)
+{
+	__u64 lo, hi;
+
+	asm volatile (
+	"call %[global_agg_good];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: __imm(global_agg_good)
+	: "r0", "r1", "r2", "r3", "r4", "r5");
+	if (lo !=3D 0x1234)
+		return 1;
+	if (hi !=3D 0x5678)
+		return 2;
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("R2 !read_ok")
+__naked int aggregate_ret_global_fail(void)
+{
+	asm volatile (
+	"call %[global_agg_bad];"
+	"r0 =3D r2;"
+	"exit;"
+	:
+	: __imm(global_agg_bad)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("At subprogram exit the register R2 is not a scalar valu=
e")
+__naked int aggregate_ret_global_ptr_fail(void)
+{
+	asm volatile (
+	"call %[global_agg_bad_ptr];"
+	"r0 =3D r2;"
+	"exit;"
+	:
+	: __imm(global_agg_bad_ptr)
+	: __clobber_all);
+}
+
+static __naked __noinline u128 static_agg_bad_ptr(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D r10;"	/* stack pointer placed in the second return register */
+	"exit;"
+	);
+}
+
+/*
+ * R2 is caller-saved and only copied from the callee at exit; a PTR_TO_=
STACK
+ * left in it is turned into an uninitialized R2 in the caller. A caller=
 that
+ * never reads R2 is therefore unaffected and loads fine.
+ */
+SEC("tc")
+__success __retval(0)
+__naked int aggregate_ret_static_ptr_unused(void)
+{
+	asm volatile (
+	"call %[static_agg_bad_ptr];"
+	"r0 =3D 0;"		/* R2 holds a stack pointer but is never read */
+	"exit;"
+	:
+	: __imm(static_agg_bad_ptr)
+	: __clobber_all);
+}
+
+/* But a caller that does read the returned stack pointer is rejected. *=
/
+SEC("tc")
+__failure __msg("R2 !read_ok")
+__naked int aggregate_ret_static_ptr_read_fail(void)
+{
+	asm volatile (
+	"call %[static_agg_bad_ptr];"
+	"r0 =3D r2;"		/* using the returned stack pointer is rejected */
+	"exit;"
+	:
+	: __imm(static_agg_bad_ptr)
+	: __clobber_all);
+}
+
+static __naked __noinline u128 static_agg_no_r2(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__failure __msg("R2 !read_ok")
+__naked int aggregate_ret_static_uninit_fail(void)
+{
+	asm volatile (
+	"call %[static_agg_no_r2];"
+	"r0 =3D r2;"
+	"exit;"
+	:
+	: __imm(static_agg_no_r2)
+	: __clobber_all);
+}
+
+static __naked __noinline u128 static_agg_precise(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 4;"	/* second half; its value is made precise below */
+	"exit;"
+	);
+}
+
+SEC("tc")
+__success __retval(0)
+__log_level(2)
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (57) r6 &=3D 7=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 1: (bf) r6 =3D r2=
")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 12: (95) exit")
+__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 11: (b7) r2 =3D 4=
")
+__naked int aggregate_ret_static_precise(void)
+{
+	asm volatile (
+	"call %[static_agg_precise];"
+	"r6 =3D r2;"		/* derived from the aggregate's second half */
+	"r6 &=3D 7;"		/* keep it in [0, 7] to index the stack */
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+	"r1 +=3D r6;"		/* ptr +=3D scalar marks r6 (hence R2) precise */
+	"r0 =3D 0;"
+	"*(u8 *)(r1 + 0) =3D r0;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(static_agg_precise)
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0)
+__log_level(2)
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (57) r6 &=3D 7=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 1: (bf) r6 =3D r2=
")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 0: (85) call pc+9=
")
+__naked int aggregate_ret_global_precise(void)
+{
+	asm volatile (
+	"call %[global_agg_good];"
+	"r6 =3D r2;"		/* derived from the aggregate's second half */
+	"r6 &=3D 7;"		/* keep it in [0, 7] to index the stack */
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+	"r1 +=3D r6;"		/* ptr +=3D scalar marks r6 (hence R2) precise */
+	"r0 =3D 0;"
+	"*(u8 *)(r1 + 0) =3D r0;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_agg_good)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("return value larger than 8 bytes is not supported at pr=
ogram exit")
+__naked u128 aggregate_ret_entry_fail(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+#if __clang_major__ >=3D 23
+
+struct pair {
+	__u64 hi;
+	__u64 lo;
+};
+
+union upair {
+	__u64 halves[2];
+	struct {
+		__u64 lo;
+		__u64 hi;
+	} parts;
+};
+
+/* A by-value struct that smuggles a pointer, which must be rejected. */
+struct with_ptr {
+	void *p;
+	__u64 x;
+};
+
+/* A by-value union that smuggles a pointer, which must be rejected too.=
 */
+union upair_with_ptr {
+	void *p;
+	__u64 halves[2];
+};
+
+/* Global subprogram returning a scalar-only 16-byte struct in R0:R2. */
+__naked struct pair global_ret_struct(void)
+{
+	asm volatile (
+	"r0 =3D 0x1234;"	/* struct's first half */
+	"r2 =3D 0x5678;"	/* struct's second half */
+	"exit;"
+	);
+}
+
+/* Global subprogram returning a scalar-only 16-byte union in R0:R2. */
+__naked union upair global_ret_union(void)
+{
+	asm volatile (
+	"r0 =3D 0x1234;"
+	"r2 =3D 0x5678;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_ret_global_struct(void *ctx)
+{
+	__u64 lo, hi;
+
+	asm volatile (
+	"call %[global_ret_struct];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: __imm(global_ret_struct)
+	: "r0", "r1", "r2", "r3", "r4", "r5");
+	if (lo !=3D 0x1234)
+		return 1;
+	if (hi !=3D 0x5678)
+		return 2;
+	return 0;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_ret_global_union(void *ctx)
+{
+	__u64 lo, hi;
+
+	asm volatile (
+	"call %[global_ret_union];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: __imm(global_ret_union)
+	: "r0", "r1", "r2", "r3", "r4", "r5");
+	if (lo !=3D 0x1234)
+		return 1;
+	if (hi !=3D 0x5678)
+		return 2;
+	return 0;
+}
+
+__naked struct with_ptr global_ret_struct_ptr(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__failure __msg("Global function global_ret_struct_ptr() has unsupported=
 return type")
+__naked int aggregate_ret_global_struct_ptr_fail(void)
+{
+	asm volatile (
+	"call %[global_ret_struct_ptr];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_struct_ptr)
+	: __clobber_all);
+}
+
+__naked union upair_with_ptr global_ret_union_ptr(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__failure __msg("Global function global_ret_union_ptr() has unsupported =
return type")
+__naked int aggregate_ret_global_union_ptr_fail(void)
+{
+	asm volatile (
+	"call %[global_ret_union_ptr];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_union_ptr)
+	: __clobber_all);
+}
+
+#endif /* __clang_major__ >=3D 23 */
+
+static __naked u128 agg_callee(void)
+{
+	asm volatile (
+	"r0 =3D 1;"
+	"r2 =3D 2;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__log_level(2)
+__msg("Live regs before insn:")
+/*
+ * R2 is read at the exit of agg_callee() (insn 5), which returns a pair=
, but
+ * not at the exit of this program (insn 2), which returns an int.
+ */
+__msg("0: .12345.... (85) call pc+2")
+__msg("1: ..2....... (bf) r0 =3D r2")
+__msg("2: 0......... (95) exit")
+__msg("3: .......... (b7) r0 =3D 1")
+__msg("4: 0......... (b7) r2 =3D 2")
+__msg("5: 0.2....... (95) exit")
+__naked int aggregate_ret_live(void)
+{
+	asm volatile (
+	"call %[agg_callee];"
+	"r0 =3D r2;"
+	"exit;"
+	:
+	: [agg_callee]"i"(agg_callee)
+	: __clobber_all);
+}
+
+/*
+ * A static subprogram is verified inline, so prepare_func_exit() hands =
the
+ * caller the callee's actual R0:R2 register state rather than an opaque=
 scalar
+ * pair. A pointer in the returned struct therefore stays tracked and is=
 usable
+ * by the caller, which is why btf_validate_return_type() does not apply=
 the
+ * scalar-only restriction to a local function. Return the context point=
er as
+ * the upper half and dereference it in the caller.
+ */
+struct ptr_pair {
+	void *p;
+	__u64 x;
+};
+
+static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D r1;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__success __retval(0)
+__naked int aggregate_ret_static_ptr_pair(void)
+{
+	asm volatile (
+	"call %[static_ret_ptr_pair];"
+	"r1 =3D *(u32 *)(r2 + 0);"	/* deref the returned ctx pointer */
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(static_ret_ptr_pair)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
new file mode 100644
index 000000000000..617724aa7015
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/*
+ * Reference kfunc addresses to force those BTF to be emitted. Taking th=
e address
+ * (rather than calling) avoids any dependence on the compiler lowering =
an
+ * __int128 or struct return value, which the BPF backend only supports =
from
+ * LLVM 23 on.
+ */
+void __kfunc_btf_root(void)
+{
+	asm volatile (""
+	:
+	: "r"(&bpf_kfunc_call_test_i128),
+	  "r"(&bpf_kfunc_call_test_ret_fastcall),
+	  "r"(&bpf_kfunc_call_test_ret_ptr),
+	  "r"(&bpf_kfunc_call_test_ret_ii),
+	  "r"(&bpf_kfunc_call_test_ret_big));
+}
+
+/*
+ * bpf_add_kfunc_call() rejects a kfunc returning more than 8 bytes unle=
ss the
+ * JIT advertises bpf_jit_supports_kfunc_ret_reg_pair(), so a test that =
has to
+ * get past it is tagged with the architectures implementing it. The two=
 tests
+ * below that are rejected earlier, on KF_FASTCALL or on reading R2 afte=
r an
+ * 8-byte struct return, behave the same everywhere and are not tagged.
+ */
+
+SEC("tc")
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__success __retval(0)
+__log_level(2)
+__msg("mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 6: (07) r1 +=3D -=
8")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 5: (bf) r1 =3D r1=
0")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (57) r6 &=3D 7=
")
+__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r6 =3D r2=
")
+__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 2: (85) call bpf_=
kfunc_call_test_i128")
+__naked int aggregate_ret_kfunc_precise(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"r2 =3D 2;"
+	"call %[bpf_kfunc_call_test_i128];"
+	"r6 =3D r2;"		/* second return half */
+	"r6 &=3D 7;"		/* keep it in [0, 7] to index the stack */
+	"r1 =3D r10;"
+	"r1 +=3D -8;"
+	"r1 +=3D r6;"		/* ptr +=3D scalar marks r6 (hence R2) precise */
+	"r0 =3D 0;"
+	"*(u8 *)(r1 + 0) =3D r0;"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_i128)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("kfunc bpf_kfunc_call_test_ret_fastcall with >8-byte ret=
urn is not supported with KF_FASTCALL")
+__naked int aggregate_ret_kfunc_fastcall_fail(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"r2 =3D 2;"
+	"call %[bpf_kfunc_call_test_ret_fastcall];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_fastcall)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__failure __msg("is not composed of scalars")
+__naked int aggregate_ret_kfunc_ptr_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"call %[bpf_kfunc_call_test_ret_ptr];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_ptr)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("R2 !read_ok")
+__naked int aggregate_ret_kfunc_small_no_r2(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"call %[bpf_kfunc_call_test_ret_ii];"
+	"r0 =3D r2;"	/* R2 is not a return register for a <=3D8 byte struct */
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_ii)
+	: __clobber_all);
+}
+
+/*
+ * A return value larger than 16 bytes does not fit in R0:R2 and is reje=
cted by
+ * btf_distill_func_proto(), before the KF_FASTCALL and JIT-capability c=
hecks,
+ * so this behaves the same on every architecture.
+ */
+SEC("tc")
+__failure __msg("The function bpf_kfunc_call_test_ret_big return type ST=
RUCT is unsupported")
+__naked int aggregate_ret_kfunc_too_big_fail(void)
+{
+	asm volatile (
+	"call %[bpf_kfunc_call_test_ret_big];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_big)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c
new file mode 100644
index 000000000000..382ef3b90037
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+typedef unsigned __int128 u128;
+
+/*
+ * Reference kfunc addresses to force those BTF to be emitted. Taking th=
e address
+ * (rather than calling) avoids any dependence on the compiler lowering =
an __int128
+ * or struct return value, which the BPF backend only supports from LLVM=
 23 on.
+ */
+void __kfunc_btf_root(void)
+{
+	asm volatile (""
+	:
+	: "r"(&bpf_kfunc_call_test_i128),
+	  "r"(&bpf_kfunc_call_test_ret_pair),
+	  "r"(&bpf_kfunc_call_test_ret_li),
+	  "r"(&bpf_kfunc_call_test_ret_ii),
+	  "r"(&bpf_kfunc_call_test_ret_uu));
+}
+
+#define I128_ASM_LO 0xABCDabcd12345678ULL
+#define I128_ASM_HI 0x1234567890abcdefULL
+
+static __naked __noinline u128 make_i128_asm(void)
+{
+	asm volatile (
+	"r0 =3D %[lo] ll;"	/* low 64 bits */
+	"r2 =3D %[hi] ll;"	/* high 64 bits */
+	"exit;"
+	:
+	: __imm_const(lo, I128_ASM_LO), __imm_const(hi, I128_ASM_HI)
+	);
+}
+
+SEC("tc")
+int aggregate_ret_asm_test(struct __sk_buff *skb)
+{
+	__u64 lo, hi;
+
+	asm volatile (
+	"call %[callee];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [callee]"i"(make_i128_asm)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (lo !=3D I128_ASM_LO)
+		return 1;
+	if (hi !=3D I128_ASM_HI)
+		return 2;
+
+	return 0;
+}
+
+/*
+ * R0 holds bytes 0..7 of a kfunc return value and R2 bytes 8..15, so wh=
ere a
+ * member sits inside a register depends on the endianness of the target=
.
+ * Although arm64 supports both little and big endian, for simplicity, o=
nly
+ * do little endian for now..
+ */
+SEC("tc")
+int aggregate_ret_asm_kfunc_test(struct __sk_buff *skb)
+{
+#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	__u64 lo, hi;
+
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_i128)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (hi !=3D a + b)
+		return 1;
+	if (lo !=3D a - b)
+		return 2;
+#endif
+
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_struct_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	__u64 lo, hi;
+
+	/* struct { u64 hi; u64 lo; }: R0 =3D hi, R2 =3D lo. */
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_pair)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (lo !=3D a + b)
+		return 1;
+	if (hi !=3D a - b)
+		return 2;
+
+#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
+	/* struct { u64 a; int b; }: R0 =3D a, low 32 bits of R2 =3D b. */
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_li)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (lo !=3D a)
+		return 3;
+	if ((int)hi !=3D ~(int)b)
+		return 4;
+
+	/* struct { int a; int b; }: 8 bytes, packed into R0; R2 is not used. *=
/
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	: [lo]"=3Dr"(lo)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_ii)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if ((int)lo !=3D (int)a)
+		return 5;
+	if ((int)(lo >> 32) !=3D (int)b)
+		return 6;
+#endif
+
+	return 0;
+}
+
+SEC("tc")
+int aggregate_ret_union_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
+	__u64 lo, hi;
+
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_uu)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (lo !=3D a + b)
+		return 1;
+	if (hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_target.c b/t=
ools/testing/selftests/bpf/progs/aggregate_ret_target.c
new file mode 100644
index 000000000000..cffd8d7d3241
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_target.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* freplace target: a global subprogram returning 16 bytes in R0:R2. */
+__naked unsigned __int128 agg_ret_target_func(void)
+{
+	asm volatile (
+	"r0 =3D 0x1234;"
+	"r2 =3D 0x5678;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__naked int agg_ret_target(void)
+{
+	asm volatile (
+	"call %[agg_ret_target_func];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(agg_ret_target_func)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_ret_pair.c b/tool=
s/testing/selftests/bpf/progs/freplace_ret_pair.c
new file mode 100644
index 000000000000..84b701402ca6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_ret_pair.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/*
+ * An extension replaces its target outright, so it has to match the tar=
get's
+ * return convention. Its own return value is capped at 8 bytes, so it c=
an
+ * never fill the R0:R2 pair that the target's callers read, and the att=
ach is
+ * rejected. btf_check_type_match() cannot catch this: it compares retur=
n types
+ * by btf_type->info only, and an int carries no vlen, so the __u64 here=
 and
+ * the target's __int128 compare equal.
+ */
+SEC("freplace/agg_ret_target_func")
+__u64 new_agg_ret_target_func(void)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
index b241bbcf54a8..455b55296f35 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -704,4 +704,42 @@ int check_arena_arg_ret(void *ctx)
 	return 0;
 }
=20
+struct arena_ret_pair {
+	__u64 lo;
+	__u64 hi;
+};
+
+/*
+ * A 16-byte value is returned in the R0:R2 register pair. A global subp=
rogram
+ * may return an arena pointer in R0, but R2 holds the upper half of a s=
calar
+ * pair, so an arena pointer there is not a valid return value. The ld_i=
mm64 of
+ * the arena map is what links the arena to the program, without which t=
he
+ * addr_space_cast insn is not allowed.
+ */
+__naked struct arena_ret_pair global_ret_arena_ptr_in_r2(void)
+{
+	asm volatile (
+		"r1 =3D %[arena] ll;"
+		"r2 =3D 8192;"
+		"r2 =3D addr_space_cast(r2, 0x0, 0x1);"
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm_addr(arena)
+		: __clobber_all);
+}
+
+SEC("syscall")
+__failure __msg("At subprogram exit the register R2 is not a scalar valu=
e (arena)")
+__naked int check_global_ret_arena_ptr_in_r2(void)
+{
+	asm volatile (
+		"call %[global_ret_arena_ptr_in_r2];"
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm(global_ret_arena_ptr_in_r2)
+		: __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 242d3e2913dc..9ef95983da3c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -965,8 +965,57 @@ __bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call=
_test_ret_pair(u64 a, u64 b)
=20
 	return r;
 }
+
+__bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(u=
64 a, u64 b)
+{
+	struct prog_test_ret_pair r =3D { .hi =3D a + b, .lo =3D a - b };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_li bpf_kfunc_call_test_ret_li(u64 a, in=
t b)
+{
+	struct prog_test_ret_li r =3D { .a =3D a, .b =3D ~b };
+
+	return r;
+}
+
+__bpf_kfunc union prog_test_ret_uu bpf_kfunc_call_test_ret_uu(u64 a, u64=
 b)
+{
+	union prog_test_ret_uu r;
+
+	r.halves[0] =3D a + b;
+	r.halves[1] =3D a - b;
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(u64 tag=
)
+{
+	struct prog_test_ret_ptr r =3D { .p =3D NULL, .tag =3D tag };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, in=
t b)
+{
+	struct prog_test_ret_ii r =3D { .a =3D a, .b =3D b };
+
+	return r;
+}
 #endif /* __x86_64__ || __aarch64__ */
=20
+/*
+ * Takes no argument on purpose: with no arguments there is nothing for =
the sret
+ * pointer to displace, so this needs no architecture guard even though =
it
+ * returns 24 bytes. See the comment on bpf_kfunc_call_test_i128() above=
.
+ */
+__bpf_kfunc struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void)
+{
+	struct prog_test_ret_big r =3D { .a =3D 1, .b =3D 2, .c =3D 3 };
+
+	return r;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
 					 u64 e, u64 f, u64 g, u64 h,
 					 u64 i, u64 j)
@@ -1503,7 +1552,13 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
 #if defined(__x86_64__) || defined(__aarch64__)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_fastcall, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_li)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_uu)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
 #endif
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b190917f36b8..755973793e9b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -64,6 +64,35 @@ struct prog_test_ret_pair {
 	__u64 lo;
 };
=20
+struct prog_test_ret_li {	/* 16 bytes: R0:R2 */
+	__u64 a;
+	int b;
+};
+
+struct prog_test_ret_ii {	/* 8 bytes: R0 only */
+	int a;
+	int b;
+};
+
+union prog_test_ret_uu {	/* 16 bytes: R0:R2 */
+	__u64 halves[2];
+	struct {
+		__u64 lo;
+		__u64 hi;
+	} parts;
+};
+
+struct prog_test_ret_ptr {	/* 16 bytes: contains a pointer */
+	void *p;
+	__u64 tag;
+};
+
+struct prog_test_ret_big {	/* 24 bytes: too large for R0:R2 */
+	__u64 a;
+	__u64 b;
+	__u64 c;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -143,6 +172,12 @@ int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) _=
_ksym;
 __int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
 #endif
 struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(__u64 a, __u64 b)=
 __ksym;
+struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(__u64 a, __u6=
4 b) __ksym;
+struct prog_test_ret_li bpf_kfunc_call_test_ret_li(__u64 a, int b) __ksy=
m;
+struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
+union prog_test_ret_uu bpf_kfunc_call_test_ret_uu(__u64 a, __u64 b) __ks=
ym;
+struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
+struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
 			       __u64 i, __u64 j) __ksym;
--=20
2.53.0-Meta

