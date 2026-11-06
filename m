Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937151;
	b=Z4TegU9iOddvtpl0dq1DHprd71lSNIJYFMk3KbUGXK4ENMrUe2IGgzuQKkTYz78mPOrE
	 WXzdCsTYfgAZNmmtb7dU7kre7m9SWRyh2/j0DTF+IAO+8rKaYCQihKIRorTj/jpk6h7ne
	 jdNTlqIt3JMlLjqMt6sJrPK02rT57Bggwvxq+voCiK1aJll22zM7pRKLrn2xbruUOQ1pf
	 /mFIuQe3zQ5UWSW/gWwBOmvrn9HvFAbu5BqrTmu9aTteOz3JpAv6yW+w9kYk/vSiy9UIi
	 7USg/md5raK1jzrcFtxKAzyUaTGsU6W2nCBXhTf5pbB+9UEaSGlvSYHLyC3nppdSE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YtejizPfxs3jRgmZcdt3Pgxe8M1NLv0ggjQ6rk13Xso=;
	b=c+Ttnc4XtSRqOD+lV5fGgsrfu3pFLZqt3ATGsSKtNoyCg6pPlFolDnoYblpJwejYmsd3
	 J/m49BVknCu+WywMsBuCZsE4aQDe0Pf+36ojNI16N1GJ/CbdH74lxzkXi51hwQJFCwLT8
	 RDQPaLYWhleYWEogKOumCNWUK3Hbmbqr1Gn4cCdDcc0La4y1c97T40K3O+kKbqO84NbgZ
	 nXMwCGtQ0nyBqQ88teD0QumQrBsnV3W17XI4b4EThALOS1a+E7dTKTnTB1JdXoe3LPaoB
	 rrsG41WW46/KKmDV6t5bM0FZrBTE3CYTAHFbBeawxM8Uuh3UYsvWpp6z8uop3Rayxig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VREvhPt6;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BA606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749BA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VREvhPt6
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed408b0d9dso699925ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937150; x=1794541950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtejizPfxs3jRgmZcdt3Pgxe8M1NLv0ggjQ6rk13Xso=;
        b=VREvhPt6tcKgIrsbd4rDR1MK5UpOaHG2JaZ5Vp3ChC/5IbHw/zv6hDYys0f8t768eO
         KE1pCTD4RSAF9RLpXDRG7v3a9JR52T8Qc55WmoHqTKLGq0MO+5LZOANhkzkdb0m5whX9
         nfIyc4QWQkuPCvF7XirC3HYPfuylfsCciGrpisXiXUN29P+q1esTCt7OQr5LQpdc6zPI
         J9ScQAYVzNzv9QHY32Ps8187PPM2wrgSGoLRGOzpK0XCvLCyRX6WrdzAXLHW4NxXb1k/
         CChaUIfBiakZWDdZ5mHOeWH6SkweHhaXaM+/qlfiB8N4wavhh2bmlybvzLXdH266ViVY
         jZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937150; x=1794541950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtejizPfxs3jRgmZcdt3Pgxe8M1NLv0ggjQ6rk13Xso=;
        b=vgDfZOcW0eD9cegIZHOEdItO07GT58ior6NIkdNYYVrythkShaV0y8hcjddHSwwzW5
         r9x1IKFcvEwKkaE037H7LYSQwOsHXXTPZCiEi/Jkl7XlJ0E85+ozCbF6DO9GtdRn+QHd
         BggTn0s13hRvTDxzASaf7l5gsdktfKPDGVSzp1h/w/3U8uuMc44SBO5rkwZVrayeu41P
         AcvQK9SOld36s6w+mPxC+6PGzRIfE9GXZyDEJUBVV2nw/P5VO0ug6TRPPi5smpTJcw4g
         duUENIQ6Wi7QMhHY0wo+AQBd7IA++gfn0JqJvv8fUu8eJLdQpLAmfyVhwCNE2xBwgxCB
         6UEQ==
X-Gm-Message-State: APuU4Z+CE1LDbf8zx+ViCnoR4fyNobMAThqGP8bGHMBuanFZ4ZQnrdsr
	JX4RBbV5W09CVnWEIS8I7283wBtFNEG5V7TSIWRvQ3BxtEj/8G1Fc7QFKBO3YA==
X-Gm-Gg: AYBFou3hrIFjxg9CC/RSt+AzavuFYelhlEdLo2Baz4N0Vardgo+f8bF/ziBha+NuDp8
	A4s/3uIYVQr+OR37OfYpW4aw21KvP9P8epyWvLXLsHMYb+5TfgAdyiP0FwSRsR8lv8cHU29y09H
	stFQELNNN5KAt2TRYWBSbOQSCilPhS9+PIAXg8PXD/zTleSqk1sMcOoFv4xOA5vgBetaRJNa2Sz
	ZgXFOHFYpd4L5k0sq/Pg74/259a4Kp2WDfNCYXAvOIo0d/lNwba8cW9MeAH+vh/KrQROsIJ5BO3
	layPpQY8K/KruQ4uZmdzjOz+ikjEUOJn3WCiSCs57rhAlokeYd2XD/hd5UHYHbIy8n6HYPdhzEn
	8f9w6ACeZPPaDD4BOU7/a1UXGoTSwmHyqpOcSPjeKqWevuboOq7lOcxzPU92McNuoSwewo9iTRf
	QKO82xQIGBXMPy6Msovnms8qwJzraaCIEkcKHLlqgotGFolU5PCu882wp7d3yMJ3alQLZjgSSgl
	UQPlscU5r00Yaym8p45xuMa/r19obcEYyRaV6oVDEYeIuP1lIDJjByzsV0C8IIs/dsZIQ/0Ggp7
	OX02JTF7Ay0wPtMA4gJgM29E2JihOAl0Yb8txvhPikBXVVp6Yk2FZ5iW/3llv5E5ES8xH5MHe1F
	ThuqytFvcfPnVY1SEmozAlr5oevrhk/YLKlesSYGsqs1/F45iBN49crLPuJL36v4crWCVHFJwNG
	M=
