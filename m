Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6A3431E3
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813381; cv=none; b=iC02tVL+zOigRynSxDiGjbhAArRshE0eWi/q/DuzDC7okkSQyGBcVkaRbMxyDrd2z2yOF2ktQJKbpoYT6XI+yZz+EKLYz42y6d9bCztJg3uOdtRkAtztoMrFGJHgg2NUL7MdFH8491dgjeowNz+eVRBz/2MrE7ZV1lXn48ZhOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813381; c=relaxed/simple;
	bh=Q8mo1LqU3VSujXiSNE+Z8kICEZYP6QMl1+O6wIVVBbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjfH6DymAMJUmFDJACqykdfE24lcZ3GJ+9rkb87ctZqfIZPGcBPCGqo0Bi5JBJyx42o3Rsz4y3yGHRZ8NK4ZCHthtPQErdoEL+1VJKaWo9xOYeffxERjyQHdIeDfCk5egARCgM+fPHER+0yb2uzMjC0U5Dg7Cx7Jptxo7dARE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE3Kuyf+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE3Kuyf+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1244291a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813377; x=1776418177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okyBYVwyREqNIGjWtfOJ+eF/mW7nxvzhooex+GtaLbQ=;
        b=sE3Kuyf+w8n5YbqxyP4sf6EEOVnGjDlNUXvVkuj31hD+Zx99JisD5+zT2Qg876r3/e
         rOyoquyIvO5TGQQHg0ISEVOejvfFTGvPsQVsWu9rYQb6qCX9HcmefWvF+JvhkEmU71CE
         gbiUBLCHNcyKtDbmlo7aZLF00g8VASf0/9Lt1tVQjnLMF46aoEi3IQ3lHnmi2m9svkUk
         9Fu4RPcIOHx+Bg72ExO9XQkmSTSwJNu7eidlkIeKcotJ9bnVafo2bcHrn2lJzcbMJ8tF
         5ZmTxvH9rvzkNt8AIWiE0ruWmtrDLrAu31g2uUGhO1F7GGUGjyBl4mzV3ZUnWCAcyRAH
         mKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813377; x=1776418177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okyBYVwyREqNIGjWtfOJ+eF/mW7nxvzhooex+GtaLbQ=;
        b=MgLAmRGa1cWW4MmQTplOUfgNwmpCrr+IsXRx5jjgplSP49LqN0wKhKaErwa+1/t33g
         KxXG8Mt5c1lHo0hbM2+pfcr4jayPAO6jAuR4QYwJ7w5j4mQdW3uoYtLqC51Elrzhx6wP
         R9J68a6n2yp4i5dZtX9XQeZY/UmR4MNDIU2r0e+SxKEU0Bz7GDsn4BXJEQZAqiKRck4T
         0SdPmkCskvnE4KuhNp/s7BspkvfaTGEGf4lpCBshNex2PQA6Ic98zg2s6YVcUwFDrwlj
         a+ei4vRFCUXsEXXzynnkt13Gq7Sgu+Vyr1qPhXZILlFWJswbIbi70vGJj2SEMecEn6t9
         MGgA==
X-Gm-Message-State: AOJu0Yzrw6ydn+70ZsFjAogu87rAf8nF6wW9J813BVI/+T+J96a0/iTM
	2jAfu050sKVAS+GVYeFycQIVgYdb12CFtJ5BAOwX7cFFJS5xRt455IeSrzqQ61oa
X-Gm-Gg: AeBDietAFRswHK8GhJshiw6U4WYjXzSeefqCImLWrG4mcECeUAtKXlg9Wkak3PSTNQv
	orUWETk17fBfBMUBpjqhNE34B/bO6eu+bXWq8QGaR8njyAXFormzlm5rfbtxuL3cKM11lVN5E7W
	gKxE+8nlmOPt+LPxujLwUS7KLrVJ490s9L8Ov2IO3TRuPNaCraoScN+v6ij8TyJG3OO3mJ+6nVc
	Hdr/EnDgshPPAxZII/Oypy9HQnH+FOOime5ZiX1WDFSGQgIErAQgVM0apwQDGYLVRHe89bn7gfD
	gavwJafrSo3/lT7bSNq64iWXjDxvWTNUokCwxbWXmDk4TgPm4VrVXDmPTNeUZhIaxXndFf7KOBt
	ekSw01c6S/Iaufvfwqb0MjcZpo4czymLKbm7jZAlFJTV1R7/LBwu9FxA6oP0fn6A/ApsqiDx7rA
	paLoZZxpVBzzfufX/FHA52/MRGJ+rLheTimL6dl0ugJro/ct+aLTvzEfCoiGDiorN1U5aZ92N0F
	Hdjdg==
X-Received: by 2002:a17:90b:3f44:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-35e4280f055mr2625174a91.16.1775813377078;
        Fri, 10 Apr 2026 02:29:37 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next v3 08/13] bpf: simplify liveness to use (callsite, depth) keyed func_instances
Date: Fri, 10 Apr 2026 02:29:12 -0700
Message-ID: <20260410-patch-set-v3-8-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Rework func_instance identification and remove the dynamic liveness
API, completing the transition to fully static stack liveness analysis.

Replace callchain-based func_instance keys with (callsite, depth)
pairs. The full callchain (all ancestor callsites) is no longer part
of the hash key; only the immediate callsite and the call depth
matter. This does not lose precision in practice and simplifies the
data structure significantly: struct callchain is removed entirely,
func_instance stores just callsite, depth.

Drop must_write_acc propagation. Previously, must_write marks were
accumulated across successors and propagated to the caller via
propagate_to_outer_instance(). Instead, callee entry liveness
(live_before at subprog start) is pulled directly back to the
caller's callsite in analyze_subprog() after each callee returns.

Skip recursive descent into callees that receive no FP-derived
arguments (has_fp_args() check). This is needed because global
subprogram calls can push depth beyond MAX_CALL_FRAMES (max depth
is 64 for global calls but only 8 frames are accommodated for FP
passing). It also handles the case where a callback subprog cannot be
determined by argument tracking: such callbacks will be processed by
analyze_subprog() at depth 0 independently.

