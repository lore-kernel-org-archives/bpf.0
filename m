Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65631D367
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698421; cv=none; b=KhJFPABD9LuvZbgamm7rhKw/RuOIeUDfb13mz7L8ITDDClDcsKH3axhdXN3gTQu0B6gnSuzWL3WXYpwyr/gypHc0PM7EqEiQDSIP1H81zBktza6EZQwdlt5cIjb7XfjWgL6/9ieRp19AAXq86mB4KxbQU7HjE/JEJQEo3iVgJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698421; c=relaxed/simple;
	bh=LFsjOxk7mKBytCGhgUK0mMkSKikD5FW9Q73ki0ogDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJiq4n5+JoPsq1bEDeRkS/ZiKCd46a/FUMAOVTsiXmwbD4KsZGb9U8esGC9nIe8B0dk6OrzTpvSXCNDqzCJuxrw5RZFF2mpz78OYOcgSAeO6gdOmLosXi9VITV2hgqoHvJ/UMSvT8kpPq3Igu3JOZesauKoKpdaXICsO7gye5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUnm3xA5; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUnm3xA5"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1279eced0b9so276993c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698415; x=1776303215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hbt5CQcdw2NtD+DbHN/MWLj2o2UkuEkvtcL6Ez54W8=;
        b=sUnm3xA50yHu0bEz8TrDafu/nUrCalw6vHO1EPbSZT4YHuRc7frAZPyPi4hdCqDjkf
         stHnEBtmTkMjIhx6/8bqPgrSDQudYLyOc1GP0mM6DVeh5ICkN+OIlZcGY7FUmBLc3745
         ce7vMbRTL0puYSvA6zCLqKXO5mJsoU7nVUGgI+Gb6uRf7U2Ig25uIGGJUW0a6oMa5Kgx
         qnc3+Vx/CtJCaZMruU0HI4NDcbUCTEDPf5q+gD/QpIkAj7ak5YzxguSpRjnELBKqbMf3
         Ou3+VH8/9HJ17aQI3f9psK+1xhFA42UJcqXXEQSnQdBzmG9Q9wluFGcGrJdpWgu6G/O4
         OT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698415; x=1776303215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hbt5CQcdw2NtD+DbHN/MWLj2o2UkuEkvtcL6Ez54W8=;
        b=gI+3HXRdeW67zvVV8G8iLAoku17AVfAW0xODoe7IMb5XJT+y7Eh5oftEJGJ55nWOe1
         m4CPxTlraUFxRKWImMWdDBoK/LE3hf7Z4n1K4sHuMBIw6NbQBGwueum2RU+a9gPuhUbf
         XruWySKAO17dhbHvajWN4WQlIhP6vB3c9DE+G1OXW3WaOIDB9AqjFhApC8nnoKEQ9W3T
         dhyDS0+JN294mBBbr6yqrL9e3vHu4pELf3RBnKQau3awhf/F/3AgBIXltaq99ZCrGyUF
         WzuxEuGkQRyqD/gKjQTCcbs6x2friXfMmHb2ehI6j216tWu0VwpaT2ZVBaItIvZzFJbz
         GDJQ==
X-Gm-Message-State: AOJu0Yx7df2b2pI7smHKCdQOeXQHR7daRzHWhFPgH/uu7zXrDZUcGOzN
	C3+/SXaFIAGx6VPXsb6eF3GkMNd+baRhyqqZCOl+xlrEh14h49aKRQOHAPmKYLNo
