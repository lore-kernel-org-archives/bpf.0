Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48F3A7F54
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854585; cv=none; b=AMBPSXryhSbkvPmuBzvGNy8ZnIvKjiU871Szi4BAjoaUk1AdqzAaDxcXbPpmQcXICdnhmhQgUhlPi1J5sV8jsuEb8klJjmy2yWFdD2GlKU4wvFtj4hVqtwbvRpj/Rmh15QvOoy3naPkmCIITguJxuOn/cLV5gVchaIj4J7uxpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854585; c=relaxed/simple;
	bh=vDdDX8XxujE6dqZ6cBmPNl9wY6GiA1T5/ik9OvqVP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0hlv/Ssna89exnvmDGHHXzUH7dblfmg2swK3MHcLhwwAxlIZTo344LUs2nLtvWvxVdXIiGt+g2Ea4YWMJBx8qpwg4dZf2HAuaU44JwyN1Fi+ZXjXy+B8suF/pvB/nnW5gL7MqRhTT04vVRAM7RrmM2YSuIhOlC4Fyqr0JyW5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCbceN4Y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCbceN4Y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so1317162b3a.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854583; x=1776459383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj1WoF83sY6mDEmhGr13H5OBY0D3NrbINGkpIP5Qzm8=;
        b=SCbceN4Yngj/BryCdSvjPyewRiG/PkK/DuyfQT0o4WFs2oYCdulXcOp1HwPYPcuUSq
         u3sst1UTwUmsUAecgePSttPCeKcuXkMwJMKl0s5aW37D0gwQrQ4BN73sbE9sZE2cEOiL
         jhuUaFar58rYlljyQFoRI33Cb25UowKe31WpZYsnYws0Cp1CLg4N24Px0dXSYpRJcOOv
         744KSc2VtYJMDc1OrmyOuFJEPYqVCkzsoVAa0ZR3lFpi7X1jNz60ntP7SnckLa9bNe6i
         kOcM2FIva8lwQlPNagGv2EzQnveIFsigppJ00sme1KRkDHKQsS4HUd53GfYT8QM0jOP2
         DtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854583; x=1776459383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oj1WoF83sY6mDEmhGr13H5OBY0D3NrbINGkpIP5Qzm8=;
        b=D3ekgVlR/Mgqe/vhvGvMCJ9iJAC9tT/p6i2ZSvb4skU8SNwgprAgum8TwGemiZnn3b
         MPOpq24WmPWDJje3nJozX9WK5FvHeQGGGkhoSSkxDwaoawsNoAvpq+fyq2+JsEKe2HPG
         uPss0y1U5YcXatwE4x9dDiI5TklnmGJChtZIEzwNCzpZ0XVPGz46d8j1lh/RLLhAdUgc
         fkoiezSvvWnVrrbCuFGDVYaw/dKbxbYkwarHvuR4Jc5vm+LGWJINTNoVOUq4jq/jGstb
         aAQhvkKYeYhqpB7Ix4kKSifh8EVLb2OpBv+Rk0x/1YgBO967siT46uS+XGjhh/v+czdz
         PMUQ==
X-Gm-Message-State: AOJu0YxWD3744GlPepeIiUE6GRHxIRD/lGjls2A/iewhwCxD4SGOt2L1
	ZWlbGiPZ0Htievt+F5CNqJ//31ISV6H6bev3evJYApBYmWPYr8Z+vwt7lZBC4rAH
X-Gm-Gg: AeBDiet79lsKj6drx11HBQY8b5amUqu42av/rehJHvM6N0pAMfQPkG/j04zZIb6XkWi
	FA/g5jMB0ZVmSREu9EJ1KAIG83NoiG1dG5Hjw6lnXPiaHp3WdUKwAhAShb3JtwjOh58D5TGkSxw
	PcwcgvDERp4WECsP5M7/AbwMm79HE9UGmp4NivcRdqtX7bNBScHTkOFQ72wOJnUTi1eH44I0YAa
	Q54gIv71YkP4rqM5xBEWFd+Ad7RCdavIBPG/1XefKbmveGJi278Ch9nJTFP+FvmEbGBbOSHNhJB
	LqkuyOO4lDboDqiea83WXMnN1IzaWHM5EOVx3bgibvxXzvLhw+sM+VHBUNfLvHTsvpee8EyMa78
	MZ6vu/LgTEMvP4v3qJ81/AKFVzQgWMZZFgX1GH2PlDHUdgmSWXl5SLp1zbNFzHcHkU05k09XwQ9
	L6oJSoo2HboZ1DyZfHPaogBlifcttcM8wI3GQ/4jrQFsziK7D2Xvh2yo7jf54twcYVw2Y=
