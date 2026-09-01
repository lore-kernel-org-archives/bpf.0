Received: from mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FF477981
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259930; cv=none; b=bVFmWfEtMyRJRuZZf+lksFac8EAvEvoc1w5JHLcZo96Fz7i9YRsltRWAcOONLcMFlb5tTsRlnWp8yWLUrL5MhQ6tKDqnslSLVV6REW+uv/TmDOlPEzMK3wfAhG6ZdnifKoYhuYpYbvXRNrbWfDmM76LLG8letP9nvazrt7KZKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259930; c=relaxed/simple;
	bh=Lw7FlsSYwx9NIxyyRCjoPzXtc3uYAtj1sWqV4v49tus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX27JliFs4VJFMJATlP70Gd1f6r6bUOOvHbjeTWHUQuSrZ19L6hsy/6s2TX5tyTRy7jTxEgHE+N2ZFj/fJrilJNtTy10y9Bmpj4qbD4qqG9z+DT23ttKJDKb022DP+RxUw8qnxB66zICXYe1TZduscoIWkKaXHNgW5fC94ZfqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxhoECTe; arc=none smtp.client-ip=95.215.58.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxhoECTe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Lw7FlsSYwx9NIxyyRCjoPzXtc3uYAtj1sWqV4v49tus=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788259924; v=1; x=1788864724;
 b=YxhoECTepcZG0pY/Ya36r7O1nffsLoGLNOqJjE+iK6sOKVplMhnweao/xHO/A6Oa+psAR1d3
 IN8CnTkC4HFgl1h9kvyq7jMHMvRD4WWw94sNgk/BpVfzUDLbT9gkddkpXNUdfYGFUhgEV/BCiRQ
 oLwQJDfhvUcyz086Tsiwj+pw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66d397e71cc3a3e9;
	Tue, 01 Sep 2026 10:52:04 +0000
X-Mizu-Trace-ID: 66d397e71cc3a3e9
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
Subject: [PATCH bpf v4 5/5] selftests/bpf: Add test for showing a void BTF type
Date: Tue,  1 Sep 2026 18:47:39 +0800
Message-ID: <20260901104924.346187-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901104924.346187-1-jiayuan.chen@linux.dev>
References: <20260901104924.346187-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the snprintf_btf test with type_ids from the vmlinux BTF that
used to NULL-deref in the BTF show path: a "const void", checked to
render the "<unsupported kind:0>" placeholder, and a BTF_KIND_VAR,
checked to resolve and render without error.

The program renders from its own buffer and the test picks a VAR whose
resolved type fits it, so the render stays in bounds.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/snprintf_btf.c   | 79 +++++++++++++++++++
 .../selftests/bpf/progs/snprintf_btf_void.c   | 24 ++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/snprintf_btf_void.c

diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
index dd41b826be30..edce9c1b54fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf_btf.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <linux/btf.h>
+#include <bpf/btf.h>
 #include "netif_receive_skb.skel.h"
+#include "snprintf_btf_void.skel.h"
 
 /* Demonstrate that bpf_snprintf_btf succeeds and that various data types
  * are formatted correctly.
@@ -58,3 +60,80 @@ void serial_test_snprintf_btf(void)
 cleanup:
 	netif_receive_skb__destroy(skel);
 }
+
+/*
+ * bpf_snprintf_btf() renders a type_id taken straight from the vmlinux BTF.
+ * Two such type_ids used to NULL-deref in the BTF show path:
+ *   - a "const void" (a modifier resolving to void) in btf_modifier_show()
+ *   - a BTF_KIND_VAR in btf_var_show() (base BTF has no resolved_ids)
+ * A fixed kernel renders both without crashing.
+ */
+static long run(struct snprintf_btf_void *skel, __u32 type_id)
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
+void test_snprintf_btf_void(void)
+{
+	const struct btf_type *t;
+	struct snprintf_btf_void *skel;
+	int i, n, cv = 0, var = 0;
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!btf) {
+		test__skip();
+		return;
+	}
+
+	skel = snprintf_btf_void__open_and_load();
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
+	snprintf_btf_void__destroy(skel);
+out_btf:
+	btf__free(btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/snprintf_btf_void.c b/tools/testing/selftests/bpf/progs/snprintf_btf_void.c
new file mode 100644
index 000000000000..44af80fbbb80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/snprintf_btf_void.c
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

