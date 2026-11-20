Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160798;
	b=18hlfjuWNjLkg/dK/aHrO+BGJcCkLbUJlue8K1hnZYhkN76i0bA254rMjfJQfz8xkPsP
	 q1gSWANZ/OvmVbiHpT3rNt5bBGkfUCokNUhFX1c81CrGmO5IBoEBKVDqTF+zzUWzUg5wc
	 TW0uS0n06ASi0uJhpq9ZfhhJRL5XRX39JmU2Fso8dFOfCAeZSCJNJB0/0TNeGMEgirz6G
	 0rjzJ/qYQWZv0sg5OOJcurggn1lS7mXMkj/1ZED27qdNtV1kGu8Dgjnl6DAOPaNR07TGz
	 wFxMd8RYP8utVY0mw9Fe0JbKT9IKx8vLwwZwKcmdRAMFOGZEp+SWc+Ta5/foZQySMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xjInmy+J6OJgcst6u/P374kTLL7cl0CJFJEDxZPVslk=;
	b=xABHmYR8yRybfO5RzaPlld3jHnbwSvrBKT42rMuoAaQwi88vFLpc5ExixnOQ/AaiJtEd
	 9mPuFUOgIyw0sZ00viURc9hHIwFf1+OOYlMBP4zXnrsEoRmDb4s+I4JPzjVh1F7vX58fz
	 88ppwteAQ/AC7kOHbEHfOnZKC0QGi+RWUsx+he8nTmLLU8sTBnhsyO+7KpEn3ZLiNc40G
	 BpwVqj72XGsdH2cE6rDvHQVOHJC2GH7aLlKBBV8OLTJJEql9J2H+sjd79DhH8/DEICajG
	 s82vZIy/vbCNZfFkwq/YVk3NaIzJ/RKjxabTngW20Ps9zuwd23er0oagl7vuwyCCDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF4X5002;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BC606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944BC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rF4X5002
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f00fc215f9so4000205ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160797; x=1795765597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjInmy+J6OJgcst6u/P374kTLL7cl0CJFJEDxZPVslk=;
        b=rF4X5002RAqdVySlBO4ToeqgbPurunEF9sFHourors1biYWGcmdZ78Ee6c1LCKeX3E
         55jbrs9ZNRLfp/nQCn5wt2bbIySI94Auarb4amxmXM/YyDHK0VP3/jGKLy/8Nr88316O
         ua7ZlY+d6pVdgY3uT3S4taxJtXnm6itUwla5x4CJ/afGodlM13ESUu9nQ6F1vF0KDRa6
         1Yd91xeQc1vqZEcoF7oneroULWu0q8ofzKfmmA6I25Bsgcr9uZxqfZdrS8VE6kkFoKlB
         LaEZQg84YaXIzbcSb9upwpUvJ84Jh4WgaeVAtIjJ9u2J0fBYDQgqMC7IcVlarIpd2B9f
         xu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160797; x=1795765597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjInmy+J6OJgcst6u/P374kTLL7cl0CJFJEDxZPVslk=;
        b=byesnMZdbZplWYoDnA4qwZttzTC+7luZSWD0YAABmCLv0snauQbQdrA6Wgfp2E0+lE
         MtO27DN4kqSKrQF34cI/6G8LLuTfdm/Z5sTUFDwwVX7O18QsHSnUdxvhjU1GkHD+SKjX
         BXsCWOW6bKwNmqxFMINSZssrTHddvxWPx0zqk52gdKIVD0mZBxlxnMBb1oSrgf8plb3E
         ZaRsQ6f3bcetEpoH5PbBrQZNpaQ0YX+ea9fs4rkFQ7OwVI+RmOs8KlxE4hts5/KvrJYJ
         o0JihQFhLV4YOsbtPSrFXTyeTwoQofgymctQ9B89NPqJgGkcFIfTcJbYwsnyAezwZ/zI
         ZGzw==
X-Gm-Message-State: APuU4Z8zlzCRmVfCrFeO85dBnOAKS4edX7DU+BOF/kmZisk5bEsf2Uvz
	30aByUdraYFZm6HKgFMhhU9Nwx6i2ZNlAlLKGRITL8Z8kE0bjcNIqs13vCgOTg==
