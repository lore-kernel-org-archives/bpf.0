Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8030B3EC2E1
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142561; cv=none; b=iToS0bgDJV7R+43DCV6zG8pK4LFQj5M+NOOgumSwf+klKOmARrc0U/qqsZkZNNHq9xp0sX4N4nBfn5VawjigpRiavRAMx3YBpc0IRO8Vc391PcuD1GkNBTNXEvN2mzSFDjdnJaFnBXbU7mYmRbGZtb3ZAv+DMYEihgz8L2m2zZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142561; c=relaxed/simple;
	bh=HoSnjjCAkqpdnCoxJ/3w4HrlIQSgownAafEf6BNq73s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsOW2sO5Vt4fywwq5WGqiz74NSq76EpP6/SD+Q38+wkAFlmHhBbgyIEfPwLp9rrInap7wQYDA8zg85i7U/27OPTRCH7QP7eAM5Mf7GMNv7WE8nMQzlwcVY9m11sRcZsQHxOoUs118TFGqF+1zzNk3tS4t1YATZhZf/VhpPA7m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8dCxQvA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8dCxQvA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso9140765e9.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142558; x=1775747358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anSNJAAr99w5UeHjjhF8N+qQRQeBzj1ViKkiLc1W9Pk=;
        b=k8dCxQvAWk3M3JN1LjmrgvysqeHMI1CAVyXHyGfg8eQowHD+V3TJCsSH4mm8R4Zq52
         QUc6kel2z6scZyBc3mxd5a247OXjf5DUmOg8KgfJYNCxAEF1XOC8vSTZJkB8PGqrdDDt
         IRHw1hNSxQafDHVIZacwCeESHaBRh2xbx9ElmbsVaMehlFp75OfSU+ycDsFMusNC0TgG
         zmMiaYCVCU3qxlk2REElm8N9pN70nq6QFoOHhONAAqpdCBvq+1C1NIMdxJC72mMuT+Rz
         /9g9C0C53dOh00QB1rv340DILG5817ZW7KXuF2fiZ/8h2KQNsVKNK5FnrR12ZMag9aBi
         +iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142558; x=1775747358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anSNJAAr99w5UeHjjhF8N+qQRQeBzj1ViKkiLc1W9Pk=;
        b=A2icLLHJ6wbnv7Fsq1iMTVeApMMtOVcAThmMblO5owmTz6sEMG91cQdZq26VltxDJu
         9JUSb7gnGgKr1fd0Ybt+CCDNAZ34VlBwawlq6kVaRkN/qXG1Vj1qbTzCHB5fxFwLodiB
         njvpRxf59TvkzYvLcAZSstNZUDmDiI5Urtcvv74Xlp29gGLA3rFhsx9a8BN0xTiKXVno
         dq8xgxaMHqoBMdPT7GCzVATLO+jwUibA8MVN0OtYEMQO52ebX1MGrA8ckpS9SCLPVWo5
         oTTO+EiJou2qsUT4phL/xXgiUo7uPpWHtHkWgRqXfr4i9gn2N22U1q4ui3CN/OGnBs5f
         eQBw==
X-Gm-Message-State: AOJu0YxyQ4uBipDtPlS3MLddBgqSbptp8PmGcZQ0U1vmtYXmeFXrAlxs
	DHXwO6OsQZaEVjiI+dS4LTIvdtQulzUK4VqSlQi6W2OnUHEWYvGrnLM3eaSPC82g
X-Gm-Gg: ATEYQzymdjUJHSlOynkA1TeCEdfu6d+Rs+DBE9bmnIGjwSDhAaoB6e6SLQmdItDH3o2
	ioPrFaFGCaU56M3/q0DYRN38ZqAzp10wigJp3mE1WVLESzxQRbopYSDe1ArOCQ6UX9aVLVGENmD
	vX47fXhhaM+9mAMFh1p74YlDFZqAQGVJIB1tmjC5F+5YnhHuRqSMgftQgeegYUyK1CCewM6Aenc
	NFftw+6ao5cI29hzhF0Jgc8Ukx7Ow204O/TzSwHF5TUZmaeXZ+jkzk7NlixEyRgVslG7T7mP7pE
	HgEntklgurg8sF/+LJLQFrFNVZ3BnaWXhW9pEJzek8cz+G4+SvYR5z2pwFsagQwtd4R+IAM0xWO
	fFCVK1FJiu4v3/iS+vOS3N6KSS7j1SHfskGJee5WNjAZvsKf7qgmGs+zT2F2mc6TdwPLOtRrD/o
	xvgNfDUhqfaO5vHvSzDkJa/ypAHZ+Dgj+oQCQulm2eMnYQHarXHMJCt638zCkYSAJZyAppVSXnH
	Puop9CmIz792G508ejCNV742orK2CFK+tUhQX7xuTTxJC8GMyTIGh4Nn1Swj6ISGc7AekQBiIFJ
	I0KYSnaqAV+3klGKmvbU5r4M0Ih/w0hN/norj90dQnk=
X-Received: by 2002:a05:600c:8209:b0:485:5c6e:8a38 with SMTP id 5b1f17b1804b1-48883591d6amr156156245e9.17.1775142557794;
        Thu, 02 Apr 2026 08:09:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8f4b77sm67488115e9.33.2026.04.02.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:09:17 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:09:15 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
Message-ID: <260b0270052944a420e1c56e6a92df4d43cadf03.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>

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
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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
index 760cd137bf3f..15defae1d7ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17253,10 +17253,6 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
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
@@ -17265,30 +17261,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
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
 
@@ -17672,6 +17661,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	copy_register_state(&env->false_reg1, dst_reg);
+	copy_register_state(&env->false_reg2, src_reg);
+	copy_register_state(&env->true_reg1, dst_reg);
+	copy_register_state(&env->true_reg2, src_reg);
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >= 0) {
 		/* If we get here with a dst_reg pointer type it is because
@@ -17736,27 +17729,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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