X-Received: by 2002:a05:6a20:a115:b0:398:7769:f869 with SMTP id adf61e73a8af0-39fe3d5427fmr5315387637.20.1775854583148;
        Fri, 10 Apr 2026 13:56:23 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/14] bpf: record arg tracking results in bpf_liveness masks
Date: Fri, 10 Apr 2026 13:55:59 -0700
Message-ID: <20260410-patch-set-v4-8-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After arg tracking reaches a fixed point, perform a single linear scan
over the converged at_in[] state and translate each memory access into
liveness read/write masks on the func_instance:

- Load/store instructions: FP-derived pointer's frame and offset(s)
  are converted to half-slot masks targeting
  per_frame_masks->{may_read,must_write}

- Helper/kfunc calls: record_call_access() queries
  bpf_helper_stack_access_bytes() / bpf_kfunc_stack_access_bytes()
  for each FP-derived argument to determine access size and direction.
  Unknown access size (S64_MIN) conservatively marks all slots from
  fp_off to fp+0 as read.

- Imprecise pointers (frame == ARG_IMPRECISE): conservatively mark
  all slots in every frame covered by the pointer's frame bitmask
  as fully read.

- Static subprog calls with unresolved arguments: conservatively mark
  all frames as fully read.

Instead of a call to clean_live_states(), start cleaning the current
state continuously as registers and stack become dead since the static
analysis provides complete liveness information. This makes
clean_live_states() and bpf_verifier_state->cleaned unnecessary.

Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   1 -
 kernel/bpf/liveness.c        | 243 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  64 +-----------
 3 files changed, 245 insertions(+), 63 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 49b19118c326..8e83a5e66fd8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -492,7 +492,6 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
-	bool cleaned;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c5d6760454d6..2729ed965f62 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1421,6 +1421,215 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 }
 
