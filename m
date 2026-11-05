Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911641;
	b=kU/ttKV/RsPwfZFc8cgHJpY1Daik0dguF/v2oaCD1+6urIqExotRTCqRE9jqreFvBHEs
	 hrFHSaDJ7/7vqpcOlT5s5H/A/sIJsx4oTkG1VL7gxxTfSoGi4SZREfcSygTJWILc8DQIY
	 nQmsaWV/TVWuwjOTiWYen1lbniC6HjQXOZuLoUeL5VKeZUAYkdxhSjHPGUoV/3tyQf7W2
	 kmG58G1iI6cwlt66rHcrUv6QnP8dziSZXZpMLhti7+Tor+72o7df9DWi+NljR7uoeKYX/
	 KIESrRqBBBCA/6N77IuGqsQTm80DI4FRWCUDjSeDPJH2mjitVj+OEpQl9uFemR+0hYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zyyPXNC5SqJLCewbPLQ97QPZFBsiRuzXsEO1d0pzTxI=;
	b=D3OPOT0Qcqnoo6WybTKZ8JtkgER+uI9BwFWC6V1hy2jPL4eLuUvJ0J1jfFPivN2pjbrV
	 qwDvIHJ9sQw4EMY76phN/quTQrb577jyr09Gqz/wq/p2AJB4PDWeTD3owFU28wTMoV3jB
	 ijd1pjWpVYRejePZBe5wIhFqnCTIuxOlMGbb5xOkaELttpLhP8aqT8C3qaMDzkQNw70Fj
	 CEK/jFMSL3Co3ymzJfvk7k+8uowNIA+DIU+Vg8Kn5Rd0yd+XXBJfxYLlCITyY7sIdLrST
	 mRaesKpeDZTFFPd0YXr+5ATa1bO/uNwyQ5I68iRxrci1Bi9HJz87wZxivkbIqLl6gVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=th1vdAsX;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFE5606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFE5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=th1vdAsX
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b2382bf051so626007b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911640; x=1794516440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyyPXNC5SqJLCewbPLQ97QPZFBsiRuzXsEO1d0pzTxI=;
        b=th1vdAsXVrW3ECSAPoxlTryctf6DwOHCABcmhQV8RhK57jiyC8Vgfwux+Q+JupSDak
         6AQsioAKes+HSRP+/xTVh3BKLNn3VmJTbrUoJCcijtn/xR+HP2HLCrz3bqSnb423/4qu
         KBSbg5/naKmVNX9Bvgpi+5DvtPXCTdHCVlbHVmcEGv2xu1q/wiUUMI5n1FS324xGxL+F
         btcfRzzhSkZrXWniRkVh+cCj+f+eX17olOWjBMSnla9zRR9hGANWVyGesU9vHL/5p2oT
         1LmDux6UYwDwcgDLV3wJGf3d0eO+06s35u0129GFz4sQ7AWGH26M//PLAhuMDaRG4A+5
         ONsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911640; x=1794516440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zyyPXNC5SqJLCewbPLQ97QPZFBsiRuzXsEO1d0pzTxI=;
        b=dJNamXGmqoeS6KUV8GN59kp6g5Jt3axW8RhdjVRgO+gHBxWo5HF50adEljwWp0rAT1
         7e/2C6s91FVnExTAbxMId/PEl2/CfCioJJyxKW3DoXFTUoPS6rcPwk8jdtYEBXhqOn2K
         UraGaVJfqEn3ad7SEfl9xeKQMBBgJgNirIvLzZL4znl/6GS1Wc5fLvoDP63bQ5cmQ4FP
         jadj8mgRUfGxTjo83y8QelXNp8Lluv3D9JSMfO5pYOWrDouDZG/Y/hagvG3RvmuxzPj+
         4up5qVNytNM+mqweQ3CsnZgeVmWj/ROP45gL15u1QK/qbBDxCQh/cEAJKVpp/XWrSIzq
         PDCQ==
X-Gm-Message-State: APuU4Z+tb+RfLzIOk0OsfLoDC+uazBwS5PP5jxGRBZuWGuvx5/4LN82K
	kgAmkDqa7cVW/0dnzjb5XbA9xHQVk6B1q1D0JGYhk/3hk7OhRZWsMO8rRm+niQ==