X-Received: by 2002:a17:902:f681:b0:2e9:61bf:6587 with SMTP id d9443c01a7336-2ed41c658dcmr20101695ad.49.1793937149505;
        Thu, 05 Nov 2026 19:52:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d88107sm1133205ad.61.2026.11.05.19.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:52:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 13/45] bpf: Decide which states are not joined
Date: Fri,  6 Nov 2026 03:50:37 +0000
Message-ID: <20261106035111.3315285-14-alexei.starovoitov@gmail.com>
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

Cilium, nat.h, in tail_handle_snat_fwd_ipv4:

  if (ret < 0) ..; to_sport = state->to_sport;

(ret=-155, state=map_value_or_null) and (ret=0, state=map_value) meet in
front of that. Numbers always have a join. But ret=[-155, 0] with
map_value_or_null has ret=0 without state, as no path has. It passes the
jump: "R3 invalid mem access 'map_value_or_null'".

A join must not make up what a later check can see. A number is tested if
a later jump compares it with a constant, or the verifier checks its range
at a call or at exit. States that have a join stay apart if they differ in:

 - A tested number, and the ranges leave a gap: -155 and 0, not 0 and 1.
   113 progs of Cilium, profiler3 and test_seg6_loop without alu32.
 - Two tested numbers, each without a common value: (err >= 0, ret=0) and
   (err < 0, ret=DROP). The join has err < 0 with ret=0.
 - A flag, 0 and 1, that a jump in this basic block or the next one tests:
   'ok = i < 64 && v->in[i] == 2; if (v->x == 7) v->n++;
    if (ok) v->w[i] = 1;'
   clang keeps ok in a register. (ok=0, i>63), (ok=1, i<=63), (ok=0, i<=63)
   meet. The join has ok=1 with i>63: "R0 unbounded memory access".
 - A register that only one of them sets. scx_layered/layered_runnable:
   'scoped_guard(rcu) { if (...) return result; nsid = ...; }' meets at the
   unlock with a flag of the compiler, then reads nsid: "R7 !read_ok".
 - Two tested numbers, (0, x) and (y, 0). xdp_synproxy_kern and
   test_tcp_custom_syncookie: 'if (hdr->ipv4) ... else if (hdr->ipv6) ...'
   after the packet changed: "R1 type=scalar expected=fp, pkt, ...".
 - A constant that becomes a stack offset. bt_print(), 5 selftests of scx:
   'if (... || depth >= BT_MAXLVL_PRINT) return 0; ind = stack[depth];'
   A copy of depth is tested: "invalid variable-offset read from stack".
 - A constant that is added to a pointer. katran/tcdecapinfo, 20 or 40 in
   'if (data + hdr_len + inner_ip_offset > data_end)'. With [20, 40] the
   jump says nothing about data + hdr_len: "invalid access to packet".
 - A constant that a kfunc or helper must know. One call is made of
   'c ? bpf_rdonly_cast(0, id) : bpf_rdonly_cast(0, 0)' in
   mem_rdonly_untrusted/mixed_mem_type: "R2 must be a known constant".
 - The number of calls of the callback of bpf_loop(N, ...), N <= 8:
   'bpf_loop(1, cb, &ctx, 0); return choice_arr[ctx.i];' in
   verifier_iterating_callbacks: "invalid access to map value".

The rules only refuse joins: no unsafe prog loads because of them. They
cost states: the first one 10 % of Cilium's insns, K flags 2^K states. Thus
most hold only while each limit is less than half used: flow_has_room().

The shape of a state is a filter in front of all that: hashes of its calls
and loops, of what it holds, of the places, objects and constant offsets of
its pointers. The load of test_cls_redirect_subprogs, 301 states at an
insn, takes three times as long without the shape.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 566 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 559 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index f17eb3467708..9eff1d60cc4e 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -148,6 +148,7 @@ enum flow_need_kind {
 	FLOW_NEED_STACK_OFF,
 	FLOW_NEED_PTR_OFF,
 	FLOW_NEED_JUMP,
+	FLOW_NEED_FLAG,
 	FLOW_NEED_VALUE_OFF,
 	FLOW_NEED_BASE,
 	FLOW_NEED_JUMP_ALU,
@@ -568,6 +569,19 @@ static u16 flow_tested_regs(struct bpf_verifier_env *env, int idx)
 	return consts & BIT(insn->dst_reg) ? BIT(insn->src_reg) : 0;
 }
 
