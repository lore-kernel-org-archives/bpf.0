Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118873F9F2F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498614; cv=none; b=NhAduifiI1TZBCKcWFJBHJE0pcy77jDhNuprvHiHhD1UMyfTz2lyntc2f2eK29e+JI6YYM9vac6iALKe0c3G8MCcrKI4yw/PC/55iA61mBoiL5l2Ch+eOvcYwiq+9CZjuFNKD2taEwk4l8bshp5gkcYs7I37b9iFT+QCK5xIKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498614; c=relaxed/simple;
	bh=JgwdUWgS2mhqtkJuPJz6Xn1w3RxQM/KIK0wxrrKkWZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npDuw1xUgjE/y/itxtuk/a5ggo/hVbMyPrj8zwjyt+HeuMqDWqye6bb3XZw/SEgN2ily7zYsR8zVOqTEQFCbqAs7MQlLVaLrCsr+wvZt4ncz8FUf7Fl+b2AjRObBxTEdBeoJMtbpAyWlo8UIZk1d5PlvCQDG4pEtOHOVdDCA2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CEDE8288131679; Thu,  3 Sep 2026 22:10:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 01/12] selftests/bpf: Add a test for an __int128 by-value argument
Date: Thu,  3 Sep 2026 22:10:02 -0700
Message-ID: <20260904051002.3976850-1-yonghong.song@linux.dev>
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
  ; __noinline __u64 take_i128_global(int a, u128 v, int c) @ verifier_in=
t128_arg.c:12
  20: (bf) r0 =3D r2                      ; R0=3Dscalar(id=3D4) R2=3Dscal=
ar(id=3D4)
  ; return (__u64)a + (__u64)(v >> 64) + (__u64)v + c; @ verifier_int128_=
arg.c:14
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

Add the test with the failure it produces now. A later patch will fix
this issue so this test should succeed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_int128_arg.c | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_int128_arg=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index f7f94ccebce2..0d68b92d6692 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -50,6 +50,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_int128_arg.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
@@ -214,6 +215,7 @@ void test_verifier_helper_access_var_len(void) { RUN(=
verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_pack=
et_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_rest=
ricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_valu=
e_access); }
+void test_verifier_int128_arg(void)           { RUN_TESTS(verifier_int12=
8_arg); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_c=
allbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/to=
ols/testing/selftests/bpf/progs/verifier_int128_arg.c
new file mode 100644
index 000000000000..419851f2d8d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define MIX_A	0xdeadbeefcafef00dULL
+#define MIX_B	0x0123456789abcdefULL
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

