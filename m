Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5D32C8B;
	Fri, 20 Feb 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582049; cv=none; b=Ywjddqo5k1EBiyrvEqTpVE6cAzfDCMY+nn9TyC9ANS8XhaD53LoMemgeWjYnUygOp8dwZBlJl0/ugN3zUALRFTwRRuDvr8fNo2+bqyk43f0dXODwLOG145jWnbo89P6deBrbd6DjoGVLnsXBfyj4rQKq7UZdC9h1IrXFnO9iG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582049; c=relaxed/simple;
	bh=ApiXL1RUtRKTLXOv3OUcU2XwVZz6H2Fk3jEvmnhNn18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0bQlD+wnLr+MG9IoMK4cI8NhroIw1i1XGRgrw6310y00JQxHydOCFWjTR3MX2Im1NdRdkaoYBGMDfUblmggCjdnX1PCVwttPgIhHH8oHLqr5wPRaSN9Gh1xXRsFxKj2EUniKDvhkKcUORBkk1AMsPSlEnVkCTidEsvvIjKWyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM/sLa7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM/sLa7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA1C116C6;
	Fri, 20 Feb 2026 10:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582048;
	bh=ApiXL1RUtRKTLXOv3OUcU2XwVZz6H2Fk3jEvmnhNn18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EM/sLa7QoNGLBr0oze4sZabznlfhPNTEQ7kAqmJrUFpZPgHnSdVG3PGsZbJ/sAEPe
	 SXw5ZlV3qzKX6RAgHjCMABakTttfrHcrzR38kgeJs/sBE7OI83dM295iWE12dpnfQA
	 8X1U+E1tVoZZ8k5myHO9jEwx2JQpCgBtW6j9C0WSpQDmyG6PoyP3iOHBQlIy42VAOl
	 0G1pqEqf2xaVdUxESDDeVfjSTryp1dGeTTJzGZvEjH2yVGWQOZdLDfJbuqtwE6g1Ix
	 Z9fjmL9koLqt4z+4OI+BFQsnTB+aFWhO5/rf6qbscBWhmlBZEKCY76CAVoyO0ehLhk
	 k8O/y2psHEthQ==
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
Subject: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
Date: Fri, 20 Feb 2026 11:06:34 +0100
Message-ID: <20260220100649.628307-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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

It's better to lock all the pool mutexes (64 at the moment) than
thousands of them.

Removing the mutex_is_locked in bpf_trampoline_put, because we removed
the mutex from bpf_trampoline.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  2 --
 kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd9b96434904..46bf3d86bdb2 100644
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
index 952cd7932461..05dc0358654d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
 /* serializes access to trampoline tables */
 static DEFINE_MUTEX(trampoline_mutex);
 
+#define TRAMPOLINE_LOCKS_BITS 6
+#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
+
+static struct {
+	struct mutex mutex;
+	struct lock_class_key key;
+} *trampoline_locks;
+
+static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *tr)
+{
+	return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
+}
+
+static void trampoline_lock(struct bpf_trampoline *tr)
+{
+	mutex_lock(trampoline_locks_lookup(tr));
+}
+
+static void trampoline_unlock(struct bpf_trampoline *tr)
+{
+	mutex_unlock(trampoline_locks_lookup(tr));
+}
+
+static int __init trampoline_locks_init(void)
+{
+	int i;
+
+	trampoline_locks = kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZE,
+					 sizeof(trampoline_locks[0]), GFP_KERNEL);
+	if (!trampoline_locks)
+		return -ENOMEM;
+
+	for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
+		lockdep_register_key(&trampoline_locks[i].key);
+		mutex_init_with_key(&trampoline_locks[i].mutex, &trampoline_locks[i].key);
+	}
+	return 0;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex);
 
@@ -71,7 +110,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 		/* This is called inside register_ftrace_direct_multi(), so
 		 * tr->mutex is already locked.
 		 */
-		lockdep_assert_held_once(&tr->mutex);
+		lockdep_assert_held_once(trampoline_locks_lookup(tr));
 
 		/* Instead of updating the trampoline here, we propagate
 		 * -EAGAIN to register_ftrace_direct(). Then we can
@@ -102,7 +141,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
 	 * (something else is making changes to this same trampoline).
 	 */
-	if (!mutex_trylock(&tr->mutex)) {
+	if (!mutex_trylock(trampoline_locks_lookup(tr))) {
 		/* sleep 1 ms to make sure whatever holding tr->mutex makes
 		 * some progress.
 		 */
@@ -129,7 +168,7 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
 		break;
 	}
 
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return ret;
 }
 #endif
@@ -359,7 +398,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist_ip, head);
 	refcount_set(&tr->refcnt, 1);
-	mutex_init(&tr->mutex);
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 out:
@@ -844,9 +882,9 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_link_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -887,9 +925,9 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 {
 	int err;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 	return err;
 }
 
@@ -999,14 +1037,15 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
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
@@ -1026,11 +1065,11 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
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
@@ -1056,9 +1095,9 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
 	if (WARN_ON_ONCE(!tr))
 		return;
 
-	mutex_lock(&tr->mutex);
+	trampoline_lock(tr);
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	mutex_unlock(&tr->mutex);
+	trampoline_unlock(tr);
 
 	if (shim_link)
 		bpf_link_put(&shim_link->link.link);
@@ -1076,14 +1115,14 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
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
 
@@ -1096,7 +1135,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	mutex_lock(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
 		goto out;
-	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++)
 		if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
@@ -1382,6 +1420,6 @@ static int __init init_trampolines(void)
 		INIT_HLIST_HEAD(&trampoline_key_table[i]);
 	for (i = 0; i < TRAMPOLINE_TABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&trampoline_ip_table[i]);
-	return 0;
+	return trampoline_locks_init();
 }
 late_initcall(init_trampolines);
-- 
2.52.0

