Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AB385529
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909543; cv=none; b=BJFUYSdbsMaTggJU5tqvoend0AjbqddzF2O5b9m6dRcG5velrkqsPOnY2I5vkzm8C1TPnf5YNbj3qfbVHebWELBxJqtDyi2iVm8gK1GwGi0Ks7itiymfoxPBObza06hgTj3dSY5XxnHt1r6rXgOgTieZBtKdkeLzRbBl1JYyQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909543; c=relaxed/simple;
	bh=T0lJa3Sd/SF0htQv5esbW6YGafFn07r4l5BN6FchVHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXbSkZyC8jI8bu0yZPpVeCNcS4DOsfnh/mhv/AecG3K/7m0CDVTk5OHG6oLkNQdQxL6O/f2DFlwq6vLjl4YI9JP4Z25HiqapZIQtHzfJaLyiOpQEYnNoQjNOPu5Te8kkRxJ8BykakOIbj7Vlid4B8yRC2uFyrsPIJWgn4V77Kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hy/ScQep; arc=none smtp.client-ip=95.215.58.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hy/ScQep"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T0lJa3Sd/SF0htQv5esbW6YGafFn07r4l5BN6FchVHA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787909536; v=1; x=1788514336;
 b=hy/ScQepxDCN4/kYIXiYGFkcdOXtuoTtjIKT9AjhT7pqtUbZZwU3+DMhXRcQZs9C7qZA6/3w
 40pfilUc2tZfFalR7kW4NHqLv1Iz1nAysLCRV/Y0u8etQF5KFYHaVjxeTqRMEO0nsZdNps9wnHW
 azlty3qw1n+TO8mAM6pP9K84=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83fe4d1dd621201e;
	Fri, 28 Aug 2026 09:32:16 +0000
X-Mizu-Trace-ID: 83fe4d1dd621201e
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for key-less BTF hash map
Date: Fri, 28 Aug 2026 17:31:17 +0800
Message-ID: <20260828093142.179856-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828093142.179856-1-jiayuan.chen@linux.dev>
References: <20260828093142.179856-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a hash and an rhash map with btf_key_type_id == 0 and expect
bpf_map_create() to fail with -EINVAL. On an unfixed kernel the map is
created; the test then pins and reads it back to walk the bpffs dump path,
which reproduces the btf_type_show() NULL-deref - so running this test on
an unfixed kernel panics it.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/btf_map_keyless.c          | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
new file mode 100644
index 000000000000..6e1496cbd8bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+/*
+ * A key-less BTF (btf_key_type_id == 0) is only meant for array maps. A hash
+ * map with one used to NULL-deref in btf_type_show() when dumped via bpffs.
+ * A fixed kernel rejects such a map at creation; on an unfixed kernel the
+ * pin-and-read below deliberately walks that bpffs dump path, so running this
+ * test on an unfixed kernel panics it.
+ */
+static void check_keyless(int map_type, __u32 map_flags, int btf_fd, int val_id)
+{
+	const char *path = "/sys/fs/bpf/keyless_map";
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	__u32 key = 1, val = 0x41424344;
+	char buf[256];
+	int map_fd;
+	FILE *f;
+
+	opts.map_flags = map_flags;
+	opts.btf_fd = btf_fd;
+	opts.btf_key_type_id = 0;
+	opts.btf_value_type_id = val_id;
+	map_fd = bpf_map_create(map_type, "keyless_map", 4, 4, 8, &opts);
+
+	if (map_fd >= 0) {
+		/* Unfixed kernel: reproduce the oops via the bpffs dump path. */
+		(void)bpf_map_update_elem(map_fd, &key, &val, 0);
+		if (bpf_obj_pin(map_fd, path) == 0) {
+			f = fopen(path, "r");
+			if (f) {
+				while (fgets(buf, sizeof(buf), f))
+					;
+				fclose(f);
+			}
+			unlink(path);
+		}
+		close(map_fd);
+	}
+
+	ASSERT_EQ(map_fd, -EINVAL, "key-less create is rejected");
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

