Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911582;
	b=Lt5OnH/HnOT9o3iuGPLsVktJXcLl5rac/LZZ/a6NUs/IAnDOvNMAcJ4Go1XFIRvFm1zW
	 B73hOkMXQk7Q5BQTcXiLtgbPUqV9wd2FlYuY2F/QwbN2a9mVJhVxEuPtPNIzFO8sc71iD
	 1oJkqqC+VWh9vfiqm4KrT802OPfjX35wKzfBOwsEzdenwQ2n269aGSYIiAWMtgfoE3CZU
	 P1c1yKoZmQvuPlGxtR0YPZmUCaNJuyJXLDmQtfx/pVuqmuW0s7yhsgG/PI8pwyA/pBhTr
	 4IMpmqCDAVSLONo4OooAdZrhOElrCz/9z8LzN2UaEKwWK9ZtD3NX7ciL0Ik2aJfQXRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
	b=iTUg8TeHcVCHrCy1AhfJElEEf9q+O340gDhZHhecQLgneBzXOBGMT2HX9Km9XYAyT+Jy
	 3ua3KrriITYs4wapfF9KuTZMhqvKCBjpJbnxREWemz531t5p2NRLDFnkG28WDYNPs1rEC
	 qIWAQvhrGcJqGY0CpWD1DCnn+tjZ4sqdpklRLOtDjYS52hmXbjwebEP12+jrP26JhVjO4
	 pnKNrrusJvWmFU0wYC2cqDAQ9R1H5645dWk/Bsr+sHGp+K8WvWHO6kHj+UYUe5Q6nJlhA
	 roE8Fw38eZm49pLwAQhMlF0xo62tAvTq4bYmgc+V5KFaZQ1QPDDpCZe4WfklkwtXung==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwcDsgq1;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D523606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D523606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bwcDsgq1
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1921430b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911581; x=1794516381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
        b=bwcDsgq1oPrUlGndGIwWn0Oj8gmwHV+gEyg1WN8Vi1mACKLgV2jI6g9FrRP8yKlbvV
         3UJ4jQfov9sTWe64OIBYZ+g+TOI7ExDe7wJuLwrJVEik/idEZMdTUWdPCI9z6IAuZva3
         s2dZsWEoziqtW2531BBbE7PU1TYHlvUdj7vNARB8V6IW3fV05/NjcLFi+YuEUauKczsC
         ujiW/CC+BXqIju+RYJLctOZ0RrQ6spbutC7FcTVvIK2YzVAjf9uc3cpfYb+L+bTn4aqd
         ottx/UTUKy3lYq+fkRQHJzMJgX48crjnB+7hFqFdb6IiJ6EjmEy34rbAVUmGGW0KUSAD
         3c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911581; x=1794516381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HdPkWH5HbEY4rgOGQ2nAd+3FK4FA3iQ8HiQ1RDNWVBU=;
        b=HYPKf3DlLmKFbz5jFn3ZcJsHE+9YBimsd+NnHrgIiUN7w9Sdvte1+NbbdrGTRnf/yI
         8KYPvDe7W7mEuLID9LFL7tZwkzcCjFrTF7c/pIKlp20X4mV97If15ckHIosj/vd3mfmG
         duFUZYoGqsP6LLlW8Eumvv00QpsWzhFazQRvrExguOtt+aVtBf2cKapHN73jsXjvr0jJ
         jiNYam4cl4+B0qni30XlLEQV36eyuklG5+WAJxXJDHHA5swoBKDgeGGEMK+BqI8qLcJX
         yFIV1YGxia0uOw6VdUT2pbZDWegY83wnUqJRL0VNw41j3jpHp/WXdDnzcv77C90doXHw
         Bw0w==
X-Gm-Message-State: APuU4Z/Db/m89lEJFLTPcyJrzv87oROK2qqcJbULwK0vG3gHFzGgiJ2G
	5ad+B4gKTwrV/lPpLRIGWYs1+fzmh+cRQid8U5iY+YANIM8E5SujpMmvAJuo9Q==
X-Gm-Gg: AYBFou2nl2Mqf8J/GPcUGru/0RD6RL4QDbFmPyvL1c8X4qH7hbEYmBORM0rS2u55yoG
	bvZTQcbcfZfl4Yrw7qCgIjztr5taMT/pUoTUQiETtVmNjlJoP2oIXtw48ohTKsP/d1Gica3vQy3
	GHzu8CV3kxd4UOiLmVRb9EyfaYdHFvW07SDftAM/XR/AumNumOHaxS0uUky2W5aO4gNo/Dz6+6H
	31XqtVzYITPcaySBSb8wQ7d3g82aJa8Xhdbigwd7CACLkqhgvQ9jOerd1QZnFRbijEoOX28Exxq
	MM1KJOIXN/dLu8Cx1F9hUfUYqxpLuJW/1vcXWHorIwr8wYiCWcPgUx44ir2Lb+8mk3dq/Pmi8V4
	gUrJ5lvURJlAAjnBdMTYGhNomvYDCiPKQzvtgffX3a9IfGDx3E6w9RoqfcPBnqXGKa3YUsiVbrb
	9WLxd8Xp3xD+W6VoNwIgGlSOgMpoCklm2PW5oVeeCs8c3CbJxWr+2E8f9pp0g+gIYVz2UHn4rQW
	i4UYNS7WG7Z7xZg+oFAnzsVY1LinRAsEBRPlXEP/tXHn78BX6PGEX+r5+ob7HXc5p73fRcSvN1e
	4mswJYsOViwyqtKa4SWBLax2ul4FzIysTHFvQ+BQQAvVSfjRSlZ9EYd81CQ4ig0xkm5asrLF3Mk
	71w/ORnkPjqWYIGYTo8OVnAPt4o035X5HMCwm4kpFREh0VxtP6E5umEfYQeRFlwNKXethU20bAA
	==
X-Received: by 2002:a05:6a00:32c5:b0:8b1:e8dc:c894 with SMTP id d2e1a72fcca58-8b377c8e4cemr219124b3a.5.1793911580467;
        Thu, 05 Nov 2026 12:46:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597ef3d1sm83130b3a.22.2026.11.05.12.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:20 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/35] bpf: Add the sets of states at an insn and the entries of functions
Date: Thu,  5 Nov 2026 20:44:48 +0000
Message-ID: <20261105204513.2230344-12-alexei.starovoitov@gmail.com>
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

