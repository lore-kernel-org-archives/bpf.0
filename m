Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022732;
	b=fzZ46uhyBHGyXih9O/2zYc0B++uJ4SUYVwtzsNF8opMJJ3sRhrvZt/3LrYs74bLZndbb
	 DsGDyPHkqjNmG4YaLMI/ttZhaPSoUp/CwcqgcpqeExswHQfzfjlE9T2kYtnMulTigRSBK
	 Hid0opGII9wov6nVGyEKcDGHlpBiUR8LjY6CYmVwwH850RQxAWWgkseRaCFpKxfBcdt31
	 DMx/sgpumRGo6fZSSfIIRBbgvefF9nKGjvhE1tGvL/cCJNIo/MGFcNvwkSPcwQ8IYwdzF
	 LhlJM3752z2vU9OtaBde1PWSOHPmLeEqLthmuHfzIUGO6cuqivetjmzyJIvDPbiqN/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qEdvKLYVuN3LXB2zI0UDXNNTmUUJ2U1rXp0thTAxaww=;
	b=jAQM4DQWBPm9nDAzkbRgJ8eIyjjq5Pc1bd1g2/+GHhQay0XVsX7DHOG2gzQBd2KL8K5s
	 aYhNINbvA9XlrqI0k2lNSPYuGqwB6W2R2aU1rGTjwakI0t/rZOu5RB6h8p+SwxQWXu5cT
	 OBd/1s81EU9LsWI3xFTYnglKv7Qi0IVQv9zkiDkKVpUYNo8qdEGaPPq3jsdcmuXbtS7wE
	 b989xMYrSSBxIc9vC8Ck0GMaX0Qn/xfuPQwCtw2Fez4j1CQd+lZIicoJlljwjws4UmltR
	 id46ZK+OK3DFZ6LkBQVfDBqGMFlATIRrdbckFTqRI0c+dxnCR9GQSDIQ1zbtNEpwRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gfGYyuux;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CA606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 511CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gfGYyuux
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso133256a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022732; x=1794627532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEdvKLYVuN3LXB2zI0UDXNNTmUUJ2U1rXp0thTAxaww=;
        b=gfGYyuuxvdu9p9SWyHbB0solpr7P88fHlfsWr/btukcC09i/fgrCbLzcWfj2avz8o9
         k/f8U79pFGXjda9AR3HvnSAotCuvF+0cY5ERLJqkR/RymXQpv3X39iR7nE7ks+/LCXlo
         6a1OZ6ftKnI3VEZ3zP4fi9pt+xpeKZCur3MSEy7dosEDh5B3kNQtvYY7HwX8fPCJNMej
         rrcOX3vcmonVTtL2zPavVzm0e0l+pGEfNeXLH4NwXZDA+3UDAZzeu5OffjURPYwcUNRe
         2+8E3O7ur7OS1gJmrcwPFoLWmx9Fv0lZFX1KOn+ANc4Q7XDy/JbgNgbneKi3QztlQE8f
         t9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022732; x=1794627532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qEdvKLYVuN3LXB2zI0UDXNNTmUUJ2U1rXp0thTAxaww=;
        b=aj13Bw5QnQHZ2ntg8SYqt1xkX4qfUhUSsZnLt2U5t740GQLxdUJIFQpK/6DXLiWeJM
         Ym3LEfKc74UalMTIXgqUMoX6jYmqRCBY89+HZzyJtt/6RRXMJUiJjUnH8YtZN/1NmLdQ
         z4CbDEPL7uTcj4f3UUAyMBhDHbZ+w0Ps78szMaG6rdRCObjNojRS6OJqvXANuFqJuknW
         LGzE0E84zHgdmwFmQiaCJAQXZE/dDw/iXSgAFGm2giqrzexYl77W65nMDfnOk+na1tN0
         NQ+ha3+ZRInHuJY2mCVwYn/W0RqyyoIKrtBxNaHzWwTVMSmce6M2i2BAgEouhVzgNxqf
         0fUg==
X-Gm-Message-State: APuU4Z+5D/v09sqg34Z3KA6gJEG6/mS0B7/TF38TmcZo2Eh+zZmjsPXD
	Tl8zCZIt+OS0RBQ+y6WzaoOS0HAfFWoGWDMQpnRjh5Im8Qu0X8jAq+lCdCjGhA==
