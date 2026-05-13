Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3702D5436
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647916; cv=none; b=MMUq8tWQjaP9GIpkJeyjBdvAk4QHBXetWb42FNOYye4Hi1a3JK5/yb/ohBy4cu0gfonM9SHZCYcrQWlOPy8bIuQs1fPSg7br3e/WSL2QT2D/7ImQ1U/FPQj1geLLbJiS0Ofb2LJNSi9ux6s4/JNhvl7RXLXC8hUEh4aNHlNAPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647916; c=relaxed/simple;
	bh=IUZyxuTenYQTqWO7a8L+aLJi2FtLw4Q9e1M4heTLHkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWOeV7qQrdbpOqcJLM0+ZqOY7xYTkYjDlqoowVwh529YiltnVELBAhqJjfxvZPejGCY2j22ZHKwnjMXtDo7h64kTd8ozDodQTAU7MU7D+H1ADHuMX1zJ7XCr6PvguLMB9XS46GfhqOEuuPka1MfjII7kMXLKusND9pJ5MTXNKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A59F0B198248E; Tue, 12 May 2026 21:51:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 22/25] selftests/bpf: Add precision backtracking test for stack arguments
Date: Tue, 12 May 2026 21:51:48 -0700
Message-ID: <20260513045148.2400087-1-yonghong.song@linux.dev>
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

Add a test that verifies precision backtracking works correctly
across BPF-to-BPF calls when stack arguments are involved.

The test passes a size value as incoming stack arg (arg6) to a
subprog, which forwards it as the mem__sz parameter (outgoing arg7)
to bpf_kfunc_call_stack_arg_mem. The expected __msg annotations
verify that precision propagates from the kfunc's mem__sz argument
back through the subprog frame to the caller's outgoing stack arg
store.

A companion BTF file (btf__stack_arg_precision.c) provides named
parameter BTF for the __naked subprog via __btf_func_path.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/stack_arg_precision.c      |  10 ++
 .../bpf/progs/btf__stack_arg_precision.c      |  23 +++
 .../selftests/bpf/progs/stack_arg_precision.c | 134 ++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__stack_arg_prec=
ision.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_precision=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_precision.c=
 b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision.c
new file mode 100644
index 000000000000..1ab041d66de3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "stack_arg_precision.skel.h"
+
+void test_stack_arg_precision(void)
+{
+	RUN_TESTS(stack_arg_precision);
+}
diff --git a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c=
 b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
new file mode 100644
index 000000000000..296fddfe6804
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long=
 size)
