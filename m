Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CC1C5D59
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245593; cv=none; b=ZTqa0jZEYMoju3HFNk9ob8fsuGZVDSYMENrwARr/D8ztL1xie7kPpvL9T64jNUwyBQis1peBISUM7CXkr0HRzXpwJHPKzWjwLcq4/54Jzd3CHyx2bvKwep7nFlmCBy9dNTx1BT+7MFj7/lHnmYPgaYEeiIyR3IyTOTSXMF7ROWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245593; c=relaxed/simple;
	bh=knKkDJO7DY7fp6ejOltkag4SDnS7VGBSaSepxgU6KNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBl/kSxo6gyinbOsZCqeESqFixB3/XPJ7KKhVTOQWN2kVtVnRXtGnqckIbAsQw7lglWCsmro3aOvsmp80NOPukJKBNiePUal2UuzLu9fFciUQJUiug0LfbLMuLfKxiKjKoqEt31DzUzt1T5o3Y0NTQWFZdaQ8bu9Rl7bKfWvcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B4czKOJH; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B4czKOJH"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc1c9879395so3516530a12.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245591; x=1788850391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2aEsgdEWN2H1TH5cS8sr7/K+SvKNqRGWtDeSlDiIT6Q=;
        b=pTFGbRCdrQ9qLaybMJ4DU9rEff76GYWtZLEglIJqvbDLUCybrNSDbzCw1+7piClGN+
         hTRPu7Sh6PwEymdnGTeqthUnYgNwDhzBlpcdesE/Ogj9W4weUF3dJjTgTBMu8Kkq91FT
         NrvmQxwRHhG2aZr1yN5jgy0fPtcsnxRMoW6LMTirY5gpEcwPai7pksCBN5sGS9jCD8kV
         uBvqgEykmvXXQrSwgh+e3vjCs7TICDA6FOY4F6YZ82zj83JUINDjDC1FVuOBdSk2iYJY
         y0KIZDUDVxo/Oef07xmhwTTIQDvDCBnjCYwuK258MCHNAJfHEYlrqnEAQvoFlgVMuamm
         yyVw==
X-Forwarded-Encrypted: i=1; AKwUvBztrVMYs0f/BqaaFOqm0z031xXUkC/LrfvDxvSNC5KL8zsY2canRLz1agcUbaHTQWgBhHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kPYQfKNlSu/Lcbo87kZ0qsChKKi/UocoorlDh3SEYxra1UtSSz
	GppnXxMynJdeNfHyZZypv2Xw/ME6IqFUkRQVzWeJ+6KAKuBsLEtnVfIh/30+URLsCzyxdvnknLj
	+BaY8ejj9Jw8liBIWNZ/jwN8zaR7cC0ww2AY6kI+mgm6pUMnroMnr5NeSGrq/W9HZqhY+EzCflW
	s/YfcamOFT04z568Q4RDwp/flNzut61CYGxLdtW+8lSDjl4kxkYw8SuRE3GFx6goh2nr12WOsHk
	tKlL3c=
X-Gm-Gg: AYBFou2U/BO+/NnEjEIHQ6xGCzhJHnOjlVr5GWJmOODQP7emRqw0HhRv6em57lhoztp
	Rdu0Exkga9TfzqpHrttwK5h7B9rt/YfZ1tKuEoeje6un7EzgE5HSJl95Pfofe3rEK4PxQ3M9764
	w/TnK10nLAzNZmPb7VZOIIu6v18ZRGoWL9q0Y/GhGvImQSe23rR1eHBvlmbpBDa0fDHmf2o4EPT
	w0o4v/2mpkfaoIMmYG1lyJVdp1KscBiooou5VBn63PihKXiqqToyDfzKRyxN9VZtCPNbvkNvvms
	f6ZpKAEMI6BbuHRVJWiHaP5CHSPolLNINH+zrVh+iAasvLbTN02rMSbelfWFxwyldyHjrD2or18
	tTI/7q4pM4qgQYi/DdjMXLc6gglsddqPDgl0PHNPvujuumbkPVIqVFfurKKbFLnYqhYFZ06vbG5
	uFv4JBJFH9vTO9J0rRgfzM9DFNwiMsw+Tp
