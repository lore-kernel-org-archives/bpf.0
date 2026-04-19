Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75EF2C15A9
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616489; cv=none; b=hEWieG7P3KwKImPxMDlsgtr/bD36qrob4sRu9B9J/P8g0+GEexgvO+RhpWluGj0rnATEZ+0pklJLChpmxrWiHIqayCtihryMeTVomj5+EAJcHlBuoyjVHapXe9rhXTTCMHlbOYseLnHG3GmMIYWF0o/BmZw7cdVHHCCylnEoq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616489; c=relaxed/simple;
	bh=Dt+33ST4kJGExWN9obRlzm5EFL4YH9lhRoJB9howysw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbWZyFOAPy4Mv3pH8NyMRTLDjWDMbBX5hnGpolKNXgdR7r1phuMjM3IqNdOkJIzI+Xi+vquCoUG1ttMh/99L08c5Rp41cUNmG3bzIpO3ykZ6g7pNbYKWSsiIMUYGH3xbIS6B46W2Vp8dg/2SxIVCkSi49bnbGu3/r/gijxaZA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5584F42DD4F49; Sun, 19 Apr 2026 09:34:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 17/17] selftests/bpf: Add verifier tests for stack argument validation
Date: Sun, 19 Apr 2026 09:34:45 -0700
Message-ID: <20260419163445.740437-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419163316.731019-1-yonghong.song@linux.dev>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Add inline-asm based verifier tests that exercise stack argument
validation logic directly.

Positive tests:
  - subprog call with 6 arg's
  - Two sequential calls to different subprogs (6-arg and 7-arg)
  - Share a r11 store for both branches

Negative tests =E2=80=94 verifier rejection:
  - Read from uninitialized incoming stack arg slot
  - Gap in outgoing slots: only r11-16 written, r11-8 missing
  - Write at r11-80, exceeding max 7 stack args
  - Missing store on one branch with a shared store
  - First call has proper stack arguments and the second
    call intends to inherit stack arguments but not working

Negative tests =E2=80=94 pointer/ref tracking:
  - Pruning type mismatch: one branch stores PTR_TO_STACK, the
    other stores a scalar, callee dereferences =E2=80=94 must not prune
  - Release invalidation: bpf_sk_release invalidates a socket
    pointer stored in a stack arg slot
  - Packet pointer invalidation: bpf_skb_pull_data invalidates
    a packet pointer stored in a stack arg slot
  - Null propagation: PTR_TO_MAP_VALUE_OR_NULL stored in stack
    arg slot, null branch attempts dereference via callee

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_stack_arg.c  | 433 ++++++++++++++++++
 2 files changed, 435 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index a96b25ebff23..aef21cf2987b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -91,6 +91,7 @@
 #include "verifier_sockmap_mutate.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_spin_lock.skel.h"
