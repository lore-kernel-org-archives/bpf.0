Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911593;
	b=kBtD/aLmg7S7yFm5rRwEafvTSnBn2WtECpCTlfY8/OPxKyHKVRwa0V4PflaSKnGDTno2
	 66bDs/IIomkjgoKV5cqist32En9kcLOm3UA7iDt6RYo1WeQD8/xEm5AWIn1ILmiYvaC+P
	 oh4/Uk4aOACZ0CO+/PyrcuY9cJ3r2xXoSSk3JYspgKjvxGPloPuxYzDzN8jRMWEwp8ubb
	 4RHyDBZ4yX81fFwb+18U4U+QlJA0ojmoYuwWAoPkl/kkBQu0ydDIgHVCYXVc3YuaQuJdw
	 4pa54o6a6PKDkhHy7ZsHsBd8+dbxnC9Tbm9KlUCUALdGGbiJJ0Opt0aQQA4hkABIOsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bpvuv9X8GazXEETptONwhClCIYZzQ7yYv+B+opmzpc0=;
	b=h3nTed2DAh9WU8pe0xz1eFN5mF0Urmrmteqw8/DPm4HwGHH99eb86FKooRxQG3vNJ6TA
	 9IPqMlwkZCIml+58hR936x7Ut2Qoqh/fKMUeiaq7CiK7Su1eKBTMSzE76Z2j/D7LW1u0j
	 OGn7lu5Wf9IDPdFkkvYzPyEjY4O540cd+rRmktN3NiFiNR0Eh+mgN12J4v+WyYAMKrAmn
	 sCn052j1NuVktKXa09enJAI38OjjznN4c8ZIfWevpRWfv1rc+GVTkxnHTgL5jZH+lWcFX
	 z5B8EIQJmZiXtcmTAXHQURssQmHzyuB7nHlNrJaDR4Z68Gh/ck/s9KQ8mSoa/lUCrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmraHZRY;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43990606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43990606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmraHZRY
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1560244a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911593; x=1794516393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bpvuv9X8GazXEETptONwhClCIYZzQ7yYv+B+opmzpc0=;
        b=gmraHZRYBhTF4gb86Ocq1mOUONncboV7/mdx1Ao1t6F1lLaW9mZG2XUwCfalAdB73S
         IozOuPQOcnUtw2dQbYmSeh5PJECGpDGU/46VS73B28p1hEBaA+iVPcu82F+V+3jnwxR2
         h5Tysaa3w6SAmVNUwjfcJaPp6f8kOCvOOErCJspGXCLRvaJMAkBiFHcPy8wHotuRFepe
         +0/ttKpz04d2BtULjaNEyur6iqtNn8hT5X283rByqojf67pHPt/v56BwLGulPGPXvhpe
         u0lO5QPNoC2VzZ1STpjg4LZmNwYEWOurO085BEQEVaYtNWrv6OLd2jeoEoY9EsvXmgye
         b6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911593; x=1794516393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bpvuv9X8GazXEETptONwhClCIYZzQ7yYv+B+opmzpc0=;
        b=VSWg1VS8gA0AxRgTORV1RsVSPnX1PgifviFNETlpG764wBczF0iVortWk7EKdRpV1Y
         qVhWjYPBx+ZQryXxSr0MsXZhY6jeVoJppDcSLBsOOSa30nGM3w5DwXNjxm3pftiYL+T5
         ol571EJugIZE77vgS6S9le2pLaksFNTEdZ8df+awkcWXidR7mnJmdK9tMUjIyuxshpgF
         UETqBwZAwiJ4EWIruaphM+9Lr5X0Ld3q1t6IR7hYeEZ/rZnnEJ4I1v5Gasu47Gs+Ma5R
         PIY65LxfmiM+LjLIwAwJNiOpXxiHntk4zhesC3d1ofxXl4A+j6Wo4oOr81kxYpFc/GKM
         qTFA==
