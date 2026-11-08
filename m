Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116394;
	b=jziv+p941yOqktC5vy3oOAfjhdxas0m7V9InR075FEtNmEXiZjajfB9uit3oYBhxsT4h
	 NSjCVXHn5r1fRWCD+xzXp8UXeh9aK/zjZvR2/KmRQQj/Pf8Tq1MNoDvzoGFe0cxzC2+S+
	 2SK5s7NYpiIqiUp+D+zn5Q0Ee1JA6xKwUqMZ0jeDGzHfahn+hHRUP+htEvyO7/YO6wcqB
	 Q77wVq1r6qzZ+ZkIUXOOyO/Lz5gMDXOT6OK7Z59KqlM9d2ywRiEGe7U6b7ssk48leEGh4
	 AImq47pdCOfCsuGl/kgRY44HFcmROihS9WJSxze0b9Vp5wNRur9RmOF9q+0RLbNSF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gG/049fUIF9AC11CTM0p+wgxx9xZPyx1pOZoZfo+lcY=;
	b=fcd7EoVWuhATZbK8qT+f8JjaroS8EQynR/28UZNFCXD1lhKUkPleUQptU0tnTcyKRCzg
	 zVf2hTRsEP/YMIX5n6IB86V5B7EiNf+00BilAjD6dXyUV+uwuXMSoHAlkpCvmGAmoI+t+
	 flLLGS1QLpCpy/QE4+7UOPIAeXv6Sk4TiwGzjDdhYweoIP4kftCKS/HePSNdnLib2yaRB
	 /8SCIATmfIDXrSuojYhavXn27xHn1cMBXDHVHTiSqXHg7xqCHqyi2v2JHAhkOxN7zs74f
	 qbYaOhlTxqeQL1t3N6xOUvN+BOC3xrltBj+0eK/BCnuh2upmhKbMB1KtO3Ppsq633GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5pBo04e;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90868606A31A
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 05:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90868606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5pBo04e
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so165762a91.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 21:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794116393; x=1794721193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gG/049fUIF9AC11CTM0p+wgxx9xZPyx1pOZoZfo+lcY=;
        b=p5pBo04eJsRLIYBuDB0EkI3lAYeNbJV7hWKkSqtb2YX7fnFidT/rsGQ4gC6OF1eeUa
         2NPEuU7SlY5AZ/KJosZ2OfT2ANMCtK89pgroIK972mP3x+e682aDC4GENDjUK/2qaK8M
         v4RkoDDPvAr7JGVT3uQbhO3cMljvtlwFMOBzZLaTQs6mM8ePDh0un4s3CJS15P3TQWp9
         4vbdnYfaeHPSEOXrCKsaYlxtU+2z9ZVR4QkShiVWLj2g0n9u4a5jA5J+aGPaEXO2uVdF
         4F+hG9ODUBOBPcIYp6E+NY4IUx3oQu3necYDWBS64QHIn9NWNfpuBtQZf4Y3adGOfpwU
         lEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794116393; x=1794721193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gG/049fUIF9AC11CTM0p+wgxx9xZPyx1pOZoZfo+lcY=;
        b=pzjuH/yZhR7AC4shutJi0EkeKMBIw9WasMM/+pqbiBc6DHV9Nzf81Oo2k6c6rMsTe1
         2rZNHIAXwB3UrP48irV1ztJf7RY6VukLtaamjO0e+5Vo118B8DVY665jkOBOAQe6yFpr
         4oLeezpN2+oRNZ20puAS44Wbh3/MGctLDEnqMfZ5/n764xwXBMfr9J+8yCjKL5ArveJN
         wRDCcymZjjP375wiUukTNm/vhk3k01ETmHeA3gccqDpNAgHEJZ1OYO78H3g8szvY+9AE
         7EuPn9G+b5xsTDb2JSxTEocIZhNje5ew+aaMjjdwVtrFEKKBhaC3Oroya+i3eRMNTQGc
         128g==
X-Gm-Message-State: APuU4Z+yud5uh5V4u/0TM+gb0YZTTJ4UKLpc1zUQ/6V2yiziTxb2hCve
	dsgc7/yvy6t5ie4woxj3Vc3FOmB5KED4ka0DjcmuLscr5YJ15RFIgkYMOTCq2A==