+#include "verifier_stack_arg.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
@@ -238,6 +239,7 @@ void test_verifier_sock_addr(void)            { RUN(v=
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
index 000000000000..66dd11840a63
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -0,0 +1,433 @@
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
+__noinline __used
+static long subprog_deref_arg6(long a, long b, long c, long d, long e, l=
ong *f)
+{
+	return *f;
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
+		"*(u64 *)(r11 - 8) =3D 6;"
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
+		"*(u64 *)(r11 - 8) =3D 10;"
+		"call subprog_6args;"
+		"r6 =3D r0;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r11 - 16) =3D 30;"
+		"*(u64 *)(r11 - 8) =3D 20;"
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
+__msg("invalid read from stack arg off 8 depth 0")
+__naked void stack_arg_read_uninitialized(void)
+{
+	asm volatile (
+		"r0 =3D *(u64 *)(r11 + 8);"
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
+__msg("stack arg#6 not properly initialized")
+__naked void stack_arg_gap_at_minus8(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r11 - 16) =3D 30;"
+		"call subprog_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: pruning with different stack arg types")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__arch_x86_64
+__msg("R1 invalid mem access 'scalar'")
+__naked void stack_arg_pruning_type_mismatch(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r6 =3D r0;"
+		/* local =3D 0 on program stack */
+		"r7 =3D 0;"
+		"*(u64 *)(r10 - 8) =3D r7;"
+		/* Branch based on random value */
+		"if r6 s> 3 goto l0_%=3D;"
+		/* Path 1: store stack pointer to outgoing arg6 */
+		"r1 =3D r10;"
+		"r1 +=3D -8;"
+		"*(u64 *)(r11 - 8) =3D r1;"
+		"goto l1_%=3D;"
+	"l0_%=3D:"
+		/* Path 2: store scalar to outgoing arg6 */
+		"*(u64 *)(r11 - 8) =3D 42;"
+	"l1_%=3D:"
+		/* Call subprog that dereferences arg6 */
+		"r1 =3D r6;"
+		"r2 =3D 0;"
+		"r3 =3D 0;"
+		"r4 =3D 0;"
+		"r5 =3D 0;"
+		"call subprog_deref_arg6;"
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
+__msg("R1 invalid mem access 'scalar'")
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
+		/* Store sock ref to outgoing arg6 slot */
+		"*(u64 *)(r11 - 8) =3D r0;"
+		/* Release the reference =E2=80=94 invalidates the stack arg slot */
+		"r1 =3D r0;"
+		"call %[bpf_sk_release];"
+		/* Call subprog that dereferences arg6 =E2=80=94 should fail */
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_deref_arg6;"
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
+__msg("R1 invalid mem access 'scalar'")
+__naked void stack_arg_stale_pkt_ptr(void)
+{
+	asm volatile (
+		"r6 =3D r1;"
+		"r7 =3D *(u32 *)(r6 + %[__sk_buff_data]);"
+		"r8 =3D *(u32 *)(r6 + %[__sk_buff_data_end]);"
+		/* check pkt has at least 1 byte */
+		"r0 =3D r7;"
+		"r0 +=3D 8;"
+		"if r0 > r8 goto l0_%=3D;"
+		/* Store valid pkt pointer to outgoing arg6 slot */
+		"*(u64 *)(r11 - 8) =3D r7;"
+		/* bpf_skb_pull_data invalidates all pkt pointers */
+		"r1 =3D r6;"
+		"r2 =3D 0;"
+		"call %[bpf_skb_pull_data];"
+		/* Call subprog that dereferences arg6 =E2=80=94 should fail */
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_deref_arg6;"
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
+		/* Store PTR_TO_MAP_VALUE_OR_NULL to outgoing arg6 slot */
+		"*(u64 *)(r11 - 8) =3D r0;"
+		/* null check on r0 */
+		"if r0 !=3D 0 goto l0_%=3D;"
+		/*
+		 * On null branch, outgoing slot is SCALAR(0).
+		 * Call subprog that dereferences arg6 =E2=80=94 should fail.
+		 */
+		"r1 =3D 0;"
+		"r2 =3D 0;"
+		"r3 =3D 0;"
+		"r4 =3D 0;"
+		"r5 =3D 0;"
+		"call subprog_deref_arg6;"
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
+SEC("tc")
+__description("stack_arg: missing store on one branch")
+__failure
+__arch_x86_64
+__msg("stack arg#6 not properly initialized")
+__naked void stack_arg_missing_store_one_branch(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		/* Write arg7 (r11-16) before branch */
+		"*(u64 *)(r11 - 16) =3D 20;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 > 0 goto l0_%=3D;"
+		/* Path 1: write arg6 and call */
+		"*(u64 *)(r11 - 8) =3D 10;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_7args;"
+		"goto l1_%=3D;"
+	"l0_%=3D:"
+		/* Path 2: missing arg6 store, call should fail */
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_7args;"
+	"l1_%=3D:"
+		"r0 =3D 0;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: share a store for both branches")
+__success __retval(0)
+__arch_x86_64
+__naked void stack_arg_shared_store(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		/* Write arg7 (r11-16) before branch */
+		"*(u64 *)(r11 - 16) =3D 20;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 > 0 goto l0_%=3D;"
+		/* Path 1: write arg6 and call */
+		"*(u64 *)(r11 - 8) =3D 10;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_7args;"
+		"goto l1_%=3D;"
+	"l0_%=3D:"
+		/* Path 2: also write arg6 and call */
+		"*(u64 *)(r11 - 8) =3D 30;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_7args;"
+	"l1_%=3D:"
+		"r0 =3D 0;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: write beyond max outgoing depth")
+__failure
+__arch_x86_64
+__msg("stack arg write offset -80 exceeds max 7 stack args")
+__naked void stack_arg_write_beyond_max(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		/* Write to offset -80, way beyond any callee's needs */
+		"*(u64 *)(r11 - 80) =3D 99;"
+		"*(u64 *)(r11 - 16) =3D 20;"
+		"*(u64 *)(r11 - 8) =3D 10;"
+		"call subprog_7args;"
+		"r0 =3D 0;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: sequential calls reuse slots")
+__failure
+__arch_x86_64
+__msg("stack arg#6 not properly initialized")
+__naked void stack_arg_sequential_calls(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r11 - 8) =3D 6;"
+		"*(u64 *)(r11 - 16) =3D 7;"
+		"call subprog_7args;"
+		"r6 =3D r0;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call subprog_7args;"
+		"r0 +=3D r6;"
+		"exit;"
+		::: __clobber_all
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