X-Gm-Message-State: APuU4Z9bXoy5q4EQULd1lysNAd9lRXhvUDmjTnlfQvR+eUeuGWb6NwdN
	FeL8ushQk/fite1UONq6O61h+NZZlMUSEyfoLbqqqd0opr8LuPnQspHsCgOaqw==
X-Gm-Gg: AYBFou1VJ/VB+UmF8nuL81WMtJFCpTRwha8b3kXAcadfpAJYKcv6x5XCbgkmYMb7OUE
	EnLnXhAF4z5WeVtKOd/51yOckbjM5iBXg+9LIMDMURTKmXstoLo3KlspVH5mTH8FgQ9vZSLm5i0
	ZebOBKW/zSJ0EtO5dRM6ddDDM1b4zaVgb/9NIuBSRQUsN9nHjBax7VYUvH631Wy+D+bVyyKgyP/
	OCiVf5vRVvev9Qfvqt7ViIkNnKGf/8H7RsgXT2Ap0kj2VWtFBTSX5pHHl8go+aGjG1WOZiyC6/t
	GBbEHV7H4rrFAWYcifeMsAS+UgYWiqr6RuBgz2DMxli5lWDkvQxVKa55N/PnvI0EJI8E1B3RV5E
	2XvOUIfq30rwFh41YIsWDssgmQEirMxLNV0GvtIw6/Fl2fOgLQPzL325Y0Ki0tQT4VbmFPJL1Dz
	Ba0cdI/mq/igcijQQK/mTYK3mwXRVyn62UlaYtmNLEdRi2lCQCz4vugF7ULLmhopzOOad0HwvL+
	azpH2F17jMU2XO7GX2wC77XZe54UvgNwKMWsKVW8RZqgqDz9oP7SnLRVW1oqiYZlfqKbrN4ZogB
	kcJPfGKXpqE2g92QRkmxuVmjkcy0Anv5vXIHv799pz4xXufX76F31p4pLpQBV0RE5Q0u/Cx5vqO
	wxba0s/hGTgjtqW7N2BJ/bhZ7k1shwTHwt7xrdoMYHyWnhKXlKSu9WBSvPcz629ssKrYdaDd6C8
	cAe6pUjOqaxgkot3W0iPA=
X-Received: by 2002:a17:90b:568e:b0:3ad:aa1a:312e with SMTP id 98e67ed59e1d1-3b0db608f5fmr203811a91.3.1793911592295;
        Thu, 05 Nov 2026 12:46:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm5497302a91.0.2026.11.05.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/35] bpf: Decide which states are not joined
Date: Thu,  5 Nov 2026 20:44:50 +0000
Message-ID: <20261105204513.2230344-14-alexei.starovoitov@gmail.com>
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
 kernel/bpf/flow.c | 502 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 502 insertions(+)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index f17eb3467708..8b294a8748bb 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1642,3 +1642,505 @@ static bool flow_has_earlier_trips(const struct bpf_verifier_state *s)
 	}
 	return false;
 }
+
+static bool flow_two_consts(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return ra->type == SCALAR_VALUE && rb->type == SCALAR_VALUE &&
+	       tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off) &&
+	       ra->var_off.value != rb->var_off.value;
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
+			if ((need->regs & BIT(i)) && flow_two_consts(&fa->regs[i], &fb->regs[i]))
+				return true;
+		nr = min(bpf_stack_nr_slots(fa), bpf_stack_nr_slots(fb));
+		for (i = 0; i < nr && i < 64 && need->slots >> i; i++) {
+			sa = bpf_stack_slot(fa, i);
+			sb = bpf_stack_slot(fb, i);
+			if ((need->slots & BIT_ULL(i)) &&
+			    bpf_is_spilled_scalar_reg(sa) && bpf_is_spilled_scalar_reg(sb) &&
+			    flow_two_consts(&sa->spilled_ptr, &sb->spilled_ptr))
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
+	return false;
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

