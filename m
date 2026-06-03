Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51E3ADBAD;
	Wed,  3 Jun 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484800; cv=none; b=KjK1SZLbNxsLFVnT9loQgOhlkoEj6F1IvHWTgQxZLbNe/H1AQ7vXF2p08Kz8/1bjA3lyxdVR/7KAVyj9GRieQD71XRMG8n5tMwr8/ZG4fx7c3DFcN9uCvmuCUwtr4yZ/Us4zGS3MiQx3FkE21w8gazC6lc75Qqq9fhojaN5RD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484800; c=relaxed/simple;
	bh=OOKw/1NyCslMDnHQOBj01BPlqSlEfltQvy0LDqpT0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbAM5tUKrbbe75ilivNT6j2pvpW9d+XsPbQIZilY7M9CMpK1Y8eTQ4hKcQ0pG9vTuHPiiBDqIBrjlooo8unUXFt79LwnMQoGjaIY821DfqFJkR+/bPVV53K9aV+7PLNQb0o0/4VhkmRYK353gRwaoXnY2S2f8BzL2eQ4Boo7Le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScLGUkX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScLGUkX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588CE1F00893;
	Wed,  3 Jun 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484799;
	bh=y0hZntby2ivPPJQ8hT3/WnoVDh3az9luZAO1a9RUjuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ScLGUkX/M4IXopkExBDy6bdMHcrVmVj6Z/CwVWhC8JxR+e//v4Sf3oM6Q1DDRbWDW
	 DjH7aaLWEuUdYbYhternm40BL2rUPfL8PzqKUtwqRpPA7WAWZIGXnf8zOpvgK34sdp
	 09Yi+AeChYNxjAwnqB2HgUPDrmZbK7iB1JZQiCfvQY3EABCLc/I+WrbPQsO+tu5IH8
	 F4iuE0BsfemqDjsXbGX+vGgZU9qWvwSkrgzlvwJIw8yWKgSltsSnw5bXRPHfyj+SDv
	 p5n87XLYJkA3ocFQXyHdBJHNqB57q6yvdZwfTh0bSAKdxQcQ2ki/cwj/n5ABeNFyHz
	 jX4sNe337rBMA==
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
Subject: [PATCHv7 bpf-next 04/29] bpf: Use mutex lock pool for bpf trampolines
Date: Wed,  3 Jun 2026 13:05:28 +0200
Message-ID: <20260603110554.29590-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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
 kernel/bpf/trampoline.c | 77 ++++++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8599b451dd7a..fd0d873219d2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1352,8 +1352,6 @@ struct bpf_trampoline {
 	/* hlist for trampoline_ip_table */
 	struct hlist_node hlist_ip;
 	struct ftrace_ops *fops;
-	/* serializes access to fields of this trampoline */
-	struct mutex mutex;
 	refcount_t refcnt;
 	u32 flags;
 	u64 key;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index a4298a25d4ba..c0b4732627be 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,6 +30,35 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
+/*
+ * Keep 32 trampoline locks (5 bits) in the pool so trampoline_lock_all()
+ * stays below MAX_LOCK_DEPTH.  Each pool slot has a distinct lockdep
+ * class because trampoline_lock_all() takes all pool mutexes at once;
+ * otherwise lockdep would report recursive locking on same-class mutexes.
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
+	return &trampoline_locks[hash_ptr(tr, TRAMPOLINE_LOCKS_BITS)].mutex;
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
 
@@ -69,9 +98,9 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
 		/* This is called inside register_ftrace_direct_multi(), so
-		 * tr->mutex is already locked.
+		 * trampoline's mutex is already locked.
 		 */
-		lockdep_assert_held_once(&tr->mutex);
+		lockdep_assert_held_once(select_trampoline_lock(tr));
 
 		/* Instead of updating the trampoline here, we propagate
 		 * -EAGAIN to register_ftrace_direct(). Then we can
@@ -91,7 +120,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 	}
 
 	/* The normal locking order is
-	 *    tr->mutex => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
+	 *    select_trampoline_lock(tr) => direct_mutex (ftrace.c) => ftrace_lock (ftrace.c)
 	 *
 	 * The following two commands are called from
 	 *
@@ -99,12 +128,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 	 *   cleanup_direct_functions_after_ipmodify
 	 *
 	 * In both cases, direct_mutex is already locked. Use
-	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
-	 * (something else is making changes to this same trampoline).
+	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
+	 * (something else holds the same pool lock).
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
@@ -129,7 +158,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 		break;
 	}
 
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return ret;
 }
 #endif
@@ -359,7 +388,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
-	mutex_init(&tr->mutex);
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
@@ -843,9 +871,9 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -886,9 +914,9 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -998,12 +1026,12 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	if (!tr)
 		return  -ENOMEM;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
 	if (shim_link && !IS_ERR(bpf_link_inc_not_zero(&shim_link->link.link))) {
 		/* Reusing existing shim attached by the other program. */
-		mutex_unlock(&tr->mutex);
+		trampoline_unlock(tr);
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 		return 0;
 	}
@@ -1023,16 +1051,16 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
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
@@ -1053,9 +1081,9 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 	if (WARN_ON_ONCE(!tr))
 		return;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 
 	if (shim_link)
 		bpf_link_put(&shim_link->link.link);
@@ -1073,14 +1101,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
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
 
@@ -1093,7 +1121,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_lock(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
 		goto out;
-	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
@@ -1379,6 +1406,8 @@ static int __init init_trampolines(void)
 		INIT_HLIST_HEAD(&trampoline_key_table[i]);
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&trampoline_ip_table[i]);
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++)
+		__mutex_init(&trampoline_locks[i].mutex, "trampoline_lock", &trampoline_locks[i].key);
 	return 0;
 }
 late_initcall(init_trampolines);
-- 
2.54.0