+{
+	char buf[8] =3D {};
+
+	return bpf_kfunc_call_stack_arg_mem(a, b, c, d, e, buf, size);
+}
+
+#else
+
+long subprog_call_mem_kfunc(void)
+{
+	return 0;
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/to=
ols/testing/selftests/bpf/progs/stack_arg_precision.c
new file mode 100644
index 000000000000..2a0a344c83ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+/* Force kfunc extern BTF generation for inline asm call below.
+ * Uses its own SEC so it's not included as a .text subprog.
+ * The '?' prefix sets autoload=3Dfalse so libbpf won't load it.
+ */
+SEC("?tc")
+int __btf_kfunc_gen(struct __sk_buff *ctx)
+{
+	char buf[8] =3D {};
+
+	return bpf_kfunc_call_stack_arg_mem(0, 0, 0, 0, 0, buf, sizeof(buf));
+}
+
+/*
+ * Test precision backtracking across bpf-to-bpf call for kfunc stack ar=
g.
+ * subprog_call_mem_kfunc receives a size as incoming stack arg (arg6)
+ * and forwards it as mem__sz (arg7) to bpf_kfunc_call_stack_arg_mem.
+ */
+__naked __noinline __used
+static long subprog_call_mem_kfunc(long a, long b, long c, long d, long =
e, long size)
+{
+	asm volatile (
+		"r1 =3D *(u64 *)(r11 + 8);"	/* r1 =3D incoming arg6 (size) */
+		"r2 =3D 0x0807060504030201 ll;"	/* r2 =3D buf contents */
+		"*(u64 *)(r10 - 8) =3D r2;"	/* store buf to stack */
+		"r2 =3D r10;"
+		"r2 +=3D -8;"			/* r2 =3D &buf */
+		"*(u64 *)(r11 - 8) =3D r2;"	/* outgoing arg6 =3D buf */
+		"*(u64 *)(r11 - 16) =3D r1;"	/* outgoing arg7 =3D size */
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"call %[bpf_kfunc_call_stack_arg_mem];"
+		"exit;"
+		:
+		: __imm(bpf_kfunc_call_stack_arg_mem)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: precision backtracking across bpf2bpf call for=
 kfunc")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__btf_func_path("btf__stack_arg_precision.bpf.o")
+__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1")
+__msg("mark_precise: frame1: regs=3D stack=3D before 25: (b7) r5 =3D 5")
+__msg("mark_precise: frame1: regs=3D stack=3D before 24: (b7) r4 =3D 4")
+__msg("mark_precise: frame1: regs=3D stack=3D before 23: (b7) r3 =3D 3")
+__msg("mark_precise: frame1: regs=3D stack=3D before 22: (b7) r2 =3D 2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 21: (b7) r1 =3D 1")
+__msg("mark_precise: frame1: regs=3D stack=3D before 20: (7b) *(u64 *)(r=
11 -16) =3D r1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 19: (7b) *(u64 *)=
(r11 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 18: (07) r2 +=3D =
-8")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 17: (bf) r2 =3D r=
10")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 16: (7b) *(u64 *)=
(r10 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 14: (18) r2 =3D 0=
x807060504030201")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 13: (79) r1 =3D *=
(u64 *)(r11 +8)")
+__msg("mark_precise: frame1: parent state regs=3D stack=3D:  frame1: R10=
=3Dfp0")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R10=3Dfp0")
+__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13")
+__msg("mark_precise: frame1: regs=3D stack=3D before 11: (85) call pc+1"=
)
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R1=3D1 R2=3D=
2 R3=3D3 R4=3D4 R5=3D5 R10=3Dfp0")
+__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx 11")
+__msg("mark_precise: frame0: regs=3D stack=3D before 9: (05) goto pc+1")
+__msg("mark_precise: frame0: regs=3D stack=3D before 8: (7a) *(u64 *)(r1=
1 -8) =3D 4")
+__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1 ")
+__msg("mark_precise: frame1: regs=3D stack=3D before 25: (b7) r5 =3D 5")
+__msg("mark_precise: frame1: regs=3D stack=3D before 24: (b7) r4 =3D 4")
+__msg("mark_precise: frame1: regs=3D stack=3D before 23: (b7) r3 =3D 3")
+__msg("mark_precise: frame1: regs=3D stack=3D before 22: (b7) r2 =3D 2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 21: (b7) r1 =3D 1")
+__msg("mark_precise: frame1: regs=3D stack=3D before 20: (7b) *(u64 *)(r=
11 -16) =3D r1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 19: (7b) *(u64 *)=
(r11 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 18: (07) r2 +=3D =
-8")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 17: (bf) r2 =3D r=
10")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 16: (7b) *(u64 *)=
(r10 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 14: (18) r2 =3D 0=
x807060504030201")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 13: (79) r1 =3D *=
(u64 *)(r11 +8)")
+__msg("mark_precise: frame1: parent state regs=3D stack=3D:  frame1: R10=
=3Dfp0")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R10=3Dfp0")
+__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13 ")
+__msg("mark_precise: frame1: regs=3D stack=3D before 11: (85) call pc+1"=
)
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R1=3D1 R2=3D=
2 R3=3D3 R4=3D4 R5=3D5 R10=3Dfp0")
+__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx 11 ")
+__msg("mark_precise: frame0: regs=3D stack=3D before 10: (7a) *(u64 *)(r=
11 -8) =3D 6")
+__naked void stack_arg_precision_bpf2bpf(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r6 =3D r0;"
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"if r6 < 2 goto l0_%=3D;"
+		"*(u64 *)(r11 - 8) =3D 4;"
+		"goto l1_%=3D;"
+	"l0_%=3D:"
+		"*(u64 *)(r11 - 8) =3D 6;"
+	"l1_%=3D:"
+		"call subprog_call_mem_kfunc;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+#else
+
+SEC("socket")
+__description("stack_arg_precision: not supported, dummy test")
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
2.53.0-Meta

