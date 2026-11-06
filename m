Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937139;
	b=Sw51VXDwI+Jin9T4lZsPPMuie0iJ424eyk2KvOxfXvJsDWnP/UtTRNNn9NdX3ZgeYIUE
	 +SfzRdnaTj/w+JBXxhtqsc0Q9K20osQCqrlnhOXXjsiGx8PeK0eAJ0rFkaljeIdWFKwxt
	 msIIwG4Y2WZ4KRWYERxOdYRy8hl9PxAKWc9DWHZA8R2iSikoryOER8vqhjM4QQWI1nNYE
	 nnQNvxuReiV8E1QHDfdnaSvhIHtBVp495KL074XDv2ze7AYCgm++hTG1s+U3lqIf6bFJT
	 b+jlQqJnB9j9ugSvIodoM2IQGYo43x6PNYnPFKDG2Pt2+Dr/PD5d9wvMb3Fr0QNdtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
	b=0rTY+OhQWdE7q/pXymzCN3NxsvlZBxMI0SKPAgejwBEj2PKGPLLg7s6KpXDyyTcrVXlW
	 8xFJs4C1tRf6/0qogVcoJLUNI4GyNPjTcS4hfNhR3DECXGU3X4C4NANefuRGMNs/xU2yD
	 Ob/hjgU1e/l0rY2eOtchph4B7Zl8AP7kkorEOCOe4z8UzeZMp9ZohuQ5tkKoBT9F+Xez4
	 z6DItOGF45cGR/YjyJzl2jtqmD+Zt7KnDArSVDCUysXdwKjkFwm2X1e2Q0Txz06uZjzMt
	 xF/KaWon1d+Sr2zqfbAC0SOOvCrubevhDBSSMFeAMW7pLT8Ii/Z4lqvhcNOcztU/R/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qaRZ5FMJ;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C116606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C116606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qaRZ5FMJ
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso79016a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937138; x=1794541938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
        b=qaRZ5FMJf7t9ewt/xycJ0eNQUw6YkCiRGBKvSHd7Ikkkcds4QMvy5IuJLeZr2V+kNd
         5cwNoNVIa0gXRAZTDP6l46duZLqjZ3TQQO2F73g6Mh4pcg4/mslNJFHWcmiXefW6KVcg
         4iwW7jg8Aae5lL0AEnswSrypUBdzz3l0Enn3KKxOBUD28visxAgBIjvHASdOyXmo31Qk
         l+a7zJnLZx+fuvtBJIhHRJ9HS7EUzwQAC45QTbDRnoMgihroFYr5f/49mcEJ1lEgL6Q+
         7iy5Pt4aP8E6Wlfzg8JdvfSS/lzQQN9K2I9kKxcVNF58+w0zZTyew/4/MSRqNDvd8QDA
         Cdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937138; x=1794541938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
        b=hgn/toWL5+V45Mth0dvngypHC/anKCt3XJqoRZBn0IYNfd9ZJTNUeUVHERe+Biqtd5
         lOUhzpbsydgu8E1WXeJMJTH7/WJv09aNHsdRVHwG2f+6vwsljrgEbE8kFdJgXhaIo9IR
         HHkewNF1SI9NL0vMYl3FCLfoqy9w8mbycRmXvgup+B9p4AAXFrq8HRJtlHVdPK8VMl0m
         qE7tI6UDhBuyTO7QUK27DIt98aDYeAaJvdmJbJKgszDk70siuMdRQKePQNUc7ZIGhCYo
         QA9xzbvjA1+0Ej8H4aqxxFvWHe+mnpGGdpzW7Blpm48crVpl4pZUGpr2JEp/b1/glSN9
         VyKA==
X-Gm-Message-State: APuU4Z9k88uh521/ErKf5mnJfuav2eYxqTSBv2xi33/B498/3S0ae+AO
	AyXiEuhzmBSdhry3Gbn3dDLfoL2PnqAaS0a5pO28nWAAhn1L1ONXPR5cWHEXHQ==
