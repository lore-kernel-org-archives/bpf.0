Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F831A81C
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410014; cv=none; b=e5+zXeudWP/wLLYiRTACHDPa7bvFdjjKARDWjxOwnZTGAtSz7IhECCfaFNrtRYkVjSPWNUEwkMNx1O6pgASmshN3/g2WTtREXJZh196GmloKEFZOAs/cmgNeDOOVGMNx8oS5F8w9T5brYY6t9fsoTnEh5rJ/XTOjg7HAdIviKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410014; c=relaxed/simple;
	bh=DWLHc71/hYqynxnU+jkmOlm0senWCSBbN8FJvHfwaTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll2YUa9lt/V5F6xPQQAcpaL3wBWa/ZdIv8I8inyVoKJL2aCW9tu7fQZbJDXiSdokuFdtbvQFLOTmxFhqONXpVcAxDF7BxCxmZnUPC5xsaV5TLelF+Nw6UKurQplWkHFWGG63X75CrGaUzmhrDup2LeusCn14B9H1LGv/LdTf5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 42E6D361E5EF7; Sun,  5 Apr 2026 10:26:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 11/11] selftests/bpf: Add verifier tests for stack argument validation
Date: Sun,  5 Apr 2026 10:26:42 -0700
Message-ID: <20260405172642.1338721-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405172505.1329392-1-yonghong.song@linux.dev>
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add inline-asm-based verifier tests that exercise the stack argument
validation logic directly.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_stack_arg.c  | 302 ++++++++++++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 1ac366fd4dae..f39ed1f28a7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -90,6 +90,7 @@
 #include "verifier_sockmap_mutate.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
+#include "verifier_stack_arg.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
@@ -236,6 +237,7 @@ void test_verifier_sock_addr(void)            { RUN(v=
erifier_sock_addr); }
 void test_verifier_sockmap_mutate(void)       { RUN(verifier_sockmap_mut=
ate); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
 void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock);=
 }