+/* A jump that compares a register with 0 or 1 */
+static u16 flow_flag_regs(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	if (BPF_SRC(insn->code) != BPF_K || !bpf_insn_is_cond_jump(insn->code) ||
+	    BPF_OP(insn->code) == BPF_JCOND)
+		return 0;
+	if (BPF_OP(insn->code) == BPF_JSET ? !(insn->imm & 1) : (u32)insn->imm > 1)
+		return 0;
+	return BIT(insn->dst_reg);
+}
+
 /* With or without sign extension */
 static bool flow_is_copy(const struct bpf_insn *insn)
 {
@@ -953,6 +967,15 @@ static u16 flow_base_regs(struct bpf_verifier_env *env, int idx)
  * A slot that is filled through another pointer to the stack than r10 is not one of them, and
  * flow_null_differs() counts on that.
  *
+ * FLOW_NEED_FLAG: those of which a jump tells 0 from 1, see flow_join_makes_up(). As they are,
+ * extended, or masked: a bool is tested as "w1 &= 1; if w1 != 0". Not through a call.
+ * The jump ends the basic block of the insn, or a block that this block leads to. Not further:
+ * every state that is kept apart goes through all that is on the way to the jump once more.
+ * So there are two rounds. In the first one nothing comes from the blocks ahead. What it finds
+ * at the first insn of a block is what the second one takes at the end of the blocks that lead
+ * there. In both a block depends on nothing that the round itself computes for another block,
+ * so the order in which the insns are looked at doesn't matter.
+ *
  * The last three kinds keep no states apart. They are for bpf_flow_is_needed(), which asks
  * whether anything ahead looks at a number that a loop changes from iteration to iteration.
  * FLOW_NEED_VALUE_OFF: FLOW_NEED_PTR_OFF, and the offset in a map value that holds nothing but
@@ -974,10 +997,11 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 				   enum flow_need_kind kind)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *insn;
-	struct flow_need in, out, *need;
+	struct flow_need in, out, *need, *from, *ahead = NULL;
 	struct bpf_iarray *succ;
 	bool jump = kind == FLOW_NEED_JUMP || kind == FLOW_NEED_JUMP_ALU;
 	bool callx = kind == FLOW_NEED_BASE || kind == FLOW_NEED_JUMP_ALU;
+	bool flag = kind == FLOW_NEED_FLAG, second = false;
 	bool changed = true, any = false, keep, from_src, reg;
 	int i, s, idx, slot, err = 0;
 	u16 *gen, callx_regs = 0, pair = BIT(BPF_REG_0) | BIT(BPF_REG_2);
@@ -987,8 +1011,11 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 	gen = kvcalloc(env->prog->len, sizeof(u16), GFP_KERNEL_ACCOUNT);
 	/* the callers need what the subprog returns: r0, and r2 of a pair */
 	ret = kvcalloc(env->subprog_cnt, sizeof(u8), GFP_KERNEL_ACCOUNT);
+	if (flag)
+		ahead = kvcalloc(env->prog->len, sizeof(*need), GFP_KERNEL_ACCOUNT);
 	*pneed = need;
