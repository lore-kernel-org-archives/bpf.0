Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC9329373
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093295; cv=none; b=ASjNXjJI3mQZFcBUR3G3rSmL9FeNKLkxkVRBKWQyw6o3RrDGCiJBMD2bU8NQ4GTrzW8sLnCGABqgfNx6YgVEgEy3cJ5QqAGtAzsqTdE3Ge/54GoMZ2y2p2KvQYhwTB7m5X9cC/cItLT5y1UPYzYoAYIIEKyCo2tic0ZXlk0RHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093295; c=relaxed/simple;
	bh=d3eeJVI6xxEvKf0WUmzAMjuJ8oXbyBcrTP0d3+IZRBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3dAZBlklaJTkEkgDqzCDhkBXO5WQPGdHaAYd/HWYuQSfzWtdgQtf1b9YiKilJJcySyz0ufnpNda8usLVNb9j/aK7RR5BrLyItLz8wrFgr4nIX5e/bLZm1lzdSPhATjJr7FBPScIwZ1u+LYKeuOctL2gJKJN3JOmCaWu1Q/w3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A95403328056A; Wed,  1 Apr 2026 18:28:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 09/10] selftests/bpf: Add negative test for oversized kfunc stack argument
Date: Wed,  1 Apr 2026 18:28:13 -0700
Message-ID: <20260402012813.3922762-1-yonghong.song@linux.dev>
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

Add a test that the verifier rejects kfunc calls where a stack argument
exceeds 8 bytes (the register-sized slot limit).

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/stack_arg_fail.c | 24 ++++++++++++++
 .../selftests/bpf/progs/stack_arg_fail.c      | 32 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  7 ++++
 4 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_fail=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/stack_arg_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c b/to=
ols/testing/selftests/bpf/prog_tests/stack_arg_fail.c
new file mode 100644
index 000000000000..328a79edee45
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "stack_arg_fail.skel.h"
+
+void test_stack_arg_fail(void)
+{
+	struct stack_arg_fail *skel;
+
+	skel =3D stack_arg_fail__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	if (!skel->rodata->has_stack_arg) {
+		test__skip();
+		goto out;
+	}
+
+	ASSERT_ERR(stack_arg_fail__load(skel), "load_should_fail");
+
+out:
+	stack_arg_fail__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/t=
esting/selftests/bpf/progs/stack_arg_fail.c
new file mode 100644
index 000000000000..caa63b6f6a80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+SEC("tc")
+int test_stack_arg_big(struct __sk_buff *skb)
+{
+	struct prog_test_big_arg s =3D { .a =3D 1, .b =3D 2 };
+
+	return bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s);
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+SEC("tc")
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
index d88ab1dc5106..00d0b238219d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -843,6 +843,12 @@ __bpf_kfunc u64 bpf_kfunc_call_stack_arg_mix(u64 a, =
u64 b, u64 c, u64 d, u64 e,
 	return a + b + c + d + e + p->x0 + f + q->x1;
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
@@ -1309,6 +1315,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test5)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_ptr)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mix)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index f93cf2db12b2..b142b87e9f60 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -48,6 +48,11 @@ struct prog_test_pass2 {
 	} x;
 };
=20
+struct prog_test_big_arg {
+	long a;
+	long b;
+};
+
 struct prog_test_fail1 {
 	void *p;
 	int x;
@@ -118,6 +123,8 @@ __u64 bpf_kfunc_call_stack_arg_ptr(__u64 a, __u64 b, =
__u64 c, __u64 d, __u64 e,
 __u64 bpf_kfunc_call_stack_arg_mix(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
 				   struct prog_test_pass1 *p, __u64 f,
 				   struct prog_test_pass1 *q) __ksym;
+__u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_big_arg s) __ksym;
=20
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
--=20
2.52.0

