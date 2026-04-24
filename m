Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F13335575
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051043; cv=none; b=FWppPq2cb30L4hIFpAmeMYbIJAJjnsEIsVpXfp0aUy4YnPchEwm+sIxZukCZDiDGrr/AkLTajHuC1OEgwD5+fLm+njEOg9DuRuqFKMIry9YidqHdVVFvJTTcdrBDHONmWlGWTb1JdWHi7kHWpi3aVDOd1IyOYwnNdnSsy+1HdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051043; c=relaxed/simple;
	bh=9u5cJSSIwRZdYVZazD1LmpUO4fmAbEBxUDoSmslRgj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvKosubu+ouoLJKIlQvqUh+pr6GQH78lVioEpa8iVtYxOkBV6ZXDWuRfoZ8o1Abga8CfNETiXDOe8aJQuOtz0rzBMDpghnKTnTTCLoPZB2os6gL57IApNNno4z8w0Cab/pZ3Q8VwQa/FwX9b40cYDsxNB2swiVooiGxUPS6b99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C732C474A701E; Fri, 24 Apr 2026 10:17:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 15/18] selftests/bpf: Add precision backtracking test for stack arguments
Date: Fri, 24 Apr 2026 10:17:13 -0700
Message-ID: <20260424171713.2056647-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
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
subprog, which bounds-checks it and forwards it as the mem__sz
parameter (outgoing arg7) to bpf_kfunc_call_stack_arg_mem. The
expected __msg annotations verify that precision propagates from
the kfunc's mem__sz argument back through the subprog frame to the
caller's outgoing stack arg store.

A companion BTF file (btf__stack_arg_precision.c) provides named
parameter BTF for the __naked subprog via __btf_func_path.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/stack_arg_precision.c      |  10 ++
 .../bpf/progs/btf__stack_arg_precision.c      |  23 ++++
 .../selftests/bpf/progs/stack_arg_precision.c | 121 ++++++++++++++++++
 3 files changed, 154 insertions(+)
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
index 000000000000..29b2f2aea931
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -0,0 +1,121 @@
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
+ * subprog_call_mem_kfunc receives a size as incoming stack arg (arg6),
+ * bounds-checks it, then passes it as mem__sz (arg7) to
+ * bpf_kfunc_call_stack_arg_mem.
+ *
+ * 1+2+3+4+5+(1+2+3+4) =3D 25
+ */
+__naked __noinline __used
+static long subprog_call_mem_kfunc(long a, long b, long c, long d, long =
e, long size)
+{
+	asm volatile (
+		"r1 =3D *(u64 *)(r11 + 8);"	/* r1 =3D incoming arg6 (size) */
+		"r2 =3D 0x0807060504030201 ll;"	/* r2 =3D buf contents */
+		"*(u64 *)(r10 - 8) =3D r2;"	/* store buf to stack */
+		"r0 =3D -1;"
+		"if r1 s< 1 goto 1f;"
+		"if r1 s> 8 goto 1f;"
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
+		"1: exit;"
+		:
+		: __imm(bpf_kfunc_call_stack_arg_mem)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: precision backtracking across bpf2bpf call for=
 kfunc")
+__success __retval(25)
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__btf_func_path("btf__stack_arg_precision.bpf.o")
+__msg("mark_precise: frame1: last_idx 24 first_idx 14 subseq_idx -1")
+__msg("mark_precise: frame1: regs=3D stack=3D before 23: (b7) r5 =3D 5")
+__msg("mark_precise: frame1: regs=3D stack=3D before 22: (b7) r4 =3D 4")
+__msg("mark_precise: frame1: regs=3D stack=3D before 21: (b7) r3 =3D 3")
+__msg("mark_precise: frame1: regs=3D stack=3D before 20: (b7) r2 =3D 2")
+__msg("mark_precise: frame1: regs=3D stack=3D before 19: (b7) r1 =3D 1")
+__msg("mark_precise: frame1: regs=3D stack=3D before 18: (7b) *(u64 *)(r=
11 -16) =3D r1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 17: (7b) *(u64 *)=
(r11 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 16: (07) r2 +=3D =
-8")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 15: (bf) r2 =3D r=
10")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 14: (65) if r1 s>=
 0x8 goto pc+10")
+__msg("mark_precise: frame1: parent state regs=3Dr1 stack=3D:  frame1: R=
0=3D-1 R1=3DPscalar")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R10=3Dfp0")
+__msg("mark_precise: frame1: last_idx 13 first_idx 13 subseq_idx 14")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 13: (c5) if r1 s<=
 0x1 goto pc+11")
+__msg("mark_precise: frame1: parent state regs=3Dr1 stack=3D:  frame1: R=
0=3D-1 R1=3DPscalar() R10=3Dfp0 fp-8=3D0x807060504030201")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R10=3Dfp0")
+__msg("mark_precise: frame1: last_idx 12 first_idx 8 subseq_idx 1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 12: (b7) r0 =3D -=
1")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 11: (7b) *(u64 *)=
(r10 -8) =3D r2")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 9: (18) r2 =3D 0x=
807060504030201")
+__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 8: (79) r1 =3D *(=
u64 *)(r11 +8)")
+__msg("mark_precise: frame1: parent state regs=3D stack=3D:  frame1: R10=
=3Dfp0")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R10=3Dfp0")
+__msg("mark_precise: frame1: last_idx 6 first_idx 6 subseq_idx 8")
+__msg("mark_precise: frame1: regs=3D stack=3D before 6: (85) call pc+1")
+__msg("mark_precise: frame0: parent state regs=3D stack=3D:  R1=3D1 R2=3D=
2 R3=3D3 R4=3D4 R5=3D5 R10=3Dfp0")
+__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx 6")
+__msg("mark_precise: frame0: regs=3D stack=3D before 5: (7a) *(u64 *)(r1=
1 -8) =3D 4")
+__msg("mark_precise: frame1: last_idx 24 first_idx 14 subseq_idx -1")
+__naked void stack_arg_precision_bpf2bpf(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u64 *)(r11 - 8) =3D 4;"
+		"call subprog_call_mem_kfunc;"
+		"exit;"
+		::: __clobber_all
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
2.52.0

