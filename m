Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BD3E63B5
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541446; cv=none; b=Ey3B3si/kadkumJ5bGq+l2kV47xPeodCBM2CPXFY8Of2U3iAElTh2g6vdpc04BvYmYNpqXWIEjw2C6mQQ6gqZxYupuQi6SYQMK13jPx/zXYUAhgNKVdMu9BgCXU7rqk1WpPPjFK+btZn49lJnqhk1RPt0/7gytAL2y5MTGnqIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541446; c=relaxed/simple;
	bh=hPs4Rm8qsqvEjg+KAh6mNqFLyZGFX0qrxK7fCidMHRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJRzt88rvC+5mjwsomf5B75uXEXoik3A35xQSmilJJEBjmBIO1Zn8fhG9ZssW3jrhdcintrrA43Xr/jGaSScCPXiIhIK0yNeVncjrSTy3FG/qPgb77RKSKXCdyv2s90vanZFYXlW68Rq4JYqTeeejGc1r2veIGJbZGzEnvKROxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0309C1D0B6F9B1; Wed,  8 Jul 2026 13:10:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 10/12] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
Date: Wed,  8 Jul 2026 13:10:30 -0700
Message-ID: <20260708201030.2161016-1-yonghong.song@linux.dev>
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

Add inline-asm and subprogram tests for more coverage, including
BPF-to-BPF cases, kfunc cases, backtracking and liveness. Both positive
and negative tests are added.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  25 ++
 .../selftests/bpf/progs/aggregate_ret_func.c  | 361 ++++++++++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  81 ++++
 .../selftests/bpf/progs/aggregate_ret_run.c   | 160 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  34 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  27 ++
 6 files changed, 688 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_run.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index d4ecc19684ce..2f1e5c704959 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -5,6 +5,9 @@
 #include "aggregate_ret_int128_c.skel.h"
 #include "aggregate_ret_struct_c.skel.h"
 #include "aggregate_ret_union_c.skel.h"
+#include "aggregate_ret_run.skel.h"
+#include "aggregate_ret_func.skel.h"
+#include "aggregate_ret_kfunc.skel.h"
=20
 /*
  * Run one program and check its result. The program returns 0 on succes=
s, or
@@ -39,6 +42,7 @@ void test_aggregate_ret(void)
 	struct aggregate_ret_struct_c *skel_struct_c;
 	struct aggregate_ret_union_c *skel_union_c;
 	struct aggregate_ret_int128_c *skel_c;
+	struct aggregate_ret_run *skel_run;
=20
 	skel_c =3D aggregate_ret_int128_c__open_and_load();
 	if (!ASSERT_OK_PTR(skel_c, "skel_c_open_load"))
@@ -93,4 +97,25 @@ void test_aggregate_ret(void)
 		run_prog(skel_union_c->progs.aggregate_ret_union_c_test, true);
=20
 	aggregate_ret_union_c__destroy(skel_union_c);
+
+	skel_run =3D aggregate_ret_run__open_and_load();
+	if (!ASSERT_OK_PTR(skel_run, "skel_run_open_load"))
+		return;
+
+	/* Inline-asm variant: compiler-version independent, always runs. */
+	if (test__start_subtest("asm"))
+		run_prog(skel_run->progs.aggregate_ret_asm_test, false);
+
+	/* Struct-by-value kfunc returns, also compiler-version independent. */
+	if (test__start_subtest("struct"))
+		run_prog(skel_run->progs.aggregate_ret_struct_test, false);
+
+	/* Union-by-value kfunc return, compiler-version independent. */
+	if (test__start_subtest("union"))
+		run_prog(skel_run->progs.aggregate_ret_union_test, false);
+
+	aggregate_ret_run__destroy(skel_run);
+
+	RUN_TESTS(aggregate_ret_func);
+	RUN_TESTS(aggregate_ret_kfunc);
 }
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
new file mode 100644
index 000000000000..31e176103374
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -0,0 +1,361 @@
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
+static __naked __attribute__((noinline)) u128 static_agg_bad_ptr(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D r10;"	/* stack pointer placed in the second return register */
+	"exit;"
+	);
+}
+
+SEC("tc")
+__failure __msg("cannot return stack pointer to the caller")
+__naked int aggregate_ret_static_ptr_fail(void)
+{
+	asm volatile (
+	"call %[static_agg_bad_ptr];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(static_agg_bad_ptr)
+	: __clobber_all);
+}
+
+static __naked __attribute__((noinline)) u128 static_agg_no_r2(void)
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
+static __naked __attribute__((noinline)) u128 static_agg_precise(void)
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
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
new file mode 100644
index 000000000000..d73d30abed55
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -0,0 +1,81 @@
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
+	  "r"(&bpf_kfunc_call_test_ret_ptr),
+	  "r"(&bpf_kfunc_call_test_ret_ii));
+}
+
+SEC("tc")
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
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_run.c b/tool=
s/testing/selftests/bpf/progs/aggregate_ret_run.c
new file mode 100644
index 000000000000..d6300b31733d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_run.c
@@ -0,0 +1,160 @@
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
+	  "r"(&bpf_kfunc_call_test_ret_ll),
+	  "r"(&bpf_kfunc_call_test_ret_li),
+	  "r"(&bpf_kfunc_call_test_ret_ii),
+	  "r"(&bpf_kfunc_call_test_ret_uu));
+}
+
+#define I128_ASM_LO 0xABCDabcd12345678ULL
+#define I128_ASM_HI 0x1234567890abcdefULL
+
+static __naked __attribute__((noinline)) u128 make_i128_asm(void)
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
+	__u64 a =3D skb->len;
+	__u64 b =3D skb->len ^ 0xdeadbeefULL;
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
+	if (hi !=3D a)
+		return 3;
+	if (lo !=3D b)
+		return 4;
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
+	/* struct { u64 a; u64 b; }: R0 =3D a, R2 =3D b. */
+	asm volatile (
+	"r1 =3D %[a];"
+	"r2 =3D %[b];"
+	"call %[kfunc];"
+	"%[lo] =3D r0;"
+	"%[hi] =3D r2;"
+	: [lo]"=3Dr"(lo), [hi]"=3Dr"(hi)
+	: [a]"r"(a), [b]"r"(b), [kfunc]"i"(bpf_kfunc_call_test_ret_ll)
+	: "r0", "r1", "r2", "r3", "r4", "r5"
+	);
+	if (lo !=3D a)
+		return 1;
+	if (hi !=3D b)
+		return 2;
+
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
+	if ((int)hi !=3D (int)b)
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
+	if (lo !=3D a)
+		return 1;
+	if (hi !=3D b)
+		return 2;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 3511a4873d6c..c9e211d8a719 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -837,6 +837,36 @@ __bpf_kfunc struct bpf_kfunc_ret_ll bpf_kfunc_call_t=
est_ret_ll(u64 a, u64 b)
 	return r;
 }
