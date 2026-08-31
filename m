Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BB39E18E
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174356; cv=none; b=ErKwUiAe8DsyWILKDwNNKbbeOm3/TmBCtQ9Wxgzz/C8iQqom/37ZB0iiPPzPLtXR7b26rNjASctjkLExgY8FB2D3pJv59//kkRAbUaoYEMqPzCZfGNSvIM7Tr8ut/YAWNxgCjf++GeQZ5VjJVHT5ZrAUxcoWHiU7WakDWBAu64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174356; c=relaxed/simple;
	bh=4uP82EAtBfHYzE0BX91YpcIeTVIQbLCyiWnv6c3JKd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qifmtEzrwOK23CZsrgFCXyPYRWg91s1FMOV/HssYn2/7N/ZxAtKAR7jjloBWstpuUMVnEy2N53GPoKIUTlT/6+RKK/xjc0kR+WZIPpvqfo6eTaQmTKRQquLUMv3s3YAbEagxnTbcTlQCZVh2b7UW0Neaj3/yveoGwzDvD8o1wJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R0qUIyoH; arc=none smtp.client-ip=95.215.58.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R0qUIyoH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4uP82EAtBfHYzE0BX91YpcIeTVIQbLCyiWnv6c3JKd4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174351; v=1; x=1788779151;
 b=R0qUIyoHsrQiJ4n/VzBz+3eOXEIRQfCfnMhGMtP+IaJf/baxmhAyzhcGdt09ZpRby/owFVls
 UYM2iLpX5QobRBvyWObeDsjbbfQxcuSNc3HvZcLVxpec2rQxPP3NHYKfJrBjMD2We/nXAzJcBPW
 FL59dwjBjapE5KsZtm12MX68=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f2098870f5880476;
	Mon, 31 Aug 2026 11:05:51 +0000
X-Mizu-Trace-ID: f2098870f5880476
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 5/5] selftests/bpf: Add test for showing a void BTF type
Date: Mon, 31 Aug 2026 19:01:10 +0800
Message-ID: <20260831110314.150870-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110314.150870-1-jiayuan.chen@linux.dev>
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call bpf_snprintf_btf() with type_ids from the vmlinux BTF that used to
NULL-deref in the BTF show path: a "const void" (checked to render the
"<unsupported kind:0>" placeholder) and a BTF_KIND_VAR (checked to render
without crashing). On an unfixed kernel each oopses the task (and panics
it under panic_on_oops), so the test doubles as a reproducer.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_show_void.c  | 81 +++++++++++++++++++
 .../selftests/bpf/progs/btf_show_void.c       | 24 ++++++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_show_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_show_void.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_show_void.c b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
new file mode 100644
index 000000000000..d73232dc2a04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_show_void.skel.h"
+
+/*
+ * bpf_snprintf_btf() renders a type_id taken straight from the vmlinux BTF.
+ * Two such type_ids used to NULL-deref in the BTF show path:
+ *   - a "const void" (a modifier resolving to void) in btf_modifier_show()
+ *   - a BTF_KIND_VAR in btf_var_show() (base BTF has no resolved_ids)
+ * A fixed kernel renders both without crashing.
+ */
+static long run(struct btf_show_void *skel, __u32 type_id)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char ctx[8] = {};
+
+	skel->bss->type_id = type_id;
+	topts.ctx_in = ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.dump_type),
+					      &topts), "test_run"))
+		return -1;
+	return skel->bss->ret;
+}
+
+void test_btf_show_void(void)
+{
+	const struct btf_type *t;
+	struct btf_show_void *skel;
+	int i, n, cv = 0, var = 0;
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!btf) {
+		test__skip();
+		return;
+	}
+
+	skel = btf_show_void__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out_btf;
+
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n && !(cv && var); i++) {
+		t = btf__type_by_id(btf, i);
+		if (!cv && btf_kind(t) == BTF_KIND_CONST && t->type == 0)
+			cv = i;
+		/* Pick a VAR small enough to render from the program's buffer. */
+		if (!var && btf_kind(t) == BTF_KIND_VAR) {
+			long sz = btf__resolve_size(btf, t->type);
+
+			if (sz > 0 && sz <= (long)sizeof(skel->bss->obj))
+				var = i;
+		}
+	}
+
+	/* "const void" renders the "<unsupported kind:0>" placeholder. */
+	if (test__start_subtest("const_void")) {
+		if (cv) {
+			ASSERT_EQ(run(skel, cv),
+				  sizeof("<unsupported kind:0>") - 1, "ret");
+			ASSERT_STREQ(skel->bss->out, "<unsupported kind:0>",
+				     "placeholder");
+		} else {
+			test__skip();
+		}
+	}
+
+	/* A BTF_KIND_VAR must resolve and render without error. */
+	if (test__start_subtest("var")) {
+		if (var)
+			ASSERT_GT(run(skel, var), 0, "ret");
+		else
+			test__skip();
+	}
+
+	btf_show_void__destroy(skel);
+out_btf:
+	btf__free(btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/btf_show_void.c b/tools/testing/selftests/bpf/progs/btf_show_void.c
new file mode 100644
index 000000000000..44af80fbbb80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_show_void.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "btf_ptr.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 type_id;
+/* A buffer we own to render the selected type from, kept in bounds. */
+char obj[256];
+char out[64];
+long ret;
+
+SEC("raw_tp/sys_enter")
+int dump_type(void *ctx)
+{
+	struct btf_ptr ptr = {
+		.ptr = obj,
+		.type_id = type_id,
+		.flags = 0,
+	};
+
+	ret = bpf_snprintf_btf(out, sizeof(out), &ptr, sizeof(ptr), 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

