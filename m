Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D9E283FF5
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892523; cv=none; b=m5UWiJU7qfOTFVKYlen/IsOPjO4jAj2/qdAeZKd72+hBMf0LngaddrhmFqiLHF8KoC3zU47MGiJnN6A+EeqBOEpUJU3z77XbwhFqMGOr0QVcCsqGMSMI+jwaCrUOWzAnzwzp1Zxa3o5qoxGA8gdcRwPHnD1WPZoB8q10icF9lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892523; c=relaxed/simple;
	bh=Ob9yb+fUJCM941miKiOpLXz4N9YrJcQ8i3ZKPKDm+rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u57VAXk2A2n4/JWKH4MjIeB7aEg32dNTnSIRIm7suykfm3L1SRaILUzNMZFISyw6yDWl81slaGdPCU9e/PaKgH5WunuT1V5pm0Ptnampqq3cKwIxu7MuFSnuenxvnvnczQME2WmrwIzmag3TE03D4Z/C63JMI/MEQrmyzIGQYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTos295I; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTos295I"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so112578f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892519; x=1786497319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ug97+W0CBRUVwqjGse+cpak2K+uOm+Q/QBsWj52vLBI=;
        b=KTos295IgfsjsLtxi3obBWVpdmchfnTvLvLnQ47O1VVYDRSBzD3G0SWv0cEHqCO4Md
         GWF3pSwU23Bd2Lly+1FTTNVhqeiAHSIfIEjZxQRgluHBfY85NUzx7V4i/CG78fNpx6aU
         9vEDvfQREaOf5XJtXy/nywYL/4mlbmciaNFsDwJEk4qv9pwHssLs97VoqTs7eNUMxX2A
         4AOqrBk17mQAMt5Rk76kOA3tCgIJwzHx0tWys5xe+qheM/bfzHo447n5gGUTxsjp6YMN
         O7V0E9SHu7dqIgQtl96j9ciJu5LIlfko/itoXVCnylbW+SqgXaful4E6VugT7HSVdyFP
         CALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892519; x=1786497319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ug97+W0CBRUVwqjGse+cpak2K+uOm+Q/QBsWj52vLBI=;
        b=Q+KQeiRG2CK/MnQ9yResxJamd2XyAkvXD/KEnffZTY+aLvRem6JLac4RHt/vkGtwyV
         qMYRpHUyV4YWayw967SzFrlCi6q5jinZriaJK435HKXOLWaRWxLHRRo/SHTcDYxw+Sya
         OPmhby9PkpL4cSena7N/4hQ/DVLlBz5TeGKCHXLxvEBB5OMiqj150YhMOoLl803ok8ll
         TbG1WR24DGCDPGpBUbigiH/AEJHPNjkznpMYlI2b49HSa+h/Q1nTlU0WTivPjZadiupr
         dhGJ0DaR3sck/5sGJ+riK+4vEKlHDHhxuyt7ly+LajGXgnDyhr+qxOyKRtUm79ycSJHW
         eTiQ==
X-Gm-Message-State: AOJu0YyWc6zxlmJt2ggJAuP8MMzmCRhHprjILhDLJ8N7uiC7ecPnx0ix
	1oY2WKz6aGR9v9NEglmUHR9TnJgAFhIB4ePymBbEJ2wC25F/M5DDwerx2h8pobsh
X-Gm-Gg: AR+sD12kDHJHj8kIOEgiR3P1DHaAYkmnPrbUPCvHr8gSU2/l0mZYpo37zJcAIc+rKdh
	qBLkVyOW6g7rAvCTXF9L+x774pO4eq3sz2vWT4equiEL63FBt+LMiUoPY0QAt3xQRG+oikmPgr/
	iM8RFdiq0bHAc75Z2ly2zMglpVzhu8h69/pwVoqj/S1m4c+vrlBX3EsHQuJV8PwR/r42IT7xf7z
	Qs5tjTZ0tbgNqVPdICBpag/yMUOsHzhyzhUC6tuPr9N4qvcHiO6F0l2Srtmyx74kzj0Fx47lk9b
	KA5IFqEPdPjFQioO+IgfwWOLUNMCqJh1F6WF/HKJwsHee+3vQvzEJIqKPM1P/Yp/QRdBuVWFPCF
	NgH7IiGfNZPGTmTjRN8+/SblKxle/76SGsurqHpTfWAehobr3FlsQKO9CwfVFwhbB0zjGmtYxls
	OP4yw6KvsMRUUprhBP4+pKfxa9QzP/VYUUkLvyYMnRvjQdXtagaiHIpY+U57UnQp6JiBfI+gfTP
	xi2dZMQRGjIwilOS/uRyW/EKo60fI2cJNw6GqTjYsvfNVoJo2uMJMXrzT1MOfKsBPERYb5XoIKx
	Fr7O/LO1vXNtoHjpBylNv2VBX4c=
