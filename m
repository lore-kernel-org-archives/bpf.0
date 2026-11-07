Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022811;
	b=l6h/T/5oUFs0OoJOWQFSu/uhHIHTLQE1DDMdZt8YuyyaDZC5+faXrNhHJQbvxaDpUrVD
	 j52eiPXoHqnJRRaipyQrwnYK7ftEsNRvZeGWCfHEg8CHP6fJ1PhpCwPvePn29VAjS1Og7
	 g4rVsVzV4Y1o6EXNFag8Bk8A7BabGD+Ri+5pgw2lzUNomuDMDMDJFdTz0mNYP6oMjUdCl
	 KQq2XgcGJcF7gLqAzEbdSNr/xyDOYweja5OqT5SzXH0WKq0GlaiUxxFIxUD6YA8fqxcAo
	 OptZZFi/kKhSebz7t5tETwHGPTrSJuMrZhcov8sJucgSuhL/whkIkGywV57r4csw+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D3eBtQ9J2NltkAdx0n7WwQujmnctlZYa49/htv1Baq4=;
	b=dsc4oaZaERuyILSZiJMT3PZhS53js1wTDhUxm4ssXhQojTe0Edsdku1Hpjm4uKZjhWxO
	 vFEupKxOw94O55/OjotO1LocadEVhFkpm5Ll9SV9cjWvtXsO2GLVla9iJeP3PjyqHbanZ
	 b0TAHPJ/1v0jXkQg60IDzq3Oa6+rnTf2+s1r1+iGzsUSHg8uMGnv84BqA8afDGoyh8mbJ
	 IVjC53HeGZ6xRsb/ozmo/OgXy6CAeDxJQAm+8FwykP0O0ieE7hxMTAa8IPtW3QPNNTn6J
	 j42Gj4LS7E+tboRutBA7WvV2jivbLESNxiIAMp8buZuvWoy32xD/nBOJ3eWEXnyU8kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGe8HCML;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06428606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06428606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGe8HCML
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e942864693so7334745ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022810; x=1794627610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3eBtQ9J2NltkAdx0n7WwQujmnctlZYa49/htv1Baq4=;
        b=cGe8HCMLui1/m8uhRks9bLWnIKjzriIngVkqUMjDCQQygr6dycMC7raBGByXxJRE4l
         OTAs3OUCBfZn9ni5l6nWj+uDMWRl5QRncOif/vf8swfvmpBLhs/miUjDtP8GiIaXcpTw
         HFwOPSYW5qdEzJxDe8bLev/zeVi92Lk667T352tJz6eBrjgqd03eX0w6YWGodIot2D8f
         6nm8xpn5DTqsV5PwNABa9T9zYp+pZwfFd2gaHXsgMZEEsbuh5yg2dl1avi446J/XKpFG
         cM0PaAm0VvtLDdJzNHO+aMRdNYcGqFJpE6QX1RfLzkRnHqyPawV3gIEAA9sO9MGxZy+3
         ZaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022810; x=1794627610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3eBtQ9J2NltkAdx0n7WwQujmnctlZYa49/htv1Baq4=;
        b=e8JjC/eMbcgpy61u74zzfFl1DBxTys7y0T4Ga2booOAO6MGVJBpbX/ik0Zri1eWR+F
         O6/+OVH4cQuy9C90YeJIjeHRuWeLB5IoyA2sPVMRam62yxxVTQyb1OV+2nuF0iMBip0X
         MY+LkRmC71YO/sZxWpx6EoZfH3sxMYXgVLdFatMkm2IM0Z8QEciLB9R3YW8MD02HmZNo
         lQBrvpuJeAt5DhcjCUdBg4f8/0PEaq0llORJx/2Nig/Eh9q241vvH3+VWMX8OL9ygeiQ
         HcFFmwZgpq5B2m5KxHZA/gISZ2GGK87D+Q2AHufdvbgp28Gl+4ksgILBddA/5qNy/ftE
         Nckw==
