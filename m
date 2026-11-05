Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911605;
	b=zv+d3psQdoqD19s+reg8xj0jf8E9b7PueNRwrNry979z1+fNlGYL6Qn2ymySf4fp4u0l
	 KfurdWccMKorZ1bOMAmg/uiHxhNFbGGC9qKMEh2O6D0SJ9llkVOidoKQLEe8Ta7EtGx4Y
	 uqrDR3WqACiE2xQZx5IToutRG4M1qarj33V1h57s42B/VqvbC1RMnG2xm/WaO369TA6q9
	 ZkK9LihBns1epge6dqnsHv1KnrBfdodGRLPiGcw90Mg07iFMC3HWcaAthfhsu0pH7Ztth
	 A6hS0fDXa9qrbRoAHGA9oFl2hOiw1WUPo0eFSlu0tipm2nSsIhD54itojjsYMRSA+1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7lyuTUxWw5hgr/98kJ7THD3HuUwN3Gg2/Vr8MEucI64=;
	b=hfckWuNd4bB17GSfSr0K01jmlx70hPeOTnqb1wSwCJu7U2WuV9G3vZbmjwra/hZSSipk
	 49V3bvOQClwiUevpfrsgdIb9EJRbcs3+X4NTsdoxbM/vPPMFrj79h+Y0xfsdbu3gAf7oi
	 qnebufAlsRUd5F99hj+I1UAT0JFBr9YIYcjPZF09+7i8PglhyB67h5jFbM1+A9b+b0yeL
	 3fvo787XKNHEJbitEaSS4uHXjTv0AzGuVEzwx9V4HuNqWP4jH9l49U53b2H5RAxvQKNZL
	 BhS8YVobTX8taSW/6dlD3aUsEngYbbK8JBCPZr34ulitfYdjuMnwt/6YvENt4KB2DoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGuJz2k6;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBB606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BBB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGuJz2k6
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1170731a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911605; x=1794516405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lyuTUxWw5hgr/98kJ7THD3HuUwN3Gg2/Vr8MEucI64=;
        b=sGuJz2k6Oo/22fApAdqor1GQwt/Do9e5v5J7xQ/akGc08CLsGfNjrJowLwh1SNtzNA
         YtFAI5Wc8V+0CAuXVTe7B1aNgr5hBXQNNP3ONV9XYkvS0UysRC7TAhJSdS/E+QICkfZA
         TwinaroZJlmGL1Lt2jBbB++SDJyE5eVweuB1GjRYLVZCJZDfBFc3OBKxvIcGVBfPqWQJ
         chI1PNi0ESPS897WM2OL0hvn/Ks2WsQPntR4ViAPlsMr+tbFXrY6KZ3JF2bZfOYQxUfP
         zTtaSPrNJ8IT1/qgjTQF2TJF1g9Q086+/9fYDXVouzp+4TA5fHGVcJHIiFeYJmK+i4bz
         koHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911605; x=1794516405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7lyuTUxWw5hgr/98kJ7THD3HuUwN3Gg2/Vr8MEucI64=;
        b=tuHRir+n5Lxglzrj6+s1HIXrJjcuxoM1uOp7AQ2bCpurTZnf53kTVzLmAuz2CDskXZ
         IRQsNln/BNTvJWePIzjngeAhKTaq1I53NyeXUfOLOfM1odOzmuTCnAZeBfqkxYyKDx9D
         3yuxfmpx/oOkc7TZmroDeQuouWxm7EwekXroz2r72rFEyQOlknEQrgDP/6cV3m10LrnJ
         kKPDwfAbgW8zXkSji+LJH4uULK6Vdmjk0oIo86aIP7+oQxWp9EUo1Syed/6lfHoYSHGH
         jQcDt6M8aKqBRD/pxVG7f1rPsd99XuW6WWnjlQgRWifFFya3RDRwkdI1IpoE4krX7Cz4
         Izig==
X-Gm-Message-State: APuU4Z+pK9Shqizi2sAr+ryvW7KfdM0SJD4bZpsc9oUxWPLbKD9PqIt6
	byISnWDXoZ2URMzUQXUmHGNkhfvaAo5J4oJFvwWp5vr3wGKkU2h160lco296sw==
X-Gm-Gg: AYBFou19hGqMmSmdoQiGyF4Up2D/KR/hpafW35Zwd/xbdET1FM17jV/Gz2rX1pZcVSZ
	QeqnqMZ5pviZr+CWrKqXwYnzCqOI0ThovuMMxkBIvzNcyvZcDu9tTrThFr4J3JCRQUMUw6owID/
	Np++uFMj08tcLyfYE8NmHb/RUTh6gIe6bYfvvMJLCd+VTRM95NekwD3lSNoUX1xxPAbOitM9GSC
	tB+pHqCeJDF9PbMwX3qojieDOw17+zu7JR8e+Neu5awOYmGgZv/B1YgwaZ6zhQRq+x4m9Ra0CYQ
	tptW60oo0UgVucM19L0LeqMxnc9YK/fYeWv0XjOmra8zym69xX0HIzrRfnmo5R43t5GrPddV+45
	Dz3FjBcsmCI3LFEJi3DAV1HLX6P5RnYTDpiRlbhGnR749l6JmHKNACvaWmTrsIaASiMfScftSMt
	j7o3w1LOiGX56VDrxziQ5wh7NQtbT4vDGt4JGz8/KLVfXDMYrnvexAn8Ys9cLiIEtTDy8LxQ4cL
	sKMuvQCgMyClSstCIFP2YC8Kz+/6KqP5Lc0pI1HnoAw2+u87uRWfEBjU3S7CHOw3UYTetlImvjz
	ik4xO9Nyaj7JP2Tac0BVUXT8LyzBDCcSzGWuJ8i+6zZNxiLpXoyuSGr7VLfesWL6NzqI8fPWvg5
	tf0iRDvJNHN7O53AXAwyxSrKdVvFKj2G0H1loUok2wDIIpC3yW+ZHYbChbqa4FOVKs4yw7B6SAg
	==
X-Received: by 2002:a17:90b:3804:b0:3ad:b8c8:4a84 with SMTP id 98e67ed59e1d1-3b0db6bb621mr195362a91.26.1793911604470;
        Thu, 05 Nov 2026 12:46:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm5075341a91.3.2026.11.05.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 15/35] bpf: Move states along edges, into loops and subprogs and out of them
Date: Thu,  5 Nov 2026 20:44:52 +0000
Message-ID: <20261105204513.2230344-16-alexei.starovoitov@gmail.com>
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
index ad9c0187b463..459b29797739 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2405,3 +2405,394 @@ static struct flow_state *flow_arrive(struct bpf_verifier_env *env, struct bpf_v
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