-	if (!need || !gen || !ret) {
+	if (!need || !gen || !ret || (flag && !ahead)) {
+		kvfree(ahead);
 		kvfree(gen);
 		kvfree(ret);
 		return -ENOMEM;
@@ -996,6 +1023,8 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 	for (i = 0; i < env->prog->len; i++) {
 		if (jump)
 			gen[i] = flow_tested_regs(env, i);
+		else if (flag)
+			gen[i] = flow_flag_regs(env, i);
 		else if (kind == FLOW_NEED_STACK_OFF)
 			gen[i] = flow_stack_off_regs(env, i);
 		else if (kind == FLOW_NEED_PTR_OFF || kind == FLOW_NEED_VALUE_OFF)
@@ -1024,6 +1053,7 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 		}
 		any = true;
 	}
+again:
 	while (any && changed) {
 		changed = false;
 		if (signal_pending(current)) {
@@ -1041,9 +1071,10 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 			succ = bpf_insn_successors(env, idx);
 			out.regs = 0;
 			out.slots = 0;
+			from = flag && env->insn_aux_data[idx].bb_end ? ahead : need;
 			for (s = 0; s < succ->cnt; s++) {
-				out.regs |= need[succ->items[s]].regs;
-				out.slots |= need[succ->items[s]].slots;
+				out.regs |= from[succ->items[s]].regs;
+				out.slots |= from[succ->items[s]].slots;
 			}
 			in = out;
 			if (class == BPF_JMP && BPF_OP(insn->code) == BPF_CALL) {
@@ -1051,7 +1082,7 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 				if (bpf_is_callx(insn))
 					in.regs |= callx_regs & GENMASK(BPF_REG_5, BPF_REG_1);
 				s = idx + insn->imm + 1;
-				if (bpf_pseudo_call(insn) &&
+				if (bpf_pseudo_call(insn) && !flag &&
 				    !bpf_subprog_is_global(env, bpf_find_subprog(env, s))) {
 					if (kind != FLOW_NEED_PTR_OFF)
 						in.regs |= need[s].regs &
@@ -1090,10 +1121,12 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 				/* the result is known when what it is made of is */
 				keep = op != BPF_MOV;
 				from_src = reg;
-				if (jump)
+				if (jump || flag)
 					from_src = flow_is_copy(insn);
-				if (kind == FLOW_NEED_JUMP)
+				if (kind == FLOW_NEED_JUMP || flag)
 					keep = flow_is_shift(insn) && !reg;
+				if (flag && op == BPF_AND && !reg)
+					keep = insn->imm & 1;
 				if (kind == FLOW_NEED_BASE) {
 					keep = !reg && (op == BPF_ADD || op == BPF_SUB);
 					from_src = reg && op == BPF_MOV;
@@ -1110,12 +1143,18 @@ static int flow_compute_need_const(struct bpf_verifier_env *env, struct flow_nee
 			}
 		}
 	}
+	if (flag && !err && !second) {
+		memcpy(ahead, need, env->prog->len * sizeof(*need));
+		second = changed = true;
+		goto again;
+	}
 	/*
 	 * An offset that is an argument: not through the call, see above, and not where the calls
 	 * meet. A function would be looked at once for each offset that it's called with.
 	 */
 	for (s = 0; kind == FLOW_NEED_PTR_OFF && s < env->subprog_cnt; s++)
 		need[env->subprog_info[s].start].regs = 0;
+	kvfree(ahead);
 	kvfree(gen);
 	kvfree(ret);
 	if (!any) {
@@ -1642,3 +1681,516 @@ static bool flow_has_earlier_trips(const struct bpf_verifier_state *s)
 	}
 	return false;
 }
+
+/* @flag: 0 and 1 */
+static bool flow_two_consts(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb,
+			    bool flag)
+{
+	return ra->type == SCALAR_VALUE && rb->type == SCALAR_VALUE &&
+	       tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off) &&
+	       ra->var_off.value != rb->var_off.value &&
+	       (!flag || (ra->var_off.value | rb->var_off.value) == 1);
+}
+
+/* Constants that have to stay constants, see flow_compute_need_const() */
+static bool flow_needed_consts_differ(const struct bpf_flow *flow, enum flow_need_kind kind,
+				      const struct bpf_verifier_state *a,
+				      const struct bpf_verifier_state *b)
+{
+	const struct flow_need *needs = flow->need[kind], *need;
+	const struct bpf_stack_state *sa, *sb;
+	const struct bpf_func_state *fa, *fb;
+	bool flag = kind == FLOW_NEED_FLAG;
+	u32 fr, i, nr;
+
+	if (!needs || a->curframe != b->curframe)
+		return false;
+	for (fr = 0; fr <= a->curframe; fr++) {
+		/* the callers need what they need when the call returns */
+		need = &needs[fr == a->curframe ? a->insn_idx : a->frame[fr + 1]->callsite + 1];
+		fa = a->frame[fr];
+		fb = b->frame[fr];
+		for (i = BPF_REG_0; need->regs && i < BPF_REG_FP; i++)
+			if ((need->regs & BIT(i)) &&
+			    flow_two_consts(&fa->regs[i], &fb->regs[i], flag))
+				return true;
+		nr = min(bpf_stack_nr_slots(fa), bpf_stack_nr_slots(fb));
+		for (i = 0; i < nr && i < 64 && need->slots >> i; i++) {
+			sa = bpf_stack_slot(fa, i);
+			sb = bpf_stack_slot(fb, i);
+			if ((need->slots & BIT_ULL(i)) &&
+			    bpf_is_spilled_scalar_reg(sa) && bpf_is_spilled_scalar_reg(sb) &&
+			    flow_two_consts(&sa->spilled_ptr, &sb->spilled_ptr, flag))
+				return true;
+		}
+	}
+	return false;
+}
+
+/* regsafe() and join_reg() say what each type needs */
+static void flow_shape_ptr(struct flow_shape *sh, u32 place, const struct bpf_reg_state *reg)
+{
+	u32 ids = (reg->id != 0) | (reg->parent_id != 0) << 1 | (reg->map_uid != 0) << 2;
+	u32 len = offsetof(struct bpf_reg_state, var_off);
+	bool has_off = false, var_off = false;
+	u64 off = reg->var_off.value;
+
+	switch (base_type(reg->type)) {
+	case NOT_INIT:
+	case SCALAR_VALUE:
+		return;
+	case PTR_TO_ARENA:
+		/* the offset is not tracked */
+		len = sizeof(reg->type);
+		ids = 0;
+		break;
+	case PTR_TO_PACKET_META:
+	case PTR_TO_PACKET:
+		len = sizeof(reg->type);
+		ids &= 1;
+		/* behind the end of the packet, or at the end: the same in both states */
+		if (reg->range < 0)
+			ids |= -reg->range << 1;
+		else
+			sh->pkt_range += reg->range;
+		if (reg->id) {
+			/* displacements between pointers that share an id are kept */
+			has_off = true;
+			off = reg->r64.base;
+		} else if (reg->range >= 0) {
+			/* join_reg() takes two such constants for two places in the packet */
+			has_off = true;
+			var_off = !tnum_is_const(reg->var_off) || off > MAX_PACKET_OFF;
+		}
+		break;
+	case PTR_TO_INSN:
+		/* a range of offsets is a set of targets */
+		ids = 0;
+		break;
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_TP_BUFFER:
+	case PTR_TO_STACK:
+	case PTR_TO_BTF_ID:
+		has_off = true;
+		var_off = !tnum_is_const(reg->var_off);
+		break;
+	default:
+		len = offsetof(struct bpf_reg_state, id);
+	}
+	sh->word[FLOW_LAYOUT] = jhash_1word(place << 1 | var_off, sh->word[FLOW_LAYOUT]);
+	sh->word[FLOW_PTRS] = jhash2((const u32 *)reg, len / sizeof(u32),
+				     sh->word[FLOW_PTRS] + ids);
+	if (has_off && !var_off)
+		sh->word[FLOW_OFFS] = jhash_2words(lower_32_bits(off), upper_32_bits(off),
+						   sh->word[FLOW_OFFS]);
+}
+
+/* stacksafe() and join_special_slot() say what each kind needs */
+static void flow_shape_special(struct flow_shape *sh, u32 place, const struct bpf_stack_state *slot)
+{
+	const struct bpf_reg_state *reg = &slot->spilled_ptr;
+	u32 kind = slot->slot_type[BPF_REG_SIZE - 1] << 2 | (reg->id != 0);
+	u32 *ptrs = &sh->word[FLOW_PTRS];
+
+	switch (slot->slot_type[BPF_REG_SIZE - 1]) {
+	case STACK_DYNPTR:
+		kind |= (reg->parent_id != 0) << 1;
+		*ptrs = jhash_3words(kind, reg->dynptr.type, reg->dynptr.first_slot, *ptrs);
+		break;
+	case STACK_ITER:
+		*ptrs = jhash_3words(lower_32_bits((unsigned long)reg->iter.btf),
+				     upper_32_bits((unsigned long)reg->iter.btf),
+				     reg->iter.btf_id, *ptrs + kind);
+		*ptrs = jhash_3words(reg->type, reg->iter.state, reg->iter.loops, *ptrs);
+		break;
+	case STACK_IRQ_FLAG:
+		*ptrs = jhash_2words(kind, reg->irq.kfunc_class, *ptrs);
+		break;
+	}
+	sh->word[FLOW_LAYOUT] = jhash_1word(place << 1, sh->word[FLOW_LAYOUT]);
+}
+
+/* The part of the shape that is made of the registers and the stack, when it is asked for */
+static void flow_shape_places(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	struct bpf_verifier_state *st = &s->st;
+	const struct bpf_stack_state *slot;
+	const struct bpf_func_state *frame;
+	struct flow_shape *sh = &s->shape;
+	u32 fr, i, args;
+	u16 live;
+
+	sh->places = true;
+	for (fr = 0; fr <= st->curframe; fr++) {
+		frame = st->frame[fr];
+		/* a state that does a call again is not cleaned, dead registers are not compared */
+		live = env->insn_aux_data[bpf_frame_insn_idx(st, fr)].live_regs_before;
+		for (i = BPF_REG_0; i < BPF_REG_FP; i++)
+			if (live & BIT(i))
+				flow_shape_ptr(sh, fr << 10 | i, &frame->regs[i]);
+		for (i = 0; i < bpf_stack_nr_slots(frame); i++) {
+			slot = bpf_stack_slot(frame, i);
+			switch (slot->slot_type[BPF_REG_SIZE - 1]) {
+			case STACK_SPILL:
+				flow_shape_ptr(sh, fr << 10 | (i + 16), &slot->spilled_ptr);
+				break;
+			case STACK_DYNPTR:
+			case STACK_ITER:
+			case STACK_IRQ_FLAG:
+				flow_shape_special(sh, fr << 10 | (i + 16), slot);
+				break;
+			}
+		}
+		/* incoming arguments are not compared with outgoing ones: other places */
+		args = 16 + MAX_BPF_STACK_SLOTS;
+		if (bpf_stack_args_are_incoming(frame))
+			args += MAX_STACK_ARG_SLOTS;
+		for (i = 0; i < frame->out_stack_arg_cnt; i++)
+			flow_shape_ptr(sh, fr << 10 | (i + args), &frame->stack_arg_regs[i]);
+	}
+}
+
+/* The part of the shape that is not */
+static void flow_shape_ctx(const struct bpf_verifier_state *st, struct flow_shape *sh)
+{
+	const struct bpf_reference_state *ref;
+	const struct loop_stack_entry *entry;
+	const struct bpf_func_state *frame;
+	u32 chain = st->curframe, ctx, fr, i;
+
+	ctx = jhash_3words(st->in_sleepable | st->callers_unknown << 1 |
+			   st->unwound << 2 | st->changed_pkt_data << 3 |
+			   (st->active_irq_id != 0) << 4 | (st->active_lock_id != 0) << 5,
+			   st->acquired_refs, st->active_locks, 0);
+	ctx = jhash_2words(st->active_preempt_locks, st->active_rcu_locks, ctx);
+	ctx = jhash_2words(lower_32_bits((unsigned long)st->active_lock_ptr),
+			   upper_32_bits((unsigned long)st->active_lock_ptr), ctx);
+	for (i = 0; i < st->acquired_refs; i++) {
+		ref = &st->refs[i];
+		ctx = jhash_1word(ref->type, ctx);
+		if (ref->type != REF_TYPE_PTR && ref->type != REF_TYPE_IRQ)
+			ctx = jhash_2words(lower_32_bits((unsigned long)ref->ptr),
+					   upper_32_bits((unsigned long)ref->ptr), ctx);
+	}
+	for (fr = 0; fr <= st->curframe; fr++) {
+		frame = st->frame[fr];
+		chain = jhash_3words(frame->subprogno, frame->callsite, frame->loop_stack_cnt,
+				     chain);
+		ctx = jhash_2words(frame->entry_refs, frame->in_rcu_callback_fn, ctx);
+		ctx = jhash_2words(frame->entry_rcu_locks, frame->entry_preempt_locks, ctx);
+		for (i = 0; i < frame->loop_stack_cnt; i++) {
+			entry = &frame->loop_stack[i];
+			chain = jhash_1word(entry->loop_id << 1 | entry->apart, chain);
+			ctx = jhash_3words(entry->counted << 2 | entry->guarded << 1 |
+					   entry->terminates,
+					   entry->max_header_count,
+					   entry->counted ? entry->trip : 0, ctx);
+		}
+	}
+	memset(sh, 0, sizeof(*sh));
+	sh->word[FLOW_CHAIN] = chain;
+	sh->word[FLOW_CTX] = ctx;
+}
+
+/* Are the words up to @last the same? */
+static __always_inline bool flow_same_shape(const struct flow_state *a, const struct flow_state *b,
+					    enum flow_word last)
+{
+	u32 i;
+
+	for (i = 0; i <= last; i++)
+		if (a->shape.word[i] != b->shape.word[i])
+			return false;
+	return true;
+}
+
+/*
+ * A state that arrives is compared with the states at the insn: is it within one of them, see
+ * bpf_state_subsumes(), does it have a join with one of them, see bpf_states_join()? Most of
+ * them have nothing to do with it. The shape of a state tells that before the registers are
+ * compared or, for a join, copied. It has what must be the same in two states that are related:
+ *
+ * FLOW_CHAIN	the chain of calls and the loops that every frame is in
+ * FLOW_CTX	what is known about every loop, the iteration of a counted one,
+ *		the flags of the state and of its frames, locks and references
+ * FLOW_LAYOUT	which registers, stack slots and stack arguments hold a pointer, a dynptr,
+ *		an iterator or an irq flag, which of the pointers are at a constant offset
+ * FLOW_PTRS	what the pointers point to and which of their ids are set, the kind of the others
+ * FLOW_OFFS	the constant offsets
+ *
+ * Nothing about numbers is in it.
+ *
+ * States that differ in one of the first two words are not related. Neither are states of
+ * the same layout that differ in one of the last two: a pointer is related to a pointer to the same
+ * thing only, and two constant offsets are two places in it.
+ * States of different layout may be related, whatever the last two words are: nothing in
+ * a register or in a slot stands for a pointer there, and a range of offsets stands for a constant,
+ * or is joined with it.
+ *
+ * A word is a hash. It is a filter and proves nothing: the states that get through it go
+ * through all the comparisons. So it's fine to look at the first two words only: @places.
+ */
+static bool flow_may_relate(struct bpf_verifier_env *env, struct flow_state *t,
+			    struct flow_state *s, bool places)
+{
+	if (!flow_same_shape(t, s, FLOW_CTX))
+		return false;
+	if (!places)
+		return true;
+	if (!t->shape.places)
+		flow_shape_places(env, t);
+	if (!s->shape.places)
+		flow_shape_places(env, s);
+	return !flow_same_shape(t, s, FLOW_LAYOUT) || flow_same_shape(t, s, FLOW_OFFS);
+}
+
+/*
+ * A pointer to the packet stands for one with at least as many checked bytes, and without
+ * widening it's joined with one that has as many. In states of the same layout that holds for
+ * the sums too. Returns 0 if the sums are the same, or say nothing.
+ */
+static int flow_cmp_pkt_range(const struct flow_state *t, const struct flow_state *s)
+{
+	if (!t->shape.places || !s->shape.places || !flow_same_shape(t, s, FLOW_LAYOUT) ||
+	    t->shape.pkt_range == s->shape.pkt_range)
+		return 0;
+	return t->shape.pkt_range < s->shape.pkt_range ? -1 : 1;
+}
+
+/*
+ * bpf_loop(N, ...) with a small N: the calls of the callback are looked at one by one, like
+ * the iterations of a loop that is walked. The call stops to enter the callback when
+ * callback_depth gets to N.
+ */
+static bool flow_callback_depth_differs(struct bpf_verifier_env *env,
+					const struct bpf_verifier_state *a,
+					const struct bpf_verifier_state *b)
+{
+	u32 max = BPF_FLOW_MAX_CALLBACKS, fr;
+	const struct bpf_func_state *fa, *fb;
+	struct bpf_insn *insn;
+
+	if (a->curframe != b->curframe)
+		return false;
+	/* at the call, and in the callback and what it calls */
+	for (fr = 0; fr <= a->curframe; fr++) {
+		insn = &env->prog->insnsi[fr == a->curframe ? a->insn_idx :
+					  a->frame[fr + 1]->callsite];
+		if (!bpf_helper_call(insn) || insn->imm != BPF_FUNC_loop)
+			continue;
+		fa = a->frame[fr];
+		fb = b->frame[fr];
+		if (fa->callback_depth != fb->callback_depth &&
+		    fa->regs[BPF_REG_1].type == SCALAR_VALUE &&
+		    reg_umax(&fa->regs[BPF_REG_1]) <= max &&
+		    fb->regs[BPF_REG_1].type == SCALAR_VALUE &&
+		    reg_umax(&fb->regs[BPF_REG_1]) <= max)
+			return true;
+	}
+	return false;
+}
+
+static const struct bpf_reg_state *flow_slot_number(const struct bpf_func_state *frame, u32 i)
+{
+	const struct bpf_stack_state *slot = bpf_stack_slot(frame, i);
+
+	if (slot->slot_type[0] != STACK_SPILL || slot->slot_type[BPF_REG_SIZE - 1] != STACK_SPILL ||
+	    slot->spilled_ptr.type != SCALAR_VALUE)
+		return NULL;
+	return &slot->spilled_ptr;
+}
+
+/* Returns true when the answer is known */
+static bool flow_null_pair(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb,
+			   bool *a_null, bool *b_null)
+{
+	if (tnum_equals_const(ra->var_off, 0) && !tnum_is_const(rb->var_off)) {
+		*a_null = true;
+		if (reg_umin(rb) == 1 && reg_umax(rb) == U64_MAX)
+			return true;
+	}
+	if (tnum_equals_const(rb->var_off, 0) && !tnum_is_const(ra->var_off)) {
+		*b_null = true;
+		if (reg_umin(ra) == 1 && reg_umax(ra) == U64_MAX)
+			return true;
+	}
+	return *a_null && *b_null;
+}
+
+/*
+ * Two things of which one is there: "if (hdr->ipv4) ... else if (hdr->ipv6)". The one that
+ * is not there is 0. What the other one is may be unknown, e.g. a pointer to the packet
+ * after the packet was changed. (0, x) is not within (y, 0) and the join (?, ?) forgets that
+ * it's one or the other.
+ * The same for a number that was compared with 0: 0 on one path, not 0 on the other.
+ *
+ * Only where a jump ahead can see it: FLOW_NEED_JUMP, see flow_join_makes_up(). What no jump
+ * looks at again sends no state another way, and every such number doubles the states.
+ *
+ *	for (i = 0; i < n; i++) { p = a[i]; if (!p) continue; put(p); }
+ * a[] is on the stack. The jump finds out about the slot that p was filled from too. Nothing
+ * looks at a[i] again, but the loop reads through a pointer that moves, so all of a[] is live
+ * until the loop is done: 2^n states if they stay apart.
+ * They don't, because FLOW_NEED_JUMP has only what is filled through r10, see flow_fp_slot().
+ * It cannot tell a[i] from a[i + 1]. With what is filled through other pointers to the stack in
+ * it, all of a[] is tested in all of the loop.
+ */
+static bool flow_null_differs(const struct bpf_flow *flow, const struct bpf_verifier_state *a,
+			      const struct bpf_verifier_state *b)
+{
+	const struct bpf_func_state *fa, *fb;
+	const struct bpf_reg_state *ra, *rb;
+	const struct flow_need *need = flow->need[FLOW_NEED_JUMP];
+	bool a_null = false, b_null = false;
+	u32 i;
+
+	if (!need || a->curframe != b->curframe)
+		return false;
+	need += a->insn_idx;
+	fa = a->frame[a->curframe];
+	fb = b->frame[b->curframe];
+	for (i = BPF_REG_0; i < BPF_REG_FP; i++) {
+		ra = &fa->regs[i];
+		rb = &fb->regs[i];
+		if ((need->regs & BIT(i)) &&
+		    ra->type == SCALAR_VALUE && rb->type == SCALAR_VALUE &&
+		    flow_null_pair(ra, rb, &a_null, &b_null))
+			return true;
+	}
+	for (i = 0; i < 64 && i < bpf_stack_nr_slots(fa) && i < bpf_stack_nr_slots(fb); i++) {
+		if (!(need->slots & BIT_ULL(i)))
+			continue;
+		ra = flow_slot_number(fa, i);
+		rb = flow_slot_number(fb, i);
+		if (ra && rb && flow_null_pair(ra, rb, &a_null, &b_null))
+			return true;
+	}
+	return false;
+}
+
+static const struct bpf_reg_state *flow_number_at(const struct bpf_func_state *frame, u8 loc)
+{
+	const struct bpf_reg_state *reg;
+
+	if (loc <= BPF_REG_FP)
+		reg = &frame->regs[loc];
+	else if (loc - BPF_REG_FP - 1 < bpf_stack_nr_slots(frame) &&
+		 bpf_is_spilled_scalar_reg(bpf_stack_slot(frame, loc - BPF_REG_FP - 1)))
+		reg = &bpf_stack_slot(frame, loc - BPF_REG_FP - 1)->spilled_ptr;
+	else
+		return NULL;
+	return reg->type == SCALAR_VALUE ? reg : NULL;
+}
+
+/*
+ * A register is set in one of the states and not in the other. Only live registers are in
+ * a state, so something ahead may read it. The state in which it's not set doesn't get there:
+ * a jump sends it another way. The join would not know which way to go, and would get
+ * there without the register. There is nothing to gain from such a join but a state less.
+ */
+static bool flow_unset_differs(const struct bpf_verifier_state *a,
+			       const struct bpf_verifier_state *b)
+{
+	u32 fr, i;
+
+	for (fr = 0; fr <= a->curframe; fr++)
+		for (i = BPF_REG_0; i < BPF_REG_FP; i++)
+			if ((a->frame[fr]->regs[i].type == NOT_INIT) !=
+			    (b->frame[fr]->regs[i].type == NOT_INIT))
+				return true;
+	return false;
+}
+
+static bool flow_disjoint(const struct bpf_reg_state *a, const struct bpf_reg_state *b)
+{
+	return cnum64_is_empty(cnum64_intersect(a->r64, b->r64)) ||
+	       cnum32_is_empty(cnum32_intersect(a->r32, b->r32)) ||
+	       ((a->var_off.value ^ b->var_off.value) & ~(a->var_off.mask | b->var_off.mask));
+}
+
+/* The smallest range that has both has numbers that are in neither */
+static bool flow_gap(const struct bpf_reg_state *a, const struct bpf_reg_state *b)
+{
+	if (cnum64_is_empty(cnum64_intersect(a->r64, b->r64)) &&
+	    a->r64.size + b->r64.size + 1 > a->r64.size &&
+	    cnum64_union(a->r64, b->r64).size > a->r64.size + b->r64.size + 1)
+		return true;
+	return cnum32_is_empty(cnum32_intersect(a->r32, b->r32)) &&
+	       cnum32_union(a->r32, b->r32).size > (u64)a->r32.size + b->r32.size + 1;
+}
+
+/*
+ * Numbers always have a join. It must not make up what neither state has where a jump ahead
+ * can see it. FLOW_NEED_JUMP has the registers and the stack slots that a jump ahead compares
+ * with a constant, or the verifier does at a call or at the exit.
+ *
+ *	if (ret < 0) goto err; if (ret > 0) goto skip; use(p);
+ * ret = [-2, -1] and ret = [1, 2], both without p, meet in front of that. [-2, 2] has 0, gets
+ * through both jumps, and there is no p. So two ranges that leave a gap are not joined. Ranges
+ * that touch, 0 and 1, -1 and 0, or have something in common make up no number.
+ *
+ *	err = update(); ret = err < 0 ? DROP : 0; ... if (err < 0) goto out; ... if (ret < 0) ...
+ * (err >= 0, ret = 0) and (err < 0, ret = DROP) meet. The join has err < 0 with ret = 0. So
+ * two numbers, each with nothing in common between the states, are not joined either.
+ *
+ *	fatal = err == -ENOMEM; ... if (fatal) bpf_set_retval(err);
+ * (fatal = 0, err = 1) and (fatal = 1, err = -ENOMEM) meet. The same: the join has
+ * fatal = 1 with err = 1, which bpf_set_retval() doesn't take.
+ *
+ *	ok = i < 64 && in[i]; if (x) n++; if (ok) a[i] = 1;
+ * (ok = 0, i >= 64), (ok = 0, i < 64) and (ok = 1, i < 64) meet. 0 and 1 touch, and i < 64 comes
+ * with either, so none of the above keeps them apart. The join has ok = 1 with i >= 64. A flag is
+ * made to send states different ways. So 0 and 1 are not joined where a jump that is not far
+ * tells one from the other: FLOW_NEED_FLAG.
+ *
+ * The states go on to the jumps on their own. Behind the last one the numbers are dead, and what
+ * is left is joined.
+ */
+static bool flow_join_makes_up(const struct bpf_flow *flow, const struct bpf_verifier_state *a,
+			       const struct bpf_verifier_state *b)
+{
+	const struct bpf_reg_state *ra, *rb;
+	const struct flow_need *tested = flow->need[FLOW_NEED_JUMP], *need;
+	u32 fr, i, id = 0;
+	bool one = false;
+
+	if (!tested)
+		return false;
+	for (fr = 0; fr <= a->curframe; fr++) {
+		/* the callers go on when the call returns */
+		need = &tested[fr == a->curframe ? a->insn_idx : a->frame[fr + 1]->callsite + 1];
+		for (i = BPF_REG_0; i < BPF_REG_FP + 1 + 64; i++) {
+			if (i <= BPF_REG_FP ? !(need->regs & BIT(i)) :
+					      !(need->slots & BIT_ULL(i - BPF_REG_FP - 1)))
+				continue;
+			ra = flow_number_at(a->frame[fr], i);
+			rb = flow_number_at(b->frame[fr], i);
+			if (!ra || !rb || !flow_disjoint(ra, rb))
+				continue;
+			if (flow_gap(ra, rb))
+				return true;
+			/* copies of a number are one number */
+			if (one && (!id || id != (ra->id & ~BPF_ADD_CONST)))
+				return true;
+			one = true;
+			id = ra->id & ~BPF_ADD_CONST;
+		}
+	}
+	return flow_needed_consts_differ(flow, FLOW_NEED_FLAG, a, b);
+}
+
+/*
+ * States that have a join are kept apart while there is room: half of every limit.
+ * After that they are joined, which may lose what the prog needs, and does not run into the limit.
+ */
+static bool flow_has_room(const struct bpf_verifier_env *env, u32 nr_states)
+{
+	u64 len = env->prog->len;
+
+	return nr_states < BPF_FLOW_MAX_STATES / 2 &&
+	       env->flow->live_states < (BPF_FLOW_LIVE_PER_INSN * len + BPF_FLOW_LIVE_BASE) / 2 &&
+	       env->total_states < (BPF_FLOW_TOTAL_PER_INSN * len + BPF_FLOW_TOTAL_BASE) / 2;
+}
-- 
2.55.0

