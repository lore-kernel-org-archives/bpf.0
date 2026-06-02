Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4E3AFAEA;
	Tue,  2 Jun 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385754; cv=none; b=QlwG34Yk0zZDigqW6NZPMKv8WsxSHIKaa12c5E1y/MOLrdKVCWij2/bfQ43gt+9Y7wQyMGOo7ySYTkenTI7/ZEJUqPWOnipV58a6rMFU1REaGQVIA/FknLzM9VmXTzNNxsPKT9bLe984d5eEZOLEWlJnFLPeUSmzRTBTlUtG08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385754; c=relaxed/simple;
	bh=t7T33buFJMTAh2cAdsVW3rHGqlJvG9uco8gKZsPF61A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhdXat/4BA0eKQQCiM9qQbeEm9V9kahohrSflmDM4Lgs6+pEcj23ueTDqR+RWFoRooKZJ8LQuWIrlNpR76iJVvM7wexDRi9fan5NokYMt1XInxommF8q7nk8ffjbhRRvb0gpT7r2FGFNAqVavrWg6mnC8KRRVqv2o1r2kVFyvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OFgVet1A; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OFgVet1A"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8TvYpMVKoYuIv5WGmMhwH/nmmSXsKr2Cr/inCUFBoZA=;
	b=OFgVet1AG10B4WUWcYc+GNCy7/sgayE+H1ImmCkU/XPplQQ5GE0LFxIVHsRdljYD69Ngo5LrS
	/sdZIKSfNAL1SUGN7AfFXn0wBTmO59rk4/MRqg8k7cmgr4dxd4kW5nw2GzqWMBAmpb3nCjFITMn
	H9KZp5MrdDs7oJLSUBDHBj4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gV2Tz0SHVz1T4Jf;
	Tue,  2 Jun 2026 15:27:35 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id 983F540537;
	Tue,  2 Jun 2026 15:35:44 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jun
 2026 15:35:43 +0800
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
Subject: [PATCH v2 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
Date: Tue, 2 Jun 2026 15:35:39 +0800
Message-ID: <20260602073539.1567846-2-malin89@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602073539.1567846-1-malin89@huawei.com>
References: <20260602073539.1567846-1-malin89@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200017.china.huawei.com (7.202.195.7)

Add tail-call selftests for prog-array ownership when cgroup storage is
in use. Verify that loading succeeds when callers and callees reuse the
owner's cgroup storage map, and that loading fails for a different
storage map or for a storage-less bridge program.

Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 103 ++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         |  44 ++++++++
 .../progs/tailcall_cgrp_storage_no_storage.c  |  20 ++++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   |  32 ++++++
 4 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7d534fde0af9..c1403ab20eae 100644
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
@@ -1654,6 +1657,100 @@ static void test_tailcall_failure()
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
 noinline void uprobe_sleepable_trigger(void)
 {
 	asm volatile ("");
@@ -1777,6 +1874,12 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
+		test_tailcall_cgrp_storage_diff_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
+		test_tailcall_cgrp_storage_no_storage();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
 	if (test__start_subtest("tailcall_sleepable"))
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