X-Gm-Gg: AYBFou3pVEi+gyJ6j9DaqeGw06+y86W1clTBHXWIIaxBUhPkfejtmuF+0Psc3ypPXNq
	OQuPJz8IePUV9oPJIf0q1hcovawbrYLW4JNgKY7pHl9L4HHMa79V//X9z4Uyr6tmVb8a3QffUKG
	RjqOFNyjHDu/cVY+hbj/llBL2vmWyXiHv1Gd61gIKw3nXPmR88RVqBkBRBcUeo3qVjC5Im5twPt
	mZzUs8Mo1pzAd6bCUO3BwzFSkzi2HMCz0cJJREVWfBeRlmVuF5dZMpDymd53FWSFoLnVppc4oyH
	17cK1rbLUm1cDeLSnedtnnSeaTMDg56LWy5Ui5+OqZ+zKNxNz2zj9MrDqioOs4UgrxpJPAnNI1/
	bOkWXA+Wom/hWTPu4FI4mvvROz9mhqdMCa43IzbgqgdCVvOitxWxYG3W3UOgfJ3TN2yjae33Bo0
	Ttu37U8HtHPinvPAfbRRWCnnYNxuWIio1aP7g7cFzeeme/usGrfHbV3xSuWiKVDtQIpCZVdUz21
	drV7lLB20TnGgDlYOT3KLmnEm/G2B48J8bb6XIedTWkMDwBBB2hkZVB/+dhPf5UgpPsg/pnqacA
	5tHFfUs1yAc1omWMfDdrmHHAg+8/uXnbXakPEsPI97I8HiyxuLsEaV5rCvuKvNCuF4TzjP3lq3w
	76bHRMWGBLyyyEczOCdsUEHLSvVnN40TVBUhoQforuLRM0rRbvQETeoKH7mJ4JgMWhfgrzX7XzA
	==
X-Received: by 2002:a17:90b:4a48:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3b12d5c53c2mr564087a91.67.1794116392780;
        Sat, 07 Nov 2026 21:39:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1032b8c55sm3251504a91.2.2026.11.07.21.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 21:39:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] bpf: Keep one basic block in the level 1 log and print the way to it
Date: Sun,  8 Nov 2026 05:39:37 +0000
Message-ID: <20261108053937.4134138-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
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

bpf(2) shows how to load a prog: .log_level = 1 and a static buffer.
Cilium's bpf_lxc/tail_ipv4_ct_egress loaded that way with 64K. Now it gets
-ENOSPC, like 2097 progs of the selftests, Cilium, scx, katran, bpfjailer
and Rust crates.

At level 1 each insn is printed when it is verified. The verifier used to
follow one path at a time. At a conditional jump push_stack() put the
other branch aside and noted the end of the log. When the path was done
pop_stack() took the branch and moved the log back:

  push_stack():  elem->log_pos = env->log.end_pos;
  pop_stack():   bpf_vlog_reset(&env->log, head->log_pos);

So the log was the path from the first insn to the current one. It never
got larger than the longest path, and when a prog was rejected it was the
path to the error.

Now there are no paths. Basic blocks are verified in the order of the
control flow graph, and the states that get to a block are joined. What
push_stack() puts aside goes to the block that it is for. pop_stack() and
log_pos are gone, and nothing else moves the log back while a function is
verified. Each block adds its text each time it is verified: 4057 insns
and 774446 bytes for tail_ipv4_ct_egress, whose longest path had 51434.

The text is dropped when the prog turns out to be safe. That doesn't help:
bpf_vlog_finalize() compares the buffer with len_max, the largest size
that the log ever had. And the log of a rejected prog is not the path to
the error any more. It has all blocks, both arms of each branch, in the
order in which they were verified.

The old log cannot come back as it was. The state at the start of a block
is the join of all that got there: no path leads to it.