Update lookup_instance() (used by is_live_before queries) to search
for the func_instance with maximal depth at the corresponding
callsite, walking depth downward from frameno to 0. This accounts for
the fact that instance depth no longer corresponds 1:1 to
bpf_verifier_state->curframe, since skipped non-FP calls create gaps.

Remove the dynamic public liveness API from verifier.c:
  - bpf_mark_stack_{read,write}(), bpf_reset/commit_stack_write_marks()
  - bpf_update_live_stack(), bpf_reset_live_stack_callchain()
  - All call sites in check_stack_{read,write}_fixed_off(),
    check_stack_range_initialized(), mark_stack_slot_obj_read(),
    mark/unmark_stack_slots_{dynptr,iter,irq_flag}()
  - The per-instruction write mark accumulation in do_check()
  - The bpf_update_live_stack() call in prepare_func_exit()

mark_stack_read() and mark_stack_write() become static functions in
liveness.c, called only from the static analysis pass. The
func_instance->updated and must_write_dropped flags are removed.
Remove spis_single_slot(), spis_one_bit() helpers from bpf_verifier.h
as they are no longer used.

Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  19 --
 kernel/bpf/liveness.c        | 558 ++++++++++++-------------------------------
 kernel/bpf/verifier.c        |  79 +-----
 3 files changed, 159 insertions(+), 497 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 49b19118c326..0e6790d89cf0 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -279,19 +279,6 @@ static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
 		mask->v[w / 64] |= BIT_ULL(w % 64);
 }
 
-static inline spis_t spis_one_bit(u32 slot)
-{
-	if (slot < 64)
-		return (spis_t){{ BIT_ULL(slot), 0 }};
-	else
-		return (spis_t){{ 0, BIT_ULL(slot - 64) }};
-}
-
-static inline spis_t spis_single_slot(u32 spi)
-{
-	return spis_or(spis_one_bit(spi * 2), spis_one_bit(spi * 2 + 1));
-}
-
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
 			  (1 << BPF_REG_5))
