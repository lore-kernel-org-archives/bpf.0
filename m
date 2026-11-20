Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207981;
	b=F7D9hsSEzWODPqJzzgeQA3AIIhHnnTeJgJLMXPwc8RcTwTOa6zgAasDhF7saB6dJe0dx
	 z6P1vEVI2kaAPzJU5Uz/5yPEpkZ+1sYz0zVYIVOkzNaPbGJFo0azzNhTcJGvpIWE2mLrU
	 WGKDh01Zjgg+798vXaM6wcd+2yXSnKw78p3a9r6+YE6v/tD3FCqUuoVfEZeDcBbnGJfZJ
	 BcmoDrA/Bxt8efqO68p+G6NGsEMzJATS3wktX9aoV76nhh5Ayvrgz73/EyUGMYVDiJzQq
	 1xTC62P0BitPddb4ZxVkOoPSuAItwn4pBnJuB1LfboczfInMsW4J6qY79BQRObZHMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lyDondtI9/yJ/PNMNZjGkzOq4ZzEkeYx+hiMu13qphA=;
	b=TkKASDW1U9cINBxMBSsmHQSCqkMhzaAc2ldbAbLtg8zoqKLN/q1o15uQTWgomyEXwEHI
	 RllYiAMVYJCHpyeAvmMjKgpJHuC4OQ7nzhYC5EBptLWo3FmqK3eo0BWsknusKGdWeqfKX
	 FaLfXVy/qXz623ceFF1uZOnShRiaa7jDrvCVX8W6powseWI8fPokuGMUcOVdQzUa3Mgpn
	 JycChPoo830FQMuETzL/Ae1fNRLn57uzhnrAu/5ItveBV65KseW3Ceir6y0g5vC1BjNHu
	 xQqZs8p614sS7cD42s2L54bB24YLXUOKM9fBRuWREXT8h1pOkKPoaSLM20XFnW2faWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwDBKsDQ;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAE606A68E
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0EAE606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwDBKsDQ
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc758830601so1082775a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207975; x=1795812775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyDondtI9/yJ/PNMNZjGkzOq4ZzEkeYx+hiMu13qphA=;
        b=KwDBKsDQ6/z6sJIaaR2BvZZp6pp5+JIsOZ9tQcplPhvB1WvzkSGtrPdfqzvzI1cBJS
         uiBMI7Pm+1zYE3e/4a/OCOwrP5B8ykaJFlNohV8BNEVdwdTzrtQMZNRw9SjnxR+2OvUa
         rT3Ut7dxUV1IKUj30VIjVBHO43rtWrZTrz3Arz3xMkhypP32ReAnQ7CWXVXDJcWQOSaT
         cu/d/6E7ME+wcxGEChQaqBibdcb04MMKtpr6gqzSNUITnDIyW7tPWG3Lm/enh/STCa0q
         7wn1n+fN4e0EWM1SSpEQVfv1v4KONN5mabmzHYPQchpIMYqQ5jm0EziIcwayLTwR8GM2
         pC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207975; x=1795812775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyDondtI9/yJ/PNMNZjGkzOq4ZzEkeYx+hiMu13qphA=;
        b=jxrKHjlO7BXz8aRykyceyS+egj32U8s0QINOp7hiQy8Rhb7coqPWr17cY3oceOGkLh
         vkrILTCPfCTMG4sT4vz1UMh1PznM5LxQOVKZATluv0BM+KQEg8NLSHmbBVLBtQFDKxyS
         wgKs1wrAt7H6rZ69n9WT4mJ/U6EmoI4rzR69ce2kri+B+izyI1OMie7lzyxshKtLIRVa
         oM05odcuZakgtsIhSVQJvxCyr9IPObAx+gpz5Ya1N/kYcj5q++rV2Q486v9lauiCQWrx
         iUZYy+ugqqUN+Ht6Y0cJUTCf1n+tZf3IcQSNHgRbbiEUTvv9ZuewmSWv77d7mZwcPThf
         LcLA==
X-Gm-Message-State: APuU4Z+7uPHbyw6uEuioZsTZIg0EpkBc6YB7YvSNg+PAttQxl2KFyi+t
	FAUJKANal3jHSrBRJPs56eIdGYwk+P5YyhcHk+ZZGoyvii31W5pv1WyBjeycwg==
X-Gm-Gg: AYBFou2JyDja2AwHwlUZ0Z1THAlSswYk6b8ZH4Vdzabi9ZeLMjQDb+GvHbcXDrqFRCJ
	lj/IIhz8rYkUZt6eu4S6eweVFH/HZ5k9myYLvdIOun0ExriS7FJnW9dtNZTlplbNMz15I3LkrEu
	BkO/IZ4zPJ9h5vuM0pB3wr1jC/i1dxBiXvZnulVlJ0ZTvlIRZTAKaehfpSMtV1+jjRjpdIlWR2+
	IC8BScjpC2OylJH0eBzNpEj3JU9Af0QrLDdcLMXCk8Fzc/78xWvvbCJm8gX9g4IlcAV/sOduaKU
	cPPXtSeqmYA4da5XrfRzayyguwjkOg9sBdMMZrTjG5ivUKOpMSAFPMkEpVlaxIYLbctVwWoZZYE
	PqlU3JCNMXddYJOUlYqXVaeGj3PUaMKyci9yMQ9JOyTKxuQthUQHTA4onsLaFXD6oHhlsLu73es
	LsEo6dgqY+euYtFh39DgSPkZK8SU6Q5t5kA+1nLG1kY8hNcI0y2jMy55jORIr/vlKADLPNZpMOy
	8OTc0yXp0VVBifBjPj3Oe+y1hcFecfeijZuwDzHX2nzwShOGtuZ9C6fBFChtpig0RtuhB1TCHVI
	IXCHlqxgIG14ksAyy6LDqHrHP2zMaUdmdA5WhDI2o1heWbIl1gJJOOJ0EDSqm+X5nMRZBgw4AAu
	zGL79TllJLrTbWwlmtFCaDTt2ZGl9aTBwQ1fDkQ+psHdC/hV4I5+GwV8/J6lLR6fDLZKLGtVZKI
	Q=
