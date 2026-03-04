Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E33845A3;
	Wed,  4 Mar 2026 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662933; cv=none; b=ouoI1OhgzNkAkFntiCjsBEEjOZEs0ro//U6uZc3cGoFAgU5e1c9PkhJBNu4UVmMmZTLD+BXH3cJ2AXzHzYH1inzGhaseAM9+PnASrbBeZ7RPJiTh75+8IBW9qe6uSsAN0rJOto93GRYFpiTDGW5PH6MDUo0iT+AF6yzHoItRrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662933; c=relaxed/simple;
	bh=Ui9ogWIi2CjTpWz2P2h5b8EcCsyxLXeeAfi43ivmdk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHFgic0CgxS9lRPw314FUVrd6/7nTJ1ifE9oyjhpztbPFZEmktWAfuGzelRfE82h5MdxHYf4EjabstLvU16db1w24UIMUXYgeHGl1y0to94pxifiZXpEseFjTdZ3tnMP+CxjY8pOyasjp1Sa0x5A18CalMojBrE7RwOz8gBLjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOnIQNG4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOnIQNG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A24C4CEF7;
	Wed,  4 Mar 2026 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662933;
	bh=Ui9ogWIi2CjTpWz2P2h5b8EcCsyxLXeeAfi43ivmdk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOnIQNG4XxGyK86JjEWCgKWjUC80M7SHac8aoQ8wpkjBmCzjx04BHXYJQBfQl/Gf/
	 hUxEsGaZ8mTppDVMmkhdcvLt41kntQpk5FDniXXS5HFr6RnaSnujM3Gczdi6ufooUM
	 4EpDY+CHxbKnJHe08hyPBZctRNImyJH0IyjmVe6VV1mPZF2TFc9MqM3Cw1nHJQpfOi
	 zWh6ocucHY+zQO4J0eJBxU2KFXhqrkaH1wg2uKAB1jgryay2CfHLUFkZNtK2B+t8GJ
	 ta2blcoyRwSOj8CiSo9BJij+LTXjggwlG6lOeKAWQw48oc67qxvoGoJjN/ZZTWGQVX
	 hB+AeEOCT1Lng==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv2 bpf-next 02/23] bpf: Use mutex lock pool for bpf trampolines
Date: Wed,  4 Mar 2026 23:21:20 +0100
Message-ID: <20260304222141.497203-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding mutex lock pool that replaces bpf trampolines mutex.

For tracing_multi link coming in following changes we need to lock all
the involved trampolines during the attachment. This could mean thousands
of mutex locks, which is not convenient.

As suggested by Andrii we can replace bpf trampolines mutex with mutex
pool, where each trampoline is hash-ed to one of the locks from the pool.

It's better to lock all the pool mutexes (32 at the moment) than
thousands of them.

There is 48 (MAX_LOCK_DEPTH) lock limit allowed to be simultaneously
held by task, so we need to keep 32 mutexes (5 bits) in the pool, so
when we lock them all in following changes the lockdep won't scream.

Removing the mutex_is_locked in bpf_trampoline_put, because we removed
the mutex from bpf_trampoline.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  2 --
 kernel/bpf/trampoline.c | 75 ++++++++++++++++++++++++++++-------------
 2 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..1d900f49aff5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1335,8 +1335,6 @@ struct bpf_trampoline {
 	/* hlist for trampoline_ip_table */
 	struct hlist_node hlist_ip;
 	struct ftrace_ops *fops;
-	/* serializes access to fields of this trampoline */
-	struct mutex mutex;
 	refcount_t refcnt;
 	u32 flags;
 	u64 key;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 84db9e658e52..28a5a96bccec 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,6 +30,34 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
+/*
+ * We keep 32 trampoline locks (5 bits) in the pool, because there
+ * is 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously
+ * held by task.
+ */
+#define TRAMPOLINE_LOCKS_BITS 5
+#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
+
+static struct {
+	struct mutex mutex;
+	struct lock_class_key key;
+} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
+
+static struct mutex *select_trampoline_lock(struct bpf_trampoline *tr)
+{
+	return &trampoline_locks[hash_64((u64)(uintptr_t) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
+}
+
+static void trampoline_lock(struct bpf_trampoline *tr)
+{
+	mutex_lock(select_trampoline_lock(tr));
+}
+
+static void trampoline_unlock(struct bpf_trampoline *tr)
+{
+	mutex_unlock(select_trampoline_lock(tr));
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -69,9 +97,9 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
 		/* This is called inside register_ftrace_direct_multi(), so
-		 * tr->mutex is already locked.
+		 * trampoline's mutex is already locked.
 		 */
-		lockdep_assert_held_once(&tr->mutex);
+		lockdep_assert_held_once(select_trampoline_lock(tr));
 
 		/* Instead of updating the trampoline here, we propagate
 		 * -EAGAIN to register_ftrace_direct(). Then we can
@@ -91,7 +119,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 	}
 
 	/* The normal locking order is
-	 *    tr->mutex => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
+	 *    select_trampoline_lock(tr) => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
 	 *
 	 * The following two commands are called from
 	 *
@@ -99,12 +127,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 	 *   cleanup_direct_functions_after_ipmodify
 	 *
 	 * In both cases, direct_mutex is already locked. Use
-	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
+	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
 	 * (something else is making changes to this same trampoline).
 	 */
-	if (!mutex_trylock(&tr->mutex)) {
-		/* sleep 1 ms to make sure whatever holding tr->mutex makes
-		 * some progress.
+	if (!mutex_trylock(select_trampoline_lock(tr))) {
+		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
+		 * makes some progress.
 		 */
 		msleep(1);
 		return -EAGAIN;
@@ -129,7 +157,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 		break;
 	}
 
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return ret;
 }
 #endif
@@ -359,7 +387,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
-	mutex_init(&tr->mutex);
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
@@ -844,9 +871,9 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -887,9 +914,9 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -999,14 +1026,15 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	if (!tr)
 		return  -ENOMEM;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
 	if (shim_link) {
 		/* Reusing existing shim attached by the other program. */
 		bpf_link_inc(&shim_link->link.link);
 
-		mutex_unlock(&tr->mutex);
+		trampoline_unlock(tr);
+
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 		return 0;
 	}
@@ -1026,16 +1054,16 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	shim_link->trampoline = tr;
 	/* note, we're still holding tr refcnt from above */
 
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 
 	return 0;
 err:
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 
 	if (shim_link)
 		bpf_link_put(&shim_link->link.link);
 
-	/* have to release tr while _not_ holding its mutex */
+	/* have to release tr while _not_ holding pool mutex for trampoline */
 	bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 
 	return err;
@@ -1056,9 +1084,9 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 	if (WARN_ON_ONCE(!tr))
 		return;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 
 	if (shim_link)
 		bpf_link_put(&shim_link->link.link);
@@ -1076,14 +1104,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 	if (!tr)
 		return NULL;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	if (tr->func.addr)
 		goto out;
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
 	tr->func.addr = (void *)tgt_info->tgt_addr;
 out:
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return tr;
 }
 
@@ -1096,7 +1124,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_lock(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
 		goto out;
-	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
@@ -1382,6 +1409,8 @@ static int __init init_trampolines(void)
 		INIT_HLIST_HEAD(&trampoline_key_table[i]);
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&trampoline_ip_table[i]);
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		__mutex_init(&trampoline_locks[i].mutex, "trampoline_lock", &trampoline_locks[i].key);
 	return 0;
 }
 late_initcall(init_trampolines);
-- 
2.53.0

