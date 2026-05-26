Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FD3D7A19
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787830; cv=none; b=UqKa6OrwObwK0NUWYbZC+AHx+hark3knS10An5TUYiTRjhkai713ya1uK3axVUsfvsAaex8C2qZB7zD7L+nTrB+uBXF6R9R7e8T58arBgrG0DW38zrOa5GGICEtZ+a5N3Fy18xZ5tI1xKUObVI71i/6rbSnL7TNMFeRl1fpQMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787830; c=relaxed/simple;
	bh=TUTo84itgdYmtZ9TcYzipqIc2j08i2Isjqvh69JFaPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ezu7h2e7tSrVhXaFRhPL/L03Vg4wo/mKURwKSHsk7zTiFzWaqX5OieGPdZn3x5V+Fe1V0mLaP2YMVbELkCYOPmqENyXK9GEdqbKzt4TbpDsrD1McNoqVxxtj+p8vZ/6SAM2EMMki5dQNN8g/EVAXwOqbMqm8B5Maskvu9UIj+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaO2ltWv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaO2ltWv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-836ebdeb969so4618255b3a.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787828; x=1780392628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDU15w3vSS+C+zqYGNzqT44o+BIYFNhOhA5Kd1z9Wzo=;
        b=LaO2ltWvWfVrRKNfs+YMs/ZXBiXH/G282iTOCt33c/fqXRdQk//yzoS8RJE7nXETOu
         LUMghnXoRy7ITbkQ7FW2XHz5hv115MFs4CyG76yRYdTVvL05dx33WV4iPOugzsjlc8D0
         qzRB3hRAXnjHN6wmlrAk/iKL4lag5oFKokmcaPXcinTtTSmiDPR9FMGxDCZ//159SGiE
         OFCiZd43JbqbyHXe2e+VtzZQSK8yT0YFp0vcy1vXtc9xKuJ3c4rAd4APRQhJEc+aYjrq
         D2j/DySr+Wj5mshmj6Kyhx/nx6oYb7mWjgIuH8Os1hBVUnMOvyBN9jicUgEOA/BZFpjC
         XzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787828; x=1780392628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pDU15w3vSS+C+zqYGNzqT44o+BIYFNhOhA5Kd1z9Wzo=;
        b=qwMOMaXZx2FqwzVwEO5zKLKSv3f1cefvBb2XrNDLMFYBmjiY7oFD9pVrxLhVo6yDVk
         Bqa769c/yAjV3I2RW0fp6vCHCh4/8EKgGEjTVNs/u+HqJssx3UTop9ZcfoK8yrFe5eL1
         laAWF8FLI6hde6gJtyiC1oo4TxI6Eip0t9f0JOEpBfSWjU26BAnIz4ZA3IG0+32VG1j0
         U6RiPjz+jcObPhj4VeRCdxrMPM647CDGSto/o5xKC6I4t3sVt+SevaWv7LBRDgCDIRZd
         Y+EOOeChc6RkZONjShiv7+UTHnaD1QPe0tmctVWDd7d4JfXT9tiz+RGLZMq4UcwW7410
         daCg==
X-Gm-Message-State: AOJu0YwKJzfMcFlQRFz+qsZW0y6x3dquKsw6RdKN2f5YBXYpdcNjt+8Y
	xcxNYNHs7Nb59vVWx6GSoqYZGARWxBbrNrP6Qwr/ksamXEYag4FAkEbcteVUqrtMtPM=
X-Gm-Gg: Acq92OEXpRVCciUvpF6YWowHsQsguuGCZLzueNolX0pdXFMHEQaoq3VCnWTCSugcWOg
	LYbXN035YlEumsVHRfizO9PAlPgtiu2W2a+F2DAk+rkwq1OCa4zf3twv6EdjXADFMGpg5rrvE3P
	Up77v7KnUTNksQWAX1M4FoaTwTKxZu94DDmcf1pzx5STwkVTI7eL/CbX62vr30XRsyMgihspCXM
	80yKbEWi+Egb6Nw/NLosewxTGMWjyf/P9EGym391UmVE5q7/vNFQZ9ZIhGoRILJD5KJ46PxzzWZ
	1zRh6EWBuew79wdbYI52hWrGAjsF/5USqIwf7M+WDDn9yQzL9OEoSEKC9Cw0TpDEsb294TBe2OS
	qVxTHc4Jr8cZ9LiPqHl4jRrYnCdeIkwpj31hlZcHe9KyMRCI3QP0eoQDIEEfem3VX+xqpOGyNYv
	miiqQS8msRFMYd52chXScx30g9TmW49YRFoJXz1bSWyToTow3FhOI=
