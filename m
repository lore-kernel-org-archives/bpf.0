Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160903;
	b=AB49mOEtrSp+xGju2e348RhUlLsL5Hxr9C2ZG7v/GHouxgNw0Nz+fL01Lz5fg7rEWfd9
	 5XpkGN9jC/tbBXiaTiptiiXGQQZPHNxbQZujD261VpkR1YBNMeqyzM0pZN/ah+1pvHl3U
	 AMYP4lt/bDXwYTzZhU0qgAvc3kMhc/OU1ARYDihuUpo1jJTtd6VruqerAHdcHGDdze128
	 3OO1yp8ZX6cYqinN6Y0EEC8SG2HvNSGY8xWU/JvLG2V89sfTzBESh3S4HLvnnasFdTMkt
	 pqKep18DYJr8U0sSV7LcIyNfmlffoUs7SEIvI6DXDrtWdNIQmAHJBTod6XTngKp6eIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6GLZgQtRmtgJfgUMKWo0TvVtv6zO0Fhq9W3NUx7qLUw=;
	b=2ET/cCKfd0vcIRSNZQaFoHOr3oed85F7QbMI4KuZeN0r1eEnLhLHJs4trxxhxyJ2OgmO
	 J0zm3vZVw/Lj/Gazkek+m8CkxAJxXrlYlPHv7SYivXJ2GaWraJzcw4DUYMe3XY83qDJMp
	 tLnrm4jjrRI9vaQwBfCCRrpOJClwkN1oWVp/3+W1h7ioctL9uJrWVUxCfla8q/PuyKl0s
	 L7Hk0iL8YD2a+YJmry0flmWugTAgi+0MC6pFqZMsDG1nF1BS6n3GEfbg7tv0Ne/fUHHqt
	 5e/mMISChXWdRPZ9pA+zyZ7sNfL7S5fP/A1NBtTrrFW7ysCUvbmaCv2GhOenbfUZFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s+VyJ0f8;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BE606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s+VyJ0f8
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b271e573adso299698b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160902; x=1795765702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GLZgQtRmtgJfgUMKWo0TvVtv6zO0Fhq9W3NUx7qLUw=;
        b=s+VyJ0f8PBsdqF9lFUYfe4DrXSwSgbK7jq6EQULKdITyVH/9NHSZKsz7QuhRWM3fE7
         /JusAIK3nw8hXWanmzwKQmqlPfxrtCAIAvpXKGyhSSSOuHhBsS3wZARESR4I20Ey+pwz
         mUR/V299QshUr8cjLgir1HVRZTF9FQVcTbmUwVhPr0KPSrGxuy482jfgqytrqF+29hI2
         t/b6Uim16JJg4hhwjAHuuc8An/ip4/+gtGEtf7xVd2IjG+9ybTZ7s5srE4nOx4bCeij0
         iOfVIOXv8nIxfDfFg0FoxLTgkZ6s4MIi+v0gmjgVRQjhU1vtx+P8s9L5isT3ZeB/RJiZ
         Gbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160902; x=1795765702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GLZgQtRmtgJfgUMKWo0TvVtv6zO0Fhq9W3NUx7qLUw=;
        b=y9OOnKiQ/KbGZ+qwNkYKIzz9ohkyND99UYJ+My4sY6iGRnVtu3yuP9u2I454DY/s6I
         SmOHu8oj2yEK3HGwaZbRofFTeXQcxr99HVQgBxkmMs4Ja301js/AbZQeIWKj7w0hiPl3
         WDJbFDy1nIcjUzUzHc46AXint0N/P4OZ+eFTrO3QLWwpb/py8l6XYGU11lE68/uihNqO
         xs7PrFqEsSnaq2WLZgbMpshEN8S/I7+UK05iUZgDnIXepp06JPjVP95ln6dPLazTutTg
         5UfxRsJo/wuPG4WsYliV9HPxQWyLnjQ1cLdnAO47PJ+avIms0GoFySMICxGQ8gpH2ozJ
         qYkQ==
X-Gm-Message-State: APuU4Z9kqu7+DPDmANY4gzOpdzBvM8C0/EK8wE7Se9JJ3ZDnb6lTakbX
	c/x/6F4yxLlus1anIFN+VHfU6g5uHw+naLa/P7gOwafVo2lEJoz/aeVhIlxzDw==
X-Gm-Gg: AZFdTZdYFRiQ00dOVu+UbzDhjaF3sDTK3mwFE70we6ZflvjYqtYpeMs7GTe8A2RLqsA
	5HA+Maz5YYBhrU9bo1YH3BPZV/JevasglfWpHXu00/FWIHveEeGK4k5Zb3WDywJFJpT42ftsx7k
	db5E5FK6iMlTH9RgpEjaZVICYFfOunQ7DPwvH6odyW33LkIML+p98F9gXqL52Cez3MIKGzMA++o
	sV/9Yb3u3Ey33YhEIYAzVGEBOFpbCTafJ6AOMHefALQqANTvkc/cXVKmnC6TilyCCL6Y7zOOGUZ
	2r1QVSV8G2sjC04bJvXiTx3VIRGKj8Hcl0nNlVDy4tZXgzZ9ECe9hzC/H7dtMHIkCl1rVyyoiI1
	1roL2axaSz/5aV2KM8MLclrD+eQIpW20vuRriO4rpO2O2R9SpAkBv4sD8nBLLYEBXtUE5Uv0e0T
	39Fsy+A/RGtvA8G4uzV/K7+rXGYmzGn/GtTHofp4usBbcJ5SG8B3rWj1n6KzwtoCuHWmtE58+Da
	6MegVIoYoUbe6sYqJlao+ybaA07GTSDAVB9UCaD+8Kg/m3xNaHQU75wogJ4XVZB1ww56IGWL/xz
	Tg1WYD4rejiJMD0cLOhNoSXvYhV+0LBSjm6aO/VoF7qb06hUZdlODc48/ZyD8Pr5UeQXzSQtOet
	Ac3CNwRbPgoMPRSxS5+ch8h6h+bo5xvu2Ui3LWls6aI5TcNmRFHsZ3YPgpKQLBSID25/7onah/w
	==
