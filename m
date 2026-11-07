Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022769;
	b=27pLZzuWjlQITRRLJH10Q+d6l1EdeHjkFD0xUh4Ym7JbOJNWAOWYtb2h8c9HQOBZSRLk
	 sIi4NTnHvtABRQ9XV3bJbuqlH5frlvhGUEcHrcZhqjl6kYqPfcvGW5AeKK+MazTEzGoLP
	 pu3OKMUw4dDH9iF451+GkKZJ+C549QuqR6UAgyzb/XVVzQyaEuOyxLkFrwYCZ05oNHG9m
	 LVzglkYGnbwOtxGpCPYn5/Cr6ixzZ18ASldWDtwadebhQdwhqqyDozJ26VmKsvpu4wGd8
	 hkBRXFEPdJ0q2IJSNvrQNKOpQsxy+eGx8h4bcZZPWzLQZwSTTevscn34gxn6CEIn2SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1eYKidUEB5Ecvy56rtXAS/3uz9eY61yj98vGkly9qG4=;
	b=dhEYKc6DWOuGgSclV095gnKsoGKSPjCKuqWXBx7icT0aXPLt1jX0iY1SYdIpo56h4Kof
	 YY0xAjj0YhI/hKXRsVhlOQVEAfTk/kjOFT6wd0J4IVPbTlH/ManXQ/Wv9cpzBDdWEj+Q1
	 qfWXGmSNSGDo+LyCA3HYw/I+XX3zfVsPG4lHhnghxg/NIS/+VQCvLeYnTJjg3F4bJHG9I
	 dZ87oVGQkjl7GPfjFyf2bScPJHf9W8TuGISb+7nv4bnIrTGdUCCe2SLw6Qg4joNbx1hDR
	 cfVG4aWyvxE64FsWuknkFf6VitrtajVuWqI/tfzW5twyUfkjdyVK+nacs+ByztRvs+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=On7kB0ec;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D8606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 308D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=On7kB0ec
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1057610a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022768; x=1794627568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1eYKidUEB5Ecvy56rtXAS/3uz9eY61yj98vGkly9qG4=;
        b=On7kB0ecq1jVi9V2xmQaoT7bjygYA6EIasytS8n98xDr/eRV7eQpUKdMOXvE1IFRUD
         lPmmr3hBwOC9ellkRvVJQyEtw2zJONGpYfX5O5M3ufV7WeUtfcZE0NT92hIqyPnGRU8Q
         rorCZ9jRiyX2+Kz0Q5/zJjg3Qn+CczJAaPMgOerveUqfGkiSpw3qQErlJgUQ17Cu5hBQ
         47bWjxzB4sfkGV4WDKfyMFn2mBVStMEUHPX9VWXPzF6IP0hZCdk6anjZKfY/UbDC4Zmp
         mHj7GAwhJStTO+CdvIinI5z7YU5x2q6435eB1HO70IuPuNYMmoSQYJoyfrH2Hw6e3w2f
         JkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022768; x=1794627568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1eYKidUEB5Ecvy56rtXAS/3uz9eY61yj98vGkly9qG4=;
        b=N+rWfBvE7icSfeTl00THujT/5esUYp7BzKAd6xmShKCDbJL7F45SAI+/GfTv4Z838O
         zASQHcl16B69w4ISiG97GI0yJNc7++jmINI2Nh/aiHVdGvXa8Qq8Y+whWmjm/3u4HKIY
         +Xf1+tkhSQ60bVYtU6VPUT1upO/7g+aIGp2eqalL0tCQQ6+eBfkJWM6rNvbZ1rYKgOXA
         tPdZR4y0UTzPaU6V/yMnSljcFSm76k/Wwa3pyGYwixPOqrOM/gNlsBGKKBIOy3xoOQGf
         jhe0S9DuELcjaFlmnMmLWHD/bPTLfdwX1fe8yVGhccG8WE2o2+lGh3SHXTkbVkQkc2MI
         s7jA==
X-Gm-Message-State: APuU4Z/hmwgVgE5AJlcongbDNkubdRABlMHpN3+gNkQllwDBirhqhjo3
	GEol9ru3Olf9UPJrtLc6V33BHiZMTgz1uvYS+2i+zpSYtK1NYjJMWhd6/S7iLw==
X-Gm-Gg: AYBFou2tt5SXr9EAC9zR5qZCbXYyhua0a2nFxm6Y+bXvB1BjimmbvyGJIRfiNjl7mjg
	HtTJskqqn7HPAzuscPXlN2G5PZROCJatOIsJvvVn+KWc9ngEW2DORCSnGGVHUt67fyBjNUrX5NA
	Pq12iDieqGYR7jIQQPaVVNVwEWgHTAWiXnnPGj9fr/Obt5sTwvfUQqfHYwbMitCX6D5YaFq1PuK
	PlREgZRAfBgGYA3x67Q7egSFfPxJpJkaw9UlVU/y18b/oG65Dw8NJOk4EUXhOptFEIwSbRFWOji
	CMMxbYbB1HxKSb7Fu4kB/FBnDYEr75YgB8cr8HltIY8KNufJt1iuxncTt6aHSLMNP8l6emD8sB0
	riWckO7wShT/kSgCKgEdAGQh026TIESyVBa3yXKG3aX6ukRVISPuu4jxNmpbqbclmbvsl0TqaUX
	sZavFxCyJXkJ8UfvV5Oybo8w9AeODve/tOfchrdpPvQoi3kaS4oZToRLAeqVZyA7cN+geJNY2iU
	Erp2m9qTy+u85FvfAq8G2y13ARvpSNJ/UrCaa5PXhbSS1I0jNiFQFZK4m2dwcg2HzI6SdyjU3sV
	pAVzBbn+DUVwQmFgI8raPTc5uoiB4wC48l/H6M4YkX1Geobm1m4A3dDChBw5b9NxMtNlD1HtT0L
	Hi+Sf4E/jJCTUXRu/xlhF3Codeal7Cy+klEp4AY4Mp2/ZLNdCt3yaQeKXJNZ7DkuxI7cr7tfa5A
	==
