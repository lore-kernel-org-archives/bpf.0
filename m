Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950A40F75A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498673; cv=none; b=QVCklAcQNRMwNsnqkEBEsE0SaJ4ovCch/uxfpqLqFlrDakrE17BF+VnLAnKt0y43RNvhmiRFMf9vcgo+I0nMf/tLYSlKH80fQpPJ0ikzVmJqU7Zfae52DIonKGhQLPdulqyPKQArMyZJ25ozc5mklrq89UdoBklt4czupGVE1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498673; c=relaxed/simple;
	bh=DSJIY+Qm9lxvTtS9v6FCYCN9zRet7VgNyRfkofRlZo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klTIun/RazNXqVau5XECKBsCwBeLZQ9IUp46Q3qtTSmRSXB5xFpQzbDJN6MDHpoIn3IZv4JWFvheiP5Y1xzeB9ByIkhvTN9ziVrJ5ejujpYzUqF3NHA27HIOqNzWLL871W/Bwu8FJpi56JReuWc20tMKPNox3aWfIP5m8HKtmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 11B2F28814FBDC; Thu,  3 Sep 2026 22:11:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 12/12] selftests/bpf: Add tests for by-value kfunc arguments
Date: Thu,  3 Sep 2026 22:11:00 -0700
Message-ID: <20260904051100.3983749-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add kfuncs taking a 16-byte struct and an __int128 by value, and tests
that call them, each checking the value the kfunc returns so that a
misplaced argument shows up rather than passing quietly.

They cover the placements the two calling conventions treat differently:
a struct in the middle of the argument list, an __int128 at an odd slot,
which AAPCS64 moves to an even register pair, a struct in the last two
argument registers, one the BPF convention splits between its last
register and the stack, which SysV moves wholly onto the stack, and the
same followed by another argument, which SysV then gives the register the
struct vacated. Two more cover the rejections that hold everywhere, an
aggregate holding a pointer and one too large to pass by value.

test_stack_arg_big() in stack_arg_fail.c passed a 16-byte struct as the
sixth argument and asserted the unrecognized stack argument type it used
to be reported as. It loads now, so the test is removed and the case is
covered by aggregate_arg_kfunc_straddle(), which makes the same call and
checks the value it returns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |   2 +
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 106 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  16 +++
 .../selftests/bpf/progs/stack_arg_fail.c      |  10 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  40 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  22 ++++
 6 files changed, 186 insertions(+), 10 deletions(-)
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
index 000000000000..6c2a07fad274
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+typedef unsigned __int128 u128;
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+#if defined(__clang__)
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
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
+SEC("tc")
+__arch_x86_64 __arch_arm64
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
+#if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
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
+SEC("tc")
+__arch_x86_64 __arch_arm64
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
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__success __retval(0)
+int aggregate_arg_kfunc_disorder(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+
+	if (bpf_kfunc_call_test_pair_arg_disorder(1, 2, 3, 4, 5, s, 6) !=3D a +=
 b + 21)
+		return 1;
+
+	return 0;
+}
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
index 50609f3b0564..8d1ce360a309 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -228,6 +228,22 @@ int arena_arg_stack(void *ctx)
 	bpf_kfunc_arena_stack_arg_test(1, 2, 3, 4, 5, (u64 *)1);
 	return 0;
 }
+
+#if defined(__clang__)
+/* The struct takes two slots, so the arena pointer is the sixth. */
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
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
index 2380b6cbdead..390a9eba2e56 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -974,6 +974,40 @@ __bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call=
_test_ret_fastcall(u64 a, u6
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
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_nofit(u64 a, u64 b, u64 c, =
u64 d,
+						   struct prog_test_pair_arg s)
+{
+	return a + b + c + d + s.lo + s.hi;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_disorder(u64 a, u64 b, u64 =
c, u64 d, u64 e,
+						      struct prog_test_pair_arg s, u64 f)
+{
+	return a + b + c + d + e + s.lo + s.hi + f;
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
@@ -1612,6 +1646,12 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr_str=
uct)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr2d)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_disorder)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ptr_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arena_arg)
 #endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index b213ef14848b..8ba684e5842f 100644
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
@@ -221,6 +231,18 @@ __int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) =
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
+#endif
+__u64 bpf_kfunc_call_test_pair_arg_nofit(__u64 a, __u64 b, __u64 c, __u6=
4 d,
+					 struct prog_test_pair_arg s) __ksym;
+__u64 bpf_kfunc_call_test_pair_arg_disorder(__u64 a, __u64 b, __u64 c, _=
_u64 d, __u64 e,
+					    struct prog_test_pair_arg s, __u64 f) __ksym;
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