X-Gm-Gg: AeBDieuFMlG+4PtdOwK+TiTwPAaTaNfrlMio12JxgphFF3HD2HCM52h5W5b8jWf1CX2
	3e4BztGGJWewnZZjcuwMU0SUT2T+zOJWQLTYr37XlEsuFYFBdvjoo0RvMAs45GzGeA2NvhO5y8W
	wmILtUWOZlanndXKQ/r5zFpJh7hQiDpOimvremAGzo+Mk6eyqT7SWkSBR60vQetwPgAP/QJQ2AM
	pnnOe3uvdQLD7+d+X4Ln/xDn/MyZkN9EmUiHlzWDehEObfCdTlGoCdLu3POPsPEBxm6IueOyzel
	XsiF6weg+RsWNgYqVMXmQiPjjIX2FenF88sN1Yx0DvtVmyJfQIeKZ4j6sKtEioOHh5Iwq5d0v0Q
	fzbhpaclQuY3nDzSPa3NeG2hZ/gMGPhLDkSx8H5O7VFEtHiROqxxldqmYiHn400ru6CZb+6Vsgn
	Pw5ImNmbBd1EXy6Yq/MU3thnfRkj89WnXr9SieB0W8/9lKo289C9SvCgVEdFVxkn0SFHV3Q79qy
	d+Jof9mbX6DVQ==
X-Received: by 2002:a05:7022:68a2:b0:12b:ebc9:2464 with SMTP id a92af1059eb24-12c28bfbd14mr899419c88.22.1775698415372;
        Wed, 08 Apr 2026 18:33:35 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:34 -0700 (PDT)
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
Subject: [PATCH bpf-next 08/14] bpf: record arg tracking results in bpf_liveness masks
Date: Wed,  8 Apr 2026 18:33:10 -0700
Message-ID: <20260408-patch-set-v1-8-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
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