@@ -1220,13 +1207,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
-int bpf_update_live_stack(struct bpf_verifier_env *env);
-int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frameno, u32 insn_idx, spis_t mask);
-void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frameno, spis_t mask);
-int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx);
-int bpf_commit_stack_write_marks(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
-void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index b5ac0800c18a..1d9c89a269e3 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -49,22 +49,8 @@
  *
  *   The above equations are computed for each call chain and instruction
  *   index until state stops changing.
- * - Additionally, in order to transfer "must_write" information from a
- *   subprogram to call instructions invoking this subprogram,
- *   the "must_write_acc" set is tracked for each (cc, i) tuple.
- *   A set of stack slots that are guaranteed to be written by this
- *   instruction or any of its successors (within the subprogram).
- *   The equation for "must_write_acc" propagation looks as follows:
- *
- *     state[cc, i].must_write_acc =
- *       ∩ [state[cc, s].must_write_acc for s in bpf_insn_successors(i)]
- *       U state[cc, i].must_write
- *
- *   (An intersection of all "must_write_acc" for instruction successors
- *    plus all "must_write" slots for the instruction itself).
  * - After the propagation phase completes for a subprogram, information from
  *   (cc, 0) tuple (subprogram entry) is transferred to the caller's call chain:
- *   - "must_write_acc" set is intersected with the call site's "must_write" set;
  *   - "may_read" set is added to the call site's "may_read" set.
  * - Any live stack queries must be taken after the propagation phase.
  * - Accumulation and propagation phases can be entered multiple times,
@@ -85,157 +71,110 @@
  * - A hash table mapping call chains to function instances.
  */
 
-struct callchain {
-	u32 callsites[MAX_CALL_FRAMES];	/* instruction pointer for each frame */
-	/* cached subprog_info[*].start for functions owning the frames:
-	 * - sp_starts[curframe] used to get insn relative index within current function;
-	 * - sp_starts[0..current-1] used for fast callchain_frame_up().
-	 */
-	u32 sp_starts[MAX_CALL_FRAMES];
-	u32 curframe;			/* depth of callsites and sp_starts arrays */
-};
-
 struct per_frame_masks {
 	spis_t may_read;	/* stack slots that may be read by this instruction */
 	spis_t must_write;	/* stack slots written by this instruction */
-	spis_t must_write_acc;	/* stack slots written by this instruction and its successors */
 	spis_t live_before;	/* stack slots that may be read by this insn and its successors */
 };
 
 /*
- * A function instance created for a specific callchain.
+ * A function instance keyed by (callsite, depth).
  * Encapsulates read and write marks for each instruction in the function.
- * Marks are tracked for each frame in the callchain.
+ * Marks are tracked for each frame up to @depth.
  */
 struct func_instance {
 	struct hlist_node hl_node;
-	struct callchain callchain;
+	u32 callsite;		/* call insn that invoked this subprog (subprog_start for depth 0) */
+	u32 depth;		/* call depth (0 = entry subprog) */
 	u32 subprog;		/* subprog index */
+	u32 subprog_start;	/* cached env->subprog_info[subprog].start */
 	u32 insn_cnt;		/* cached number of insns in the function */
-	bool updated;
-	bool must_write_dropped;
 	/* Per frame, per instruction masks, frames allocated lazily. */
 	struct per_frame_masks *frames[MAX_CALL_FRAMES];
-	/* For each instruction a flag telling if "must_write" had been initialized for it. */
-	bool *must_write_set;
+	bool must_write_initialized;
 };
 
 struct live_stack_query {
 	struct func_instance *instances[MAX_CALL_FRAMES]; /* valid in range [0..curframe] */
+	u32 callsites[MAX_CALL_FRAMES]; /* callsite[i] = insn calling frame i+1 */
 	u32 curframe;
 	u32 insn_idx;
 };
 
 struct bpf_liveness {
-	DECLARE_HASHTABLE(func_instances, 8);		/* maps callchain to func_instance */
+	DECLARE_HASHTABLE(func_instances, 8);		/* maps (depth, callsite) to func_instance */
 	struct live_stack_query live_stack_query;	/* cache to avoid repetitive ht lookups */
-	/* Cached instance corresponding to env->cur_state, avoids per-instruction ht lookup */
-	struct func_instance *cur_instance;
-	/*
-	 * Below fields are used to accumulate stack write marks for instruction at
-	 * @write_insn_idx before submitting the marks to @cur_instance.
-	 */
-	spis_t write_masks_acc[MAX_CALL_FRAMES];
-	u32 write_insn_idx;
 };
 
-/* Compute callchain corresponding to state @st at depth @frameno */
-static void compute_callchain(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
-			      struct callchain *callchain, u32 frameno)
-{
-	struct bpf_subprog_info *subprog_info = env->subprog_info;
-	u32 i;
-
-	memset(callchain, 0, sizeof(*callchain));
-	for (i = 0; i <= frameno; i++) {
-		callchain->sp_starts[i] = subprog_info[st->frame[i]->subprogno].start;
-		if (i < st->curframe)
-			callchain->callsites[i] = st->frame[i + 1]->callsite;
-	}
-	callchain->curframe = frameno;
-	callchain->callsites[callchain->curframe] = callchain->sp_starts[callchain->curframe];
-}
-
-static u32 hash_callchain(struct callchain *callchain)
-{
-	return jhash2(callchain->callsites, callchain->curframe, 0);
-}
-
-static bool same_callsites(struct callchain *a, struct callchain *b)
+/*
+ * Hash/compare key for func_instance: (depth, callsite).
+ * For depth == 0 (entry subprog), @callsite is the subprog start insn.
+ * For depth > 0, @callsite is the call instruction index that invoked the subprog.
+ */
+static u32 instance_hash(u32 callsite, u32 depth)
 {
-	int i;
+	u32 key[2] = { depth, callsite };
 
-	if (a->curframe != b->curframe)
-		return false;
-	for (i = a->curframe; i >= 0; i--)
-		if (a->callsites[i] != b->callsites[i])
-			return false;
-	return true;
+	return jhash2(key, 2, 0);
 }
 
-/*
- * Find existing or allocate new function instance corresponding to @callchain.
- * Instances are accumulated in env->liveness->func_instances and persist
- * until the end of the verification process.
- */
-static struct func_instance *__lookup_instance(struct bpf_verifier_env *env,
-					       struct callchain *callchain)
+static struct func_instance *find_instance(struct bpf_verifier_env *env,
+					   u32 callsite, u32 depth)
 {
 	struct bpf_liveness *liveness = env->liveness;
-	struct bpf_subprog_info *subprog;
-	struct func_instance *result;
-	u32 subprog_sz, size, key;
-
-	key = hash_callchain(callchain);
-	hash_for_each_possible(liveness->func_instances, result, hl_node, key)
-		if (same_callsites(&result->callchain, callchain))
-			return result;
-
-	subprog = bpf_find_containing_subprog(env, callchain->sp_starts[callchain->curframe]);
-	subprog_sz = (subprog + 1)->start - subprog->start;
-	size = sizeof(struct func_instance);
-	result = kvzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!result)
-		return ERR_PTR(-ENOMEM);
-	result->must_write_set = kvzalloc_objs(*result->must_write_set,
-					       subprog_sz, GFP_KERNEL_ACCOUNT);
-	if (!result->must_write_set) {
-		kvfree(result);
-		return ERR_PTR(-ENOMEM);
-	}
-	memcpy(&result->callchain, callchain, sizeof(*callchain));
-	result->subprog = subprog - env->subprog_info;
-	result->insn_cnt = subprog_sz;
-	hash_add(liveness->func_instances, &result->hl_node, key);
-	return result;
+	struct func_instance *f;
+	u32 key = instance_hash(callsite, depth);
+
+	hash_for_each_possible(liveness->func_instances, f, hl_node, key)
+		if (f->depth == depth && f->callsite == callsite)
+			return f;
+	return NULL;
 }
 
 static struct func_instance *call_instance(struct bpf_verifier_env *env,
 					   struct func_instance *caller,
 					   u32 callsite, int subprog)
 {
-	struct callchain cc;
-
-	if (caller) {
-		cc = caller->callchain;
-		cc.callsites[cc.curframe] = callsite;
-		cc.curframe++;
-	} else {
-		memset(&cc, 0, sizeof(cc));
-	}
-	cc.sp_starts[cc.curframe] = env->subprog_info[subprog].start;
-	cc.callsites[cc.curframe] = cc.sp_starts[cc.curframe];
-	return __lookup_instance(env, &cc);
+	u32 depth = caller ? caller->depth + 1 : 0;
+	u32 subprog_start = env->subprog_info[subprog].start;
+	u32 lookup_key = depth > 0 ? callsite : subprog_start;
+	struct func_instance *f;
+	u32 hash;
+
+	f = find_instance(env, lookup_key, depth);
+	if (f)
+		return f;
+
+	f = kvzalloc(sizeof(*f), GFP_KERNEL_ACCOUNT);
+	if (!f)
+		return ERR_PTR(-ENOMEM);
+	f->callsite = lookup_key;
+	f->depth = depth;
+	f->subprog = subprog;
+	f->subprog_start = subprog_start;
+	f->insn_cnt = (env->subprog_info + subprog + 1)->start - subprog_start;
+	hash = instance_hash(lookup_key, depth);
+	hash_add(env->liveness->func_instances, &f->hl_node, hash);
+	return f;
 }
 
 static struct func_instance *lookup_instance(struct bpf_verifier_env *env,
 					     struct bpf_verifier_state *st,
 					     u32 frameno)
 {
-	struct callchain callchain;
-
-	compute_callchain(env, st, &callchain, frameno);
-	return __lookup_instance(env, &callchain);
+	u32 callsite, subprog_start;
+	struct func_instance *f;
+	u32 key, depth;
+
+	subprog_start = env->subprog_info[st->frame[frameno]->subprogno].start;
+	callsite = frameno > 0 ? st->frame[frameno]->callsite : subprog_start;
+
+	for (depth = frameno; ; depth--) {
+		key = depth > 0 ? callsite : subprog_start;
+		f = find_instance(env, key, depth);
+		if (f || depth == 0)
+			return f;
+	}
 }
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env)
@@ -256,9 +195,8 @@ void bpf_stack_liveness_free(struct bpf_verifier_env *env)
 	if (!env->liveness)
 		return;
 	hash_for_each_safe(env->liveness->func_instances, bkt, tmp, instance, hl_node) {
-		for (i = 0; i <= instance->callchain.curframe; i++)
+		for (i = 0; i <= instance->depth; i++)
 			kvfree(instance->frames[i]);
-		kvfree(instance->must_write_set);
 		kvfree(instance);
 	}
 	kvfree(env->liveness);
