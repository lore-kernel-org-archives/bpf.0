Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911599;
	b=Y/XbpI7HSki+khLdnNIl1CM3+ivGmXWR6RsSUmJI01JExBBTsy6I5IeKf8x1SPy+wMJD
	 QOx+54T61ujidvGfmkQMuQdz77YjdQaSHLNEUoYgGjhHqqu8BNPIMBNjeGIIVQWJUc+rl
	 BiFR/r2Yv3LX4p64EKKRMltNoH0JQ4q1M2jaQ8Us9Y7xQxW3IbObrZFDeDZJumcEFmCC7
	 sGhGB/6bpo10pNjcoc96ORlC4539VoIVWnOchUM9u3qU4bwjK09C5GuqcvhJTkV5lyW12
	 9Lr0h/c0FRvk27sdt/hXtfa1OkM4Jw1Jimd8jn8Kkq3dc25J7oQN0eF9Vm/Q3qM9ZYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IHsyQWyHn8v1XGHoVoxlw1jGbMAqX4S+nWlIZKLjSqc=;
	b=xhIeofu6N4z2y9sQWIR4j76e6c1DRnSyu/hvpXiYsAokSez966L1rbu2WEQ1xjGN5yQR
	 Ytgye76E1/RvY+jIhsIXVba35K+/A9Xu+OPyHaYgKMf72QIdhhgdeQB+h6MVNaHgA05mV
	 kMNGxJwmO8V1zOAqu2PNTl3AFhsEXSz6POjcCqEofqfk3VDOhX+Sr8t2QAQUMlvE3oPDL
	 3+hIA3onFNh0mG9cLtYX2JmCcCF/wXOChGbUJH6CQLcHahKgyzHYf5TkXrOIPeZ3amofM
	 0lbKzhNyJWvAQrESjmcCKdY0c161iarNtvBTf58Ew4xcU4VS8KBwAo6uzyZM5gyIRUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvKBS6i6;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B7606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0B7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EvKBS6i6
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1921644b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911599; x=1794516399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IHsyQWyHn8v1XGHoVoxlw1jGbMAqX4S+nWlIZKLjSqc=;
        b=EvKBS6i6vtGKumzdKkG+pD2CiTrvFweSs2nSHkcpai/RK9rPw1bifOa4OZq8MZmVZN
         7yKOYAxBBP4XroVVVw0phnvBVdVQMuHy167RpBHEb2p5EwP/cQGDDIF/IvZt7agcM3nD
         gk0ZUIBJddHtLJZki136dpBJxh0KYvuzMhFgZNrY4ZHg27kNRmU4FYIwoMW7ZcwdZdrz
         LqgcxtjQ5lEsnJiU802B709+PjBRYS6xjuyUFqwEiP3/QlK9pZbj/ISJZRtq07uRs9ey
         fI4L2eDizbYfoXRmbaRUuuTOeLXfJHcXMvqRQ3g+FkAsFjyLcT7chKG7ZtXYF8t6ZdYy
         gJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911599; x=1794516399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IHsyQWyHn8v1XGHoVoxlw1jGbMAqX4S+nWlIZKLjSqc=;
        b=UJeR+HXJAQl9oTCDlrWj28hidYyWGfn/y8UFkNOvlFmeoDqnFWv/uksI7Hp+OWNAtp
         VoCR+bm+ckqCdIjaaL+MljBypTZNCUC0i9jYRihxISIqzrZJt1WchumuPD3ZhQijapbG
         oZyT40YTZbB3B6CGk03pRPwDul+/7Sc8CExq77eeI3U3XnZxEj2XQc7nHi8bftipi5o4
         LQCbPE4sL/rRusMTiQSScY05MxYJCD1e2ylmdaW6FYPB9LrY51FnQjPzmTvsH/hsb89Q
         0HlsU1rD4yJelBpgAvXX1xLyq5nWSTSkb+qbizUD09a7UsXzUT6eatiE47WxmIa68X3+
         FO1w==