X-Received: by 2002:a17:90b:4c0b:b0:398:9c0c:7c72 with SMTP id 98e67ed59e1d1-3989c0c7ffemr32289250a91.25.1788245590539;
        Mon, 31 Aug 2026 23:53:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3990c5fb4f4sm727819a91.6.2026.08.31.23.53.10
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2026 23:53:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so118852396d6.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788245589; x=1788850389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aEsgdEWN2H1TH5cS8sr7/K+SvKNqRGWtDeSlDiIT6Q=;
        b=B4czKOJHOoP+lmM6BW63tIQXGKMdH3npCvKZriVzH1mThNzzncwUw9d7ChLfNpU15t
         9UJYhzPOIFDJLpAABGDsF0s2eDmH9iw+ZxHQ3QFX3jtwZJTTOf9rjINYsbfAMKnS/ve8
         IMyXRXRbI3U9IJEBjgAQM96zgyptgWx3dOEcU=
X-Forwarded-Encrypted: i=1; AKwUvBy9ffxyJyey2rkNX06A8la35pJLoosFlvDR4D5SknUdC9sdqLAW/pyGo9qN/CfOtVdmohg=@vger.kernel.org
X-Received: by 2002:a05:6214:20ab:b0:90e:96d1:40d3 with SMTP id 6a1803df08f44-90e96d14161mr23448816d6.20.1788245589195;
        Mon, 31 Aug 2026 23:53:09 -0700 (PDT)
X-Received: by 2002:a05:6214:20ab:b0:90e:96d1:40d3 with SMTP id 6a1803df08f44-90e96d14161mr23448386d6.20.1788245588660;
        Mon, 31 Aug 2026 23:53:08 -0700 (PDT)
Received: from photon-dev-haas ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e89af6288sm45058006d6.27.2026.08.31.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 23:53:08 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v6.18] bpf: fix the return value of push_stack
Date: Tue,  1 Sep 2026 06:23:11 +0000
Message-ID: <20260901062311.1150953-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Anton Protopopov <a.s.protopopov@gmail.com>

commit 6ea5fc92a0fc1cde976cb701db2c1dba4dcab7cf upstream.

In [1] Eduard mentioned that on push_stack failure verifier code
should return -ENOMEM instead of -EFAULT. After checking with the
other call sites I've found that code randomly returns either -ENOMEM
or -EFAULT. This patch unifies the return values for the push_stack
(and similar push_async_cb) functions such that error codes are
always assigned properly.

  [1] https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20251019202145.3944697-2-a.s.protopopov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Ajay: Modified to apply on v6.18 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/bpf/verifier.c | 81 ++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 459ed14..62e4ffd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2110,7 +2110,7 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2120,12 +2120,12 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	env->stack_size++;
 	err = copy_verifier_state(&elem->st, cur);
 	if (err)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	elem->st.speculative |= speculative;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
 		verbose(env, "The sequence of %d jumps is too complex.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-E2BIG);
 	}
 	if (elem->st.parent) {
 		++elem->st.parent->branches;
@@ -2974,7 +2974,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 
 	elem = kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL_ACCOUNT);
 	if (!elem)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
@@ -2986,7 +2986,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 		verbose(env,
 			"The sequence of %d jumps is too complex for async cb.\n",
 			env->stack_size);
-		return NULL;
+		return ERR_PTR(-E2BIG);
 	}
 	/* Unlike push_stack() do not copy_verifier_state().
 	 * The caller state doesn't matter.
@@ -2997,7 +2997,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	elem->st.in_sleepable = is_sleepable;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL_ACCOUNT);
 	if (!frame)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_func_state(env, frame,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno within this callchain */,
@@ -9116,8 +9116,8 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
 		/* branch out active iter state */
 		queued_st = push_stack(env, insn_idx + 1, insn_idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -10687,8 +10687,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
 					 is_async_cb_sleepable(env, insn));
-		if (!async_cb)
-			return -EFAULT;
+		if (IS_ERR(async_cb))
+			return PTR_ERR(async_cb);
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = caller->async_entry_cnt + 1;
 
