Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E72E7373
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788075263; cv=none; b=uMbevkpoOF6DpkHovLPDUdENy3norR7Aynt9wa8YOCneZJP0FKxn9I/rTJxTiCIm2o1PDDHYX8FIGxXYLVgzoCnTAanpo8Uatq9nGRIwg4lJpIOhH6RTwQ8Zo4R0cHacS7ahR7sJpM0JnnQ9BySwd3y58r8csSWtBXbXbrCnGps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788075263; c=relaxed/simple;
	bh=75UGVSqZiItz8E1acm475ZCn05iHcNlau/5M8Mc9FGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkHnob8L6Pz1+5RRYFu1eTUVOxRF6YtIqQf43FUYmqGdSGN4ZmNFqvVoTKgJAUH5OzOW7OgbJNi2Hggy9xXv7BlP6dthWto1gJTf76e8mWwQ3UKzLdteTeJ4DLMWmUV1NDovwbM95CcMLG5zQA4cGdrIta1lIIYNn7aFNCP6+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DV/YVn0P; arc=none smtp.client-ip=91.218.175.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DV/YVn0P"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=75UGVSqZiItz8E1acm475ZCn05iHcNlau/5M8Mc9FGc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788075259; v=1; x=1788680059;
 b=DV/YVn0PSEj5+XxUEX7Ja9N1RVRxUVkT910ujf0ssk14mP/ZnkBvGDJHfx9S52qTbGU8Twge
 jy+LE7gUt/vh8s8s+3RLnkQy9GA11kEHhFGft4/5Vyl7CiAGE5EScKRIfQ+nAe6fL+9L1Seh+qm
 egqMSHPRZVJt0yJRx9kRUzp4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d6e9dbc4dc8d805;
	Sun, 30 Aug 2026 07:34:19 +0000
X-Mizu-Trace-ID: 5d6e9dbc4dc8d805
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
Subject: [PATCH bpf v2 3/4] selftests/bpf: Add test for key-less BTF hash map
Date: Sun, 30 Aug 2026 15:30:58 +0800
Message-ID: <20260830073242.148092-4-jiayuan.chen@linux.dev>
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

Create a hash and an rhash map with btf_key_type_id == 0 and expect
bpf_map_create() to fail with -EINVAL; a positive control with a real
key type confirms the rejection is about the key-less BTF. On an unfixed
kernel the map is created, and the test pins and reads it back to walk
the bpffs dump path, which reproduces the btf_type_show() NULL-deref - so
running it on an unfixed kernel oopses the reading task (and panics it
under panic_on_oops).

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/btf_map_keyless.c          | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
new file mode 100644
index 000000000000..43f0bb9bd578
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
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