X-Gm-Message-State: APuU4Z+GfjbfTyV83XCF3MeXpbB8iO8Y0edfnCojo8rOAOP61afKAbj2
	xpG/8JWGGTeucpgE18xL55FdrY8yDOCJAW21t8o4X47tULjD8c3D6ROli1Jbuw==
X-Gm-Gg: AYBFou0hlv8TPvwqJjdSFnPV49KYqAsf+hU9SZXI3CvlFnf9p5GWWyNajTVPv3hQzI1
	Ztp0cRRyX6reQy74a9jin7IKCleExYv86feKpdrtjfGMcmFD6oem0BYIn5xtqXWWk+EfpI3QQEU
	vJCLXQTKdWJ7WvxAc9uaZNyLGs2PJFX5Y5KHgWkREbjJAC5jBfxUWvyzpvVYJXDX0QgNejO62YV
	xPfNtHKHs+sqq9lQevqME+KvQxNHWMHAcwhJr7UmXHGKGmKSxz6XV5mtRVnig27g+QvKfBdecev
	bZSabQYDwDiYbijADIC1bnd6kYj+bOoHzVxO+clv0F5qAGteZJKs7ZXW1XHxLeEz5EhBzdR2Jf4
	mgJHe8n2hDnxV0/GzQTAHqph9r3tfBl+z3bAqkpT+jA1gBK7QJI6MS5L2PMjFnKo4vz9i91b3+7
	F9GWjXDl3PLBSxGaoMnvFeYe6X9AjvlHloTt4++4Ldf+BbbgZO7PfEvg5BE0iC4lj5esei8DTdK
	0IbkcGj7wDPULrKqu0jQf/I48ZTY7qWujLV/6ZZ3OZA+jdSSN81Lwq6a+qDfU90Q5IalhTsgV5F
	NozwKzYNzsENgks5UBc0NO1oUPH1QsIFSzj3bNPMTbr0294Q+1HiRttJJRCXXjPp3cbLLOquPGR
	V5s7qWRDlzmcpfEdBEt6ubuj6c9ENrxE32S2ld3eJ7AD8JBdHjqoQ0fLfbDvZjJPn3d9BcjyA0d
	y5z8OB4N4qM+7M9tGy36eo
X-Received: by 2002:a17:902:ef49:b0:2ed:3e3d:f0ea with SMTP id d9443c01a7336-2ed40aca6fdmr57869325ad.20.1794022809958;
        Fri, 06 Nov 2026 19:40:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da165dsm10351495ad.73.2026.11.06.19.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 21/46] bpf: Verify static subprogs on their own
Date: Sat,  7 Nov 2026 03:37:29 +0000
Message-ID: <20261107033758.1547725-22-alexei.starovoitov@gmail.com>
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

Selftest test_verif_scale1, 90 times in a row, jhash() is static noinline:
  ptr = data + i;
  if (ptr + nh_off > data_end)
      break;
  ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++);
The verifier verifies a static subprog in the frames of its callers. States
with different frames have no join: each insn of jhash() has a state for
each way to it: "more than 1024 states that cannot be joined at insn 903".
In Rust each function of core and alloc is a static subprog: 30 tests of
rust-bpf are rejected too.

Verify a static subprog for the states at its first insn. The entry state
has one frame, with the arguments and nothing of the callers. It arrives at
the first insn like each state at an insn: dropped, joined or added. The
call waits. Each exit state goes to all calls that wait for this entry.

  2: call f  --- { r1=scalar } --->  +---------------------+
  7: call f  --- { r1=scalar } --->  | f: verified 1 time  |
  3: ...     <-- { r0=[0,7] } -----  |                     |
  8: ...     <-- { r0=[0,7] } -----  +---------------------+

test_verif_scale1: 50765 insns, today 530362.

