Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911546;
	b=VddcjeSaW2FXUOWB61pmYPebLRDKKv5snlkxAqMv6qsY3ejfJ+B5xBH5nJPo2/eshOh8
	 dLon2b5MBdjF2CiUH5/qz+iDneyTm+tqucS9lgC41Ez/2Jv9+LPY++9P2qAGazyJwAVax
	 kcu++5xbjHaUxhunAT7FPNepByscuqGFsejmzBRs3mG6KUMxT1KGLokbZYLER/pULWZ0E
	 UhwvVL5Fc0G6YL6mkzmHC06qWf7KfV3DA9W/YHft3vX8YKMP5NMM5WlP3Djcg64GbdNea
	 gXbkfzqGbZz5gkH+/654vfPHnNUZgEWEnOtNA+BzfJNFIBIPc8ZKNVCjIZ9p6Tn7KBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4uhQ9B3m4CL1dyIUwTC/dsXplnEoP6Zvr1j6wsaA+ig=;
	b=PmA1d00LY6yKwasCgDEbhLInnV0WF4SsQVNXU/kZfd2I1wvtNH+zX/E96bUp97SbqzI1
	 wx6isq0Oml08efZE7JptIfWkRwFTlao2qi1w/MMZ/OvBOIPMxjyJgouHKzLWs4GOAl0jM
	 zJv/HCrd2twoKSIdHCIFLT/uWcsVdIvkU5AvbwZYR4wBu83hWCuasE294RncyF5Z0O2od
	 RqhWY0Wzwko/hxfRIPLAw2zopwUC+WTneyBJF5VyNY6e7mrPA6Qhw1BGODW22CW8EgvfU
	 tA0+uEXMhvoV98aGNH8I2BcA1Ks6GtZYgBL+09X9Qwec3puRLar6YrWIeBENt6uAaWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0CyRHfiv;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567F606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4567F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0CyRHfiv
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1453865a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911545; x=1794516345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4uhQ9B3m4CL1dyIUwTC/dsXplnEoP6Zvr1j6wsaA+ig=;
        b=0CyRHfivOIUA1ovf1a3v5wTeppVmB0JAI474J+PRTxb3geL0b9ix9PFjn2vIOz+qUY
         Xrj1ZlZRxpy4wtDQ35URnz0ZOJ89CeUXk1bPj4eRKfVaUPoQUKNgHJHVOVQOgMTFso0r
         bJCN1DfXvadr3Fi+BFOVbZvYkk3/mD4WFy127HsT/5JCe5LYmVAjwojERwUX+ExXQXCy
         yLXNdMNklAevzG/SrBWFU7fHP3JLdB6Aa5VESTLfO5Am4UqunUVS0rktmy9jJNe90eMn
         5WK8A7uEjPRehXa7mNLZ1bv/7S+QuagxUQBxDIb2yW65gdhXPJH9xFt6H5LQpuXRyrm6
         dX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911545; x=1794516345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4uhQ9B3m4CL1dyIUwTC/dsXplnEoP6Zvr1j6wsaA+ig=;
        b=B1x5AUjuEjtNS2Z30xT7fRGbe//C0AAGj2bsnQtEW4kDoEd8WADlEqSojNL2aokrys
         s6hwn1VLicnhpCksnCURVxwybjvPHFgX5Ke4fj3sT2zDWemfbuLbm6ASuxjgeqIiPSCC
         R4a2l3hnzKF0O3hqH6S5EhFbWj52PtUgpA1APqOzK8+iUAM5O3RVH3XSFIIQHyxiMBNS
         T35NLi9J7uQziOjIJE9FFvJJZoImlOyZT+3ZjzZFCHZ3gjOtEPZ1TSq0+FGLlPpIdjuK
         deU7NKxDS0AWAy+hFZZFw7kHoH9hU5A+km+4Qd83VV0+kvC/8IZb+XEtS1J5YrwBlXNS
         fbWA==
X-Gm-Message-State: APuU4Z+UT38DCQrACc72AZJkOp7ZvdW5wTy8WvHfuH3CkFVonTRBNGQb
	AMc1fItvfSGE9DG7v+RDhHsDV6fo7UIypGHnPvyZDL6hTDxbZifejqVLuhnFWQ==
