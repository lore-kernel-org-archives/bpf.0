Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208001;
	b=Gj/QoxGiGO+xrfoBh5I2i1qPDL7P1hvVgDRK7lCYzvJqkiHsLQ9I7gnksKASyaUTpALY
	 Ul9T58/SgXYfMll68bP1BlNfi/LW51Zl+Ne5ld3uBQKQVJOHKF05jVkVp1PNP5u0lcs93
	 CDKKKTvpycTIvwX/+nbhAqpN1vtoHAAU79ZouZUVGmpNXrPwbTvnS3YLxhPla3BetqFEY
	 vZCLG0efWXS4XyZli/C6iFi/kQl1Q8kzAidvJNKtxVHHTHFWcQpjK54LhXYlT/QnDOvNU
	 OLz5NKkKV9ldMWF9vYnaF/4n8CpShBg92cIDLIdTkrWFgfQOBo0COuXYxXZdgDZSYeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FgJHdI70j9OufwQhEixoUo20pNd4kdjgnUXL/tX1D1c=;
	b=tZK/LF/J5MRCLZXNbgadLK4xtsALXVzUNr8/6QM/y/lCwSasTB71aaZ4Z4fe0qYSltUA
	 C/5GNrbbG8KtiUL61vmWQx031BJZa+KoMnrueAlKXQNnKaBMASlMSEqWsNwrEM8P9WiBW
	 GFrP7QpRToHDJKmbVKuewOh1PigWfX0RqTrypggYxpKuDel9ENR1iEhtsSPGUVyKq7LFB
	 F33ld47hHPDBKe3OgK6I+vVvx3QnI++WfA5DqgW1MQFkf12QzZTJHezW7jIxXTc16fHDM
	 SqnFH0xr86z9AYgNM6jotUJkhfvTDrDWM8A0qsHruyLJetIFwZ6umlmntI7nhakFT6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJq+pfT+;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149B606A6B2
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1149B606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJq+pfT+
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b4021b572dso976425a91.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207998; x=1795812798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgJHdI70j9OufwQhEixoUo20pNd4kdjgnUXL/tX1D1c=;
        b=ZJq+pfT+BVn4JBIT4IiqgfZNoW2doLUlaDWRVlBGnO4TIlNsGQ/5UvgVPCQu9P/6la
         3wPeIXmRyL+bNmzSNFZTN6V3HXELa166RzHuZjbn5dnxAWIxiK9/y7WK8eALYEIy2Etw
         HYfsZYlv8tlKPaTTpHvTR7zmbYjEE+3A9QVijsEUy/kv5ZW6U4xDN4oTTi9l8wEo9We/
         BCeXDrdDxaTizbvot6OA3CNsL5oJmKXlltm/mXQDc8w9/GbElz4VhLHT3UMze+SANDnh
         UyLzZtHDzRu+dnAfMF0aWr8Cs1aQRyDL6UEm+4VZGKfUlRCv+NgB7tY9eV8N7Nmcuke5
         cBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207998; x=1795812798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgJHdI70j9OufwQhEixoUo20pNd4kdjgnUXL/tX1D1c=;
        b=vOHS+v6CBDKrBhNCU35tv0hBfdIAWJo0T76Lkkl6sMOcYcfHdLMLPuLzO+Jk2eqepe
         f2ItxPP6N8zQJ7EvJpgzr1AuhLL55uP4McrQ3B6axHsM45H2nXsHCAgiJX2sKmLYLAd/
         HIUkc38pR/o7wlCpHx6o0rX1ES5gqN1lwnqIKlf7/SmWl5uwOSID0osqpq7vUKtqDGQi
         kalSoJA9xN0B4f6adKLVTzJh1vMCdAK8p+KqY7LAbVqlxlh0GJFjjV+agyAShA8PK+bA
         tdih0gXvMpgKQekk7QpyGnkYFqGlPsOIelwQo21OfqjfRM7eonb/76hScs7NYb7W404u
         VaAg==
X-Gm-Message-State: APuU4Z9ExyLvwn1l5NAOXBxtdKti5+NmS47NV0yboNxxO3FNpHMxvOgF
	m4zQXD7cNF/kpSSKyCcydgDW9D1zlQw6sHgG3/l33//RPAkTH8VVWniw0lVwmg==