X-Received: by 2002:a05:6a20:a124:b0:3f9:ceaa:90e with SMTP id adf61e73a8af0-4014ca44dcfmr4783457637.23.1795207974560;
        Fri, 20 Nov 2026 12:52:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4d7basm1906307b3a.21.2026.11.20.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 29/49] bpf: Order the pending states and free the states that are done
Date: Fri, 20 Nov 2026 20:49:37 +0000
Message-ID: <20261120204959.614908-30-alexei.starovoitov@gmail.com>
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
 include/linux/bpf_verifier.h |  11 +-
 kernel/bpf/flow.c            | 281 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  23 +--
 3 files changed, 305 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bf27d751966..6ccac5dff96 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -482,6 +482,12 @@ static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entr
 	return entry->apart && entry->terminates && !entry->counted && !entry->first;
 }
 
+/* The states of trip 0, 1, 2, 4, 8, ... are saved. A compare with them finds any period. */
+static inline bool bpf_trip_is_saved(const struct loop_stack_entry *entry)
+{
+	return !(entry->trip & (entry->trip - 1));
+}
+
 #define LOOP_STACK_SIZE 16
 
 /* state of the program:
@@ -860,6 +866,7 @@ struct bpf_loop_per_pass {
 	bool has_leftover;	/* the peeled trips were not enough */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
+	u32 last_peeled_trip;	/* see flow_keep_peeled() */
 	u32 peeled_cnt;		/* trips that the pass peeled */
 	u64 cost;		/* for the states that the loop keeps apart */
 };
@@ -1362,10 +1369,12 @@ struct bpf_verifier_env {
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
@@ -1746,7 +1755,7 @@ void bpf_flow_free(struct bpf_verifier_env *env);
 bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx);
 int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 		     int insn_idx, int prev_insn_idx, bool again);
-int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx);
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos, u64 *diag_pos);
 int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		  struct bpf_verifier_state *entry, int subprog, int call_idx);
 int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index eb64b0dade1..fbd81c1447d 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -663,6 +663,74 @@ bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx)
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
+	s->pending = true;
+	instance->pending_cnt++;
+	rb_add_cached(&s->rb, &flow->pending, flow_less);
+}
+
 /*
  * States meet only if they have the same hash. The tree sorts them by a half of the hash,
  * then by the range of one xreg of data_deps. Two ranges with a gap stay apart, but not where
@@ -695,6 +763,125 @@ static struct flow_state *flow_find(struct bpf_verifier_env *env, struct flow_st
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
@@ -757,6 +944,7 @@ static void flow_insert(struct bpf_verifier_env *env, struct flow_state *s)
 static void flow_link(struct bpf_verifier_env *env, struct flow_state *s)
 {
 	flow_insert(env, s);
+	flow_set_pending(env, s);
 }
 
 /* The entry of @loop in the top frame of @st */
@@ -945,3 +1133,96 @@ int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st
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
index 43c4e7b2c8d..f8779c51cf7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21589,26 +21589,31 @@ static bool round_is_dropped(struct bpf_verifier_env *env)
 
 static int do_check(struct bpf_verifier_env *env)
 {
-	bool level1 = (env->log.level & BPF_LOG_LEVEL) == BPF_LOG_LEVEL1;
-	u64 log_pos = env->log.end_pos;
+	bool level2 = env->log.level & BPF_LOG_LEVEL2;
+	u64 log_pos = env->log.end_pos, diag_pos = 0;
 	int prev_insn_idx, err;
 
 	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1, false);
-	while (!err) {
-		err = bpf_flow_next(env, &prev_insn_idx);
+	while (!err && !(env->path_sensitive && env->cost >= env->failing_path_max_cost)) {
+		err = bpf_flow_next(env, &prev_insn_idx, &log_pos, &diag_pos);
+		/* at the limit the work on equations is not complete, such a pass proves nothing */
 		if (err == -ENOENT)
-			return 0;
+			return bpf_check_limits(env);
 		if (err)
 			break;
-		/* What is known about how the state came to be is not kept with it. */
-		bpf_diag_event_log_restore(env, 0);
-		/* Neither is the text: the level 1 log has one basic block at a time. */
-		if (level1) {
+		/* A pass logs one basic block at a time. A path-sensitive run logs a full path. */
+		bpf_diag_event_log_restore(env, diag_pos);
+		if (!level2) {
 			bpf_vlog_reset(&env->log, log_pos);
 			env->prev_linfo = NULL;
 		}
 		err = do_check_block(env, prev_insn_idx);
+		if (env->bug)
+			return -EFAULT;
 	}
+	/* bpf_flow_edge_unproven() noted it with the state that failed */
+	if (err && !bpf_insn_is_unproven(env))
+		note_error(env, err);
 	return err;
 }
 
-- 
2.55.0

