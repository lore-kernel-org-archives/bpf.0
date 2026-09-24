Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C445D5C2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267353; cv=none; b=rb4w3zNnW+U1dlZbXmA/PhW7xcWKRoPzkQUQrI6TxmpWWMeh6o7vY2h+6UnhkiJ4ZXvorI4G2biPeFTOhiTNcsTLywkPB9vu0880SqVuGDJW1gkfb2zcHrBhxos4Xhtr0i7Hc3yOOpn51AXnP3JCalUKfMRrZ1hgTSO7uO0wEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267353; c=relaxed/simple;
	bh=FnPznJwKOgqoaoWWh+PudvnETplDvzf+D3uz5b1tWwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDrAMPzOOo4H5RTKRVUeIKIT6kLBJGhv1HR+CtzAwHAOZ8LVRRKouii0zhq4KYNi8KD4pu8Al17qD+jUzuFsY6PIDc1tPf8QAcEgMzg7IPKTm6n5wZ/pmNtvSCa/Pr8akDC3s7SJlUvQ1qxMdYOso7kUQ8c6Qz4cVrkjdCMwcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Axjnj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Axjnj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297231F000FF;
	Thu, 24 Sep 2026 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267351;
	bh=sq6uFpmY4flZkumzVCf8Sto3GYK1M1p5kPRppolF3gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9Axjnj3HPL3nZ/NYP5Mi9gNSTWJs5LEMiLg7agSIosWkLykAvT1Bq4qaWzP+cMYs
	 JFWFHCzI0DkZnxjx8ZhbJpmtIIOo1neC5HX4awzZE3jRm7FQQQBKyLB42wjhgMUFOc
	 v09ZX3ZeGC+epO9bAEWE73hVllURRtLw4PNWkYW88kV5TP/d3boaxQ2wwYFHejT5j8
	 PK2BBtwKT3CUQOYrWc6cS6adppVHnQWuzXFQWnJBVIGQBuUKO/En2qSZY34WD1cWeF
	 4DjSbx4ego4/SAQVm0OOTBrXT0tJiM45f/I2HWxopjbWmeycMMcElckQdiy727xM+s
	 byLoHDBVUqxiQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add bpf_call_rcu tests for hash and LRU hash maps
Date: Thu, 24 Sep 2026 09:28:57 -0700
Message-ID: <20260924162858.2435106-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162858.2435106-1-puranjay@kernel.org>
References: <20260924162858.2435106-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each of these checks the element a callback was armed on is still the one
it runs on, by the value it sees.

hash_delete arms, deletes, then inserts another key, which would be handed
the freed element straight back off the freelist. hash_np does the same on
a BPF_F_NO_PREALLOC map, which frees to bpf_mem_alloc instead.
hash_replace replaces the key twice, which is how a preallocated map
recycles through its per-CPU spare. reuse arms an element that has already
been deleted and recycled. lru_evict floods a two-entry map and checks the
armed element was not evicted. hash_chain checks a re-arm from the callback
of a deleted element is refused.

stress hammers arm and delete on overlapping keys from several CPUs and
checks every arm ran.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/call_rcu.c       | 254 +++++++++++++++-
 tools/testing/selftests/bpf/progs/call_rcu.c  | 274 ++++++++++++++++++
 2 files changed, 526 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/call_rcu.c b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
index e4d271d43d878..b60220cdf318c 100644
--- a/tools/testing/selftests/bpf/prog_tests/call_rcu.c
+++ b/tools/testing/selftests/bpf/prog_tests/call_rcu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <pthread.h>
 #include "call_rcu.skel.h"
 #include "call_rcu_fail.skel.h"
 
@@ -163,6 +164,158 @@ static void test_call_rcu_teardown(void)
 	call_rcu__destroy(skel);
 }
 
