Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937121;
	b=hiEn75M/NCKMh1HXw4tRvxhfWx99fR3wYGw9Hm+0w1cv+c5smxXEo60ly2IR4j73TeUp
	 gtB7wQmTM4aPangSjhgK8NXx5ss4LUIlNtsOATCIcqASsFlQGM3FstsQj/Niiw0GQJAeK
	 q37v9+zz+0c4y2ETnlKmMD3sOoSmQlIEJOeq/NvCbr2p6CBgdyWyJ99hl2Ikc9yMrabJ8
	 +FFdbYBwGS4vYe+LBEy184/x9LZjOH6L7LJpvDhKJPi+h6G1ma5QGaaMB9VyhMKDpZYCS
	 +Wq5xZkqHiFp+h8g8QW+SJJseahdS+rzo2YP0nUN3O4ZDaY227mPQJoVtPpFaJH/oFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JVGQlHRJuGY4FMHBo6URHjBCbsA+t7ekozhXbARFb5I=;
	b=PlAs7fVTy+qjzW7Bvnyg2rkM9kgfbvbEdWLK2FFpLXeliyheduyLpei9TFzp8oQeVZ7Q
	 /am8sHW+ahaItGFYVl4rBPX0NtbgnTVzPNNFvwZgvynMzcUH9l8rKcrOGmj0Onu8/K2xL
	 xify2yH4Qkg2ob0Vch+5xa6734fsofDyhc8jmZiPEeEKcANhlSX6Q78vNFv1PZ3urjD/2
	 B4Lb7K9nz5rNJzh7/oh4CyvEzcTjxfkvRMBBbVnZkOcOzDJ4JOwY8ARabXCyRhS51ysTH
	 P4MV/0yTe+fm3V2VzeGAZ/yEm81bPpuc2XDdvK3hdTkkANF3PjMnVwdrEaCfCmSu2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJbsTvdM;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D370606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D370606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJbsTvdM
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so84273a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937121; x=1794541921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVGQlHRJuGY4FMHBo6URHjBCbsA+t7ekozhXbARFb5I=;
        b=sJbsTvdMZICT+3B/LPrXwUYNZ+mmQiCVfwSIScDgW1BtDviL9DUMVrNeCRXEyiBxKe
         CXHahiW9FIUiF1I6fO09kmu7ATRNzWxiIqRLQx3N9BLCHOAIwPvOnXFWjFkQBjCgVa7Q
         cqd4Ckqpm189yinACjckcG/rYB2ZBjvyolKOBIe/sIylf0PJskMKbiIhcmwYJ4EZ02OI
         JlRFeHqGltjGSUJ/hhFRf12YcJOSeBP9IuFsnd1uxzNruh91qeaNkPo8ZTy+R/rY+EhG
         i/ZrMMzaz5DAEc+p2CCbtFldaMlYPa/PaILO/sEWQMU1dsnC/FdjPjvYbKXbdbaey/Jy
         T3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937121; x=1794541921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVGQlHRJuGY4FMHBo6URHjBCbsA+t7ekozhXbARFb5I=;
        b=2myTGVh+FevkB9lJdSI5PdXASNWayb/fUF5nuuxmoOquRwQdyjUMcUjU64dk4VHFM4
         EMqaQBet8Mj6ZQ9UUeE7/yzY77esjcyWGuXOLOltoiS5Y2duev8jVbEzZUVLGP1zIdf7
         jLpF5nQ7I+NKXr+aNXqP/b8lMlPDKsUSDUYCQPj+yRUIuln3MglabYy/Yml1CnVzFvr6
         B5e5OTqyqRVuJWM0YV4M8wzMmHbYEpYyxhF3tLSKlk5qagQSdWfJt9Ob/qDTat8Pzo2y
         LC3b/9CQ/cmabQmMFxusCM2ktNA2GKFu6dgg1Uhco/Gs5Pu5ELxwJfbfCEZyfVESAR/u
         D11g==
X-Gm-Message-State: APuU4Z89MolNkOY8HIFVxap2ykRcmZceTpcxG2VjmFzIua/9EAq4VimJ
	CpLazAIwljRcX41x9Us0rjXt6bqFWUickDEYxHkCRCjgpZPFuyTG/fi4KmhWxg==
X-Gm-Gg: AYBFou2kdO/oyNDsc7U7phgh8cEngoysgmw07I2X3s4V7p6JljovEMtXGshmmLhAHGe
	EIibtzkoWQKtrg/KTmDoNXRK75GeMNK/Ss5IDyDEKpe0SgLkp9xjeP1c7O65Xgq9PZbHQJ9hUFO
	ko8vdWHjXCdTXQ1HL47hS/wXPUyaX1d/qlcz9g1p14QqVzXqUGOgk54ZomK5iGNmWMudEZiD0kK
	d3y2QwWy5DfgSV29zrcSZ8ilptFpMI5oFTWELwsSLFo57yfnzF2T8sJ505iuzYgx2gbiB0rkt35
	absWZMQ4UsT/HmYCHuiqQULsLyZPuo5shG1oUAgktjQ5gIlVG1cOZP/18WNl5jeAyZJvNVON9Xt
	Z2wGl2AWu0x7QRhsGzKmRxORvdIfvprAhaYrSB+mgWpp8ouiN0O3nm789YcybQ+jk9KHDrmynZB
	a2XaZufCqA6PPT+ONVr+38HJ+LEOO4pKSbtVliNq5M66Sc9xjBNr8jCon0VnBP0D9MWWpWwfNgf
	d3+L9QvaSuLJrXTJyBP3hFWI4TufpSpuSaq8514pjIL7uFLQRj8Sqs6Z1nuPnlL6ks3LqmaCN1W
	kSnDPcdFzGeuffkEmD34/ZbwvfRg5USIM8Q+Y6dpuchF2FfLPKHhMbux7b0noAaCoAv/YP84YFl
	9zr3mlErchFMyD8N53RehMrlVZnqJfNGcSfruk84RbRJnpGrWwq1zf+YOrrpDdGcsQi86ALLqwA
	==
X-Received: by 2002:a17:90b:4b89:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3b0db5edb65mr1167998a91.2.1793937120195;
        Thu, 05 Nov 2026 19:52:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32baf86sm5867641a91.17.2026.11.05.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:51:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 08/45] bpf: Order the insns, find what stops a loop and where may_goto can go
Date: Fri,  6 Nov 2026 03:50:32 +0000
Message-ID: <20261106035111.3315285-9-alexei.starovoitov@gmail.com>
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
index dafbf2851b22..53507aed9f20 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1609,6 +1609,7 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env);
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

