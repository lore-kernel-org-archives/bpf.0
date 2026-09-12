Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C438F620
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242806; cv=none; b=CTwZhtHVAaFtGkV7wqzQpogsY6Ty9gREpx26BWoxrUzNXPh3v3v9VF5NoVrVhFX7fde63EeQaAnf/sNzvYxzlfEXWh6whDVROLV4IYN6lk4eVAl+sdd2P6kMIX+wOKOK6CBCTToxuEtReEHxSe1dBh8FZ9V5WGhreAwOkETs0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242806; c=relaxed/simple;
	bh=G9EbJ7HDGP5tEREroVgaCy1vb14B1utVZZ0dOm5RKRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ias/D7ui/4B2Cesdeo9jzyJjIoTNrCUNeCkcuEDMznTE/sAJd6ycrO2LGo7+TqLt0ywTd+D4lhefIBbT98kPqWKQUNg+v7hn9TB8HUlGwT7i3iF+UXqmxDOdzBnMAOHuOyLMJXCV0qLYQ5NrjfpwVRGdDqOCas88U79MpCM7Dxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 24AF02A58A0E57; Sat, 12 Sep 2026 12:53:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 15/15] selftests/bpf: Add tests for by-value kfunc arguments
Date: Sat, 12 Sep 2026 12:53:13 -0700
Message-ID: <20260912195313.992803-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
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
Each kfunc weighs its parameters by argument slot, the first by one, the
second by two and so on, and every test checks the value it returns. A
plain sum would be the same whichever slot each value reached, so an
argument that lands in the wrong one, or a 16-byte argument whose halves
arrive the other way round, would pass quietly; a weighted one differs.

An __int128 takes two argument slots. One test passes it in registers
and one past them, where both conventions pad the stack to align it
although the BPF convention does not, so both JITs move it up an
eightbyte.

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
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 168 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  15 ++
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  59 +++++-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  27 +++
 6 files changed, 270 insertions(+), 11 deletions(-)
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
index 000000000000..52d3d5d53946
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -0,0 +1,168 @@
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
+	if (bpf_kfunc_call_test_pair_arg(1, s, 2) !=3D 2 * a + 3 * b + 9)
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
+	if (bpf_kfunc_call_test_i128_arg(1, 2, v) !=3D 4 * a + 3 * b + 5)
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
+	if (bpf_kfunc_call_test_pair_arg_nofit(1, 2, 3, 4, s) !=3D 5 * a + 6 * =
b + 30)
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
+	if (bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s) !=3D 6 * a + 7 * b +=
 55)
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
+	if (bpf_kfunc_call_test_pair_arg_tail(1, 2, 3, 4, 5, s, 6) !=3D 6 * a +=
 7 * b + 103)
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
+	if (bpf_kfunc_call_test_pair_arg_split8(1, 2, 3, 4, 5, 6, 7, s) !=3D 8 =
* a + 9 * b + 140)
+		return 1;
+
+	return 0;
+}
+
+#ifdef __SIZEOF_INT128__
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
+	if (bpf_kfunc_call_test_i128_arg_pad(1, 2, 3, 4, 5, 6, 7, v) !=3D 9 * a=
 + 8 * b + 140)
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
index 6578cf12fa27..96f7aacf4d9f 100644
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
index f798bbbb4d13..66b14168566a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1029,6 +1029,55 @@ __bpf_kfunc struct prog_test_ret_pair bpf_kfunc_ca=
ll_test_ret_fastcall(u64 a, u6
 	return r;
 }
=20
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg(u64 a, struct prog_test_pai=
r_arg s, u64 b)
+{
+	return a + s.lo * 2 + s.hi * 3 + b * 4;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a, u64 b, __int128 v)
+{
+	return a + b * 2 + (u64)v * 3 + (u64)((unsigned __int128)v >> 64) * 4;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u64 a, u64 b, u64 c, u6=
4 d, u64 e,
+						 u64 f, u64 g, __int128 v)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 +
+	       (u64)v * 8 + (u64)((unsigned __int128)v >> 64) * 9;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_nofit(u64 a, u64 b, u64 c, =
u64 d,
+						   struct prog_test_pair_arg s)
+{
+	return a + b * 2 + c * 3 + d * 4 + s.lo * 5 + s.hi * 6;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_tail(u64 a, u64 b, u64 c, u=
64 d, u64 e,
+						  struct prog_test_pair_arg s, u64 f)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + s.lo * 6 + s.hi * 7 + f * 8;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_split8(u64 a, u64 b, u64 c,=
 u64 d, u64 e,
+						    u64 f, u64 g,
+						    struct prog_test_pair_arg s)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 +
+	       s.lo * 8 + s.hi * 9;
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
@@ -1186,7 +1235,7 @@ __bpf_kfunc u64 bpf_kfunc_call_stack_arg_timer(u64 =
a, u64 b, u64 c, u64 d, u64 e
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_big(u64 a, u64 b, u64 c, u64 d,=
 u64 e,
 					     struct prog_test_big_arg s)
 {
-	return a + b + c + d + e + s.a + s.b;
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + s.a * 6 + s.b * 7;
 }
=20
 static struct prog_test_ref_kfunc prog_test_struct =3D {
@@ -1667,6 +1716,14 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr_str=
uct)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr2d)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
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
index b213ef14848b..d3696d5254c9 100644
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
@@ -221,6 +231,23 @@ __int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) =
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
2.53.0-Meta

