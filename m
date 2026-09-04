Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1E3F9F2F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498667; cv=none; b=nz+vwngMb+fu1DLOGZOo0QJnk9rrsHzkgpVquPGZuTcaSRgSbortiM5pB/U8Itg10Hco7PTgboitDmPkEEgPu4qEPRnmUoT8LqWQ6VvGC/Tkre4gpEhF/g791wTHbF/ktiyI9mi6M1Zc1XKTDNrvIAuzn/LFeyw9lcRiQQy3Eq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498667; c=relaxed/simple;
	bh=1Q0EcthOAram9Mjgjv+8A85Z/4DljIYTjAYOG2DhyfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CefZHD534FTjw84WZF/VXR43mHfgVVCt/5A3ZHE0ndKD3p4tlB6lREp9Dpl+zta8shtmGAttyJLKjzKNkh7lVwRAv754Z36NE1CRd38pVCtcKBuION2c6FA+IdgQFMM6/mWFlq+c11aKY9bFgL2+LhQoHmLm6cxQXcbg4Fq6MCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E9DD728814FBB3; Thu,  3 Sep 2026 22:10:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 11/12] selftests/bpf: Add inline-asm tests for by-value arguments
Date: Thu,  3 Sep 2026 22:10:54 -0700
Message-ID: <20260904051054.3983495-1-yonghong.song@linux.dev>
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

The tests cover a struct passed in a register pair, a pointer in one half
of it refused at the call site, a struct too large to pass by value, and
three placements a global function cannot have: a struct split between th=
e
last argument register and the stack, one wholly past the registers, and
an __int128 whose two slots push the last parameter out.

GCC passes an aggregate by invisible reference, so a callee it compiles
expects a pointer where BTF says the halves of the struct are, and those
tests are left to clang.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |   9 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 155 ++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/aggregate_arg.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_arg_func.=
c

diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_arg.c
new file mode 100644
index 000000000000..b230f3bd3b2a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/aggregate_arg.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "aggregate_arg_func.skel.h"
+
+void test_aggregate_arg(void)
+{
+	RUN_TESTS(aggregate_arg_func);
+}
diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_arg_func.c
new file mode 100644
index 000000000000..61dd5f86c3a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+typedef unsigned __int128 u128;
+
+struct pair {
+	__u64 lo;
+	__u64 hi;
+};
+
+struct too_big {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+};
+
+#if defined(__clang__)
+
+__noinline __u64 global_arg_pair(int a, struct pair p, int c)
+{
+	return (__u64)a + p.lo + p.hi + c;
+}
+
+SEC("tc")
+__success __retval(0x33)
+__naked int aggregate_arg_pair_asm(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"r2 =3D 0x10;"	/* p.lo */
+	"r3 =3D 0x20;"	/* p.hi */
+	"r4 =3D 2;"
+	"call %[global_arg_pair];"
+	"exit;"
+	:
+	: __imm(global_arg_pair)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("R2 is not a scalar")
+__naked int aggregate_arg_pair_ptr_fail(void)
+{
+	asm volatile (
+	"r1 =3D 1;"
+	"r2 =3D r10;"	/* a stack pointer where p.lo belongs */
+	"r3 =3D 0x20;"
+	"r4 =3D 2;"
+	"call %[global_arg_pair];"
+	"exit;"
+	:
+	: __imm(global_arg_pair)
+	: __clobber_all);
+}
+
+#endif
+
+__noinline __u64 global_arg_too_big(struct too_big s)
+{
+	return s.a + s.b + s.c;
+}
+
+SEC("tc")
+__failure __msg("in global_arg_too_big() has size 24, only 1 to 16 bytes=
 can be passed by value")
+__naked int aggregate_arg_too_big_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"r3 =3D 0;"
+	"call %[global_arg_too_big];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_arg_too_big)
+	: __clobber_all);
+}
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+__noinline __u64 global_arg_split(int a, int b, int c, int d, struct pai=
r p)
+{
+	return (__u64)a + b + c + d + p.lo + p.hi;
+}
+
+SEC("tc")
+__failure __msg("global function global_arg_split() needs 6 > 5 argument=
 slots")
+__naked int aggregate_arg_split_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"r3 =3D 0;"
+	"r4 =3D 0;"
+	"r5 =3D 0;"
+	"call %[global_arg_split];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_arg_split)
+	: __clobber_all);
+}
+
+__noinline __u64 global_arg_past_regs(struct pair p, struct pair q, int =
a, struct pair r)
+{
+	return p.lo + p.hi + q.lo + q.hi + a + r.lo + r.hi;
+}
+
+SEC("tc")
+__failure __msg("global function global_arg_past_regs() needs 7 > 5 argu=
ment slots")
+__naked int aggregate_arg_past_regs_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"r3 =3D 0;"
+	"r4 =3D 0;"
+	"r5 =3D 0;"
+	"call %[global_arg_past_regs];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_arg_past_regs)
+	: __clobber_all);
+}
+
+__noinline __u64 global_arg_i128_slots(u128 v, int a, int b, int c, int =
d)
+{
+	return (__u64)v + a + b + c + d;
+}
+
+SEC("tc")
+__failure __msg("global function global_arg_i128_slots() needs 6 > 5 arg=
ument slots")
+__naked int aggregate_arg_i128_slots_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"r3 =3D 0;"
+	"r4 =3D 0;"
+	"r5 =3D 0;"
+	"call %[global_arg_i128_slots];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_arg_i128_slots)
+	: __clobber_all);
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