X-Gm-Message-State: APuU4Z+9pGsBUT523+/eMAvtRs5a4iOjdioFtYyijXQEpwjRBPqSPFES
	B5d+hXv6YtRg2hb46wgFJ0LTvE4NeW/RmU0ZajMn9YwhgXBG7Ro1YBmH5H+6lg==
X-Gm-Gg: AYBFou3pUFzuuGfRx50pjnGrrtG4LKaXloZ4PnFJX4XEJB3hFMNrDUGDNqUVMkZOcIt
	fX5TrWJ2dgCAsR5r0vHNS/fe3Dlt8F9QN69J1b4R/z9M+hV6ucLnzjoaRsHjXPJ/4SHMePNySbh
	muDdgcEiXBNPV18j/UnhxN5RdffYwCAaVWF3LxH6KRifQJYS8S1kD0zv+S4BeRM2bnnzYQSYJvH
	8Lhf/88qD2QMnVevadLdegBviu0LOITHhNtB1m2ENJkF6SJe6uBOv9q62cuwukjdmkAqKrpjHEi
	uohPgf6Ul8w4k7XDxBNd/4ZGrNV+/7jCzdiEFtiCXFzMpZG4koF8vxjt8woIgQuZjXPaceRXNj+
	lEw56mq9dgJy+PzaBaimzQ29vNkU/UU73ZYhbkryC/xaV7hLVMB2Lcp37Pis9402jGDt+wXZZKY
	elVDlRvNH5eZssTEKR5OZfp54Tf9UxPENZaqx6budjZZEFiruaxQoQma5r5vgLr5IipnQMssgrz
	zg29+5t7HSwl1Qx2C1opqmT8CdCfetXugAbJqJ8W1WkHw5xtJg7O+suUUWICbYr51ZcXYM3p+Ag
	1YQnNDnnPSwMmpZHd4h7WSWTNWUV5TlsFohq7HNfZBRIVQogkTY+xuUoewtVG8TJ1O6WUoSyklU
	9ME8lOspzT5F73Gfyk7Upr2Pk2ESFiP7wBj1CIsN7NTo7w7ikE2blXykrDEaUpMY5se9Kily+1w
	==
X-Received: by 2002:a05:6a00:4b01:b0:887:17f3:94f7 with SMTP id d2e1a72fcca58-8b377c8e7a7mr205456b3a.1.1793911598316;
        Thu, 05 Nov 2026 12:46:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35aa97f0bsm72532b3a.57.2026.11.05.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/35] bpf: Merge the state that arrives into the set at an insn
Date: Thu,  5 Nov 2026 20:44:51 +0000
Message-ID: <20261105204513.2230344-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

scx_flow, flow_dispatch() is a row of blocks like this one:

  if (likely(left) && likely(visits < (u32)FLOW_DISPATCH_MAX_VISIT)) {
      if (nq0 > 0) {
          node_moved = flow_move_one_hint(node_dsq, cpu, &visits, nq0);
          if (node_moved > left)
              node_moved = left;
          left -= node_moved;
      }
  }

Each way through a block leaves other ranges in left, visits, node_moved.
No check behind the block depends on the way. Today's verifier follows all
paths: 70716 insns for a prog of 1117. With one state where the ways meet
it takes 3115. flow_merge() puts a state S into the set at an insn:

  a state of the set covers S ?  ------ yes -->  drop S
     | no
  S covers a state T of the set ?  ---- yes -->  drop T
     |
  S has a join with a state T,  ------- yes -->  drop T, S = join(S, T),
  and no rule refuses it ?                       start again
     | no
  add S to the set: it is new, the verifier goes on from it

A state is dropped only if a state of the set covers it. Thus the verified
states cover each execution of the prog.

S can come around a cycle: to the head of a loop, to the first insn of
a recursive subprog, from a callback to its helper. There a bound can grow
by one step each time: i=[0,1], [0,2], ... Thus the join is a widening: it
gives up the bound that grew. S and T differ in what the cycle changes, so
the rules that refuse a join are off. These stay on:
 - A constant that becomes a stack offset: bt_print() of scx has
   'stack[depth++] = ind + 1' and 'ind = stack[depth]' in bpf_for().
 - A constant that is added to a pointer, if a state of the set has it too.
 - The calls of the callback of bpf_loop(N <= 8). What other callbacks come
   back with is joined 4 times, then widened: selftest
   verifier_iterating_callbacks/bpf_loop_iter_limit_nested needs both.

