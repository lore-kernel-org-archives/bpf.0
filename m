Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160844;
	b=kI0c2wUik/e2F2Ln+f2ezGUYHwACdu6apEo3uH4jDIMfFFMcLUlSGbA2nQ/cixez8Wps
	 HijXvBwHw3ymxIh0W8mwSVMxdy2VPE10WiMTEixWJw73sMU6ODKj+aKFTwS+xEH+dkgB6
	 xyMqqgkjfnvyIZopXaWKdzAkJijrSJNRat4U8snVeYC8eZjCAqjQ6zaN3431Yc2pH7xvQ
	 lH0yq8qr+/TiqLy5qGz8RGBDJcqOaIy45jUgtQ4FUXx11VPw6lmkRO1xtRcfA5tuJrWhI
	 LZSBY+dXkjAsbUz4IwPs59ov5Cq4JJZ4jBbBT6xQhV40BUAFCjFaMx5nGPqmLgmTr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RqBY7R8bQbZpCown8y8sbqVAbTv3sqVJVi70U0n9L/Q=;
	b=m+rtXdfUCGg0AUZUyDBNxN0XOAe1FVCnUxQM05lzQSlX1fTtLC+CXBIjBIcJN1doorhd
	 ShAmQFqN6R1G1bPHRK0R8KuCs++/QHfjuRA+iYIiRWgmJxXWx79UzdjnMq6XEbDFIi02S
	 rK6cGAubKJ1yGQTuSU3odRN13qXeEohs90yzhOo4D0BgLwj64CkfU0fPqWWy8/jHWTNOi
	 Ge3M34Ou8T3VNNxDy7gdlyLHKeHif0kxC37D0xUk570TJOFhVDVyzYMM4ySOkLLaz/KYX
	 4VV3ePbgeB7FD9S7Goy8p68QzFSIIJAiKIaDRQdRzj/j/jZ6SI4pDTdDb2kzKp09bgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljo8a7PJ;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764D606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6764D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljo8a7PJ
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so335304b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160844; x=1795765644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqBY7R8bQbZpCown8y8sbqVAbTv3sqVJVi70U0n9L/Q=;
        b=ljo8a7PJCfP+mowggrZZHmGinCbm8OJUCmkfLLRCfTP32AhwoGYIusKv+c+1fR9Ulf
         sTK+DGlubAEHYa9NcfcJuzRN+Qe6PwIrQzMH4Q8SFRc0wRfuToaof14AURiBdKSPdBYg
         Yfx8lwVRUMKtfhO5WUhRKulF2RSaEO/aWdEMKKDjtUfsPLTv+HOCN1Kvk9si8ncTvnzL
         8FUMOszBfo4ncPyxjrl5wK1rSxLbMYUR3ELe7WEHfq9yTMq8kzIQu+S6CvgwSObJM/Wy
         I2Xz5/3ZkuaEdmKOL3U0fTpmKBZp3Lg2Qm24u2Adt3HU4T/XSRhUgIKLTbRs+Wqm8LbD
         Ipqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160844; x=1795765644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqBY7R8bQbZpCown8y8sbqVAbTv3sqVJVi70U0n9L/Q=;
        b=rzT82KuyvZWbX+te27/Gc1humAj7AJNu0VIjz/OSizF76A4omSUycbWEz0lo7RvGK+
         40bIMeHbmrFn9c9oArqkLjrPFGkjNze0DtS/QQ8CTBIwFaP/ecfzd8qqkDayIs1aBXsi
         rXELRGLPkKI/qDykPS3Uz/whp6HOHxLIcsJoTVbucUCWDuFI13W535L3boCQWzC7aM45
         Xjy5fxBvhu6gKPT27gal5zSPcs9tIXf30i6Vm6L/eCJQllmCzZywUE7sIeG67hRrX6ej
         UTn9P/Qtiy0bTcvXocp2a5AhHgaG5+3ZD+rudChI5oh60IczQcntewKNWjOcqzZC20XX
         pDpw==