Move the log back in front of each basic block, so that it holds one block
at a time. When a block is rejected print the way to it from what the
verifier holds at that time. It keeps the states where ways meet. Such a
state knows the edge that it came by, after a join the edge that changed
it last: the edge that brought the bad value. There may be several states
at an insn, so a state gets a u32 that tells which kept state it comes
from. A block in between has one predecessor. The block that fails is in
the log already: stash it, print the way, append it. Nothing is verified
twice.

  if (skb->mark == 1)      i = skb->len & 63;
  else if (skb->mark == 2) i = skb->priority;
  else                     i = 7;
  if (skb->protocol == 8)  v[0] = 1;
  return v[i];

  from -1 to 0: R1=ctx() R10=fp0
  ...
  10: (16) if w2 == 0x2 goto pc+5
  ; i = skb->priority; @ pick.bpf.c:22
  16: (61) r1 = *(u32 *)(r6 +32)
  from 16 to 17: R0=map_value(map=m,ks=4,vs=64) R1=scalar(smin=0,smax=..
  ; if (skb->protocol == 8) @ pick.bpf.c:25
  17: (61) r2 = *(u32 *)(r6 +16)
  18: (56) if w2 != 0x8 goto pc+2
  21: R0=map_value(map=m,ks=4,vs=64) R1=scalar(smin=0,smax=umax=0xfff..
  ; return v[i]; @ pick.bpf.c:27
  21: (0f) r0 += r1               ; R0=map_value(map=m,ks=4,vs=64,smin=..
  22: (71) r7 = *(u8 *)(r0 +0)
  R0 unbounded memory access, make sure to bounds check any such access

A block is on the way once, so the way goes around a loop once. Where
a block would come again the way goes on from its dominator: all that gets
into the loop goes through it. The earlier rounds are left out, what is in
front of the loop is not. A function that is verified in the frames of its
caller is on the way once too, for its last call. Its dominators end at
its first insn, so the way begins where the call before that one returns.

A signal ends the print. A round that do_check_all() drops gets no way, so
bpf_flow_loops_lost_bound() can be asked twice now. Level 1 doesn't show
the states behind the insns of the way and the bodies of subprogs that are
verified on their own. Level 2 has them. It is not changed, and six tests
that look at such a state get __log_level(2), with the five others that
come out of the same macros.

log_true_size at level 1           one path   all blocks   this patch
  bpf_lxc/tail_ipv4_ct_egress         51434       774446         7652
  bpf_host/cil_to_netdev             101212      1789015         9778
  katran/balancer_ingress            103567      3668559        22603
  progs with -ENOSPC at 64K            2841         5503           45
  the builds of a prog as one           435         1018           23

A prog that loads pays two stores of a u32 per state: ftrace sees no call
of bpf_flow_print_way(). The longest way, 713 lines, takes 0.4 ms.

Fixes: 5395aa9bbeb5 ("bpf: Verify programs as a fixpoint over the control flow graph")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/flow.c                             | 111 ++++++++++++++++--
 kernel/bpf/verifier.c                         |  20 +++-
 .../selftests/bpf/progs/linked_list_peek.c    |   2 +-
 .../selftests/bpf/progs/rbtree_search.c       |   4 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 6 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15619edc8f03..4771c55d8f41 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1553,6 +1553,7 @@ int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 int bpf_flow_guard_edge(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			int insn_idx, int prev_insn_idx, enum bpf_guard_edge edge);
 int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx);
+void bpf_flow_print_way(struct bpf_verifier_env *env, u64 log_pos, int head, int i);
 int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		  struct bpf_verifier_state *entry, int subprog, int call_idx);
 int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index e6d1817ffa57..c9458b3ad114 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -92,6 +92,7 @@ struct flow_state {
 	struct rb_node rb;		/* pending states */
 	int prev_insn_idx;
 	u32 seq;
+	u32 from;			/* seq of the last state on the way to it that is kept */
 	struct flow_shape shape;
 	u16 joins;
 	bool pending;
@@ -178,6 +179,7 @@ struct bpf_flow {
 	struct list_head kept;
 	struct bpf_verifier_state tmp;
 	u32 seq;
+	u32 from;			/* flow_state.from of what comes from the current state */
 	u32 live_states;
 };
 
@@ -416,17 +418,14 @@ void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h
 bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env)
 {
 	struct bpf_loop *loop;
-	bool lost = false;
 	int h;
 
 	for (h = 0; h < env->prog->len; h++) {
 		loop = env->insn_aux_data[h].loop;
-		if (!loop || !loop->rt_bounded || flow_loop_is_bounded(env, h))
-			continue;
-		loop->rt_bounded = false;
-		lost = true;
+		if (loop && loop->rt_bounded && !flow_loop_is_bounded(env, h))
+			return true;
 	}
-	return lost;
+	return false;
 }
 
 /*
@@ -459,8 +458,12 @@ void bpf_flow_new_round(struct bpf_verifier_env *env)
 	env->guards_late = false;
 	for (i = 0; i < env->prog->len; i++) {
 		aux[i].guard_edge_dropped = false;
-		if (aux[i].loop)
-			aux[i].loop->no_guard_edges = false;
+		if (!aux[i].loop)
+			continue;
+		aux[i].loop->no_guard_edges = false;
+		/* what the last round found out */
+		if (aux[i].loop->rt_bounded)
+			aux[i].loop->rt_bounded = flow_loop_is_bounded(env, i);
 	}
 }
 
