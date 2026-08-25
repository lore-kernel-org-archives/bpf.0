Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25D3D6477
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691307; cv=none; b=uUoOI0zdy1So2iEL1QFhF0afhuBtrTDpR7AhGQCg55xh+HoLaE3dlRHajEwBKVmWmrAHpZ6inrHkVRdZvUWR/WBgon70JivtldQgdm9cVH/ID5s6YS+V6w5sAWTxU1soBl/wqHNLgEg1aigdaf346ncO95YjRrM0WPcl7FDgdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691307; c=relaxed/simple;
	bh=GRTnTpR8rGTRdIyu1cIxu3uACV7CHDGUnC7wfoHe7ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyRhRalFdf5nstmqaSO7rnaD0J+AgSF/x8sQWHKtZGrrbvfmVvkBUTzmTyinrTZYp/9lw+c6qIQYAdYfSvA+6nZGPxBtgbnXQS1oQ+QX/+Qe/qqlDv84c32X9OKtN8tNqbZQUeiBvmbrtZ3fZNiUgU0IGVrPNft07FLNU207ldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 72F79268293E0C; Tue, 25 Aug 2026 13:54:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 09/10] selftests/bpf: Test global functions returning arena pointers by value
Date: Tue, 25 Aug 2026 13:54:58 -0700
Message-ID: <20260825205458.1325916-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825205412.1320099-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_ret_func.c  | 118 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_arena.c      |  37 ++++++
 2 files changed, 155 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/too=
ls/testing/selftests/bpf/progs/aggregate_ret_func.c
index 6f66fc822ced..237adb8e5ee1 100644
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
@@ -234,4 +235,121 @@ __naked int aggregate_ret_global_union_ptr_fail(voi=
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
+#endif
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
index 815f342eb4b0..d37424d1161a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -734,4 +734,41 @@ int check_arena_arg_ret(void *ctx)
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
+	struct arena_page_pair pair;
+
+	if (!page)
+		return 1;
+
+	pair =3D split_arena_page(page);
+	if (!pair.first || !pair.second)
+		return 2;
+
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

