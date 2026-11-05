Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911665;
	b=xhfRc3huzDhW1OB1dNif+2KZzNqoWjluxAHrsdCi5cjMS/lszT7mzum33rIlro05Qytu
	 n6dsGjuBHCsRRpEu1AxzKxp8xPl3EwATOO+KJIZV+LPDRITbvPvDnPXH3g19Baxj60W6f
	 tTpW/4OmB0hdEJcuOjpp1dbVR290Qt/8ZKz/VKABhpyjD5hU996Y5r6htRTgyOXeY3nE0
	 uanUwRvWdoBixi+k2QTiEq4QyQV6KsqzcXETxbpjLvPsqfN8GKqoaFSvdMmwMprzKHl8h
	 +thZ+anhhZ8py2AZ8fTMdSM140YfjPAVz9zeL+SVzIfWTY5allbfMQgt3fczgM9Kkrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aYiKKzULMRKz15hQTwZsmEe3peDHG4+vs4jIT0qMPIg=;
	b=5mu9oD6r3bj0gIv6gsDKSqsc74ng/Cht9S3MbV8y3j459Xer+AeHr+CNW825/kaA5W8k
	 yqeRDpdiPx8UnOTIsK0CXc6sadrNQ1IZg5SSFSgRBjLZ27VFZK+aU+sm1h5894t2xje4K
	 +R8kkb42GT0P6XUQndcORDcGOo9s8KFO8a3a87UdboWiqjJejKACpgPFBfej4TB+CeQ+v
	 S/JVN53C3rh/xLPGBJRYCWhpdDZ8I9A81+h8zPha1HTQou7+q1PHfnevAE/4Wn4WcR0q/
	 y4n+gnTWTohqFmufZ3btFzJJ4ZBqyRO91Gci0L9IGJl/WK2CX14YhDx9hBaaipsoX3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVESmzBn;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DA606A330
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 340DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVESmzBn
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1077941a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911665; x=1794516465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYiKKzULMRKz15hQTwZsmEe3peDHG4+vs4jIT0qMPIg=;
        b=WVESmzBnqd8UxyTULfwKfl+q0XzC9wux6qrBflqgEya2MHDDhS2YQraNb2rtZLPgFw
         omy8MNt9b2rEt43MefTeMuJGpFpAVmUrA9NYDA2ShESL9U+M6E20o8Tnod6s70KrxSA8
         ywYuRAVigdgGvzheQx8yKQD7ITOdvYO1k/PzaOD3wF8+8ce3aV/t1nSkLylPmFpT9v0J
         mzQ+NDNL1y26eiwLxMGF3erSTbG4CnJjPxGgR+MM8X+2hM3k2M7O7bdxZxIx96vxNsku
         Y26VvrJI1FkVm2gZgcHllYLqpSpzP6j2ttX+UQ9F+yQy6zRX9YqVrdR0bNQq0wlJs4IG
         /c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911665; x=1794516465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYiKKzULMRKz15hQTwZsmEe3peDHG4+vs4jIT0qMPIg=;
        b=VDEGwZyaNyYR/ar53xicCfd6NFFC+18RzyDGZYo27zA2O+FlEg3buUaDZD/llSFB8f
         FL9r8JYj+rdUg0xj5v8ZTiCPxuIJ9dZa8Ra/OEkplNm0invknuEre0gYgugmae98S5wv
         DwEOhA3FvfTwbjzcBokrW7GW12h+vSBnLXUvhVQJr35bBmQSQfMBxhz9s4jXXBzkj7Q7
         vknJFskADF5BoavOcllDAQgsK31s5wrPhZVZ3T/kbel6voa6W6OIHzNzdMjwqgHup8h4
         t/I/Xy5V7BQ2tcyBIbEl2XP9zEiQW5zEhycNW4K4TcrFMCumUf5dBEbtXjMzEdX8QwfV
         9/iQ==
X-Gm-Message-State: APuU4Z+OmOoHbOmLPOeyl0tzg16tYuWpjrh9NV5+DzHToobtY7AYujcn
	/oEudQyLHn3NsgGLpMNIy6RKbz9ZbPfFZeqENmgWBXo56H9y7Ck0f0Ffy0QuZw==
