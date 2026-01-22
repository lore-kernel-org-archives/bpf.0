Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468F392B9B
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095926; cv=none; b=dQy8wRM+JVPnfzmSTdbMRgVIy0tOeiQKYIUiTB0vZ9GdRfj+oUSTk8RNA1e7hn5RJhbzdasMLaBtlHM3Q9qEGIZFTKXTQ79U+gqlSVwXqXS+QK9p+WYNH0dpjTUJEpUXdYt2kQh1TInKPalaWTieO0vx0sVB+MPVuzhMWUU+5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095926; c=relaxed/simple;
	bh=VeK4ExRXCh+3B3ipuqifOQCvQneCr/2OWhViUuULlKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUZYTc/R22NU+1Fp9fS6QK8wApVv9ekP1zBVMyKyXPhJ8F9sbvBtxlhKJMKnc5KKZkVkTgNMk2fpXO2bGoLu/860KWkJdEhp5vQ+IWtiwZMlADZROxmWNafPnP422nwvtx/cP4T2aLLXMdrGwsWmnKdvwOhmoBDbcYxKbsdceJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPqhVPhE; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPqhVPhE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769095920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGFs8iwFD+3Bos+er5vmVWRRN6I8GRLoMxxtNzEogAM=;
	b=oPqhVPhE1x8MpJ7DZ1cDXjUiTdGXJjgJ3QdDVSv006/7Fl1gElm1qmwheaj8IKTH/pKp6H
	OoIZV3vE0sKfhn/2RU+t4a0qpmAtdvcu5EpfGSYITqKv+1ysXua4uAxVY12QT0eSRWEOOV
	DaS9+0RlDFYSXqteD3PpkwCsN3zsStc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests to verify BPF_F_LOCK restrictions
Date: Thu, 22 Jan 2026 23:31:20 +0800
Message-ID: <20260122153120.69249-3-leon.hwang@linux.dev>
In-Reply-To: <20260122153120.69249-1-leon.hwang@linux.dev>
References: <20260122153120.69249-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a tc-based helper program that updates a map value containing both
bpf_spin_lock and bpf_timer and records errors for invalid flag
combinations.

Extend the existing map_lock tests to cover array and hash maps. Verify
that BPF_NOEXIST|BPF_EXIST is rejected with -EINVAL/-EEXIST, and that
BPF_F_LOCK returns -EOPNOTSUPP when mixed with other special fields.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/map_lock.c       | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_map_lock.c       | 31 +++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/testing/selftests/bpf/prog_tests/map_lock.c
index 1d6726f01dd2..aafae8d02e1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include "test_map_lock.skel.h"
 
 static void *spin_lock_thread(void *arg)
 {
@@ -90,3 +91,72 @@ void test_map_lock(void)
 close_prog:
 	bpf_object__close(obj);
 }
+
+struct map_value {
+	struct bpf_spin_lock lock;
+	struct bpf_timer timer;
+	__u64 payload;
+};
+
+static void test_map_lock_update_elem(enum bpf_map_type map_type, int err_exist)
+{
+	struct map_value val = {};
+	struct test_map_lock *skel;
+	int prog_fd, err;
+	u32 key = 0;
+	char buff[128] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	skel = test_map_lock__open();
+	if (!ASSERT_OK_PTR(skel, "test_map_lock__open"))
+		return;
+
+	bpf_map__set_type(skel->maps.map, map_type);
+
+	err = test_map_lock__load(skel);
+	if (!ASSERT_OK(err, "test_map_lock__load"))
+		goto out;
+
+	err = bpf_map__update_elem(skel->maps.map, &key, sizeof(key), &val, sizeof(val),
+				   BPF_NOEXIST | BPF_EXIST);
+	if (!ASSERT_EQ(err, -EINVAL, "err_exist"))
+		goto out;
+
+	err = bpf_map__update_elem(skel->maps.map, &key, sizeof(key), &val, sizeof(val),
+				   BPF_F_LOCK);
+	if (!ASSERT_EQ(err, -EOPNOTSUPP, "err_lock"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.map_update);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->err_exist, err_exist, "err_exist");
+	ASSERT_EQ(skel->bss->err_lock, -EOPNOTSUPP, "err_lock");
+
+out:
+	test_map_lock__destroy(skel);
+}
+
+static void test_array_map_lock_update_elem(void)
+{
+	test_map_lock_update_elem(BPF_MAP_TYPE_ARRAY, -EEXIST);
+}
+
+static void test_hash_map_lock_update_elem(void)
+{
+	test_map_lock_update_elem(BPF_MAP_TYPE_HASH, -EINVAL);
+}
+
+void test_map_lock_flag(void)
+{
+	if (test__start_subtest("array_map"))
+		test_array_map_lock_update_elem();
+	if (test__start_subtest("hash_map"))
+		test_hash_map_lock_update_elem();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_lock.c b/tools/testing/selftests/bpf/progs/test_map_lock.c
index 1c02511b73cd..f1b7b741795c 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lock.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
@@ -59,4 +59,33 @@ int bpf_map_lock_test(struct __sk_buff *skb)
 err:
 	return err;
 }
+
+int err_exist;
+int err_lock;
+
+struct map_value {
+	struct bpf_spin_lock lock;
+	struct bpf_timer timer;
+	__u64 payload;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} map SEC(".maps");
+
+SEC("tc")
+int map_update(struct __sk_buff *skb)
+{
+	struct map_value val = {};
+	u32 key = 0;
+
+	val.payload = 0xDEADBEEF;
+	err_exist = bpf_map_update_elem(&map, &key, &val, BPF_NOEXIST | BPF_EXIST);
+	err_lock = bpf_map_update_elem(&map, &key, &val, BPF_F_LOCK);
+	return BPF_OK;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