+/*
+ * A hash element armed and then deleted: the element must stay alive until the
+ * callback has run, and the callback must still see its value.
+ */
+static void test_call_rcu_hash_delete(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	int i;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_hash_then_delete),
+					      &opts), "test_run"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 0, "retval") ||
+	    !ASSERT_EQ(skel->bss->arm_err, 0, "arm_err"))
+		goto out;
+
+	kern_sync_rcu();
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->hash_callbacks, __ATOMIC_ACQUIRE) >= 1)
+			break;
+		usleep(10000);
+	}
+
+	ASSERT_EQ(skel->bss->hash_callbacks, 1, "hash_callbacks");
+	ASSERT_EQ(skel->bss->hash_cb_val, 0xbadc0de, "hash_cb_val");
+out:
+	call_rcu__destroy(skel);
+}
+
+/* A hash callback which re-arms, with the element deleted mid-chain. */
+static void test_call_rcu_hash_chain(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	int i;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->hash_chain = 3;
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_hash_then_delete),
+					      &opts), "test_run") ||
+	    !ASSERT_EQ(opts.retval, 0, "retval"))
+		goto out;
+
+	kern_sync_rcu();
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->hash_callbacks, __ATOMIC_ACQUIRE) >= 1)
+			break;
+		usleep(10000);
+	}
+
+	/*
+	 * The delete lands before the first callback, so the chain is cut:
+	 * re-arming a dead head fails and the element is released once.
+	 */
+	ASSERT_EQ(skel->bss->hash_chain_err, -EBUSY, "chain_refused");
+
+	/* A re-arm that slipped through would land within a grace period. */
+	kern_sync_rcu();
+	usleep(100000);
+	ASSERT_EQ(skel->bss->hash_callbacks, 1, "hash_callbacks");
+out:
+	call_rcu__destroy(skel);
+}
+
+/* An LRU element evicted under pressure while its callback is queued. */
+static void test_call_rcu_lru_evict(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	int i;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_lru_then_evict),
+					      &opts), "test_run") ||
+	    !ASSERT_EQ(opts.retval, 0, "retval") ||
+	    !ASSERT_EQ(skel->bss->arm_err, 0, "arm_err"))
+		goto out;
+
+	kern_sync_rcu();
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->lru_callbacks, __ATOMIC_ACQUIRE) >= 1)
+			break;
+		usleep(10000);
+	}
+
+	ASSERT_EQ(skel->bss->lru_still_present, 1, "lru_still_present");
+	ASSERT_EQ(skel->bss->lru_callbacks, 1, "lru_callbacks");
+	ASSERT_EQ(skel->bss->lru_cb_val, 0xfeedface, "lru_cb_val");
+out:
+	call_rcu__destroy(skel);
+}
+
+static void *stress_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int i, err, prog_fd = *(int *)arg;
+
+	for (i = 0; i < 200; i++) {
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+		if (!ASSERT_OK(err, "test_run"))
+			break;
+	}
+
+	return NULL;
+}
+
+/* Concurrent arm and delete on overlapping keys from several CPUs. */
+static void test_call_rcu_stress(void)
+{
+	pthread_t thread[8];
+	struct call_rcu *skel;
+	int i, err, prog_fd;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.stress_hash);
+	for (i = 0; i < ARRAY_SIZE(thread); i++) {
+		err = pthread_create(&thread[i], NULL, stress_thread, &prog_fd);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
+	}
+	while (i--)
+		pthread_join(thread[i], NULL);
+
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->stress_callbacks, __ATOMIC_ACQUIRE) >=
+		    skel->bss->stress_arms)
+			break;
+		kern_sync_rcu();
+		usleep(10000);
+	}
+
+	/* Every arm must have run, and the run must not have stalled early. */
+	ASSERT_GT(skel->bss->stress_arms, 1000, "stress_arms");
+	ASSERT_EQ(skel->bss->stress_callbacks, skel->bss->stress_arms, "stress_callbacks");
+
+	call_rcu__destroy(skel);
+}
+
 static void test_call_rcu_bad_map(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts);
@@ -177,9 +330,9 @@ static void test_call_rcu_bad_map(void)
 	opts.btf_key_type_id = bpf_map__btf_key_type_id(skel->maps.arr);
 	opts.btf_value_type_id = bpf_map__btf_value_type_id(skel->maps.arr);
 