X-Received: by 2002:a05:6a00:3004:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-8415f37bf67mr15860168b3a.37.1779787828170;
        Tue, 26 May 2026 02:30:28 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 5/6] bpf: report register diff summary for hot callchains
Date: Tue, 26 May 2026 02:30:06 -0700
Message-ID: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When a hot callchain ends at a iter_next, may_goto, or
callback-calling instruction, compare cached states from
explored_states to identify which registers or stack slots most
frequently differ between states. Report the top 3 most varying
locations.

The full states diff computation would require some statistical
analysis similar to k-means. To keep things simple, approximate this
by modifying states_equal() to return the first location where old and
current states differ, and counting most frequent diff locations.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  14 ++++
 kernel/bpf/states.c          | 174 +++++++++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c        |  54 +++++++++++---
 3 files changed, 211 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 347a155d8e21..b48fcd411903 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,16 @@ struct bpf_loop {
 	bool irreducible;
 };
 
+struct bpf_state_diff {
+	u8 slot;
+	u8 frame;
+	enum {
+		DIFF_REG,
+		DIFF_STACK,
+		DIFF_ARG,
+	} kind;
+};
+
 struct bpf_callchain {
 	u32 insn_idx[MAX_CALL_FRAMES];
 	u32 curframe;
@@ -1631,5 +1641,9 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 
 int bpf_compute_loops(struct bpf_verifier_env *env);
+int bpf_sample_state_diffs(struct bpf_verifier_env *env,
+			   struct bpf_callchain *cc,
+			   struct bpf_state_diff *top_diffs,
+			   int *nr_diffs);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 877338136009..17b48d9f0c10 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -4,6 +4,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/cnum.h>
 #include <linux/filter.h>
+#include <linux/sort.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
@@ -696,7 +697,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
-		      enum exact_level exact)
+		      enum exact_level exact, struct bpf_state_diff *diff)
 {
 	int i, spi;
 
@@ -720,8 +721,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 				old_type = STACK_INVALID;
 			if (cur_type == STACK_POISON)
 				cur_type = STACK_INVALID;
-			if (i >= cur->allocated_stack || old_type != cur_type)
+			if (i >= cur->allocated_stack || old_type != cur_type) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 		}
 
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID ||
@@ -735,8 +739,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
-		if (i >= cur->allocated_stack)
+		if (i >= cur->allocated_stack) {
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
+		}
 
 		/*
 		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
@@ -748,8 +755,11 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
 			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
 			if (old_reg && cur_reg) {
-				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
+				if (!regsafe(env, old_reg, cur_reg, idmap, exact)) {
+					diff->slot = spi;
+					diff->kind = DIFF_STACK;
 					return false;
+				}
 				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
 				continue;
 			}
@@ -763,13 +773,16 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_ZERO)
 			continue;
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		    cur->stack[spi].slot_type[i % BPF_REG_SIZE]) {
 			/* Ex: old explored (safe) state has STACK_SPILL in
 			 * this stack slot, but current has STACK_MISC ->
 			 * this verifier states are not equivalent,
 			 * return false to continue verification of this path
 			 */
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
+		}
 		if (i % BPF_REG_SIZE != BPF_REG_SIZE - 1)
 			continue;
 		/* Both old and cur are having same slot_type */
@@ -786,16 +799,22 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			if (!regsafe(env, &old->stack[spi].spilled_ptr,
-				     &cur->stack[spi].spilled_ptr, idmap, exact))
+				     &cur->stack[spi].spilled_ptr, idmap, exact)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_DYNPTR:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_ITER:
 			old_reg = &old->stack[spi].spilled_ptr;
@@ -810,15 +829,21 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_IRQ_FLAG:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
-			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
+			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class) {
+				diff->slot = spi;
+				diff->kind = DIFF_STACK;
 				return false;
+			}
 			break;
 		case STACK_MISC:
 		case STACK_ZERO:
@@ -827,6 +852,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			continue;
 		/* Ensure that new unhandled slot types return false by default */
 		default:
+			diff->slot = spi;
+			diff->kind = DIFF_STACK;
 			return false;
 		}
 	}
@@ -839,7 +866,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
  */
 static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
-			   enum exact_level exact)
+			   enum exact_level exact, struct bpf_state_diff *diff)
 {
 	int i, nslots;
 
@@ -852,8 +879,11 @@ static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *
 			  &old->stack_arg_regs[i] : &not_init;
 		cur_arg = i < cur->out_stack_arg_cnt ?
 			  &cur->stack_arg_regs[i] : &not_init;
-		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
+		if (!regsafe(env, old_arg, cur_arg, idmap, exact)) {
+			diff->slot = i;
+			diff->kind = DIFF_ARG;
 			return false;
+		}
 	}
 
 	return true;
