Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40723469EE
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811124; cv=none; b=LCU8aWfO0tp31c7wNAVzQ2zLzAsLzsnuoRyvRV+QZ6ONhsMbNH47KZPg+TPfus3aYYN7iaSIE0XUq15Oy6jnyMzFWTq5xeq9faPzB0LMfg4QdRmCOtrHRSIkB2hveG6dILotIFCsk81c1t+TfKAgMbMmqQi5GptIh0N4Qrf2ZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811124; c=relaxed/simple;
	bh=qNXjx+u+26+e6luB0jg6rX4Gze2ZfM9RHvTmVO0XoBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWNEUbUOLv+yBPune00ctvV4aiYeBkooD8CZl+flrFM/6XbTsPd3ft3cBqIewjByqrwU15SYOHpzcUkHm7pVeigM2r5r2Lk5v0vp8rXVVHK90NfTD6zPSpO9JgI1pROx6OwVS1ExP1ELpKpkjXi5ZfUEkel0vVlH/SiTJKMcgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 01C5626CDEC6BA; Wed, 26 Aug 2026 23:12:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 09/11] selftests/bpf: Test global functions returning arena pointers by value
Date: Wed, 26 Aug 2026 23:12:00 -0700
Message-ID: <20260827061200.2519335-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827061114.2514603-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the by-value struct returns a global function may now make: two
arena pointers filling R0:R2, an arena pointer beside a scalar, an array
of them, and an eight byte struct returned in R0 alone. The existing
cases for a struct and a union carrying a plain pointer stay rejected.

check_arena_struct_ret() also stores through both halves of the returned
pair and reads them back, so the test covers the returned pointers still
being usable as arena pointers rather than only the program verifying.

A toolchain guard goes into each file, and they differ because the
constructs do.

aggregate_ret_func.c uses "#if defined(__clang__)". Those cases are
__naked, so the function body is the inline asm and nothing else: the
clang compiler never lowers the return, and the 16 byte return type
reaches the verifier only through BTF. The minimum checked is LLVM 21.
gcc is excluded because it returns a by-value struct through a hidden
pointer and emits the 'r0 =3D r1' returning it after the __naked body's
exit, leaving the subprogram falling through.

verifier_arena.c uses "#if defined(__clang_major__) && __clang_major__ >=3D
23". split_arena_page() returns the struct from C, so the compiler lowers
the return itself, and a 16 byte return only lands in R0:R2 with the
LLVM 23 BPF ABI. An older clang does not fall back to anything here, it
rejects the function with "aggregate returns are not supported", so the
floor is what lets the file build at all.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_ret_func.c  | 146 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_arena.c      |  48 ++++++
 2 files changed, 194 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
index 6f66fc822ced..f0077d951a25 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf_arena_common.h>
 #include "bpf_misc.h"
=20
 typedef unsigned __int128 u128;
@@ -234,4 +235,149 @@ __naked int aggregate_ret_global_union_ptr_fail(voi=
d)
=20
 #endif
=20
+/*
+ * gcc returns a by-value struct through a hidden pointer, and emits the
+ * 'r0 =3D r1' returning it after the __naked body's exit, leaving the
+ * subprogram falling through. Build these with clang only.
+ */
+#if defined(__clang__)
+
+struct arena_pair {
+	void __arena *lo;
+	void __arena *hi;
+};
+
+struct arena_and_scalar {
+	void __arena *p;
+	__u64 x;
+};
+
+struct arena_array {
+	void __arena *p[2];
+};
+
+struct arena_single {
+	void __arena *p;
+};
+
+union arena_upair {
+	void __arena *p;
+	__u64 halves[2];
+};
+
+__naked struct arena_pair global_ret_arena_pair(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_global_arena_pair(void)
+{
+	asm volatile (
+	"call %[global_ret_arena_pair];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_arena_pair)
+	: __clobber_all);
+}
+
+__naked struct arena_and_scalar global_ret_arena_and_scalar(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_global_arena_and_scalar(void)
+{
+	asm volatile (
+	"call %[global_ret_arena_and_scalar];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_arena_and_scalar)
+	: __clobber_all);
+}
+
+__naked struct arena_array global_ret_arena_array(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_global_arena_array(void)
+{
+	asm volatile (
+	"call %[global_ret_arena_array];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_arena_array)
+	: __clobber_all);
+}
+
+__naked struct arena_single global_ret_arena_single(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__success __retval(0)
+__naked int aggregate_ret_global_arena_single(void)
+{
+	asm volatile (
+	"call %[global_ret_arena_single];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_arena_single)
+	: __clobber_all);
+}
+
+__naked union arena_upair global_ret_arena_union(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"r2 =3D 0;"
+	"exit;"
+	);
+}
+
+SEC("tc")
+__load_if_JITed()
+__success __retval(0)
+__naked int aggregate_ret_global_arena_union(void)
+{
+	asm volatile (
+	"call %[global_ret_arena_union];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(global_ret_arena_union)
+	: __clobber_all);
+}
+
+#endif
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
index 815f342eb4b0..672a3aadd9cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -734,4 +734,52 @@ int check_arena_arg_ret(void *ctx)
 	return 0;
 }
=20
+#if defined(__clang_major__) && __clang_major__ >=3D 23
+
+struct arena_page_pair {
+	u32 __arena *first;
+	u32 __arena *second;
+};
+
+__weak struct arena_page_pair split_arena_page(u32 __arena *page)
+{
+	struct arena_page_pair pair;
+
+	pair.first =3D page;
+	pair.second =3D page + 1;
+
+	return pair;
+}
+
+SEC("syscall")
+__load_if_JITed()
+__success __retval(0)
+int check_arena_struct_ret(void *ctx)
+{
+	u32 __arena *page =3D bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NO=
DE, 0);
+	u32 volatile __arena *first, *second;
+	struct arena_page_pair pair;
+
+	if (!page)
+		return 1;
+
+	pair =3D split_arena_page(page);
+	if (!pair.first || !pair.second)
+		return 2;
+
+	/* Both halves of the pair must still be usable as arena pointers. */
+	first =3D pair.first;
+	second =3D pair.second;
+	*first =3D 1;
+	*second =3D 2;
+	if (*first !=3D 1)
+		return 3;
+	if (*second !=3D 2)
+		return 4;
+
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