X-Gm-Gg: AYBFou0eL76fAeUklccMcp5ArZhwFi06A5EIbNEroW8I6ExXOuI1xbgfkIQSxpv5MAY
	4D2oDChHU7O6EwxYhZ7MkoDvNy8hL6T00d4zg3wuJ5npnmHOqEWNDtwBs6nKgn7RFmmL547VHCA
	fgOHM3nQ7Mz7Skzdm2txYW8c3fkbXUSIPKZysWrQpxyki+z3KFiR9rA9rjgzh7dSTlH2ax1Ob7Z
	8sn3Dl0gLNVL8yXctZlgkuID9td3nBfGiRyUIlFeKxmkJY1P0NQOynas6qT2V5TyV5PuvyJASnW
	7O24ablrXxA91IELYLWmD3A32MAs1j+DsefLZXTzhE5EVQEiYkvM0dPQYEGwslsh3e5/Qp9ms5U
	+C8iAbup6/TJ7FB8BNjmKEzJOPJYN53aHUmfcQ+swSPJkH6Bbvlf0f++BT/K5c1j2JVR/2DqWvb
	IWbaJjXLtew1vDb0z/6XkrGDF6+Cdm/U2bRHapR+tJW+678pATJANTgP+511LRoT8uYaiqELXs7
	Uix03C1NL7y9oR+m6pNbWt7RQ7wYr6cffyXkI5XWcDpafMqhxjS1yPBaT8pqu0+hWia2YmmQBRM
	b0Na+dnxuK+butoIE18ao+F3Mzchrldiv9raUVAAjgkTt5zg2YCn8gJ/4k8tHqpNL31VBoc1AGl
	J+tv8DVpCqb42N6taofVco6JmB7phDnDmXGsHeLu0SbjaGpkluPLDw4ShI+mfOS1v8yQvUrscBw
	==
X-Received: by 2002:a17:90b:2b50:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b0db721561mr179315a91.49.1793911664252;
        Thu, 05 Nov 2026 12:47:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7cb249fsm609275a91.15.2026.11.05.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:47:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 25/35] bpf: Remove prune points, levels of state comparison and pop_stack()
Date: Thu,  5 Nov 2026 20:45:02 +0000
Message-ID: <20261105204513.2230344-26-alexei.starovoitov@gmail.com>
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

The old main pass followed each path of a prog depth first and compared
states at selected insns to prune paths. flow.c goes from basic block to
basic block. Three more parts of the old pass have no user.

  removed              task in the old pass       what does it now
  -------------------  -------------------------  -------------------------
  prune_point,         Select the insns at which  States meet at the start
  jmp_point,           the pass saves and         of each basic block.
  force_checkpoint,    compares states.
  is_iter_next
  enum exact_level     Select one of three ways   bpf_state_subsumes() has
                       to compare states.         one way, the way of
                                                  RANGE_WITHIN.
  pop_stack()          Get the next state when    flow_drain() empties the
                       a path ends.               stack after each insn.

NOT_EXACT ignored scalars without a precision mark, and the marks are gone.
EXACT accepted only identical states, for "infinite loop detected", which
is gone too. What RANGE_WITHIN did stays: the range of each live scalar of
the new state is within its range in the old state.

push_stack() stays. The code that verifies an insn uses it to make a second
state, for example for the other branch of a jump. flow_drain() gives these
states to flow.c.

