Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F9EA4
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945263; cv=none; b=hOhF8CTnuxWjIJ9mknM0csopRR8QNTRc64aKORRss6D1qp4jr9Xr9OYtcTAlItr50dtJ3iIim+yfRxikfYw7imOTCaVp9SZdPZoc+010/AAhz3Fznezf33pptAxFWzq7BoJmlKD3H623RuVzhv55+D66bIRzDEvXpYXC0R6a74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945263; c=relaxed/simple;
	bh=uKHqsIqPsLgf0lYxbSOcteCsu+u/Lr6UV+6u/kUaNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9tVtc2w6TQGnvKD5Px5qcIgaCaa0XaTa7BUjdNsytluZMMFO/Az71zSFFRXtdKTgdLkz8QUQIkVWPCnSpy/jDt4h/1wLAz+O+JsZw0oA9vrtRE7zIKLFgCo/hqps8S442hPIxSiJXr5pUP3Dwezz03+RBS1SA2QlEd0f+2mvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Uo4rEY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Uo4rEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB6C433C7;
	Sat,  9 Mar 2024 00:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709945262;
	bh=uKHqsIqPsLgf0lYxbSOcteCsu+u/Lr6UV+6u/kUaNxg=;
	h=From:To:Cc:Subject:Date:From;
	b=q4Uo4rEYLATlEDI6G2NWVC3esldNG8w5TSO+ZNsiPpT4OPuXeV79LZw/BRkaULLRt
	 fPg5yZg9zA/qSU8YuYMm232vhk+wat/EP7hDNFJcOBtZHObuvmnsw+5Ln/KWzwSF3j
	 XW7aJRwKLW6x84a4H/ieOXncCZKvA3LVYrs8unmQy2DzlU1sbBTxctfwSCagl3hfoL
	 YNnVv5UP2xxyiPjBRaowy+DmwOaaMsdcSsemxqNORWRp6qm3OMbic6Ap9iGOxCeUVL
	 JoJc3vCyaJH3I10fkUaAOByk7NziRZJ2oiOLt4kw+a1BaURv0NVuYKrYuT/t1xOi/b
	 GAsTaCFaNWA2g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
Date: Fri,  8 Mar 2024 16:47:39 -0800
Message-ID: <20240309004739.2961431-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prog->aux->sleepable is checked very frequently as part of (some) BPF
program run hot paths. So this extra aux indirection seems wasteful and
on busy systems might cause unnecessary memory cache misses.

Let's move sleepable flag into prog itself to eliminate unnecessary
pointer dereference.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  8 ++++----
 kernel/bpf/bpf_iter.c          |  4 ++--
 kernel/bpf/core.c              |  2 +-
 kernel/bpf/syscall.c           |  6 +++---
 kernel/bpf/trampoline.c        |  4 ++--
 kernel/bpf/verifier.c          | 12 ++++++------
 kernel/events/core.c           |  2 +-
 kernel/trace/bpf_trace.c       |  2 +-
 net/bpf/bpf_dummy_struct_ops.c |  2 +-
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 95e07673cdc1..b444237e01a0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1452,7 +1452,6 @@ struct bpf_prog_aux {
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
 	bool attach_tracing_prog; /* true if tracing another tracing program */
 	bool func_proto_unreliable;
-	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
 	bool exception_cb;
@@ -1537,7 +1536,8 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
-				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
+				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
+				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
@@ -2108,14 +2108,14 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
-		if (!prog->aux->sleepable)
+		if (!prog->sleepable)
 			rcu_read_lock();
 
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
 		item++;
 
-		if (!prog->aux->sleepable)
+		if (!prog->sleepable)
 			rcu_read_unlock();
 	}
 	bpf_reset_run_ctx(old_run_ctx);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0fae79164187..112581cf97e7 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -548,7 +548,7 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 		return -ENOENT;
 
 	/* Only allow sleepable program for resched-able iterator */
-	if (prog->aux->sleepable && !bpf_iter_target_support_resched(tinfo))
+	if (prog->sleepable && !bpf_iter_target_support_resched(tinfo))
 		return -EINVAL;
 
 	link = kzalloc(sizeof(*link), GFP_USER | __GFP_NOWARN);
@@ -697,7 +697,7 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 	struct bpf_run_ctx run_ctx, *old_run_ctx;
 	int ret;
 
