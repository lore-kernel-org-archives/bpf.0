Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937162;
	b=eh0uZwDBloQcZ1ZJBYfZf8p6tP8BsQ9b1Fx9VDrMuBBzBpn70YEAdyix71fIsY2NvqR5
	 PN9GTwb1Bt5pmOzjjbbbsIXsszVWA3ABSpQ82sElGC/AyiAmCuTNjLPDQY7Hk8WbtVkLc
	 c54pj4/ZZfnwSRk1SR09un55ZPvKiYxbCBsHHNnKTxhvYZA9l7rIy3uwCKLepKC1+lc0D
	 ryvs9Pc3XKIgbH0//1SNTrx0j5Shl6g0RwAvan5j/z3x1HSYnhLMiETnhCstCARa9s6Ef
	 4HCFIz5yN/7hZXrevZY8B1JDTAY1m7LwQfIk8AptGZY64tHNa1Hn4fNvxXPxm40Z2uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OD2aPO6Quppf1ffm/XnCOtzeFWu02cnHZkfkI+GxsMU=;
	b=MuCU8jn2p0xupvFT6tIGzfFn1ixCToW++flzuPar0FzBQb4BanSjD0psLAz0qrtwd+C/
	 OKO9rhFPEcdfPYCbCXabPV1mpOhomi2l4EX+yFNXGqK1IsnknzqKeWSSm8bHa190svt7Q
	 hFSpJRtRPiEz8+rV0qpw/gRhbCOUk0c0q7TLcks0aGieGjO8vKUkkAmuemXK5ZGcrtvB8
	 2jYsaeEm20yBKg7ce+04hlKpDwLlI50B/ZR4bvh1rUpY4hV3w/gby363nB+VHQslvakx6
	 GXhGRyFYnWIQ0Q1pLVdGb0hfa4qy4XR4IXi8zdgsTjFwgd6OiUtqELbH2KZ8b00ZjBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5HsxfxB;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D105606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D105606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5HsxfxB
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea7190aea1so706535ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937161; x=1794541961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OD2aPO6Quppf1ffm/XnCOtzeFWu02cnHZkfkI+GxsMU=;
        b=n5HsxfxB/VCYwjR36IxIoShtHzOR+2AuOFoskel8QIxekNSKRVlN4T+QlHldGf20x5
         TXM+GsPkZKH1RJH5RKroMmZjwC3FsK/FGYLvJFYjcozkautZBZWWe8nxO+4Dqzt7HsIT
         d+AEZN9m8HXTaduqGRt6et5oTMr5ZsvYx5Frjpwhv1F8BHjMjcf4jGAjcn6CIzTQSVJo
         naDFyDz3P+Fa9Sg2tEk6JQxvL2R/kJ2UZplg+uxEvYHvsY+8Yfs3yOFp4xIoY+9LUP+7
         /jDX8HHbffXNOmkhVQ9b+cTuA7pZDKjjjgV+VfuhUcjEdt13hZGnWMMjEjFqttMe7IST
         tdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937161; x=1794541961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OD2aPO6Quppf1ffm/XnCOtzeFWu02cnHZkfkI+GxsMU=;
        b=qhtoP8D39suRSl7JzToJRmdHGazaWDsW2r1EzErfg0RuyRp3M8WZg3Hw4vkSsU7FUd
         WTZD38Hc2BIbybeUZXNKixQfOAPn0Rb001x+4N0OW3ZDnRuVY5ABhxS9ihilbGGdFGsR
         R/LIvXQma2jS4ou1QW+urUgySVHIA56X69jTtIjciUuzmjXnZ3Ou42AMRpp73tXk0js+
         STb0vbHJ3qVAVGWzWoQNqaW2BDwaGaFmF9C0sExMxzAzWi3Bh3x7CDX7rjU3zRl4JAlu
         aYdfDYRb4GIEYBtmGTN4G4bbWF3bmn6QXbPKzHWjO04iCxM2TD3Y+FdgjTjahT4mR5qW
         ScrA==