@@ -2883,6 +2886,7 @@ static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_
 		return NULL;
 	s->prev_insn_idx = prev_insn_idx;
 	s->seq = ++flow->seq;
+	s->from = flow->from;
 	env->total_states++;
 	flow->live_states++;
 	env->peak_states = max(env->peak_states, flow->live_states);
@@ -3308,8 +3312,11 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx)
 
 	env->insn_idx = s->st.insn_idx;
 	*prev_insn_idx = s->prev_insn_idx;
-	if (test_bit(s->st.insn_idx, flow->keep))
+	if (test_bit(s->st.insn_idx, flow->keep)) {
+		flow->from = s->seq;
 		return bpf_copy_verifier_state(env->cur_state, &s->st);
+	}
+	flow->from = s->from;
 	*env->cur_state = s->st;
 	memset(&s->st, 0, sizeof(s->st));
 	s->st.insn_idx = env->insn_idx;
@@ -3317,3 +3324,89 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx)
 	flow_free_state(env, s);
 	return 0;
 }
+
+/* A basic block on the way to the block that is rejected, up to the insn that leads on */
+struct flow_step {
+	const struct flow_state *s;	/* the state at its head, if one is kept */
+	int head, last;
+};
+
+/*
+ * The state at @head with that @seq. If it is gone a state that came later took its place:
+ * the last one then.
+ */
+static const struct flow_state *flow_find_state(const struct bpf_flow *flow, int head, u32 seq)
+{
+	const struct list_head *list = &flow->states[head].list;
+	const struct flow_state *s;
+
+	if (!test_bit(head, flow->keep))
+		return NULL;
+	list_for_each_entry(s, list, node)
+		if (s->seq == seq)
+			return s;
+	return list_empty(list) ? NULL : list_last_entry(list, struct flow_state, node);
+}
+
+/*
+ * The basic block at @head, which the current state got to from insn @i, is rejected. The block
+ * and the message are what was printed since @log_pos. Print the way to the block in front of it.
+ *
+ * The way is put together backwards from what is there. A state that is kept knows the edge that
+ * it came by, after a join the edge that changed it last, and the kept state that it comes from.
+ * A block whose state is not kept has one predecessor, which is its dominator.
+ * A block is on the way once. Where it would come again, after a round of a loop, the way goes on
+ * from its dominator: all that gets into the loop goes through it.
+ */
+void bpf_flow_print_way(struct bpf_verifier_env *env, u64 log_pos, int head, int i)
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	const struct bpf_flow *flow = env->flow;
+	const struct flow_state *s;
+	struct bpf_vlog_stash stash;
+	struct flow_step *way, *w;
+	u32 from = flow->from, cnt = 0;
+	unsigned long *seen;
+
+	seen = bitmap_zalloc(flow->len, GFP_KERNEL_ACCOUNT);
+	way = kvmalloc_array(bitmap_weight(flow->point, flow->len), sizeof(*way),
+			     GFP_KERNEL_ACCOUNT);
+	if (!seen || !way)
+		goto out;
+
+	s = flow_find_state(flow, head, from);
+	from = s ? s->from : from;
+	while (i >= 0) {
+		head = find_last_bit(flow->point, i + 1);
+		s = NULL;
+		if (!__test_and_set_bit(head, seen)) {
+			s = flow_find_state(flow, head, from);
+			way[cnt++] = (struct flow_step){ s, head, i };
+		}
+		from = s ? s->from : from;
+		i = s ? s->prev_insn_idx : env->idoms[head];
+		cond_resched();
+	}
+
+	if (!cnt || bpf_vlog_stash(&env->log, log_pos, &stash))
+		goto out;
+	env->prev_linfo = NULL;
+	while (cnt-- && !signal_pending(current)) {
+		w = &way[cnt];
+		if (w->s) {
+			verbose(env, "from %d to %d:", w->s->prev_insn_idx, w->head);
+			print_verifier_state(env, &w->s->st, w->s->st.curframe, true);
+		}
+		for (i = w->head; i <= w->last; i += 1 + bpf_is_ldimm64(&insns[i])) {
+			verbose_linfo(env, i, "; ");
+			verbose(env, "%d: ", i);
+			bpf_verbose_insn(env, &insns[i]);
+			verbose(env, "\n");
+		}
+		cond_resched();
+	}
+	bpf_vlog_unstash(&env->log, &stash);
+out:
+	bitmap_free(seen);
+	kvfree(way);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd333b1063c3..20b1b9ff574c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22035,9 +22035,17 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	}
 }
 