X-Gm-Gg: AYBFou0J10+WzlzxdtgVxObbgis6eAaAYZFu3Yy0hbfALbG+dR58huZqVsQPBrqqobb
	J3/57mXyKt5vd/YGH91MMlUsxBiWYsMcSTNPEfM7sebg9xvB5gm29Ai+TDmrp3iHq7FP7dH24aM
	GL5vBrea7mO7cgcDNh6UoYmjPNnL5yY96QzBQXwBe/Oryk8qCHS8KQjbuoah2UeLT0QtPYJIuy3
	41K7wbm9TlvLsM68/SmapeZ7bJjHLiUqY6aVmvADwM2uKq7H8djmRwexoDmACaruEF4b74G5ENw
	Jn1Gj0l99HYlJgXiOBi2OYmLbP8bEBLjnlSatzWLnwZxxgOKHgdPosxS8HiXN0FH4Ejg9SfUEJi
	2yzEF/nht2/DcQ4G6/niXRJijypOHe5+PEM3SjDRQOylAJbZOVoPBFUM2xZDr5RqLDuB10uKqWI
	BYHWQoED05wLOed1228XJ4Hbsu2FWJ+H1/jLHrRCn/AsTIoCR65P46hbZ46sSoOA+YIYuLXkk+i
	9X94tlbbT+KlPmqraEPkCQv8frLz79Fb/Fnd3FfBTo9fbTTE0jJfPn8Ih8zEhEvWyMp74OrDPNc
	5ELcuC/P1hioBwaMQb0HmxJwlIwRoDpaquG676/nRQiZBtzEpEa+f/K2KNZw7CxZBD5criw47pu
	e7LeNjomK8LmqyyExwqjnUOSAIG2RbJYZw9iKlPLklK7aGd7gDbMI6+wljaQyvfcxO9tZsAw10B
	E=
X-Received: by 2002:a17:90b:5905:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b0db70add1mr173883a91.49.1793911545043;
        Thu, 05 Nov 2026 12:45:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7cb249fsm606408a91.15.2026.11.05.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/35] bpf: Add join of verifier states
Date: Thu,  5 Nov 2026 20:44:42 +0000
Message-ID: <20261105204513.2230344-6-alexei.starovoitov@gmail.com>
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

central_dispatch() of tools/sched_ext/scx_central.bpf.c:

  bpf_for(cpu, 0, nr_cpu_ids) {
          ...
          if (dispatch_to_cpu(cpu))
                  *gimme = false;
  }
  ...
  dispatch_to_cpu(central_cpu);

To verify dispatch_to_cpu() one time, not for each call, the states of the
two calls must meet at its first insn. Numbers, like cpu, can be joined.
But at one call the iterator of bpf_for() is held, at the other nothing.
One state cannot stand for the two: the code after the return destroys the
iterator for one of them only. A state is more than registers and slots.

Add the second half of join.c and build it. bpf_states_join() joins two
states at one insn, frame by frame. There is no join, and the caller keeps
the two states, when one of these differs:

  frames                number, subprog, callsite, kind of callback
  locks, RCU, preempt   the counts, the lock
  references            number and types. The ids must pair one to one
  held since the entry  entry_refs, entry_rcu_locks, entry_preempt_locks
  loop stack            the loops, the state that entered them, the count,
                        the iteration if iterations are kept apart
  flags                 speculative, sleepable, unwound, ...

 - A register, its spill and the reference have one id. Thus the pairs of
   ids are collected over all frames and references first, and the join
   is made in a second pass.
 - Only live registers count, and the caller removes dead stack slots with
   bpf_clean_verifier_state(). What is dead does not prevent a join.
 - A subprog that is verified without its callers has what they hold in
   its state, as above. entry_* tell how much of it is still held.
 - Such a subprog has its incoming stack arguments in the slots for
   outgoing ones, until it has loaded them. The two kinds are not joined.
   quicksort(right, scratch, limit, pivot_ref, is_less) of Rust's core is
   recursive and takes 7 words: bpfland_init of rust-bpf fails without it.