What user space sees:
 - The statistics line shows "processed %d insns (limit 1000000)". The
   verifier limits the number of states, not of processed insns, and
   BPF_COMPLEXITY_LIMIT_INSNS is only the maximum length of a prog.
   veristat and other tools parse the line. Keep the format, print 0.
 - The report of a register that is not readable said
   "R1 has never been initialized on this path". It needs the history of
   the whole path, and the verifier has that of the current basic block.
   The report says that the register may never have been initialized, or
   that an earlier operation may have invalidated it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  4 +++
 include/linux/bpf_verifier.h | 38 --------------------
 kernel/bpf/cfg.c             | 56 ++---------------------------
 kernel/bpf/diagnostics.c     | 13 -------
 kernel/bpf/diagnostics.h     |  1 -
 kernel/bpf/scev.c            |  4 ---
 kernel/bpf/states.c          | 70 ++++++++----------------------------
 kernel/bpf/verifier.c        | 61 ++++++++-----------------------
 8 files changed, 36 insertions(+), 211 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cdf3c9b90987..520fd72e21fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2633,6 +2633,10 @@ struct bpf_array {
  */
 int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
 
+/*
+ * the longest program. The verifier limits the number of states, not of
+ * processed insns, see BPF_FLOW_MAX_STATES.
+ */
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c10c69bf5518..9ab835c23fac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -792,7 +792,6 @@ struct bpf_insn_aux_data {
 	u64 needs_zext:1; /* alu op needs to clear upper bits */
 	u64 prevent_zext:1; /* alu op cannot be zext (already used with 64-bit scalars) */
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
-	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
@@ -823,12 +822,6 @@ struct bpf_insn_aux_data {
 	u64 non_arena_load:1;
 
 	/* below flags are initialized once */
-	u64 jmp_point:1;
-	u64 prune_point:1;
-	/* ensure we check state equivalence and save state checkpoint and
-	 * this instruction, regardless of any heuristics
-	 */
-	u64 force_checkpoint:1;
 	/* true if instruction is a call to a helper function that
 	 * accepts callback function as a parameter.
 	 */
@@ -1157,7 +1150,6 @@ struct bpf_verifier_env {
 	const struct bpf_verifier_ops *ops;
 	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
-	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
@@ -1375,26 +1367,6 @@ void bpf_verbose_snum32(struct bpf_verifier_env *env, s32 num);
 		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
 	})
 
-static inline void mark_prune_point(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].prune_point = true;
-}
-
-static inline bool bpf_is_prune_point(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].prune_point;
-}
-
-static inline void mark_force_checkpoint(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].force_checkpoint = true;
-}
-
-static inline bool bpf_is_force_checkpoint(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].force_checkpoint;
-}
-
 static inline void clear_scalar_id(struct bpf_reg_state *reg)
 {
 	reg->id = 0;
@@ -1411,11 +1383,6 @@ static inline bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx
 	return env->insn_aux_data[insn_idx].calls_callback;
 }
 
-static inline void mark_jmp_point(struct bpf_verifier_env *env, int idx)
-{
-	env->insn_aux_data[idx].jmp_point = true;
-}
-
 static inline void mark_jump_target(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].jump_target = true;
@@ -1586,11 +1553,6 @@ static inline u32 bpf_frame_insn_idx(struct bpf_verifier_state *st, u32 frame)
 	       : st->frame[frame + 1]->callsite;
 }
 