+/*
+ * Record access_bytes from helper/kfunc or load/store insn.
+ *   access_bytes > 0:      stack read
+ *   access_bytes < 0:      stack write
+ *   access_bytes == S64_MIN: unknown   — conservative, mark [0..slot] as read
+ *   access_bytes == 0:      no access
+ *
+ */
+static int record_stack_access_off(struct bpf_verifier_env *env,
+				   struct func_instance *instance, s64 fp_off,
+				   s64 access_bytes, u32 frame, u32 insn_idx)
+{
+	s32 slot_hi, slot_lo;
+	spis_t mask;
+
+	if (fp_off >= 0)
+		/*
+		 * out of bounds stack access doesn't contribute
+		 * into actual stack liveness. It will be rejected
+		 * by the main verifier pass later.
+		 */
+		return 0;
+	if (access_bytes == S64_MIN) {
+		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, 0, slot_hi);
+		return mark_stack_read(instance, frame, insn_idx, mask);
+	}
+	if (access_bytes > 0) {
+		/* Mark any touched slot as use */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, slot_lo, slot_hi);
+		return mark_stack_read(instance, frame, insn_idx, mask);
+	} else if (access_bytes < 0) {
+		/* Mark only fully covered slots as def */
+		access_bytes = -access_bytes;
+		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
+		slot_lo = max_t(s32, (-fp_off - access_bytes + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
+		if (slot_lo <= slot_hi) {
+			mask = SPIS_ZERO;
+			spis_or_range(&mask, slot_lo, slot_hi);
+			bpf_mark_stack_write(env, frame, mask);
+		}
+	}
+	return 0;
+}
+
+/*
+ * 'arg' is FP-derived argument to helper/kfunc or load/store that
+ * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
+ */
+static int record_stack_access(struct bpf_verifier_env *env,
+			       struct func_instance *instance,
+			       const struct arg_track *arg,
+			       s64 access_bytes, u32 frame, u32 insn_idx)
+{
+	int i, err;
+
+	if (access_bytes == 0)
+		return 0;
+	if (arg->off_cnt == 0) {
+		if (access_bytes > 0 || access_bytes == S64_MIN)
+			return mark_stack_read(instance, frame, insn_idx, SPIS_ALL);
+		return 0;
+	}
+	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
+		/* multi-offset write cannot set stack_def */
+		return 0;
+
+	for (i = 0; i < arg->off_cnt; i++) {
+		err = record_stack_access_off(env, instance, arg->off[i], access_bytes, frame, insn_idx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/*
+ * When a pointer is ARG_IMPRECISE, conservatively mark every frame in
+ * the bitmask as fully used.
+ */
+static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
+{
+	int depth = instance->callchain.curframe;
+	int f, err;
+
+	for (f = 0; mask; f++, mask >>= 1) {
+		if (!(mask & 1))
+			continue;
+		if (f <= depth) {
+			err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/* Record load/store access for a given 'at' state of 'insn'. */
+static int record_load_store_access(struct bpf_verifier_env *env,
+				    struct func_instance *instance,
+				    struct arg_track *at, int insn_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int depth = instance->callchain.curframe;
+	s32 sz = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	u8 class = BPF_CLASS(insn->code);
+	struct arg_track resolved, *ptr;
+	int oi;
+
+	switch (class) {
+	case BPF_LDX:
+		ptr = &at[insn->src_reg];
+		break;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
+			if (insn->imm == BPF_STORE_REL)
+				sz = -sz;
+			if (insn->imm == BPF_LOAD_ACQ)
+				ptr = &at[insn->src_reg];
+			else
+				ptr = &at[insn->dst_reg];
+		} else {
+			ptr = &at[insn->dst_reg];
+			sz = -sz;
+		}
+		break;
+	case BPF_ST:
+		ptr = &at[insn->dst_reg];
+		sz = -sz;
+		break;
+	default:
+		return 0;
+	}
+
+	/* Resolve offsets: fold insn->off into arg_track */
+	if (ptr->off_cnt > 0) {
+		resolved.off_cnt = ptr->off_cnt;
+		resolved.frame = ptr->frame;
+		for (oi = 0; oi < ptr->off_cnt; oi++) {
+			resolved.off[oi] = arg_add(ptr->off[oi], insn->off);
+			if (resolved.off[oi] == OFF_IMPRECISE) {
+				resolved.off_cnt = 0;
+				break;
+			}
+		}
+		ptr = &resolved;
+	}
+
+	if (ptr->frame >= 0 && ptr->frame <= depth)
+		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
+	if (ptr->frame == ARG_IMPRECISE)
+		return record_imprecise(instance, ptr->mask, insn_idx);
+	/* ARG_NONE: not derived from any frame pointer, skip */
+	return 0;
+}
+
+/* Record stack access for a given 'at' state of helper/kfunc 'insn' */
+static int record_call_access(struct bpf_verifier_env *env,
+			      struct func_instance *instance,
+			      struct arg_track *at,
+			      int insn_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int depth = instance->callchain.curframe;
+	struct bpf_call_summary cs;
+	int r, err = 0, num_params = 5;
+
+	if (bpf_pseudo_call(insn))
+		return 0;
+
+	if (bpf_get_call_summary(env, insn, &cs))
+		num_params = cs.num_params;
+
+	for (r = BPF_REG_1; r < BPF_REG_1 + num_params; r++) {
+		int frame = at[r].frame;
+		s64 bytes;
+
+		if (!arg_is_fp(&at[r]))
+			continue;
+
+		if (bpf_helper_call(insn)) {
+			bytes = bpf_helper_stack_access_bytes(env, insn, r - 1, insn_idx);
+		} else if (bpf_pseudo_kfunc_call(insn)) {
+			bytes = bpf_kfunc_stack_access_bytes(env, insn, r - 1, insn_idx);
+		} else {
+			for (int f = 0; f <= depth; f++) {
+				err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+				if (err)
+					return err;
+			}
+			return 0;
+		}
+		if (bytes == 0)
+			continue;
+
+		if (frame >= 0 && frame <= depth)
+			err = record_stack_access(env, instance, &at[r], bytes, frame, insn_idx);
+		else if (frame == ARG_IMPRECISE)
+			err = record_imprecise(instance, at[r].mask, insn_idx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * For a calls_callback helper, find the callback subprog and determine
  * which caller register maps to which callback register for FP passthrough.
@@ -1665,6 +1874,40 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 	if (changed)
 		goto redo;
 
+	/* Record memory accesses using converged at_in (RPO skips dead code) */
+	for (p = po_end - 1; p >= po_start; p--) {
+		int idx = env->cfg.insn_postorder[p];
+		int i = idx - start;
+		struct bpf_insn *insn = &insns[idx];
+
+		reset_stack_write_marks(env, instance);
+		err = record_load_store_access(env, instance, at_in[i], idx);
+		if (err)
+			goto err_free;
+
+		if (insn->code == (BPF_JMP | BPF_CALL)) {
+			err = record_call_access(env, instance, at_in[i], idx);
+			if (err)
+				goto err_free;
+		}
+
+		if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
+			kvfree(env->callsite_at_stack[idx]);
+			env->callsite_at_stack[idx] =
+				kvmalloc_objs(*env->callsite_at_stack[idx],
+					      MAX_ARG_SPILL_SLOTS, GFP_KERNEL_ACCOUNT);
+			if (!env->callsite_at_stack[idx]) {
+				err = -ENOMEM;
+				goto err_free;
+			}
+			memcpy(env->callsite_at_stack[idx],
+			       at_stack_in[i], sizeof(struct arg_track) * MAX_ARG_SPILL_SLOTS);
+		}
+		err = commit_stack_write_marks(env, instance, idx);
+		if (err)
+			goto err_free;
+	}
+
 	info->at_in = at_in;
 	at_in = NULL;
 	info->len = len;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7f03ec7e0e4..919822f67381 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1783,7 +1783,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
-	dst_state->cleaned = src->cleaned;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -20139,8 +20138,6 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i, err;
 
-	if (env->cur_state != st)
-		st->cleaned = true;
 	err = bpf_live_stack_query_init(env, st);
 	if (err)
 		return err;
@@ -20153,37 +20150,6 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* the parentage chains form a tree.
- * the verifier states are added to state lists at given insn and
- * pushed into state stack for future exploration.
- * when the verifier reaches bpf_exit insn some of the verifier states
- * stored in the state lists have their final liveness state already,
- * but a lot of states will get revised from liveness point of view when
- * the verifier explores other branches.
- * Example:
- * 1: *(u64)(r10 - 8) = 1
- * 2: if r1 == 100 goto pc+1
- * 3: *(u64)(r10 - 8) = 2
- * 4: r0 = *(u64)(r10 - 8)
- * 5: exit
- * when the verifier reaches exit insn the stack slot -8 in the state list of
- * insn 2 is not yet marked alive. Then the verifier pops the other_branch
- * of insn 2 and goes exploring further. After the insn 4 read, liveness
- * analysis would propagate read mark for -8 at insn 2.
- *
- * Since the verifier pushes the branch states as it sees them while exploring
- * the program the condition of walking the branch instruction for the second
- * time means that all states below this branch were already explored and
- * their final liveness marks are already propagated.
- * Hence when the verifier completes the search of state list in is_state_visited()
- * we can call this clean_live_states() function to clear dead the registers and stack
- * slots to simplify state merging.
- *
- * Important note here that walking the same branch instruction in the callee
- * doesn't meant that the states are DONE. The verifier has to compare
- * the callsites
- */
-
 /* Find id in idset and increment its count, or add new entry */
 static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
 {
@@ -20249,33 +20215,6 @@ static void clear_singular_ids(struct bpf_verifier_env *env,
 	}));
 }
 
-static int clean_live_states(struct bpf_verifier_env *env, int insn,
-			      struct bpf_verifier_state *cur)
-{
-	struct bpf_verifier_state_list *sl;
-	struct list_head *pos, *head;
-	int err;
-
-	head = explored_state(env, insn);
-	list_for_each(pos, head) {
-		sl = container_of(pos, struct bpf_verifier_state_list, node);
-		if (sl->state.branches)
-			continue;
-		if (sl->state.insn_idx != insn ||
-		    !same_callsites(&sl->state, cur))
-			continue;
-		if (sl->state.cleaned)
-			/* all regs in this state in all frames were already marked */
-			continue;
-		if (incomplete_read_marks(env, &sl->state))
-			continue;
-		err = clean_verifier_state(env, &sl->state);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap)
@@ -20976,7 +20915,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
 
-	err = clean_live_states(env, insn_idx, cur);
+	/* keep cleaning the current state as registers/stack become dead */
+	err = clean_verifier_state(env, cur);
 	if (err)
 		return err;
 

-- 
2.53.0