X-Gm-Message-State: APuU4Z+uE4hCI7QzSgsT7iBtk1dMS4VJPUOG4g7b2QLZISHte1G5mEgt
	4W1Zn6+s6sPdq0x2s+V7xZLsqtJXB0cMfDnEGkoUm8vapogCnztn+QFMezXa3Q==
X-Gm-Gg: AYBFou2LJK+ZcJDLn04EA7rbcOOGoqLLVIlKJYbYWjgH986AqsrTksb9P0c/QZ+GPbz
	r62jMbqF3oGU8ZwQxZAhmqYnVTRwtpVPRWYlqylJ4syk4TLSmyfsX22Id/mlzmebIkeexnzymTK
	mK0sZUbYcSuJkhmMwNrPjEdXi/FUO/2CWsGPMzBXrVyXLnNW8gyso7hs/lI3Bq43rTwY78roJjG
	lrFdyiC4/CaKHNhQxZvm7mzADoBMYUZtdrgF8PhTV5LOWkVvg7JXxkaqfrIRlpi+/2CIVdJzlPS
	OQhG2ile8LUesKpnIdGyDa6EJGVwd6bnO/M9OzkPXvp3x3Qwj8LviGbp34HciV41ttbZC76Hf/Y
	J739AqldWyHzbAHZa0HlM+LPkTJduuurFfOHVwEDOI444aPtjXXwQpuVFFtnar2A+6Jm0ZbNIjJ
	+Xa7MbbTeZrWCXQ7xfrdYERCrpdvZxO22dOGbnyC5Yr84r6xeE//D8uuMQNfBvD1cEJk1KZa85z
	y5kOTuRgQkyeqUr1udkkFh2RXNPaaxbPocyKzcB5Y2vM06pz73kg7WX4j2U3gmVE7OtiDJH4UIq
	k+at12hfnxCYq1BoFoSCDnh8c7nO87vtFYE8qobtBYbkM9QLGZh6vuYFyaQzxr+rSVmidQcBeQy
	79iozCJVO2KIPASP5EzYcmzLD0QEJSPkXqy2qV8/il/PEUW+yHduA/fSmJl/ua5dJjhoDVDlVWw
	==
X-Received: by 2002:a17:903:1a30:b0:2e9:3c10:c5f8 with SMTP id d9443c01a7336-2ed40e02743mr17770835ad.65.1793937161102;
        Thu, 05 Nov 2026 19:52:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70aa6878sm147099a12.28.2026.11.05.19.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 15/45] bpf: Move states along edges, into loops and subprogs and out of them
Date: Fri,  6 Nov 2026 03:50:39 +0000
Message-ID: <20261106035111.3315285-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

Selftest test_verif_scale1 has these lines 90 times. jhash() is static:

  ptr = data + i;
  if (ptr + nh_off > data_end) break;
  ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++);

The 90th call is reached with i = 0 .. 89, in 90 states. All calls: 4095.
jhash() sees one of 90 pointers. If a state in jhash() has the frames of
its callers, as today, states of different calls have no join:
"more than 1024 states that cannot be joined at insn 903". Thus a state in
a static subprog has one frame, and the caller's state waits at the call:

  bpf_flow_call()   saves the caller. The entry state goes to the set at
                    the first insn of the subprog, like any state.
  bpf_flow_exit()   a state at exit goes to all calls that wait for its
                    entry state. The exit states are a set too.

When the merge drops or joins an entry state, its calls wait for the state
that took its place, and flow_do_united() gives them its exit states. 4005
of the 4095 calls end so: 50765 insns, today 530362. Else the limit stops
this test, 100 progs of the schedulers of rust-bpf and 124 of its tests.

The exit states of an entry are joined like the states at an insn, and the
joins must end. Thus an exit state that was joined more than 16 times is
widened. The entry and the exits of a recursive subprog are widened at
once.