-	fd = bpf_map_create(BPF_MAP_TYPE_HASH, "rcu_hash", sizeof(__u32),
+	fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "rcu_pcpu", sizeof(__u32),
 			    bpf_map__value_size(skel->maps.arr), 1, &opts);
-	ASSERT_EQ(fd, -EOPNOTSUPP, "hash_rejected");
+	ASSERT_EQ(fd, -EOPNOTSUPP, "percpu_hash_rejected");
 	if (fd >= 0)
 		close(fd);
 
@@ -253,6 +406,89 @@ static void test_call_rcu_two_heads(void)
 	call_rcu__destroy(skel);
 }
 
+static void test_call_rcu_hash_replace(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	int i;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_then_replace),
+					      &opts), "run"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 0, "retval"))
+		goto out;
+	ASSERT_OK(skel->bss->arm_err, "arm_err");
+
+	kern_sync_rcu();
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->hash_callbacks, __ATOMIC_ACQUIRE) >= 1)
+			break;
+		usleep(10000);
+	}
+	if (!ASSERT_EQ(skel->bss->hash_callbacks, 1, "hash_callbacks"))
+		goto out;
+
+	/*
+	 * The value the callback saw tells us which element it ran on: the one
+	 * that was armed, not one handed back out to a later update.
+	 */
+	ASSERT_EQ(skel->bss->hash_cb_val, 0xbadc0de, "hash_cb_val");
+out:
+	call_rcu__destroy(skel);
+}
+
+static void test_call_rcu_reuse(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_after_reuse), &opts),
+		       "run"))
+		goto out;
+	ASSERT_EQ(opts.retval, 0, "retval");
+	ASSERT_OK(skel->bss->reuse_arm2, "arm_after_reuse");
+out:
+	call_rcu__destroy(skel);
+}
+
+static void test_call_rcu_hash_np(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct call_rcu *skel;
+	int i;
+
+	skel = call_rcu__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		return;
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arm_delete_reinsert),
+					      &opts), "run"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 0, "retval"))
+		goto out;
+	ASSERT_OK(skel->bss->arm_err, "arm_err");
+
+	kern_sync_rcu();
+	for (i = 0; i < 3000; i++) {
+		if (__atomic_load_n(&skel->bss->hash_callbacks, __ATOMIC_ACQUIRE) >= 1)
+			break;
+		usleep(10000);
+	}
+	if (!ASSERT_EQ(skel->bss->hash_callbacks, 1, "hash_callbacks"))
+		goto out;
+
+	ASSERT_EQ(skel->bss->hash_cb_val, 0xbadc0de, "hash_cb_val");
+out:
+	call_rcu__destroy(skel);
+}
+
 void test_call_rcu(void)
 {
 	if (test__start_subtest("run"))
@@ -265,6 +501,20 @@ void test_call_rcu(void)
 		test_call_rcu_two_heads();
 	if (test__start_subtest("teardown"))
 		test_call_rcu_teardown();
+	if (test__start_subtest("hash_delete"))
+		test_call_rcu_hash_delete();
+	if (test__start_subtest("hash_chain"))
+		test_call_rcu_hash_chain();
+	if (test__start_subtest("lru_evict"))
+		test_call_rcu_lru_evict();
+	if (test__start_subtest("hash_replace"))
+		test_call_rcu_hash_replace();
+	if (test__start_subtest("hash_np"))
+		test_call_rcu_hash_np();
+	if (test__start_subtest("reuse"))
+		test_call_rcu_reuse();
+	if (test__start_subtest("stress"))
+		test_call_rcu_stress();
 	if (test__start_subtest("bad_map"))
 		test_call_rcu_bad_map();
 	if (test__start_subtest("iter"))
diff --git a/tools/testing/selftests/bpf/progs/call_rcu.c b/tools/testing/selftests/bpf/progs/call_rcu.c
index 505008647fd6f..f3ad927298005 100644
--- a/tools/testing/selftests/bpf/progs/call_rcu.c
+++ b/tools/testing/selftests/bpf/progs/call_rcu.c
@@ -20,6 +20,31 @@ struct {
 	__type(value, struct elem);
 } arr SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 16384);
