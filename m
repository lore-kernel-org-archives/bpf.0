Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022750;
	b=jwOplwAtHn4mkjh7B2Lxhm3dgGK+OjgeXcUFUw2BejOVkrACqHYjYpWr/my/ITF6wdu9
	 ghB+zALdFU6bXLEjBZUG5cYHElW6L1YtuFMvKOfkW1iO4W14m1FJom0ZmiivRjiEKDOP/
	 WwK98bIVBSMbuqC8dmpcw44kfLT7JaSRRf+NdtK4Kwk7qIx7demrkqWhb3NvGvVe/1RMD
	 ip3F3VVg9g9jxPcKXqdbufIg4WsKmhaSsC2x8dWncvBPIUrl+MlKEnwBrHaqlBIyxN1rw
	 +E6SCV/5XEGR3FdgZF3e1mmL+ZZg9OeFEK/1HydtpiP2ak6DZz1kiNHP5iNHwtDhHUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OWxwQNVn5bg0ClfD56UMbqBHzyQ7/paQIisdapffxFU=;
	b=SNVZwtT7Iq/QtqnPZroX7LtbyzLH4skfPZNU9coVXLgHpbrG+ntVw0Qmy3nQmrhR1awl
	 tuoCpEMn9ECbCzFPBE0iB0IxRZtjlWb8gGuCLriHuP4I4KIvS/vZRpCpJDtLbAvdrjVOj
	 duSQZ6cZx4BwMfekt1REs84TNfOXcCx25Gt6DE5wjm1DQ4rjAhSKgeA0jSZ92oMSARXkN
	 zEEaYsSyYXNDLlphbuYL1zf/rzdJZ37yspTqX7K1kxmIpcCd/wVYUiEvLmvZjkh134UpE
	 1NIcGrNUTKhxiMowhgAxlB/KjhifY+Xmt1PWIfMdBmG7yKcDuDj9OAOT9D8UOFclP4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y9r4Jof/";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E79606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E79606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y9r4Jof/
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso887256a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022749; x=1794627549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWxwQNVn5bg0ClfD56UMbqBHzyQ7/paQIisdapffxFU=;
        b=y9r4Jof/e3XUTvg9dcn4wu2ZkfyNt4qtAu5nvq9Ao8ox7v42APxnqdOs4pYYg6FjNP
         hlnGddDqLmPyc5nhVFLiJbtdADllY/Fpp4pynC+3Y3aAhPsRvKovA/RtVtAuzqwN8LfO
         FqHnhJ6feP3GpZj7/kNy2e2YJK+959cmlbqABFcOa32/o3q9mbZVKr7NLoqMOi2mJwPD
         0DSqHbUwt5amPM0PiNe2L+hyklZIPlBBRNeLiDtmXOfaMduDtmiaJyegQhKFwPtzBnQ9
         P2ZhvOO3B+ssHzf0fN5YMEe/+N708+9YnpyxDmoySFxncDUdAC7RIkP6bgKSIioSV1w6
         0cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022749; x=1794627549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWxwQNVn5bg0ClfD56UMbqBHzyQ7/paQIisdapffxFU=;
        b=oNyCD6NtT0CGSUq45PgQlQI8xjXkS49Mr+W/uK3YOyg9aoDgf+ooIaRwBoWHzwu43E
         Zm8jid/AU1vfDOsepdFgY7j5kdlTGl2n6rzZlzaHpqRPPGUkpeBjh/0AWbtlQQcRx4PO
         d/nWsEtbCFaz/wuC7AhVrc8OmtLMxMeMlxBJU5QDwXKIXIto6rsu/WyPLxvqKR2qz6zo
         bGoTtcfTe6YIrCJXjQnIe0Uomymiy2W38tscAI4493VpHxDIcODYox96lQkXX/FP+B68
         4xoRJGnkhNgISLbjEgRGEIRBMQExjiwGOXibSNrl7ZhWkVAwvgK8Pcx8iH/w8Ba81nzM
         caHA==
X-Gm-Message-State: APuU4Z9y7DigqfZMIgzCRePODWpB86SIMx1DfVhp8WzkZydUxULj7rj3
	mvz+7V0NrzqbV0mtP1+3IDixmqG6tpGIHwEOmQ97ib/wcOPbm1r4bWQr8g56ow==
X-Gm-Gg: AYBFou3+rONymIqvGL1iBFaVzP90jHE6UQ5J43KQ3Q4kfVDKj99KSRLOjwusJd6N2fH
	g1MXgA1RA2jISKYgOnOYPsHcy8AsDIntMHK84xo/UpxVZ26rlRik00qsh5mAaqQp8lGEfFrOR13
	ZGQX5pw2AZ0qhuTbCA0jFdhpYVbJnYHgDA60Xsjcge1kbb+M1yvUwmN76b1+2T67wqhNUToEvHl
	9RvrOt7RN2LrHiZRcZDfW9C1MENGvF+BtCdOQ7MNYnxI63vOCsOXD2zOzJxJGLnzc1l1f0MatHh
	d5fsjn5w1HzDdHu3QAenXUtvGAnuswpSP3/yuhymOrBXgKslPhL8xJ01hpPCR3pllzyRGvErmN+
	OkpAcaMl4zqPXMPAfV4Cuf96swGBF6Q9xhBh3abug7uLSsm1k+7ExBh8utbYfcqMGSNlNshV1ZF
	hOpVlUEbgnl471HoUYTFBenQ8wNbuTv9nImOCeT+nLrYKVle7N4Dltyrr4SAl4MZxeIeG9nuCF0
	ZwgKwLiZxTc4XnrFOZ+65NLDT3QUvSyx6SdRGEnuVVONsL79yinhFqt3DkOgREyqJUORC1euYRR
	tr7IIURU2afjWPqQywR5Zg7gTTwr6aC3foJWl3ipEseBoukHQtyYDBwEzlLpPYeIMwocYV0NgRp
	s00d5SQTVWcOqCcOGDoaY/CdJEc6j3E7PWmCYdFxBWbPw4ASKEWLyN3gWYN4c7GY2Iix06BLQRb
	Q=
X-Received: by 2002:a17:90b:1801:b0:3ab:884b:65b7 with SMTP id 98e67ed59e1d1-3b0db6d3f55mr4508863a91.25.1794022749259;
        Fri, 06 Nov 2026 19:39:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a0475sm1441629a91.0.2026.11.06.19.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:39:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 11/46] bpf: Add the sets of states at an insn and the entries of functions
Date: Sat,  7 Nov 2026 03:37:19 +0000
Message-ID: <20261107033758.1547725-12-alexei.starovoitov@gmail.com>
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
the one before it arrives: pandemonium_select_cpu, 130073 insns, not 26758.

bpf_flow_prepare() marks the insns where a state goes into a set, and those
where a second state can arrive. Only there the set keeps a state that the
verifier used: to keep them all doubles the peak of states of Cilium, scx.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 324 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index f5a91552b090..3996220f89f0 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1152,3 +1152,327 @@ bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r)
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