bpf_states_join() examines each result with the comparison that pruning
uses: the join must cover state a and state b. If it does not, that is a
verifier bug and the prog is rejected, not loaded. The fields that join.c
compares come with this patch. Nothing sets them, nothing calls the join.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  65 ++++++++-
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/join.c            | 247 +++++++++++++++++++++++++++++++++++
 kernel/bpf/states.c          |  12 ++
 4 files changed, 324 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index edddb25c4c12..1b08ccd5d766 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -120,6 +120,11 @@ struct bpf_reg_state {
 			/* packing following two fields to fit iter state into 16 bytes */
 			enum bpf_iter_state state:2;
 			int depth:30;
+			/*
+			 * The number of loops, in all frames, that the program was in
+			 * when it made the iterator, see iter_stops_loops().
+			 */
+			u32 loops:30;
 		} iter;
 
 		/* For irq stack slots */
@@ -363,12 +368,35 @@ struct loop_stack_entry {
 	struct bpf_verifier_state *entry_state;
 	u32 min_header_count;
 	u32 max_header_count;
-	u32 loop_id:31;
+	u32 loop_id:23;
 	u32 terminates:1;
+	/* the loop had may_goto when the state entered it, see check_loop_guard() */
+	u32 guarded:1;
+	/*
+	 * The iterations are kept apart: states with different @trip are not
+	 * joined for as long as they are in the loop.
+	 */
+	u32 apart:1;
+	/* max_header_count follows from the state at the entry, not from patience */
+	u32 counted:1;
+	/*
+	 * How many times the state came back to the head of the loop. With @apart that is
+	 * the iteration that it is in. A state that stands for many iterations is a join, and has
+	 * the largest number of the states that it is made of.
+	 */
+	u32 trip;
+	/* the number of references that the state had when it entered the loop */
+	u32 refs;
 	int iv_reg;
 	struct cnum64 iv_range;
 };
 
+/* The state is in a walk on patience, which may not get to the end of the loop */
+static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entry)
+{
+	return entry->apart && entry->terminates && !entry->counted;
+}
+
 #define LOOP_STACK_SIZE 16
 
 /* state of the program:
@@ -426,6 +454,14 @@ struct bpf_func_state {
 	 * subprogram (loops never cross subprogram boundaries).
 	 */
 	u32 loop_stack_cnt;
+	/*
+	 * How much of what was held when the frame was entered is held ever since. For
+	 * references that is the first entry_refs of refs[]. What is released and taken again
+	 * doesn't count. More than that is for this frame to release.
+	 */
+	u32 entry_refs;
+	u32 entry_rcu_locks;
+	u32 entry_preempt_locks;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -558,8 +594,15 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	/* a global function or an extension, and what it calls: exit of frame 0 is not the end */
+	bool callers_unknown;
 	/* The callee left with unwind_exit. Next insn is unwind_goto. */
 	bool unwound;
