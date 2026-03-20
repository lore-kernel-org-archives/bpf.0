Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B413D1719
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025357; cv=none; b=AW3EQpt2F+pI1qIlkgvKprbx64dPup8YY8XobKQkC9M+YwAfnsZB6yivFfdZOVBgnZb5+SIZm2HRfXuman73tc12NMzMqskqF6hLFR++KGaAgkcNdg8rCiP33yEXrM+vW358fabAGBMEdwU68kg5WfBcilJzCesgjxA+mMaJArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025357; c=relaxed/simple;
	bh=jHw3El0uIyIpwSx6+3Ng2dGwgPF6ERjPqZ1KgR/RLHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMtBvI5EPl7EaiE1IExQHaysriXMa7L5sWnrNPVTnBTASAcWeRSPZcRMFbRfj5adHNmgAkJHMsFNNuRBDLDZFUD82vWCEdQajxW2C1edDxROQvUyl7RCwBBvbf/AvZwM2QE5CA2Q/d44E36SxAYKKwMGf7pr7mIGy4nhTHgPYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqBemTQ0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqBemTQ0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so7114665e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025354; x=1774630154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWS72DfN+hsMC4uD/Y7JIWFTLSim7vaKbXxSaKM0Z3s=;
        b=KqBemTQ0+1AZtvvmJKzecpN1eHnSd2oSapZNryHaHJXjhA0vKN0eiUeMgoXmKCyPZG
         vZ9cY9NLbuP2h/jy6eRHtuJhFjUnaR7UbsJaIYv+8AHlgtqvxOpeEM1/ShLP02YyEUv6
         sBXklT4TZ3EmjcTtHGL32xEr0rNnOug0oSs6PwKBpsF++0lYQZO9zjTdRj8GhV7NsXJU
         nnCY8H4WKsbYospTBV4MEZfMJiDHAQO/Lzs0p4/IyTF7po3Bqpq/Z9T3z6XinGq3M9Fy
         8dKjA07ZJu2mKsNlhKa87M9lF/tn18M1dxHeOs50AthtCnRZMjAVScequqPDk/w5pAe6
         HeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025354; x=1774630154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWS72DfN+hsMC4uD/Y7JIWFTLSim7vaKbXxSaKM0Z3s=;
        b=jdwjWRke5bFfzvOCQFqDgaR3wvaLDMatJGhAgeLiOdX8XnOHzIzeoQ7X4TOa7Zp6Pc
         lsNhk1T+wfEPIfFt8E+OlovUwr6ZvDd1cMg/a+gPd7NVHrf8jt3Wpx2rfHNEJU4Eymmh
         EL9iI+zpePb9n0rSFad10E1nC30Gr2Pc4UWQnSFa34pA41zKNYGelYqKurB0ccObLMJT
         hg/HEvLnWfXOpddZvHel42Fr/pYwdLqkXA9y2UUajQ1T/Uaog8kQA8+tZpFgva1SIN2z
         qZ8pWnjgrIBtPsn520xoBWBsZkkx0Jez0U+BvDjt8M9zxP6ArfPknX5hNf9Akvjo6dLw
         Hdrw==
X-Gm-Message-State: AOJu0YzGIFwYce752dE4mEOqdKVG0xchoy/Bn4wsQsQwJKmRcdjkxBVg
	zVfFtnZeBiuK/acT5chzg3ILuCzMxQRdie4UnDBJYcqc7+b4aXIVhwumKMSJc+rg
X-Gm-Gg: ATEYQzwkFjdh24MueXGzqL7ZIh5n7NkOkYrJUpaoVr5FUXkraibC/irJ/fr2Gczm+9+
	OflD2/WK7cjeg4Fl2STx36yX2hjXFYDjHYJtJFdOdSAfuhuvkCpW1ehqzQX1+hy9h0CSOzlC5pg
	N1JLqw8wDkZNPIL17lOExuPUhwSkW3Fa2z7UGF2e3K3wZA7JKHttqsMmZyei2kuz7Gyyqt0wyxr
	v4/KUvZVtWmDfrh+zLlJRfhAd1EDHUNWq9Nx1cZsbAEm7HdpFMjev2yGzKue6eUSiKdjkU7QE7I
	vnL93lxbiYFSloWy0zopspIdEFlbPWwK5urkISR4KlDitaAkJ5BGiAT6ctLXDryTcdgpAxqUSC5
	HXeq/1UI5c+kjQ/pH63dwBvnSiJ8sXtOKPhU8Ujy1jeTqspg9C+6w7N6MMqc2QLIn/RVvRH4jey
	9wNl9MjJsibAykb6xQxz3Mxvd93UlslpWQ8jfmW+GZFzJ5RX/aJ0+xe27Knu7pDuOaUUZvP2lYw
	lzCBvAkdnwwg5VaB3wic7vSptzVt4RHBZCwl9qdbpAx1Rb0M4xtkWmwLaXJB9Au03rL2DC1VGeS
X-Received: by 2002:a05:600c:4705:b0:486:f8d6:5dea with SMTP id 5b1f17b1804b1-486fee0b743mr52938645e9.19.1774025354417;
        Fri, 20 Mar 2026 09:49:14 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e2665sm85467395e9.6.2026.03.20.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:49:13 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:49:09 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774025082.git.paul.chaignon@gmail.com>