X-Gm-Gg: AZFdTZdV33eVd/TC0xyY0edcJBwSothYctO1TB7IrNFux+S1O02vPomhlvx9at0CsY+
	esfwlVTc3Sort6jgBUgCXgrY9jIcfFeQCmJw7woNlnnV1EVSu5UiiXQmzZ0/aBLdt7VAazPOalD
	713Vgo/wvTwELgD4nrWKdDJojl+rEMWCSBGLZRI/kF1K32sEqli9nLCv0C0nCZUEr/HLHv0gr7c
	8ht9fy9GWGIztc7XJaASE/7S74gTLO0pIN3ll5uLVv/no5HnTO3oHWITDxYa4OIxFv3Og8eSdhP
	ypIQ3JeFg6Tz2jqPw6BLKtKUxPUb8rRVscsqgN/ARJw6qgwTBQAmNKgABhUlrQ/JGi4lsXvtFsR
	GzF/0QL/SqqsMyFp5e3AgMtsf3QK8dnWbvPH2GskK87hM6WFsTYflWqOjHj+EhTS2V5sl7A+WIA
	Tah1QLyiuOryj9oBFFZvqBd7WsnigJXlBN3KhYruL3YDtCGj11rX4sorNaPuPTiYDFE56DAfFvX
	Keu9IAk1zjzStmrMZkN0MhjlTl1Vt/2i23w74YIE0yqN8GI7uyUnFmW1SbX4TeStO97eN/p5up9
	FXhWPNGRDtx9fQX2rmrjG2pCyag767ZyuXNnfrPqFpYlWrGemndTYtEXIgOEngh5P+wxlZfjf98
	rpwFCLNQszfbhGaWnmK9gnLpv1Fo6pcUp08ZqoZlQnQXsvuKGVdXbbZChJJ2DuxeKGqAE5pBvQw
	==
X-Received: by 2002:a17:902:db08:b0:2ed:790:b8f8 with SMTP id d9443c01a7336-2f03ef5a24fmr26040105ad.2.1795160796634;
        Thu, 19 Nov 2026 23:46:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dcbe3sm10563525ad.28.2026.11.19.23.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 21/49] bpf: Compare states by join_key, then by value
Date: Fri, 20 Nov 2026 07:41:53 +0000
Message-ID: <20261120074430.2704488-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

The compare and the join of two states start with the same question:
can they be one state at all? Each had its own list of fields. Put the
fields in one group, the join_key:

  what is held    references, locks, dynptrs, iterators, irq flags
  where it is     the call chain, the instance of the function
  which trip      the peeled trip, or the leftover

The group is compared and hashed as bytes, so it has no padding.
States with two join_keys never meet. bpf_state_subsumes() looks only
at values.

regsafe() had a case for each type. All say the same: the type and the
object are equal, and the number is within. bpf_same_type_and_object()
answers the first part, also for the join.

Two rules are new. A later patch joins such values:
- Pointers to the packet are compared by the bytes that are left:

   smin           smax              range
    |-- offsets ---|-- bytes left ---|

  Pointers that share an id have to keep their distance. The pairs of
  ids are in env->pkt_pairs, which grows on demand.
- stacksafe() knows the bytes that a join makes. An unreadable spill
  subsumes a written byte, misc subsumes a spilled number, zero
  subsumes a spilled 0.

This also fixes a leak in the old code. A store of a pointer at a
variable stack offset makes a number of it. With the mitigations off
that needed no CAP_PERFMON. Reject it: a join of two offsets makes such
a store too.