X-Received: by 2002:a05:6a00:1911:b0:881:158b:ea8c with SMTP id d2e1a72fcca58-8c87bfa7787mr2286433b3a.26.1795160901638;
        Thu, 19 Nov 2026 23:48:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8707792e8sm1135712b3a.7.2026.11.19.23.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 39/49] bpf: Keep two states apart if a live xreg has two types
Date: Fri, 20 Nov 2026 07:42:11 +0000
Message-ID: <20261120074430.2704488-40-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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
index 40faa1b3f39..ba31a2e45fc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1729,6 +1729,8 @@ bool bpf_must_keep_apart(struct bpf_verifier_env *env, const struct bpf_verifier
 			 const struct loop_stack_entry *entry);
 bool bpf_values_grew_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
 			     const struct bpf_verifier_state *new);
+u64 bpf_hash_live_types(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			u64 hash, u64 apart_cost);
 u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			 u64 hash, bool consts);
 u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index a1ac4709b68..ffae6cf95f9 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -58,6 +58,7 @@ struct flow_state {
 	enum flow_kind kind;
 	bool pending;
 	bool late_exit_reaches;		/* a late exit state can get to it */
+	bool from_apart;		/* it comes from a state that was not alone */
 	/* it is kept until the states leave this loop, see flow_loop_is_left() */
 	u8 kept_frameno, kept_depth;
 	/* the order of pending states, see flow_set_pending() */
@@ -118,6 +119,7 @@ struct bpf_flow {
 	/* of the pass */
 	u64 *cost;			/* per function */
 	u64 budget, charged_cost;
+	u64 apart_cost;			/* of states that are not alone, see bpf_flow_next() */
 	u32 budget_func_cnt;
 
 	/* of the check */
@@ -128,6 +130,7 @@ struct bpf_flow {
 	struct flow_instance **instances;	/* bpf_verifier_state.instance_id is the index */
 	u32 instance_cnt, instance_cap;
 	struct flow_instance *last_instance;	/* of the last pending state */
+	bool last_is_apart;			/* it adds to @apart_cost */
 	u64 priority_gen;
 	struct list_head unused;		/* struct flow_kept */
 	u32 seq;
@@ -426,6 +429,7 @@ void bpf_flow_new_pass(struct bpf_verifier_env *env)
 	memset(flow->cost, 0, env->subprog_cnt * sizeof(*flow->cost));
 	flow->budget = bpf_precision_budget(env);
 	flow->budget_func_cnt = 0;
+	flow->apart_cost = 0;
 	flow->start_cnt++;
 	for (i = 0; i < env->prog->len; i++, aux++) {
 		if (aux->callback_loop)
@@ -631,6 +635,7 @@ static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_
 	INIT_LIST_HEAD(&s->node);
 	s->prev_insn_idx = prev_insn_idx;
 	s->seq = ++flow->seq;
+	s->from_apart = flow->last_is_apart;
 	s->log_pos = env->log.end_pos;
 	s->diag_pos = bpf_diag_event_log_save(env);
 	bpf_add_cost(env, 1, BPF_COST_STATE);
@@ -723,6 +728,7 @@ void bpf_flow_reset(struct bpf_verifier_env *env)
 	env->mem -= flow->instance_cnt * INSTANCE_BYTES;
 	flow->instance_cnt = 0;
 	flow->last_instance = NULL;
+	flow->last_is_apart = false;
 }
 
 void bpf_flow_free(struct bpf_verifier_env *env)
@@ -870,6 +876,9 @@ static struct flow_state *flow_find(struct bpf_verifier_env *env, struct flow_st
 
 	hash = bpf_hash_apart_xregs(env, &s->st, bpf_hash_join_key(env, &s->st) + s->kind,
 				    s->kind == FLOW_PEELED);
+	/* the arguments are joined, else calls do not share an instance */
+	if (s->kind != FLOW_FUNC_ENTRY && s->kind != FLOW_JOINED_CALLS)
+		hash = bpf_hash_live_types(env, &s->st, hash, env->flow->apart_cost);
 	if (s->kind == FLOW_FUNC_ENTRY && (!e || e->peeled))
 		hash = bpf_hash_args(env, &s->st, hash);
 	if (s->kind == FLOW_AT ? !aux->loop && !aux->callback_loop :
@@ -1722,6 +1731,8 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 again:
 	if (flow->last_instance && flow->last_instance->cost)
 		*flow->last_instance->cost += env->cost - flow->charged_cost;
+	if (flow->last_is_apart)
+		flow->apart_cost += env->cost - flow->charged_cost;
 	flow->charged_cost = env->cost;
 	if (flow->last_instance)
 		flow_end_instance(env, flow->last_instance);
@@ -1731,6 +1742,13 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
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
index 7fc1e93aef1..cafa7805295 100644
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
@@ -1391,6 +1442,7 @@ bool bpf_undo_precision(struct bpf_verifier_env *env)
 		return false;
 	}
 	env->over_limit = false;
+	prec->live_types_over = false;
 	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));
 	for (i = 0; i < prec->loop_cnt; i++)
 		over_budget |= prec->loops[i]->partitioned &&
@@ -1563,7 +1615,11 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env)
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
@@ -1620,6 +1676,10 @@ int bpf_precision_init(struct bpf_verifier_env *env)
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