X-Gm-Gg: AYBFou1LvuKUSISg9zNMnSdvS43CdaeL/P25cd/oncn3/JtEjfdfI3wSVWEHHVvJV56
	vP4/1JkOXDpfZyDkdwXa8hF5Xk2mIaNfQRp1RfpBnpcGqWssnXqvMFBGxcR7H4l/jR2I3jkFV7Q
	eNVDTopc41VOL6U0keqZ+jmUg269ivYgobRaHTwqh8+ZhLTQqb7ieERurdJNqDtdBrQwcrjIwdi
	dXoEDCI/JCopa/mQciiBnMT5S4cxAdd4pabMbuR911YXqmRLrfPwnUNE5XYzPmDVa0j9xLaiNJO
	qElW2d0NltfZDU3AyCZekRBbqEC48i4SbljwM9ngubSd3gWr/hR3fgf4Or0Igrf1C4AxlrZfzrQ
	8X9x1TSUH4UgJ6h7xw1/X4cgqF6UOEAK1375lxZ2ssE6cKfGbGFEfGIYw6TSrdowlyQ9nSuUK0C
	yxNsSsLd0N11jUA/iEm7IZlLfExnu1HYRcTS9OPUuQxMPg9xq7bMJkXxZvT8ghAjs2ucz96trXR
	A7UQD9FrVHEDzTMMaKCL0mrdhMa8MXhuk5x36mmgSQSay1NywneW2l9OT3EMCtn7it1nS18jMSZ
	kB347F2t/d9wdn4Mz2Fz8yxiXiOmk4wGUsQiq0LjoTIuhQd9tUx+UdzrnxmEnmBFlwT8k97ooNG
	e2DCYlsbA/inmyPUBgdud0x/KeSNFpr9a+RRQeSETgIWgM9BmXj2wmim0dvdkE1zx55zhwBNM4g
	==
X-Received: by 2002:a05:6a21:778c:b0:3e2:ae03:b296 with SMTP id adf61e73a8af0-3ebb28f176fmr600943637.37.1793911640036;
        Thu, 05 Nov 2026 12:47:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597ef3d1sm83285b3a.22.2026.11.05.12.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:47:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 21/35] bpf: Verify static subprogs on their own
Date: Thu,  5 Nov 2026 20:44:58 +0000
Message-ID: <20261105204513.2230344-22-alexei.starovoitov@gmail.com>
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

Selftest test_verif_scale1, 90 times in a row, jhash() is static noinline:
  ptr = data + i;
  if (ptr + nh_off > data_end)
      break;
  ctx->tc_index = jhash(ptr, nh_off, ctx->cb[0] + i++);
The verifier verifies a static subprog in the frames of its callers. States
with different frames have no join: each insn of jhash() has a state for
each way to it: "more than 1024 states that cannot be joined at insn 903".
In Rust each function of core and alloc is a static subprog: 30 tests of
rust-bpf are rejected too, its schedulers take 6 times the insns, those of
sched-ext/scx +9 .. +15 %.

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
id. The frames of the callers stay, func_is_on_its_own(), if
 - an argument is a pointer to the stack or a dynptr: it is their memory,
 - an argument is a pointer with the id of something that is not held: the
   id of its NULL check, or of a variable offset into the packet,
 - an argument can be NULL or is the end of the packet: the subprog does
   a check for the caller ('direct packet access: test29'),
 - the subprog is a callback, changes packet data, has a tail call or
   LD_ABS, or releases what the caller holds.
BPF_LOG_STATS adds its insns to each caller: verifier_subprog_insn_stats.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/verifier.c        | 219 ++++++++++++++++++++++++++++++++++-
 2 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 95ca8017d81a..82184053677c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1186,6 +1186,9 @@ struct bpf_id_pair {
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
index 808092037806..901f4c7620e9 100644
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
@@ -11246,6 +11247,8 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 			mark_reg_invalid(env, reg);
 		}
 	}));
+	if (env->cur_state->flow_entry)
+		env->cur_state->changed_pkt_data = true;
 }
 
 static bool holds_pkt_pointers(struct bpf_verifier_env *env)
@@ -11794,6 +11797,175 @@ static void account_current_path(struct bpf_verifier_env *env);
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
+static bool arg_needs_caller(const struct bpf_verifier_state *state,
+			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
+{
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
+	if (reg->type == PTR_TO_PACKET_END && !sub->recursive)
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
+		if (arg_needs_caller(state, sub, &caller->regs[i]))
+			return false;
+	}
+	for (i = 0; i < bpf_in_stack_arg_cnt(sub); i++) {
+		if (caller->stack_arg_regs[i].type == PTR_TO_STACK ||
+		    base_type(caller->stack_arg_regs[i].type) == CONST_PTR_TO_DYNPTR)
+			return false;
+		if (arg_needs_caller(state, sub, &caller->stack_arg_regs[i]))
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
+		callee->regs[i].id = inherited_id(state, callee->regs[i].id);
+		callee->regs[i].parent_id = inherited_id(state, callee->regs[i].parent_id);
+		callee->regs[i].map_uid = inherited_id(state, callee->regs[i].map_uid);
+	}
+	for (i = 0; i < callee->out_stack_arg_cnt; i++) {
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
@@ -11957,6 +12129,9 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	if (err)
 		return err;
 
+	if (func_is_on_its_own(env, state, subprog))
+		return call_func_on_its_own(env, subprog, *insn_idx);
+
 	/*
 	 * For regular function entry setup new frame and continue
 	 * from that frame.
@@ -20839,6 +21014,9 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur_frame = cur_func(env);
 
+	if (!exception_exit && !env->cur_state->curframe && env->cur_state->flow_entry)
+		return exit_func_on_its_own(env);
+
 	/* We must do check_reference_leak here before
 	 * prepare_func_exit to handle the case when
 	 * state->curframe > 0, it may be a callback function,
@@ -21774,6 +21952,12 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
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
@@ -23369,6 +23553,37 @@ static int do_check_all(struct bpf_verifier_env *env)
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
@@ -25436,10 +25651,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