This replaces refsafe(), regs_exact() and stack_arg_safe().
async_entry_cnt goes away: states of an async callback are joined.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 105 +++++++++---
 kernel/bpf/states.c          | 323 +++++++++++++++++++++++++----------
 kernel/bpf/verifier.c        |  15 +-
 3 files changed, 324 insertions(+), 119 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4159384821..7b1cc56cd73 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -395,7 +395,7 @@ struct bpf_reference_state {
 struct bpf_retval_range {
 	s32 minval;
 	s32 maxval;
-	bool return_32bit;
+	u32 return_32bit;	/* no padding, see bpf_same_join_key() */
 };
 
 /*
@@ -457,6 +457,8 @@ struct loop_stack_entry {
  */
 struct bpf_func_state {
 	struct bpf_reg_state regs[MAX_BPF_REG];
+	/* equal in states that have a join, see bpf_same_join_key() */
+	struct_group(join_key,
 	/* index of call instruction that called into this func */
 	int callsite;
 	/* stack frame number of this function state from pov of
@@ -464,32 +466,36 @@ struct bpf_func_state {
 	 * 0 = main function, 1 = first callee.
 	 */
 	u32 frameno;
-	/*
-	 * Unique diagnostic identity for this function invocation. Frame depth is
-	 * reused after returns, while this ID is preserved across state clones.
-	 */
-	u32 diag_frame_id;
-	/* parent_id of the args that are gone when this frame returns */
-	u32 frame_id;
 	/* subprog number == index within subprog_info
 	 * zero == main subprog
 	 */
 	u32 subprogno;
 	/*
-	 * The frame of an async callback has the count of frame 0 of the state
-	 * that sets the callback plus one. Frames that differ in it are not joined.
+	 * What was held at the entry of the frame and is still held. For references these are
+	 * the first entry_refs of refs[]. What is released and acquired again does not count.
+	 * This frame must release all the rest.
 	 */
-	u32 async_entry_cnt;
+	u32 entry_refs;
+	u32 entry_rcu_locks;
+	u32 entry_preempt_locks;
 	struct bpf_retval_range callback_ret_range;
 	bool in_callback_fn;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
-	bool no_stack_arg_load;
 	/*
 	 * The helper invokes this callback under rcu_read_lock(), so the
 	 * callback and its callees run in an RCU read-side critical section.
 	 */
 	bool in_rcu_callback_fn;
+	/* parent_id of the args that are gone when this frame returns */
+	u32 frame_id;
+	);
+	bool no_stack_arg_load;
+	/*
+	 * Unique diagnostic identity for this function invocation. Frame depth is
+	 * reused after returns, while this ID is preserved across state clones.
+	 */
+	u32 diag_frame_id;
 	/* For callback calling functions that limit number of possible
 	 * callback executions (e.g. bpf_loop) keeps track of current
 	 * simulated iteration number.
@@ -508,14 +514,6 @@ struct bpf_func_state {
 	 * subprogram (loops never cross subprogram boundaries).
 	 */
 	u32 loop_stack_cnt;
-	/*
-	 * How much of what was held when the frame was entered is held ever since. For
-	 * references that is the first entry_refs of refs[]. What is released and taken again
-	 * doesn't count. More than that is for this frame to release.
-	 */
-	u32 entry_refs;
-	u32 entry_rcu_locks;
-	u32 entry_preempt_locks;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -565,7 +563,7 @@ struct bpf_verifier_state {
 	/* Acquired reference states */
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
-	u32 curframe;
+	bool speculative;
 	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
 	bool infeasible;
 	/* an error only in a leftover, see check_held_in_leftover() */
@@ -574,6 +572,8 @@ struct bpf_verifier_state {
 	/* the loops that made an xreg of data_deps imprecise, see bpf_loop.suspect_bit */
 	u64 suspect_loops;
 
+	/* equal in states that have a join, see bpf_same_join_key(). No holes. */
+	struct_group(join_key,
 	struct_group(held,
 	void *active_lock_ptr;
 	u32 acquired_refs;
@@ -582,9 +582,8 @@ struct bpf_verifier_state {
 	u32 active_rcu_locks;
 	u32 active_irq_id;
 	u32 active_lock_id;
-
-	bool speculative;
 	);
+	u32 curframe;
 	bool in_sleepable;
 	/* a global function or an extension, and what it calls: exit of frame 0 is not the end */
 	bool callers_unknown;
@@ -600,6 +599,9 @@ struct bpf_verifier_state {
 	 * state at its entry came from, see bpf_flow_call().
 	 */
 	u32 flow_entry;
+	);
+	/* Not zero in a function that is verified on its own, see bpf_flow_call() */
+	u32 instance_id;
 
 	/* The insn that the state comes from, -1 if no instructions have been executed yet. */
 	u32 last_insn_idx;
@@ -654,6 +656,16 @@ static inline bool bpf_stack_args_are_incoming(const struct bpf_func_state *fram
 	return !frame->frameno && !frame->no_stack_arg_load;
 }
 
+/* Stack argument @i of @frame to compare with @other or NULL: incoming ones are not outgoing */
+static inline const struct bpf_reg_state *
+bpf_stack_arg(const struct bpf_func_state *frame, const struct bpf_func_state *other, u32 i)
+{
+	if (i >= frame->out_stack_arg_cnt ||
+	    (bpf_stack_args_are_incoming(frame) && !bpf_stack_args_are_incoming(other)))
+		return NULL;
+	return &frame->stack_arg_regs[i];
+}
+
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled register. */
 #define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
 	for (iter = 0, reg = bpf_get_spilled_reg(iter, frame, mask);		\
@@ -1190,6 +1202,16 @@ static inline bool bpf_id_is_xreg(u32 id)
 	return id & 2;
 }
 
+/* pointers to the packet with id @old are those with id @cur moved by @delta */
+struct bpf_pkt_pair {
+	u32 old;
+	u32 cur;
+	u64 delta;
+	/* for a join */
+	u32 type;
+	u32 id;
+};
+
 struct bpf_idmap {
 	u32 cnt;
 	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
@@ -1289,6 +1311,7 @@ struct bpf_verifier_env {
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
+	u64 hash_seed;			/* see bpf_hash_join_key() */
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
 	bool no_mem;			/* a table cannot grow, see bpf_check_limits() */
@@ -1363,6 +1386,8 @@ struct bpf_verifier_env {
 	} *callx_edges;
 	struct bpf_index callx_index;
 	struct bpf_idmap idmap_scratch;
+	struct bpf_pkt_pair *pkt_pairs;	/* of the two states that are compared or joined */
+	u32 pkt_pair_cnt, pkt_pair_cap;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1593,9 +1618,15 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 
 int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
-bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
-			struct bpf_verifier_state *cur);
-
+bool bpf_add_pkt_pair(struct bpf_verifier_env *env, const struct bpf_pkt_pair *pair);
+bool bpf_state_subsumes(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			const struct bpf_verifier_state *cur);
+bool bpf_scalar_subsumes(const struct bpf_reg_state *old, const struct bpf_reg_state *cur);
+bool bpf_same_type_and_object(struct bpf_verifier_env *env, const struct bpf_reg_state *a,
+			      const struct bpf_reg_state *b);
+bool bpf_same_join_key(const struct bpf_verifier_state *a, const struct bpf_verifier_state *b);
+u64 bpf_hash64(const void *p, size_t len, u64 hash);
+u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
 int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
 /*
@@ -1696,7 +1727,7 @@ static inline struct bpf_func_state *bpf_func(struct bpf_verifier_env *env,
 }
 
 /* Return IP for a given frame in a call stack */
-static inline u32 bpf_frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+static inline u32 bpf_frame_insn_idx(const struct bpf_verifier_state *st, u32 frame)
 {
 	return frame == st->curframe
 	       ? st->insn_idx
@@ -2349,12 +2380,25 @@ static inline u8 bpf_signed_opcode(u8 op)
 	return op == BPF_JGT || op == BPF_JGE ? op + BPF_JSGT - BPF_JGT : op;
 }
 
+/* True if pkt_bytes_left() is valid */
+static inline bool pkt_has_bytes_left(const struct bpf_reg_state *reg)
+{
+	return reg->range >= 0 && reg_smin(reg) >= -MAX_PACKET_OFF &&
+	       reg_smax(reg) <= MAX_PACKET_OFF;
+}
+
 /* How many bytes are checked from the start of the packet, wherever the pointer is */
 static inline int pkt_min_len(const struct bpf_reg_state *reg)
 {
 	return reg->r64.size ? reg->pkt_min_len : max(reg->range, reg->pkt_min_len);
 }
 
+/* How many bytes are checked after a pointer to the packet */
+static inline s64 pkt_bytes_left(const struct bpf_reg_state *reg)
+{
+	return reg->range - reg_smax(reg);
+}
+
 /* The loop that the frame is in, or NULL */
 static inline struct loop_stack_entry *bpf_top_loop(const struct bpf_func_state *frame)
 {
@@ -2370,4 +2414,11 @@ static inline u32 bpf_xreg_cnt(const struct bpf_verifier_state *st)
 	return nr;
 }
 
+static inline bool bpf_slot_is_held(const struct bpf_stack_state *slot)
+{
+	u8 t = slot->slot_type[BPF_REG_SIZE - 1];
+
+	return t == STACK_DYNPTR || t == STACK_ITER || t == STACK_IRQ_FLAG;
+}
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index bb8fa008a8a..174b1a613fb 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -4,6 +4,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/cnum.h>
 #include <linux/filter.h>
+#include <linux/siphash.h>
 
 /* check %cur's range satisfies %old's */
 static bool range_within(const struct scalar *old, const struct scalar *cur)
@@ -39,6 +40,11 @@ bool scalar_subsumes(const struct scalar *old, const struct scalar *cur)
 	return range_within(old, cur) && tnum_in(old->var_off, cur->var_off);
 }
 
+bool bpf_scalar_subsumes(const struct bpf_reg_state *old, const struct bpf_reg_state *cur)
+{
+	return scalar_subsumes(scalar_of(old), scalar_of(cur));
+}
+
 static void renumber_id(struct bpf_verifier_env *env, u32 *id, u32 new_id)
 {
 	struct bpf_idmap *map = &env->idmap_scratch;
@@ -116,6 +122,51 @@ int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 	return -E2BIG;
 }
 
+bool bpf_add_pkt_pair(struct bpf_verifier_env *env, const struct bpf_pkt_pair *pair)
+{
+	if (!bpf_grow_array(env, &env->pkt_pairs, &env->pkt_pair_cap, env->pkt_pair_cnt + 1,
+			    sizeof(*pair)))
+		return false;
+	env->pkt_pairs[env->pkt_pair_cnt++] = *pair;
+	return true;
+}
+
+/* Packet pointers that share an id in the old state share one in the new state, as far apart */
+static bool check_pkt_ids(struct bpf_verifier_env *env, const struct bpf_reg_state *rold,
+			  const struct bpf_reg_state *rcur)
+{
+	struct bpf_pkt_pair pair = { rold->id, rcur->id, rcur->r64.base - rold->r64.base };
+	const struct bpf_pkt_pair *p = env->pkt_pairs;
+
+	if (!rold->id)
+		return !rcur->id;
+	bpf_add_cost(env, env->pkt_pair_cnt, BPF_COST_SCAN);
+	for (; p < env->pkt_pairs + env->pkt_pair_cnt; p++)
+		if (p->old == pair.old)
+			return p->cur == pair.cur && p->delta == pair.delta;
+	return bpf_add_pkt_pair(env, &pair);
+}
+
+/*
+ * The bytes that are checked for @rold are checked for @rcur. This matters even if the range
+ * is below the offset: the program can move the pointer back.
+ */
+static bool pkt_range_safe(const struct bpf_reg_state *rold, const struct bpf_reg_state *rcur)
+{
+	if (pkt_min_len(rold) > pkt_min_len(rcur))
+		return false;
+	/* the range tells no more than pkt_min_len() */
+	if (!rold->range || rold->range == pkt_min_len(rold))
+		return true;
+	/* AT_PKT_END or BEYOND_PKT_END */
+	if (rold->range < 0 || rcur->range < 0)
+		return rold->range == rcur->range;
+	if (pkt_has_bytes_left(rold) && pkt_has_bytes_left(rcur))
+		return pkt_bytes_left(rold) <= pkt_bytes_left(rcur);
+	return rold->range <= rcur->range && rold->r64.base == rcur->r64.base &&
+	       rold->r64.size == rcur->r64.size;
+}
+
 static void __clean_func_state(struct bpf_verifier_env *env,
 			       struct bpf_func_state *st,
 			       u16 live_regs, int frame)
@@ -228,6 +279,50 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 	return bpf_renumber_ids(env, st);
 }
 
+/*
+ * Values of one type and object differ only in a number: the value of a scalar, the offset
+ * of a pointer.
+ *
+ * Types have to match exactly, including their modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc).
+ * A pointer is not a number: numbers are allowed to leak while pointers are not. A pointer is
+ * not its MAYBE_NULL variant: a NULL check changes all xregs with the same id.
+ */
+bool bpf_same_type_and_object(struct bpf_verifier_env *env, const struct bpf_reg_state *a,
+			      const struct bpf_reg_state *b)
+{
+	if (a->type != b->type)
+		return false;
+	if (a->type == SCALAR_VALUE || a->type == NOT_INIT || type_is_pkt_pointer(a->type) ||
+	    base_type(a->type) == PTR_TO_ARENA)
+		return true;
+	if (!reg_object_equal(a, b))
+		return false;
+	/* Only what an insn can make: see check_stack_access_for_ptr_arithmetic() */
+	if (bpf_reg_has_range(a) && (a->type != PTR_TO_STACK || env->bypass_spec_v1))
+		return true;
+	return scalar_equal(scalar_of(a), scalar_of(b));
+}
+
+/* Returns true if (rold safe implies rcur safe) */
+static bool regsafe(struct bpf_verifier_env *env, const struct bpf_reg_state *rold,
+		    const struct bpf_reg_state *rcur)
+{
+	bpf_add_cost(env, 1, BPF_COST_XREG);
+	if (rold->type == NOT_INIT)
+		/* nothing can be done with it */
+		return true;
+	if (!rcur || !bpf_same_type_and_object(env, rold, rcur))
+		return false;
+	/* The offset is not tracked. */
+	if (base_type(rold->type) == PTR_TO_ARENA)
+		return true;
+	if (type_is_pkt_pointer(rold->type) &&
+	    (!pkt_range_safe(rold, rcur) || !check_pkt_ids(env, rold, rcur)))
+		return false;
+	/* new val must satisfy old val knowledge */
+	return bpf_scalar_subsumes(rold, rcur);
+}
+
 static struct bpf_reg_state unbound_reg;
 
 static __init int unbound_reg_init(void)
@@ -272,7 +367,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
+		      struct bpf_func_state *cur)
 {
 	int i, spi;
 
@@ -287,6 +382,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		int im = i % BPF_REG_SIZE;
 		u8 old_type;
 
+		bpf_add_cost(env, 1, BPF_COST_SCAN);
 		spi = i / BPF_REG_SIZE;
 		old_slot = bpf_stack_slot(old, spi);
 		old_type = old_slot->slot_type[im];
@@ -295,6 +391,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old_type == STACK_INVALID || old_type == STACK_POISON)
 			continue;
 
+		/* it can be filled into a register that is unreadable */
+		if (old_type == STACK_SPILL && old_slot->spilled_ptr.type == NOT_INIT &&
+		    (env->allow_uninit_stack ||
+		     (cur_slot && cur_slot->slot_type[im] != STACK_INVALID &&
+		      cur_slot->slot_type[im] != STACK_POISON)))
+			continue;
+
 		if (env->allow_uninit_stack && old_type == STACK_MISC)
 			continue;
 
@@ -320,7 +423,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = scalar_reg_for_stack(env, old_slot, im);
 			cur_reg = scalar_reg_for_stack(env, cur_slot, im);
 			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap))
+				if (!regsafe(env, old_reg, cur_reg))
 					return false;
 				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
 				continue;
@@ -331,7 +434,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		 * it will be safe with zero-initialized stack.
 		 * The opposite is not true
 		 */
-		if (old_type == STACK_MISC && cur_slot->slot_type[im] == STACK_ZERO)
+		if (old_type == STACK_MISC &&
+		    (cur_slot->slot_type[im] == STACK_ZERO ||
+		     is_spilled_scalar_after(cur_slot, im)))
+			continue;
+		if (old_type == STACK_ZERO && is_spilled_scalar_after(cur_slot, im) &&
+		    bpf_register_is_null(&cur_slot->spilled_ptr))
 			continue;
 		if (old_type != cur_slot->slot_type[im])
 			/*
@@ -355,34 +463,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -16}
 			 * such verifier states are not equivalent.
 			 */
-			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr, idmap))
+			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr))
 				return false;
 			break;
 		case STACK_DYNPTR:
-			old_reg = &old_slot->spilled_ptr;
-			cur_reg = &cur_slot->spilled_ptr;
-			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
-			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
-			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
-				return false;
-			break;
 		case STACK_ITER:
-			old_reg = &old_slot->spilled_ptr;
-			cur_reg = &cur_slot->spilled_ptr;
-			if (old_reg->type != cur_reg->type ||
-			    old_reg->iter.btf != cur_reg->iter.btf ||
-			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
-			    old_reg->iter.state != cur_reg->iter.state ||
-			    old_reg->iter.loops != cur_reg->iter.loops ||
-			    !check_ids(old_reg->id, cur_reg->id, idmap))
-				return false;
-			break;
 		case STACK_IRQ_FLAG:
-			old_reg = &old_slot->spilled_ptr;
-			cur_reg = &cur_slot->spilled_ptr;
-			if (!check_ids(old_reg->id, cur_reg->id, idmap) ||
-			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
+			if (!reg_object_equal(&old_slot->spilled_ptr, &cur_slot->spilled_ptr))
 				return false;
 			break;
 		case STACK_MISC:
@@ -398,6 +485,114 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 	return true;
 }
 
+static const struct bpf_stack_state *held_slot(const struct bpf_func_state *f, u32 i)
+{
+	return i < bpf_stack_nr_slots(f) && bpf_slot_is_held(bpf_stack_slot(f, i)) ?
+	       bpf_stack_slot(f, i) : NULL;
+}
+
+static bool same_refs(const struct bpf_verifier_state *a, const struct bpf_verifier_state *b)
+{
+	u32 i;
+
+	for (i = 0; i < a->acquired_refs; i++)
+		if (a->refs[i].type != b->refs[i].type || a->refs[i].id != b->refs[i].id ||
+		    memcmp(&a->refs[i].ptr, &b->refs[i].ptr, sizeof(u64)))
+			return false;
+	return true;
+}
+
+/*
+ * The join_key of a state is what has no join:
+ * - what is held: references, locks, dynptrs, iterators, irq flags
+ * - the call chain and the instance
+ * - the peeled trip
+ */
+bool bpf_same_join_key(const struct bpf_verifier_state *a, const struct bpf_verifier_state *b)
+{
+	const struct bpf_stack_state *sa, *sb;
+	const struct loop_stack_entry *ea, *eb;
+	const struct bpf_func_state *fa, *fb;
+	u32 fr, i;
+
+	if (memcmp(&a->join_key, &b->join_key, sizeof(a->join_key)) ||
+	    a->instance_id != b->instance_id || !same_refs(a, b))
+		return false;
+	for (fr = 0; fr <= a->curframe; fr++) {
+		fa = a->frame[fr];
+		fb = b->frame[fr];
+		if (memcmp(&fa->join_key, &fb->join_key, sizeof(fa->join_key)) ||
+		    fa->loop_stack_cnt != fb->loop_stack_cnt)
+			return false;
+		for (i = 0; i < fa->loop_stack_cnt; i++) {
+			ea = &fa->loop_stack[i];
+			eb = &fb->loop_stack[i];
+			if (ea->loop != eb->loop || ea->peeled != eb->peeled ||
+			    (ea->peeled && ea->trip != eb->trip))
+				return false;
+		}
+		for (i = 0; i < max(bpf_stack_nr_slots(fa), bpf_stack_nr_slots(fb)); i++) {
+			sa = held_slot(fa, i);
+			sb = held_slot(fb, i);
+			if (!sa != !sb || (sa && (sa->slot_type[0] != sb->slot_type[0] ||
+						  !reg_object_equal(&sa->spilled_ptr,
+								    &sb->spilled_ptr))))
+				return false;
+		}
+	}
+	return true;
+}
+
+u64 bpf_hash64(const void *p, size_t len, u64 hash)
+{
+	siphash_key_t key = {{ hash }};
+
+	return siphash(p, len, &key);
+}
+
+/*
+ * The hash of the join_key and of the insn. The seed is random, so a program cannot select
+ * states that collide. Only a collision can change a result.
+ */
+u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	u64 hash = bpf_hash64(&st->join_key, sizeof(st->join_key), env->hash_seed +
+			      ((u64)st->instance_id << 32 | st->insn_idx));
+	u32 fr, i, trip;
+	const struct bpf_stack_state *slot;
+	const struct loop_stack_entry *e;
+	const struct bpf_func_state *f;
+
+	for (i = 0; i < st->acquired_refs; i++)
+		hash = bpf_hash64(&st->refs[i].ptr, sizeof(u64), hash + st->refs[i].type);
+	for (fr = 0; fr <= st->curframe; fr++) {
+		f = st->frame[fr];
+		hash = bpf_hash64(&f->join_key, sizeof(f->join_key), hash);
+		for (i = 0, e = f->loop_stack; i < f->loop_stack_cnt; i++, e++) {
+			trip = e->peeled ? e->trip : -1;
+			hash = bpf_hash64(&trip, sizeof(trip), hash);
+		}
+		for (i = 0; i < bpf_stack_nr_slots(f); i++) {
+			slot = held_slot(f, i);
+			if (!slot)
+				continue;
+			hash = bpf_hash64(&slot->spilled_ptr,
+					  offsetof(struct bpf_reg_state, var_off), hash + i);
+		}
+	}
+	return hash;
+}
+
+static bool loop_stack_safe(struct bpf_func_state *old, struct bpf_func_state *cur)
+{
+	u32 i;
+
+	for (i = 0; i < old->loop_stack_cnt; i++)
+		if (!trip_index_safe(&old->loop_stack[i], &cur->loop_stack[i]))
+			return false;
+	return true;
+}
+
 /* compare two verifier states
  *
  * The state that gets to an insn doesn't have to be looked at when there is
@@ -418,56 +613,30 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 	u16 i;
 
-	if (old->callback_depth > cur->callback_depth)
-		return false;
-
-	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
-		return false;
-
-	if (memcmp(&old->callback_ret_range, &cur->callback_ret_range,
-		   sizeof(old->callback_ret_range)))
-		return false;
-
-	if (old->in_rcu_callback_fn != cur->in_rcu_callback_fn)
-		return false;
-
-	/* what the frame did to what its callers hold is a part of what it tells them */
-	if (old->entry_refs != cur->entry_refs ||
-	    old->entry_rcu_locks != cur->entry_rcu_locks ||
-	    old->entry_preempt_locks != cur->entry_preempt_locks)
-		return false;
-
-	if (!check_ids(old->frame_id, cur->frame_id, &env->idmap_scratch))
+	if (old->callback_depth > cur->callback_depth ||
+	    (!old->no_stack_arg_load && cur->no_stack_arg_load) ||
+	    !loop_stack_safe(old, cur))
 		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
