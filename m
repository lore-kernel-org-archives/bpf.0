Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AACD498933
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141829; cv=none; b=EY+ItCQVsJcnXidCYI4FePG29EgtSX8MXeppYxhO3JQANd9oKcoOiuwXvJ5IMJMuMV5BC/P1xe/tZ0Iwty9JWoTHxzx1W2RymleTfTnaRk01mfCYCc/IfsX/80CJcUNNMPpSYd1oEhZhbvai6Of4W7yl9bLgUHU44l9MgtIvQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141829; c=relaxed/simple;
	bh=8vOYXOEpYGnuciTjFvZntQTzKMnhDqZjUjMYRekS1UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NstXvMeUIdDyKZctMrwcpcPr+uQts2Q5kYwnXn9JwL6gnJRSqZgM5aYJ7WxD16Qt3s3rgcF7n0hT2uGGOVwr+f6xC/PQ6M92CjjStoSOdHitC86BK+ThD8Aj4rhfRAt5A7LPoY5nzdop55yfxIB9lUnu7iORZdSODn1x3oxJB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 84B262A18431AB; Fri, 11 Sep 2026 08:50:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 14/15] selftests/bpf: Add tests for by-value kfunc arguments
Date: Fri, 11 Sep 2026 08:50:25 -0700
Message-ID: <20260911155025.2012309-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add kfuncs taking a 16-byte struct and an __int128 by value, with
combinations of <=3D 8 byte arguments and '> 8 && <=3D 16' byte arguments=
.
Every test checks the value the kfunc returns, so a misplaced argument
shows up rather than passing quietly.

There are some cases with __int128 as the register argument. For such
arguments, arm64 requires the argument to start at an even slot while
x86-64 has no such requirement.

Two more cover a rejection. An aggregate holding a pointer is refused
everywhere, and in arena_kfunc.c a two-slot struct pushes an arena
pointer past the argument registers, which is refused too. An aggregate
too large to pass by value is already covered in aggregate_arg_func.c.

test_stack_arg_big() in stack_arg_fail.c passed a 16-byte struct as the
sixth argument and asserted the unrecognized stack argument type it used
to be reported as. The JIT places that argument now, so the test is
removed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |   2 +
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 231 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  15 ++
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 -
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  77 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  32 +++
 6 files changed, 357 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_arg.c
index b230f3bd3b2a..aa7562f48737 100644
--- a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
@@ -2,8 +2,10 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include "aggregate_arg_func.skel.h"
+#include "aggregate_arg_kfunc.skel.h"
=20
 void test_aggregate_arg(void)
 {
 	RUN_TESTS(aggregate_arg_func);
+	RUN_TESTS(aggregate_arg_kfunc);
 }
diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
new file mode 100644
index 000000000000..2100f0ab1abe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+#ifdef __SIZEOF_INT128__
+typedef unsigned __int128 u128;
+#endif
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+#if defined(__clang__)
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_struct(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+
+	if (bpf_kfunc_call_test_pair_arg(1, s, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+#endif
+
+#ifdef __SIZEOF_INT128__
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg(1, 2, v) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * arm64 rounds the register number up to an even one for an argument
+ * aligned to 16 bytes, so it wants this __int128 in x2 and x3.
+ * The x86-64 ABI has no such rule.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_odd(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg_odd(1, v, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+#endif /* __SIZEOF_INT128__ */
+
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_last_regs(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+
+	if (bpf_kfunc_call_test_pair_arg_nofit(1, 2, 3, 4, s) !=3D a + b + 10)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * The x86-64 ABI moves an argument its six remaining registers cannot h=
old
+ * wholly onto the stack. arm64, with eight argument registers, still ha=
s a
+ * pair for it.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_straddle(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_big_arg s =3D { .a =3D a, .b =3D b };
+
+	if (bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s) !=3D a + b + 15)
+		return 1;
+
+	return 0;
+}
+
+/* The same, with an argument after the struct to take the eighth regist=
er. */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_tail(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+
+	if (bpf_kfunc_call_test_pair_arg_tail(1, 2, 3, 4, 5, s, 6) !=3D a + b +=
 21)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * arm64 gives no register to an argument its eight registers cannot hol=
d,
+ * nor to anything after it. Past its six registers the x86-64 ABI has b=
oth
+ * eightbytes on the stack either way.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_split8(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+
+	if (bpf_kfunc_call_test_pair_arg_split8(1, 2, 3, 4, 5, 6, 7, s) !=3D a =
+ b + 28)
+		return 1;
+
+	return 0;
+}
+
+#ifdef __SIZEOF_INT128__
+
+/*
+ * The same hole, with enough arguments after the __int128 that the shif=
t
+ * reaches the registers the BPF convention counts as stack slots: arm64
+ * wants the last one in x6 where the BPF convention put it in x5.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_shift(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg_shift(1, v, 2, 3, 4) !=3D a + b + 10)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * One argument further and the hole pushes the last one off x7, so the =
JIT
+ * shifts it into the first arm64 stack slot. The x86-64 ABI packs the
+ * eightbytes, so its last two are on the stack where BPF put them.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_ovf(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg_ovf(1, v, 2, 3, 4, 5, 6) !=3D a + b + =
21)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Both conventions pad the stack to align this __int128, and the BPF
+ * convention pads for neither, so both JITs move it up an eightbyte.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_pad(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg_pad(1, 2, 3, 4, 5, 6, 7, v) !=3D a + b=
 + 28)
+		return 1;
+
+	return 0;
+}
+
+#endif /* __SIZEOF_INT128__ */
+
+#endif
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("R1 type STRUCT is not composed of scalars")
+int aggregate_arg_kfunc_ptr_member(struct __sk_buff *skb)
+{
+	struct prog_test_ptr_arg s =3D { .p =3D skb, .x =3D 1 };
+
+	return bpf_kfunc_call_test_ptr_arg(s);
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/test=
ing/selftests/bpf/progs/arena_kfunc.c
index 50609f3b0564..7302d279ead2 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -228,6 +228,21 @@ int arena_arg_stack(void *ctx)
 	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
 	return 0;
 }
+
+#if defined(__clang__)
+/* The struct takes two slots, so the arena pointer is the sixth. */
+SEC("syscall")
+__arch_x86_64 __arch_arm64
+__failure __msg("arena pointer cannot be a stack argument")
+int arena_arg_stack_after_pair(void *ctx)
+{
+	struct prog_test_pair_arg s =3D { .lo =3D 1, .hi =3D 2 };
+
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	bpf_kfunc_call_test_pair_arena_arg(1, 2, 3, s, (u64 *)1);
+	return 0;
+}
+#endif
 #else
 SEC("syscall")
 __arch_x86_64
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/t=
esting/selftests/bpf/progs/stack_arg_fail.c
index eed97d582515..fff2e947ea33 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_fail.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
@@ -3,20 +3,10 @@
=20
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-#include "../test_kmods/bpf_testmod_kfunc.h"
 #include "bpf_misc.h"
=20
 #if defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
-SEC("tc")
-__failure __msg("Unrecognized *(R11-8) type STRUCT")
-int test_stack_arg_big(struct __sk_buff *skb)
-{
-	struct prog_test_big_arg s =3D { .a =3D 1, .b =3D 2 };
-
-	return bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s);
-}
-
 SEC("socket")
 __description("r11 in ALU instruction")
 __failure __msg("R11 is invalid")
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f798bbbb4d13..baccee6fdad4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1029,6 +1029,72 @@ __bpf_kfunc struct prog_test_ret_pair bpf_kfunc_ca=
ll_test_ret_fastcall(u64 a, u6
 	return r;
 }
=20
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg(u64 a, struct prog_test_pai=
r_arg s, u64 b)
+{
+	return a + s.lo + s.hi + b;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a, u64 b, __int128 v)
+{
+	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd(u64 a, __int128 v, u64 =
b)
+{
+	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_shift(u64 a, __int128 v, u6=
4 b, u64 c,
+						   u64 d)
+{
+	return a + b + c + d + (u64)((unsigned __int128)v >> 64) + (u64)v;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_ovf(u64 a, __int128 v, u64 =
b, u64 c,
+						 u64 d, u64 e, u64 f)
+{
+	return a + b + c + d + e + f +
+	       (u64)((unsigned __int128)v >> 64) + (u64)v;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u64 a, u64 b, u64 c, u6=
4 d, u64 e,
+						 u64 f, u64 g, __int128 v)
+{
+	return a + b + c + d + e + f + g +
+	       (u64)((unsigned __int128)v >> 64) + (u64)v;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_nofit(u64 a, u64 b, u64 c, =
u64 d,
+						   struct prog_test_pair_arg s)
+{
+	return a + b + c + d + s.lo + s.hi;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_tail(u64 a, u64 b, u64 c, u=
64 d, u64 e,
+						  struct prog_test_pair_arg s, u64 f)
+{
+	return a + b + c + d + e + s.lo + s.hi + f;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_split8(u64 a, u64 b, u64 c,=
 u64 d, u64 e,
+						    u64 f, u64 g,
+						    struct prog_test_pair_arg s)
+{
+	return a + b + c + d + e + f + g + s.lo + s.hi;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_ptr_arg(struct prog_test_ptr_arg s)
+{
+	return s.x;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arena_arg(u64 a, u64 b, u64 c,
+						   struct prog_test_pair_arg s,
+						   u64 *f__arena)
+{
+	return a + b + c + s.lo + s.hi + *f__arena;
+}
+
 __bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(u64 tag=
)
 {
 	struct prog_test_ret_ptr r =3D { .p =3D NULL, .tag =3D tag };
@@ -1667,6 +1733,17 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr_str=
uct)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr2d)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_shift)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_ovf)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_tail)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_split8)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ptr_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arena_arg)
 #endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b213ef14848b..195ec37d5bbc 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -61,6 +61,16 @@ struct prog_test_big_arg {
 	__u64 b;
 };
=20
+struct prog_test_pair_arg {	/* 16 bytes: two argument registers */
+	__u64 lo;
+	__u64 hi;
+};
+
+struct prog_test_ptr_arg {	/* 16 bytes, but holds a pointer */
+	void *p;
+	__u64 x;
+};
+
 struct prog_test_ret_pair {	/* 16 bytes: R0:R2 */
 	__u64 lo;
 	__u64 hi;
@@ -221,6 +231,28 @@ __int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) =
__ksym;
 struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(__u64 a, __u64 b)=
 __ksym;
 struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(__u64 a, __u6=
4 b) __ksym;
 struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
+__u64 bpf_kfunc_call_test_pair_arg(__u64 a, struct prog_test_pair_arg s,=
 __u64 b) __ksym;
+#ifdef __SIZEOF_INT128__
+__u64 bpf_kfunc_call_test_i128_arg(__u64 a, __u64 b, __int128 v) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __k=
sym;
+__u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b, _=
_u64 c,
+					 __u64 d) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, __u=
64 c,
+				       __u64 d, __u64 e, __u64 f) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_pad(__u64 a, __u64 b, __u64 c, __u64 =
d, __u64 e,
+				       __u64 f, __u64 g, __int128 v) __ksym;
+#endif
+__u64 bpf_kfunc_call_test_pair_arg_nofit(__u64 a, __u64 b, __u64 c, __u6=
4 d,
+					 struct prog_test_pair_arg s) __ksym;
+__u64 bpf_kfunc_call_test_pair_arg_tail(__u64 a, __u64 b, __u64 c, __u64=
 d, __u64 e,
+					struct prog_test_pair_arg s, __u64 f) __ksym;
+__u64 bpf_kfunc_call_test_pair_arg_split8(__u64 a, __u64 b, __u64 c, __u=
64 d, __u64 e,
+					  __u64 f, __u64 g,
+					  struct prog_test_pair_arg s) __ksym;
+__u64 bpf_kfunc_call_test_ptr_arg(struct prog_test_ptr_arg s) __ksym;
+__u64 bpf_kfunc_call_test_pair_arena_arg(__u64 a, __u64 b, __u64 c,
+					 struct prog_test_pair_arg s,
+					 __u64 *f__arena) __ksym;
 struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
 struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(__u64 tag) __=
ksym;
 struct prog_test_ret_ptr_arr bpf_kfunc_call_test_ret_ptr_arr(void) __ksy=
m;
--=20
2.52.0