The entry state has what a check asks the frames of the callers for: the
references and locks that they hold, sleepable, rcu callback.
inherited_id() gives what is held a name, an id that depends only on its
position, from 2^29: calls that differ only in ids share an entry. 27 progs
of the schedulers of rust-bpf call core::fmt while they hold a reference.
All other ids stay below 2^28: "too many ids". A scalar argument loses its
id and its delta. The frames of the callers stay, func_is_on_its_own(), if
 - an argument is a pointer to the stack or a dynptr: it is their memory,
 - an argument is a pointer with the id of something that is not held: the
   id of its NULL check, or of a variable offset into the packet,
 - an argument can be NULL or is the end of the packet: the subprog does
   a check for the caller. So does a subprog that loads data_end itself:
   'bool has(ctx, p, n) { return p + n <= (void *)(long)ctx->data_end; }'.
   On its own it leaves 'if (has(ctx, p, 14)) x = p[13];' without a range,
 - it gets the context of a struct_ops prog that holds a reference: an
   argument with __ref is found by its id, not by a name. Otherwise:
   "invalid bpf_context access off=8. Reference may already be released",
 - the subprog is a callback, changes packet data, has a tail call or
   LD_ABS, or releases what the caller holds.
BPF_LOG_STATS adds its insns to each caller: verifier_subprog_insn_stats.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/verifier.c        | 229 ++++++++++++++++++++++++++++++++++-
 2 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 485c2abee665..993d8241f6f3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1213,6 +1213,9 @@ struct bpf_id_pair {
  *   check_ids() and jid_note() do not rename it. So two calls share a state at the entry, and what
  *   comes out for it, only if the same places have the same names.
  * - bpf_flow_return() puts the ids of the call that waits back. All other ids get new values.
+ * - What comes out has the ranges of all calls that share the state at the entry. So a name is good
+ *   for what holds whatever the ranges are: the same object. Other ids have no name: a number
+ *   loses its id, any other argument keeps the frames of the caller, see arg_needs_caller().
  * - env->id_gen stays below BPF_MAX_ID. So no id is a name or has a bit of BPF_ADD_CONST.
  */
 #define BPF_INHERITED_ID	0x20000000
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0a315a88e355..3c3d1c8ea452 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1822,6 +1822,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->callers_unknown = src->callers_unknown;
 	dst_state->unwound = src->unwound;
+	dst_state->changed_pkt_data = src->changed_pkt_data;
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
@@ -11301,6 +11302,8 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 			mark_reg_invalid(env, reg);
 		}
 	}));
+	if (env->cur_state->flow_entry)
+		env->cur_state->changed_pkt_data = true;
 }
 
 static bool holds_pkt_pointers(struct bpf_verifier_env *env)
@@ -11849,6 +11852,185 @@ static void account_current_path(struct bpf_verifier_env *env);
  * BPF_INHERITED_ID + the position for the function, and put back at the return.
  */
 