-		if (((1 << i) & live_regs) &&
-		    !regsafe(env, &old->regs[i], &cur->regs[i], &env->idmap_scratch))
+		if ((live_regs & BIT(i)) && !regsafe(env, &old->regs[i], &cur->regs[i]))
 			return false;
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch))
-		return false;
-
-	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch))
-		return false;
-
-	if (!loop_stack_safe(env, old, cur))
-		return false;
+	/* outgoing stack args are a part of the state and must agree */
+	for (i = 0; i < old->out_stack_arg_cnt; i++)
+		if (!regsafe(env, &old->stack_arg_regs[i], bpf_stack_arg(cur, old, i)))
+			return false;
 
-	return true;
+	return stacksafe(env, old, cur);
 }
 
-/* Everything that @cur describes is described by @old. */
-bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
-			struct bpf_verifier_state *cur)
+/* @old describes all that @cur describes. They have the same join_key. */
+bool bpf_state_subsumes(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			const struct bpf_verifier_state *cur)
 {
-	u32 insn_idx;
 	int i;
 
-	if (old->curframe != cur->curframe)
-		return false;
-
-	reset_idmap_scratch(env);
+	env->pkt_pair_cnt = 0;
 
 	/* Verification state from speculative execution simulation
 	 * must never stand for a non-speculative execution one.
@@ -475,28 +644,10 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 	if (old->speculative && !cur->speculative)
 		return false;
 
-	if (old->callers_unknown != cur->callers_unknown)
-		return false;
-
-	if (old->in_sleepable != cur->in_sleepable)
-		return false;
-
-	if (old->unwound != cur->unwound || old->changed_pkt_data != cur->changed_pkt_data)
-		return false;
-
-	if (!refsafe(old, cur, &env->idmap_scratch))
-		return false;
-
-	/* for states to be equal callsites have to be the same
-	 * and all frame states need to be equivalent
-	 */
-	for (i = 0; i <= old->curframe; i++) {
-		insn_idx = bpf_frame_insn_idx(old, i);
-		if (old->frame[i]->callsite != cur->frame[i]->callsite)
-			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx))
+	for (i = 0; i <= old->curframe; i++)
+		if (!func_states_equal(env, old->frame[i], cur->frame[i],
+				       bpf_frame_insn_idx(old, i)))
 			return false;