-static inline bool bpf_is_jmp_point(struct bpf_verifier_env *env, int insn_idx)
-{
-	return env->insn_aux_data[insn_idx].jmp_point;
-}
-
 static inline bool bpf_is_spilled_reg(const struct bpf_stack_state *stack)
 {
 	return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 94140d1fe1c3..bbcf42eae9d9 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -130,12 +130,8 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	if (e == BRANCH) {
-		/* mark branch target for state pruning */
-		mark_prune_point(env, w);
-		mark_jmp_point(env, w);
+	if (e == BRANCH)
 		mark_jump_target(env, w);
-	}
 
 	if (insn_state[w] == 0) {
 		/* tree-edge */
@@ -179,13 +175,8 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 	if (ret)
 		return ret;
 
-	mark_prune_point(env, t + insn_sz);
-	/* when we exit from subprog, we need to record non-linear history */
-	mark_jmp_point(env, t + insn_sz);
-
 	if (visit_callee) {
 		w = t + insns[t].imm + 1;
-		mark_prune_point(env, t);
 		merge_callee_effects(env, t, w);
 		ret = push_insn(t, w, BRANCH, env);
 	}
@@ -446,14 +437,12 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		return -E2BIG;
 	}
 
-	mark_prune_point(env, t);
 	for (i = 0; i < jt->cnt; i++) {
 		w = jt->items[i];
 		if (verifier_bug_if(w < 0 || w >= env->prog->len, env,
 				    "indirect jump from insn %d to %d out of range", t, w))
 			return -EFAULT;
 
-		mark_jmp_point(env, w);
 		mark_jump_target(env, w);
 
 		/* EXPLORED || DISCOVERED */
@@ -528,14 +517,11 @@ static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
 	}
 
 	/* all functions are explored, their effects are known */
-	mark_prune_point(env, t);
 	for (i = 0; i < cnt; i++) {
 		w = ptrs[i].xlated_off;
 		merge_callee_effects(env, t, w);
 
-		/* the same marks as push_insn() leaves on a branch target */
-		mark_prune_point(env, w);
-		mark_jmp_point(env, w);
+		/* the same mark as push_insn() leaves on a branch target */
 		mark_jump_target(env, w);
 	}
 	return DONE_EXPLORING;
@@ -599,28 +585,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return DONE_EXPLORING;
 
 	case BPF_CALL:
-		if (bpf_is_async_callback_calling_insn(insn))
-			/* Mark this call insn as a prune point to trigger
-			 * is_state_visited() check before call itself is
-			 * processed by __check_func_call(). Otherwise new
-			 * async state will be pushed for further exploration.
-			 */
-			mark_prune_point(env, t);
 		/* For functions that invoke callbacks it is not known how many times
 		 * callback would be called. Verifier models callback calling functions
 		 * by repeatedly visiting callback bodies and returning to origin call
 		 * instruction.
-		 * In order to stop such iteration verifier needs to identify when a
-		 * state identical some state from a previous iteration is reached.
-		 * Check below forces creation of checkpoint before callback calling
-		 * instruction to allow search for such identical states.
 		 */
-		if (bpf_is_sync_callback_calling_insn(insn)) {
+		if (bpf_is_sync_callback_calling_insn(insn))
 			mark_calls_callback(env, t);
-			mark_force_checkpoint(env, t);
-			mark_prune_point(env, t);
-			mark_jmp_point(env, t);
-		}
 		if (bpf_helper_call(insn)) {
 			const struct bpf_func_proto *fp;
 
@@ -640,21 +611,6 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			struct bpf_call_arg_meta meta;
 
 			ret = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-			if (ret == 0 && bpf_is_iter_next_kfunc(&meta)) {
-				mark_prune_point(env, t);
-				/* Checking and saving state checkpoints at iter_next() call
-				 * is crucial for fast convergence of open-coded iterator loop
-				 * logic, so we need to force it. If we don't do that,
-				 * is_state_visited() might skip saving a checkpoint, causing
-				 * unnecessarily long sequence of not checkpointed
-				 * instructions and jumps, leading to exhaustion of jump
-				 * history buffer, and potentially other undesired outcomes.
-				 * It is expected that with correct open-coded iterators
-				 * convergence will happen quickly, so we don't run a risk of
-				 * exhausting memory.
-				 */
-				mark_force_checkpoint(env, t);
-			}
 			/* Same as helpers, if called in a non-sleepable context
 			 * program will be rejected anyway, so we should end up
 			 * with precise sleepable marks on subprogs, except for
@@ -683,18 +639,12 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		if (ret)
 			return ret;
 
-		mark_prune_point(env, t + off + 1);
-		mark_jmp_point(env, t + off + 1);
 		mark_jump_target(env, t + off + 1);
 
 		return ret;
 
 	default:
 		/* conditional jump with two edges */
-		mark_prune_point(env, t);
-		if (bpf_is_may_goto_insn(insn))
-			mark_force_checkpoint(env, t);
-
 		ret = push_insn(t, t + 1, FALLTHROUGH, env);
 		if (ret)
 			return ret;
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 08e12714bb95..3de3e1486bbd 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -392,13 +392,6 @@ static u32 log_pos(const struct bpf_diag_log *log, u32 idx)
 	return pos < log->cap ? pos : pos - log->cap;
 }
 
-u64 bpf_diag_event_log_save(struct bpf_verifier_env *env)
-{
-	struct bpf_diag *diag = env->diag;
-
-	return diag ? log_end(&diag->log) : 0;
-}
-
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
 {
 	struct bpf_diag *diag = env->diag;
@@ -1357,10 +1350,6 @@ void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int reg
 		diag_reason(
 			env, "R%d is not readable here. A previous operation invalidated this register, so the verifier cannot use it as an input.",
 			regno);
-	else if (log && !log->first_seq)
-		diag_reason(env,
-			    "R%d has never been initialized on this path, so the verifier cannot use it as an input.",
-			    regno);
 	else
 		diag_reason(
 			env, "R%d is not readable here. It may never have been initialized, or an earlier operation may have invalidated it.",
@@ -1375,8 +1364,6 @@ void bpf_diag_unreadable_reg(struct bpf_verifier_env *env, u32 insn_idx, int reg
 	if (invalidated)
 		diag_suggestion(
 			env, "Avoid using the register after it is invalidated, or initialize it again before this instruction.");
-	else if (log && !log->first_seq)
-		diag_suggestion(env, "Initialize R%d on every path before this instruction.", regno);
 	else
 		diag_suggestion(
 			env, "Initialize the register on every path, or initialize it again after any operation that invalidates it.");
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 490decc133f6..e155d2588a51 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -53,7 +53,6 @@ const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __p
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type);
 const char *bpf_diag_arg_type_plain(enum bpf_arg_type type);
-u64 bpf_diag_event_log_save(struct bpf_verifier_env *env);
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos);
 u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
 void bpf_diag_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 9c9a7e2b79f5..da094f769c31 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1803,10 +1803,6 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 						 find_header_env(scev, header));
 	}
 
