Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D93B14B8
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174324; cv=none; b=iKG7QzJ5Dg5aluZPjtDucj9vubPVDlA9LZ8X98/Oj7cc3L8bxGFhEY8nGEBStgV3lds5NGQhz0ZkIke4UPuTHyY/1OXTdMjNAZHIQTTObEW16fQSIxPa/F7vlGh11GEOhhhvnRU9dATFXO7BzUqUSD8lNjoo8AB08tr9cDWhQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174324; c=relaxed/simple;
	bh=8WHtN6ourocR0E48NCxNPrEIJOFHpFqlFquB2qhCgpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzqn1YMpqghnvPBWVT+XcvOq62zZnK0O3U2be28arLjvrSemaLsVnHQlb+ta7tHhrJfFdMVaCZGFvm2NX8Vz59YBlLIALpYMmezKxWc/2IpB7fjfTNu+uEkavcWx1lRrm5vqQPGrZlFxGg3a7siX64c5jGRxr5nJAsRqcmSTFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mRV5w/Sq; arc=none smtp.client-ip=95.215.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mRV5w/Sq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8WHtN6ourocR0E48NCxNPrEIJOFHpFqlFquB2qhCgpA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788174320; v=1; x=1788779120;
 b=mRV5w/SqUAWJ2quLPiAcMmP0XSiUMu7x1cbKU0KXKv9Y+XF6CC9QLaAhJRNAz4+7zK0pYBZY
 7x0dOeXYA0OC9r2bpSstmlrZXREGT7xnPSGMVzF7ZfkVH/jIic3yqv7ZomWKQqo1FxFtBLuaOce
 euavRX1TxVLFwXYLfs16CAH8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 97a19a524f8c428b;
	Mon, 31 Aug 2026 11:05:20 +0000
X-Mizu-Trace-ID: 97a19a524f8c428b
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
Subject: [PATCH bpf v3 4/5] selftests/bpf: Add test for key-less BTF hash map
Date: Mon, 31 Aug 2026 19:01:09 +0800
Message-ID: <20260831110314.150870-5-jiayuan.chen@linux.dev>
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

Create a hash and an rhash map with btf_key_type_id == 0 and expect
bpf_map_create() to fail with -EINVAL; a positive control with a real
key type confirms the rejection is about the key-less BTF. On an unfixed
kernel the map is created, and the test pins and reads it back to walk
the bpffs dump path, which reproduces the btf_type_show() NULL-deref - so
running it on an unfixed kernel oopses the reading task (and panics it
under panic_on_oops).

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/btf_map_keyless.c          | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
new file mode 100644
index 000000000000..a7d037f57a7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+/*
+ * A hash map with a key-less BTF (btf_key_type_id == 0) used to NULL-deref in
+ * btf_type_show() when dumped via bpffs.
+ * A fixed kernel rejects such a map at creation; on an unfixed kernel the
+ * pin-and-read below deliberately walks that bpffs dump path, so it doubles
+ * as a reproducer: it oopses an unfixed kernel (and panics it under
+ * panic_on_oops).
+ */
+static void check_keyless(int map_type, __u32 map_flags, int btf_fd, int val_id)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const char *path = "/sys/fs/bpf/keyless_map";
+	__u32 key = 1, val = 0x41424344;
+	char buf[256];
+	int map_fd;
+	FILE *f;
+
+	opts.map_flags = map_flags;
+	opts.btf_fd = btf_fd;
+	opts.btf_value_type_id = val_id;
+
+	/*
+	 * Positive control: the same map with a real key type must be accepted,
+	 * so the -EINVAL below is about the key-less BTF and not some unrelated
+	 * rejection (e.g. an unknown map type).
+	 */
+	opts.btf_key_type_id = val_id;
+	map_fd = bpf_map_create(map_type, "keyed_map", 4, 4, 8, &opts);
+	if (!ASSERT_GE(map_fd, 0, "keyed create is accepted"))
+		return;
+	close(map_fd);
+
+	/* A key-less BTF must be rejected. */
+	opts.btf_key_type_id = 0;
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