+/* 0 if it is not held */
+static u32 inherited_id(const struct bpf_verifier_state *state, u32 id)
+{
+	int i;
+
+	/* the first one: a lock in an object that the caller owns has the id of the reference */
+	for (i = 0; id && i < state->acquired_refs; i++)
+		if (state->refs[i].id == id)
+			return BPF_INHERITED_ID + i;
+	return 0;
+}
+
+/* What func_is_on_its_own() asks of an argument, be it in a register or on the stack */
+static bool arg_needs_caller(struct bpf_verifier_env *env, const struct bpf_verifier_state *state,
+			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
+{
+	/* the id of a __ref argument is kept in ctx_arg_info[], see __check_ctx_access() */
+	if (reg->type == PTR_TO_CTX && state->acquired_refs &&
+	    env->prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+		return true;
+	/* only the ids of what is held have names */
+	if (reg->type != SCALAR_VALUE &&
+	    ((reg->id && !inherited_id(state, reg->id)) ||
+	     (reg->parent_id && !inherited_id(state, reg->parent_id)) ||
+	     (reg->map_uid && !inherited_id(state, reg->map_uid))))
+		return true;
+	/*
+	 * Pointers to the packet that share an id have ranges of the same size, see
+	 * find_good_pkt_pointers(). What comes out of the function has the range of all calls.
+	 */
+	if (reg_is_pkt_pointer(reg) && reg->id)
+		return true;
+	/* it checks how much of the packet is there, for the caller */
+	if ((reg->type == PTR_TO_PACKET_END ||
+	     (reg->type == PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->recursive)
+		return true;
+	/* or whether there is something to point to */
+	return type_may_be_null(reg->type) && !sub->recursive;
+}
+
+static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			       int subprog)
+{
+	struct bpf_func_state *caller = state->frame[state->curframe];
+	struct bpf_subprog_info *sub = &env->subprog_info[subprog];
+	u16 live = env->insn_aux_data[sub->start].live_regs_before;
+	u32 i;
+
+	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
+	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
+		return false;
+	if (state->speculative)
+		return false;
+	if (sub->releases_inherited &&
+	    (state->acquired_refs || state->active_rcu_locks || state->active_preempt_locks))
+		return false;
+	/* what must not be done in that callback is refused by looking at the frames */
+	if (in_rbtree_lock_required_cb(env))
+		return false;
+	/* there are that many names for what is held, and bpf_flow_return() has room for them */
+	if (state->acquired_refs > BPF_ID_MAP_SIZE / 2)
+		return false;
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+		if (!(live & BIT(i)))
+			continue;
+		if (caller->regs[i].type == PTR_TO_STACK ||
+		    base_type(caller->regs[i].type) == CONST_PTR_TO_DYNPTR)
+			return false;
+		if (arg_needs_caller(env, state, sub, &caller->regs[i]))
+			return false;
+	}
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
+		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
+			return false;
+		if (arg_needs_caller(env, state, sub, &caller->stack_arg_regs[i]))
+			return false;
+	}
+	return true;
+}
+
+static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int insn_idx)
+{
+	u16 live = env->insn_aux_data[env->subprog_info[subprog].start].live_regs_before;
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller = state->frame[state->curframe], *callee;
+	struct bpf_verifier_state entry = {};
+	int i, err;
+
+	callee = kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
+	if (!callee)
+		return -ENOMEM;
+	entry.frame[0] = callee;
+	entry.in_sleepable = state->in_sleepable;
+	entry.callers_unknown = state->callers_unknown;
+	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
+	/* the frame that says so is not there when the function is verified */
+	callee->in_rcu_callback_fn = in_rcu_callback(env);
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		if (live & BIT(i))
+			callee->regs[i] = caller->regs[i];
+	err = grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->subprog_info[subprog]));
+	if (err) {
+		bpf_free_verifier_state(&entry, false);
+		return err;
+	}
+	for (i = 0; i < callee->out_stack_arg_cnt; i++)
+		callee->stack_arg_regs[i] = caller->stack_arg_regs[i];
+
+	err = copy_reference_state(&entry, state);
+	if (err) {
+		bpf_free_verifier_state(&entry, false);
+		return err;
+	}
+	for (i = 0; i < entry.acquired_refs; i++) {
+		/* the id of a lock is the id of the pointer to it, which may have none */
+		entry.refs[i].id = inherited_id(state, entry.refs[i].id);
+		if (entry.refs[i].type == REF_TYPE_PTR)
+			entry.refs[i].parent_id = inherited_id(state, entry.refs[i].parent_id);
+	}
+	entry.active_irq_id = inherited_id(state, entry.active_irq_id);
+	entry.active_lock_id = inherited_id(state, entry.active_lock_id);
+	callee->entry_refs = entry.acquired_refs;
+	callee->entry_rcu_locks = entry.active_rcu_locks;
+	callee->entry_preempt_locks = entry.active_preempt_locks;
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
+		/* what a scalar is linked to stays with the caller, so does the delta to it */
+		if (callee->regs[i].type == SCALAR_VALUE)
+			clear_scalar_id(&callee->regs[i]);
+		callee->regs[i].id = inherited_id(state, callee->regs[i].id);
+		callee->regs[i].parent_id = inherited_id(state, callee->regs[i].parent_id);
+		callee->regs[i].map_uid = inherited_id(state, callee->regs[i].map_uid);
+	}
+	for (i = 0; i < callee->out_stack_arg_cnt; i++) {
+		if (callee->stack_arg_regs[i].type == SCALAR_VALUE)
+			clear_scalar_id(&callee->stack_arg_regs[i]);
+		callee->stack_arg_regs[i].id = inherited_id(state, callee->stack_arg_regs[i].id);
+		callee->stack_arg_regs[i].parent_id =
+			inherited_id(state, callee->stack_arg_regs[i].parent_id);
+		callee->stack_arg_regs[i].map_uid =
+			inherited_id(state, callee->stack_arg_regs[i].map_uid);
+	}
+
+	account_current_path(env);
+	env->subprog_info[subprog].on_its_own = true;
+	err = bpf_flow_call(env, state, &entry, subprog, insn_idx);
+	bpf_free_verifier_state(&entry, false);
+	/* the call waits, there is nothing to go on with */
+	return err ?: PROCESS_BPF_EXIT;
+}
+
+/* The current state is at exit of a function that is verified on its own. */
+static int exit_func_on_its_own(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *callee = state->frame[0];
+	u32 i, nregs;
+	int err;
+
+	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	for (i = 0; i < nregs; i++) {
+		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
+			continue;
+		verbose(env, "cannot return stack pointer to the caller\n");
+		return -EINVAL;
+	}
+	state->unwound |= bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx]);
+
+	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
+	err = destroy_dynptrs_in_stack_slots(env, callee, 0,
+					     callee->allocated_stack / BPF_REG_SIZE - 1);
+	if (err)
+		return err;
+
+	account_current_path(env);
+	err = bpf_flow_exit(env, state, env->insn_idx);
+	return err ?: PROCESS_BPF_EXIT;
+}
+
 static u32 fresh_id(struct bpf_verifier_env *env, struct bpf_idmap *idmap, u32 id)
 {
 	u32 flags = id & BPF_ADD_CONST, i;
@@ -12012,6 +12194,9 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	if (err)
 		return err;
 
+	if (func_is_on_its_own(env, state, subprog))
+		return call_func_on_its_own(env, subprog, *insn_idx);
+
 	/*
 	 * For regular function entry setup new frame and continue
 	 * from that frame.
@@ -20957,6 +21142,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur_frame = cur_func(env);
 
+	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
+		return exit_func_on_its_own(env);
+
 	/* We must do check_reference_leak here before
 	 * prepare_func_exit to handle the case when
 	 * state->curframe > 0, it may be a callback function,
@@ -21937,6 +22125,12 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		if (need_resched())
 			cond_resched();
 
+		/* no insn makes as many ids as there are from here to BPF_INHERITED_ID */
+		if (env->id_gen >= BPF_MAX_ID) {
+			verbose(env, "too many ids\n");
+			return -E2BIG;
+		}
+
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
 			verbose(env, "invalid insn idx %d insn_cnt %d\n",
@@ -23532,6 +23726,37 @@ static int do_check_all(struct bpf_verifier_env *env)
 	}
 }
 
