Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD638F95B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242796; cv=none; b=owZ2PhfnY6Rp//X+YN6GTpZi288lzWkTVX8opmmogLtLs83qvSx7VHi/9O1KArUldc5zHNQbMonnch9P8OszvtzRBMO6s/pdYJY67BwW1pVKVqxdOD0oOyhtp3oKHJp5to/iCuSXOo6t6J2YHk1TvxLCw2o2Haoi+oAC40cV2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242796; c=relaxed/simple;
	bh=va7vwEslftvXbUYbgdoe5relbB+xm4udwmfin22NXoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpo+hEoX5HUY7EN8wmjxizOSn31bcEzORdFV2Xtgstgv24p8IZ3j/UgpW2UaBM9W+J0Ygj3YLl1xLKw/Mi8K29gtxzbjPGcARcna69KKOD/WsUX0cCOb8p2ht7gtX2mvVf5maVO5cJmm24TtTM8wGNlsIXyH5PdcmSIqzqXAtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 081E22A58A0E44; Sat, 12 Sep 2026 12:53:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 14/15] selftests/bpf: Add inline-asm tests for by-value arguments
Date: Sat, 12 Sep 2026 12:53:07 -0700
Message-ID: <20260912195308.992139-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The tests cover a struct passed in a register pair, a pointer in one half
of it refused at the call site, a struct too large to pass by value, and
four placements a global function cannot have: six scalars, a struct spli=
t
between the last argument register and the stack, one wholly past the
registers, and an __int128 whose two slots push the last parameter out.

The six-scalar case is the one whose slot count is known from the
parameters alone, so it takes the check btf_prepare_func_args() makes
before it walks them, while the other three take the one it makes after.
Both report the same way.

GCC passes an aggregate by invisible reference, so a callee it compiles
expects a pointer where BTF says the halves of the struct are, and those
tests are left to clang.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/aggregate_arg.c  |   9 +
 .../selftests/bpf/progs/aggregate_arg_func.c  | 188 ++++++++++++++++++
 2 files changed, 197 insertions(+)
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
index 000000000000..d0a4f84a6fbf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#ifdef __SIZEOF_INT128__
+typedef unsigned __int128 u128;
+#endif
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
+/*
+ * One slot per parameter, so the slot count is settled before the param=
eters
+ * are walked. The cases below reach the same count only once they have =
been.
+ */
+__noinline __u64 global_arg_six_scalars(int a, int b, int c, int d, int =
e, int f)
+{
+	return (__u64)a + b + c + d + e + f;
+}
+
+SEC("tc")
+__failure __msg("global function global_arg_six_scalars() needs 6 > 5 ar=
gument slots")
+__naked int aggregate_arg_six_scalars_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"r2 =3D 0;"
+	"r3 =3D 0;"
+	"r4 =3D 0;"
+	"r5 =3D 0;"
+	"call %[global_arg_six_scalars];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_arg_six_scalars)
+	: __clobber_all);
+}
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
+#ifdef __SIZEOF_INT128__
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
+#endif /* __SIZEOF_INT128__ */
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