X-Gm-Gg: AYBFou3vS38LyYuwQ8bEu/OR4wIaGNI1y6XUTLSP/1kjYpcxWjQgGgLhvdNkHzxQzNQ
	3Qtz3vy/rBW+QyM+/bcC/M5TrDe0r7VUmobkLwAGVZ6vzq1Vt1nKfDoHXmPDAHs+/YtPXTEPgkd
	wsY1pX41WcYz2JOiNQHNaHSMAd7+JG0VerNvIbL2f0E9gFaeewolqVstAWrFQY/t5IwYmyxzOmT
	7vQEc6WutIJRUZji3JpXjBLJPpYX1njkCcZhv+anO7vwlT1xgPOO1YtfwR4bqpcVeub6V4nhy6K
	G8iebe5XDIRzlIJlpVjU6zaC3vDo7RLmrVwwOwQHFhSz397oEHeFn6IHMZxO9YI7f1rZv4ds2kP
	mcFTY3hB+ja52i2fNBPpmiK9LlHauW6TyvcVSsaFlBRt2SwYq7xZwfFIdOFrOaIZSR2C3njFQBZ
	Qo6YfZLWlsoOHWLTlbrnsJWQKfaPmifelTZCjk9MRRESdJeDsM9idBb+1ZEqE2PV7aH0ehDIuop
	YghyFSoHyHG6sQxTSxe9ii7xxa4UBtro+jmUdZ/JR1epAuhrD2HL8jLI5rUC/prs/wLMpxfA7qJ
	oo0VdEkFyVtH9rs7bnPAbrUaZPT4GBGpz22nVOqhFpkvmg2uG0AXOyr7RSkWjODcmkNoGHtSmUH
	0v5dN/poVvB4vv6RfUaM3+0EiHSzh9slhVDNJmo/JpM+0UhyuEFOTdrev0BC+tGRsNiTnwLE6dg
	==
X-Received: by 2002:a17:90b:3c86:b0:3b0:a3eb:759d with SMTP id 98e67ed59e1d1-3b0db6a0113mr1145833a91.10.1793937137748;
        Thu, 05 Nov 2026 19:52:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d78b0a8bsm1525323a91.2.2026.11.05.19.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 11/45] bpf: Add the sets of states at an insn and the entries of functions
Date: Fri,  6 Nov 2026 03:50:35 +0000
Message-ID: <20261106035111.3315285-12-alexei.starovoitov@gmail.com>
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

Today the verifier verifies jhash() again for each state at each call:
530362 insns. The main pass verifies a static subprog for the states at its
first insn, and the call waits for the states at the exits. Each call that
waits makes an entry. Its number is in the entry state and in all states
that come from it. 4095 states arrive at the 90 calls. At the first insn of
jhash() a state of a different call covers 4005 of them. Then each exit
state is for the calls of the two:

  call A  -->  entry 1  --+
                          +-->  one set: calls { A, B }, exit states
  call B  -->  entry 2  --+

Thus the entries are disjoint sets, with union and find: 50765 insns. If
they stay apart, the main pass hits its limit of states at an insn:
"more than 1024 states that cannot be joined at insn 903". The same for
pandemonium_enqueue of scx_pandemonium and 100 of the 225 progs of the
schedulers of rust-bpf.

All new states are in one tree. flow_set_pending() gives them an order:
 1. Callers are before the subprogs that they call: all calls get to
    a subprog before it is verified.
 2. Then the position of the call in each frame, then of the insn. Thus
    a callee that keeps the frames of its callers, like a callback, is
    complete before the code after the call.
 3. A walk verifies a loop iteration by iteration, as today. An iteration
    is complete before the next one:

  for (int i = 0; i < MAX_AFFINITY_CANDIDATES; i++) {
      if (*val >= nr_cpu_ids) continue;
      if (++checked >= affinity_search_online) break;

'continue' is a back edge in the middle of the loop. By position alone it
runs ahead through all iterations, and each is done again when the rest of
the one before it arrives: pandemonium_select_cpu, 130073 insns, not 25589.

bpf_flow_prepare() marks the insns where a state goes into a set, and those
where a second state can arrive. Only there the set keeps a state that the
verifier used: to keep them all doubles the peak of states of Cilium, scx.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 324 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 1eecd9ee5123..8daee1f22461 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1145,3 +1145,327 @@ bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r)
 	}
 	return false;
 }
