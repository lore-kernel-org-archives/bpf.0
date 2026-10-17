Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C32379EC1
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200599; cv=none; b=jY2MyNNq7/vnQxQNhRjiEFrw+iL86f8SGFrgQbyQm4V5PSd26YI7lk/NBh+yKZlv4t0fJYfg8ltBiXgJ8kwHMQeZ2BFbrMeiVd1jQSpzQtgpq1zeXiLIqxDjkdb/g3FwirqfqsU6LIR+N9hAQ9EBmujOnK7XyX7o2+R2rc9syd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200599; c=relaxed/simple;
	bh=+Q9C8oe3hqWcJoDTtj0AHpR5cMx2KWUkdcqLZdsQkvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIxbKQBufH70LIDlpO0Q4B6uztRU5qQJ7f5cnZnjE+/q7CtJzYNLgPXAdAGZVb4XixMkptOe/fsNrnAK+72JOZbZascIdtyrdfnMXJLpcGNJXjxijDaxE9hApJjy2KvQQDIa6t/9iLOkgM6atH5Vq5B3BIyHXvuyIl/cLXz2XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHEtqHAU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHEtqHAU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e49fbf92aaso2315905ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200598; x=1792805398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ro7OdpQEd8MQYPcU23BKt9hO5HQKv8OL+xjogw/2Zck=;
        b=tHEtqHAUgQOxxm/UPe90orpdXjGBQBTNYDt4oUoN6DqquFguAEJYuSIeX82Pd7QyPh
         tsZaU4WL4vax2Yy7Hg0VUpQnBytvCBMuZTOacWOc3j9DFV3gsFms9mtRW+M4WfuVtA9G
         k38I7ha6r7alljKocirr1vm5FqyfKzPRQ2b06CPnhPMid/qHl7WZJ3SQtBsFfFB6VCBP
         ZmbzwXcMRkpqKi/LuSFCuGa3XuNDDFw/aNxeR229p+LjwmU6QVcycjAxLKr/z81E05R6
         9eyJEDpRmBE4hNMk/8mg6ErvTP1fKzNZQfnl+2EmMXUstrvZuN3Atk+vDTwN9P6HPDc8
         mISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200598; x=1792805398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ro7OdpQEd8MQYPcU23BKt9hO5HQKv8OL+xjogw/2Zck=;
        b=Mgr/QejrCy0DkMfEPXKrb6XiLRGE/xBZBqtzLtPcueetqwbh2EnvZ/koKDI+2DJ6DU
         UaAXZZ3CBANsjiICosbwU0g/Fk7EKkQCp+t3EtWogp7XZrs6rXxsWIPAq6k/47O9AEco
         mjN2yZdXnYUfBu9vVHmBnAG+2e64B7hbr1tpI16P0nzz9/2FSLsPla0tufd4uMXaYQXn
         Xhtv1NWeMyXrh63RZxr5Rj8+rOCO4V70wkHyr7hdfM0owa6O3fY+9S0C2j5zHsHJ+bbi
         RVKmLD2x+R8BhphUEbxizhooRQUQn73PxuHremJbNtgLimb2RaQwEzZDF+GT72tc9XbI
         Cg4w==
X-Gm-Message-State: AFq9FYLoRDOV8CMM/iCoRXA2K1VyijVBfnbMz8cnpmm089xyXExVi/k3
	YATNtTAae0aJjgclltjwNKqdeDYA4TX9dJXSNKUSR+9+mUMTaLXuKB7vYGBmzwZA
X-Gm-Gg: AYBFou2xeU+PCTctkQ6ig1ruYb3XREKL2aGufnntcHinm6ee17apWHzjUiF7ocPs5oO
	w1H6YQ8JGTS6xJssZXRMZGfaBlEmQH2mX67vHopSKmU991doP7jJArwKVyAN1x8Q9Nv19igU6UW
	DuK4X9pXGjMU5XRqs2BQuyvDS+H7pame4aQz+ugl2IuLWU3aVUkkSsbJ7OTrBwMbBCS8BqclBYU
	PS/UuWppWGGpLQA4RuB5UfItigPNmja9ITOfUbFgS5FHoTrFnkmqB4jSAMSMIFKJOlKKT2gBur7
	lGMklwkMe/5xTsBXfNLfpr0pngjMebd1Batj0Bx9BXOwCngSDeTnhAVvyB6AATOvcqJVNJJjmM0
	Fkgjcge+gywwlRXjXzdjgbffKNX3c3bU8KS6sYptk6B6w05UomRrBaggY0uAiudd8DS2ThY0UwN
	fX4tWDrjO9k5BwdL1piO4ctUxiK1PUPaALngMMVHtu4Pn/eKi79nQX7PxtwgBHaPDQ0cRE/mJ68
	ZgZikl2KNIhyhP7BLivbwszLXFOLFJeFhQKcd/e3GhoogfeueU2rPPcoQyzorG7+EJL/bTe2DD/
	0axTflw4q95TDwLA+70P1MTlHtiKEwPRCdE7JmzJKpje
X-Received: by 2002:a17:902:e844:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2e9a6e558admr14366835ad.47.1792200597865;
        Fri, 16 Oct 2026 18:29:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804becsm17019475ad.21.2026.10.16.18.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:29:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 23/38] bpf: Check the maps that sleepable callbacks use
Date: Sat, 17 Oct 2026 01:24:36 +0000
Message-ID: <20261017012451.364800-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/verifier.c | 80 +++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f2a846ae415..09173d1d66d3 100644
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
@@ -10379,12 +10380,57 @@ bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
 	       bpf_jit_supports_subprog_tailcalls();
 }
 
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
+	if (in_sleepable(env) && !env->cur_state->active_rcu_locks &&
+	    !in_rcu_callback(env) && !map_needs_no_rcu(map)) {
+		verbose(env, "map '%s' needs bpf_rcu_read_lock() in sleepable context\n",
+			map->name);
+		return -EINVAL;
+	}
+
 	/* We need a two way check, first is from map perspective ... */
 	switch (map->map_type) {
 	case BPF_MAP_TYPE_PROG_ARRAY:
@@ -20676,35 +20722,11 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
-- 
2.55.0