+void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg);=
 }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr);=
 }
 void test_verifier_store_release(void)        { RUN(verifier_store_relea=
se); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_pre=
cision); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
new file mode 100644
index 000000000000..43a0636d995d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+__noinline __used
+static int subprog_6args(int a, int b, int c, int d, int e, int f)
+{
+	return a + b + c + d + e + f;
+}
+
+__noinline __used
+static int subprog_7args(int a, int b, int c, int d, int e, int f, int g=
)
+{
+	return a + b + c + d + e + f + g;
+}
+
+SEC("tc")
+__description("stack_arg: subprog with 6 args")
+__success
+__arch_x86_64
+__naked void stack_arg_6args(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r12 - 8) =3D 6;"
+		"call subprog_6args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: two subprogs with >5 args")
+__success
+__arch_x86_64
+__naked void stack_arg_two_subprogs(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r12 - 8) =3D 10;"
+		"call subprog_6args;"
+		"r6 =3D r0;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r12 - 16) =3D 30;"
+		"*(u64 *)(r12 - 8) =3D 20;"
+		"call subprog_7args;"
+		"r0 +=3D r6;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: read from uninitialized stack arg slot")
+__failure
+__arch_x86_64
+__msg("invalid read from stack arg")
+__naked void stack_arg_read_uninitialized(void)
+{
+	asm volatile (
+		"r0 =3D *(u64 *)(r12 - 8);"
+		"r0 =3D 0;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: gap at offset -8, only wrote -16")
+__failure
+__arch_x86_64
+__msg("stack arg#5 not properly initialized")
+__naked void stack_arg_gap_at_minus8(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r12 - 16) =3D 30;"
+		"call subprog_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: incorrect size of stack arg write")
+__failure
+__arch_x86_64
+__msg("stack arg write must be 8 bytes, got 4")
+__naked void stack_arg_not_written(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u32 *)(r12 - 8) =3D 30;"
+		"call subprog_6args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+__noinline __used
+static long subprog_stack_arg_pruning_deref(int a, int b, int c, int d, =
int e, int f)
+{
+	long local =3D 0, *p, *ptr;
+
+	if (a <=3D 3) {
+		/* Overwrite the stack arg slot with a pointer to local */
+		p =3D &local;
+		asm volatile ("*(u64 *)(r12 - 8) =3D %[p];" :: [p] "r"(p) : "memory");
+	}
+
+	/* Read back the (possibly overwritten) stack arg slot */
+	asm volatile ("%[ptr] =3D *(u64 *)(r12 - 8);" : [ptr] "=3Dr"(ptr) :: "m=
emory");
+
+	/* Deref: safe for PTR_TO_STACK, unsafe for scalar */
+	return *ptr;
+}
+
+SEC("tc")
+__description("stack_arg: pruning with different stack arg types")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__arch_x86_64
+__msg("invalid mem access 'scalar'")
+__naked void stack_arg_pruning_type_mismatch(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 =3D r0;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r12 - 8) =3D 42;"
+		"call subprog_stack_arg_pruning_deref;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: release_reference invalidates stack arg slot")
+__failure
+__arch_x86_64
+__msg("R0 invalid mem access 'scalar'")
+__naked void stack_arg_release_ref(void)
+{
+	asm volatile (
+		"r6 =3D r1;"
+		/* struct bpf_sock_tuple tuple =3D {} */
+		"r2 =3D 0;"
+		"*(u32 *)(r10 - 8) =3D r2;"
+		"*(u64 *)(r10 - 16) =3D r2;"
+		"*(u64 *)(r10 - 24) =3D r2;"
+		"*(u64 *)(r10 - 32) =3D r2;"
+		"*(u64 *)(r10 - 40) =3D r2;"
+		"*(u64 *)(r10 - 48) =3D r2;"
+		/* sk =3D bpf_sk_lookup_tcp(ctx, &tuple, sizeof(tuple), 0, 0) */
+		"r1 =3D r6;"
+		"r2 =3D r10;"
+		"r2 +=3D -48;"
+		"r3 =3D %[sizeof_bpf_sock_tuple];"
+		"r4 =3D 0;"
+		"r5 =3D 0;"
+		"call %[bpf_sk_lookup_tcp];"
+		/* r0 =3D sk (PTR_TO_SOCK_OR_NULL) */
+		"if r0 =3D=3D 0 goto l0_%=3D;"
+		/* spill sk to stack arg slot */
+		"*(u64 *)(r12 - 8) =3D r0;"
+		/* release the reference */
+		"r1 =3D r0;"
+		"call %[bpf_sk_release];"
+		/* r0 and stack arg slot (r12 - 8) should be invalid now. */
+		"r0 =3D *(u64 *)(r12 - 8);"
+		"r0 =3D *(u8 *)(r0 + 0);"
+	"l0_%=3D:"
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm(bpf_sk_lookup_tcp),
+		  __imm(bpf_sk_release),
+		  __imm_const(sizeof_bpf_sock_tuple, sizeof(struct bpf_sock_tuple))
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: pkt pointer in stack arg slot invalidated afte=
r pull_data")
+__failure
+__arch_x86_64
+__msg("R0 invalid mem access 'scalar'")
+__naked void stack_arg_stale_pkt_ptr(void)
+{
+	asm volatile (
+		"r6 =3D r1;"
+		"r7 =3D *(u32 *)(r6 + %[__sk_buff_data]);"
+		"r8 =3D *(u32 *)(r6 + %[__sk_buff_data_end]);"
+		/* check pkt has at least 1 byte */
+		"r0 =3D r7;"
+		"r0 +=3D 1;"
+		"if r0 > r8 goto l0_%=3D;"
+		/* spill valid pkt pointer to stack arg slot */
+		"*(u64 *)(r12 - 8) =3D r7;"
+		/* bpf_skb_pull_data(skb, 0) -- invalidates all pkt pointers */
+		"r1 =3D r6;"
+		"r2 =3D 0;"
+		"call %[bpf_skb_pull_data];"
+		/* read back the stale pkt pointer from stack arg slot */
+		"r0 =3D *(u64 *)(r12 - 8);"
+		/* dereferencing stale pkt pointer should fail */
+		"r0 =3D *(u8 *)(r0 + 0);"
+	"l0_%=3D:"
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm(bpf_skb_pull_data),
+		  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+		  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)=
)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: null propagation rejects deref on null branch"=
)
+__failure
+__arch_x86_64
+__msg("R1 invalid mem access 'scalar'")
+__naked void stack_arg_null_propagation_fail(void)
+{
+	asm volatile (
+		"r1 =3D 0;"
+		"*(u64 *)(r10 - 8) =3D r1;"
+		/* r0 =3D bpf_map_lookup_elem(&map_hash_8b, &key) */
+		"r2 =3D r10;"
+		"r2 +=3D -8;"
+		"r1 =3D %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		/* spill PTR_TO_MAP_VALUE_OR_NULL to stack arg slot */
+		"*(u64 *)(r12 - 8) =3D r0;"
+		/* null check on r0 */
+		"if r0 !=3D 0 goto l0_%=3D;"
+		/*
+		 * on null branch, stack arg slot should be null (scalar 0).
+		 * read it back and dereference should fail.
+		 */
+		"r1 =3D *(u64 *)(r12 - 8);"
+		"r0 =3D *(u64 *)(r1 + 0);"
+	"l0_%=3D:"
+		"r0 =3D 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_hash_8b)
+		: __clobber_all
+	);
+}
+
+#else
+
+SEC("socket")
+__description("stack_arg is not supported by compiler or jit, use a dumm=
y test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.52.0