@@ -270,7 +208,7 @@ void bpf_stack_liveness_free(struct bpf_verifier_env *env)
  */
 static int relative_idx(struct func_instance *instance, u32 insn_idx)
 {
-	return insn_idx - instance->callchain.sp_starts[instance->callchain.curframe];
+	return insn_idx - instance->subprog_start;
 }
 
 static struct per_frame_masks *get_frame_masks(struct func_instance *instance,
@@ -297,145 +235,36 @@ static struct per_frame_masks *alloc_frame_masks(struct func_instance *instance,
 	return get_frame_masks(instance, frame, insn_idx);
 }
 
-void bpf_reset_live_stack_callchain(struct bpf_verifier_env *env)
-{
-	env->liveness->cur_instance = NULL;
-}
-
-/* If @env->liveness->cur_instance is null, set it to instance corresponding to @env->cur_state. */
-static int ensure_cur_instance(struct bpf_verifier_env *env)
-{
-	struct bpf_liveness *liveness = env->liveness;
-	struct func_instance *instance;
-
-	if (liveness->cur_instance)
-		return 0;
-
-	instance = lookup_instance(env, env->cur_state, env->cur_state->curframe);
-	if (IS_ERR(instance))
-		return PTR_ERR(instance);
-
-	liveness->cur_instance = instance;
-	return 0;
-}
-
 /* Accumulate may_read masks for @frame at @insn_idx */
 static int mark_stack_read(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
 {
 	struct per_frame_masks *masks;
-	spis_t new_may_read;
 
 	masks = alloc_frame_masks(instance, frame, insn_idx);
 	if (IS_ERR(masks))
 		return PTR_ERR(masks);
-	new_may_read = spis_or(masks->may_read, mask);
-	if (!spis_equal(new_may_read, masks->may_read) &&
-	    !spis_equal(spis_or(new_may_read, masks->live_before),
-				masks->live_before))
-		instance->updated = true;
 	masks->may_read = spis_or(masks->may_read, mask);
 	return 0;
 }
 
-int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, spis_t mask)
-{
-	int err;
-
-	err = ensure_cur_instance(env);
-	err = err ?: mark_stack_read(env->liveness->cur_instance, frame, insn_idx, mask);
-	return err;
-}
-
-static void reset_stack_write_marks(struct bpf_verifier_env *env, struct func_instance *instance)
+static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
 {
-	struct bpf_liveness *liveness = env->liveness;
-	int i;
-
-	for (i = 0; i <= instance->callchain.curframe; i++)
-		liveness->write_masks_acc[i] = SPIS_ZERO;
-}
-
-int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
-{
-	struct bpf_liveness *liveness = env->liveness;
-	int err;
-
-	err = ensure_cur_instance(env);
-	if (err)
-		return err;
-
-	liveness->write_insn_idx = insn_idx;
-	reset_stack_write_marks(env, liveness->cur_instance);
-	return 0;
-}
-
-void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, spis_t mask)
-{
-	env->liveness->write_masks_acc[frame] = spis_or(env->liveness->write_masks_acc[frame], mask);
-}
-
-static int commit_stack_write_marks(struct bpf_verifier_env *env,
-				    struct func_instance *instance,
-				    u32 insn_idx)
-{
-	struct bpf_liveness *liveness = env->liveness;
-	u32 idx, frame, curframe;
 	struct per_frame_masks *masks;
-	spis_t mask, old_must_write, dropped;
 
-	if (!instance)
-		return 0;
-
-	curframe = instance->callchain.curframe;
-	idx = relative_idx(instance, insn_idx);
-	for (frame = 0; frame <= curframe; frame++) {
-		mask = liveness->write_masks_acc[frame];
-		/* avoid allocating frames for zero masks */
-		if (spis_is_zero(mask) && !instance->must_write_set[idx])
-			continue;
-		masks = alloc_frame_masks(instance, frame, insn_idx);
-		if (IS_ERR(masks))
-			return PTR_ERR(masks);
-		old_must_write = masks->must_write;
-		/*
-		 * If instruction at this callchain is seen for a first time, set must_write equal
-		 * to @mask. Otherwise take intersection with the previous value.
-		 */
-		if (instance->must_write_set[idx])
-			mask = spis_and(mask, old_must_write);
-		if (!spis_equal(old_must_write, mask)) {
-			masks->must_write = mask;
-			instance->updated = true;
-		}
-		/* dropped = old_must_write & ~mask */
-		dropped = spis_and(old_must_write, spis_not(mask));
-		if (!spis_is_zero(dropped))
-			instance->must_write_dropped = true;
-	}
-	instance->must_write_set[idx] = true;
-	liveness->write_insn_idx = 0;
+	masks = alloc_frame_masks(instance, frame, insn_idx);
+	if (IS_ERR(masks))
+		return PTR_ERR(masks);
+	if (instance->must_write_initialized)
+		masks->must_write = spis_and(masks->must_write, mask);
+	else
+		masks->must_write = mask;
 	return 0;
 }
 
