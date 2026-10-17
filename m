Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BA3ACF0E
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255219; cv=none; b=QhHVu9Bil7Lui8UqYaoC29sMdRjxQCZCbWTcMxrXcFPy/LjB4uUFuWElG3CAfD0P7n0VMXCbDJlyuRCz7KSvpxDPKWhZWBX604TQJ9ZDvTken1epmFlv0zNtf34FRw8U/8XZhdmPjKAFmN6JCwGxhEppXK7dUw1p8y03KPL1eBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255219; c=relaxed/simple;
	bh=rErm5Rlg9mbOFhTgoy9seQV86u9QqfO7TlIX0nU3lK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbIU+SmpID95Uso86p7qFRuknBr/Z01KepCuaGrt02mcDwgn7NeNwR9IxCi+bups0ccfPuL1u5F5rDfCnxHEhrqWYkdhAlGIMEFxLlB1arFUrDHjF1K3rVqx3njFN5Vfe1Yd1VioIPP6lIh/n1BGTkgN1MMpIadKfZBGVtMg7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvRhGjCp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvRhGjCp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so793605a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255214; x=1792860014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TuAeVKLz0IpQrrfXM3oQMgxs6fe8M+Im28LuY3ZkygU=;
        b=EvRhGjCpnU8e0z6E5SjzOkR9Uz2bOn8mAdMdoPV+R0XhSNGbSRtIyQXFWSqqIcw7tg
         0ux/pOM2u1wSmaiUVJ7Jrsfxs93FLnwQSaZVG7lL6NHQXvn/YU4xOIj+ss5KSwH0FF+F
         smsgiZr04bMZ+2HA8sxdHmBLx2DzFHtlCtNMM+jO6YbTh0mHXQYZbUnXKJO2rCVnfmCE
         EUrT6OmBOoSpDUjCH66yeqbAKMhZRQdtfRXgIWgK/LLQ584flTEVItBHHIRNul9moNiK
         gcpjPS3ccFzaZvmO5U3T9DmXi3dRN/54O5o8TUETukjWD2p24/+3PsDnYodCMvhECjPB
         obbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255214; x=1792860014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TuAeVKLz0IpQrrfXM3oQMgxs6fe8M+Im28LuY3ZkygU=;
        b=tE/JUv0GO/hn5YrwS0aLz7bdoZeVNCLJegQHKbMTCFQyWqxSJP/r7t439SAEdYe/Ru
         hXFBeXej3vCMt9+33SecBM144gtgjwA4FJfMV2pzt+06D/fKZIuBD79avacFJKgAKDx9
         e2f0eOere83Yh1VJXIHt5jBJRF94LeqtVAAvwToum9oSYtdiUGg7rYCApMm1OmtIeEXu
         A/RzVNTHek6GBHaRnVzHX0/LQOZdmtEu9h17M2ahyWIg1Uolbufoarty72KDEnvVJ5PY
         pzDZOY1B+HdItQArauz4BLTT+HUDjWRVTjePWprCy6Thyj3S7L6zPimpK8qfr8tK1eKL
         g6nQ==
X-Gm-Message-State: AFq9FYJQdYunO7Y2HRer4n48Ql2HYO224vg1tXNZEQCETdkCIUaqeYeE
	m1AYYOrmwf1aWBK5MOqbfXmvKHX4Xbt/iWvs0mlFMwXumawv+thWLU+1gymUpQ==
X-Gm-Gg: AYBFou3KTUge/ZWJm/5f3oL5ccggV9EAemZy+LYZ0VMQ4//3Ugw9XOr2PF8LmkURhRp
	sIBmsY7+TlLXv45U3J5MAu4Zgj9i4VMsehRb/Ytb2iecllRb/FFkJemp74q/izq9oz0WQjYBDoI
	IGI7W9QSXqDJ/eJUKwjvv+rjeueOtuf62d2g3n6qkWXLofEUKw92hErI2z9jDZvKHDNvyv0T03I
	GhU3k7IVOK51E/hGSxHzXzXBd58jI0FmPwPdrxMD3f/Eh8XEkgXXnp5Korkreo4WxOlipsRpZKq
	83vd0HiFLMSYuwyPpA4bEBzi+B9ahMNQD3y1m8ZWdEOxE3j6lUjhD+Hd5Z67Bj3sUea2qz6Wf+x
	hXfx2BEKFBq0xjC5jR5ONjor5q9fTzbSZbf/jUg+bfAnqZS/8BvZCVgEL+SlA3GDSeabRS+LG+G
	pgrSuDxN9yGhMxbkf67xAQGGXyepyoTCnz6YoFlQGa72WxdF0a8ePB4fIP+Sf3ulgqIyXT4bmaE
	J2DGNjPoazwocG7c41dNQRN3cvIH8wq+PO4AsmS3uBEMiwjjmsuJKyCws+YMxpFfvE1GinbUY3O
	wbyb3jsFLr1wELIZfkVxbldTHqAydl9l5ktxuq/Y1K4=
