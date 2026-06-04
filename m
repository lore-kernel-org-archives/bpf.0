Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB823EAB4;
	Thu,  4 Jun 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556610; cv=none; b=Q7f38DTpHoliKFJz3uk2fTxQrtRk0q9sWta5qSXynHmMjc8zSuYKGV9YArRxFos7A/JEK+6Y7+X5ZLwtGuorZXvnHTlCTYMzv6r2ooemdsPMLzhu/nceKvWRZC+j7MZxAU5+q4r/TxwVpkuu/4TB+RIhvqLO1cKOIfyCGGtcuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556610; c=relaxed/simple;
	bh=NWM6UwBE/krwdyZt25WWgGj8vdUlYf6tA3tHl7OMXIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAu9jbE8bJPOR66xP+/x3Z1Jcx0YU1LgOUGdyXTa2QSqaQ8WCnbqyndSjDV2CbDQOCQHVZGu0wZrQTcvrde40CAYiRmgj9nCnLq6vIgp5wccjcxc/HaYl2xN18MUrDzieQEGyfNiGOaT9UtjFog1dXmImblMZOj+OOf9dvwxpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PGzPWgrs; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PGzPWgrs"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7A88tY0iiWonzbMr9q4Y20ALoORxtq0siTcZ67RbMAo=;
	b=PGzPWgrsoavS9ZrZXUqgsMoyMiu0oKL8D7BTtbeZl4LV0alD0oa2bTgA6wv1ZF3o8hYNMLHxY
	MUhIkPTGoV8wCEk+HRWnwbvhsreuIzzpnjPBUt2Y3gAvtgX2GvCS1B7bnyFABiomGntInmr5soS
	iTjR5E6tmHpkXbwwHagHGAo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gWFh06SKrz12LF9;
	Thu,  4 Jun 2026 14:55:28 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id 19AAA40537;
	Thu,  4 Jun 2026 15:03:24 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 15:03:23 +0800
From: Lin Ma <malin89@huawei.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Amery Hung <ameryhung@gmail.com>, Lin Ma
	<malin89@huawei.com>, Rongzhen Cui <cuirongzhen@huawei.com>, Jingguo Tan
	<tanjingguo@huawei.com>, <cenxianlong@huawei.com>, <chenzhe@huawei.com>
Subject: [PATCH v4 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
Date: Thu, 4 Jun 2026 15:03:18 +0800
Message-ID: <20260604070318.2869813-2-malin89@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604070318.2869813-1-malin89@huawei.com>
References: <20260604070318.2869813-1-malin89@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200017.china.huawei.com (7.202.195.7)

Add tail-call selftests for prog-array ownership when cgroup storage is
in use. Verify that loading succeeds when callers and callees reuse the
owner's cgroup storage map, and that loading fails for a different
storage map and for the A(storage) -> B(no storage) -> C(storage)
bridge case from patch 1.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---
v2: https://lore.kernel.org/bpf/31927f33-9db0-4a39-b38a-72b33487979e@linux.dev/T/#t
v2 -> v3:
 - add explicit A(storage) -> B(no storage) -> C(storage) bridge
   coverage
v3: https://lore.kernel.org/bpf/7b3e1adae5c92153e991ac406b2d334609c36d866b5bf81e4465cf63bde0a79c@mail.kernel.org/T/#t
v3 -> v4:
 - move the new tail-call cgroup storage subtests to the tail of
   test_tailcalls()
 - add Leon Hwang's Suggested-by tag
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 159 ++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         |  44 +++++
 .../progs/tailcall_cgrp_storage_no_storage.c  |  20 +++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   |  32 ++++
 4 files changed, 255 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7d534fde0af9..e2b2e0e0b1ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,9 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_cgrp_storage_no_storage.skel.h"
+#include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
@@ -1654,6 +1657,154 @@ static void test_tailcall_failure()
 	RUN_TESTS(tailcall_fail);
 }
 