-/*
- * Merge stack writes marks in @env->liveness->write_masks_acc
- * with information already in @env->liveness->cur_instance.
- */
-int bpf_commit_stack_write_marks(struct bpf_verifier_env *env)
-{
-	return commit_stack_write_marks(env, env->liveness->cur_instance, env->liveness->write_insn_idx);
-}
-
-static char *fmt_callchain(struct bpf_verifier_env *env, struct callchain *callchain)
+static char *fmt_instance(struct bpf_verifier_env *env, struct func_instance *instance)
 {
-	char *buf_end = env->tmp_str_buf + sizeof(env->tmp_str_buf);
-	char *buf = env->tmp_str_buf;
-	int i;
-
-	buf += snprintf(buf, buf_end - buf, "(");
-	for (i = 0; i <= callchain->curframe; i++)
-		buf += snprintf(buf, buf_end - buf, "%s%d", i ? "," : "", callchain->callsites[i]);
-	snprintf(buf, buf_end - buf, ")");
+	snprintf(env->tmp_str_buf, sizeof(env->tmp_str_buf),
+		 "(d%d,cs%d)", instance->depth, instance->callsite);
 	return env->tmp_str_buf;
 }
 
@@ -466,7 +295,7 @@ static void bpf_fmt_spis_mask(char *buf, ssize_t buf_sz, spis_t spis)
 	}
 }
 