Loops. Scalar evolution derives the count and the ranges of a loop from the
state that enters it. Thus the states that enter are a set of their own.
A copy of each new one, with these ranges, goes to the set at the head.
When a walk ends before the loop does, one state stands for the rest:
flow_end_walk() joins, with widening, the state that came back to the head
and the state one iteration before. They differ in what the loop changes.
Without it the schedulers of rust-bpf take 9 % more insns.

bpf_flow_deliver() sends a state along an edge, bpf_flow_next() gives the
next new state. An added may_goto is an edge that the prog does not have:
bpf_flow_guard_edge() sends a state along it only if the loop has may_goto
by now. Else it drops the state and notes that. If the loop gets may_goto
later, the prog is verified again.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 391 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 41e01bb33fb0..c4a6384d34bc 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2455,3 +2455,394 @@ static struct flow_state *flow_arrive(struct bpf_verifier_env *env, struct bpf_v
 	bpf_clear_singular_ids(env, &s->st);
 	return s;
 }
+
+/* Is that where may_goto in front of @insn_idx goes, as far as it's known? */
+static bool flow_guard_edge_is_real(struct bpf_verifier_env *env, int insn_idx, u8 edge)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+
+	return aux[bpf_loop_at_index(env, insn_idx)].loop->guarded &&
+	       aux[insn_idx].guard_no_unwind == (edge == BPF_GUARD_LEAVES_LOOP);
+}
+
+/*
+ * @st gets to @insn_idx if the loop has may_goto in front of @prev_insn_idx and that is where it
+ * goes, see check_loop_guard(). If that is not so, or not known yet, @st is dropped. If it turns
+ * out to be so later all is done again.
+ */
+int bpf_flow_guard_edge(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			int insn_idx, int prev_insn_idx, enum bpf_guard_edge edge)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+
+	if (flow_guard_edge_is_real(env, prev_insn_idx, edge)) {
+		aux[prev_insn_idx].loop_guard = true;
+		return bpf_flow_deliver(env, st, insn_idx, prev_insn_idx);
+	}
+	/* it's not going to leave the subprog any more */
+	if (edge == BPF_GUARD_LEAVES_SUBPROG && aux[prev_insn_idx].guard_no_unwind)
+		return 0;
+	aux[prev_insn_idx].guard_edge_dropped = true;
+	aux[bpf_loop_at_index(env, prev_insn_idx)].loop->no_guard_edges = true;
+	return 0;
+}
+
+/*
+ * @s came back to the head of a loop, and the walk through the iterations ends, see
+ * bpf_flow_loop_enter(). From now on a state stands for many iterations. The first such state is
+ * the join of @s with the state that it comes from, one iteration ago. Both were seen, and what
+ * differs between them is what the loop changes. If they have no join @s goes on as it is.
+ * A state of another walk, which began with another state, has nothing to do with @s.
+ */
+static int flow_end_walk(struct bpf_verifier_env *env, struct flow_set *set, struct flow_state *s)
+{
+	struct bpf_func_state *frame = s->st.frame[s->st.curframe];
+	struct loop_stack_entry *entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	u32 top = frame->loop_stack_cnt - 1, walk = entry->walk_id;
+	struct bpf_flow *flow = env->flow;
+	int insn_idx = s->st.insn_idx, err;
+	struct flow_state *t;
+
+	list_for_each_entry_reverse(t, &set->list, node) {
+		/*
+		 * The rules that hold for what comes around a loop, see flow_merge(). And one
+		 * more: the iteration has set a register, see flow_unset_differs(). The join
+		 * would be without it.
+		 */
+		if (flow_trips_behind(&t->st, &s->st) ||
+		    t->st.frame[t->st.curframe]->loop_stack[top].walk_id != walk ||
+		    (flow_has_room(env, flow->nr_states[insn_idx]) &&
+		     (flow_unset_differs(&t->st, &s->st) ||
+		      flow_needed_consts_differ(flow, FLOW_NEED_STACK_OFF, &t->st, &s->st) ||
+		      flow_needed_consts_differ(flow, FLOW_NEED_PTR_OFF, &t->st, &s->st))))
+			continue;
+		err = bpf_states_join(env, &flow->tmp, &t->st, &s->st, true);
+		if (err < 0)
+			return err;
+		if (err)
+			continue;
+		err = flow_unite(flow, s->st.flow_entry, t->st.flow_entry);
+		if (err)
+			return err;
+		flow->tmp.flow_entry = t->st.flow_entry;
+		flow->tmp.last_insn_idx = s->prev_insn_idx;
+		bpf_free_verifier_state(&s->st, false);
+		s->st = flow->tmp;
+		memset(&flow->tmp, 0, sizeof(flow->tmp));
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "from %d to %d: widened\n", s->prev_insn_idx, insn_idx);
+		break;
+	}
+
+	frame = s->st.frame[s->st.curframe];
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	entry->guarded = env->insn_aux_data[insn_idx].loop->guarded;
+	entry->apart = false;
+	entry->probe = false;
+	entry->decided = false;
+	entry->terminates = false;
+	entry->trip++;
+	entry->max_header_count = 0;
+	return 0;
+}
+
+/*
+ * @s goes into the set of the states at its insn. It is taken.
+ * @enters: it enters a loop.
+ */
+static int flow_add(struct bpf_verifier_env *env, struct flow_state *s, enum flow_cycle cycle,
+		    bool enters)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	int cur_idx = env->insn_idx, insn_idx = s->st.insn_idx, err;
+	const struct loop_stack_entry *entry;
+	const struct bpf_func_state *frame;
+	bool backedge = false, drop = false, ends_walk = false;
+	struct bpf_flow *flow = env->flow;
+
+	env->cur_state = &s->st;
+	env->insn_idx = insn_idx;
+	err = bpf_flow_loop_enter(env, &backedge, &drop, &ends_walk);
+	env->cur_state = cur;
+	env->insn_idx = cur_idx;
+	if (!err && ends_walk)
+		err = flow_end_walk(env, &flow->states[insn_idx], s);
+	if (!err && enters) {
+		frame = s->st.frame[s->st.curframe];
+		entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+		/* it has a count, see bpf_flow_loop_gets_guards() */
+		if (entry->terminates && !entry->guarded && !bpf_loop_walk_may_give_up(entry))
+			env->insn_aux_data[insn_idx].loop->no_guard_edges = true;
+	}
+	if (err || drop) {
+		flow_free_state(env, s);
+		return err;
+	}
+
+	err = flow_merge(env, &flow->states[insn_idx], &s, backedge ? FLOW_CYCLE : cycle);
+	if (err)
+		return err < 0 ? err : 0;
+	flow_set_pending(flow, s);
+	return 0;
+}
+
+/*
+ * @st gets to @insn_idx. What it holds is taken and @st is left empty.
+ */
+int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		     int insn_idx, int prev_insn_idx)
+{
+	struct bpf_flow *flow = env->flow;
+	struct bpf_subprog_info *sub;
+	struct flow_state *s, *e;
+	enum flow_cycle cycle;
+	bool enters = false;
+	int err;
+
+	s = flow_arrive(env, st, insn_idx, prev_insn_idx, &enters);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	/*
+	 * Cycles that have no loop head: the callback that came back to the helper
+	 * that calls it, and calls that go through the entry of a function.
+	 */
+	sub = bpf_find_containing_subprog(env, insn_idx);
+	cycle = FLOW_NO_CYCLE;
+	if (sub->recursive && sub->start == insn_idx)
+		cycle = FLOW_CYCLE;
+	else if (env->insn_aux_data[insn_idx].calls_callback && prev_insn_idx >= 0 &&
+		 env->prog->insnsi[prev_insn_idx].code == (BPF_JMP | BPF_EXIT))
+		cycle = FLOW_CALLBACK_CYCLE;
+
+	/*
+	 * What is known about a loop is derived from the state that enters it. So
+	 * the states that enter are a set of their own, and what gets to
+	 * the set at the head of the loop is derived from what is new in it.
+	 */
+	if (enters) {
+		err = flow_merge(env, &flow->enter[insn_idx], &s, cycle);
+		if (err)
+			return err < 0 ? err : 0;
+		cycle = FLOW_NO_CYCLE;
+		e = s;
+		s = flow_new_state(env, prev_insn_idx);
+		if (!s)
+			return -ENOMEM;
+		err = bpf_copy_verifier_state(&s->st, &e->st);
+		if (err) {
+			flow_free_state(env, s);
+			return err;
+		}
+	}
+	return flow_add(env, s, cycle, enters);
+}
+
+static void flow_free_call(struct flow_state *w)
+{
+	list_del(&w->node);
+	bpf_free_verifier_state(&w->st, false);
+	kfree(w);
+}
+
+/* @x came out of the function that the call @w waits for. @w may be gone afterwards. */
+static int flow_apply_exit(struct bpf_verifier_env *env, struct flow_state *w,
+			   struct flow_exit *x)
+{
+	int call_idx = w->st.insn_idx, err;
+	struct bpf_verifier_state st = {};
+	struct flow_state *s;
+
+	err = bpf_copy_verifier_state(&st, &w->st);
+	if (!err)
+		err = bpf_flow_return(env, &st, &x->st, call_idx);
+	if (!err)
+		err = bpf_flow_deliver(env, &st, call_idx + 1, call_idx);
+	bpf_free_verifier_state(&st, false);
+	if (err != 1)
+		return err;
+
+	/*
+	 * The call is verified in the context of the caller: it doesn't wait any more, it is
+	 * done again. Not with bpf_flow_deliver(): the state was at the insn before, it may
+	 * be there still.
+	 */
+	s = flow_new_state(env, w->st.last_insn_idx);
+	if (!s)
+		return -ENOMEM;
+	s->st = w->st;
+	memset(&w->st, 0, sizeof(w->st));
+	flow_free_call(w);
+	flow_shape_ctx(&s->st, &s->shape);
+	flow_link(env, &env->flow->states[call_idx], s);
+	flow_set_pending(env->flow, s);
+	return 0;
+}
+
+/* What came out for the set of @from goes to the calls that wait for the set of @to */
+static int flow_apply_exits(struct bpf_verifier_env *env, struct flow_entry *from,
+			    struct flow_entry *to)
+{
+	struct flow_state *w, *wn;
+	struct flow_exit *x;
+	int err;
+
+	list_for_each_entry(x, &from->exits, node) {
+		list_for_each_entry_safe(w, wn, &to->calls, node) {
+			err = flow_apply_exit(env, w, x);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int flow_do_united(struct bpf_verifier_env *env)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_entry *a, *b;
+	struct flow_united u;
+	int err;
+
+	while (flow->united_cnt) {
+		u = flow->united[--flow->united_cnt];
+		a = flow_entry_find(flow, u.a);
+		b = flow_entry_find(flow, u.b);
+		if (a == b)
+			continue;
+		err = flow_apply_exits(env, a, b) ?: flow_apply_exits(env, b, a);
+		if (err)
+			return err;
+		list_splice_tail_init(&a->calls, &b->calls);
+		list_splice_tail_init(&a->exits, &b->exits);
+		a->up = b;
+	}
+	return 0;
+}
+
+/*
+ * The call at @call_idx in @caller of a function that is verified on its own,
+ * @entry is the state at its first insn. Both are taken.
+ */
+int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		  struct bpf_verifier_state *entry, int subprog, int call_idx)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_state *w;
+	int id;
+
+	w = kzalloc_obj(*w, GFP_KERNEL_ACCOUNT);
+	if (!w)
+		return -ENOMEM;
+	w->st = *caller;
+	memset(caller, 0, sizeof(*caller));
+	w->st.insn_idx = call_idx;
+
+	id = flow_entry_new(flow);
+	if (id < 0) {
+		bpf_free_verifier_state(&w->st, false);
+		kfree(w);
+		return id;
+	}
+	list_add_tail(&w->node, &flow->entries[id]->calls);
+
+	entry->flow_entry = id;
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "call at %d waits for func#%d\n", call_idx, subprog);
+	return bpf_flow_deliver(env, entry, env->subprog_info[subprog].start, call_idx);
+}
+
+/* @st came to exit of the function that is verified on its own. It is taken. */
+int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_func *f = &flow->funcs[st->frame[0]->subprogno];
+	u32 id = st->flow_entry, cnt = 0;
+	struct flow_exit *x, *o, *on;
+	struct flow_state *w, *wn;
+	struct flow_entry *entry;
+	u16 joins = 0;
+	int err;
+
+	st->insn_idx = exit_idx;
+	err = bpf_clean_verifier_state(env, st);
+	if (err)
+		return err;
+	if (f->exit_idx < 0)
+		f->exit_idx = exit_idx;
+	st->insn_idx = f->exit_idx;
+	entry = flow_entry_find(flow, id);
+
+	list_for_each_entry_safe(o, on, &entry->exits, node) {
+		if (bpf_state_subsumes(env, &o->st, st))
+			return 0;
+		if (flow_has_room(env, ++cnt) && flow_join_makes_up(flow, &o->st, st))
+			continue;
+		/* what comes out of a recursive function gets into it again */
+		err = bpf_states_join(env, &flow->tmp, &o->st, st,
+				      env->subprog_info[st->frame[0]->subprogno].recursive ||
+				      o->joins > BPF_FLOW_MAX_JOINS);
+		if (err < 0)
+			return err;
+		if (err)
+			continue;
+		joins = max(joins, o->joins) + 1;
+		bpf_free_verifier_state(st, false);
+		*st = flow->tmp;
+		memset(&flow->tmp, 0, sizeof(flow->tmp));
+		st->flow_entry = id;
+		list_del(&o->node);
+		bpf_free_verifier_state(&o->st, false);
+		kfree(o);
+	}
+
+	x = kzalloc_obj(*x, GFP_KERNEL_ACCOUNT);
+	if (!x)
+		return -ENOMEM;
+	x->st = *st;
+	memset(st, 0, sizeof(*st));
+	x->joins = joins;
+	list_add_tail(&x->node, &entry->exits);
+
+	list_for_each_entry_safe(w, wn, &entry->calls, node) {
+		err = flow_apply_exit(env, w, x);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * Make the next pending state the current one. env->cur_state has to be empty.
+ * Returns -ENOENT when nothing is pending.
+ */
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_state *s;
+	struct rb_node *n;
+	int err;
+
+	do {
+		err = flow_do_united(env);
+		if (err)
+			return err;
+	} while (flow->united_cnt);
+	n = rb_first_cached(&flow->pending);
+	if (!n)
+		return -ENOENT;
+	s = rb_entry(n, struct flow_state, rb);
+	rb_erase_cached(&s->rb, &flow->pending);
+	s->pending = false;
+
+	env->insn_idx = s->st.insn_idx;
+	*prev_insn_idx = s->prev_insn_idx;
+	if (test_bit(s->st.insn_idx, flow->keep))
+		return bpf_copy_verifier_state(env->cur_state, &s->st);
+	*env->cur_state = s->st;
+	memset(&s->st, 0, sizeof(s->st));
+	s->st.insn_idx = env->insn_idx;
+	flow_unlink(env, s);
+	flow_free_state(env, s);
+	return 0;
+}
-- 
2.55.0