X-Gm-Message-State: APuU4Z+JzgcmEzUHNdHUXXehWWH0qoldpHqdyE/WLaOMssOweBSlwOGY
	Qt8OYjstamwVJLC6qtLdaEytG/A8BGwdO+/Oy9+n1rhA8pVyO4rlxGfDMb/DlA==
X-Gm-Gg: AZFdTZdJD4ISlEOw/wF2isqsd+h6HndF2dGDmK5v/WbUONppG8fSHsfHVMEWb1enVzI
	8F6nBx5gsx4aewhNHSxTpUbUdP0glgJ9gXBWX8e08cm+4y6i0AmXDdCiNm0ag+e5px6gWgZ/rME
	RKsmWwJaPIOsz/Nh5GGnyms9fY4p2aMOgrOBrW23M5mFX9i/bt8DwSGxLuTGWXZ17xlCxuFILh4
	3x9TMtIq9CdWGe8BNNmplyseXB7ftP1fwuv1jT+ryTkHYQfcC8Du0Ql71/JebiWFEBX4jeyjg9s
	vlG10NGjnDexRcHhjJdBX41zvuY78cK7+p/QR4XpvmmfkvJdJgJiIP5K3WLwBpu2W+hWVm7YvC3
	hG3C/NbNuPV5CinihzqVNQ8Pn404e3plh1mjA/Fz/RTn9V5y8Zs6HyGUBscBOBEld5fRbIETiHw
	dYi+zidWEvxN7lx5ec3/Aq7jQ/47Re0LtniO9SSXG7eFBCeHzNxAUCaPaDaqYph1Qyj0qiSbCZf
	cFjtWzJaYnJCLwxOHOI3thV8x4JpmUOvC1JCVf6VsRE+zB7hl1GaNPM2SH0V9vXD8qMQlZWECwW
	JoU7rBF8wh9e0NmhZV1DXW/iIGgZJcJZn15cTQbS0uhM4TKiFUtdeyJObQZqyWXwtcheGg4bYMw
	QbbrJQm1j7kEHP6JukatxOPDhZf1gZUETSD4rF4FZqIkn6bnUv14XtjoHl8dCJsn7V1dDL6cyBn
	8=
X-Received: by 2002:a05:6a00:4c0d:b0:886:84c7:72b3 with SMTP id d2e1a72fcca58-8c87c388190mr2047689b3a.26.1795160843328;
        Thu, 19 Nov 2026 23:47:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm1121252b3a.9.2026.11.19.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:47:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 29/49] bpf: Order the pending states and free the states that are done
Date: Fri, 20 Nov 2026 07:42:01 +0000
Message-ID: <20261120074430.2704488-30-alexei.starovoitov@gmail.com>
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

The order decides how often an insn is checked. A join point has to get
all its states before it runs:

  if (c) x = 1; else x = 2;      both branches first,
  use(x);                        then one check with x = 1..2

flow_set_pending() sets the order:
1. a function that a call waits for,
2. callers, so that the calls of a function meet before it is checked,
3. the trip and the position in each frame: a trip is complete before
   the next trip, a loop before the code after it,
4. exit states last.

With this order most states can meet no later state. They are freed
when their turn comes. flow_keep() keeps a state at a join point
- in the leftover of a loop, until the states leave the loop,
- at the start of a peeled trip (0, 1, 2, 4, 8, ...), to find a trip
  that repeats a state,
- at the entry of a function, or while a call can get more exit states,
- in an async callback, because it can start again.

Without that the memory grows with the number of peeled trips.

do_check() takes the next state and checks its basic block.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  10 ++
 kernel/bpf/flow.c            | 293 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  41 +++++
 3 files changed, 344 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f153e5e7c28..a310ad50941 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -453,6 +453,12 @@ struct loop_stack_entry {
 	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
 };
 