States that cannot be joined are what is left of the paths. Limits on them
replace 1M insns and 8192 jumps: 1024 at an insn, 16 * N + 4096 at a time,
256 * N + 64K in all, for a prog of N insns. Then the load fails: -E2BIG.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 261 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 8b294a8748bb..ad9c0187b463 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2144,3 +2144,264 @@ static bool flow_has_room(const struct bpf_verifier_env *env, u32 nr_states)
 	       env->flow->live_states < (BPF_FLOW_LIVE_PER_INSN * len + BPF_FLOW_LIVE_BASE) / 2 &&
 	       env->total_states < (BPF_FLOW_TOTAL_PER_INSN * len + BPF_FLOW_TOTAL_BASE) / 2;
 }
+
+/* The state of @set behind @t, the first one if @t is NULL, that @s may be related to */
+static struct flow_state *flow_next_related(struct bpf_verifier_env *env,
+					    const struct flow_set *set, struct flow_state *s,
+					    struct flow_state *t, bool places)
+{
+	t = t ? list_next_entry(t, node) : list_first_entry(&set->list, struct flow_state, node);
+	list_for_each_entry_from(t, &set->list, node)
+		if (flow_may_relate(env, t, s, places))
+			return t;
+	return NULL;
+}
+
+static void flow_link(struct bpf_verifier_env *env, struct flow_set *set, struct flow_state *s)
+{
+	list_add_tail(&s->node, &set->list);
+	env->flow->nr_states[s->st.insn_idx]++;
+}
+
+static void flow_sweep_trip(struct bpf_verifier_env *env, struct flow_state *t,
+			    const struct flow_state *s)
+{
+	if (t->pending || !flow_earlier_trip(&t->st, &s->st))
+		return;
+	flow_unlink(env, t);
+	flow_free_state(env, t);
+}
+
+/* States of earlier iterations than @s go away, see flow_earlier_trip() */
+static void flow_sweep_trips(struct bpf_verifier_env *env, struct flow_set *set,
+			     const struct flow_state *s)
+{
+	struct flow_state *t, *tn;
+
+	if (!flow_has_earlier_trips(&s->st))
+		return;
+	list_for_each_entry_safe(t, tn, &set->list, node)
+		if (flow_same_shape(t, s, FLOW_CHAIN))
+			flow_sweep_trip(env, t, s);
+}
+
+/*
+ * Put *@ps into @set, one of the sets of states at its insn. Returns
+ * 1 if it is within a state of the set. It is gone then.
+ * 0 if it is in the set now, as it was or joined with states of the set.
+ * @cycle: it came around a cycle, what grew is forgotten.
+ */
+static int flow_merge(struct bpf_verifier_env *env, struct flow_set *set,
+		      struct flow_state **ps, enum flow_cycle cycle)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_state *s = *ps, *t, *tn;
+	int insn_idx = s->st.insn_idx, err;
+	u32 *nr_states = &flow->nr_states[insn_idx];
+	bool places, widen_all, widen, offs_apart = false, offs_change = false;
+	/* the set of the states that enter a loop is a stop on the way, see bpf_flow_deliver() */
+	bool log = (env->log.level & BPF_LOG_LEVEL2) && set == &flow->states[insn_idx];
+	const char *what = NULL;
+	int prev = s->prev_insn_idx;
+
+again:
+	if (signal_pending(current)) {
+		err = -EAGAIN;
+		goto err_free;
+	}
+	if (need_resched())
+		cond_resched();
+
+	/* again after a join: an offset may not be a constant any more, a pointer may be gone */
+	flow_shape_ctx(&s->st, &s->shape);
+	places = *nr_states >= BPF_FLOW_MIN_SHAPES;
+	for (t = flow_next_related(env, set, s, NULL, places); t;
+	     t = flow_next_related(env, set, s, t, places)) {
+		if (flow_cmp_pkt_range(t, s) > 0 || !flow_trips_near(&t->st, &s->st) ||
+		    !flow_within(env, &t->st, &s->st))
+			continue;
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "from %d to %d: within\n", prev, insn_idx);
+		err = flow_cycle_closed(env, &t->st, &s->st) ?:
+		      flow_unite(flow, s->st.flow_entry, t->st.flow_entry);
+		flow_free_state(env, s);
+		return err ?: 1;
+	}
+
+	flow_sweep_trips(env, set, s);
+
+	widen_all = cycle == FLOW_CYCLE;
+	for (t = flow_next_related(env, set, s, NULL, places); t; t = tn) {
+		tn = flow_next_related(env, set, s, t, places);
+		/*
+		 * Iterations that are kept apart have no join. Neither does a state take the place
+		 * of a state of another iteration that it covers: that one is done with, or has its
+		 * own way to go, see flow_cycle_closed().
+		 * The shape is a hash, and what follows goes through the frames of both.
+		 */
+		if (flow_trips_behind(&t->st, &s->st))
+			continue;
+		widen = widen_all || (cycle == FLOW_CALLBACK_CYCLE &&
+				      max(s->joins, t->joins) >= BPF_FLOW_CALLBACK_JOINS);
+		if (!widen && flow_has_room(env, *nr_states) &&
+		    flow_null_differs(flow, &t->st, &s->st))
+			continue;
+		if (!widen && flow_needed_consts_differ(flow, FLOW_NEED_ARG, &t->st, &s->st))
+			continue;
+		if (flow_callback_depth_differs(env, &t->st, &s->st))
+			continue;
+		/* what grows in a loop is not replaced with what is larger, it is forgotten */
+		if (!widen && flow_cmp_pkt_range(s, t) <= 0 && flow_within(env, &s->st, &t->st)) {
+			err = flow_unite(flow, s->st.flow_entry, t->st.flow_entry);
+			if (err)
+				goto err_free;
+			/*
+			 * What a callback comes back with and covers what is there grew, like
+			 * what is joined with it. It counts, or nothing ends "*ctx += 1".
+			 */
+			s->joins = max(s->joins, t->joins) + (cycle == FLOW_CALLBACK_CYCLE);
+			flow_unlink(env, t);
+			flow_free_state(env, t);
+			what = what ?: "joined";
+			continue;
+		}
+		if (!widen && flow_cmp_pkt_range(s, t))
+			continue;
+		if (!widen && flow_has_room(env, *nr_states) &&
+		    (flow_unset_differs(&t->st, &s->st) ||
+		     flow_join_makes_up(flow, &t->st, &s->st)))
+			continue;
+		/*
+		 * Around a loop too:
+		 *	u8 stack[10], depth = 0;
+		 *	loop {
+		 *		if (...) { if (depth >= 10) break; stack[depth++] = x; }
+		 *		else { depth--; if (depth >= 10) break; x = stack[depth]; }
+		 *	}
+		 * depth is in a 32-bit register. A compiler tests 'depth & 255' and computes it
+		 * anew for the index. What is found out about a copy says nothing about
+		 * a range, and everything about a constant.
+		 */
+		if (flow_has_room(env, *nr_states) &&
+		    flow_needed_consts_differ(flow, FLOW_NEED_STACK_OFF, &t->st, &s->st))
+			continue;
+		/*
+		 * Two states enter a loop, with the header at pkt + 34 and at pkt + 54. What comes
+		 * around the loop with 34 is for the state with 34. Next to 54 it looks like
+		 * a number that grew, and would be forgotten.
+		 */
+		if ((!widen || !offs_change) && flow_has_room(env, *nr_states) &&
+		    flow_needed_consts_differ(flow, FLOW_NEED_PTR_OFF, &t->st, &s->st)) {
+			offs_apart |= widen;
+			continue;
+		}
+		err = bpf_states_join(env, &flow->tmp, &t->st, &s->st, widen);
+		if (err < 0)
+			goto err_free;
+		if (err)
+			continue;
+		what = widen ? "widened" : "joined";
+		err = flow_unite(flow, s->st.flow_entry, t->st.flow_entry);
+		if (err)
+			goto err_free;
+		flow->tmp.flow_entry = t->st.flow_entry;
+		flow->tmp.last_insn_idx = s->prev_insn_idx;
+		s->joins = max(s->joins, t->joins) + 1;
+		bpf_free_verifier_state(&s->st, false);
+		s->st = flow->tmp;
+		memset(&flow->tmp, 0, sizeof(flow->tmp));
+		flow_unlink(env, t);
+		flow_free_state(env, t);
+		/* the join may be within, or have a join with, what is left in the set */
+		goto again;
+	}
+
+	/* No state has the offsets of what came around the loop: they are what changes in it */
+	if (offs_apart && !offs_change && !what) {
+		offs_change = true;
+		goto again;
+	}
+
+	if (*nr_states >= BPF_FLOW_MAX_STATES) {
+		verbose(env, "more than %d states that cannot be joined at insn %d\n",
+			BPF_FLOW_MAX_STATES, insn_idx);
+		err = -E2BIG;
+		goto err_free;
+	}
+	if (flow->live_states > BPF_FLOW_LIVE_PER_INSN * env->prog->len + BPF_FLOW_LIVE_BASE ||
+	    env->total_states >
+	    BPF_FLOW_TOTAL_PER_INSN * (u64)env->prog->len + BPF_FLOW_TOTAL_BASE) {
+		verbose(env, "too many states for %d insns: %d, %d at a time\n",
+			env->prog->len, env->total_states, flow->live_states);
+		err = -E2BIG;
+		goto err_free;
+	}
+	/*
+	 * The state is printed when its turn comes. That says enough about a state that
+	 * is new, and about a state that goes on to the next insn.
+	 */
+	if (prev >= 0 && insn_idx == prev + 1 + bpf_is_ldimm64(&env->prog->insnsi[prev]) &&
+	    what && !strcmp(what, "joined"))
+		what = NULL;
+	if (log && what)
+		verbose(env, "from %d to %d: %s\n", prev, insn_idx, what);
+	flow_link(env, set, s);
+	env->max_states_per_insn = max(env->max_states_per_insn, *nr_states);
+	return 0;
+
+err_free:
+	flow_free_state(env, s);
+	return err;
+}
+
+static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_insn_idx)
+{
+	struct flow_state *s = kzalloc_obj(*s, GFP_KERNEL_ACCOUNT);
+	struct bpf_flow *flow = env->flow;
+
+	if (!s)
+		return NULL;
+	s->prev_insn_idx = prev_insn_idx;
+	s->seq = ++flow->seq;
+	env->total_states++;
+	flow->live_states++;
+	env->peak_states = max(env->peak_states, flow->live_states);
+	return s;
+}
+
+/* What @st holds is taken and @st is left empty. What doesn't matter at @insn_idx goes. */
+static struct flow_state *flow_arrive(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+				      int insn_idx, int prev_insn_idx, bool *enters)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	int cur_idx = env->insn_idx, err;
+	struct flow_state *s;
+
+	if (insn_idx < 0 || insn_idx >= env->prog->len) {
+		verbose(env, "invalid insn idx %d insn_cnt %d\n", insn_idx, env->prog->len);
+		return ERR_PTR(-EFAULT);
+	}
+
+	s = flow_new_state(env, prev_insn_idx);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
+	s->st = *st;
+	memset(st, 0, sizeof(*st));
+	s->st.insn_idx = insn_idx;
+	s->st.last_insn_idx = prev_insn_idx;
+
+	env->cur_state = &s->st;
+	env->insn_idx = insn_idx;
+	err = bpf_flow_loop_leave(env, enters);
+	if (!err)
+		err = bpf_clean_verifier_state(env, &s->st);
+	env->cur_state = cur;
+	env->insn_idx = cur_idx;
+	if (err) {
+		flow_free_state(env, s);
+		return ERR_PTR(err);
+	}
+	/* when the registers that it was shared with are dead, or are those of the caller */
+	bpf_clear_singular_ids(env, &s->st);
+	return s;
+}
-- 
2.55.0