+/*
+ * What it took to verify a static subprog on its own is not in insns_total of its callers.
+ * Add it, once per caller. The main prog and global subprogs have all of it already.
+ */
+static void add_insns_of_callees(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int *added, i, j, s, c;
+
+	added = kvcalloc(env->subprog_cnt, sizeof(*added), GFP_KERNEL_ACCOUNT);
+	if (!added)
+		return;
+	/* callees first */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		s = env->subprog_topo_order[i];
+		if (!s || bpf_subprog_is_global(env, s))
+			continue;
+		for (j = si[s].start; j < si[s + 1].start; j++) {
+			if (!bpf_pseudo_call(&insn[j]))
+				continue;
+			c = bpf_find_subprog(env, j + insn[j].imm + 1);
+			if (c <= 0 || c == s || !si[c].on_its_own || added[c] == s)
+				continue;
+			added[c] = s;
+			si[s].insns_total += si[c].insns_total;
+		}
+	}
+	kvfree(added);
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
@@ -25603,10 +25828,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		goto skip_full_check;
 
 	ret = do_check_all(env);
-
 	/* reject recursion through the callx edges found by the main pass */
 	if (ret == 0 && env->callx_edges)
 		ret = sort_subprogs_topo(env);
+	/* while the calls are what they are in the program */
+	if (env->log.level & BPF_LOG_STATS)
+		add_insns_of_callees(env);
 
 	/* the driver numbers the insns like the program that it was given */
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
-- 
2.55.0