=20
+__bpf_kfunc struct bpf_kfunc_ret_li bpf_kfunc_call_test_ret_li(u64 a, in=
t b)
+{
+	struct bpf_kfunc_ret_li r =3D { .a =3D a, .b =3D b };
+
+	return r;
+}
+
+__bpf_kfunc struct bpf_kfunc_ret_ii bpf_kfunc_call_test_ret_ii(int a, in=
t b)
+{
+	struct bpf_kfunc_ret_ii r =3D { .a =3D a, .b =3D b };
+
+	return r;
+}
+
+__bpf_kfunc union bpf_kfunc_ret_uu bpf_kfunc_call_test_ret_uu(u64 a, u64=
 b)
+{
+	union bpf_kfunc_ret_uu r;
+
+	r.halves[0] =3D a;
+	r.halves[1] =3D b;
+	return r;
+}
+
+__bpf_kfunc struct bpf_kfunc_ret_ptr bpf_kfunc_call_test_ret_ptr(u64 tag=
)
+{
+	struct bpf_kfunc_ret_ptr r =3D { .p =3D NULL, .tag =3D tag };
+
+	return r;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
 					 u64 e, u64 f, u64 g, u64 h,
 					 u64 i, u64 j)
@@ -1372,6 +1402,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ll)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_li)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_uu)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 34d0a352e70d..9ac31d68e2c8 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -64,6 +64,29 @@ struct bpf_kfunc_ret_ll {	/* 16 bytes: R0:R2 */
 	__u64 b;
 };
=20
+struct bpf_kfunc_ret_li {	/* 16 bytes: R0:R2 */
+	__u64 a;
+	int b;
+};
+
+struct bpf_kfunc_ret_ii {	/* 8 bytes: R0 only */
+	int a;
+	int b;
+};
+
+union bpf_kfunc_ret_uu {	/* 16 bytes: R0:R2 */
+	__u64 halves[2];
+	struct {
+		__u64 lo;
+		__u64 hi;
+	} parts;
+};
+
+struct bpf_kfunc_ret_ptr {	/* 16 bytes: contains a pointer */
+	void *p;
+	__u64 tag;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -129,6 +152,10 @@ long bpf_kfunc_call_test4(signed char a, short b, in=
t c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
 __int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
 struct bpf_kfunc_ret_ll bpf_kfunc_call_test_ret_ll(__u64 a, __u64 b) __k=
sym;
+struct bpf_kfunc_ret_li bpf_kfunc_call_test_ret_li(__u64 a, int b) __ksy=
m;
+struct bpf_kfunc_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
+union bpf_kfunc_ret_uu bpf_kfunc_call_test_ret_uu(__u64 a, __u64 b) __ks=
ym;
+struct bpf_kfunc_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
 			       __u64 i, __u64 j) __ksym;
--=20
2.53.0-Meta