X-Gm-Gg: AZFdTZcD5HtNyJj+RGS2mwa9MZbbO8shPDFOYDIhoE+mJ48c3z7h0liRe5sWPnTHwNn
	k3Prbr6FOUbER9L66OQ/yjXgWB/BoazaXdJoJt+/a1MmLBUSRDNYYnop76mabG/3fCLd+voZy3i
	8VB7i8aAUZgz4F1MYgNASmUQtYK1v0/85z9A/+fkJhzKviGerEEGGcdtrAB3bBjGqo8VAd1YFXZ
	2Uf4ZXLCXm5UTT/FuLTY27mVHyNLSdyy6gQu3rTMbTDv3XgaAkSlnP3FNrE+rgDrcVsnIWrYh74
	DBHMf6r02txSRQpfQr0uIm4eWHIrYi78yfGO/f1CYpEQ9lU4vMNMBKay2x7puG46HnrO2j/M9yD
	MvoGNdyoORAX65UNZ3mqo9v14z4RY11S6NCxX26Ew6e3V1EB3s1FF4v8cIH2vsH+DunO97rdO+y
	0n2EGwa9lKLNs0PVS0qolQC4AGr+fkDlyN2AbPJS0aJVH3do4ykHuOCeo8mI1lo256YFKRw5QIC
	pYdUw9gcauXXyfoYi8O+E+U9UnjAz+fvrIqKmM3u4+QUkLfO5ymlz8EybvEEBxIaYh3P6/kUKgk
	OZvIfgVyJLjbxD12VM1PphI+eEOwMgNx4mu3Y3gp3L4EGBGi6Zv6YYTDdZlc9q3y/7XOuJp8ikX
	VizPpF9UUifEmPi4oUbpzE84Xtz8UUDzFLmV/GZfDYUmk+jm3TY8mSzZjYnpb3bEkYBK/jjKPyw
	==
X-Received: by 2002:a17:90b:2f8f:b0:3b3:bd07:665b with SMTP id 98e67ed59e1d1-3b41c9325b1mr3860233a91.40.1795207997925;
        Fri, 20 Nov 2026 12:53:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm5594570a91.2.2026.11.20.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 33/49] bpf: Verify a static function once for each instance
Date: Fri, 20 Nov 2026 20:49:41 +0000
Message-ID: <20261120204959.614908-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A chain of calls multiplies the work if each call is verified in the
frames of its caller. 18 levels with 2 calls each are 1 << 18 chains.
A function that cannot get to the frames of its callers is verified on
its own. The old pass united two calls if their states met anywhere in
the function. Then each call got the results of both. Now the states of
two calls meet only at the first insn:

  call1 f(0) --+
  call2 f(1) --+--> first insn

  in pass 0                join         -> one instance
  if r1 is in data_deps    keep apart   -> two instances

An instance is an entry state, its exit states and the calls that wait
for them. So the result of a call goes with its arguments. An instance
that has started does not grow. The join starts a new instance:

  call1 f(0)  instance 1: f(0)     exits 1 -> call1
  call2 f(1)  instance 2: f(0..1)  exits 1 -> call2, call3  at once
  call3 f(2)              f(0..2)  exits 2 -> call2, call3  later

A call waits if it has no exit state to continue with, or if it is in
a peeled trip.

Instances can multiply too. The functions that have more than one
instance divide a budget. When a function has used its part, the next
calls are joined, see flow_may_add_instance().

A function can test a reference of its caller for NULL and return it.
bpf_flow_return() then marks the copies in the caller as not NULL. Else
'if (!n)' drops the reference, and copy still has its id:

  copy = throw_if_null(n);  if (!n) return copy->a;

callx of a set checks each function with a copy of the state. After an
error do_check_block() has to see that copy.

A speculative call gets an instance too. flow_end_instance() frees the
calls that have all exit states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 +-
 kernel/bpf/flow.c            | 313 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  23 ++-
 3 files changed, 334 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c5793f48ad3..54a11c71374 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -607,11 +607,6 @@ struct bpf_verifier_state {
 	 * and their packet pointers are not in the state, see bpf_flow_return().
 	 */
 	bool changed_pkt_data;
-	/*
-	 * Not zero in a function that is verified on its own: the call that the
-	 * state at its entry came from, see bpf_flow_call().
-	 */
-	u32 flow_entry;
 	);
 	/* Not zero in a function that is verified on its own, see bpf_flow_call() */
 	u32 instance_id;