+/* All is done again, whatever came out, see do_check_all() */
+static bool round_is_dropped(struct bpf_verifier_env *env)
+{
+	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
-	int prev_insn_idx = -1;
+	bool level1 = (env->log.level & BPF_LOG_LEVEL) == BPF_LOG_LEVEL1;
+	u64 log_pos = env->log.end_pos;
+	int prev_insn_idx = -1, insn_idx;
 	int err;
 
 	err = bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1);
@@ -22049,7 +22057,15 @@ static int do_check(struct bpf_verifier_env *env)
 			break;
 		/* What is known about how the state came to be is not kept with it. */
 		bpf_diag_event_log_restore(env, 0);
+		/* Neither is the text: the level 1 log has one basic block at a time. */
+		if (level1) {
+			bpf_vlog_reset(&env->log, log_pos);
+			env->prev_linfo = NULL;
+		}
+		insn_idx = env->insn_idx;
 		err = do_check_block(env, prev_insn_idx);
+		if (err && level1 && !round_is_dropped(env))
+			bpf_flow_print_way(env, log_pos, insn_idx, prev_insn_idx);
 	}
 	return err;
 }
@@ -23435,7 +23451,7 @@ static int do_check_all(struct bpf_verifier_env *env)
 		bpf_flow_new_round(env);
 		ret = do_check_main(env);
 		ret = ret ?: do_check_subprogs(env);
-		if (!(env->restart && bpf_flow_loops_lost_bound(env)) && !env->guards_late)
+		if (!round_is_dropped(env))
 			return ret;
 		/* the log is dropped when a function is found to be safe */
 		bpf_vlog_reset(&env->log, min(log_pos, env->log.end_pos));
diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
index 264e81bfb287..d881c0210816 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_peek.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
@@ -83,7 +83,7 @@ long list_peek(void *ctx)
 
 #define TEST_FB(op, dolock)					\
 SEC("syscall")							\
-__failure __msg(MSG)						\
+__failure __msg(MSG) __log_level(2)				\
 long test_##op##_spinlock_##dolock(void *ctx)			\
 {								\
 	struct bpf_list_node *l_n;				\
diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/testing/selftests/bpf/progs/rbtree_search.c
index b05565d1db0d..da2112c89d96 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_search.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
@@ -133,7 +133,7 @@ long rbtree_search(void *ctx)
 
 #define TEST_ROOT(dolock)				\
 SEC("syscall")						\
-__failure __msg(MSG)					\
+__failure __msg(MSG) __log_level(2)			\
 long test_root_spinlock_##dolock(void *ctx)		\
 {							\
 	struct bpf_rb_node *rb_n;			\
@@ -152,7 +152,7 @@ long test_root_spinlock_##dolock(void *ctx)		\
 
 #define TEST_LR(op, dolock)				\
 SEC("syscall")						\
-__failure __msg(MSG)					\
+__failure __msg(MSG) __log_level(2)			\
 long test_##op##_spinlock_##dolock(void *ctx)		\
 {							\
 	struct bpf_rb_node *rb_n;			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 28d48e5fbc4f..f55d58af8004 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1648,7 +1648,7 @@ l0_%=:	r0 = 0;				\
  */
 SEC("socket")
 __description("bounds deduction cross sign boundary, two overlaps")
-__failure
+__failure __log_level(2)
 __msg("3: (2d) if r0 > r1 {{.*}} R0=scalar(smin=smin32=-128,smax=smax32=127)")
 /* smin=-128 includes point 0xffffffffffffff80 */
 __msg("frame pointer is read only")
-- 
2.55.0