-	}
 
 	return true;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cfcb20dda5e..01c492e0242 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -29,6 +29,7 @@
 #include <linux/keyctl.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
+#include <linux/random.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/cnum.h>
@@ -1816,16 +1817,12 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 		return err;
 	bpf_add_cost(env, bpf_xreg_cnt(src) + src->acquired_refs, BPF_COST_COPY);
 	dst_state->speculative = src->speculative;
-	dst_state->in_sleepable = src->in_sleepable;
-	dst_state->callers_unknown = src->callers_unknown;
-	dst_state->unwound = src->unwound;
-	dst_state->changed_pkt_data = src->changed_pkt_data;
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->infeasible = src->infeasible;
 	dst_state->max_held_cnt = src->max_held_cnt;
 	dst_state->suspect_loops = src->suspect_loops;
+	dst_state->join_key = src->join_key;
 	dst_state->insn_idx = src->insn_idx;
-	dst_state->curframe = src->curframe;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -3796,6 +3793,11 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	max_off = reg_smax(ptr_reg) + off + size;
 	if (value_regno >= 0)
 		value_reg = &cur->regs[value_regno];
+	/* no slot remembers the pointer, a load gets it as a number */
+	if (value_reg && __is_pointer_value(env->allow_ptr_leaks, value_reg)) {
+		verbose(env, "R%d leaks addr into stack\n", value_regno);
+		return -EACCES;
+	}
 	if ((value_reg && bpf_register_is_null(value_reg)) ||
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
@@ -11418,7 +11420,6 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		if (is_async_cb_sleepable(env, insn))
 			env->sleepable_async_cb = true;
 		callee = async_cb->frame[0];
-		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
 		/* Convert bpf_timer_set_callback() args into timer callback args */
 		err = set_callee_state_cb(env, caller, callee, insn_idx);
@@ -24736,6 +24737,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->max_cost = BPF_MAX_COST >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
 	env->pass_max_cost = U64_MAX;
 	env->max_mem = BPF_MAX_MEM >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
+	env->hash_seed = get_random_u64();
 	env->signature = attr->signature;
 
 	/* user could have requested verbose verifier output
@@ -25083,6 +25085,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	kvfree(env->pkt_pairs);
 	kvfree(env->callx_edges);
 	kvfree(env->callx_index.slots);
 	kvfree(env->func_ptrs);
-- 
2.55.0