+static void test_tailcall_cgrp_storage(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel = NULL;
+	struct tailcall_cgrp_storage *skel = NULL;
+	int err, key = 0, prog_array_fd, prog_fd, storage_map_fd;
+
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "owner_open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open"))
+		goto out;
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	if (!ASSERT_OK(err, "reuse_prog_array"))
+		goto out;
+
+	err = bpf_map__reuse_fd(skel->maps.storage_map, storage_map_fd);
+	if (!ASSERT_OK(err, "reuse_storage_map"))
+		goto out;
+
+	err = bpf_object__load(skel->obj);
+	if (!ASSERT_OK(err, "tailcall_cgrp_storage__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.callee_prog);
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_OK(err, "update_prog_array");
+
+out:
+	tailcall_cgrp_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+static void test_tailcall_cgrp_storage_diff_storage(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel = NULL;
+	struct tailcall_cgrp_storage *skel = NULL;
+	int err, prog_array_fd;
+
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "owner_open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open"))
+		goto out;
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	if (!ASSERT_OK(err, "reuse_prog_array"))
+		goto out;
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_ERR(err, "tailcall_cgrp_storage__load");
+
+out:
+	tailcall_cgrp_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+static void test_tailcall_cgrp_storage_no_storage(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel = NULL;
+	struct tailcall_cgrp_storage_no_storage *skel = NULL;
+	int err, prog_array_fd;
+
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "owner_open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+
+	skel = tailcall_cgrp_storage_no_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage_no_storage__open"))
+		goto out;
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	if (!ASSERT_OK(err, "reuse_prog_array"))
+		goto out;
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_ERR(err, "tailcall_cgrp_storage_no_storage__load");
+
+out:
+	tailcall_cgrp_storage_no_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+static void test_tailcall_cgrp_storage_no_storage_bridge(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel = NULL;
+	struct tailcall_cgrp_storage_no_storage *bridge_skel = NULL;
+	struct tailcall_cgrp_storage *callee_skel = NULL;
+	int err, key = 0, prog_array_fd, prog_fd, storage_map_fd;
+
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "owner_open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	callee_skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(callee_skel, "tailcall_cgrp_storage__open"))
+		goto out;
+
+	bpf_program__set_autoload(callee_skel->progs.caller_prog, false);
+
+	err = bpf_map__reuse_fd(callee_skel->maps.prog_array, prog_array_fd);
+	if (!ASSERT_OK(err, "reuse_prog_array"))
+		goto out;
+
+	err = bpf_map__reuse_fd(callee_skel->maps.storage_map, storage_map_fd);
+	if (!ASSERT_OK(err, "reuse_storage_map"))
+		goto out;
+
+	err = bpf_object__load(callee_skel->obj);
+	if (!ASSERT_OK(err, "tailcall_cgrp_storage__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(callee_skel->progs.callee_prog);
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update_prog_array"))
+		goto out;
+
+	bridge_skel = tailcall_cgrp_storage_no_storage__open();
+	if (!ASSERT_OK_PTR(bridge_skel, "tailcall_cgrp_storage_no_storage__open"))
+		goto out;
+
+	err = bpf_map__reuse_fd(bridge_skel->maps.prog_array, prog_array_fd);
+	if (!ASSERT_OK(err, "reuse_prog_array"))
+		goto out;
+
+	err = bpf_object__load(bridge_skel->obj);
+	ASSERT_ERR(err, "tailcall_cgrp_storage_no_storage_bridge__load");
+
+out:
+	tailcall_cgrp_storage_no_storage__destroy(bridge_skel);
+	tailcall_cgrp_storage__destroy(callee_skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
 noinline void uprobe_sleepable_trigger(void)
 {
 	asm volatile ("");
@@ -1781,4 +1932,12 @@ void test_tailcalls(void)
 		test_tailcall_failure();
 	if (test__start_subtest("tailcall_sleepable"))
 		test_tailcall_sleepable();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
+		test_tailcall_cgrp_storage_diff_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
+		test_tailcall_cgrp_storage_no_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
+		test_tailcall_cgrp_storage_no_storage_bridge();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
new file mode 100644
index 000000000000..4dd3a0033d75
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+	return 1;
+}
+
+SEC("cgroup_skb/egress")
+int callee_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
new file mode 100644
index 000000000000..f95166dad7c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &prog_array, 0);
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
new file mode 100644
index 000000000000..d7e8ec9855c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int prog_array_owner(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0
