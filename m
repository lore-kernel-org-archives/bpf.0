Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70B357D0E
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141778; cv=none; b=ar97C8aYDW0/X/9/U7tvak96+wFRYbABo17e2+zgdhurCYLuwJyCK6JzwDl9fRwpN1Suu7mjnZEGkhbrhfA9d2lo5ulo0Uqc1k8B/k1PF50hn0SjQvyOpfJWnB15JifiwjxISOUXc0PnKu6U8Esgv/RHLh+YIsE3jl9oWHnVD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141778; c=relaxed/simple;
	bh=vXQPgAzafnRXLth4GLXrjI7SGcYserHSWZpgoQRqQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coLMdzgEWvGSQSggtrPCA/BiXEB4ZA1rDj0tSoZSQttLlBEkRvE3oPRuYUeWFVQDIXw+dBkmR5nWObrM4ixzkzoy+wM2q4cFnLD4oF6VhdrKb8QhcHyOT6ZMy50qc5I3Yp1U6J+gKCAOylu73+QFUNiodOaAHm6Bi4EllUe3WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 69C8F2A1842F96; Fri, 11 Sep 2026 08:49:24 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 02/15] selftests/bpf: Add a test for an __int128 by-value argument
Date: Fri, 11 Sep 2026 08:49:24 -0700
Message-ID: <20260911154924.2005771-1-yonghong.song@linux.dev>
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

A 128-bit integer is passed in two consecutive argument registers, but
the verifier counts one argument register per parameter whatever its
size. For

  __u64 take_i128_global(int a, u128 v, int c)

the compiler passes a in R1, v in R2:R3 and c in R4, while the verifier
marks only R1 through R3 at the entry of the global function. The callee
then reads its own third parameter out of a register the verifier
considers uninitialized, and the program is rejected for a register the
source never names:

  Validating take_i128_global() func#1...
  20: R1=3Dscalar() R2=3Dscalar() R3=3Dscalar() R10=3Dfp0
  ; __noinline __u64 take_i128_global(int a, u128 v, int c) @ verifier_ag=
gregate_arg.c:12
  20: (bf) r0 =3D r2                      ; R0=3Dscalar(id=3D4) R2=3Dscal=
ar(id=3D4)
  ; return (__u64)a + (__u64)(v >> 64) + (__u64)v + c; @ verifier_aggrega=
te_arg.c:14
  21: (bc) w1 =3D w1                      ; R1=3Dscalar(smin=3D0,smax=3Du=
max=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
  22: (67) r1 <<=3D 32                    ; R1=3Dscalar(smax=3D0x7fffffff=
00000000,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(0x0; 0xffffffff0000000=
0))
  23: (c7) r1 s>>=3D 32                   ; R1=3Dscalar(smin=3D0xffffffff=
80000000,smax=3D0x7fffffff)
  24: (0f) r0 +=3D r1                     ; R0=3Dscalar() R1=3Dscalar(smi=
n=3D0xffffffff80000000,smax=3D0x7fffffff)
  25: (0f) r0 +=3D r3                     ; R0=3Dscalar() R3=3Dscalar()
  26: (bc) w1 =3D w4
  R4 !read_ok

The log is from clang 23. LLVM 21/22 place the argument in the same
registers.

Add the test with the failure it produces now. A later patch, "bpf:
Support __int128 as a by-value function argument", places the two slots
and flips this test to __success.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_aggregate_arg.c        | 40 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_aggregate_=
arg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index f7f94ccebce2..3c7ded537314 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -5,6 +5,7 @@
 #include "arena_kfunc.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
+#include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
@@ -171,6 +172,7 @@ void test_arena_kfunc(void)                   { RUN_T=
ESTS(arena_kfunc); }
=20
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_ji=
t); }
=20
+void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggre=
gate_arg); }
 void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggre=
gate_ret); }
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c b=
/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
new file mode 100644
index 000000000000..d90f754396d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
+
+#ifdef __SIZEOF_INT128__
+
+typedef unsigned __int128 u128;
+
+__noinline __u64 take_i128_global(int a, u128 v, int c)
+{
+	return (__u64)a + (__u64)(v >> 64) + (__u64)v + c;
+}
+
+SEC("tc")
+/*
+ * The verifier counts one argument register for the __int128 and marks =
only
+ * R1 through R3 at the entry of take_i128_global(), while the compiler =
passed
+ * a in R1, v in R2:R3 and c in R4.
+ */
+__failure __msg("R4 !read_ok")
+int aggregate_arg_int128_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (take_i128_global(1, v, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+#endif /* __SIZEOF_INT128__ */
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.52.0

