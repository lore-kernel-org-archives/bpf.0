Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F640DFC5
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093302; cv=none; b=GVBXD7nohD4l6fPwlG8Vhjs3PcdUQVqIMPCXkHgUcBXRmumC6GK9nFZ3AQQUP6cvgg3RqIxoMpIGxzuGzckhcFpmTazlcyLpquS36tOCo3hP9i9UH30l6Wgh4ExumejLW/9s7dMblMlWKT5LAAtkOahjoaD4qhrpZrWMEhX3kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093302; c=relaxed/simple;
	bh=ZHFqC4uWuevcZderyHpBERVUyLia8dCf2wzemyzsQuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0/QjGstnYXohlI65yfv/4mlfrtlfw7JGNEg0jqFbifQqeFPGa5ZJNqBYjA/PHY6mxRq50D59g7KliPetFxXCRTEJqMHZdyfhhqt8gWs12vjPCzelbgHdV9cWvHkatO1vPyP1PFjx/x2i4pBjz1OHOM/lnzFhEU3LbXUYgyUNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D4C7833280592; Wed,  1 Apr 2026 18:28:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 10/10] selftests/bpf: Add verifier tests for stack argument validation
Date: Wed,  1 Apr 2026 18:28:18 -0700
Message-ID: <20260402012818.3923396-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402012727.3916819-1-yonghong.song@linux.dev>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
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
 .../selftests/bpf/progs/verifier_stack_arg.c  | 122 ++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_arg.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index bcf01cb4cfe4..cbdbcb913bae 100644
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
@@ -235,6 +236,7 @@ void test_verifier_sock_addr(void)            { RUN(v=
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
index 000000000000..eb1005c771f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+__description("stack_arg: gap at offset -8, only wrote -16")
+__failure
+__msg("stack arg#6 not properly initialized")
+__arch_x86_64
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
+__description("stack_arg: misaligned stack arg write")
+__failure
+__msg("stack arg write must be 8 bytes, got 4")
+__arch_x86_64
+__naked void stack_arg_not_written(void)
+{
+	asm volatile (
+		"r1 =3D 1;"
+		"r2 =3D 2;"
+		"r3 =3D 3;"
+		"r4 =3D 4;"
+		"r5 =3D 5;"
+		"*(u32 *)(r12 - 4) =3D 30;"
+		"call subprog_6args;"
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

