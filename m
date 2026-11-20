Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208035;
	b=MARJNfB7PNveVOhXsw6F3o9MDeagQwM/ViiWDiUmZWOmg8/YoquztiVuDn54nBaNpMmS
	 ZytjoJr4ezeiGl4F9L/qTCiES9LzijZD3P8earw0dkFfvQJjogCYQVTs8qiWn3eBk3XJ0
	 ygc5/kt6HPQzDwSLNCaDJqSyUml77mEpqLTvmXnv0mRBfn/bA6cktWSGGS6yFnmhebxpq
	 S9y7To1rJMBiMale7f2I7IPXRX5ThSu/mD228MjI7EGByZkUQHdKmbXw7Hs9R889TMrtW
	 ZhdXig6NBl0h1EAy7JgVJX5ghoUeq66DL0LkqEUHZf7EscFPpmqVvHq6Ao06h2MVLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XXcibJu1PWJTrpaT3JQiQ75biDxYpAA2Mo5a5oecrew=;
	b=V+9EPlxcweJKMCefdD3XX77NNaidNIoFSzJ+DiiluOmI70+ri03ww+OdGGzYXSpKt9cf
	 E8iImtGqVfMQZdmfYOueiXXC6YWXBJnq6AR+jadOgNwRLy9bW7bTa2mLtHeNoMuFuM2Du
	 471O87LFjGbK9SiDVAW0NJyIXr/rfPqq3VFIFULYt873NF5oxwXvNaZw1b3lzbXgYpW4r
	 tEyYswLPgNAJHV7QqN9ijJp+4gYAuoWQy1qm+qOdRpns7aja+Y/WdTR9GU1zYZDq01niO
	 6OY3TM1HUHHd7jdbL+SKj6u1aBZAIMjfFK6She9sfqcj204x0o4xrILo/n3/9GUGjlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gFT5hRtS;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A794606A69C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A794606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gFT5hRtS
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso604922a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208033; x=1795812833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXcibJu1PWJTrpaT3JQiQ75biDxYpAA2Mo5a5oecrew=;
        b=gFT5hRtSKak1Dj5nAMoqCminkWfKY1onF6UqeiGROMYyx9cefXcikorm4Tpan4tmNc
         I2KBPZYkZn9XHYEeECDB4DcRfSNlkDsrlcyoPJ1szDovHYBMvi7WvpKZyj7O3v6Jh0aH
         MNGFhxIY62YyLfctbQNliJHuLZ564n9HlGgtXbe9ViUiprzZvrH3KznI+CeHZnsbDzwZ
         X4+DPMBrfciDzPd8yV4yxRUuz0L/BWxBFvCv3IDNrO5aN8uVw9D8kxMQI90pTASyhcj5
         9GNurXD6f1hHqWJhXDHVSQ99oO906NN3poSEUl3J3Ue7nhXfhXpvSlUrvgzSIG07Hyr/
         YvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208033; x=1795812833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXcibJu1PWJTrpaT3JQiQ75biDxYpAA2Mo5a5oecrew=;
        b=TkTZqYfGMarT9y5MRHfDS0Vargh6DXkNQSpFOxELZWtZxwjPwN1YfjomUZoDE4ffPR
         JsggQlJJ6iAO70iBDw+X5AdPqKhYw/Fcdzj9Q/lnv7vYknmtt29OVa4wDkGUqKxQSFXP
         o/09gpkuuJveHnFuwgueh53g6u65S+UfykYb5zgoLvnPPQjmEgOqiG8NvIJ3ZPzSTH2J
         roAMtjLUDMV+/deQD/a+s93of0NzIR+qpBliQmOIt53mjrBLhwL28gwbJynPjdIuMDDH
         0IR86UvOXGxbsYzel9VVCPp7S/QYNpP1Kinv0FSsFIBuhPCkzKKjFQAiO3Nv0iFYQEwH
         bA2Q==
X-Gm-Message-State: APuU4Z90xNUEdkcbILGPwphZ3zl92yah4vAzipIAJbrpO8NQABz/RImf
	fr8jIg+tbxlctqk+NyrV+TeuwnX9OgliXWvgT9dBXRVKhVPXUYXRQwzNVDW3Ew==