-	for (i = 0; i < env->prog->len; i++)
-		if (aux[i].loop)
-			aux[i].prune_point = true;
-
 	if (env->log.level & BPF_LOG_LEVEL2) {
 		err = log_scevs(env);
 		if (err)
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5935e16730fd..fb7998654e16 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -198,8 +198,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 	}
 }
 
-static int clean_verifier_state(struct bpf_verifier_env *env,
-				 struct bpf_verifier_state *st)
+int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
 {
 	int i, err;
 
@@ -225,20 +224,10 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 	       check_ids(rold->map_uid, rcur->map_uid, idmap);
 }
 
-enum exact_level {
-	NOT_EXACT,
-	EXACT,
-	RANGE_WITHIN
-};
-
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
-		    enum exact_level exact)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
 {
-	if (exact == EXACT)
-		return regs_exact(rold, rcur, idmap);
-
 	if (rold->type == NOT_INIT)
 		/* explored state can't have used this */
 		return true;
@@ -427,8 +416,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
-		      enum exact_level exact)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
 {
 	int i, spi;
 
@@ -447,18 +435,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		old_type = old_slot->slot_type[im];
 		cur_slot = i < cur->allocated_stack ? bpf_stack_slot(cur, spi) : NULL;
 
-		if (exact == EXACT) {
-			u8 cur_type = cur_slot ? cur_slot->slot_type[im] : STACK_INVALID;
-
-			/* STACK_INVALID and STACK_POISON are equivalent for pruning */
-			if (old_type == STACK_POISON)
-				old_type = STACK_INVALID;
-			if (cur_type == STACK_POISON)
-				cur_type = STACK_INVALID;
-			if (!cur_slot || old_type != cur_type)
-				return false;
-		}
-
 		if (old_type == STACK_INVALID || old_type == STACK_POISON)
 			continue;
 
@@ -481,7 +457,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = scalar_reg_for_stack(env, old_slot, im);
 			cur_reg = scalar_reg_for_stack(env, cur_slot, im);
 			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+				if (!regsafe(env, old_reg, cur_reg, idmap))
 					return false;
 				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
 				continue;
@@ -516,8 +492,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * such verifier states are not equivalent.
 			 * return false to continue verification of this path
 			 */
-			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr,
-				     idmap, exact))
+			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr, idmap))
 				return false;
 			break;
 		case STACK_DYNPTR:
@@ -565,8 +540,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
  * Outgoing stack args are path-local state and must agree for pruning.
  */
 static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
-			   enum exact_level exact)
+			   struct bpf_func_state *cur, struct bpf_idmap *idmap)
 {
 	int i, nslots, cur_cnt = cur->out_stack_arg_cnt;
 
@@ -582,7 +556,7 @@ static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *
 			  &old->stack_arg_regs[i] : &not_init;
 		cur_arg = i < cur_cnt ?
 			  &cur->stack_arg_regs[i] : &not_init;
-		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
+		if (!regsafe(env, old_arg, cur_arg, idmap))
 			return false;
 	}
 
@@ -710,7 +684,7 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx)
 {
 	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 	u16 i;
@@ -736,14 +710,13 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
-		    !regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch, exact))
+		    !regsafe(env, &old->regs[i], &cur->regs[i], &env->idmap_scratch))
 			return false;
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch))
 		return false;
 
-	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch))
 		return false;
 
 	if (!loop_stack_safe(env, old, cur))
@@ -760,10 +733,9 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 	idmap->cnt = 0;
 }
 
-static bool states_equal(struct bpf_verifier_env *env,
-			 struct bpf_verifier_state *old,
-			 struct bpf_verifier_state *cur,
-			 enum exact_level exact)
+/* Everything that @cur describes is described by @old. */
+bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
+			struct bpf_verifier_state *cur)
 {
 	u32 insn_idx;
 	int i;
@@ -798,21 +770,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 		insn_idx = bpf_frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx))
 			return false;
 	}
 
 	return true;
 }
