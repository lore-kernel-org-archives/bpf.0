Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171A584971
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202979; cv=none; b=J3cmgqt6zGmCINIEPqeakJtc4NEDKIalASCGt1rBDJYorjufHzZxWuHVwnNS7Fkp+SbuZyxVtzOfJptNu42fiul0uGhR3v0cVn2VGoMOozyS417W/XTys33fkBoj5eZgK6bSls9dCVFAMaB9TOC2htYARQ4tm7ba4UAaHYW/HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202979; c=relaxed/simple;
	bh=jsQCZrDF/kT1DqfoEjXF1QjVkKPgln4NpggN8Q/6zAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH6CaUdTZhZuQLryslJfngAZCGFjyzHqhckebWE7ryMkOmBUzQl4Js4HeVKtsIODia+7STBi6PATUXLYULCpDvtZzFq4KgPuOty8gElqJzfzgjoluv43IoAsT2GEI+lP8BjrQQDiM+L+J+9gg2mDputbDtJOuVNboN2H4yfyJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuJE806K; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuJE806K"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso933448a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202975; x=1790807775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqoaYFegdBiFcg/pNRLlrEg1DEBtldSdqUx/xaa2m64=;
        b=TuJE806KNs8Bb7bLmhbp/D7LmrXJzyjNkZxH7FVeB5cGkeXDrk7MNc9pZ1q/Sf7u3M
         64LXEEuhh7fyBtFrguOMjiZ/+t5ahpyz0UP6N/+QemcItJeIDzJjcfasMOm1GXtCTW9m
         ii55m327jL7AVOwJ905q52cQpLs1NF7CDoBbC/Q8oNdxTtgb2O6gtP39APQYbyQ5Oda5
         sDZE3Zq+z6K/yE3I8i95DpQikRwoEq3S8Fgla7uu0315zXVCRCtZrA7C0Myttqb/ZtpA
         ROzK6QG95ZQxxb0BRqgYkWA/0DwcN50sPlNayoe8xHA5QVgS06LvfsamIwiLvkBPbgPr
         XmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202975; x=1790807775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqoaYFegdBiFcg/pNRLlrEg1DEBtldSdqUx/xaa2m64=;
        b=WjkODpGZ4vRFN9UdEOlzM03xZUPElY3NWsELfBtJ+WHeSc0g2bIRPW+14pFHts/FOU
         oxHQNMTaTyKGvVK0YELnwFcfN+kWuR6WCY1Dr+iOFg442xUWu3mp8oqUvUwhF5tO1Fdg
         LHaFKsWEOkGhq3YiVRapLhluyrl/dPxGsYPFq9nN8S8lNAgULdszoihhDCnRi8psqOH7
         VmVt+cvUMZX4aID9fepW1J+pgc0X/UgbKLfc5v+Fzg6twZ+m2gKlu9TJvQjmRKS3wRuZ
         jzHVZq3T2pO7dHZWC8jDA9mClWHnmAlNyP5kFKMgMoih/h2AKY0w/wlOvs/zH4xO3wXp
         UKGA==
X-Gm-Message-State: AFuF++kITWMgzP1G5h04poFGZ+lViLhHqMj/Y+TsA7UTKbbMp+etw0ud
	XcUbmaI67EB6gM90okEq6IQqFKAuGFw/BnPS3+HZwbvaWarM/xPK3a/1vSyx8A==
X-Gm-Gg: AYBFou12gawNi6HcJbtJ+gY3znqLmluDrFnPurBkffjV8wqqP9/1YDrYLkYQ6Bxd7IL
	DgrEXGX4U0ESNvViqnWZ2nAlsw9XcXcbiu4GDUSTAlurgA8fUQ63ECHSE/Lp1kAKgvYAQyVLNUf
	WTtsCJ+SgRzPaCBhbEHF7be7CqOvpF6bGxD4vY4XtelcvWTp1x2qmSpWESiPVniD/t38KJADSxu
	RUMT81MVXVmwbQLuEN4y1Q50FQwSkzkP76Hvt+ZK6/lzKlJeQYQH7wSce7gbIPha1+19uoT6guj
	RjMhN5TwUB/1tqPf3s7U3DFWR3lMK5uhEH9iWkBWow6dO3RMrAiRGDEOTM/2GBSpoWcVtGLhe97
	ovtHe3ozmGkIoR7/JO4TOI7yJuUlhhjPoJUuB/NL5yQ6N6Ck+ibMA75CZrmygF24RWOMy6Od+dK
	PYJe7yjg368jDCc0sd0mOH6RfIC3Y/LcPOpSoaEsSt8trgCyCJBE4gYPUNeGf76Bgs8xDFk/N38
	x1blKFJuXlxGL8rKZ5a8e28HZ7J4v9XJJjCWD9Xe8Cz1BPCi80ATht0+4BWZqz0JtfXfFWixHXW
	ECG+bUkYMiEa1pWoJRvX8lYD+NGYZLIRmYMRwGEmb2oH