@@ -933,7 +963,8 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx,
+			      enum exact_level exact, struct bpf_state_diff *diff)
 {
 	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
 	u16 i;
@@ -947,13 +978,16 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
-			     &env->idmap_scratch, exact))
+			     &env->idmap_scratch, exact)) {
+			diff->slot = i;
+			diff->kind = DIFF_REG;
 			return false;
+		}
 
-	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact, diff))
 		return false;
 
-	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
+	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact, diff))
 		return false;
 
 	return true;
@@ -970,7 +1004,8 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 enum exact_level exact)
+			 enum exact_level exact,
+			 struct bpf_state_diff *diff)
 {
 	u32 insn_idx;
 	int i;
@@ -999,8 +1034,11 @@ static bool states_equal(struct bpf_verifier_env *env,
 		insn_idx = bpf_frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i],
+				       insn_idx, exact, diff)) {
+			diff->frame = i;
 			return false;
+		}
 	}
 	return true;
 }
@@ -1231,6 +1269,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state, *new;
+	struct bpf_state_diff diff = {};
 	bool force_new_state, add_new_state, loop;
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
@@ -1320,7 +1359,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -1345,13 +1384,13 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
 				if (sl->state.may_goto_depth != cur->may_goto_depth &&
-				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				    states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					loop = true;
 					goto hit;
 				}
 			}
 			if (bpf_calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
 					loop = true;
 					goto hit;
 				}
@@ -1359,7 +1398,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, EXACT) &&
+			    states_equal(env, &sl->state, cur, EXACT, &diff) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.may_goto_depth == cur->may_goto_depth &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
@@ -1392,7 +1431,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		}
 		/* See comments for mark_all_regs_read_and_precise() */
 		loop = incomplete_read_marks(env, &sl->state);
-		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
+		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT, &diff)) {
 hit:
 			sl->hit_cnt++;
 
@@ -1588,3 +1627,94 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	list_add(&new_sl->node, head);
 	return 0;
 }
+
+static bool callchain_matches_state(struct bpf_callchain *cc,
+				    struct bpf_verifier_state *st)
+{
+	int i;
+
+	if (st->curframe != cc->curframe)
+		return false;
+	for (i = 0; i < (int)cc->curframe; i++)
+		if (st->frame[i + 1]->callsite != cc->insn_idx[i])
+			return false;
+	return true;
+}
+
+struct state_diff_cnt {
+	struct bpf_state_diff diff;
+	u32 cnt;
+};
+
+static int state_diff_cmp(const void *a, const void *b)
+{
+	return ((struct state_diff_cnt *)b)->cnt - ((struct state_diff_cnt *)a)->cnt;
+}
+
+static bool state_diff_eq(struct bpf_state_diff *a, struct bpf_state_diff *b)
+{
+	return a->frame == b->frame && a->slot == b->slot && a->kind == b->kind;
+}
+
+int bpf_sample_state_diffs(struct bpf_verifier_env *env,
+			   struct bpf_callchain *cc,
+			   struct bpf_state_diff *top_diffs,
+			   int *nr_diffs)
+{
+	struct bpf_verifier_state_list *sl_i, *sl_j;
+	struct state_diff_cnt *diff_cnts = NULL;
+	struct list_head *pos_i, *pos_j, *head;
+	u32 leaf_insn, callsite, hash_idx;
+	int i, cap = 0, nr_locs = 0;
+
+	leaf_insn = cc->insn_idx[cc->curframe];
+	callsite = cc->curframe > 0 ? cc->insn_idx[cc->curframe - 1] : BPF_MAIN_FUNC;
+	hash_idx = (leaf_insn ^ callsite) % env->prog->len;
+	head = &env->explored_states[hash_idx];
+
+	list_for_each(pos_i, head) {
+		sl_i = container_of(pos_i, struct bpf_verifier_state_list, node);
+		if (!callchain_matches_state(cc, &sl_i->state))
+			continue;
+		list_for_each(pos_j, pos_i) {
+			struct bpf_state_diff diff = {};
+
+			sl_j = container_of(pos_j, struct bpf_verifier_state_list, node);
+			if (!callchain_matches_state(cc, &sl_j->state))
+				continue;
+			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))
+				continue;
+			for (i = 0; i < nr_locs; i++) {
+				if (state_diff_eq(&diff_cnts[i].diff, &diff)) {
+					diff_cnts[i].cnt++;
+					goto next;
+				}
+			}
+			if (nr_locs == cap) {
+				int new_cap = cap ? cap * 2 : 16;
+				struct state_diff_cnt *new;
+
+				new = kvrealloc(diff_cnts, new_cap * sizeof(*new),
+						GFP_KERNEL_ACCOUNT);
+				if (!new) {
+					kvfree(diff_cnts);
+					return -ENOMEM;
+				}
+				memset(new + cap, 0, (new_cap - cap) * sizeof(*new));
+				diff_cnts = new;
+				cap = new_cap;
+			}
+			diff_cnts[nr_locs].diff = diff;
+			diff_cnts[nr_locs].cnt = 1;
+			nr_locs++;
+next:;
+		}
+	}
+
+	sort(diff_cnts, nr_locs, sizeof(*diff_cnts), state_diff_cmp, NULL);
+	*nr_diffs = min(nr_locs, *nr_diffs);
+	for (i = 0; i < *nr_diffs; i++)
+		top_diffs[i] = diff_cnts[i].diff;
+	kvfree(diff_cnts);
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8eb8f1ce17c7..7a84eeae395f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17292,13 +17292,13 @@ static void free_callchain_profile(struct bpf_verifier_env *env)
 	}
 }
 