+/* The states of trip 0, 1, 2, 4, 8, ... are saved. A compare with them finds any period. */
+static inline bool bpf_trip_is_saved(const struct loop_stack_entry *entry)
+{
+	return !(entry->trip & (entry->trip - 1));
+}
+
 #define LOOP_STACK_SIZE 16
 
 /* state of the program:
@@ -831,6 +837,7 @@ struct bpf_loop_per_pass {
 	bool has_leftover;	/* the peeled trips were not enough */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
+	u32 last_peeled_trip;	/* see flow_keep_peeled() */
 	u32 peeled_cnt;		/* trips that the pass peeled */
 	u64 cost;		/* for the states that the loop keeps apart */
 };
@@ -1329,10 +1336,12 @@ struct bpf_verifier_env {
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	bool for_log;			/* the verdict is known, see do_check_all() */
+	bool fallthrough_first;		/* see find_failing_path() */
 	struct bpf_precision *precision;
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
 	u64 hash_seed;			/* see bpf_hash_join_key() */
+	u64 failing_path_budget, failing_path_max_cost;	/* see find_failing_path() */
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
 	bool no_mem;			/* a table cannot grow, see bpf_check_limits() */
@@ -1712,6 +1721,7 @@ void bpf_flow_free(struct bpf_verifier_env *env);
 bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx);
 int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 		     int insn_idx, int prev_insn_idx, bool again);
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos, u64 *diag_pos);
 int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		  struct bpf_verifier_state *entry, int subprog, int call_idx);
 int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 9c96f10f3ac..5fbbb09a665 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -642,6 +642,82 @@ bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx)
 	return test_bit(insn_idx, env->flow->bb_starts);
 }
 