X-Received: by 2002:a05:6000:2489:b0:47f:9260:4bc9 with SMTP id ffacd0b85a97d-47fec634b2cmr4628834f8f.29.1785892519091;
        Tue, 04 Aug 2026 18:15:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e533sm4366652f8f.28.2026.08.04.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 1/6] bpf: Track verifier instruction stats for each subprogram
Date: Wed,  5 Aug 2026 03:15:09 +0200
Message-ID: <20260805011517.1717238-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7692; i=memxor@gmail.com; h=from:subject; bh=Ob9yb+fUJCM941miKiOpLXz4N9YrJcQ8i3ZKPKDm+rY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz0UlcdafpBUP16VJcM+cWSWl6r2nYH3ClizuTRO+T PGbJmvQUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInc42H4Kznn0VqNuQ6WJfMZ mla9fl5T8KT5ZJ71JqUX35oyUh8mpDMyvF926g7jGYspcx3WR8rqP13az8d1SsV7vt+KlLnO92Y s4gcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier currently records one instruction count for the main program
and each global subprogram checked independently. Static subprograms are
explored within callers, so their verification cost cannot be reported
separately.

Track both own and inclusive instruction counts for every subprogram.
Charge each processed instruction as own work to the current subprogram and
to a path-local subtotal in its function frame. When a function returns, add
the callee subtotal to its inclusive count and to its parent subtotal. Fold
any remaining frames when a path terminates or is pruned.

Instruction subtotals are accounting state, not semantic verifier state.
Clear them when a verifier state is copied so work before a path fork is
charged once, rather than again when a saved branch is explored.

This generic frame accounting also records own and inclusive totals when an
asynchronous callback starts as a fresh frame-zero state. It does not yet
charge that independently explored callback path back to the main or global
exploration root which scheduled it. That will be done in subsequent changes.

This does not change the verification statistics output format. It only
prepares the counters for per-subprogram reporting.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 +++-
 kernel/bpf/verifier.c        | 50 +++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..9de45ade473b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -385,6 +385,8 @@ struct bpf_func_state {
 	 *                           | number of simulations is tracked in frame N
 	 */
 	u32 callback_depth;
+	/* Instructions processed in this frame and callees on the current path. */
+	u32 insns_subtotal;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -803,7 +805,8 @@ struct bpf_subprog_info {
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
-	u32 insn_processed;
+	u32 insns_total;
+	u32 insns_own;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
 	 * are used for bpf_fastcall spills and fills.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7439afdc851a..88e7ea6fbe73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1593,6 +1593,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
+	/* Instruction accounting is path-local, not part of verifier state. */
+	dst->insns_subtotal = 0;
 	return copy_stack_state(dst, src);
 }
 
@@ -9807,6 +9809,37 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
+static void account_processed_insn(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *frame = cur_func(env);
+
+	env->insn_processed++;
+	frame->insns_subtotal++;
+	env->subprog_info[frame->subprogno].insns_own++;
+}
+
+static void account_processed_insns(struct bpf_verifier_env *env,
+				    struct bpf_func_state *callee,
+				    struct bpf_func_state *caller)
+{
+	u32 insns = callee->insns_subtotal;
+
+	env->subprog_info[callee->subprogno].insns_total += insns;
+	if (caller)
+		caller->insns_subtotal += insns;
+	callee->insns_subtotal = 0;
+}
+
+static void account_current_path(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int frame;
+
+	for (frame = state->curframe; frame >= 0; frame--)
+		account_processed_insns(env, state->frame[frame],
+					frame ? state->frame[frame - 1] : NULL);
+}
+
 /* Are we currently verifying the callback for a rbtree helper that must
  * be called with lock held? If so, no need to complain about unreleased
  * lock
@@ -9903,6 +9936,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
+	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
@@ -17496,7 +17530,9 @@ static int do_check(struct bpf_verifier_env *env)
 		insn = &insns[env->insn_idx];
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
-		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
+		account_processed_insn(env);
+
+		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
@@ -17636,6 +17672,7 @@ static int do_check(struct bpf_verifier_env *env)
 					    "speculation barrier after jump instruction may not have the desired effect"))
 				return -EFAULT;
 process_bpf_exit:
+			account_current_path(env);
 			mark_verifier_state_scratched(env);
 			err = bpf_update_branch_counts(env, env->cur_state);
 			if (err)
@@ -18680,6 +18717,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
+	account_current_path(env);
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
@@ -18711,7 +18749,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
-	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18726,8 +18763,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_subprog_is_global(env, i))
 			continue;
 
-		insn_processed = env->insn_processed;
-
 		sub_aux = subprog_aux(env, i);
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
@@ -18735,7 +18770,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
-		env->subprog_info[i].insn_processed = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18762,12 +18796,10 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
-	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
-	env->subprog_info[0].insn_processed = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
@@ -18786,10 +18818,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
 		verbose(env, " max %d\n", env->max_stack_depth);
-		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
+		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-				verbose(env, "+%d", env->subprog_info[i].insn_processed);
+				verbose(env, "+%d", env->subprog_info[i].insns_total);
 		verbose(env, "\n");
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
-- 
2.53.0