In a subsequent patch, the regs_refine_cond_op and reg_bounds_sync
functions will be called in is_branch_taken instead of reg_set_min_max,
to simulate each branch's outcome. Since they will run before we branch
out, these two functions will need to work on temporary registers for
the two branches.

This refactoring patch prepares for that change, by introducing the
temporary registers on bpf_verifier_env and using them in
reg_set_min_max.

This change also allows us to save one fake_reg slot as we don't need to
allocate an additional temporary buffer in case of a BPF_K condition.

Finally, you may notice that this patch removes the check for
"false_reg1 == false_reg2" in reg_set_min_max. That check was introduced
in commit d43ad9da8052 ("bpf: Skip bounds adjustment for conditional
jumps on same scalar register") to avoid an invariant violation. Given
that "env->false_reg1 == env->false_reg2" doesn't make sense and
invariant violations are addressed in a subsequent commit, this patch
just removes the check.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/linux/bpf_verifier.h |  4 ++-
 kernel/bpf/verifier.c        | 64 +++++++++++++-----------------------
 2 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 090aa26d1c98..b129e0aaee20 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -837,7 +837,9 @@ struct bpf_verifier_env {
 	u64 scratched_stack_slots;
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
-	struct bpf_reg_state fake_reg[2];
+	struct bpf_reg_state fake_reg[1];
+	/* buffers used to save updated reg states while simulating branches */
+	struct bpf_reg_state true_reg1, true_reg2, false_reg1, false_reg2;
 	/* buffer used to generate temporary string representations,
 	 * e.g., in reg_type_str() to generate reg_type string
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b638ab841c10..fbc29fb96a60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17184,10 +17184,6 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
  * but we don't support that right now.
  */
 static int reg_set_min_max(struct bpf_verifier_env *env,
-			   struct bpf_reg_state *true_reg1,
-			   struct bpf_reg_state *true_reg2,
-			   struct bpf_reg_state *false_reg1,
-			   struct bpf_reg_state *false_reg2,
 			   u8 opcode, bool is_jmp32)
 {
 	int err;
@@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	 * variable offset from the compare (unless they were a pointer into
 	 * the same object, but we don't bother with that).
 	 */
-	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
-		return 0;
-
-	/* We compute branch direction for same SCALAR_VALUE registers in
-	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
-	 * on the same registers, we don't need to adjust the min/max values.
-	 */
-	if (false_reg1 == false_reg2)
+	if (env->false_reg1.type != SCALAR_VALUE || env->false_reg2.type != SCALAR_VALUE)
 		return 0;
 
 	/* fallthrough (FALSE) branch */
-	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
-	reg_bounds_sync(false_reg1);
-	reg_bounds_sync(false_reg2);
+	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
+	reg_bounds_sync(&env->false_reg1);
+	reg_bounds_sync(&env->false_reg2);
 
 	/* jump (TRUE) branch */
-	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
-	reg_bounds_sync(true_reg1);
-	reg_bounds_sync(true_reg2);
-
-	err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
-	err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
-	err = err ?: reg_bounds_sanity_check(env, false_reg1, "false_reg1");
-	err = err ?: reg_bounds_sanity_check(env, false_reg2, "false_reg2");
+	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
+	reg_bounds_sync(&env->true_reg1);
+	reg_bounds_sync(&env->true_reg2);
+
+	err = reg_bounds_sanity_check(env, &env->true_reg1, "true_reg1");
+	err = err ?: reg_bounds_sanity_check(env, &env->true_reg2, "true_reg2");
+	err = err ?: reg_bounds_sanity_check(env, &env->false_reg1, "false_reg1");
+	err = err ?: reg_bounds_sanity_check(env, &env->false_reg2, "false_reg2");
 	return err;
 }
 
@@ -17597,6 +17586,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	copy_register_state(&env->false_reg1, dst_reg);
+	copy_register_state(&env->false_reg2, src_reg);
+	copy_register_state(&env->true_reg1, dst_reg);
+	copy_register_state(&env->true_reg2, src_reg);
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >= 0) {
 		/* If we get here with a dst_reg pointer type it is because
@@ -17661,27 +17654,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
 
-	if (BPF_SRC(insn->code) == BPF_X) {
-		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      &other_branch_regs[insn->src_reg],
-				      dst_reg, src_reg, opcode, is_jmp32);
-	} else /* BPF_SRC(insn->code) == BPF_K */ {
-		/* reg_set_min_max() can mangle the fake_reg. Make a copy
-		 * so that these are two different memory locations. The
-		 * src_reg is not used beyond here in context of K.
-		 */
-		memcpy(&env->fake_reg[1], &env->fake_reg[0],
-		       sizeof(env->fake_reg[0]));
-		err = reg_set_min_max(env,
-				      &other_branch_regs[insn->dst_reg],
-				      &env->fake_reg[0],
-				      dst_reg, &env->fake_reg[1],
-				      opcode, is_jmp32);
-	}
+	err = reg_set_min_max(env, opcode, is_jmp32);
 	if (err)
 		return err;
 
+	copy_register_state(dst_reg, &env->false_reg1);
+	copy_register_state(src_reg, &env->false_reg2);
+	copy_register_state(&other_branch_regs[insn->dst_reg], &env->true_reg1);
+	if (BPF_SRC(insn->code) == BPF_X)
+		copy_register_state(&other_branch_regs[insn->src_reg], &env->true_reg2);
+
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
 	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
-- 
2.43.0