In clean_live_states(), start cleaning the current state continuously
as registers and stack become dead, and drop the incomplete_read_marks
check for cached states since the static analysis provides complete
liveness information.

Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/liveness.c        | 209 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   9 +-
 3 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 202de7f09bca864f2750d4d9fdea5e95f1f722ed..0cc415bfc851750fe658fb0920482e77ba0fc9be 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -226,6 +226,7 @@ enum bpf_stack_slot_type {
 
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
+#define STACK_SLOT_SZ		4
 #define STACK_SLOTS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)	/* 128 */
 
 typedef struct {
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 4f77487202505212da1ca6d4f5a3c4f52318d1c2..4457cd80d072b9b506bb2ef8ad477bd7e3403c2c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1422,6 +1422,202 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+static void record_stack_access_off(struct bpf_verifier_env *env,
+				    struct func_instance *instance, s64 fp_off,
+				    s64 access_bytes, u32 frame, u32 insn_idx)
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
+		return;
+	if (access_bytes == S64_MIN) {
+		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, 0, slot_hi);
+		mark_stack_read(instance, frame, insn_idx, mask);
+		return;
+	}
+	if (access_bytes > 0) {
+		/* Mark any touched slot as use */
+		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
+		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
+		mask = SPIS_ZERO;
+		spis_or_range(&mask, slot_lo, slot_hi);
+		mark_stack_read(instance, frame, insn_idx, mask);
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
+}
+
+/*
+ * 'arg' is FP-derived argument to helper/kfunc or load/store that
+ * reads (positive) or writes (negative) 'access_bytes' into 'use' or 'def'.
+ */
+static void record_stack_access(struct bpf_verifier_env *env,
+				struct func_instance *instance,
+				const struct arg_track *arg,
+				s64 access_bytes, u32 frame, u32 insn_idx)
+{
+	int i;
+
+	if (access_bytes == 0)
+		return;
+	if (arg->off_cnt == 0) {
+		if (access_bytes > 0)
+			mark_stack_read(instance, frame, insn_idx, SPIS_ALL);
+		return;
+	}
+	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
+		/* multi-offset write cannot set stack_def */
+		return;
+
+	for (i = 0; i < arg->off_cnt; i++)
+		record_stack_access_off(env, instance, arg->off[i], access_bytes, frame, insn_idx);
+}
+
+/*
+ * When a pointer is ARG_IMPRECISE, conservatively mark every frame in
+ * the bitmask as fully used.
+ */
+static void record_imprecise(struct func_instance *instance, u32 mask, u32 insn_idx)
+{
+	int depth = instance->callchain.curframe;
+	int f;
+
+	for (f = 0; mask; f++, mask >>= 1) {
+		if (!(mask & 1))
+			continue;
+		if (f <= depth)
+			mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+	}
+}
+
+/* Record load/store access for a given 'at' state of 'insn'. */
+static void record_load_store_access(struct bpf_verifier_env *env,
+				     struct func_instance *instance,
+				     struct arg_track *at, int insn_idx)
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
+		return;
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
+	if (ptr->frame >= 0 && ptr->frame <= depth) {
+		record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
+	} else if (ptr->frame == ARG_IMPRECISE) {
+		record_imprecise(instance, ptr->mask, insn_idx);
+	}
+	/* ARG_NONE: not derived from any frame pointer, skip */
+}
+
+/* Record stack access for a given 'at' state of helper/kfunc 'insn' */
+static void record_call_access(struct bpf_verifier_env *env,
+			       struct func_instance *instance,
+			       struct arg_track *at,
+			       int insn_idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int depth = instance->callchain.curframe;
+	struct bpf_call_summary cs;
+	int r, num_params = 5;
+
+	if (bpf_pseudo_call(insn))
+		return;
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
+			for (int f = 0; f <= depth; f++)
+				mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			return;
+		}
+		if (bytes == 0)
+			continue;
+
+		if (frame >= 0 && frame <= depth) {
+			record_stack_access(env, instance, &at[r], bytes, frame, insn_idx);
+		} else if (frame == ARG_IMPRECISE) {
+			record_imprecise(instance, at[r].mask, insn_idx);
+		}
+	}
+}
+
 /*
  * For a calls_callback helper, find the callback subprog and determine
  * which caller register maps to which callback register for FP passthrough.
@@ -1665,11 +1861,18 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 	if (changed)
 		goto redo;
 
+	/* Record memory accesses using converged at_in (RPO skips dead code) */
 	for (p = po_end - 1; p >= po_start; p--) {
 		int idx = env->cfg.insn_postorder[p];
 		int i = idx - start;
 		struct bpf_insn *insn = &insns[idx];
 
+		reset_stack_write_marks(env, instance);
+		record_load_store_access(env, instance, at_in[i], idx);
+
+		if (insn->code == (BPF_JMP | BPF_CALL))
+			record_call_access(env, instance, at_in[i], idx);
+
 		if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
 			kvfree(env->callsite_at_stack[idx]);
 			env->callsite_at_stack[idx] =
@@ -1680,6 +1883,7 @@ static int compute_subprog_args(struct bpf_verifier_env *env,
 			memcpy(env->callsite_at_stack[idx],
 			       at_stack_in[i], sizeof(struct arg_track) * MAX_ARG_SPILL_SLOTS);
 		}
+		commit_stack_write_marks(env, instance, idx);
 	}
 
 	info->at_in = at_in;
@@ -1755,6 +1959,11 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 				 */
 				if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
 					continue;
+				for (int f = 0; f <= depth; f++) {
+					err = mark_stack_read(instance, f, idx, SPIS_ALL);
+					if (err)
+						return err;
+				}
 				continue;
 			}
 			if (callee < 0)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 535a1cbaaafe6fae5fd0797540294e0a72e93751..838f164f803fae7bb7fc203cd7e1225adb75ad7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20261,6 +20261,13 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 	struct bpf_verifier_state_list *sl;
 	struct list_head *pos, *head;
 
+	/* keep cleaning the current state as registers/stack become dead */
+	clean_verifier_state(env, cur);
+
+	/*
+	 * can simply return here, since cached states will also be clean,
+	 * but keep old logic for the sake of dynamic liveness.
+	 */
 	head = explored_state(env, insn);
 	list_for_each(pos, head) {
 		sl = container_of(pos, struct bpf_verifier_state_list, node);
@@ -20272,8 +20279,6 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.cleaned)
 			/* all regs in this state in all frames were already marked */
 			continue;
-		if (incomplete_read_marks(env, &sl->state))
-			continue;
 		clean_verifier_state(env, &sl->state);
 	}
 }

-- 
2.53.0
