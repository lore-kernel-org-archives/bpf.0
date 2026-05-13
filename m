Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007E38E8D2
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647906; cv=none; b=ZTv7YjxYY7cC6YM6zZn11b6RbBYJECTsQx57vcGmVPMpTqPtmaIzn/PWgkoyHsB9AFY0/ha0zlPoN9CxxKdMEbLfk+/YIV1YAGUUcA/IR7OsFkaZ6eMcr6+ZofoOX6Q8VApAY0Kc0KSCexQpwNkgM2aTml5Vz+vKtX63Sit//d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647906; c=relaxed/simple;
	bh=ENz8ccnFkVI00T7016SfH/RIYBqiCyWfAjpSPUQ/GcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbolHSQXxsoIr6phEizP2n5wstz1wZpnezjL/PRvtb6BDwPYnGEUtrHTmeqqDMzEq4Kyaq9BXR8OhuGVe0HAe1ETKx1SxgfZTYGFxhLpCj1lnLcGrqsvFKcyLlcUhv7DljiNn/SQ4BZlnVSmGi8eQnnD3Zdr/vKbPHgf9tVTR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 513F3B1981FBF; Tue, 12 May 2026 21:51:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 19/25] selftests/bpf: Add tests for stack argument validation
Date: Tue, 12 May 2026 21:51:32 -0700
Message-ID: <20260513045132.2398371-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add negative tests that verify the kfunc (rejecting kfunc call
with >8 byte struct as stack argument) and the verifier
(rejecting invalid uses of r11 for stack arguments).

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/stack_arg_fail.c |  10 ++
 .../selftests/bpf/progs/stack_arg_fail.c      | 114 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   7 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   8 ++
 4 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c b/to=
ols/testing/selftests/bpf/prog_tests/stack_arg_fail.c
new file mode 100644
index 000000000000..090af1330953
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "stack_arg_fail.skel.h"
+
+void test_stack_arg_fail(void)
+{
+	RUN_TESTS(stack_arg_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/t=
esting/selftests/bpf/progs/stack_arg_fail.c
new file mode 100644
index 000000000000..ad9d4bfe15dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+SEC("tc")
+__failure __msg("Unrecognized *(R11-8) type STRUCT")
+int test_stack_arg_big(struct __sk_buff *skb)
+{
+	struct prog_test_big_arg s =3D { .a =3D 1, .b =3D 2 };
+
+	return bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s);
+}
+
+SEC("socket")
+__description("r11 in ALU instruction")
+__failure __msg("R11 is invalid")
+__naked void r11_alu_reject(void)
+{
+	asm volatile (
+	"r11 +=3D 1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 store with non-DW size")
+__failure __msg("R11 is invalid")
+__naked void r11_store_non_dw(void)
+{
+	asm volatile (
+	"*(u32 *)(r11 - 8) =3D r1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 store with unaligned offset")
+__failure __msg("R11 is invalid")
+__naked void r11_store_unaligned(void)
+{
+	asm volatile (
+	"*(u64 *)(r11 - 4) =3D r1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 store with positive offset")
+__failure __msg("R11 is invalid")
+__naked void r11_store_positive_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r11 + 8) =3D r1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 load with negative offset")
+__failure __msg("R11 is invalid")
+__naked void r11_load_negative_off(void)
+{
+	asm volatile (
+	"r0 =3D *(u64 *)(r11 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 load with non-DW size")
+__failure __msg("R11 is invalid")
+__naked void r11_load_non_dw(void)
+{
+	asm volatile (
+	"r0 =3D *(u32 *)(r11 + 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("socket")
+__description("r11 store with zero offset")
+__failure __msg("R11 is invalid")
+__naked void r11_store_zero_off(void)
+{
+	asm volatile (
+	"*(u64 *)(r11 + 0) =3D r1;"
+	"r0 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+#else
+
+SEC("tc")
+__description("stack_arg_fail: not supported, dummy test")
+__success
+int test_stack_arg_big(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index aef2f68b7e83..0be918fe3021 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -882,6 +882,12 @@ __bpf_kfunc u64 bpf_kfunc_call_stack_arg_timer(u64 a=
, u64 b, u64 c, u64 d, u64 e
 	return a + b + c + d + e;
 }
=20
+__bpf_kfunc u64 bpf_kfunc_call_stack_arg_big(u64 a, u64 b, u64 c, u64 d,=
 u64 e,
+					     struct prog_test_big_arg s)
+{
+	return a + b + c + d + e + s.a + s.b;
+}
+
 static struct prog_test_ref_kfunc prog_test_struct =3D {
 	.a =3D 42,
 	.b =3D 108,
@@ -1353,6 +1359,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mem)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_iter)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_const_str)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_timer)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_acquire, KF_ACQUIRE | KF_RET_NULL=
)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2c1cb118f886..2edc36b66de9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -50,6 +50,11 @@ struct prog_test_pass2 {
 	} x;
 };
=20
+struct prog_test_big_arg {
+	__u64 a;
+	__u64 b;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -130,6 +135,9 @@ __u64 bpf_kfunc_call_stack_arg_const_str(__u64 a, __u=
64 b, __u64 c, __u64 d, __u
 					 const char *str__str) __ksym;
 __u64 bpf_kfunc_call_stack_arg_timer(__u64 a, __u64 b, __u64 c, __u64 d,=
 __u64 e,
 				     struct bpf_timer *timer) __ksym;
+__u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_big_arg s) __ksym;
+
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
--=20
2.53.0-Meta