-
-int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	return clean_verifier_state(env, st);
-}
-
-/* Everything that @cur describes is described by @old. */
-bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
-			struct bpf_verifier_state *cur)
-{
-	return states_equal(env, old, cur, RANGE_WITHIN);
-}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9742688c3600..d2ceaa8ce268 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -185,7 +185,10 @@ static bool bpf_global_percpu_ma_set;
  * reference remains at the end of the program, the verifier rejects it.
  */
 
-/* verifier_state + insn_idx are pushed to stack when branch is encountered */
+/*
+ * verifier_state + insn_idx are pushed to stack when branch is encountered.
+ * It's emptied after every insn, see flow_drain().
+ */
 struct bpf_verifier_stack_elem {
 	/* verifier state is 'st'
 	 * before processing instruction 'insn_idx'
@@ -197,9 +200,6 @@ struct bpf_verifier_stack_elem {
 	/* it goes there only if may_goto in front of prev_insn_idx does, see check_loop_guard() */
 	enum bpf_guard_edge guard_edge;
 	struct bpf_verifier_stack_elem *next;
-	/* length of verifier log at the time this state was pushed on stack */
-	u32 log_pos;
-	u64 diag_log_pos;
 };
 
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
@@ -1816,36 +1816,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	return 0;
 }
 
-static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
-		     int *insn_idx, bool pop_log)
-{
-	struct bpf_verifier_state *cur = env->cur_state;
-	struct bpf_verifier_stack_elem *elem, *head = env->head;
-	int err;
-
-	if (env->head == NULL)
-		return -ENOENT;
-
-	if (cur) {
-		err = bpf_copy_verifier_state(cur, &head->st);
-		if (err)
-			return err;
-		bpf_diag_event_log_restore(env, head->diag_log_pos);
-	}
-	if (pop_log)
-		bpf_vlog_reset(&env->log, head->log_pos);
-	if (insn_idx)
-		*insn_idx = head->insn_idx;
-	if (prev_insn_idx)
-		*prev_insn_idx = head->prev_insn_idx;
-	elem = head->next;
-	bpf_free_verifier_state(&head->st, false);
-	kfree(head);
-	env->head = elem;
-	env->stack_size--;
-	return 0;
-}
-
 static bool error_recoverable_with_nospec(int err)
 {
 	/* Should only return true for non-fatal errors that are allowed to
@@ -1873,10 +1843,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
-	elem->log_pos = env->log.end_pos;
-	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
-	env->stack_size++;
 	err = bpf_copy_verifier_state(&elem->st, cur);
 	if (err)
 		return ERR_PTR(-ENOMEM);
@@ -2529,10 +2496,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
-	elem->log_pos = env->log.end_pos;
-	elem->diag_log_pos = bpf_diag_event_log_save(env);
 	env->head = elem;
-	env->stack_size++;
 	/* Unlike push_stack() do not bpf_copy_verifier_state().
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
@@ -15438,7 +15402,6 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return info;
 }
 
-/* insn_aux_data->is_iter_next is not there before the main pass */
 bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	struct bpf_call_arg_meta meta;
@@ -15898,7 +15861,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 	meta.fn = &desc->proto;
 
-	insn_aux->is_iter_next = bpf_is_iter_next_kfunc(&meta);
 
 	if (!insn->off &&
 	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
@@ -21567,7 +21529,6 @@ static int flow_drain(struct bpf_verifier_env *env)
 
 	while ((elem = env->head)) {
 		env->head = elem->next;
-		env->stack_size--;
 		if (!err && elem->guard_edge)
 			err = bpf_flow_guard_edge(env, &elem->st, elem->insn_idx,
 						  elem->prev_insn_idx, elem->guard_edge);
@@ -22876,9 +22837,15 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 
 static void free_states(struct bpf_verifier_env *env)
 {
+	struct bpf_verifier_stack_elem *elem;
+
 	bpf_free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
-	while (!pop_stack(env, NULL, NULL, false));
+	while ((elem = env->head)) {
+		env->head = elem->next;
+		bpf_free_verifier_state(&elem->st, false);
+		kfree(elem);
+	}
 	bpf_flow_reset(env);
 }
 
@@ -23235,10 +23202,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 				env->subprog_info[i].stack_depth);
 		}
 	}
-	/* user space parses this line. There are no read marks. */
-	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
+	/* user space parses this line. There is no limit and there are no read marks. */
+	verbose(env, "processed %d insns (limit 0) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read 0\n",
-		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
+		env->insn_processed,
 		env->max_states_per_insn, env->total_states,
 		env->peak_states);
 }
-- 
2.55.0