-	if (prog->aux->sleepable) {
+	if (prog->sleepable) {
 		rcu_read_lock_trace();
 		migrate_disable();
 		might_fault();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 134b7979f537..c58d1781c708 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2701,7 +2701,7 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 	bool sleepable;
 	u32 i;
 
-	sleepable = aux->sleepable;
+	sleepable = aux->prog->sleepable;
 	for (i = 0; i < len; i++) {
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f63f4da4db5e..1a257c281e26 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2212,7 +2212,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 		btf_put(prog->aux->attach_btf);
 
 	if (deferred) {
-		if (prog->aux->sleepable)
+		if (prog->sleepable)
 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
 		else
 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
@@ -2777,11 +2777,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	}
 
 	prog->expected_attach_type = attr->expected_attach_type;
+	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
 	prog->aux->dev_bound = !!attr->prog_ifindex;
-	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
 
 	/* move token into prog->aux, reuse taken refcnt */
@@ -5512,7 +5512,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	/* The bpf program will not access the bpf map, but for the sake of
 	 * simplicity, increase sleepable_refcnt for sleepable program as well.
 	 */
-	if (prog->aux->sleepable)
+	if (prog->sleepable)
 		atomic64_inc(&map->sleepable_refcnt);
 	memcpy(used_maps_new, used_maps_old,
 	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d382f5ebe06c..db7599c59c78 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1014,7 +1014,7 @@ void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr)
 
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog)
 {
-	bool sleepable = prog->aux->sleepable;
+	bool sleepable = prog->sleepable;
 
 	if (bpf_prog_check_recur(prog))
 		return sleepable ? __bpf_prog_enter_sleepable_recur :
@@ -1029,7 +1029,7 @@ bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog)
 
 bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog)
 {
-	bool sleepable = prog->aux->sleepable;
+	bool sleepable = prog->sleepable;
 
 	if (bpf_prog_check_recur(prog))
 		return sleepable ? __bpf_prog_exit_sleepable_recur :
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf084c693507..7ceee73ff598 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5273,7 +5273,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static bool in_sleepable(struct bpf_verifier_env *env)
 {
-	return env->prog->aux->sleepable;
+	return env->prog->sleepable;
 }
 
 /* The non-sleepable programs and sleepable programs with explicit bpf_rcu_read_lock()
@@ -18090,7 +18090,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable)
+	if (prog->sleepable)
 		switch (map->map_type) {
 		case BPF_MAP_TYPE_HASH:
 		case BPF_MAP_TYPE_LRU_HASH:
@@ -18277,7 +18277,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
-			if (env->prog->aux->sleepable)
+			if (env->prog->sleepable)
 				atomic64_inc(&map->sleepable_refcnt);
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
@@ -20833,7 +20833,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			}
 		}
 
-		if (prog->aux->sleepable) {
+		if (prog->sleepable) {
 			ret = -EINVAL;
 			switch (prog->type) {
 			case BPF_PROG_TYPE_TRACING:
@@ -20944,14 +20944,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	u64 key;
 
 	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
-		if (prog->aux->sleepable)
+		if (prog->sleepable)
 			/* attach_btf_id checked to be zero already */
 			return 0;
 		verbose(env, "Syscall programs can only be sleepable\n");
 		return -EINVAL;
 	}
 
-	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
+	if (prog->sleepable && !can_be_sleepable(prog)) {
 		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ecfa57e3b97..724e6d7e128f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10553,7 +10553,7 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 	    (is_syscall_tp && prog->type != BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
 
-	if (prog->type == BPF_PROG_TYPE_KPROBE && prog->aux->sleepable && !is_uprobe)
+	if (prog->type == BPF_PROG_TYPE_KPROBE && prog->sleepable && !is_uprobe)
 		/* only uprobe programs are allowed to be sleepable */
 		return -EINVAL;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..0a5c4efc73c3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3256,7 +3256,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 		.uprobe = uprobe,
 	};
 	struct bpf_prog *prog = link->link.prog;
-	bool sleepable = prog->aux->sleepable;
+	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 1b5f812e6972..de33dc1b0daa 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -174,7 +174,7 @@ static int bpf_dummy_ops_check_member(const struct btf_type *t,
 	case offsetof(struct bpf_dummy_ops, test_sleepable):
 		break;
 	default:
-		if (prog->aux->sleepable)
+		if (prog->sleepable)
 			return -EINVAL;
 	}
 
-- 
2.43.0