@@ -1143,6 +1138,7 @@ struct bpf_subprog_info {
 	u32 callx_edge; /* 1 + the first of its env->callx_edges, 0 if none */
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u32 deepest_insn; /* the insn that set stack_depth */
+	u32 first_exit; /* see bpf_flow_exit() */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u16 arena_stack_depth; /* size of the frame in the stack in arena */
@@ -1374,6 +1370,7 @@ struct bpf_verifier_env {
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_needs_guard() */
+	bool calls_joined;		/* see flow_may_add_instance() */
 	bool extra_values;		/* a state can have constants that no run has */
 	bool new_linear_xreg;		/* see bpf_same_insns_unproven() */
 	bool seen_direct_write;
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c10fa54cdf9..b5d65dd2d07 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -86,8 +86,11 @@ struct flow_instance {
 	u32 pending_cnt;		/* states */
 	/* calls from this instance that can get more exit states, and those that call itself */
 	u32 open_call_cnt, self_call_cnt;
+	struct flow_group *group;
+	struct flow_instance *next_in_group;
 	u64 *cost;			/* of its function, see flow_may_add_instance() */
 	bool in_peeled_trip;		/* a call of it, or of a caller, is in a peeled trip */
+	bool replaced;			/* no new call finds it, see flow_grow_instance() */
 	bool ended;			/* see flow_end_instance() */
 	struct flow_instance *next;
 	struct list_head waiting_calls;	/* calls of this instance */
@@ -645,6 +648,7 @@ static void flow_clear_pending(struct bpf_flow *flow, struct flow_state *s)
 		return;
 	rb_erase_cached(&s->rb, &flow->pending);
 	flow_state_instance(flow, s)->pending_cnt--;
+	flow_state_instance(flow, s)->group->busy_cnt--;
 	s->pending = false;
 }
 
@@ -659,6 +663,7 @@ static void flow_unlink(struct bpf_verifier_env *env, struct flow_state *s)
 		instance = flow_state_instance(env->flow, s);
 		instance->open_call_cnt--;
 		instance->self_call_cnt -= instance == s->callee;
+		instance->group->busy_cnt -= instance->group != s->callee->group;
 		s->callee = NULL;
 	}
 	if (!RB_EMPTY_NODE(&s->tree_node))
@@ -697,6 +702,7 @@ void bpf_flow_reset(struct bpf_verifier_env *env)
 	for (i = 0; i < flow->instance_cnt; i++)
 		flow_free_list(env, &flow->instances[i]->waiting_calls);
 	for (i = 0; i < flow->instance_cnt; i++) {
+		flow->instances[i]->group->instances = NULL;
 		kfree(flow->instances[i]);
 	}
 	env->mem -= flow->instance_cnt * INSTANCE_BYTES;
@@ -793,6 +799,7 @@ static void flow_set_pending(struct bpf_verifier_env *env, struct flow_state *s)
 	s->order_len = i + 1;
 	s->pending = true;
 	instance->pending_cnt++;
+	instance->group->busy_cnt++;
 	rb_add_cached(&s->rb, &flow->pending, flow_less);
 }
 