X-Received: by 2002:a17:90b:3c07:b0:3a0:8050:2ec4 with SMTP id 98e67ed59e1d1-3a098b4b114mr402503a91.20.1790202975285;
        Wed, 23 Sep 2026 15:36:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097344841sm1125059a91.10.2026.09.23.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/8] bpf: Walk loops with widened states first
Date: Wed, 23 Sep 2026 22:35:52 +0000
Message-ID: <20260923223554.562379-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Widening gives up precision. A loop that initializes one stack slot per
iteration or advances a pointer along with the counter cannot be verified
with the counter being a range. may_goto cannot be added to the loop
that holds a reference.

Walk the program with widening first. If that walk fails restore
everything it changed outside of verifier states: insn_aux_data,
subprog_info, func_info_aux, flags of the prog, counters and the log,
and walk every iteration as before. The program is accepted when either
walk accepts it. It is all or nothing for the main program and global
functions: may_goto added to a loop of a static function is there for
all callers. The insns processed by the walk that failed are reported
separately:

  processed 258028 insns (limit 1000000) max_states_per_insn 27 ...
  walks with widened loops that failed processed 24102 insns

Offloaded programs are walked the old way. The driver sees every insn
that is visited.

veristat for selftests, 5251 programs: nothing that was accepted is
rejected. 4 programs that were rejected are accepted: the loops in them
can exit, but don't have to. 126 programs are walked twice. Their stats
of the second walk are the same as before.
Total insns of programs accepted before and after go from 5569499 to
4774715 plus 88708 in walks that failed (-12.7%).

File                         Program                          Insns A Insns B      Diff
loop1                        nested_loops                      361349     135   -99.96%
bpf_iter_tasks               dump_task_sleepable                85521     583   -99.32%
verifier_loops1              jumps_out_rather_than_in           40004      15   -99.96%
timer_start_delete_race      start_timer                        40008      49   -99.88%
profiler2                    tracepoint__syscalls__sys_enter_   51274   26746   -47.84%
verifier_iterating_callbacks loop_inside_iter_volatile_limit    22026     114   -99.48%
verifier_iterating_callbacks loop_inside_iter                   19022      90   -99.53%
verifier_iterating_callbacks loop_inside_iter_signed            19022      90   -99.53%
access_map_in_map            access_map_in_array                18462      49   -99.73%
access_map_in_map            access_map_in_htab                 18462      49   -99.73%
access_map_in_map            sleepable_access_map_in_array      18462      49   -99.73%
access_map_in_map            sleepable_access_map_in_htab       18462      49   -99.73%
timer_start_delete_race      delete_elem                        14004      19   -99.86%
linked_list                  clear_global_array_list            13071     108   -99.17%
...
iters                        stack_misc_vs_scalar_in_a_loop       106     120   +13.21%
profiler2                    kprobe__proc_sys_write              3268    4210   +28.82%
profiler2                    raw_tracepoint__sched_process_ex    3846    6907   +79.59%
xdp_lb_bench                 xdp_lb_bench                       27529   30974   +12.51%

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/verifier.c        | 167 ++++++++++++++++++++++++++++++++++-
 2 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fb35f8a7aedd..e02ee286067d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1068,6 +1068,8 @@ struct bpf_verifier_env {
 	bool widen_loops;
 	/* the walk did or tried that, so a failure can be due to the lost precision */
 	bool widen_used;
+	/* insns processed by a walk that was given up */
+	u32 insn_wasted;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2fb5a66bd7d4..871aa45031d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20536,6 +20536,122 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	return ret;
 }
 
