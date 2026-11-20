Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207940;
	b=AH9PV48B9CIT+o+Pu9pAmyOcF+o/6n0wa70+mZSfIYr7Hn8quo5dOenn32a3K0f2B8uA
	 cckDok7QDMQEuFBF+VzHH7uP0Nw0ZeRVRER07XUYo1Njm5uncTZDzrcOXxPCxPCzYd8gO
	 b38LxzL4jemiqKG89NEQemUBsu30JTIPRVE4NTyj3iUmSPLpakaHGmW1N15rRMJfeEAKw
	 M8P05FpvKlqyv5//P6dW/Q5ixbAZCU7CaRYwJAm5KlTODkDWkXfCKJ2DN3ARgj+JX7+Ln
	 kE6jiecVLivC6XTRbkO5mzjD5hJb2hkI0POKAs6HrctyQodM8wRTOmhLBA+Jc5be60g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+asx3XfCeCjBy0YW7q723QFqh2a/s60IK6r+xKuFBqw=;
	b=1yQaS/xWp/VshBE9wqMfwbkqwHmjCQZdehXwdArBa12Ew2bJYGDRjzRwFKpVqTj9illq
	 Zd3oKNgcqCZAwzppUXTGv9F6CsKKfZjEYn90luq5v71NDkOWiPciSTUW5ZTTqZ0IlgPAu
	 5noC6dawSzS3JQlyR91Pl5Zw8D/xInadJqQBOjn+6c7DP5SIyCe5veUcA+ruTsOQwNErV
	 4jB+ZMmthgPppCpIodaBJKF6dvQeutoMR3rekL+EfBd+4Vi/5rSNs/JLkxX8yY6/ruQC9
	 etiLNI55asi/6FPhRt8a0IbcHE3yIaxWY5f93dhav/WOGHXXvxYAOfRTvY1NGLZdnxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBOoyrPO;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0860A2635
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB0860A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBOoyrPO
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso566764a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207928; x=1795812728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+asx3XfCeCjBy0YW7q723QFqh2a/s60IK6r+xKuFBqw=;
        b=FBOoyrPOy4fG+9JoxIAZgsl6V73Tk9cdP0/sEUak0vQ6ZDBCis5MrMXAtKZhYefEAT
         x5fIj0On6sOW/tsi0k+y6UXJOSVz0jp02ZYTnZ6w/12HG9vxCL4fZZYnBNAN6eHgHuXg
         Ne9M/Hy3gXviUxTr9vly8mzyKDjZcLiEglinG8R/o6hdmR7NBWCnRiesNcxweo4MEqbY
         7RbM5nqGNu40OfSR5EBpqjQZ/XX02uR1Q8eLN0UDFG7lDM1okvEckdVaJ/J+DQl7YydM
         awo1SmVNPt7YolujLHf5/iqimYs/9kppq7B6lVfH1g/IlRxk/m3fRKwuQ//aM2eBR7gw
         C3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207928; x=1795812728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+asx3XfCeCjBy0YW7q723QFqh2a/s60IK6r+xKuFBqw=;
        b=qeSTmEvOaZdHdsmplZ1SvhAH2/F1CsjojsJ+hoaykOtTHl86EAp0YMiYlIQ5Vtoz4l
         m36GYQl1Bv5Unj3o2LV+sfb7iUoGEtAi/a2OxBfdvjA5mASGbkM0rz1VrhBZmRVOagEs
         n+iF/IamJwFLhzkrN2UI7rGoUc0cxkQ9ZxSYNEjz1+WF954IywRZJTdXkTZ5Psm9/i8I
         Ba+1y9PIfxh1xcVR78P6ovyEZWwZqcYZBFUyXtWM8/JNRwPJDqGlSETJGLVpyzr2ceHU
         sFiCw/sriD+5y/mLBSI3y1bQFj9OcTxCbU52+MhKUAP9xOBUDuXa22u8E2gKmszYDEdc
         Bi8w==
X-Gm-Message-State: APuU4Z98sDmSOsHBWGr7at6+VnqmMu3YqgRJR50bu76suDm9Sv6NpCJW
	jc2Rht2nbIBAeFYD9ZLgbUkMoDMDie8yr8hqg+1S3YenIvtiq/Km+PXy8oZYlA==