@@ -950,6 +957,7 @@ static bool flow_loop_is_left(struct flow_state *s, const struct flow_state *nex
 static struct flow_instance *flow_new_instance(struct bpf_verifier_env *env,
 					       struct flow_state *entry)
 {
+	const struct bpf_func_state *f = entry ? entry->st.frame[0] : NULL;
 	struct bpf_flow *flow = env->flow;
 	struct flow_instance **instances, *instance;
 	u32 cap;
@@ -969,6 +977,11 @@ static struct flow_instance *flow_new_instance(struct bpf_verifier_env *env,
 	INIT_LIST_HEAD(&instance->exit_states);
 	INIT_LIST_HEAD(&instance->done);
 	instance->entry_state = entry;
+	instance->group = flow->groups;
+	if (f && f->loop_stack_cnt && !f->loop_stack->peeled)
+		instance->group += env->subprog_info[f->subprogno].cycle;
+	instance->next_in_group = instance->group->instances;
+	instance->group->instances = instance;
 	env->mem += INSTANCE_BYTES;
 	instance->id = flow->instance_cnt++;
 	flow->instances[instance->id] = instance;
@@ -1345,6 +1358,301 @@ int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 	return flow_add(env, s, false);
 }
 
+/* @x is an exit state of the instance of the call @w. @w can leave the instance. */
+static int flow_apply_exit(struct bpf_verifier_env *env, struct flow_state *w,
+			   struct flow_state *x)
+{
+	int call_idx = w->st.insn_idx, err;
+	struct bpf_verifier_state st = {};
+
+	err = bpf_copy_verifier_state(env, &st, &w->st) ?:
+	      bpf_flow_return(env, &st, &x->st, call_idx);
+	if (!err)
+		err = bpf_flow_deliver(env, &st, call_idx + 1, call_idx, false);
+	else if (err < 0 && st.speculative)
+		err = min(bpf_flow_edge_unproven(env, &st, call_idx + 1, err), 0);
+	else if (err < 0)
+		err = min(bpf_flow_edge_unproven(env, &x->st, x->prev_insn_idx, err), 0);
+	bpf_free_verifier_state(env, &st, false);
+	if (err <= 0)
+		return err;
+
+	/* The call is checked again in the frames of the caller */
+	flow_unlink(env, w);
+	flow_find(env, w);
+	flow_link(env, w);
+	return 0;
+}
+
+/* The arguments that are readable */
+static u64 flow_readable_args(const struct bpf_func_state *f)
+{
+	u64 mask = 0;
+	u32 i;
+
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		mask |= (u64)(f->regs[i].type != NOT_INIT) << i;
+	for (i = 0; i < f->out_stack_arg_cnt; i++)
+		mask |= (u64)(f->stack_arg_regs[i].type != NOT_INIT) << (MAX_BPF_REG + i);
+	return mask;
+}
+
+/* The exit states of @old are exit states of @instance too */
+static int flow_copy_exit_states(struct bpf_verifier_env *env, struct flow_instance *instance,
+				 struct flow_instance *old)
+{
+	struct flow_state *x, *copy;
+	int err;
+
+	list_for_each_entry(x, &old->exit_states, node) {
+		if (x->pending)
+			continue;
+		copy = flow_new_state(env, x->prev_insn_idx);
+		if (!copy)
+			return -ENOMEM;
+		err = bpf_copy_verifier_state(env, &copy->st, &x->st);
+		if (err) {
+			flow_free_state(env, copy);
+			return err;
+		}
+		copy->kind = FLOW_FUNC_EXIT;
+		copy->st.instance_id = instance->id;
+		flow_find(env, copy);
+		flow_insert(env, copy);
+	}
+	return 0;
+}
+
+/* @s gets to the first insn. @t is there and does not subsume @s. */
+static int flow_grow_instance(struct bpf_verifier_env *env, struct flow_state *t,
+			      struct flow_state *s, struct bpf_loop *leftover_loop)
+{
+	u64 args = flow_readable_args(t->st.frame[0]);
+	struct flow_instance *old = t->started_instance, *instance = old;
+	int err;
+
+	if (!old->entry_state) {
+		instance = flow_new_instance(env, t);
+		if (!instance)
+			return -ENOMEM;
+		instance->cost = old->cost;
+	}
+	flow_unlink(env, t);
+	err = bpf_states_join(env, &t->st, &s->st, leftover_loop ?: &env->flow->call_loop,
+			      instance != old);
+	t->started_instance = instance;
+	flow_find(env, t);
+	flow_link(env, t);
+	if (args != flow_readable_args(t->st.frame[0]))
+		flow_free_list(env, &instance->exit_states);
+	else if (!err && instance != old)
+		err = flow_copy_exit_states(env, instance, old);
+	old->replaced = instance != old;
+	if (old->ended)
+		flow_free_list(env, &old->exit_states);
+	return err;
+}
+
+/*
+ * A chain of calls multiplies the instances. The functions that have more than one instance
+ * divide a budget. When a function has used its part, the next calls are joined.
+ */
+static bool flow_may_add_instance(struct bpf_verifier_env *env, int subprog)
+{
+	struct bpf_flow *flow = env->flow;
+
+	if (flow->cost[subprog] * flow->budget_func_cnt <= flow->budget)
+		return true;
+	env->calls_joined = true;
+	return false;
+}
+
+static bool flow_in_peeled_trip(const struct bpf_verifier_state *st)
+{
+	const struct loop_stack_entry *e;
+	u32 fr, i;
+
+	for (fr = 0; fr <= st->curframe; fr++)
+		for (i = 0, e = st->frame[fr]->loop_stack; i < st->frame[fr]->loop_stack_cnt; i++)
+			if (e[i].peeled && e[i].loop->kind != BPF_LOOP_RECURSION)
+				return true;
+	return false;
+}
+
+/*
+ * The call at @call_idx in @caller goes to a function that is verified on its own. @entry is
+ * the state at its first insn. Both states are taken. The first insn is the only join point
+ * for the states of two calls.
+ *
+ *  call1 f(0) --+                       pass 0: join          -> one instance for both calls
+ *  call2 f(1) --+--> first insn of f    data dep r1 differs   -> one instance for each call
+ *
+ * An instance that has started does not grow. The join starts a new instance:
+ *
+ *  call1 f(0)   instance 1: f(0)      exits 1 --> call1
+ *  call2 f(1)   instance 2: f(0..1)   exits 1 --> call2, call3   at once: the caller continues
+ *  call3 f(2)               f(0..2)   exits 2 --> call2, call3   later, if they have more
+ *
+ * An argument can have another type or object. Then the old exit states can refer to what the
+ * new call did not pass in, so the call waits. It waits in a peeled trip too: a late exit state
+ * checks all later trips again.
+ */
+int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		  struct bpf_verifier_state *entry, int subprog, int call_idx)
+{
+	struct loop_stack_entry *e = bpf_top_loop(entry->frame[0]);
+	struct bpf_loop *leftover_loop = e && e->trip && !e->peeled ? e->loop : NULL;
+	struct flow_instance *instance, *from = env->flow->instances[caller->instance_id];
+	u64 *cost = &env->flow->cost[subprog];
+	struct flow_state *w, *s, *t, *tn, *x;
+	bool subsumed;
+	int err;
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "call at %d waits for func#%d\n", call_idx, subprog);
+
+	s = flow_new_state(env, call_idx);
+	if (!s)
+		return -ENOMEM;
+	swap(s->st, *entry);
+	s->st.insn_idx = env->subprog_info[subprog].start;
+	s->st.last_insn_idx = call_idx;
+	s->kind = FLOW_FUNC_ENTRY;
+	err = bpf_clean_verifier_state(env, &s->st);
+	if (err)
+		goto free;
+again:
+	flow_for_each_near(env, s, t, tn) {
+		if (!flow_same_join_key(env, t, s) ||
+		    bpf_must_keep_apart(env, &t->st, &s->st, s->kind == FLOW_JOINED_CALLS ||
+					(leftover_loop && flow_same_entry(leftover_loop, t, s)) ?
+					BPF_JOIN_POINT_HEADER : BPF_JOIN_POINT_CALLS,
+					leftover_loop ? e : NULL))
+			continue;
+		subsumed = bpf_state_subsumes(env, &t->st, &s->st);
+		if (!subsumed && t->st.speculative != s->st.speculative)
+			continue;
+		env->imprecise |= !env->err;
+		if (!subsumed)
+			err = flow_grow_instance(env, t, s, leftover_loop);
+		flow_free_state(env, s);
+		if (err)
+			return err;
+		goto wait;
+	}
+	if (s->kind == FLOW_FUNC_ENTRY && !flow_may_add_instance(env, subprog)) {
+		s->kind = FLOW_JOINED_CALLS;
+		goto again;
+	}
+	t = s;
+	t->started_instance = flow_new_instance(env, t);
+	if (!t->started_instance) {
+		err = -ENOMEM;
+		goto free;
+	}
+	/* the first instance is free */
+	if ((*cost)++)
+		t->started_instance->cost = cost;
+	env->flow->budget_func_cnt += *cost == 2;
+	flow_link(env, t);
+wait:
+	w = flow_new_state(env, caller->last_insn_idx);
+	if (!w)
+		return -ENOMEM;
+	swap(w->st, *caller);
+	w->st.insn_idx = call_idx;
+	instance = w->callee = t->started_instance;
+	from->open_call_cnt++;
+	from->self_call_cnt += from == instance;
+	from->group->busy_cnt += from->group != instance->group;
+	flow_insert(env, w);
+	instance->in_peeled_trip |= t->kind == FLOW_FUNC_ENTRY &&
+				    (from->in_peeled_trip || flow_in_peeled_trip(&w->st));
+	if (instance->entry_state &&
+	    (list_empty(&instance->exit_states) || instance->in_peeled_trip))
+		flow_set_pending(env, w);
+	list_for_each_entry(x, &instance->exit_states, node)
+		if (!err && !x->pending && w->callee)
+			err = flow_apply_exit(env, w, x);
+	if (instance->ended && w->callee)
+		flow_free_state(env, w);
+	return err;
+free:
+	flow_free_state(env, s);
+	return err;
+}
+
+/* @st came to exit of the function that is verified on its own. It is taken. */
+int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[st->frame[0]->subprogno];
+	struct loop_stack_entry *e = bpf_top_loop(st->frame[0]);
+	struct flow_state *x;
+	int err;
+
+	st->insn_idx = exit_idx;
+	err = bpf_clean_verifier_state(env, st);
+	if (err)
+		return err;
+	x = flow_new_state(env, exit_idx);
+	if (!x)
+		return -ENOMEM;
+	x->st = *st;
+	memset(st, 0, sizeof(*st));
+	/* all exit states are compared at the first exit */
+	sub->first_exit = sub->first_exit ?: exit_idx;
+	x->st.insn_idx = sub->first_exit;
+	x->kind = FLOW_FUNC_EXIT;
+	return flow_prune_or_join(env, x, e && !e->peeled ? e->loop : NULL, false);
+}
+
+static void flow_add_ended(struct flow_instance *instance, struct flow_instance **ended)
+{
+	if (instance->ended)
+		return;
+	instance->ended = true;
+	instance->next = *ended;
+	*ended = instance;
+}
+
+/*
+ * A state of @instance comes from another state of it, or from an exit state that one of its
+ * open calls gets. If there is none of these, @instance ended. The same holds for a group.
+ * The instances in the leftover of a recursion are a group: they can wait for each other.
+ * All other instances are group 0.
+ */
+static void flow_find_ended(struct flow_instance *instance, struct flow_instance **ended)
+{
+	struct flow_group *group = instance->group;
+
+	if (!instance->pending_cnt && instance->open_call_cnt == instance->self_call_cnt)
+		flow_add_ended(instance, ended);
+	while (!group->busy_cnt && group->instances) {
+		flow_add_ended(group->instances, ended);
+		group->instances = group->instances->next_in_group;
+	}
+}
+
+/* If an instance ended, its waiting calls have all exit states */
+static void flow_end_instance(struct bpf_verifier_env *env, struct flow_instance *instance)
+{
+	struct flow_instance *from, *ended = NULL;
+	struct flow_state *w, *wn;
+
+	flow_find_ended(instance, &ended);
+	while ((instance = ended)) {
+		ended = instance->next;
+		list_for_each_entry_safe(w, wn, &instance->waiting_calls, node) {
+			from = flow_state_instance(env->flow, w);
+			flow_free_state(env, w);
+			flow_find_ended(from, &ended);
+		}
+		flow_free_list(env, &instance->done);
+		if (instance->replaced)
+			flow_free_list(env, &instance->exit_states);
+	}
+}
+
 /*
  * Make the next pending state the current one. env->cur_state has to be empty.
  * Returns -ENOENT when nothing is pending.
@@ -1362,6 +1670,8 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 	if (flow->last_instance && flow->last_instance->cost)
 		*flow->last_instance->cost += env->cost - flow->charged_cost;
 	flow->charged_cost = env->cost;
+	if (flow->last_instance)
+		flow_end_instance(env, flow->last_instance);
 	n = rb_first_cached(&flow->pending);
 	if (!n)
 		return -ENOENT;
@@ -1389,6 +1699,9 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 	env->insn_idx = s->st.insn_idx;
 	if (s->kind == FLOW_FUNC_EXIT) {
 		list_for_each_entry_safe(t, tn, &instance->waiting_calls, node) {
+			err = flow_apply_exit(env, t, s);
+			if (err)
+				return err;
 		}
 		goto again;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fac44fceccf..58a483fed88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1809,11 +1809,11 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 		return err;
 	bpf_add_cost(env, bpf_xreg_cnt(src) + src->acquired_refs, BPF_COST_COPY);
 	dst_state->speculative = src->speculative;
-	dst_state->flow_entry = src->flow_entry;
 	dst_state->infeasible = src->infeasible;
 	dst_state->max_held_cnt = src->max_held_cnt;
 	dst_state->suspect_loops = src->suspect_loops;
 	dst_state->join_key = src->join_key;
+	dst_state->instance_id = src->instance_id;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	for (i = 0; i <= src->curframe; i++) {
@@ -10931,7 +10931,7 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 			mark_reg_invalid(env, reg);
 		}
 	}));
-	if (env->cur_state->flow_entry)
+	if (env->cur_state->instance_id)
 		env->cur_state->changed_pkt_data = true;
 }
 
@@ -11515,7 +11515,7 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
 	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
 		return false;
-	if (state->speculative)
+	if (env->path_sensitive)
 		return false;
 	if (sub->releases_inherited &&
 	    (state->acquired_refs || state->active_rcu_locks || state->active_preempt_locks))
@@ -11560,6 +11560,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	if (!callee)
 		return -ENOMEM;
 	entry.frame[0] = callee;
+	entry.speculative = state->speculative;
 	entry.in_sleepable = state->in_sleepable;
 	entry.suspect_loops = state->suspect_loops;
 	entry.callers_unknown = state->callers_unknown;
@@ -11628,6 +11629,8 @@ static int exit_func_on_its_own(struct bpf_verifier_env *env)
 	return err ?: PROCESS_BPF_EXIT;
 }
 
+static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno, bool is_null);
+
 static u32 returned_id(u32 id)
 {
 	return bpf_id_is_xreg(id) ? BPF_RETURNED_ID(id) : id;
@@ -11646,6 +11649,7 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 	struct bpf_reg_state *reg;
 	int err;
 
+	caller->speculative |= exit->speculative;
 	/*
 	 * Keep only what the function held all the time. The state at its exit looks the same if
 	 * the function released a lock and acquired it again. Else verify the function in the
@@ -11676,6 +11680,8 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 	 * the packet pointers of the caller is found out in the context of the caller.
 	 */
 	if (exit->changed_pkt_data) {
+		if (exit->speculative)
+			return -EACCES;
 		env->subprog_info[callee->subprogno].changes_pkt_data = true;
 		return BPF_EXIT_NEEDS_CALLER;
 	}