+/* A peeled trip is complete before the next one starts. The leftover is last. */
+static int flow_cmp_trips(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
+{
+	const struct loop_stack_entry *ea = fa->loop_stack, *eb = fb->loop_stack;
+	u32 i, ta, tb;
+
+	for (i = 0; i < fa->loop_stack_cnt && i < fb->loop_stack_cnt; i++, ea++, eb++) {
+		if (ea->loop != eb->loop)
+			break;
+		ta = ea->peeled ? ea->trip : U32_MAX;
+		tb = eb->peeled ? eb->trip : U32_MAX;
+		if (ta != tb)
+			return ta < tb ? -1 : 1;
+	}
+	return 0;
+}
+
+static bool flow_less(struct rb_node *na, const struct rb_node *nb)
+{
+	const struct flow_state *a = rb_entry(na, struct flow_state, rb);
+	const struct flow_state *b = rb_entry(nb, struct flow_state, rb);
+	int cmp;
+	u32 i;
+
+	if (a->priority != b->priority)
+		return a->priority < b->priority;
+	for (i = 0; i < a->order_len && i < b->order_len; i++) {
+		cmp = flow_cmp_trips(a->st.frame[i], b->st.frame[i]);
+		if (cmp)
+			return cmp < 0;
+		if (a->order[i] != b->order[i])
+			return a->order[i] < b->order[i];
+	}
+	if (a->order_len != b->order_len)
+		return a->order_len < b->order_len;
+	/* a speculative state gets a barrier if the fixups of the others do not fit */
+	if (a->st.speculative != b->st.speculative)
+		return b->st.speculative;
+	return a->seq < b->seq;
+}
+
+/*
+ * The order of pending states:
+ * 1. An instance that a call waits for. The call has no exit state to continue. It waits at
+ *    its position in the order. The code after the call waits too.
+ * 2. Callers. So the calls of a function get to it before it is checked.
+ * 3. The trip, then the position, in each frame. A callee in the frames of its callers is
+ *    complete before the code after the call.
+ * 4. Exit states. They go to the calls when the instance is complete.
+ *
+ * A path-sensitive run goes depth first, to the state that is nearer to an unproven insn.
+ */
+static void flow_set_pending(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	const struct bpf_verifier_state *st = &s->st;
+	struct bpf_flow *flow = env->flow;
+	struct flow_instance *instance = flow_state_instance(flow, s);
+	u32 i;
+
+	s->priority = instance->priority ?:
+		      BIT_ULL(63) | (u64)flow->rank[st->frame[0]->subprogno] << 32 | ~instance->id;
+	for (i = 0; i < st->curframe; i++)
+		s->order[i] = flow->pos[st->frame[i + 1]->callsite];
+	s->order[i] = s->kind == FLOW_FUNC_EXIT ? U32_MAX : flow->pos[st->insn_idx];
+	s->order_len = i + 1;
+	if (env->path_sensitive) {
+		s->priority = (u64)~env->insn_processed << 32 | (env->fallthrough_first ?
+			      st->insn_idx != s->prev_insn_idx + 1 :
+			      bpf_failing_path_hops(env, st));
+		s->order_len = 0;
+	}
+	s->pending = true;
+	instance->pending_cnt++;
+	rb_add_cached(&s->rb, &flow->pending, flow_less);
+}
+
 /*
  * States meet only if they have the same hash. The tree sorts them by a half of the hash,
  * then by the range of one xreg of data_deps. Two ranges with a gap stay apart, but not where
@@ -674,6 +750,125 @@ static struct flow_state *flow_find(struct bpf_verifier_env *env, struct flow_st
 	for (t = flow_find(env, s);							\
 	     t && (tn = flow_tree_iter_next(t, (s)->first, (s)->last), true); t = tn)
 
+/*
+ * The loop that @st came around or entered, if @st is at a header. One insn can be the header
+ * of a jump loop and of the calls of a callback.
+ */
+static struct loop_stack_entry *flow_header_entry(const struct bpf_verifier_state *st)
+{
+	const struct bpf_func_state *frame = st->frame[st->curframe];
+	struct loop_stack_entry *e = NULL;
+	u32 i = frame->loop_stack_cnt;
+
+	while (i-- && frame->loop_stack[i].loop->header == st->insn_idx && !(e && e->trip) &&
+	       frame->loop_stack[i].loop->kind != BPF_LOOP_RECURSION)
+		e = &frame->loop_stack[i];
+	return e;
+}
+
+/* If more than one state starts a peeled trip, paths of other lengths can come to one state */
+static bool flow_keep_peeled(struct bpf_verifier_env *env, struct loop_stack_entry *e)
+{
+	bool more = e->loop->this_pass.last_peeled_trip == e->trip;
+
+	e->loop->this_pass.last_peeled_trip = e->trip;
+	if (!more && !bpf_trip_is_saved(e))
+		return false;
+	e->entry_id = ++env->loop_entry_cnt;
+	return true;
+}
+
+/*
+ * @s is the next pending state. Can a state with the same join_key arrive later?
+ * - In the leftover of a loop: until the states leave the loop.
+ * - At the start of a peeled trip: later trips are compared with it.
+ * - A call can get more exit states: until all calls have them and the late states went by.
+ *   In a peeled trip the call waits.
+ * - An async callback can start again: until the check ends.
+ */
+static bool flow_keep(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	const struct bpf_verifier_state *st = &s->st;
+	struct loop_stack_entry *e, *header_entry = flow_header_entry(st);
+	struct flow_instance *instance = env->flow->instances[st->instance_id];
+	bool in_loop = false, keep;
+	u32 fr, i;
+
+	if (!test_bit(st->insn_idx, env->flow->join_points) || env->path_sensitive ||
+	    s->kind == FLOW_AGAIN)
+		return false;
+	if (s->started_instance)
+		return true;
+	s->late_exit_reaches = true;
+	s->kept_frameno = U8_MAX;
+	for (fr = 0; fr <= st->curframe; fr++) {
+		e = st->frame[fr]->loop_stack;
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++, e++) {
+			if (s->kind == FLOW_LEFTOVER && e == bpf_top_loop(st->frame[st->curframe]))
+				break;
+			if (e == header_entry && e->peeled && s->kind == FLOW_AT &&
+			    flow_keep_peeled(env, e))
+				s->kind = FLOW_PEELED;
+			keep = !e->peeled || (e == header_entry && s->kind == FLOW_PEELED);
+			if (e->loop->kind != BPF_LOOP_RECURSION && (e->peeled || !in_loop)) {
+				s->late_exit_reaches &= !e->peeled;
+				s->kept_frameno = fr;
+				s->kept_depth = i;
+				in_loop = keep;
+			}
+			if (e == header_entry && keep)
+				break;
+		}
+	}
+	if (s->late_exit_reaches && st->frame[0]->in_async_callback_fn)
+		return true;
+	keep = in_loop || (s->late_exit_reaches && instance->open_call_cnt);
+	if (keep)
+		list_add_tail(&s->node, &instance->done);
+	return keep;
+}
+
+/* Later trips find @s without the number of its trip */
+static void flow_insert_peeled(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	flow_header_entry(&s->st)->trip = 0;
+	flow_tree_remove(s, &env->flow->state_tree);
+	flow_find(env, s);
+	flow_tree_insert(s, &env->flow->state_tree);
+}
+
+/* @next is the next pending state. Did the states leave the loop that @s is kept for? */
+static bool flow_loop_is_left(struct flow_state *s, const struct flow_state *next)
+{
+	const struct loop_stack_entry *es, *en;
+	const struct bpf_func_state *fs, *fn;
+	u32 fr, i;
+
+	/* a call returned late */
+	if (!flow_less(&s->rb, &next->rb))
+		return false;
+	if (next->st.curframe < s->kept_frameno)
+		return true;
+	for (fr = 0; fr <= s->kept_frameno; fr++) {
+		fs = s->st.frame[fr];
+		fn = next->st.frame[fr];
+		if (fs->subprogno != fn->subprogno || fs->callsite != fn->callsite)
+			return true;
+		for (i = 0;
+		     i < (fr < s->kept_frameno ? fs->loop_stack_cnt : s->kept_depth + 1); i++) {
+			es = &fs->loop_stack[i];
+			en = &fn->loop_stack[i];
+			if (i >= fn->loop_stack_cnt || es->loop != en->loop)
+				return true;
+			if (es->peeled && (!en->peeled || es->trip != en->trip) &&
+			    !(s->kind != FLOW_AT && en->peeled && fr == s->kept_frameno &&
+			      i == s->kept_depth))
+				return true;
+		}
+	}
+	return false;
+}
+
 static struct flow_instance *flow_new_instance(struct bpf_verifier_env *env,
 					       struct flow_state *entry)
 {
@@ -935,3 +1130,101 @@ int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 	}
 	return flow_add(env, s, false);
 }