-static void log_mask_change(struct bpf_verifier_env *env, struct callchain *callchain,
+static void log_mask_change(struct bpf_verifier_env *env, struct func_instance *instance,
 			    char *pfx, u32 frame, u32 insn_idx,
 			    spis_t old, spis_t new)
 {
@@ -478,7 +307,7 @@ static void log_mask_change(struct bpf_verifier_env *env, struct callchain *call
 
 	if (spis_is_zero(changed_bits))
 		return;
-	bpf_log(&env->log, "%s frame %d insn %d ", fmt_callchain(env, callchain), frame, insn_idx);
+	bpf_log(&env->log, "%s frame %d insn %d ", fmt_instance(env, instance), frame, insn_idx);
 	if (!spis_is_zero(new_ones)) {
 		bpf_fmt_spis_mask(env->tmp_str_buf, sizeof(env->tmp_str_buf), new_ones);
 		bpf_log(&env->log, "+%s %s ", pfx, env->tmp_str_buf);
@@ -561,61 +390,12 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 
 __diag_pop();
 
-static struct func_instance *get_outer_instance(struct bpf_verifier_env *env,
-						struct func_instance *instance)
-{
-	struct callchain callchain = instance->callchain;
-
-	/* Adjust @callchain to represent callchain one frame up */
-	callchain.callsites[callchain.curframe] = 0;
-	callchain.sp_starts[callchain.curframe] = 0;
-	callchain.curframe--;
-	callchain.callsites[callchain.curframe] = callchain.sp_starts[callchain.curframe];
-	return __lookup_instance(env, &callchain);
-}
-
-static u32 callchain_subprog_start(struct callchain *callchain)
-{
-	return callchain->sp_starts[callchain->curframe];
-}
-
-/*
- * Transfer @may_read and @must_write_acc marks from the first instruction of @instance,
- * to the call instruction in function instance calling @instance.
- */
-static int propagate_to_outer_instance(struct bpf_verifier_env *env,
-				       struct func_instance *instance)
-{
-	struct callchain *callchain = &instance->callchain;
-	u32 this_subprog_start, callsite, frame;
-	struct func_instance *outer_instance;
-	struct per_frame_masks *insn;
-	int err;
-
-	this_subprog_start = callchain_subprog_start(callchain);
-	outer_instance = get_outer_instance(env, instance);
-	if (IS_ERR(outer_instance))
-		return PTR_ERR(outer_instance);
-	callsite = callchain->callsites[callchain->curframe - 1];
-	reset_stack_write_marks(env, outer_instance);
-	for (frame = 0; frame < callchain->curframe; frame++) {
-		insn = get_frame_masks(instance, frame, this_subprog_start);
-		if (!insn)
-			continue;
-		bpf_mark_stack_write(env, frame, insn->must_write_acc);
-		err = mark_stack_read(outer_instance, frame, callsite, insn->live_before);
-		if (err)
-			return err;
-	}
-	commit_stack_write_marks(env, outer_instance, callsite);
-	return 0;
-}
 
 static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	spis_t new_before, new_after, must_write_acc;
+	spis_t new_before, new_after;
 	struct per_frame_masks *insn, *succ_insn;
 	struct bpf_iarray *succ;
 	u32 s;
@@ -629,17 +409,10 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	insn = get_frame_masks(instance, frame, insn_idx);
 	new_before = SPIS_ZERO;
 	new_after = SPIS_ZERO;
-	/*
-	 * New "must_write_acc" is an intersection of all "must_write_acc"
-	 * of successors plus all "must_write" slots of instruction itself.
-	 */
-	must_write_acc = SPIS_ALL;
 	for (s = 0; s < succ->cnt; ++s) {
 		succ_insn = get_frame_masks(instance, frame, succ->items[s]);
 		new_after = spis_or(new_after, succ_insn->live_before);
-		must_write_acc = spis_and(must_write_acc, succ_insn->must_write_acc);
 	}
-	must_write_acc = spis_or(must_write_acc, insn->must_write);
 	/*
 	 * New "live_before" is a union of all "live_before" of successors
 	 * minus slots written by instruction plus slots read by instruction.
@@ -648,53 +421,27 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	new_before = spis_or(spis_and(new_after, spis_not(insn->must_write)),
 			     insn->may_read);
 	changed |= !spis_equal(new_before, insn->live_before);
-	changed |= !spis_equal(must_write_acc, insn->must_write_acc);
 	if (unlikely(env->log.level & BPF_LOG_LEVEL2) &&
 	    (!spis_is_zero(insn->may_read) || !spis_is_zero(insn->must_write) ||
-	     insn_idx == callchain_subprog_start(&instance->callchain) ||
+	     insn_idx == instance->subprog_start ||
 	     aux[insn_idx].prune_point)) {
-		log_mask_change(env, &instance->callchain, "live",
+		log_mask_change(env, instance, "live",
 				frame, insn_idx, insn->live_before, new_before);
-		log_mask_change(env, &instance->callchain, "written",
-				frame, insn_idx, insn->must_write_acc, must_write_acc);
 	}
 	insn->live_before = new_before;
-	insn->must_write_acc = must_write_acc;
 	return changed;
 }
 
-/* Fixed-point computation of @live_before and @must_write_acc marks */
-static int update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
+/* Fixed-point computation of @live_before marks */
+static void update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
 {
-	u32 i, frame, po_start, po_end, cnt, this_subprog_start;
-	struct callchain *callchain = &instance->callchain;
+	u32 i, frame, po_start, po_end, cnt;
 	int *insn_postorder = env->cfg.insn_postorder;
 	struct bpf_subprog_info *subprog;
-	struct per_frame_masks *insn;
 	bool changed;
-	int err;
-
-	if (!instance->updated)
-		return 0;
-
-	this_subprog_start = callchain_subprog_start(callchain);
-	/*
-	 * If must_write marks were updated must_write_acc needs to be reset
-	 * (to account for the case when new must_write sets became smaller).
-	 */
-	if (instance->must_write_dropped) {
-		for (frame = 0; frame <= callchain->curframe; frame++) {
-			if (!instance->frames[frame])
-				continue;
-
-			for (i = 0; i < instance->insn_cnt; i++) {
-				insn = get_frame_masks(instance, frame, this_subprog_start + i);
-				insn->must_write_acc = SPIS_ZERO;
-			}
-		}
-	}
 
-	subprog = bpf_find_containing_subprog(env, this_subprog_start);
+	instance->must_write_initialized = true;
+	subprog = &env->subprog_info[instance->subprog];
 	po_start = subprog->postorder_start;
 	po_end = (subprog + 1)->postorder_start;
 	cnt = 0;
@@ -702,7 +449,7 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 	do {
 		cnt++;
 		changed = false;
-		for (frame = 0; frame <= instance->callchain.curframe; frame++) {
+		for (frame = 0; frame <= instance->depth; frame++) {
 			if (!instance->frames[frame])
 				continue;
 
@@ -713,44 +460,7 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 
 	if (env->log.level & BPF_LOG_LEVEL2)
 		bpf_log(&env->log, "%s live stack update done in %d iterations\n",
-			fmt_callchain(env, callchain), cnt);
-
-	/* transfer marks accumulated for outer frames to outer func instance (caller) */
-	if (callchain->curframe > 0) {
-		err = propagate_to_outer_instance(env, instance);
-		if (err)
-			return err;
-	}
-
-	instance->updated = false;
-	instance->must_write_dropped = false;
-	return 0;
-}
-
-/*
- * Prepare all callchains within @env->cur_state for querying.
- * This function should be called after each verifier.c:pop_stack()
- * and whenever verifier.c:do_check_insn() processes subprogram exit.
- * This would guarantee that visited verifier states with zero branches
- * have their bpf_mark_stack_{read,write}() effects propagated in
- * @env->liveness.
- */
-int bpf_update_live_stack(struct bpf_verifier_env *env)
-{
-	struct func_instance *instance;
-	int err, frame;
-
-	bpf_reset_live_stack_callchain(env);
-	for (frame = env->cur_state->curframe; frame >= 0; --frame) {
-		instance = lookup_instance(env, env->cur_state, frame);
-		if (IS_ERR(instance))
-			return PTR_ERR(instance);
-
-		err = update_instance(env, instance);
-		if (err)
-			return err;
-	}
-	return 0;
+			fmt_instance(env, instance), cnt);
 }
 
 static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
@@ -770,9 +480,12 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 	memset(q, 0, sizeof(*q));
 	for (frame = 0; frame <= st->curframe; frame++) {
 		instance = lookup_instance(env, st, frame);
-		if (IS_ERR(instance))
-			return PTR_ERR(instance);
-		q->instances[frame] = instance;
+		if (IS_ERR_OR_NULL(instance))
+			q->instances[frame] = NULL;
+		else
+			q->instances[frame] = instance;
+		if (frame < st->curframe)
+			q->callsites[frame] = st->frame[frame + 1]->callsite;
 	}
 	q->curframe = st->curframe;
 	q->insn_idx = st->insn_idx;
@@ -782,27 +495,44 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
 {
 	/*
-	 * Slot is alive if it is read before q->st->insn_idx in current func instance,
+	 * Slot is alive if it is read before q->insn_idx in current func instance,
 	 * or if for some outer func instance:
 	 * - alive before callsite if callsite calls callback, otherwise
 	 * - alive after callsite
 	 */
 	struct live_stack_query *q = &env->liveness->live_stack_query;
 	struct func_instance *instance, *curframe_instance;
-	u32 i, callsite;
-	bool alive;
+	u32 i, callsite, rel;
+	int cur_delta, delta;
+	bool alive = false;
 
 	curframe_instance = q->instances[q->curframe];
-	alive = is_live_before(curframe_instance, q->insn_idx, frameno, half_spi);
+	if (!curframe_instance)
+		return true;
+	cur_delta = (int)curframe_instance->depth - (int)q->curframe;
+	rel = frameno + cur_delta;
+	if (rel <= curframe_instance->depth)
+		alive = is_live_before(curframe_instance, q->insn_idx, rel, half_spi);
+
 	if (alive)
 		return true;
 
 	for (i = frameno; i < q->curframe; i++) {
-		callsite = curframe_instance->callchain.callsites[i];
 		instance = q->instances[i];
+		if (!instance)
+			return true;
+		/* Map actual frameno to frame index within this instance */
+		delta = (int)instance->depth - (int)i;
+		rel = frameno + delta;
+		if (rel > instance->depth)
+			return true;
+
+		/* Get callsite from verifier state, not from instance callchain */
+		callsite = q->callsites[i];
+
 		alive = bpf_calls_callback(env, callsite)
-			? is_live_before(instance, callsite, frameno, half_spi)
-			: is_live_before(instance, callsite + 1, frameno, half_spi);
+			? is_live_before(instance, callsite, rel, half_spi)
+			: is_live_before(instance, callsite + 1, rel, half_spi);
 		if (alive)
 			return true;
 	}
@@ -1302,7 +1032,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			   struct func_instance *instance,
 			   u32 *callsites)
 {
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	u8 class = BPF_CLASS(insn->code);
 	u8 code = BPF_OP(insn->code);
 	struct arg_track *dst = &at_out[insn->dst_reg];
@@ -1432,8 +1162,7 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
  *   access_bytes == 0:      no access
  *
  */
-static int record_stack_access_off(struct bpf_verifier_env *env,
-				   struct func_instance *instance, s64 fp_off,
+static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
 				   s64 access_bytes, u32 frame, u32 insn_idx)
 {
 	s32 slot_hi, slot_lo;
@@ -1468,7 +1197,7 @@ static int record_stack_access_off(struct bpf_verifier_env *env,
 		if (slot_lo <= slot_hi) {
 			mask = SPIS_ZERO;
 			spis_or_range(&mask, slot_lo, slot_hi);
-			bpf_mark_stack_write(env, frame, mask);
+			return mark_stack_write(instance, frame, insn_idx, mask);
 		}
 	}
 	return 0;
@@ -1478,8 +1207,7 @@ static int record_stack_access_off(struct bpf_verifier_env *env,
  * 'arg' is FP-derived argument to helper/kfunc or load/store that
  * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
  */
-static int record_stack_access(struct bpf_verifier_env *env,
-			       struct func_instance *instance,
+static int record_stack_access(struct func_instance *instance,
 			       const struct arg_track *arg,
 			       s64 access_bytes, u32 frame, u32 insn_idx)
 {
@@ -1497,7 +1225,7 @@ static int record_stack_access(struct bpf_verifier_env *env,
 		return 0;
 
 	for (i = 0; i < arg->off_cnt; i++) {
-		err = record_stack_access_off(env, instance, arg->off[i], access_bytes, frame, insn_idx);
+		err = record_stack_access_off(instance, arg->off[i], access_bytes, frame, insn_idx);
 		if (err)
 			return err;
 	}
@@ -1510,7 +1238,7 @@ static int record_stack_access(struct bpf_verifier_env *env,
  */
 static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
 {
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	int f, err;
 
 	for (f = 0; mask; f++, mask >>= 1) {
@@ -1531,7 +1259,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 				    struct arg_track *at, int insn_idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	s32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
 	u8 class = BPF_CLASS(insn->code);
 	struct arg_track resolved, *ptr;
@@ -1577,7 +1305,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	}
 
 	if (ptr->frame >= 0 && ptr->frame <= depth)
-		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
+		return record_stack_access(instance, ptr, sz, ptr->frame, insn_idx);
 	if (ptr->frame == ARG_IMPRECISE)
 		return record_imprecise(instance, ptr->mask, insn_idx);
 	/* ARG_NONE: not derived from any frame pointer, skip */
@@ -1591,7 +1319,7 @@ static int record_call_access(struct bpf_verifier_env *env,
 			      int insn_idx)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	struct bpf_call_summary cs;
 	int r, err = 0, num_params = 5;
 
@@ -1624,7 +1352,7 @@ static int record_call_access(struct bpf_verifier_env *env,
 			continue;
 
 		if (frame >= 0 && frame <= depth)
-			err = record_stack_access(env, instance, &at[r], bytes, frame, insn_idx);
+			err = record_stack_access(instance, &at[r], bytes, frame, insn_idx);
 		else if (frame == ARG_IMPRECISE)
 			err = record_imprecise(instance, at[r].mask, insn_idx);
 		if (err)
@@ -1783,7 +1511,7 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 {
 	int subprog = instance->subprog;
 	struct bpf_insn *insns = env->prog->insnsi;
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	int start = env->subprog_info[subprog].start;
 	int po_start = env->subprog_info[subprog].postorder_start;
 	int end = env->subprog_info[subprog + 1].start;
@@ -1883,7 +1611,6 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 		int i = idx - start;
 		struct bpf_insn *insn = &insns[idx];
 
-		reset_stack_write_marks(env, instance);
 		err = record_load_store_access(env, instance, at_in[i], idx);
 		if (err)
 			goto err_free;
@@ -1906,9 +1633,6 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 			memcpy(env->callsite_at_stack[idx],
 			       at_stack_in[i], sizeof(struct arg_track) * MAX_ARG_SPILL_SLOTS);
 		}
-		err = commit_stack_write_marks(env, instance, idx);
-		if (err)
-			goto err_free;
 	}
 
 	info->at_in = at_in;
@@ -1924,6 +1648,15 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 	return err;
 }
 
+/* Return true if any of R1-R5 is derived from a frame pointer. */
+static bool has_fp_args(struct arg_track *args)
+{
+	for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
+		if (args[r].frame != ARG_NONE)
+			return true;
+	return false;
+}
+
 /*
  * Recursively analyze a subprog with specific 'entry_args'.
  * Each callee is analyzed with the exact args from its call site.
@@ -1940,7 +1673,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 			   u32 *callsites)
 {
 	int subprog = instance->subprog;
-	int depth = instance->callchain.curframe;
+	int depth = instance->depth;
 	struct bpf_insn *insns = env->prog->insnsi;
 	int start = env->subprog_info[subprog].start;
 	int po_start = env->subprog_info[subprog].postorder_start;
@@ -2002,6 +1735,9 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 			continue;
 		}
 
+		if (!has_fp_args(callee_args))
+			continue;
+
 		if (depth == MAX_CALL_FRAMES - 1)
 			return -EINVAL;
 
@@ -2012,9 +1748,25 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		err = analyze_subprog(env, callee_args, info, callee_instance, callsites);
 		if (err)
 			return err;
+
+		/* Pull callee's entry liveness back to caller's callsite */
+		{
+			u32 callee_start = callee_instance->subprog_start;
+			struct per_frame_masks *entry;
+
+			for (int f = 0; f < callee_instance->depth; f++) {
+				entry = get_frame_masks(callee_instance, f, callee_start);
+				if (!entry)
+					continue;
+				err = mark_stack_read(instance, f, idx, entry->live_before);
+				if (err)
+					return err;
+			}
+		}
 	}
 
-	return update_instance(env, instance);
+	update_instance(env, instance);
+	return 0;
 }
 
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e8a6813af4f..b279c4c93b09 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -828,9 +828,6 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
-
 	return 0;
 }
 
@@ -845,9 +842,6 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
-
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
 }
 
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
@@ -965,9 +959,6 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
 	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
-	bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - 1));
-
 	return 0;
 }
 
@@ -1093,7 +1084,6 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_ITER;
 
-		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1122,7 +1112,6 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		for (j = 0; j < BPF_REG_SIZE; j++)
 			slot->slot_type[j] = STACK_INVALID;
 
-		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi - i));
 		mark_stack_slot_scratched(env, spi - i);
 	}
 
@@ -1212,7 +1201,6 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
-	bpf_mark_stack_write(env, reg->frameno, spis_single_slot(spi));
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
 	st->ref_obj_id = id;
@@ -1268,8 +1256,6 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 
 	__mark_reg_not_init(env, st);
 
-	bpf_mark_stack_write(env, reg->frameno, spis_single_slot(spi));
-
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_INVALID;
 
@@ -3846,15 +3832,10 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    int spi, int nr_slots)
 {
-	int err, i;
+	int i;
 
-	for (i = 0; i < nr_slots; i++) {
-		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx,
-					  spis_single_slot(spi - i));
-		if (err)
-			return err;
+	for (i = 0; i < nr_slots; i++)
 		mark_stack_slot_scratched(env, spi - i);
-	}
 	return 0;
 }
 
@@ -5402,16 +5383,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (!(off % BPF_REG_SIZE) && size == BPF_REG_SIZE)
-		/* 8-byte aligned, 8-byte write */
-		bpf_mark_stack_write(env, state->frameno, spis_single_slot(spi));
-	else if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
-		/* 8-byte aligned, 4-byte write */
-		bpf_mark_stack_write(env, state->frameno, spis_one_bit(spi * 2 + 1));
-	else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
-		/* 4-byte aligned, 4-byte write */
-		bpf_mark_stack_write(env, state->frameno, spis_one_bit(spi * 2));
-
 	check_fastcall_stack_contract(env, state, insn_idx, off);
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
@@ -5668,26 +5639,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
 	int insn_flags = insn_stack_access_flags(reg_state->frameno, spi);
-	spis_t mask;
-	int err;
 
 	stype = reg_state->stack[spi].slot_type;
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
 	check_fastcall_stack_contract(env, state, env->insn_idx, off);
-	if (!(off % BPF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
-		/* 8-byte aligned, 4-byte read */
-		mask = spis_one_bit(spi * 2 + 1);
-	else if (!(off % BPF_HALF_REG_SIZE) && size == BPF_HALF_REG_SIZE)
-		/* 4-byte aligned, 4-byte read */
-		mask = spis_one_bit(spi * 2);
-	else
-		mask = spis_single_slot(spi);
-
-	err = bpf_mark_stack_read(env, reg_state->frameno, env->insn_idx, mask);
-	if (err)
-		return err;
 
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		u8 spill_size = 1;
@@ -8479,18 +8436,7 @@ static int check_stack_range_initialized(
 		}
 		return -EACCES;
 mark:
-		/* reading any byte out of 8-byte 'spill_slot' will cause
-		 * the whole slot to be marked as 'read'
-		 */
-		err = bpf_mark_stack_read(env, reg->frameno, env->insn_idx,
-					  spis_single_slot(spi));
-		if (err)
-			return err;
-		/* We do not call bpf_mark_stack_write(), as we can not
-		 * be sure that whether stack slot is written to or not. Hence,
-		 * we must still conservatively propagate reads upwards even if
-		 * helper may write to the entire memory range.
-		 */
+		;
 	}
 	return 0;
 }
@@ -11105,8 +11051,6 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	/* and go analyze first insn of the callee */
 	*insn_idx = env->subprog_info[subprog].start - 1;
 
-	bpf_reset_live_stack_callchain(env);
-
 	if (env->log.level & BPF_LOG_LEVEL) {
 		verbose(env, "caller:\n");
 		print_verifier_state(env, state, caller->frameno, true);
@@ -11391,10 +11335,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	bool in_callback_fn;
 	int err;
 
-	err = bpf_update_live_stack(env);
-	if (err)
-		return err;
-
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	if (r0->type == PTR_TO_STACK) {
@@ -21753,7 +21693,7 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err, marks_err;
+		int err;
 
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
@@ -21867,15 +21807,7 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
-		err = bpf_reset_stack_write_marks(env, env->insn_idx);
-		if (err)
-			return err;
 		err = do_check_insn(env, &do_print_state);
-		if (err >= 0 || error_recoverable_with_nospec(err)) {
-			marks_err = bpf_commit_stack_write_marks(env);
-			if (marks_err)
-				return marks_err;
-		}
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
 			 * insn that would have been unsafe to execute.
@@ -21916,9 +21848,6 @@ static int do_check(struct bpf_verifier_env *env)
 process_bpf_exit:
 			mark_verifier_state_scratched(env);
 			err = update_branch_counts(env, env->cur_state);
-			if (err)
-				return err;
-			err = bpf_update_live_stack(env);
 			if (err)
 				return err;
 			err = pop_stack(env, &prev_insn_idx, &env->insn_idx,

-- 
2.53.0