X-Gm-Gg: AYBFou3fWVByRb/8yfVbfJInoVE/x5MSrUaV3q9NWjPBK78uZxnAU465kyEMCzPESCG
	OzekjYylzzohEq561zYUJ/wt3s/Ow6sa4WIVazeaCfvzgJYm8m18b6w+1THRHKmtYXtln3jWwDb
	Qv3jhml/X3nsOdMogfnQILBnMAlTIVbJYni9QAhEpIcW5lTvFOQ81sVCiToyKqUARaeFAnoZfJ0
	T76Pjitr6MX9jty8zgh7mHHBrYklItr1rCRuBqERQCn7bwAK4Kk8bhk69uGcNOxYze9V6oD8cij
	Bgpqpp+3hNZlx6eUnrRwtzWoake9jjoECrrZRzVdHU5aEl3OR/42YNlG9QNjHSI/WlclB5L1kZv
	7/TyJFaPf8jE9/jIztvfiXGZeL4kDVIDipfeL0JswCcp55icR3gCxhHhyLuAnU2A+5+UOIdvTrT
	CVvr33FHiloeMXmCic2Agf3V5yLosU666PIjww/eQfhnHawauHOOI7EWdmvpwN2LLQNu8vQRF9L
	ZIZPT6Bz1YZ2lpDP5hvEg29X/Dmt0Ky7DflMmG7jh5KkEXfgg7c+AUzZ0gVeRJGwcbZ413+c6dP
	CQombPOIT+Gcu8k3fqMTdh2cItZfryKCYZLAFTAJzeIRvOkPy57NJMOEaGwBCekA6z2r/cKtDb4
	+FnrgqtIMDSsaz1eYh+T+D2nF6CCs1nJyuCubc1EnjNgFvOn0lPypmCZyIDJoDdPrs/dW1UZ8rA
	==
X-Received: by 2002:a17:90b:3809:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b10637bf76mr691490a91.30.1794022731252;
        Fri, 06 Nov 2026 19:38:51 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d2fa3sm1412976a91.13.2026.11.06.19.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 08/46] bpf: Order the insns, find what stops a loop and where may_goto can go
Date: Sat,  7 Nov 2026 03:37:16 +0000
Message-ID: <20261107033758.1547725-9-alexei.starovoitov@gmail.com>
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

A fixpoint shows that each iteration of a loop is safe, not that it ends:

  do { i++; sum += PT_REGS_RC(ctx); } while (i < 0x100000000ULL);

Today selftest loop3 hits the limit of 1M insns. The main pass widens i and
is done, so the verifier has to add a may_goto. That is an edge that the
prog does not have. Its place decides which progs load:

1. None, if each iteration executes a may_goto that leaves the loop, or
bpf_iter_*_next() of an iterator that was created before the loop.

  bpf_repeat(1000000) {
          map_val = bpf_map_lookup_elem(&hash_map, &key);
          if (map_val) { found = true; break; }
  }
  if (found) *map_val = 123;

An added may_goto goes where 'break' goes, without the test. Selftest
iters/iter_tricky_but_fine: "R6 invalid mem access 'map_value_or_null'".
layered_init of scx_layered and mitosis_init of scx_mitosis fail alike.

2. In front of a conditional jump that leaves the loop, to its target: the
prog gets there with the same registers and stack. One jump of the loop
itself, bpf_insn_leaves_loop(), that each iteration goes through is enough:
the 'while' of loop3. Else each back edge gets one: a may_goto at the head
skips the body, and the first exit can read what the body sets.

3. At the head, if a back edge has none. The compiler makes one loop of

  while self.locked.compare_exchange(0, 1, Acquire, Relaxed).is_err() {
      while self.locked.load(Relaxed) != 0 { core::hint::spin_loop(); }
  }

and the inner back edge has none. Without this place the main pass says
"loop at insn 127 never exits" for 142 of the 225 progs of the schedulers
of rust-bpf. This edge can skip what stops an outer loop: it leaves all.

The added insn executes in each state. Thus a loop has it for all states or
for none. The main pass can find out late: it first goes through loop3
iteration by iteration, as today, and gives up. Then the pass is repeated.