+
+/*
+ * Make the next pending state the current one. env->cur_state has to be empty.
+ * Returns -ENOENT when nothing is pending.
+ */
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos, u64 *diag_pos)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_state *s, *t, *tn;
+	struct flow_instance *instance;
+	struct rb_node *n;
+	bool leftover, starts;
+	int err = 0;
+
+again:
+	if (flow->last_instance && flow->last_instance->cost)
+		*flow->last_instance->cost += env->cost - flow->charged_cost;
+	flow->charged_cost = env->cost;
+	if (flow->last_instance)
+		flow_end_instance(env, flow->last_instance);
+	n = rb_first_cached(&flow->pending);
+	if (!n)
+		return -ENOENT;
+	s = rb_entry(n, struct flow_state, rb);
+	flow_clear_pending(flow, s);
+	flow->last_instance = flow_state_instance(flow, s);
+	instance = s->callee;
+	if (instance) {
+		if (instance->entry_state && !instance->priority) {
+			instance->priority = BIT_ULL(63) - ++flow->priority_gen;
+			flow_clear_pending(flow, instance->entry_state);
+			flow_set_pending(env, instance->entry_state);
+		}
+		goto again;
+	}
+	instance = flow->instances[s->st.instance_id];
+	while (!s->started_instance && !list_empty(&instance->done)) {
+		t = list_last_entry(&instance->done, struct flow_state, node);
+		if ((t->late_exit_reaches && instance->open_call_cnt) || !flow_loop_is_left(t, s))
+			break;
+		flow_free_state(env, t);
+	}
+
+
+	env->insn_idx = s->st.insn_idx;
+	if (s->kind == FLOW_FUNC_EXIT) {
+		list_for_each_entry_safe(t, tn, &instance->waiting_calls, node) {
+			err = flow_apply_exit(env, t, s);
+			if (err)
+				return err;
+		}
+		goto again;
+	}
+	*prev_insn_idx = s->prev_insn_idx;
+	if (env->path_sensitive) {
+		*log_pos = s->log_pos;
+		*diag_pos = s->diag_pos;
+	}
+	leftover = s->kind == FLOW_LEFTOVER;
+	starts = leftover || s->started_instance;
+	if (!flow_keep(env, s)) {
+		flow_unlink(env, s);
+	} else if (!starts) {
+		err = bpf_copy_verifier_state(env, env->cur_state, &s->st);
+		if (s->kind != FLOW_AT)
+			flow_insert_peeled(env, s);
+		goto out;
+	} else {
+		t = s;
+		s = flow_new_state(env, t->prev_insn_idx);
+		if (!s)
+			return -ENOMEM;
+		err = bpf_copy_verifier_state(env, &s->st, &t->st);
+		if (err) {
+			flow_free_state(env, s);
+			return err;
+		}
+		if (t->started_instance) {
+			s->st.instance_id = t->started_instance->id;
+			t->started_instance->entry_state = NULL;
+		}
+	}
+	if (starts) {
+		err = flow_add(env, s, leftover);
+		if (err)
+			return err;
+		goto again;
+	}
+	swap(*env->cur_state, s->st);
+	flow_free_state(env, s);
+out:
+	/* all ids have names, see bpf_renumber_ids() */
+	env->id_gen = 0;
+	/* the state at the header stays as it was widened, else the sequence possibly never ends */
+	if (!err && env->cur_state->equations.needs_refine)
+		bpf_equations_refine_all(env, env->cur_state);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 710c3113e61..cb79c91ae1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21584,6 +21584,47 @@ static bool round_is_dropped(struct bpf_verifier_env *env)
 	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
 }
 