X-Gm-Gg: AZFdTZeXX8HjyHohAD13vCQ5P9BZ8A0/UNNuyL63UvY2ij3+hqFDNw8wnzItfzAnTC0
	Wzxc2/ECziLlUG9859dye976bOqjXOqRyBotd4SNkso4brIP0zC6WXYZ0bw24pA6YNhX8dMI1bF
	H98dwPclPIdnBMf+FMrygOfQtx8wNE7I9dYJywCbZY/Z5/dvu4PhX/d9biy3AjzyslCYWDd/WG/
	djcH/tWLmLNroOCtppIoIlIXjMxjGnWMKRQtq8ISApkvZCtNMa84zV/aV3ua8AgUu7NENSV15Zw
	PL2suAyywEhmCTrVyISm7wq5PCFWN2tpEJUUcerywR/BTOsmT+LAUjCe49TdYp3l2w5tenoxXRf
	x7YGPb01tP1LqjFe81+APKrTdIkOzurfdiGYXvtRLQgdGsOsVqhS7BDfvmh9X0L/qmGfjo4UeiC
	sBIbK2D2foNs22RJqbOHei6XbZ9yi+BX4QKGpL5VYga2M0pfJtk0/lJIlFv8tVZohd1inOwpC7i
	unyIYwOae8j2E2OV8tgOeGnUfhxk+BKw7P2c+5bKomRPlZQpOAA8tCkqBVQX2kf1hpIj7aXMSyH
	kxQDox0uOCxwlyDqrYU5IcxZu2ZsExqrsyFc6SG7IY5FFMnwFHzgsesFkQ8rO/q+DUIhFDrWKpa
	r4PNiOBHUzIJvlO/BQiUOKP3jTlCuJkoZZW+F4PsKnKzOr/XdXZWBb0pdJnpUDy0ONE9PTTe02w
	==
X-Received: by 2002:a17:90b:5109:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3b41c9bc501mr3710521a91.64.1795208033230;
        Fri, 20 Nov 2026 12:53:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm5507521a91.8.2026.11.20.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 39/49] bpf: Keep two states apart if a live xreg has two types
Date: Fri, 20 Nov 2026 20:49:47 +0000
Message-ID: <20261120204959.614908-40-alexei.starovoitov@gmail.com>
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

Pass 0 joins all states. A join of two types or two objects is
unreadable. If the xreg is live, the program probably reads it. Then the
pass has an error, and the price is two more runs:

  r6 = 0;               r6 = map value;
          \            /
           if (r6 == 0) goto out;

  old:  join -> r6 !read_ok -> path-sensitive run -> pass 1: apart
  new:  pass 0: apart

The same holds for a packet pointer that has checked bytes in one state
and has none in the other state.

bpf_hash_live_types() adds the types and objects of the live xregs to
the hash of a state. So such states do not meet.

- Numbers are joined as before.
- The arguments of the calls of an instance are joined as before, else
  the calls do not share it.
- N such xregs can give 1 << N states. So the rule has a budget in each
  pass: 1/64 of the limits on cost and memory. The cost of a state
  that is alone does not count, see bpf_flow_next(). A pass that is over
  the budget joins from there on, and so do the next passes. Then an
  error selects the xregs.
- Offloaded programs are joined as before. The replay for the driver
  has to join where the good pass did.

                                     insns processed
  program                            before    after
  profiler3 kprobe__vfs_link         7969      3865
  test_cls_redirect_subprogs         5726      3091
  xdp_synproxy_kern syncookie_xdp    8136      7630
  bpf_flow flow_dissector_0          1363      701

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/flow.c            | 18 +++++++++++
 kernel/bpf/precision.c       | 60 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/precision.h       |  3 ++
 4 files changed, 83 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1ddcf6d7c4..47939e49908 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1730,6 +1730,8 @@ bool bpf_must_keep_apart(struct bpf_verifier_env *env, const struct bpf_verifier
 			 const struct loop_stack_entry *entry);
 bool bpf_values_grew_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
 			     const struct bpf_verifier_state *new);