The main pass takes the blocks that have a new state in the order of
flow_compute_order(): reverse post order, but a loop stays together. Else
the code behind a 'break' is verified before the loop is done, then again.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/flow.c            | 335 +++++++++++++++++++++++++++++++++++
 kernel/bpf/loops.c           |   8 +
 3 files changed, 344 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7fda41a4bf25..332701cdf3ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1617,6 +1617,7 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
 u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 01681957855d..0f5acdf1cb94 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -179,3 +179,338 @@ struct bpf_flow {
 	u32 seq;
 	u32 live_states;
 };
+
+/*
+ * The order. Reverse post order is a topological order of the graph without
+ * back edges, but it may put what follows a loop between the insns of
+ * the loop. Keep the insns of a loop together, the head first: in the list of
+ * its parent the loop takes the place of the insn of it that comes first.
+ *
+ * Every cycle has a back edge of the depth first search in it and
+ * bpf_compute_loops() makes the target of such edge a loop head. So every edge
+ * that goes backwards in the order is in a loop whose head is at or before its
+ * target, loops that are not reducible included.
+ */
+static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flow)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int len = env->prog->len, i, s, n, h, top, depth;
+	int *next, *head, *tail, *stack;
+	unsigned long *linked;
+	u32 pos = 0;
+	int err = -ENOMEM;
+
+	/* lists of members are indexed by loop head, len is the function */
+	next = kvmalloc_array(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	head = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
+	tail = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
+	stack = kvmalloc_array(len + 1, sizeof(int), GFP_KERNEL_ACCOUNT);
+	linked = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
+	if (!next || !head || !tail || !stack || !linked)
+		goto out;
+
+	for (i = 0; i <= len; i++)
+		head[i] = tail[i] = -1;
+
+	for (s = 0; s < env->subprog_cnt; s++) {
+		int first = env->subprog_info[s].postorder_start;
+		int last = env->subprog_info[s + 1].postorder_start - 1;
+
+		head[len] = tail[len] = -1;
+		for (i = last; i >= first; i--) {
+			n = env->cfg.insn_postorder[i];
+			/* n, then the heads of the loops around it that are not in a list yet */
+			depth = 0;
+			for (h = n; h >= 0 && !test_bit(h, linked); h = aux[h].loop_header)
+				stack[depth++] = h;
+			while (depth) {
+				h = stack[--depth];
+				top = aux[h].loop_header >= 0 ? aux[h].loop_header : len;
+				__set_bit(h, linked);
+				next[h] = -1;
+				if (tail[top] < 0)
+					head[top] = h;
+				else
+					next[tail[top]] = h;
+				tail[top] = h;
+			}
+		}
+
+		depth = 0;
+		n = head[len];
+		while (n >= 0 || depth) {
+			if (n < 0) {
+				n = next[stack[--depth]];
+				continue;
+			}
+			flow->pos[n] = pos++;
+			if (aux[n].loop && head[n] >= 0) {
+				stack[depth++] = n;
+				n = head[n];
+			} else {
+				n = next[n];
+			}
+		}
+	}
+	err = 0;
+out:
+	kvfree(next);
+	kvfree(head);
+	kvfree(tail);
+	kvfree(stack);
+	kvfree(linked);
+	return err;
+}
+
+/* Does the insn at @idx stop the loop @h? */
+static bool flow_is_bound(struct bpf_verifier_env *env, int h, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	int t;
+
+	/* Once it is out of budget it's a jump. It has to leave the loop. */
+	if (bpf_is_may_goto_insn(insn)) {
+		t = bpf_loop_at_index(env, idx + insn->off + 1);
+		return t != h && !bpf_is_nested_loop(env, t, h);
+	}
+	if (!bpf_insn_is_iter_next(env, insn))
+		return false;
+	/* unless the main pass finds that it doesn't, see iter_stops_loops() */
+	t = env->insn_aux_data[idx].not_stopped;
+	return t < 0 || bpf_is_nested_loop(env, h, t);
+}
+
+/*
+ * What stops a loop at run time is may_goto that leaves it, or bpf_iter_*_next() of
+ * an iterator that is older than the loop, that every trip goes through. A loop without
+ * it gets may_goto unless the number of its trips turns out to be known.
+ *
+ * The place for it is in front of a conditional jump that leaves the loop, with
+ * the same target. The registers and the stack are what they are when
+ * the program leaves the loop there. One such jump that every trip goes
+ * through is enough. Otherwise every back edge needs one.
+ */
+static void flow_set_guard(struct bpf_verifier_env *env, int h, int n)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int t = n + env->prog->insnsi[n].off + 1;
+	int i = bpf_loop_at_index(env, t);
+
+	if (i == h || bpf_is_nested_loop(env, i, h))
+		t = n + 1;
+	aux[n].guard_place = true;
+	aux[n].guard_to = t;
+	aux[h].loop->has_guards = true;
+}
+
+static void flow_place_guards(struct bpf_verifier_env *env, int h, u32 *seen)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_loop *loop = aux[h].loop;
+	int i, n, o, t, found = -1;
+
+	if (loop->backedges_overflow)
+		goto header;
+
+	/*
+	 * The head of a loop with more than one entry doesn't dominate what is in the loop.
+	 * Then an insn that dominates a back edge can be passed once, on the way in, and
+	 * never again. Every trip goes through the jump that is the back edge, and
+	 * through the head.
+	 */
+	if (loop->irreducible) {
+		for (i = 0; i < loop->backedges_cnt; i++)
+			if (!loop->backedges[i].latches_cnt ||
+			    loop->backedges[i].latches[0] != loop->backedges[i].from)
+				goto header;
+		for (i = 0; i < loop->backedges_cnt; i++)
+			flow_set_guard(env, h, loop->backedges[i].from);
+		return;
+	}
+
+	/* seen[n]: the number of back edges that n dominates */
+	for (i = 0; i < loop->backedges_cnt; i++)
+		for (n = loop->backedges[i].from; n >= 0; n = n == h ? -1 : env->idoms[n])
+			seen[n]++;
+	for (n = loop->backedges[0].from; n >= 0 && found < 0; n = n == h ? -1 : env->idoms[n])
+		if (seen[n] == loop->backedges_cnt && bpf_insn_leaves_loop(env, h, n))
+			found = n;
+	for (i = 0; i < loop->backedges_cnt; i++)
+		for (n = loop->backedges[i].from; n >= 0; n = n == h ? -1 : env->idoms[n])
+			seen[n] = 0;
+	if (found >= 0) {
+		flow_set_guard(env, h, found);
+		return;
+	}
+
+	for (i = 0; i < loop->backedges_cnt; i++)
+		if (!loop->backedges[i].latches_cnt)
+			goto header;
+	for (i = 0; i < loop->backedges_cnt; i++)
+		flow_set_guard(env, h, loop->backedges[i].latches[0]);
+	return;
+
+header:
+	/*
+	 * In front of a jump may_goto goes where the jump goes. From the head to where the loop
+	 * is left is not an edge of the program: it skips what is in the loop. If that is what
+	 * stops a loop around this one, bpf_iter_*_next() or i++, and the exit leads back to
+	 * the head of that loop, the program goes round and round from may_goto to may_goto.
+	 * So leave all loops.
+	 *
+	 * What is derived from the graph in the direction of the edges has to know about this
+	 * one, see bpf_head_guard_target().
+	 */
+	for (o = h; aux[o].loop_header >= 0; o = aux[o].loop_header)
+		;
+	/* a loop that has no exit can only be stopped together with the program */
+	if (!aux[o].loop->exits_cnt)
+		return;
+	t = aux[o].loop->exits[0].to;
+	aux[h].guard_place = true;
+	aux[h].guard_at_header = true;
+	aux[h].guard_to = t;
+	loop->has_guards = true;
+}
+
+/* Does every trip of the loop @h go through an insn that stops it? */
+static bool flow_loop_is_bounded(struct bpf_verifier_env *env, int h)
+{
+	struct bpf_loop *loop = env->insn_aux_data[h].loop;
+	int i, n;
+
+	/* see flow_place_guards() about loops with more than one entry */
+	if (loop->backedges_overflow || loop->irreducible)
+		return false;
+	for (i = 0; i < loop->backedges_cnt; i++) {
+		for (n = loop->backedges[i].from; n >= 0 && n != h; n = env->idoms[n])
+			if (flow_is_bound(env, h, n))
+				break;
+		if (n < 0 || !flow_is_bound(env, h, n))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * The main pass got to bpf_iter_*_next() at @insn_idx in a state in which it doesn't stop
+ * the loop @h around it. What is assumed about the loops stays as it is until the pass
+ * is over, so that all states are treated alike.
+ */
+void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+
+	if (aux->not_stopped >= 0 && !bpf_is_nested_loop(env, h, aux->not_stopped))
+		return;
+	aux->not_stopped = h;
+	env->restart = true;
+}
+
+/*
+ * True if a loop was taken for bounded in the pass and is not. The pass is done again then.
+ * A loop that has something else that stops it, like the outer one of two nested
+ * bpf_for(), is not affected. Every time at least one loop is found out for good.
+ */
+bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env)
+{
+	struct bpf_loop *loop;
+	bool lost = false;
+	int h;
+
+	for (h = 0; h < env->prog->len; h++) {
+		loop = env->insn_aux_data[h].loop;
+		if (!loop || !loop->rt_bounded || flow_loop_is_bounded(env, h))
+			continue;
+		loop->rt_bounded = false;
+		lost = true;
+	}
+	return lost;
+}
+
+/*
+ * A state is in the loop @h without a count, so the loop gets may_goto. At run time may_goto is
+ * there for everybody, also for those who know the number of trips or got to the end of the loop
+ * trip by trip. It can be out of budget in the first trip, because of a loop before this one.
+ *
+ * So a loop has may_goto or it has not, and a state takes the edges of may_goto if the loop had
+ * it when the state entered. If a state entered without it, with a count or on a walk that may
+ * give up, all is done again, and the loop has may_goto from the start.
+ */
+void bpf_flow_loop_gets_guards(struct bpf_verifier_env *env, int h)
+{
+	struct bpf_loop *loop = env->insn_aux_data[h].loop;
+
+	if (loop->guarded)
+		return;
+	loop->guarded = true;
+	if (loop->no_guard_edges)
+		env->guards_late = true;
+}
+
+/* The main prog and the global functions are about to be verified, maybe not for the first time */
+void bpf_flow_new_round(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i;
+
+	env->restart = false;
+	env->guards_late = false;
+	for (i = 0; i < env->prog->len; i++) {
+		aux[i].guard_edge_dropped = false;
+		if (aux[i].loop)
+			aux[i].loop->no_guard_edges = false;
+	}
+}
+
+/*
+ * Which loops have something that stops them at run time, and where may_goto goes in the others.
+ * Returns 1 if a place is at the head of a loop.
+ */
+int bpf_flow_place_guards(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int len = env->prog->len, h, i, depth, ret = 0;
+	struct bpf_loop *loop;
+	u32 *seen;
+
+	seen = kvcalloc(len, sizeof(*seen), GFP_KERNEL_ACCOUNT);
+	if (!seen)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		aux[i].not_stopped = -1;
+		depth = 0;
+		for (h = bpf_loop_at_index(env, i); h >= 0; h = aux[h].loop_header) {
+			/* the main pass doesn't get that deep */
+			if (++depth > LOOP_STACK_SIZE) {
+				verbose(env, "Too many nested loops at %d\n", i);
+				kvfree(seen);
+				return -E2BIG;
+			}
+			aux[h].loop->nr_insns++;
+			if (bpf_pseudo_call(&env->prog->insnsi[i]) ||
+			    bpf_is_callx(&env->prog->insnsi[i]))
+				aux[h].loop->has_calls = true;
+		}
+	}
+
+	for (h = 0; h < len; h++) {
+		loop = aux[h].loop;
+		if (!loop)
+			continue;
+		/* a deep nest of loops takes long */
+		if (signal_pending(current)) {
+			ret = -EAGAIN;
+			break;
+		}
+		cond_resched();
+		loop->rt_bounded = flow_loop_is_bounded(env, h);
+		/* also when it's bounded: the main pass may find that it's not */
+		flow_place_guards(env, h, seen);
+		if (aux[h].guard_at_header)
+			ret = 1;
+	}
+	kvfree(seen);
+	return ret;
+}
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index cc15712f70d4..729e0055f86f 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -540,6 +540,14 @@ bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n)
 	       (f != h && !bpf_is_nested_loop(env, f, h));
 }
 
+/* The same for an insn that is in the loop @h itself */
+bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n)
+{
+	if (bpf_loop_at_index(env, n) != h)
+		return false;
+	return bpf_jump_leaves_loop(env, h, n);
+}
+
 int bpf_compute_loops(struct bpf_verifier_env *env)
 {
 	int i, j, k, s, t, iloop, sloop, err = 0, len = env->prog->len;
-- 
2.55.0