@@ -10704,8 +10704,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * proceed with next instruction within current frame.
 	 */
 	callback_state = push_stack(env, env->subprog_info[subprog].start, insn_idx, false);
-	if (!callback_state)
-		return -ENOMEM;
+	if (IS_ERR(callback_state))
+		return PTR_ERR(callback_state);
 
 	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
 			       callback_state);
@@ -13958,9 +13958,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		struct bpf_reg_state *regs;
 
 		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
-		if (!branch) {
+		if (IS_ERR(branch)) {
 			verbose(env, "failed to push state for failed lock acquisition\n");
-			return -ENOMEM;
+			return PTR_ERR(branch);
 		}
 
 		regs = branch->frame[branch->curframe]->regs;
@@ -14426,16 +14426,15 @@ struct bpf_sanitize_info {
 	bool mask_to_left;
 };
 
-static struct bpf_verifier_state *
-sanitize_speculative_path(struct bpf_verifier_env *env,
-			  const struct bpf_insn *insn,
-			  u32 next_idx, u32 curr_idx)
+static int sanitize_speculative_path(struct bpf_verifier_env *env,
+				     const struct bpf_insn *insn,
+				     u32 next_idx, u32 curr_idx)
 {
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *regs;
 
 	branch = push_stack(env, next_idx, curr_idx, true);
-	if (branch && insn) {
+	if (!IS_ERR(branch) && insn) {
 		regs = branch->frame[branch->curframe]->regs;
 		if (BPF_SRC(insn->code) == BPF_K) {
 			mark_reg_unknown(env, regs, insn->dst_reg);
@@ -14444,7 +14443,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
 			mark_reg_unknown(env, regs, insn->src_reg);
 		}
 	}
-	return branch;
+	return PTR_ERR_OR_ZERO(branch);
 }
 
 static int sanitize_ptr_alu(struct bpf_verifier_env *env,
@@ -14463,7 +14462,6 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 alu_state, alu_limit;
 	struct bpf_reg_state tmp;
-	bool ret;
 	int err;
 
 	if (can_skip_alu_sanitation(env, insn))
@@ -14536,11 +14534,12 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		tmp = *dst_reg;
 		copy_register_state(dst_reg, ptr_reg);
 	}
-	ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
-					env->insn_idx);
-	if (!ptr_is_dst_reg && ret)
+	err = sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->insn_idx);
+	if (err < 0)
+		return REASON_STACK;
+	if (!ptr_is_dst_reg)
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -17008,8 +17007,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		/* branch out 'fallthrough' insn as a new state to explore */
 		queued_st = push_stack(env, idx + 1, idx, false);
-		if (!queued_st)
-			return -ENOMEM;
+		if (IS_ERR(queued_st))
+			return PTR_ERR(queued_st);
 
 		queued_st->may_goto_depth++;
 		if (prev_st)
@@ -17087,10 +17086,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * the fall-through branch for simulation under speculative
 		 * execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			err = sanitize_speculative_path(env, insn, *insn_idx + 1, *insn_idx);
+			if (err < 0)
+				return err;
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		*insn_idx += insn->off;
@@ -17100,11 +17100,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * program will go. If needed, push the goto branch for
 		 * simulation under speculative execution.
 		 */
-		if (!env->bypass_spec_v1 &&
-		    !sanitize_speculative_path(env, insn,
-					       *insn_idx + insn->off + 1,
-					       *insn_idx))
-			return -EFAULT;
+		if (!env->bypass_spec_v1) {
+			err = sanitize_speculative_path(env, insn, *insn_idx + insn->off + 1,
+							*insn_idx);
+			if (err < 0)
+				return err;
+		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
 		return 0;
@@ -17127,8 +17128,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
 				  false);
-	if (!other_branch)
-		return -EFAULT;
+	if (IS_ERR(other_branch))
+		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
 
 	if (BPF_SRC(insn->code) == BPF_X) {
@@ -17427,8 +17428,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 		mark_reg_scratched(env, BPF_REG_0);
 		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
-		if (!branch)
-			return -EFAULT;
+		if (IS_ERR(branch))
+			return PTR_ERR(branch);
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		err = prepare_func_exit(env, &env->insn_idx);
 		if (err)
-- 
2.53.0

