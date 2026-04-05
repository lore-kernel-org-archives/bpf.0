Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E61946BC
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408103; cv=none; b=sQZcJqp0LmttHVMhdOzJ4HhKq/aBXhgHxSmeKPXK95Xq7fxJXm38TwUKTxtqjBulwgA5QVwIIjb3W1weEmvNzuVdXfzGWfRJRQfysdDtaYvvPY2wC2RwIxKvoI2H5CCacglhVXqLkYD3bsv3ZiI8ZvXGQuo8xvq2ryjBO3VD5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408103; c=relaxed/simple;
	bh=f5PFtJLdXTsdYlVh713hMms8qwU9VKikO9wJ7EI2tGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY/3kI/dntx9gXrPMbE7Odg9oQ+Lt8b3+FuXmVaIuZiMI9YMcSKb49KiYrSN032q016UsP57FomMbDajeZ33gGe2epDWz6OTBynOj6Bkxlyjw2BIJ9LUhS6U/1qH42gb5K0zjnfcO5u5MFDmnM1y2SfLkAAjhW+TfR3gWcQMG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 05BD0361CF30A; Sun,  5 Apr 2026 09:54:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 10/11] selftests/bpf: Add negative test for greater-than-8-byte kfunc stack argument
Date: Sun,  5 Apr 2026 09:54:48 -0700
Message-ID: <20260405165448.837885-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405165300.826241-1-yonghong.song@linux.dev>
References: <20260405165300.826241-1-yonghong.song@linux.dev>
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
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  8 +++++
 4 files changed, 71 insertions(+)
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
index 4fcdb13e4a9a..861c564cc330 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -881,6 +881,12 @@ __bpf_kfunc u64 bpf_kfunc_call_stack_arg_timer(u64 a=
, u64 b, u64 c, u64 d, u64 e
 	return a + b + c + d + e;
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
@@ -1352,6 +1358,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_mem)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_iter)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_const_str)
 BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_timer)
+BTF_ID_FLAGS(func, bpf_kfunc_call_stack_arg_big)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2c1cb118f886..2a40f80b074a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -50,6 +50,11 @@ struct prog_test_pass2 {
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
@@ -130,6 +135,9 @@ __u64 bpf_kfunc_call_stack_arg_const_str(__u64 a, __u=
64 b, __u64 c, __u64 d, __u
 					 const char *str__str) __ksym;
 __u64 bpf_kfunc_call_stack_arg_timer(__u64 a, __u64 b, __u64 c, __u64 d,=
 __u64 e,
 				     struct bpf_timer *timer) __ksym;
+__u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, _=
_u64 e,
+				   struct prog_test_big_arg s) __ksym;
+
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
--=20
2.52.0

