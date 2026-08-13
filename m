Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2926A1A4
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651392; cv=none; b=IP0Ptaoi0lV1ccwk9B6707l7o0SIRvG5Zsuh9GLLRCvjcQuIupw6XLx1vHP5dppgyLlL7oXeFrBKPsjnquaReACHMwGtl1Gfd5V8SufXie3VZ4Xkkk31ZArXqftMja58OZUbmgUygbGa18/ahY9pfjfQrHsM349PX3ZE7rUCut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651392; c=relaxed/simple;
	bh=ULzds8kdcaMm8xOGguXclx64e47nzWwuQfwcVheeLag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLIWuYZWqod7BNGObwvV5IGAdAXP25DV5KSDB/n5V3hFfaWq/ovMDJzZdzx5FJNMnIwMiAnpl1o1VwG7ZUjs1oN1+J3AumfGOiIOnICi1rP9O3+DBiRpuGz+t/ftgi0WEMQy22yBv8mt5Nr1ia3siLxbdxRrr9RQtc2docqMYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 04A3623E0355F8; Thu, 13 Aug 2026 13:03:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 10/11] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
Date: Thu, 13 Aug 2026 13:03:01 -0700
Message-ID: <20260813200302.1997359-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add inline-asm tests covering what the C tests cannot reach.
aggregate_ret_func.c exercises BPF-to-BPF returns: subprograms that leave
R2 uninitialised or holding a stack pointer, ones returning a struct or a
union that smuggles a pointer, static and global subprograms whose R2
stays precise under backtracking, and liveness at the exit of a
subprogram returning a pair.

In addition, a negative freplace test checks that an extension cannot
replace a function returning R0:R2: the extension's own return is capped
at 8 bytes, so it would leave R2 stale for the target's callers, and the
load is expected to fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_ret.c  |   4 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  15 +
 .../selftests/bpf/progs/aggregate_ret_func.c  | 260 ++++++++++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c | 122 ++++++++
 .../bpf/progs/aggregate_ret_kfunc_c.c         |  60 ++++
 .../bpf/progs/aggregate_ret_target.c          |  29 ++
 .../bpf/progs/compute_live_registers.c        |  30 ++
 .../selftests/bpf/progs/freplace_ret_pair.c   |  12 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  55 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  35 +++
 10 files changed, 622 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_func.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_targe=
t.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_ret_pair.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
index 979536f3c89c..c295adedbae8 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c
@@ -4,10 +4,14 @@
 #include "aggregate_ret_int128_c.skel.h"
 #include "aggregate_ret_struct_c.skel.h"
 #include "aggregate_ret_kfunc_c.skel.h"
+#include "aggregate_ret_func.skel.h"
+#include "aggregate_ret_kfunc.skel.h"
=20
 void test_aggregate_ret(void)
 {
 	RUN_TESTS(aggregate_ret_int128_c);
 	RUN_TESTS(aggregate_ret_struct_c);
 	RUN_TESTS(aggregate_ret_kfunc_c);
+	RUN_TESTS(aggregate_ret_func);
+	RUN_TESTS(aggregate_ret_kfunc);
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
index 000000000000..cfb21bcf704b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -0,0 +1,260 @@
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
+ * R2 is a return register once the subprogram returns a pair, so a stac=
k
+ * pointer left in it is rejected at the callee's exit exactly as one in=
 R0
+ * is: the callee frame is gone by the time the caller could use it.
+ */
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
+__load_if_JITed()
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
+__load_if_JITed()
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
+__load_if_JITed()
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
index 000000000000..c23b4beb1773
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -0,0 +1,122 @@
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
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
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
+__arch_x86_64 __arch_arm64
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
+__arch_x86_64 __arch_arm64
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
+__arch_x86_64 __arch_arm64
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
+__arch_x86_64 __arch_arm64
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
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c b/=
tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
index b66576307f73..2c1889fc28ef 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_c.c
@@ -50,6 +50,66 @@ int aggregate_ret_kfunc_struct_c_test(struct __sk_buff=
 *skb)
 	return 0;
 }
=20
+/* struct { u64 a; int b; }: 16 bytes, R0 =3D a, R2 =3D b. */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_li_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	int b =3D skb->len ^ MIX_B;
+	struct prog_test_ret_li r;
+
+	r =3D bpf_kfunc_call_test_ret_li(a, b);
+	if (r.a !=3D a)
+		return 1;
+	if (r.b !=3D ~b)
+		return 2;
+
+	return 0;
+}
+
+/* struct { int a; int b; }: 8 bytes, packed into R0; R2 is not a return=
 reg. */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_ii_c_test(struct __sk_buff *skb)
+{
+	int a =3D skb->len ^ MIX_A;
+	int b =3D skb->len ^ MIX_B;
+	struct prog_test_ret_ii r;
+
+	r =3D bpf_kfunc_call_test_ret_ii(a, b);
+	if (r.a !=3D a)
+		return 1;
+	if (r.b !=3D b)
+		return 2;
+
+	return 0;
+}
+
+/* A union of 16 bytes takes the same R0:R2 path as a struct. */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_uu_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	union prog_test_ret_uu r;
+
+	r =3D bpf_kfunc_call_test_ret_uu(a, b);
+	if (r.parts.lo !=3D a + b)
+		return 1;
+	if (r.parts.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
 #else
=20
 SEC("socket")
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
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b=
/tools/testing/selftests/bpf/progs/compute_live_registers.c
index d055fc7b3b95..0be9441ec273 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -431,6 +431,36 @@ __naked void subprog1(void)
 		::: __clobber_all);
 }
=20
+static __used __naked unsigned __int128 aux2(void)
+{
+	asm volatile (
+		"r0 =3D 1;"
+		"r2 =3D 2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+/* A program observing the pair needs the JIT; see bpf_compute_subprog_r=
et_regs(). */
+__load_if_JITed()
+__log_level(2)
+__msg("0: .12345.... (85) call pc+2")
+__msg("1: ..2....... (bf) r0 =3D r2")
+/* R2 is not read at the exit of this program, which returns an int, ...=
 */
+__msg("2: 0......... (95) exit")
+__msg("3: .......... (b7) r0 =3D 1")
+__msg("4: 0......... (b7) r2 =3D 2")
+/* ... but it is at the exit of aux2(), which returns a register pair. *=
/
+__msg("5: 0.2....... (95) exit")
+__naked void subprog_ret_reg_pair(void)
+{
+	asm volatile (
+		"call aux2;"
+		"r0 =3D r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
 #if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
=20
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/freplace_ret_pair.c b/tool=
s/testing/selftests/bpf/progs/freplace_ret_pair.c
new file mode 100644
index 000000000000..12c15d293bd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_ret_pair.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("freplace/agg_ret_target_func")
+__u64 new_agg_ret_target_func(void)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index fc1e43c5038b..ad36d583d2e7 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -951,8 +951,57 @@ __bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call=
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
@@ -1489,7 +1538,13 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
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
index 682f7793d0c2..c7be973cd286 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -60,6 +60,35 @@ struct prog_test_ret_pair {
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
@@ -139,6 +168,12 @@ int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) _=
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