X-Received: by 2002:a17:90b:3b8f:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3b0db6e4139mr4627290a91.38.1794022768201;
        Fri, 06 Nov 2026 19:39:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101e3e513sm1037501a91.4.2026.11.06.19.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:39:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 14/46] bpf: Merge the state that arrives into the set at an insn
Date: Sat,  7 Nov 2026 03:37:22 +0000
Message-ID: <20261107033758.1547725-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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
  if (nq0 > 0) {
      node_moved = flow_move_one_hint(node_dsq, cpu, &visits, nq0);
      if (node_moved > left)
          node_moved = left;
      left -= node_moved;
  }
Each way through a block leaves other ranges in left, visits, node_moved.
No check behind the block depends on the way. Today's verifier follows all
paths: 70716 insns for a prog of 1117. With one state where the ways meet
it takes 3127. flow_merge() puts a state S into the set at an insn:

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
 - A live register that only S has set. In clang 18's code of
   'bpf_for(..) { if (..) continue; last = rnd(); found = true; }' and
   'if (found) use(last);' the join has no 'last': "R7 !read_ok".
 - The calls of the callback of bpf_loop(N <= 8). What other callbacks come
   back with is joined 4 times, then widened.
All that holds only if S comes from T:
  ret = 0; if (file->f_flags & O_TRUNC) { denied++; ret = -EPERM; }
  bpf_for(i, 0, 100) { sum += a[i]; } total = sum; return ret;
Two states enter the loop. Next to -EPERM the 0 that comes around looks
like a number that grew, and an LSM prog is rejected:
"R0 has smin=0 smax=4294967295 should have been in [-4095, 0]".
Thus a state that enters a loop, or gets to bpf_loop(), has a number, and
so has what becomes of it. S is widened with a T of its number only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index feaa5949a2a1..0774e54f8b2c 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2189,6 +2189,22 @@ static bool flow_join_makes_up(const struct bpf_flow *flow, const struct bpf_ver
 	return flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b);
 }
 
+/*
+ * @s came back to the head of a loop, or from a callback to the helper that calls it. @t is there.
+ * Do they come from two states that entered the cycle?
+ */
+static bool flow_entries_differ(const struct bpf_verifier_state *t,
+				const struct bpf_verifier_state *s, enum flow_cycle cycle)
+{
+	const struct bpf_func_state *ft = t->frame[t->curframe], *fs = s->frame[s->curframe];
+	u32 cnt = fs->loop_stack_cnt;
+
+	if (cycle == FLOW_CALLBACK_CYCLE)
+		return ft->callback_entry_id != fs->callback_entry_id;
+	return cnt && ft->loop_stack_cnt == cnt &&
+	       ft->loop_stack[cnt - 1].entry_id != fs->loop_stack[cnt - 1].entry_id;
+}
+
 /*
  * States that have a join are kept apart while there is room: half of every limit.
  * After that they are joined, which may lose what the prog needs, and does not run into the limit.
@@ -2201,3 +2217,264 @@ static bool flow_has_room(const struct bpf_verifier_env *env, u32 nr_states)
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
+	bool places, widen_all, widen;
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
+		/*
+		 *	ret = 0; if (...) { denied++; ret = -EPERM; }
+		 *	bpf_for(i, 0, n) { ... } return ret;
+		 * Two states enter the loop. What comes around it with 0 is for the state with 0.
+		 * Next to -EPERM it looks like a number that grew, and would be forgotten. The same
+		 * for the header of a packet at pkt + 34 and at pkt + 54. No rule has to tell which
+		 * numbers that holds for: a state knows where it comes from.
+		 * If it has no join with that state it is at the head on its own from now on.
+		 * The same for bpf_loop() in place of the loop.
+		 */
+		if (widen && flow_has_room(env, *nr_states) &&
+		    flow_entries_differ(&t->st, &s->st, cycle))
+			continue;
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
+		if (flow_has_room(env, *nr_states) &&
+		    (flow_unset_differs(&t->st, &s->st) ||
+		     (!widen && flow_join_makes_up(flow, &t->st, &s->st))))
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
+		if (!widen && flow_has_room(env, *nr_states) &&
+		    flow_needed_consts_differ(flow, FLOW_NEED_PTR_OFF, &t->st, &s->st))
+			continue;
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