X-Gm-Gg: AZFdTZeMwGs5WFyVt5T7dfSLotu4kHSttiz7Zwle22yuQNDYeqo16UizvM6N+QRaXaJ
	MfCcmZBIVodB69PsET4dXjSZRMeNcrpfESEXqz22c70O0Q1kvzvp2co2RtjsEoinsZGu8EdYH9P
	Qu7xXYO4r0W5aFVss5mS2IfLgSLTVkDwdv4DJq/sckorZVKBIntpKZdg1shnfI2RHSWNZ301IIr
	PZAr4b6FNxlmZRev5C69RwjcIgT/E87quODR5PAfdfZ7p75Kl1TmBt4DLWwd+UkgTQdCqRUWolM
	8kqYMlyU4StRucb8f+Q9B4UaVazHMUJqx5smTXGwd+qbGE6H2osYjPGIDtuhZmURibISLeyHW4h
	w70rmZ4bHkmjGgweRhFZbpnb8rsNHK1j9Te0hmYPyunEjN0ZePYelrSNpoJQ9xHcr5wMlJ/aYbL
	SK+KcxESU8m/J6FjI+ku749Fe/MBwWE/83MwmLUjuscIMWBsXb4+K6mbZzJbS7h0OGxYAgRU4DZ
	niYBC695YddXjBgGmjIpwxfqd7XGwRxDb4eEcoXu8gcqdMDcyhgO/O4RbzijcUnTnDZvfDU6aYP
	/Ot2FOZSorDC4cOqdK8Y9E3qqpY1xqkjnVCN+/cr4KGEzabpYoKkJD4QiaXuiQHpKVXGFcPmqHe
	KMZ8Q2TFOTvveuE90IaOEDnQP51/Mk9UMGfI1/oQ4CQvKFUyx7Z48L7CU7FabcgglYxS0mz52sP
	XTpxLXrPFbNG3asKTfe6I=
X-Received: by 2002:a17:90b:3f0e:b0:3b3:fc1f:a5c1 with SMTP id 98e67ed59e1d1-3b41c8fed40mr3854443a91.28.1795207927319;
        Fri, 20 Nov 2026 12:52:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe16sm5570006a91.17.2026.11.20.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 21/49] bpf: Compare states by join_key, then by value
Date: Fri, 20 Nov 2026 20:49:29 +0000
Message-ID: <20261120204959.614908-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