+
+int bpf_flow_prepare(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	/* the rest is for loops */
+	int len = env->prog->len, kinds = FLOW_NEED_VALUE_OFF, i, s, err;
+	struct bpf_iarray *succ;
+	struct bpf_flow *flow;
+	u8 *preds;
+
+	flow = kzalloc_obj(*flow, GFP_KERNEL_ACCOUNT);
+	if (!flow)
+		return -ENOMEM;
+	env->flow = flow;
+	INIT_LIST_HEAD(&flow->kept);
+	flow->pending = RB_ROOT_CACHED;
+
+	flow->pos = kvcalloc(len, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	flow->rank = kvcalloc(env->subprog_cnt + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	flow->point = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
+	flow->keep = kvcalloc(BITS_TO_LONGS(len), sizeof(long), GFP_KERNEL_ACCOUNT);
+	flow->states = kvmalloc_array(len, sizeof(*flow->states), GFP_KERNEL_ACCOUNT);
+	flow->enter = kvmalloc_array(len, sizeof(*flow->enter), GFP_KERNEL_ACCOUNT);
+	flow->nr_states = kvcalloc(len, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	flow->funcs = kvcalloc(env->subprog_cnt + 1, sizeof(*flow->funcs), GFP_KERNEL_ACCOUNT);
+	preds = kvcalloc(len, 1, GFP_KERNEL_ACCOUNT);
+	if (!flow->pos || !flow->rank || !flow->point || !flow->keep || !flow->states ||
+	    !flow->enter ||
+	    !flow->nr_states || !flow->funcs || !preds) {
+		kvfree(preds);
+		return -ENOMEM;
+	}
+	for (i = 0; i < len; i++) {
+		INIT_LIST_HEAD(&flow->states[i].list);
+		INIT_LIST_HEAD(&flow->enter[i].list);
+	}
+	for (i = 0; i <= env->subprog_cnt; i++)
+		flow->funcs[i].exit_idx = -1;
+	/* from here on there is something for bpf_flow_reset() to look at */
+	flow->len = len;
+	flow->nr_funcs = env->subprog_cnt + 1;
+
+	/* subprog_topo_order[] has callees first */
+	for (i = 0; i < env->subprog_cnt; i++)
+		flow->rank[env->subprog_topo_order[i]] = env->subprog_cnt - i;
+
+	for (i = 0; i < len; i++) {
+		succ = bpf_insn_successors(env, i);
+		iarray_for_each(s, succ) {
+			if (preds[s] < 2)
+				preds[s]++;
+			if (aux[i].bb_end)
+				__set_bit(s, flow->point);
+		}
+		/* where the callees come back to */
+		if (bpf_pseudo_call(&insns[i]) || bpf_is_callx(&insns[i])) {
+			if (i + 1 < len) {
+				__set_bit(i + 1, flow->point);
+				__set_bit(i + 1, flow->keep);
+			}
+		}
+		if (aux[i].calls_callback) {
+			__set_bit(i, flow->point);
+			__set_bit(i, flow->keep);
+		}
+		if (aux[i].loop) {
+			__set_bit(i, flow->point);
+			__set_bit(i, flow->keep);
+			kinds = FLOW_NEED_KINDS;
+		}
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+	for (i = 0; i < len; i++)
+		if (preds[i] > 1)
+			__set_bit(i, flow->keep);
+	for (i = 0; i < env->subprog_cnt; i++) {
+		__set_bit(env->subprog_info[i].start, flow->point);
+		__set_bit(env->subprog_info[i].start, flow->keep);
+	}
+	kvfree(preds);
+
+	err = flow_compute_order(env, flow);
+	if (err)
+		return err;
+	for (i = 0; !err && i < kinds; i++)
+		err = flow_compute_need_const(env, &flow->need[i], i);
+	return err;
+}
+
+static void flow_free_state(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	bpf_free_verifier_state(&s->st, false);
+	kfree(s);
+	env->flow->live_states--;
+}
+
+/* What a pass leaves behind. */
+void bpf_flow_reset(struct bpf_verifier_env *env)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_state *s, *sn;
+	struct flow_kept *k, *kn;
+	struct flow_exit *x, *xn;
+	struct flow_entry *e;
+	int i;
+
+	if (!flow || !flow->states || !flow->enter)
+		return;
+	for (i = 0; i < flow->len; i++) {
+		list_for_each_entry_safe(s, sn, &flow->states[i].list, node) {
+			list_del(&s->node);
+			flow_free_state(env, s);
+		}
+		list_for_each_entry_safe(s, sn, &flow->enter[i].list, node) {
+			list_del(&s->node);
+			flow_free_state(env, s);
+		}
+		flow->nr_states[i] = 0;
+	}
+	flow->pending = RB_ROOT_CACHED;
+	for (i = 0; i < flow->nr_funcs && flow->funcs; i++)
+		flow->funcs[i].exit_idx = -1;
+	for (i = 1; i <= flow->entry_cnt; i++) {
+		e = flow->entries[i];
+		list_for_each_entry_safe(s, sn, &e->calls, node) {
+			bpf_free_verifier_state(&s->st, false);
+			kfree(s);
+		}
+		list_for_each_entry_safe(x, xn, &e->exits, node) {
+			bpf_free_verifier_state(&x->st, false);
+			kfree(x);
+		}
+		kfree(e);
+	}
+	list_for_each_entry_safe(k, kn, &flow->kept, node) {
+		bpf_free_verifier_state(&k->st, false);
+		kfree(k);
+	}
+	INIT_LIST_HEAD(&flow->kept);
+	bpf_free_verifier_state(&flow->tmp, false);
+	memset(&flow->tmp, 0, sizeof(flow->tmp));
+	flow->entry_cnt = 0;
+	flow->united_cnt = 0;
+}
+
+void bpf_flow_free(struct bpf_verifier_env *env)
+{
+	struct bpf_flow *flow = env->flow;
+	int i;
+
+	if (!flow)
+		return;
+	bpf_flow_reset(env);
+	kvfree(flow->pos);
+	kvfree(flow->rank);
+	for (i = 0; i < FLOW_NEED_KINDS; i++)
+		kvfree(flow->need[i]);
+	kvfree(flow->point);
+	kvfree(flow->keep);
+	kvfree(flow->states);
+	kvfree(flow->enter);
+	kvfree(flow->nr_states);
+	kvfree(flow->funcs);
+	kvfree(flow->entries);
+	kvfree(flow->united);
+	kfree(flow);
+	env->flow = NULL;
+}
+
+bool bpf_flow_is_point(struct bpf_verifier_env *env, int insn_idx)
+{
+	return test_bit(insn_idx, env->flow->point);
+}
+
+/* A copy of @st that lives as long as the pass. */
+struct bpf_verifier_state *bpf_flow_keep_state(struct bpf_verifier_env *env,
+					       const struct bpf_verifier_state *st)
+{
+	struct flow_kept *k = kzalloc_obj(*k, GFP_KERNEL_ACCOUNT);
+
+	if (!k)
+		return NULL;
+	list_add(&k->node, &env->flow->kept);
+	if (bpf_copy_verifier_state(&k->st, st))
+		return NULL;
+	return &k->st;
+}
+
+/*
+ * Both are in a loop whose iterations are kept apart: an iteration is done with before
+ * the next one begins. A back edge in the middle of the loop would run ahead otherwise and
+ * leave the rest of every iteration behind, see flow_earlier_trip(). The state that stands
+ * for all iterations comes last.
+ */
+static int flow_cmp_trips(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
+{
+	const struct loop_stack_entry *ea, *eb;
+	u32 i, ta, tb;
+
+	for (i = 0; i < fa->loop_stack_cnt && i < fb->loop_stack_cnt; i++) {
+		ea = &fa->loop_stack[i];
+		eb = &fb->loop_stack[i];
+		if (ea->loop_id != eb->loop_id)
+			break;
+		ta = ea->apart ? ea->trip : U32_MAX;
+		tb = eb->apart ? eb->trip : U32_MAX;
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
+	for (i = 0; i < a->key_len && i < b->key_len; i++) {
+		/* key[i] is the place in frame[i - 1] */
+		if (i) {
+			cmp = flow_cmp_trips(a->st.frame[i - 1], b->st.frame[i - 1]);
+			if (cmp)
+				return cmp < 0;
+		}
+		if (a->key[i] != b->key[i])
+			return a->key[i] < b->key[i];
+	}
+	if (a->key_len != b->key_len)
+		return a->key_len < b->key_len;
+	return a->seq < b->seq;
+}
+
+/*
+ * Callers first, so that the calls of a function get to it before it is looked
+ * at. Then by the place of the call in every frame: what is called in the frames of
+ * its callers is done with before what follows the call. What follows the call of
+ * a function that is verified on its own goes on with every state that comes out.
+ */
+static void flow_set_pending(struct bpf_flow *flow, struct flow_state *s)
+{
+	const struct bpf_verifier_state *st = &s->st;
+	u32 i;
+
+	s->key[0] = flow->rank[st->frame[0]->subprogno];
+	/* the place in the function makes the rank of the function redundant below */
+	for (i = 0; i < st->curframe && i + 2 < ARRAY_SIZE(s->key); i++)
+		s->key[i + 1] = flow->pos[st->frame[i + 1]->callsite];
+	s->key[i + 1] = flow->pos[st->insn_idx];
+	s->key_len = i + 2;
+	s->pending = true;
+	rb_add_cached(&s->rb, &flow->pending, flow_less);
+}
+
+static void flow_unlink(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	struct bpf_flow *flow = env->flow;
+
+	if (s->pending)
+		rb_erase_cached(&s->rb, &flow->pending);
+	s->pending = false;
+	list_del(&s->node);
+	flow->nr_states[s->st.insn_idx]--;
+}
+
+/* The entry that stands for the set that entry @id is in */
+static struct flow_entry *flow_entry_find(struct bpf_flow *flow, u32 id)
+{
+	struct flow_entry *e = flow->entries[id];
+
+	while (e->up != e) {
+		e->up = e->up->up;
+		e = e->up;
+	}
+	return e;
+}
+
+static int flow_entry_new(struct bpf_flow *flow)
+{
+	struct flow_entry **entries, *e;
+	u32 cap;
+
+	if (flow->entry_cnt + 1 >= flow->entry_cap) {
+		cap = max(64U, flow->entry_cap * 2);
+		entries = kvrealloc(flow->entries, cap * sizeof(*entries), GFP_KERNEL_ACCOUNT);
+		if (!entries)
+			return -ENOMEM;
+		flow->entries = entries;
+		flow->entry_cap = cap;
+	}
+	e = kmalloc_obj(*e, GFP_KERNEL_ACCOUNT);
+	if (!e)
+		return -ENOMEM;
+	e->up = e;
+	INIT_LIST_HEAD(&e->calls);
+	INIT_LIST_HEAD(&e->exits);
+	flow->entries[++flow->entry_cnt] = e;
+	return flow->entry_cnt;
+}
+
+/* It delivers states, so it is done when nothing is in the middle of that. */
+static int flow_unite(struct bpf_flow *flow, u32 a, u32 b)
+{
+	struct flow_united *u;
+	u32 cap;
+
+	if (!a || !b || flow_entry_find(flow, a) == flow_entry_find(flow, b))
+		return 0;
+	if (flow->united_cnt == flow->united_cap) {
+		cap = max(16U, flow->united_cap * 2);
+		u = kvrealloc(flow->united, cap * sizeof(*u), GFP_KERNEL_ACCOUNT);
+		if (!u)
+			return -ENOMEM;
+		flow->united = u;
+		flow->united_cap = cap;
+	}
+	u = &flow->united[flow->united_cnt++];
+	u->a = a;
+	u->b = b;
+	return 0;
+}
-- 
2.55.0

