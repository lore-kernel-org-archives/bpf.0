Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138234756B6
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259906; cv=none; b=rKBPyY+pNiF/JU59FpqcodurVLGu6BzQFxTzNrW4Q+iV5tX7Kr3QiXpam/JmhLPPFdZ6CO0m+XrtO+I4ClASD8fqqGcuZIoN54/qaR2sTbrtjpsrG17P3BZZCkCoyKXAl3Po2HrUsbr5TAdXO9ZSH3BsX88wQ2ZZFQohqDGhoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259906; c=relaxed/simple;
	bh=mxQjvG+VqIP1YaBTpqWzujFAX1hh8VeTZFGeGZcTtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmoAPGT3UGp3GXHA+7rsurY183LUx2bL1v9EZHZ/xY04WlcS5WEWVwTC3ZlkqeOC9SSRSEpbig1Qh0TVFsIT1qaVixS6G1XfP2gAm6puM4IyRNZ+/g0d0OLLcFLL/O4dL6N3uy5Pk0cb2LQ5Pdtt3H35L72zbdyQwrCmt2v66Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xrYzOQ0W; arc=none smtp.client-ip=91.218.175.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xrYzOQ0W"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mxQjvG+VqIP1YaBTpqWzujFAX1hh8VeTZFGeGZcTtBk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788259899; v=1; x=1788864699;
 b=xrYzOQ0WTc+1CmkxFa7e7NFWzqjrumzovvNob7xY4gUWFUOU73MePOkMzbq5v++VF8E5JKN+
 cZ5sWO5cP/HuKOOCbLCK8pNmccq1bRKgegFJo2aqfWplFDOifs3+KPVu2ZC2XqogPKyH8qWzyKa
 StipbekJDXzG8HStm1l3sIu0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 91a937191a82c02f;
	Tue, 01 Sep 2026 10:51:39 +0000
X-Mizu-Trace-ID: 91a937191a82c02f
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
Subject: [PATCH bpf v4 4/5] selftests/bpf: Add test for key-less BTF hash map
Date: Tue,  1 Sep 2026 18:47:38 +0800
Message-ID: <20260901104924.346187-5-jiayuan.chen@linux.dev>
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

Create a hash and an rhash map with btf_key_type_id == 0 and expect
bpf_map_create() to fail with -EINVAL; a positive control with a real
key type confirms the rejection is about the key-less BTF and not some
unrelated failure.

Such a map used to be accepted and then NULL-deref in btf_type_show()
when dumped through bpffs.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
re bot+bpf-ci: the positive control is on purpose. Without it, if the map
type is missing both creates return -EINVAL and the key-less check would
pass for the wrong reason.
---
 .../bpf/prog_tests/btf_map_keyless.c          | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
new file mode 100644
index 000000000000..3248bccc3557
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+/*
+ * A hash map with a key-less BTF (btf_key_type_id == 0) used to be accepted
+ * and then NULL-deref in btf_type_show() when dumped through bpffs. A fixed
+ * kernel rejects it at creation; verify that rejection, with a keyed positive
+ * control so the -EINVAL is about the missing key type and not some unrelated
+ * failure.
+ */
+static void check_keyless(int map_type, __u32 map_flags, int btf_fd, int val_id)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int map_fd;
+
+	opts.map_flags = map_flags;
+	opts.btf_fd = btf_fd;
+	opts.btf_value_type_id = val_id;
+
+	/* Positive control: the same map with a real key type is accepted. */
+	opts.btf_key_type_id = val_id;
+	map_fd = bpf_map_create(map_type, "keyed_map", 4, 4, 8, &opts);
+	if (!ASSERT_GE(map_fd, 0, "keyed create is accepted"))
+		return;
+	close(map_fd);
+
+	/* A key-less BTF must be rejected. */
+	opts.btf_key_type_id = 0;
+	map_fd = bpf_map_create(map_type, "keyless_map", 4, 4, 8, &opts);
+	ASSERT_EQ(map_fd, -EINVAL, "key-less create is rejected");
+	if (map_fd >= 0)
+		close(map_fd);
+}
+
+void test_btf_map_keyless(void)
+{
+	int btf_fd, val_id;
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new_empty"))
+		return;
+
+	val_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(val_id, 0, "btf__add_int"))
+		goto out;
+
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf__load_into_kernel"))
+		goto out;
+	btf_fd = btf__fd(btf);
+
+	if (test__start_subtest("hash"))
+		check_keyless(BPF_MAP_TYPE_HASH, 0, btf_fd, val_id);
+	if (test__start_subtest("rhash"))
+		check_keyless(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC, btf_fd, val_id);
+out:
+	btf__free(btf);
+}
-- 
2.43.0