+u64 bpf_hash_live_types(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			u64 hash, u64 apart_cost);
 u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			 u64 hash, bool consts);
 u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 4dbf288f11a..d6f353a7bb2 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -59,6 +59,7 @@ struct flow_state {
 	bool pending;
 	bool returned;			/* FLOW_FUNC_EXIT: the calls have a part of it */
 	bool late_exit_reaches;		/* a late exit state can get to it */
+	bool from_apart;		/* it comes from a state that was not alone */
 	/* it is kept until the states leave this loop, see flow_loop_is_left() */
 	u8 kept_frameno, kept_depth;
 	/* the order of pending states, see flow_set_pending() */
@@ -119,6 +120,7 @@ struct bpf_flow {
 	/* of the pass */
 	u64 *cost;			/* per function */
 	u64 budget, charged_cost;
+	u64 apart_cost;			/* of states that are not alone, see bpf_flow_next() */
 	u32 budget_func_cnt;
 
 	/* of the check */
@@ -129,6 +131,7 @@ struct bpf_flow {
 	struct flow_instance **instances;	/* bpf_verifier_state.instance_id is the index */
 	u32 instance_cnt, instance_cap;
 	struct flow_instance *last_instance;	/* of the last pending state */
+	bool last_is_apart;			/* it adds to @apart_cost */
 	u64 priority_gen;
 	struct list_head unused;		/* struct flow_kept */
 	u32 seq;
@@ -427,6 +430,7 @@ void bpf_flow_new_pass(struct bpf_verifier_env *env)
 	memset(flow->cost, 0, env->subprog_cnt * sizeof(*flow->cost));
 	flow->budget = bpf_precision_budget(env);
 	flow->budget_func_cnt = 0;
+	flow->apart_cost = 0;
 	flow->start_cnt++;
 	for (i = 0; i < env->prog->len; i++, aux++) {
 		if (aux->callback_loop)
@@ -632,6 +636,7 @@ static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_
 	INIT_LIST_HEAD(&s->node);
 	s->prev_insn_idx = prev_insn_idx;
 	s->seq = ++flow->seq;
+	s->from_apart = flow->last_is_apart;
 	s->log_pos = env->log.end_pos;
 	s->diag_pos = bpf_diag_event_log_save(env);
 	bpf_add_cost(env, 1, BPF_COST_STATE);
@@ -724,6 +729,7 @@ void bpf_flow_reset(struct bpf_verifier_env *env)
 	env->mem -= flow->instance_cnt * INSTANCE_BYTES;
 	flow->instance_cnt = 0;
 	flow->last_instance = NULL;
+	flow->last_is_apart = false;
 }
 
 void bpf_flow_free(struct bpf_verifier_env *env)
@@ -871,6 +877,9 @@ static struct flow_state *flow_find(struct bpf_verifier_env *env, struct flow_st
 
 	hash = bpf_hash_apart_xregs(env, &s->st, bpf_hash_join_key(env, &s->st) + s->kind,
 				    s->kind == FLOW_PEELED);
+	/* the arguments are joined, else calls do not share an instance */
+	if (s->kind != FLOW_FUNC_ENTRY && s->kind != FLOW_JOINED_CALLS)
+		hash = bpf_hash_live_types(env, &s->st, hash, env->flow->apart_cost);
 	if (s->kind == FLOW_FUNC_ENTRY && (!e || e->peeled))
 		hash = bpf_hash_args(env, &s->st, hash);
 	if (s->kind == FLOW_AT ? !aux->loop && !aux->callback_loop :
@@ -1729,6 +1738,8 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 again:
 	if (flow->last_instance && flow->last_instance->cost)
 		*flow->last_instance->cost += env->cost - flow->charged_cost;
+	if (flow->last_is_apart)
+		flow->apart_cost += env->cost - flow->charged_cost;
 	flow->charged_cost = env->cost;
 	if (flow->last_instance)
 		flow_end_instance(env, flow->last_instance);
@@ -1738,6 +1749,13 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 	s = rb_entry(n, struct flow_state, rb);
 	flow_clear_pending(flow, s);
 	flow->last_instance = flow_state_instance(flow, s);
+	/*
+	 * Is another state at this insn? In a loop the states go one by one, and only the join
+	 * points of a leftover keep them. So a yes holds up to a join point that is not peeled.
+	 */
+	if (test_bit(s->st.insn_idx, flow->join_points) && !flow_in_peeled_trip(&s->st))
+		s->from_apart = false;
+	flow->last_is_apart = s->from_apart || flow->nr_states[s->st.insn_idx] > 1;
 	instance = s->callee;
 	if (instance) {
 		if (instance->entry_state && !instance->priority) {
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index bb71d31c45c..a33cc8664bc 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -121,6 +121,9 @@ const struct bpf_reg_state *bpf_xreg_value(struct bpf_verifier_env *env,
 	       slot_value(env, f, bpf_xreg_to_spi(xregno), tmp);
 }
 
+/* The budget of bpf_hash_live_types() in one pass */
+#define LIVE_TYPES_PART	64	/* of the limits */
+
 static u64 hash_type(const struct bpf_reg_state *reg, u64 hash)
 {
 	if (type_is_pkt_pointer(reg->type) || base_type(reg->type) == PTR_TO_ARENA)
@@ -128,6 +131,54 @@ static u64 hash_type(const struct bpf_reg_state *reg, u64 hash)
 	return bpf_hash64(reg, offsetof(typeof(*reg), var_off), hash);
 }
 
+/*
+ * A join of two types or objects is unreadable. A join of a packet pointer that has checked
+ * bytes with one that has none gives no access. If the xreg is live, an error is probable, and
+ * the price is one more pass. So such states stay apart from the start:
+ *
+ *	r6 = 0;				r6 = map value;
+ *		\			/
+ *		 if (r6 == 0) goto out;		two states
+ *
+ * N such xregs can give 1 << N states. If a pass is over the budget, it joins from there on,
+ * and so do the next passes. Then an error selects the xregs, see add_deps().
+ * @apart_cost: the cost of this pass without the states that were alone.
+ */
+u64 bpf_hash_live_types(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			u64 hash, u64 apart_cost)
+{
+	struct bpf_precision *prec = env->precision;
+	const struct bpf_insn_aux_data *aux;
+	const struct bpf_reg_state *reg;
+	unsigned long live[XREG_WORDS];
+	struct bpf_reg_state tmp;
+	u32 fr, xregno, bits;
+
+	if (env->path_sensitive)
+		return hash;
+	prec->live_types_over |= apart_cost > prec->live_types_cost ||
+				 env->mem > prec->start_mem + prec->live_types_mem;
+	for (fr = 0; !prec->live_types_over && fr <= st->curframe; fr++) {
+		aux = &env->insn_aux_data[bpf_frame_insn_idx(st, fr)];
+		bits = bpf_spi_to_xreg(bpf_stack_nr_slots(st->frame[fr]));
+		bitmap_zero(live, bits);
+		live[0] = aux->live_regs_before & XREG_REGS;
+		bpf_add_slots(live, aux->live_stack_before, bits);
+		bpf_add_cost(env, bitmap_weight(live, bits), BPF_COST_COPY);
+		for_each_set_bit(xregno, live, bits) {
+			reg = bpf_xreg_value(env, st->frame[fr], xregno, &tmp);
+			/* a slot with no spill hashes like a slot that is not allocated */
+			if (!reg || reg == &tmp || reg->type == SCALAR_VALUE)
+				continue;
+			hash = hash_type(reg, hash + fr * MAX_BPF_XREG + xregno);
+			if (type_is_pkt_pointer(reg->type) && pkt_has_bytes_left(reg) &&
+			    pkt_bytes_left(reg) > 0)
+				hash = ~hash;
+		}
+	}
+	return hash;
+}
+
 /*
  * States with another type or object in data_deps stay apart. Hash these like the join_key.
  * @consts: find a state with the same constants in all deps.
@@ -1396,6 +1447,7 @@ bool bpf_undo_precision(struct bpf_verifier_env *env)
 		return false;
 	}
 	env->over_limit = false;
+	prec->live_types_over = false;
 	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));
 	for (i = 0; i < prec->loop_cnt; i++)
 		over_budget |= prec->loops[i]->partitioned &&
@@ -1568,7 +1620,11 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env)
 		prec->partitioned_by = prec->pass_cost = 0;
 	}
 	prec->budget_grew = prec->new_nospec = false;
+	/* the pass for the log has to join where the last pass did */
+	prec->join_live_types |= prec->live_types_over && !env->for_log;
+	prec->live_types_over = prec->join_live_types;
 	prec->start_cost = env->cost;
+	prec->start_mem = env->mem;
 	prec->last_unproven_left = bitmap_weight(prec->last_unproven_insns, env->prog->len);
 	/* ADD_DEPS has no alternative, so it has no limit of its own */
 	if (prec->partitioned_by > BIT(PARTITION_ADD_DEPS) && !env->replay)
@@ -1625,6 +1681,10 @@ int bpf_precision_init(struct bpf_verifier_env *env)
 	prec->this_pass.unproven_funcs = bits + 16 * words;
 	prec->last_pass.unproven_funcs = bits + 17 * words;
 	prec->pass_cost = env->cost;
+	prec->live_types_cost = env->max_cost / LIVE_TYPES_PART;
+	prec->live_types_mem = env->max_mem / LIVE_TYPES_PART;
+	/* the replay for the driver has to join where the good pass did */
+	prec->join_live_types = bpf_prog_is_offloaded(env->prog->aux);
 	prec->budget_left = prec->budget = bpf_precision_first_budget(env);
 	prec->first_unproven_insn = prec->loop_carried_at = U32_MAX;
 	for (i = 0; i < env->prog->len && !err; i++, aux++)
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index f833b4642bc..3af6f10eed7 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -67,6 +67,9 @@ struct bpf_precision {
 	bool failing_path_due;		/* see bpf_failing_path_is_due() */
 	bool budget_grew;		/* see partition_next() */
 	bool new_nospec;
+	/* see bpf_hash_live_types() */
+	u64 live_types_cost, live_types_mem, start_mem;
+	bool live_types_over, join_live_types;	/* in this pass, in all next passes */
 
 	u16 *apart_xregno;	/* per insn, see bpf_range_of_data_dep() */
 
-- 
2.55.0

