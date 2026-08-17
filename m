Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D66313E2C
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940549; cv=none; b=S55le7MtJPSZ4ubMEkKTZJBEOHGU2creFfrtXBbGRuVLcgrbPVzzRJW7BbXX1zvYPSnFiDLigufrul2cshfFzY1Fu5EsrV81So6zKtaG9u35dp9x5DwTgFyxGq9++x6ybKH7pQmfgd+7WHiCmpKVx7poCSyhNFmPXBjNY2CxXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940549; c=relaxed/simple;
	bh=grYOHqrduDvSBVKtldTKjgM2QxDQVS90+EeMQ5WH99k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub1PdLLOCGQbOoyNn5Cu3qdDfpmqLLK4yteCP1cmDTJj175cwtKMZqzd0aUKM08odtDEcX26uoATdYt3glBpwL9jB74ckT18UUZCUME2GHMcMmEKOG/7KUzz3rykgYFbnTp0iGzlQUZH2fcTpso5pcxnviSdDwM89ceAX2Gl+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7D12C24982E91E; Sun, 16 Aug 2026 21:22:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 08/10] selftests/bpf: Add C tests for 16-byte returns in R0:R2
Date: Sun, 16 Aug 2026 21:22:22 -0700
Message-ID: <20260817042222.2295525-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817042141.2286086-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add selftests that exercise a 16-byte return value passed in the R0:R2
register pair, written in C so that they depend on the compiler lowering
the register-pair return.

The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
aggregate return does not compile at all before that, so the programs sit
behind a __clang_major__ guard. An older compiler builds the dummy test i=
n
the #else branch instead, which keeps the object non-empty and says in it=
s
description why nothing was exercised.

The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
Those are the architectures whose JIT advertises
bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() require=
s
before it accepts a kfunc returning more than 8 bytes, and they are also
the only ones building the kfuncs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_aggregate_ret.c        | 178 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  18 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   9 +
 4 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_=
ret.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..f7f94ccebce2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -5,6 +5,7 @@
 #include "arena_kfunc.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
+#include "verifier_aggregate_ret.skel.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
@@ -170,6 +171,7 @@ void test_arena_kfunc(void)                   { RUN_T=
ESTS(arena_kfunc); }
=20
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_ji=
t); }
=20
+void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggre=
gate_ret); }
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c b=
/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
new file mode 100644
index 000000000000..7851bade2b40
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+typedef unsigned __int128 u128;
+
+struct pair {
+	__u64 lo;	/* R0 */
+	__u64 hi;	/* R2 */
+};
+
+union upair {
+	__u64 halves[2];
+	struct {
+		__u64 lo;	/* R0 */
+		__u64 hi;	/* R2 */
+	} parts;
+};
+
+static __noinline u128 make_i128(__u64 a, __u64 b)
+{
+	return ((u128)(a + b) << 64) | (a - b);
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_int128_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v;
+
+	v =3D make_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a + b)
+		return 1;
+	if ((__u64)v !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+static __noinline struct pair make_pair(__u64 a, __u64 b)
+{
+	struct pair p =3D { .lo =3D a + b, .hi =3D a - b };
+
+	return p;
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p;
+
+	p =3D make_pair(a, b);
+	if (p.lo !=3D a + b)
+		return 1;
+	if (p.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+__noinline struct pair make_pair_global(__u64 a, __u64 b)
+{
+	struct pair p =3D { .lo =3D a + b, .hi =3D a - b };
+
+	return p;
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_global_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p;
+
+	p =3D make_pair_global(a, b);
+	if (p.lo !=3D a + b)
+		return 1;
+	if (p.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+static __noinline union upair make_upair(__u64 a, __u64 b)
+{
+	union upair p;
+
+	p.halves[0] =3D a + b;
+	p.halves[1] =3D a - b;
+	return p;
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_union_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	union upair p;
+
+	p =3D make_upair(a, b);
+	if (p.parts.lo !=3D a + b)
+		return 1;
+	if (p.parts.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_int128_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v;
+
+	v =3D bpf_kfunc_call_test_i128(a, b);
+	if ((__u64)(v >> 64) !=3D a + b)
+		return 1;
+	if ((__u64)v !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_ret_kfunc_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_ret_pair p;
+
+	p =3D bpf_kfunc_call_test_ret_pair(a, b);
+	if (p.lo !=3D a + b)
+		return 1;
+	if (p.hi !=3D a - b)
+		return 2;
+
+	return 0;
+}
+
+#else
+
+SEC("socket")
+__description("verifier_aggregate_ret: needs LLVM 23, dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 9366a3c578f1..c4bc8e11c6e1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -954,6 +954,20 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u3=
2 c)
 	return 0;
 }
=20
+#if defined(__x86_64__) || defined(__aarch64__)
+__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)
+{
+	return (__int128)(((unsigned __int128)(a + b) << 64) | (a - b));
+}
+
+__bpf_kfunc struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(u64 a=
, u64 b)
+{
+	struct prog_test_ret_pair r =3D { .lo =3D a + b, .hi =3D a - b };
+
+	return r;
+}
+#endif /* __x86_64__ || __aarch64__ */
+
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
 					 u64 e, u64 f, u64 g, u64 h,
 					 u64 i, u64 j)
@@ -1487,6 +1501,10 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test4)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
+#if defined(__x86_64__) || defined(__aarch64__)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
+#endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 7d81070eefe7..426000f9a14f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -55,6 +55,11 @@ struct prog_test_big_arg {
 	__u64 b;
 };
=20
+struct prog_test_ret_pair {	/* 16 bytes: R0:R2 */
+	__u64 lo;
+	__u64 hi;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -131,6 +136,10 @@ int bpf_kfunc_call_test2(struct sock *sk, __u32 a, _=
_u32 b) __ksym;
 struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
+#ifdef __SIZEOF_INT128__
+__int128 bpf_kfunc_call_test_i128(__u64 a, __u64 b) __ksym;
+#endif
+struct prog_test_ret_pair bpf_kfunc_call_test_ret_pair(__u64 a, __u64 b)=
 __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
 			       __u64 i, __u64 j) __ksym;
--=20
2.53.0-Meta