-static void print_callchain_entry(struct bpf_verifier_env *env,
-				  struct bpf_callchain_entry *entry, int idx)
+static int print_callchain_entry(struct bpf_verifier_env *env,
+				 struct bpf_callchain_entry *entry, int idx)
 {
 	struct bpf_callchain *cc = &entry->cc;
 	const struct bpf_line_info *linfo;
 	struct bpf_subprog_info *sub;
-	int i, insn_idx;
+	int i, err, insn_idx;
 
 	verbose(env, "#%d most visited simulated stacktrace (visited %llu times):\n",
 		idx, entry->count);
@@ -17316,6 +17316,35 @@ static void print_callchain_entry(struct bpf_verifier_env *env,
 				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
 		verbose(env, "\n");
 	}
+
+	insn_idx = cc->insn_idx[cc->curframe];
+	if (bpf_is_force_checkpoint(env, insn_idx)) {
+		struct bpf_state_diff top_diffs[3];
+		int nr_diffs = ARRAY_SIZE(top_diffs);
+
+		err = bpf_sample_state_diffs(env, cc, top_diffs, &nr_diffs);
+		if (err)
+			return err;
+		for (i = 0; i < nr_diffs; i++) {
+			struct bpf_state_diff *d = &top_diffs[i];
+
+			switch (d->kind) {
+			case DIFF_REG:
+				verbose(env, "    Most varying: R%d (frame %d)\n",
+					d->slot, d->frame);
+				break;
+			case DIFF_STACK:
+				verbose(env, "    Most varying: fp-%d (frame %d)\n",
+					(d->slot + 1) * BPF_REG_SIZE, d->frame);
+				break;
+			case DIFF_ARG:
+				verbose(env, "    Most varying: arg#%d (frame %d)\n",
+					d->slot, d->frame);
+				break;
+			}
+		}
+	}
+	return 0;
 }
 
 static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
@@ -17340,16 +17369,16 @@ static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subprog_info
  * Print several most visited simulated stack traces,
  * and a disasembly of related subprograms.
  */
-static void print_hotspots(struct bpf_verifier_env *env)
+static int print_hotspots(struct bpf_verifier_env *env)
 {
 	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) = {};
 	struct bpf_callchain_entry *top[3] = {};
 	struct bpf_callchain_entry *entry;
 	struct bpf_subprog_info *sub;
-	int i, j, bkt, nr_top = 0;
+	int i, j, err, bkt, nr_top = 0;
 
 	if (!(env->log.level & BPF_LOG_LEVEL))
-		return;
+		return 0;
 
 	/* Collect the hottest callchains */
 	hash_for_each(env->callchain_htab, bkt, entry, node) {
@@ -17366,7 +17395,7 @@ static void print_hotspots(struct bpf_verifier_env *env)
 		nr_top++;
 
 	if (!nr_top)
-		return;
+		return 0;
 
 	if (!(env->log.level & BPF_LOG_LEVEL2))
 		bpf_vlog_reset(&env->log, 0);
@@ -17388,9 +17417,14 @@ static void print_hotspots(struct bpf_verifier_env *env)
 
 	/* Print the hot callchains */
 	for (i = 0; i < nr_top; i++) {
-		print_callchain_entry(env, top[i], i + 1);
+		err = print_callchain_entry(env, top[i], i + 1);
+		if (err)
+			return err;
+
 		verbose(env, "\n");
 	}
+
+	return 0;
 }
 
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
@@ -17527,7 +17561,9 @@ static int do_check(struct bpf_verifier_env *env)
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
-			print_hotspots(env);
+			err = print_hotspots(env);
+			if (err)
+				return err;
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);

-- 
2.53.0