+	__type(key, __u32);
+	__type(value, struct elem);
+} hash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 8);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, struct elem);
+} hash_np SEC(".maps");
+
+int hash_cb_val;
+int hash_callbacks;
+int hash_chain;		/* set by userspace: re-arms from the hash callback */
+int hash_chain_err;
+int lru_callbacks;
+int lru_still_present;
+int lru_cb_val;
+int stress_callbacks;
+int stress_arms;
+
 __u32 cb_key;
 __u64 cb_keys;
 __u64 cb_val;
@@ -103,6 +128,255 @@ int arm_trace(void *ctx)
 	return 0;
 }
 
+static int hash_reclaim(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *e = value;
+
+	hash_cb_val = e->val;
+
+	if (hash_chain > 0) {
+		hash_chain--;
+		hash_chain_err = bpf_call_rcu(&e->rh, &hash, hash_reclaim);
+	}
+
+	__sync_fetch_and_add(&hash_callbacks, 1);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, struct elem);
+} lru SEC(".maps");
+
+static int lru_reclaim(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *e = value;
+
+	lru_cb_val = e->val;
+	__sync_fetch_and_add(&lru_callbacks, 1);
+	return 0;
+}
+
+/*
+ * Arm an LRU element, then push enough traffic through the map to evict it
+ * while the callback is still queued.
+ */
+SEC("syscall")
+int arm_lru_then_evict(void *ctx)
+{
+	struct elem init = {};
+	__u32 key = 100;
+	struct elem *e;
+	int i;
+
+	init.val = 0xfeedface;
+	if (bpf_map_update_elem(&lru, &key, &init, BPF_ANY))
+		return 1;
+
+	e = bpf_map_lookup_elem(&lru, &key);
+	if (!e)
+		return 2;
+
+	arm_err = bpf_call_rcu(&e->rh, &lru, lru_reclaim);
+	if (arm_err)
+		return 3;
+
+	/* max_entries is 2, so this would evict the armed element. */
+	init.val = 0;
+	bpf_for(i, 0, 64) {
+		__u32 k = 200 + i;
+
+		bpf_map_update_elem(&lru, &k, &init, BPF_ANY);
+	}
+
+	/* The callback still needs it, so the eviction must have been declined. */
+	lru_still_present = !!bpf_map_lookup_elem(&lru, &key);
+	return 0;
+}
+
+static int stress_reclaim(struct bpf_map *map, void *key, void *value)
+{
+	__sync_fetch_and_add(&stress_callbacks, 1);
+	return 0;
+}
+
+/*
+ * Hammer arm and delete on overlapping keys from several CPUs at once, to
+ * exercise the window where a delete lands while a callback is running.
+ */
+SEC("syscall")
+int stress_hash(void *ctx)
+{
+	struct elem init = {};
+	struct elem *e;
+	__u32 key;
+	int i;
+
+	init.val = 0xabcd1234;
+
+	bpf_for(i, 0, 16) {
+		key = bpf_get_prandom_u32() & 0xff;
+
+		if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
+			continue;
+
+		e = bpf_map_lookup_elem(&hash, &key);
+		if (!e)
+			continue;
+
+		if (!bpf_call_rcu(&e->rh, &hash, stress_reclaim))
+			__sync_fetch_and_add(&stress_arms, 1);
+		bpf_map_delete_elem(&hash, &key);
+	}
+
+	return 0;
+}
+
+/*
+ * Arm a hash element, then replace its key twice. On a preallocated map the
+ * first replace would stash the old element in this CPU's spare and the second
+ * would hand that same element straight back out, so a callback that still
+ * needs it must take it out of circulation instead.
+ */
+SEC("syscall")
+int arm_then_replace(void *ctx)
+{
+	struct elem init = {};
+	__u32 key = 7;
+	struct elem *e;
+
+	init.val = 0xbadc0de;
+	if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
+		return 1;
+
+	e = bpf_map_lookup_elem(&hash, &key);
+	if (!e)
+		return 2;
+
+	arm_err = bpf_call_rcu(&e->rh, &hash, hash_reclaim);
+	if (arm_err)
+		return 3;
+
+	init.val = 0xaaaa;
+	if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
+		return 4;
+	init.val = 0xbbbb;
+	if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
+		return 5;
+
+	return 0;
+}
+
+static int hash_np_reclaim(struct bpf_map *map, void *key, void *value)
+{
+	struct elem *e = value;
+
+	hash_cb_val = e->val;
+	__sync_fetch_and_add(&hash_callbacks, 1);
+	return 0;
+}
+
+/*
+ * Same handover on a map that frees elements to bpf_mem_alloc rather than a
+ * freelist: arm, delete, then insert the key again. The callback must still
+ * see the value it was armed on, not whatever the reinsert wrote.
+ */
+SEC("syscall")
+int arm_delete_reinsert(void *ctx)
+{
+	struct elem init = {};
+	__u32 key = 3;
+	struct elem *e;
+
+	init.val = 0xbadc0de;
+	if (bpf_map_update_elem(&hash_np, &key, &init, BPF_ANY))
+		return 1;
+
+	e = bpf_map_lookup_elem(&hash_np, &key);
+	if (!e)
+		return 2;
+
+	arm_err = bpf_call_rcu(&e->rh, &hash_np, hash_np_reclaim);
+	if (arm_err)
+		return 3;
+
+	if (bpf_map_delete_elem(&hash_np, &key))
+		return 4;
+
+	init.val = 0x1234;
+	if (bpf_map_update_elem(&hash_np, &key, &init, BPF_ANY))
+		return 5;
+
+	return 0;
+}
+
+/* Arm a hash element, then delete it before the callback can run. */
+SEC("syscall")
+int arm_hash_then_delete(void *ctx)
+{
+	struct elem init = {};
+	__u32 key = 7;
+	struct elem *e;
+
+	init.val = 0xbadc0de;
+	if (bpf_map_update_elem(&hash, &key, &init, BPF_ANY))
+		return 1;
+
+	e = bpf_map_lookup_elem(&hash, &key);
+	if (!e)
+		return 2;
+
+	arm_err = bpf_call_rcu(&e->rh, &hash, hash_reclaim);
+	if (arm_err)
+		return 3;
+
+	if (bpf_map_delete_elem(&hash, &key))
+		return 4;
+
+	/* The freelist is LIFO, so this would hand the same element back out. */
+	key = 8;
+	init.val = 0x5678;
+	return bpf_map_update_elem(&hash, &key, &init, BPF_ANY) ? 5 : 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct elem);
+} one SEC(".maps");
+
+int reuse_arm1, reuse_arm2;
+
+static int reuse_cb(struct bpf_map *map, void *key, void *value)
+{
+	return 0;
+}
+
+/* Insert, delete without ever arming, reinsert, then arm the recycled element. */
+SEC("syscall")
+int arm_after_reuse(void *ctx)
+{
+	struct elem init = {};
+	__u32 key = 1;
+	struct elem *e;
+
+	if (bpf_map_update_elem(&one, &key, &init, BPF_ANY))
+		return 1;
+	/* No callback is ever armed on this element before the delete. */
+	if (bpf_map_delete_elem(&one, &key))
+		return 3;
+	if (bpf_map_update_elem(&one, &key, &init, BPF_ANY))
+		return 4;
+	e = bpf_map_lookup_elem(&one, &key);
+	if (!e)
+		return 5;
+	reuse_arm2 = bpf_call_rcu(&e->rh, &one, reuse_cb);
+	return 0;
+}
+
 SEC("iter/bpf_map_elem")
 int dump(struct bpf_iter__bpf_map_elem *ctx)
 {
-- 
2.53.0-Meta