+static int do_check(struct bpf_verifier_env *env)
+{
+	bool level2 = env->log.level & BPF_LOG_LEVEL2;
+	u64 log_pos = env->log.end_pos, diag_pos = 0, cost = env->cost;
+	int prev_insn_idx, err;
+
+	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1, false);
+	while (!err && !(env->path_sensitive && env->cost >= env->failing_path_max_cost)) {
+		err = bpf_flow_next(env, &prev_insn_idx, &log_pos, &diag_pos);
+		/* at the limit the work on equations is not complete, such a pass proves nothing */
+		if (err == -ENOENT)
+			return bpf_check_limits(env);
+		if (err)
+			break;
+		charge_loops(env, env->cost - cost);
+		cost = env->cost;
+		/* A pass logs one basic block at a time. A path-sensitive run logs a full path. */
+		bpf_diag_event_log_restore(env, diag_pos);
+		if (!level2) {
+			bpf_vlog_reset(&env->log, log_pos);
+			env->prev_linfo = NULL;
+		}
+		err = do_check_block(env, prev_insn_idx);
+		if (env->bug)
+			return -EFAULT;
+		/* a pass had no error at this insn, possibly with a state that has more values */
+		if (err && env->path_sensitive && is_error_of_state(env, err) &&
+		    (env->cur_state->infeasible || env->cur_state->equations.infeasible ||
+		     !bpf_failing_path_may_end_at(env, env->insn_idx))) {
+			bpf_free_verifier_state(env, env->cur_state, false);
+			memset(env->cur_state, 0, sizeof(*env->cur_state));
+			free_pushed_states(env);
+			err = 0;
+		}
+	}
+	/* bpf_flow_edge_unproven() noted it with the state that failed */
+	if (err && !bpf_insn_is_unproven(env))
+		note_error(env, err);
+	return err;
+}
+
 static int find_btf_percpu_datasec(struct btf *btf)
 {
 	const struct btf_type *t;
-- 
2.55.0

