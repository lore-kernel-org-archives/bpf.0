Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D303845A4
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075292; cv=none; b=cUo58WY/2D8frsmWFRap9RokfjfakvoxagfQcYfm8k5JwjnV4LR5SEPfBFUPwusmRWNIBXA8/iVn38VgRxk7Eq3rpPc2PYo017BNYsTMj7wOdVUcAyIOdhugqJrjiqJe98mzYZ4bgK+qLcTKjR16Sq4tG7IGEO3MG0n0XQvOOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075292; c=relaxed/simple;
	bh=3hNN2sJx7jce4kX+dZSg5U54CCuIoPecIBlxjnu4xRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxM8bBw50UqfQIErHCuh4vZ76a9uzkzGYrNCcINMYWFtI3dlZ32my9/D4js4anYniG7gU7+1Rwa8XXI2RqZN9Bwb/X4aHCbbvLLaiZlM0xPBnrzEKknmKTYfkfcUWA+GOoK538BvE1vseiyDurBR02TiF+jOEP0YZjFNaQmHkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWw1RItb; arc=none smtp.client-ip=91.218.175.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWw1RItb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3hNN2sJx7jce4kX+dZSg5U54CCuIoPecIBlxjnu4xRQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788075287; v=1; x=1788680087;
 b=FWw1RItbbjz8QQfYXfgCpxOHFNnjN5y4kHK83vEEc8KATz459Qs+eU4N9lvp/yg2fi1tjaNk
 n9fwzlkqNFBNHXnUpnSMJlaapaXtw4cTy6SmIBC2nOlgXvTX5jouQhiOcOf1YO5RP7y4+IjrhzF
 HlJxbI8+6//AOOvgdhYPBZt0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7828805adfc406f3;
	Sun, 30 Aug 2026 07:34:47 +0000
X-Mizu-Trace-ID: 7828805adfc406f3
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
Subject: [PATCH bpf v2 4/4] selftests/bpf: Add test for showing a void BTF type
Date: Sun, 30 Aug 2026 15:30:59 +0800
Message-ID: <20260830073242.148092-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830073242.148092-1-jiayuan.chen@linux.dev>
References: <20260830073242.148092-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call bpf_snprintf_btf() with the type_id of a "const void" from the
vmlinux BTF and check the rendered output is the "<unsupported kind:0>"
placeholder. On an unfixed kernel this used to NULL-deref in
btf_modifier_show(), so the test doubles as a reproducer: it oopses the
task (and panics it under panic_on_oops).

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/btf_show_void.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/btf_show_void.c       | 22 +++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_show_void.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf_show_void.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_show_void.c b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
new file mode 100644
index 000000000000..546833199195
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_show_void.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_show_void.skel.h"
+
+/*
+ * bpf_snprintf_btf() with the type_id of a "const void" (a modifier that
+ * resolves to void, present in the vmlinux BTF) used to NULL-deref in
+ * btf_modifier_show(). A fixed kernel prints the "<unsupported kind:0>"
+ * placeholder; on an unfixed kernel this oopses the task (and panics it under
+ * panic_on_oops), so it doubles as a reproducer.
+ */
+void test_btf_show_void(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	const struct btf_type *t;
+	struct btf_show_void *skel;
+	int i, n, cv = 0, err;
+	char ctx[16] = {};
+	struct btf *btf;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf__parse vmlinux"))
+		return;
+
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
+		t = btf__type_by_id(btf, i);
+		if (btf_kind(t) == BTF_KIND_CONST && t->type == 0) {
+			cv = i;
+			break;
+		}
+	}
+	if (!ASSERT_GT(cv, 0, "find const void in vmlinux BTF"))
+		goto out_btf;
+
+	skel = btf_show_void__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto out_btf;
+	skel->rodata->const_void_id = cv;
+	if (!ASSERT_OK(btf_show_void__load(skel), "skel_load"))
+		goto out_skel;
+
+	topts.ctx_in = ctx;
+	topts.ctx_size_in = sizeof(ctx);
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.dump_const_void),
+				     &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto out_skel;
+
+	ASSERT_EQ(skel->bss->ret, sizeof("<unsupported kind:0>") - 1, "ret");
+	ASSERT_STREQ(skel->bss->out, "<unsupported kind:0>", "placeholder");
+out_skel:
+	btf_show_void__destroy(skel);
+out_btf:
+	btf__free(btf);
+}
diff --git a/tools/testing/selftests/bpf/progs/btf_show_void.c b/tools/testing/selftests/bpf/progs/btf_show_void.c
new file mode 100644
index 000000000000..9fabd7372f89
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_show_void.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "btf_ptr.h"
+#include <bpf/bpf_helpers.h>
+
+const volatile __u32 const_void_id;
+char out[64];
+long ret;
+
+SEC("raw_tp/sys_enter")
+int dump_const_void(void *ctx)
+{
+	struct btf_ptr ptr = {
+		.ptr = ctx,
+		.type_id = const_void_id,
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

