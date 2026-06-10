Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F773F9F21
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088960; cv=none; b=R1pN3UcCmw7DcukdcdSCtI6fillwvrGAhlPnzMowVpWrQoBMTwT97ZUquTSPKNbwKNjN++wQPLHRfqPRiEDzBoerok/9WK3RL7JDVZ8Hgy/q9nPhMgYomsFDl1l88YeHnDH3mPnTWHJyanYa8w5h5gWGwpkLXOjaRTFLicLyQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088960; c=relaxed/simple;
	bh=/sx+059AWWij7Gbq4aRsCcaLfgKnO0ctrsfwgIUNUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE8fOJmQb5gicj2Vdf+30BzIGIE62J/CzxyJ86QwpYojlJZnxjVIn6n2Z9Ku4kuuOCpsA7xjZTSbU9QLUZZGqZf3HwpK+JuUrJvZZbQs64h712VZFFBfUykiVMYL+eLDALR/ed98fFbygFp2M4DiP12j0Z3SYigIUv/MFtt2toE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=gs50FyN7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="gs50FyN7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fCkzIdWfRWlqhPIFfMwBCARmxvp3aJu7O3kec/+J0E8=; b=gs50FyN76/jGfbiKXwc/0p/oD/
	9iCcNC7w7jT2WkO/srJOovSWnKqrOKfkngyuB4K7k8J4rfo8QoCuBOVon/c09aZzcWXP8PVOddbJk
	65+STvaLBUWW33iiugMcB9RliC//nOUjdy0T1Swxmx+vK8+YcBV5E1mzsTMgQdxOzxsD4kINrKUW9
	UDFL4jiJ5WvpPHMvgMLX8QzedG6PVUEd3jVzHGWErUY9AgXD4xo//iZWNUt/5jlZiZCeFFVxiPlrL
	AJ4ou/BgyAD09WRTsTbJRbA8cWFFfYXIJYIzNdqwJcQhw9nR3+8eYtFUPoTvO/05fSLGFd8KZmu5H
	dZmPasIg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXGay-000Ak4-2q;
	Wed, 10 Jun 2026 12:55:40 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: yonghong.song@linux.dev,
	malin89@huawei.com,
	ast@kernel.org,
	Rongzhen Cui <cuirongzhen@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover tail-call cgroup storage prog-array checks
Date: Wed, 10 Jun 2026 12:55:39 +0200
Message-ID: <20260610105539.705887-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610105539.705887-1-daniel@iogearbox.net>
References: <20260610105539.705887-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)

From: Lin Ma <malin89@huawei.com>

Add tail-call selftests for prog-array ownership when cgroup storage
is in use. Verify that loading succeeds when callers and callees reuse
the owner's cgroup storage map, and that loading fails for a different
storage map and for the A(storage) -> B(no storage) -> C(storage)
bridge case addressed in the previous commit.

Also verify that a storage-less leaf program which cannot perform tail
calls itself is still allowed to join a storage-owned prog array, while
a storage-less tail-caller is rejected also at map update time.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t tailcalls
  [...]
  #475/25  tailcalls/tailcall_freplace:OK
  #475/26  tailcalls/tailcall_bpf2bpf_freplace:OK
  #475/27  tailcalls/tailcall_failure:OK
  #475/28  tailcalls/reject_tail_call_spin_lock:OK
  #475/29  tailcalls/reject_tail_call_rcu_lock:OK
  #475/30  tailcalls/reject_tail_call_preempt_lock:OK
  #475/31  tailcalls/reject_tail_call_ref:OK
  #475/32  tailcalls/tailcall_sleepable:OK
  #475/33  tailcalls/tailcall_cgrp_storage:OK
  #475/34  tailcalls/tailcall_cgrp_storage_diff_storage:OK
  #475/35  tailcalls/tailcall_cgrp_storage_no_storage:OK
  #475/36  tailcalls/tailcall_cgrp_storage_no_storage_leaf:OK
  #475/37  tailcalls/tailcall_cgrp_storage_no_storage_bridge:OK
  #475     tailcalls:OK
  Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 186 ++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         |  44 +++++
 .../progs/tailcall_cgrp_storage_no_storage.c  |  26 +++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   |  32 +++
 4 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7d534fde0af9..a5a226d0104c 100644
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
@@ -1654,6 +1657,179 @@ static void test_tailcall_failure()
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
+out:
+	tailcall_cgrp_storage_no_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+static void test_tailcall_cgrp_storage_no_storage_leaf(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel = NULL;
+	struct tailcall_cgrp_storage_no_storage *skel = NULL;
+	int err, key = 0, prog_array_fd, prog_fd;
+
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "owner_open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+
+	skel = tailcall_cgrp_storage_no_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage_no_storage__open_and_load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.leaf_prog);
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update_prog_array_leaf"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.caller_prog);
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "update_prog_array_bridge");
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
+out:
+	tailcall_cgrp_storage_no_storage__destroy(bridge_skel);
+	tailcall_cgrp_storage__destroy(callee_skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
 noinline void uprobe_sleepable_trigger(void)
 {
 	asm volatile ("");
@@ -1781,4 +1957,14 @@ void test_tailcalls(void)
 		test_tailcall_failure();
 	if (test__start_subtest("tailcall_sleepable"))
 		test_tailcall_sleepable();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
+		test_tailcall_cgrp_storage_diff_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
+		test_tailcall_cgrp_storage_no_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage_leaf"))
+		test_tailcall_cgrp_storage_no_storage_leaf();
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
index 000000000000..5c69b0af6ff9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
@@ -0,0 +1,26 @@
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
+SEC("cgroup_skb/egress")
+int leaf_prog(struct __sk_buff *skb)
+{
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
2.43.0