X-Received: by 2002:a17:90b:5487:b0:3ac:9c37:9426 with SMTP id 98e67ed59e1d1-3acef0c8743mr3197211a91.31.1792255214072;
        Sat, 17 Oct 2026 09:40:14 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm13865543a91.7.2026.10.17.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:40:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 24/43] bpf: Check the maps that sleepable callbacks use
Date: Sat, 17 Oct 2026 16:37:26 +0000
Message-ID: <20261017163745.3341787-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Sleepable programs can only use the kinds of map that do without an RCU
read side critical section.  check_map_prog_compatibility() sees to that
when a map is bound to the program, and asks whether the program is
sleepable.  That misses the bpf_wq or bpf_task_work callback of a program
that is not, which runs sleepable all the same, and it misses an inner
map, which is not bound.

The bpf_wq callback of a tc program that looks a key up in a sockhash
gets as far as

  WARNING: net/core/sock_map.c:903 at __sock_hash_lookup_elem+0x18f/0x1e0

Ask the same question for the map that is handed to a helper in sleepable
context, unless the RCU read lock is held: by bpf_rcu_read_lock(), or by
the helper that runs the callback, as bpf_for_each_map_elem() does for a
hash map.  Programs that take the lock go on working.  Disabled preemption
or interrupts are not enough, since the maps ask for rcu_read_lock_held().
The other parts of the program may use such a map as before.

A global function that is called with preemption or interrupts disabled is
verified for the non-sleepable context, in which nothing is known of all
that.  Verify it for a context of its own: not sleepable, and without the
RCU read lock.  It differs in what maps can be used, and in nothing else.

What is refused from now on runs into the warning above, or uses what the
map frees behind a plain RCU grace period: an entry of a devmap, of a perf
event array or of a cgroup array.

A bloom filter does without RCU.  Add it to the list, so that callbacks
which use one go on loading.  As a side effect sleepable programs can use
bloom filters as well.

A pointer to the value of a devmap which a program keeps beyond
bpf_rcu_read_unlock() is not dealt with here.

Fixes: 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in sleepable programs")
Fixes: 8e83da9732d9 ("bpf: add bpf_wq_start")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  14 ++++-
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/verifier.c        | 109 ++++++++++++++++++++++++-----------
 3 files changed, 89 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index db56d5d07462..1823ca3a1d5e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1742,12 +1742,20 @@ static inline void bpf_trampoline_multi_detach(struct bpf_prog *prog,
 static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags) {}
 #endif
 