@@ -11700,6 +11706,9 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		reg->id = returned_id(reg->id);
 		reg->parent_id = returned_id(reg->parent_id);
 		reg->map_uid = returned_id(reg->map_uid);
+		/* the function saw that a reference of the caller is not NULL */
+		if (reg->id && !type_may_be_null(reg->type))
+			mark_ptr_or_null_regs(caller, ret_regs[i], false);
 	}
 	return 0;
 }
@@ -11984,6 +11993,9 @@ static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *in
 			env->cur_state = copy;
 			err = check_func_callx_one(env, set->subprog[i], insn_idx);
 			env->cur_state = cur;
+			/* do_check_block() looks at the state that failed */
+			if (err < 0)
+				swap(*cur, *copy);
 		}
 		bpf_free_verifier_state(env, copy, true);
 		if (err == PROCESS_BPF_EXIT)
@@ -20331,7 +20343,7 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur_frame = cur_func(env);
 
-	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
+	if (!exception_exit && !env->cur_state->curframe && env->cur_state->instance_id)
 		return exit_func_on_its_own(env);
 
 	/* We must do check_reference_leak here before
@@ -21529,6 +21541,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		from_unproven = reads_from_unproven(env);
 		fixups = insn_aux->fixups;
 		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
+		/* a call or an exit gave the state to the flow, the error is from there */
+		if (err < 0 && !state->frame[0])
+			return err;
 		insn_aux->releases |= held_cnt(state) < held && err != PROCESS_BPF_EXIT;
 		insn_aux->acquires |= held_cnt(state) > held;
 		if (nospec_ends_path(env, state, err)) {
-- 
2.55.0