+/* What a walk changes outside of verifier states and per insn data. */
+struct walk_snapshot {
+	struct bpf_insn_aux_data *insn_aux;
+	struct bpf_func_info_aux *func_aux;
+	struct bpf_subprog_info *subprogs;
+	struct bpf_prog *prog;
+	u64 log_pos, diag_pos;
+	u32 insn_processed, prev_insn_processed;
+	u32 jmps_processed, prev_jmps_processed;
+	u32 total_states, peak_states, max_states_per_insn, longest_mark_read_walk;
+	u32 explored_states_size, free_list_size, num_backedges;
+	u32 id_gen, pass_cnt, max_stack_depth;
+	u32 max_ctx_offset, max_pkt_offset, max_tp_access, max_rdonly_access, max_rdwr_access;
+	bool seen_direct_write, seen_exception, explore_alu_limits, tail_call_reachable;
+	void *arena;
+};
+
+static void walk_snapshot_free(struct walk_snapshot *s)
+{
+	kvfree(s->insn_aux);
+	kvfree(s->func_aux);
+	kvfree(s->subprogs);
+	kfree(s->prog);
+}
+
+static size_t func_aux_size(struct bpf_verifier_env *env)
+{
+	return array_size(env->prog->aux->func_info_cnt, sizeof(*env->prog->aux->func_info_aux));
+}
+
+static int walk_snapshot_save(struct bpf_verifier_env *env, struct walk_snapshot *s)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+
+	memset(s, 0, sizeof(*s));
+	s->insn_aux = kvmemdup(env->insn_aux_data,
+			       array_size(env->prog->len, sizeof(*env->insn_aux_data)),
+			       GFP_KERNEL_ACCOUNT);
+	s->subprogs = kvmemdup(env->subprog_info, sizeof(env->subprog_info), GFP_KERNEL_ACCOUNT);
+	/* flags of the program, not its insns */
+	s->prog = kmemdup(env->prog, offsetof(struct bpf_prog, insnsi), GFP_KERNEL_ACCOUNT);
+	if (aux->func_info_aux)
+		s->func_aux = kvmemdup(aux->func_info_aux, func_aux_size(env), GFP_KERNEL_ACCOUNT);
+	if (!s->insn_aux || !s->subprogs || !s->prog || (aux->func_info_aux && !s->func_aux)) {
+		walk_snapshot_free(s);
+		return -ENOMEM;
+	}
+	s->log_pos = env->log.end_pos;
+	s->diag_pos = bpf_diag_event_log_save(env);
+	s->insn_processed = env->insn_processed;
+	s->prev_insn_processed = env->prev_insn_processed;
+	s->jmps_processed = env->jmps_processed;
+	s->prev_jmps_processed = env->prev_jmps_processed;
+	s->total_states = env->total_states;
+	s->peak_states = env->peak_states;
+	s->max_states_per_insn = env->max_states_per_insn;
+	s->longest_mark_read_walk = env->longest_mark_read_walk;
+	s->explored_states_size = env->explored_states_size;
+	s->free_list_size = env->free_list_size;
+	s->num_backedges = env->num_backedges;
+	s->id_gen = env->id_gen;
+	s->pass_cnt = env->pass_cnt;
+	s->max_stack_depth = env->max_stack_depth;
+	s->seen_direct_write = env->seen_direct_write;
+	s->seen_exception = env->seen_exception;
+	s->explore_alu_limits = env->explore_alu_limits;
+	s->max_ctx_offset = aux->max_ctx_offset;
+	s->max_pkt_offset = aux->max_pkt_offset;
+	s->max_tp_access = aux->max_tp_access;
+	s->max_rdonly_access = aux->max_rdonly_access;
+	s->max_rdwr_access = aux->max_rdwr_access;
+	s->tail_call_reachable = aux->tail_call_reachable;
+	s->arena = aux->arena;
+	return 0;
+}
+
+static void walk_snapshot_restore(struct bpf_verifier_env *env, struct walk_snapshot *s)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+
+	memcpy(env->insn_aux_data, s->insn_aux,
+	       array_size(env->prog->len, sizeof(*env->insn_aux_data)));
+	memcpy(env->subprog_info, s->subprogs, sizeof(env->subprog_info));
+	memcpy(env->prog, s->prog, offsetof(struct bpf_prog, insnsi));
+	if (s->func_aux)
+		memcpy(aux->func_info_aux, s->func_aux, func_aux_size(env));
+	env->insn_wasted += env->insn_processed - s->insn_processed;
+	env->insn_processed = s->insn_processed;
+	env->prev_insn_processed = s->prev_insn_processed;
+	env->jmps_processed = s->jmps_processed;
+	env->prev_jmps_processed = s->prev_jmps_processed;
+	env->total_states = s->total_states;
+	env->peak_states = s->peak_states;
+	env->max_states_per_insn = s->max_states_per_insn;
+	env->longest_mark_read_walk = s->longest_mark_read_walk;
+	env->explored_states_size = s->explored_states_size;
+	env->free_list_size = s->free_list_size;
+	env->num_backedges = s->num_backedges;
+	env->id_gen = s->id_gen;
+	env->pass_cnt = s->pass_cnt;
+	env->max_stack_depth = s->max_stack_depth;
+	env->seen_direct_write = s->seen_direct_write;
+	env->seen_exception = s->seen_exception;
+	env->explore_alu_limits = s->explore_alu_limits;
+	aux->max_ctx_offset = s->max_ctx_offset;
+	aux->max_pkt_offset = s->max_pkt_offset;
+	aux->max_tp_access = s->max_tp_access;
+	aux->max_rdonly_access = s->max_rdonly_access;
+	aux->max_rdwr_access = s->max_rdwr_access;
+	aux->tail_call_reachable = s->tail_call_reachable;
+	aux->arena = s->arena;
+	if (!(env->log.level & BPF_LOG_LEVEL2))
+		bpf_vlog_reset(&env->log, s->log_pos);
+	bpf_diag_event_log_restore(env, s->diag_pos);
+}
+
 /* Lazily verify all global functions based on their BTF, if they are called
  * from main BPF program or any of subprograms transitively.
  * BPF global subprogs called from dead code are not validated.
@@ -20617,6 +20733,51 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/*
+ * Walk the program with loops widened first. It is much less work when it
+ * succeeds. If it fails the reason can be the precision that widening gave
+ * up. Then undo everything that walk did, so that the walk of every
+ * iteration that follows can't tell that it is not the first one.
+ * It is all or nothing for the main program and global functions, because
+ * may_goto added to a loop of a static function is there for all callers.
+ */
+static int do_check_prog(struct bpf_verifier_env *env)
+{
+	struct walk_snapshot snap;
+	int ret;
+
+	/* no loops without bpf_capable, the driver of an offloaded prog sees every insn visit */
+	if (!env->bpf_capable || env->scc_cnt <= 1 || bpf_prog_is_offloaded(env->prog->aux)) {
+		ret = do_check_main(env);
+		return ret ?: do_check_subprogs(env);
+	}
+
+	env->scc_converged = kvzalloc_objs(*env->scc_converged, BITS_TO_LONGS(env->scc_cnt),
+					   GFP_KERNEL_ACCOUNT);
+	if (!env->scc_converged)
+		return -ENOMEM;
+	ret = walk_snapshot_save(env, &snap);
+	if (ret)
+		return ret;
+
+	env->widen_loops = true;
+	env->widen_used = false;
+	ret = do_check_main(env);
+	ret = ret ?: do_check_subprogs(env);
+	if (!ret && env->widen_used)
+		ret = bpf_commit_loop_guards(env);
+	env->widen_loops = false;
+	if (ret && ret != -ENOMEM && ret != -EAGAIN && ret != -EFAULT && env->widen_used) {
+		walk_snapshot_restore(env, &snap);
+		if (env->log.level & BPF_LOG_LEVEL)
+			verbose(env, "walk with widened loops failed, walking every iteration\n");
+		ret = do_check_main(env);
+		ret = ret ?: do_check_subprogs(env);
+	}
+	walk_snapshot_free(&snap);
+	return ret;
+}
+
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
@@ -20645,6 +20806,9 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
 		env->max_states_per_insn, env->total_states,
 		env->peak_states, env->longest_mark_read_walk);
+	if (env->insn_wasted)
+		verbose(env, "walks with widened loops that failed processed %d insns\n",
+			env->insn_wasted);
 }
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
@@ -22287,8 +22451,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = do_check_main(env);
-	ret = ret ?: do_check_subprogs(env);
+	ret = do_check_prog(env);
 
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
-- 
2.55.0