+/* The contexts that a global function is called in, and is verified for. */
+enum bpf_func_context {
+	BPF_FUNC_CTX_NON_SLEEPABLE,
+	BPF_FUNC_CTX_SLEEPABLE,
+	/* Sleepable code has disabled preemption or interrupts: no RCU read lock. */
+	BPF_FUNC_CTX_NO_RCU_LOCK,
+	BPF_FUNC_CTX_CNT,
+};
+
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
-	/* Indexed by in_sleepable. */
-	bool called[2];
-	bool verified[2];
+	bool called[BPF_FUNC_CTX_CNT];
+	bool verified[BPF_FUNC_CTX_CNT];
 };
 
 enum bpf_jit_poke_reason {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 816948df8fff..e420d211f423 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1090,6 +1090,8 @@ struct bpf_verifier_env {
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
 	bool seen_direct_write;
+	/* a global function is verified for BPF_FUNC_CTX_NO_RCU_LOCK */
+	bool no_rcu_read_lock;
 	bool seen_exception;
 	bool signature;
 	u32 insn_aux_data_len;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f2a846ae415..81660ffce99a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -219,6 +219,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
+static bool in_rcu_callback(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
@@ -10379,12 +10380,71 @@ bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
 	       bpf_jit_supports_subprog_tailcalls();
 }
 
+/*
+ * Is rcu_read_lock_held() true at run time? Unlike for in_rcu_cs(), disabled
+ * preemption or interrupts will not do.
+ */
+static bool has_rcu_read_lock(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+
+	if (state->active_rcu_locks || in_rcu_callback(env))
+		return true;
+	if (in_sleepable(env))
+		return false;
+	return !env->no_rcu_read_lock || state->frame[0]->in_async_callback_fn;
+}
+
+/* May the map be used outside of an RCU read side critical section? */
+static bool map_needs_no_rcu(const struct bpf_map *map)
+{
+	switch (map->map_type) {
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_RHASH:
+	case BPF_MAP_TYPE_LRU_HASH:
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_LPM_TRIE:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_USER_RINGBUF:
+	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CGRP_STORAGE:
+	case BPF_MAP_TYPE_QUEUE:
+	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_ARENA:
+	case BPF_MAP_TYPE_INSN_ARRAY:
+	case BPF_MAP_TYPE_PROG_ARRAY:
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int check_map_func_compatibility(struct bpf_verifier_env *env,
 					struct bpf_map *map, int func_id)
 {
 	if (!map)
 		return 0;
 
+	/*
+	 * check_map_prog_compatibility() asks the program.  That misses the
+	 * sleepable callback of another program, and an inner map.  They may
+	 * use any map under the RCU read lock.  Disabled preemption or
+	 * interrupts will not do: the maps ask for rcu_read_lock_held().
+	 */
+	if (!has_rcu_read_lock(env) && !map_needs_no_rcu(map)) {
+		verbose(env, "map '%s' needs bpf_rcu_read_lock() in sleepable context\n",
+			map->name);
+		return -EINVAL;
+	}
+
 	/* We need a two way check, first is from map perspective ... */
 	switch (map->map_type) {
 	case BPF_MAP_TYPE_PROG_ARRAY:
@@ -11373,7 +11433,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 				subprog, sub_name);
-		sub_aux->called[in_sleepable_context(env)] = true;
+		if (in_sleepable_context(env))
+			sub_aux->called[BPF_FUNC_CTX_SLEEPABLE] = true;
+		else if (has_rcu_read_lock(env))
+			sub_aux->called[BPF_FUNC_CTX_NON_SLEEPABLE] = true;
+		else
+			sub_aux->called[BPF_FUNC_CTX_NO_RCU_LOCK] = true;
 		returns_void = subprog_returns_void(env, subprog);
 		if (env->subprog_info[subprog].changes_pkt_data)
 			clear_all_pkt_pointers(env);
@@ -20676,35 +20741,11 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (prog->sleepable)
-		switch (map->map_type) {
-		case BPF_MAP_TYPE_HASH:
-		case BPF_MAP_TYPE_RHASH:
-		case BPF_MAP_TYPE_LRU_HASH:
-		case BPF_MAP_TYPE_ARRAY:
-		case BPF_MAP_TYPE_PERCPU_HASH:
-		case BPF_MAP_TYPE_PERCPU_ARRAY:
-		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
-		case BPF_MAP_TYPE_LPM_TRIE:
-		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
-		case BPF_MAP_TYPE_HASH_OF_MAPS:
-		case BPF_MAP_TYPE_RINGBUF:
-		case BPF_MAP_TYPE_USER_RINGBUF:
-		case BPF_MAP_TYPE_INODE_STORAGE:
-		case BPF_MAP_TYPE_SK_STORAGE:
-		case BPF_MAP_TYPE_TASK_STORAGE:
-		case BPF_MAP_TYPE_CGRP_STORAGE:
-		case BPF_MAP_TYPE_QUEUE:
-		case BPF_MAP_TYPE_STACK:
-		case BPF_MAP_TYPE_ARENA:
-		case BPF_MAP_TYPE_INSN_ARRAY:
-		case BPF_MAP_TYPE_PROG_ARRAY:
-			break;
-		default:
-			verbose(env,
-				"Sleepable programs can only use array, hash, ringbuf and local storage maps\n");
-			return -EINVAL;
-		}
+	if (prog->sleepable && !map_needs_no_rcu(map)) {
+		verbose(env,
+			"Sleepable programs can only use array, hash, ringbuf and local storage maps\n");
+		return -EINVAL;
+	}
 
 	if (bpf_map_is_cgroup_storage(map) &&
 	    bpf_cgroup_storage_assign(env->prog->aux, map)) {
@@ -21426,7 +21467,8 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog, bool is_sleepable)
+static int do_check_common(struct bpf_verifier_env *env, int subprog,
+			   enum bpf_func_context context)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
@@ -21446,7 +21488,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog, bool is_sl
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
-	state->in_sleepable = is_sleepable;
+	state->in_sleepable = context == BPF_FUNC_CTX_SLEEPABLE;
+	env->no_rcu_read_lock = context == BPF_FUNC_CTX_NO_RCU_LOCK;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
@@ -21663,7 +21706,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 	/*
 	 * We can't loop forever as each pass verifies at least one new context,
-	 * and there are only two contexts per global subprog.
+	 * and there are only three contexts per global subprog.
 	 */
 	if (new_cnt)
 		goto again;
-- 
2.55.0