This replaces check_ids(), regs_exact(), refsafe() and stack_arg_safe().
async_entry_cnt goes away: states of an async callback are joined.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 105 +++++++---
 kernel/bpf/states.c          | 362 ++++++++++++++++++++---------------
 kernel/bpf/verifier.c        |  15 +-
 3 files changed, 292 insertions(+), 190 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e7322f0aece..bded3a774be 100644
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
@@ -486,6 +486,8 @@ static inline bool bpf_loop_walk_may_give_up(const struct loop_stack_entry *entr
  */
 struct bpf_func_state {
 	struct bpf_reg_state regs[MAX_BPF_REG];
+	/* equal in states that have a join, see bpf_same_join_key() */
+	struct_group(join_key,
 	/* index of call instruction that called into this func */
 	int callsite;
 	/* stack frame number of this function state from pov of
@@ -493,32 +495,36 @@ struct bpf_func_state {
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
@@ -537,14 +543,6 @@ struct bpf_func_state {
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
@@ -594,7 +592,7 @@ struct bpf_verifier_state {
 	/* Acquired reference states */
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
-	u32 curframe;
+	bool speculative;
 	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
 	bool infeasible;
 	/* an error only in a leftover, see check_held_in_leftover() */
@@ -603,6 +601,8 @@ struct bpf_verifier_state {
 	/* the loops that made an xreg of data_deps imprecise, see bpf_loop.suspect_bit */
 	u64 suspect_loops;
 
+	/* equal in states that have a join, see bpf_same_join_key(). No holes. */
+	struct_group(join_key,
 	struct_group(held,
 	void *active_lock_ptr;
 	u32 acquired_refs;
@@ -611,9 +611,8 @@ struct bpf_verifier_state {
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
@@ -629,6 +628,9 @@ struct bpf_verifier_state {
 	 * state at its entry came from, see bpf_flow_call().
 	 */
 	u32 flow_entry;
+	);
+	/* Not zero in a function that is verified on its own, see bpf_flow_call() */
+	u32 instance_id;
 
 	/* The insn that the state comes from, -1 if no instructions have been executed yet. */
 	u32 last_insn_idx;
@@ -683,6 +685,16 @@ static inline bool bpf_stack_args_are_incoming(const struct bpf_func_state *fram
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
@@ -1230,6 +1242,16 @@ static inline bool bpf_id_is_xreg(u32 id)
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
@@ -1329,6 +1351,7 @@ struct bpf_verifier_env {
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
+	u64 hash_seed;			/* see bpf_hash_join_key() */
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
 	bool no_mem;			/* a table cannot grow, see bpf_check_limits() */
@@ -1403,6 +1426,8 @@ struct bpf_verifier_env {
 	} *callx_edges;
 	struct bpf_index callx_index;
 	struct bpf_idmap idmap_scratch;
+	struct bpf_pkt_pair *pkt_pairs;	/* of the two states that are compared or joined */
+	u32 pkt_pair_cnt, pkt_pair_cap;
 	struct {
 		int *insn_state;
 		int *insn_stack;
@@ -1633,9 +1658,15 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 
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
 
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
@@ -1745,7 +1776,7 @@ static inline struct bpf_func_state *bpf_func(struct bpf_verifier_env *env,
 }
 
 /* Return IP for a given frame in a call stack */
-static inline u32 bpf_frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
+static inline u32 bpf_frame_insn_idx(const struct bpf_verifier_state *st, u32 frame)
 {
 	return frame == st->curframe
 	       ? st->insn_idx
@@ -2398,12 +2429,25 @@ static inline u8 bpf_signed_opcode(u8 op)
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
@@ -2419,4 +2463,11 @@ static inline u32 bpf_xreg_cnt(const struct bpf_verifier_state *st)
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
index c7630a50e62..fa21a9174f6 100644
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
@@ -116,50 +122,49 @@ int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 	return -E2BIG;
 }
 
-/* If in the old state two registers had the same id, then they need to have
- * the same id in the new state as well.  But that id could be different from
- * the old state, so we need to track the mapping from old to new ids.
- * Once we have seen that, say, a reg with old id 5 had new id 9, any subsequent
- * regs with old id 5 must also have new id 9 for the new state to be safe.  But
- * regs with a different old id could still have new id 9, we don't care about
- * that.
- * So we look through our idmap to see if this old id has been seen before.  If
- * so, we require the new id to match; otherwise, we add the id pair to the map.
- */
-static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
+bool bpf_add_pkt_pair(struct bpf_verifier_env *env, const struct bpf_pkt_pair *pair)
 {
-	struct bpf_id_pair *map = idmap->map;
-	unsigned int i;
-
-	/* either both IDs should be set or both should be zero */
-	if (!!old_id != !!cur_id)
+	if (!bpf_grow_array(env, &env->pkt_pairs, &env->pkt_pair_cap, env->pkt_pair_cnt + 1,
+			    sizeof(*pair)))
 		return false;
+	env->pkt_pairs[env->pkt_pair_cnt++] = *pair;
+	return true;
+}
 
-	if (old_id == 0) /* cur_id == 0 as well */
-		return true;
-
-	for (i = 0; i < idmap->cnt; i++) {
-		if (map[i].old == old_id)
-			return map[i].cur == cur_id;
-		if (map[i].cur == cur_id)
-			return false;
-	}
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
 
-	/* Reached the end of known mappings; haven't seen this id before */
-	if (idmap->cnt < BPF_ID_MAP_SIZE) {
-		map[idmap->cnt].old = old_id;
-		map[idmap->cnt].cur = cur_id;
-		idmap->cnt++;
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
 		return true;
-	}
-
-	/*
-	 * idmap slots are bounded by the number of registers and stack slots.
-	 * Since referenced dynptrs acquire intermediate references that do
-	 * not live in either, so the map can be exhausted. Since it is unlikely,
-	 * fail the verification by treating the states as not equivalent.
-	 */
-	return false;
+	/* AT_PKT_END or BEYOND_PKT_END */
+	if (rold->range < 0 || rcur->range < 0)
+		return rold->range == rcur->range;
+	if (pkt_has_bytes_left(rold) && pkt_has_bytes_left(rcur))
+		return pkt_bytes_left(rold) <= pkt_bytes_left(rcur);
+	return rold->range <= rcur->range && rold->r64.base == rcur->r64.base &&
+	       rold->r64.size == rcur->r64.size;
 }
 
 static void __clean_func_state(struct bpf_verifier_env *env,
@@ -274,54 +279,48 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 	return bpf_renumber_ids(env, st);
 }
 
-static bool regs_exact(const struct bpf_reg_state *rold,
-		       const struct bpf_reg_state *rcur,
-		       struct bpf_idmap *idmap)
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
 {
-	return reg_value_equal(rold, rcur) &&
-	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
-	       check_ids(rold->map_uid, rcur->map_uid, idmap);
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
 }
 
 /* Returns true if (rold safe implies rcur safe) */
-static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
+static bool regsafe(struct bpf_verifier_env *env, const struct bpf_reg_state *rold,
+		    const struct bpf_reg_state *rcur)
 {
+	bpf_add_cost(env, 1, BPF_COST_XREG);
 	if (rold->type == NOT_INIT)
 		/* nothing can be done with it */
 		return true;
-
-	/* Enforce that register types have to match exactly, including their
-	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
-	 * rule.
-	 *
-	 * One can make a point that using a pointer register as unbounded
-	 * SCALAR would be technically acceptable, but this could lead to
-	 * pointer leaks because scalars are allowed to leak while pointers
-	 * are not. We could make this safe in special cases if root is
-	 * calling us, but it's probably not worth the hassle.
-	 *
-	 * Also, register types that are *not* MAYBE_NULL could technically be
-	 * safe to use as their MAYBE_NULL variants (e.g., PTR_TO_MAP_VALUE
-	 * is safe to be used as PTR_TO_MAP_VALUE_OR_NULL, provided both point
-	 * to the same map).
-	 * However, if the old MAYBE_NULL register then got NULL checked,
-	 * doing so could have affected others with the same id, and we can't
-	 * check for that because we lost the id when we converted to
-	 * a non-MAYBE_NULL variant.
-	 * So, as a general rule we don't allow mixing MAYBE_NULL and
-	 * non-MAYBE_NULL registers as well.
-	 */
-	if (rold->type != rcur->type)
+	if (!rcur || !bpf_same_type_and_object(env, rold, rcur))
 		return false;
-
-	switch (base_type(rold->type)) {
-	case PTR_TO_ARENA:
+	/* The offset is not tracked. */
+	if (base_type(rold->type) == PTR_TO_ARENA)
 		return true;
-	default:
-		return regs_exact(rold, rcur, idmap);
-	}
+	if (type_is_pkt_pointer(rold->type) &&
+	    (!pkt_range_safe(rold, rcur) || !check_pkt_ids(env, rold, rcur)))
+		return false;
+	/* new val must satisfy old val knowledge */
+	return bpf_scalar_subsumes(rold, rcur);
 }
 
 static struct bpf_reg_state unbound_reg;
@@ -368,7 +367,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
+		      struct bpf_func_state *cur)
 {
 	int i, spi;
 
@@ -383,6 +382,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		int im = i % BPF_REG_SIZE;
 		u8 old_type;
 
+		bpf_add_cost(env, 1, BPF_COST_SCAN);
 		spi = i / BPF_REG_SIZE;
 		old_slot = bpf_stack_slot(old, spi);
 		old_type = old_slot->slot_type[im];
@@ -391,6 +391,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
 
@@ -416,7 +423,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = scalar_reg_for_stack(env, old_slot, im);
 			cur_reg = scalar_reg_for_stack(env, cur_slot, im);
 			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap))
+				if (!regsafe(env, old_reg, cur_reg))
 					return false;
 				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
 				continue;
@@ -427,7 +434,12 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
@@ -451,34 +463,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
@@ -494,6 +485,104 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
 /* compare two verifier states
  *
  * The state that gets to an insn doesn't have to be looked at when there is
@@ -520,51 +609,25 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
 
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
-		return false;
-
 	for (i = 0; i < MAX_BPF_REG; i++)
-		if (((1 << i) & live_regs) &&
-		    !regsafe(env, &old->regs[i], &cur->regs[i], &env->idmap_scratch))
+		if ((live_regs & BIT(i)) && !regsafe(env, &old->regs[i], &cur->regs[i]))
 			return false;
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch))
-		return false;
-
-	return true;
-}
-
-static void reset_idmap_scratch(struct bpf_verifier_env *env)
-{
-	struct bpf_idmap *idmap = &env->idmap_scratch;
+	/* outgoing stack args are a part of the state and must agree */
+	for (i = 0; i < old->out_stack_arg_cnt; i++)
+		if (!regsafe(env, &old->stack_arg_regs[i], bpf_stack_arg(cur, old, i)))
+			return false;
 
-	idmap->cnt = 0;
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
@@ -572,25 +635,10 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
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
index e0c829745b2..3edc91b8852 100644
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
@@ -1808,16 +1809,12 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
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
@@ -3788,6 +3785,11 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
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
@@ -24790,6 +24791,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->max_cost = BPF_MAX_COST >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
 	env->pass_max_cost = U64_MAX;
 	env->max_mem = BPF_MAX_MEM >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
+	env->hash_seed = get_random_u64();
 	env->signature = attr->signature;
 
 	/* user could have requested verbose verifier output
@@ -25137,6 +25139,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	kvfree(env->pkt_pairs);
 	kvfree(env->callx_edges);
 	kvfree(env->callx_index.slots);
 	kvfree(env->func_ptrs);
-- 
2.55.0