+	/*
+	 * A function that is verified on its own changed packet data. Its callers
+	 * and their packet pointers are not in the state, see bpf_flow_return().
+	 */
+	bool changed_pkt_data;
 
 	/*
 	 * First and last insn idx of this verifier state.
@@ -620,6 +663,16 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 	return NULL;
 }
 
+/*
+ * The function that is verified on its own has no caller to look at. Its incoming arguments
+ * are in stack_arg_regs of frame 0 until it is done with loading them. Until then it has
+ * no outgoing arguments.
+ */
+static inline bool bpf_stack_args_are_incoming(const struct bpf_func_state *frame)
+{
+	return !frame->frameno && !frame->no_stack_arg_load;
+}
+
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
 #define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
 	for (iter = 0, reg = bpf_get_spilled_reg(iter, frame, mask);		\
@@ -754,6 +807,8 @@ struct bpf_loop {
 	bool exits_overflow;
 	/* @exits of a loop in this one is cut. Then @exits of this loop can lack exits too. */
 	bool nested_exits_overflow;
+	/* and it is going to be there, see bpf_flow_loop_gets_guards() */
+	bool guarded;
 	/*
 	 * Loop-entry registers used to compute stack addresses for loads,
 	 * stores and calls requiring fixed stack offsets, in this and nested
@@ -885,6 +940,11 @@ struct bpf_insn_aux_data {
 	 * For a loop header, identifies the parent loop instead.
 	 */
 	s32 loop_header;
+	/*
+	 * bpf_iter_*_next(): the innermost loop around it that counted on it and that it doesn't
+	 * stop, -1 if none was found. It doesn't stop the loops around that one either.
+	 */
+	s32 not_stopped;
 	/* where may_goto in front of this instruction goes */
 	s32 guard_to;
 	/* additional information about the loop if this instruction is a loop header */
@@ -1535,6 +1595,9 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+			struct bpf_verifier_state *cur);
 
 /* join.c */
 int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269810b128c4..3e0b096cfc9f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index fe513b7a8e88..4da051767e1d 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -398,3 +398,250 @@ static bool join_slot(struct bpf_join_state *js, struct bpf_stack_state *ds,
 	bpf_mark_reg_not_init(js->env, &ds->spilled_ptr);
 	return true;
 }
+
+static bool join_loop_stack(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
+{
+	u32 i;
+
+	if (fa->loop_stack_cnt != fb->loop_stack_cnt)
+		return false;
+	/* what is known about a counted loop comes from the state it was entered with */
+	for (i = 0; i < fa->loop_stack_cnt; i++)
+		if (fa->loop_stack[i].loop_id != fb->loop_stack[i].loop_id ||
+		    fa->loop_stack[i].terminates != fb->loop_stack[i].terminates ||
+		    fa->loop_stack[i].guarded != fb->loop_stack[i].guarded ||
+		    fa->loop_stack[i].counted != fb->loop_stack[i].counted ||
+		    fa->loop_stack[i].apart != fb->loop_stack[i].apart ||
+		    (fa->loop_stack[i].apart && fa->loop_stack[i].trip != fb->loop_stack[i].trip) ||
+		    fa->loop_stack[i].refs != fb->loop_stack[i].refs ||
+		    fa->loop_stack[i].max_header_count != fb->loop_stack[i].max_header_count ||
+		    fa->loop_stack[i].entry_state != fb->loop_stack[i].entry_state)
+			return false;
+	return true;
+}
+
+static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
+		      const struct bpf_func_state *fa, const struct bpf_func_state *fb,
+		      u16 live_regs, int pass)
+{
+	static const struct bpf_reg_state not_init = { .type = NOT_INIT };
+	struct bpf_verifier_env *env = js->env;
+	u32 i, nslots_b;
+	bool in_a, in_b;
+
+	if (pass == 1) {
+		if (fa->callsite != fb->callsite || fa->frameno != fb->frameno ||
+		    fa->subprogno != fb->subprogno)
+			return false;
+		if (fa->in_callback_fn != fb->in_callback_fn ||
+		    fa->in_async_callback_fn != fb->in_async_callback_fn ||
+		    fa->in_exception_callback_fn != fb->in_exception_callback_fn ||
+		    fa->in_rcu_callback_fn != fb->in_rcu_callback_fn ||
+		    fa->async_entry_cnt != fb->async_entry_cnt ||
+		    memcmp(&fa->callback_ret_range, &fb->callback_ret_range,
+			   sizeof(fa->callback_ret_range)))
+			return false;
+		if (fa->entry_refs != fb->entry_refs ||
+		    fa->entry_rcu_locks != fb->entry_rcu_locks ||
+		    fa->entry_preempt_locks != fb->entry_preempt_locks)
+			return false;
+		if (!join_loop_stack(fa, fb))
+			return false;
+	}
+
+	for (i = 0; i < MAX_BPF_REG; i++) {
+		if (!(live_regs & BIT(i))) {
+			if (pass == 2 && i < BPF_REG_FP)
+				bpf_mark_reg_not_init(env, &fd->regs[i]);
+			continue;
+		}
+		js->place = i;
+		if (!join_reg(js, &fd->regs[i], &fa->regs[i], &fb->regs[i], pass))
+			return false;
+	}
+
+	nslots_b = bpf_stack_nr_slots(fb);
+	for (i = 0; i < bpf_stack_nr_slots(fa); i++) {
+		const struct bpf_stack_state *sb = i < nslots_b ? bpf_stack_slot(fb, i) : NULL;
+
+		js->place = MAX_BPF_REG + i;
+		if (!join_slot(js, bpf_stack_slot(fd, i), bpf_stack_slot(fa, i), sb, pass))
+			return false;
+	}
+	js->place = -1;
+	/* Slots that exist only in 'b' are STACK_INVALID in the result. */
+	for (i = bpf_stack_nr_slots(fa); pass == 1 && i < nslots_b; i++) {
+		const struct bpf_stack_state *sb = bpf_stack_slot(fb, i);
+
+		if (slot_is_special(sb) ||
+		    (slot_has_spill(sb) && sb->spilled_ptr.type != SCALAR_VALUE))
+			return false;
+	}
+
+	if (fa->out_stack_arg_cnt < fb->out_stack_arg_cnt)
+		return false;
+	/* incoming arguments are not joined with outgoing ones: that side has no outgoing ones */
+	in_a = bpf_stack_args_are_incoming(fa) && !bpf_stack_args_are_incoming(fb);
+	in_b = bpf_stack_args_are_incoming(fb) && !bpf_stack_args_are_incoming(fa);
+	for (i = 0; i < fa->out_stack_arg_cnt; i++) {
+		const struct bpf_reg_state *rb;
+
+		if (in_a) {
+			if (pass == 2)
+				bpf_mark_reg_not_init(env, &fd->stack_arg_regs[i]);
+			continue;
+		}
+		rb = i < fb->out_stack_arg_cnt && !in_b ? &fb->stack_arg_regs[i] : &not_init;
+		if (!join_reg(js, &fd->stack_arg_regs[i], &fa->stack_arg_regs[i], rb, pass))
+			return false;
+	}
+
+	if (pass == 2) {
+		fd->no_stack_arg_load = fa->no_stack_arg_load || fb->no_stack_arg_load;
+		fd->callback_depth = min(fa->callback_depth, fb->callback_depth);
+		for (i = 0; i < fd->loop_stack_cnt; i++)
+			fd->loop_stack[i].trip = max(fd->loop_stack[i].trip, fb->loop_stack[i].trip);
+	}
+	return true;
+}
+
+/* Things that can't be different in two states that are joined */
+static bool join_check_state(const struct bpf_verifier_state *a,
+			     const struct bpf_verifier_state *b)
+{
+	int i;
+
+	if (a->curframe != b->curframe || a->insn_idx != b->insn_idx)
+		return false;
+	if (a->speculative != b->speculative || a->in_sleepable != b->in_sleepable ||
+	    a->callers_unknown != b->callers_unknown ||
+	    a->unwound != b->unwound || a->changed_pkt_data != b->changed_pkt_data)
+		return false;
+	if (a->active_locks != b->active_locks ||
+	    a->active_preempt_locks != b->active_preempt_locks ||
+	    a->active_rcu_locks != b->active_rcu_locks ||
+	    a->active_lock_ptr != b->active_lock_ptr ||
+	    !a->active_irq_id != !b->active_irq_id ||
+	    !a->active_lock_id != !b->active_lock_id)
+		return false;
+	if (a->acquired_refs != b->acquired_refs)
+		return false;
+	for (i = 0; i < a->acquired_refs; i++) {
+		if (a->refs[i].type != b->refs[i].type)
+			return false;
+		switch (a->refs[i].type) {
+		case REF_TYPE_PTR:
+		case REF_TYPE_IRQ:
+			break;
+		default:
+			if (a->refs[i].ptr != b->refs[i].ptr)
+				return false;
+		}
+	}
+	return true;
+}
+
+static void join_refs_note(struct bpf_join_state *js, const struct bpf_verifier_state *a,
+			   const struct bpf_verifier_state *b)
+{
+	int i;
+
+	jid_note(js, a->active_irq_id, b->active_irq_id, true);
+	jid_note(js, a->active_lock_id, b->active_lock_id, true);
+	for (i = 0; i < a->acquired_refs; i++) {
+		jid_note(js, a->refs[i].id, b->refs[i].id, true);
+		if (a->refs[i].type == REF_TYPE_PTR)
+			jid_note(js, a->refs[i].parent_id, b->refs[i].parent_id, true);
+	}
+}
+
+static bool join_refs_check(struct bpf_join_state *js, const struct bpf_verifier_state *a,
+			    const struct bpf_verifier_state *b)
+{
+	int i;
+
+	if (!jid_strict_ok(js, a->active_irq_id, b->active_irq_id) ||
+	    !jid_strict_ok(js, a->active_lock_id, b->active_lock_id))
+		return false;
+	for (i = 0; i < a->acquired_refs; i++) {
+		if (!jid_strict_ok(js, a->refs[i].id, b->refs[i].id))
+			return false;
+		if (a->refs[i].type == REF_TYPE_PTR &&
+		    !jid_strict_ok(js, a->refs[i].parent_id, b->refs[i].parent_id))
+			return false;
+	}
+	return true;
+}
+
+/* The result has to describe everything that an input describes */
+static int join_check(struct bpf_join_state *js, struct bpf_verifier_state *dst,
+		      const struct bpf_verifier_state *in, const char *which)
+{
+	struct bpf_verifier_env *env = js->env;
+
+	if (bpf_state_subsumes(env, dst, (struct bpf_verifier_state *)in))
+		return 0;
+	/* check_ids() has no room left: that says nothing about the join */
+	if (env->idmap_scratch.cnt == BPF_ID_MAP_SIZE)
+		return 1;
+	bpf_log(&env->log, "join:");
+	print_verifier_state(env, dst, dst->curframe, true);
+	bpf_log(&env->log, "input %s:", which);
+	print_verifier_state(env, in, in->curframe, true);
+	verifier_bug(env, "join of states at insn %u does not subsume input '%s'",
+		     dst->insn_idx, which);
+	return -EFAULT;
+}
+
+/*
+ * Compute in @dst the state that describes everything that @a or @b describe.
+ * @dst has to be a valid state (zeroed is fine) different from @a and @b, its
+ * previous content is released. Bookkeeping fields are copied from @a.
+ *
+ * Returns 0 on success, 1 if there is no join, negative error otherwise.
+ * When 1 is returned the content of @dst is undefined, but it's a valid state.
+ */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
+		    bool widen)
+{
+	struct bpf_join_state *js = join_state(env);
+	const struct bpf_func_state *frame;
+	int pass, fr, err;
+
+	if (!js)
+		return -ENOMEM;
+	js->widen = widen;
+	js->npairs = 0;
+	js->pairs_overflow = false;
+
+	if (!join_check_state(a, b))
+		return 1;
+	err = bpf_copy_verifier_state(dst, a);
+	if (err)
+		return err;
+
+	for (pass = 1; pass <= 2; pass++) {
+		if (pass == 1)
+			join_refs_note(js, a, b);
+		else if (!join_refs_check(js, a, b))
+			return 1;
+		for (fr = 0; fr <= a->curframe; fr++) {
+			u32 insn_idx = bpf_frame_insn_idx((struct bpf_verifier_state *)a, fr);
+			u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+			u32 cnt;
+
+			/* not the states that get to the head through a call of the function */
+			frame = a->frame[fr];
+			cnt = frame->loop_stack_cnt;
+			js->loop = widen && fr == a->curframe && cnt &&
+				   frame->loop_stack[cnt - 1].loop_id == insn_idx ?
+				   env->insn_aux_data[insn_idx].loop : NULL;
+			if (!join_func(js, dst->frame[fr], a->frame[fr], b->frame[fr],
+				       live_regs, pass))
+				return 1;
+		}
+	}
+
+	return join_check(js, dst, a, "a") ?: join_check(js, dst, b, "b");
+}
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 50480c42bcad..4136a708a78e 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1765,3 +1765,15 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	 */
 	return bpf_split_cur_state(env);
 }
+
+int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	return clean_verifier_state(env, st);
+}
+
+/* Everything that @cur describes is described by @old. */
+bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+			struct bpf_verifier_state *cur)
+{
+	return states_equal(env, old, cur, RANGE_WITHIN);
+}
-- 
2.55.0

