Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805E3EF0A8
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142649; cv=none; b=Ood8ld38fKxUp7iu+MzHTRYWlccaq00/xHGHszsnB3Eo860pyNTTU1KcoO/+VWTgG0uSddqbxgzEqfAHJsrL9kKseCkMt7pC3RVtobGE5Dj2ScRhoypLsMeWMGGPKpwnDBkPrJXIochOJncpxN8KLi/Ts6yzvYpi82WglsEC8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142649; c=relaxed/simple;
	bh=59nyxk6d5FSV8mx9qcjzmDkAmQ/MYYWAiIc3hzb0nzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwNLo7da2L43ETBkSPWVX/ARKOanKGyVKXBeFyXXn+p0lkvNIWPEjXZIZ28FaumB3DKdAnr0GDO44CyCpGUkCKPGBVlXH2m9wrZmJ6qb/r1fCywC8XIFjGAazxvIVT/Nx161RPvDX/LDn1puAYgH+bPmPV/2TUm2X24vuKmaC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAO9jOyi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAO9jOyi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso13767105e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142646; x=1775747446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Es1I1R863F7QiZwcoMaPlOsPHMypq/nLOrijoaQ/rl8=;
        b=GAO9jOyiuNYBfllEwLbPvukHuUSNa90O7rSX3WDqpJ9yhWUcdsLb/Cq/khrnJCnPfU
         eBPamupXTLoVHOEFNQOXB0gErWkydTOrAFhUtF48oasa/udfdBahG1hHysvae1fv5If6
         rtDDkihffEeHnxHdI7dzuWhsSX/zYflXx2W6hugEXaYXUjBeuDEbxvqHrHIKpXKs1N9g
         R5B4hpvOYNfjO5Ac7/iUeSr6RToObc+7FORAf6XTDzzI3z77oGYCDWupvqcoA/yleWVv
         oxYqCxm432z9/rjy28yjVLvM8WBe1ZNN6jAjBiVJ/la0WZ2N6O5w3+aTRJUlLTsLFIaW
         ftqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142646; x=1775747446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es1I1R863F7QiZwcoMaPlOsPHMypq/nLOrijoaQ/rl8=;
        b=KE6uAnPcFgwZ1eOfcjJtf9rprpRKN7MH2oHkETWdUPMIIcxR+ynWTxy08T0XFzBCwF
         qR4O60GUOF82S0EnPyVjtwwQ2FAE30SulChp+fSLGqdaXkAaYf+99p78a6tBWgbSLOU3
         Ptl3FK3ayjOtpypkGWu/aVFJlKaWU7qgLfw4XO37ayHoxsBLODdIc1g1w5xcweQ6MF+l
         1m1hvbNKCy637W3l6HLddrzp8zWHVvkGoxStzi8QuVDLu59cXHhdqBYi05p45P8uX609
         rEfG7SPbNP884jiMpZ1A+CHYCHdMTXIp8wWyS85wdYcKMpOBGpV3lTJsClH8SpIPs2iu
         w6/Q==
X-Gm-Message-State: AOJu0Ywaxau4z6/Ewz7k1K0Gsiq3ZyBTr3gmIPzfBhHaRSRKEQ7wGHNw
	NHSSpHJSNHpMhGO46yt5xGktsteDmRSPKgkhypf58amuAtA1aI/a4MnewZ4vMt5o
X-Gm-Gg: ATEYQzyoh1VwjkhWOLAhuJIVBCaGolQH+zNYSu4/rbM9L+ldGXbjw+Kek1ireLYMvRf
	sLu9+rrcpp21PF8e5shCYjIdSYTbq9uTZTRPX0F12Nci02gJ43hY9LWtBN4gS0GIm5k6IZp3U3+
	Roh2PRnSQ4pKF/MZDD2WJz7o0+MlxlhnPN0sbtFCnoDw2VYwfVWnc1pYT5h5UdwS278urt5+1X3
	HlZnqGZIw8/jH1m250ByaGmXG4Avox7pc7UlHXtMpofOJrJmN7PB+9yANjdVi/ikvwbZzbisw3g
	d2aXlOan71Ole94ZnViE6EhOcV+DhPQfpxfMWp80oiFylZ6Ii+JmDiBKyOZgoyy2v3EA3azDWV+
	8U+mEV+7mnAw1ThCGBz6q+AWnGM8XUF32uJqJJ/872Arc/hGz4jkuqzhpf9eDB7taoTXhutAwD9
	Bf+vc67xT4iwopywv241e4ZA4d6iTEGVkHfT+qaU23wvjhif+3i+PQeavfVPVPUyh/mZX0tRyR6
	72RG8In5lPlD5ja2chP8iElrUIS5dEK04XQ/OljcV04rb0Bd/B6drmcQvk+7R0eYWeH6CpJIoqp
	bh7QrSaGJl0w9dVhWBbwPtDTaJP0f0qnI44tvnlHWD4=
X-Received: by 2002:a05:600c:4ece:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4888e04f610mr41132415e9.4.1775142646003;
        Thu, 02 Apr 2026 08:10:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm11040355e9.8.2026.04.02.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:10:44 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:10:43 +0200
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
Subject: [PATCH bpf-next v3 4/6] bpf: Simulate branches to prune based on
 range violations
Message-ID: <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
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

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This patch fixes the invariant violations that can happen after we
refine ranges & tnum based on an incorrectly-detected branch condition.
For example, the branch is always true, but we miss it in
is_branch_taken; we then refine based on the branch being false and end
up with incoherent ranges (e.g. umax < umin).

To avoid this, we can simulate the refinement on both branches. More
specifically, this patch simulates both branches taken using
regs_refine_cond_op and reg_bounds_sync. If the resulting register
states are ill-formed on one of the branches, is_branch_taken can mark
that branch as "never taken".

On a more formal note, we can deduce a branch is not taken when
regs_refine_cond_op or reg_bounds_sync returns an ill-formed state
because the branch operators are sound (verified with Agni [1]).
Soundness means that the verifier is guaranteed to produce sound
outputs on the taken branches. On the non-taken branch (explored
because of imprecision in the bounds), the verifier is free to produce
any output. We use ill-formedness as a signal that the branch is dead
and prune that branch.

This patch moves the refinement logic for both branches from
reg_set_min_max to their own function, simulate_both_branches_taken,
which is called from is_scalar_branch_taken. As a result,
reg_set_min_max now only runs sanity checks and has been renamed to
reg_bounds_sanity_check_branches to reflect that.

We have had five patches fixing specific cases of invariant violations
in the past, all added with selftests:
- commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
  min/max boundary")
- commit efc11a667878 ("bpf: Improve bounds when tnum has a single
  possible value")
- commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
  logic")
- commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
  boundary")
- commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
  JSET")

To confirm that this patch addresses all invariant violations, we have
also reverted those five commits and verified that their related
selftests don't cause any invariant violation warnings anymore. Those
selftests still fail but only because of misdetected branches or
less-precise bounds than expected. This demonstrates that the current
patch is enough to avoid the invariant violation warning AND that the
previous five patches are still useful to improve branch detection.

In addition to the selftests, this change was also tested with the
Cilium complexity test suite: all programs were successfully loaded and
it didn't change the number of processed instructions.

Link: https://github.com/bpfverif/agni [1]
Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 86 +++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8215355f6be0..a431b7d50e1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16786,11 +16786,50 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}));
 }
 
+static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
+				u8 opcode, bool is_jmp32);
+static u8 rev_opcode(u8 opcode);
+
+/*
+ * Learn more information about live branches by simulating refinement on both branches.
+ * regs_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
+ * that branch is dead.
+ */
+static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
+{
+	/* Fallthrough (FALSE) branch */
+	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
+	reg_bounds_sync(&env->false_reg1);
+	reg_bounds_sync(&env->false_reg2);
+	/*
+	 * If there is a range bounds violation in *any* of the abstract values in either
+	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
+	 * TRUE branch will be taken.
+	 */
+	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
+		return 1;
+
+	/* Jump (TRUE) branch */
+	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
+	reg_bounds_sync(&env->true_reg1);
+	reg_bounds_sync(&env->true_reg2);
+	/*
+	 * If there is a range bounds violation in *any* of the abstract values in either
+	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
+	 * Only FALSE branch will be taken.
+	 */
+	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
+		return 0;
+
+	/* Both branches are possible, we can't determine which one will be taken. */
+	return -1;
+}
+
 /*
  * <reg1> <op> <reg2>, currently assuming reg2 is a constant
  */
-static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
-				  u8 opcode, bool is_jmp32)
+static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *reg1,
+				  struct bpf_reg_state *reg2, u8 opcode, bool is_jmp32)
 {
 	struct tnum t1 = is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_off;
 	struct tnum t2 = is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_off;
@@ -16942,7 +16981,7 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 		break;
 	}
 
-	return -1;
+	return simulate_both_branches_taken(env, opcode, is_jmp32);
 }
 
 static int flip_opcode(u32 opcode)
@@ -17013,8 +17052,8 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
  * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register value
  *      range [0,10]
  */
-static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
-			   u8 opcode, bool is_jmp32)
+static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *reg1,
+			   struct bpf_reg_state *reg2, u8 opcode, bool is_jmp32)
 {
 	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is_jmp32)
 		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
@@ -17052,7 +17091,7 @@ static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg
 	}
 
 	/* now deal with two scalars, but not necessarily constants */
-	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
+	return is_scalar_branch_taken(env, reg1, reg2, opcode, is_jmp32);
 }
 
 /* Opcode that corresponds to a *false* branch condition.
@@ -17143,8 +17182,8 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 			/* u32_min_value is not equal to 0xffffffff at this point,
 			 * because otherwise u32_max_value is 0xffffffff as well,
 			 * in such a case both reg1 and reg2 would be constants,
-			 * jump would be predicted and reg_set_min_max() won't
-			 * be called.
+			 * jump would be predicted and regs_refine_cond_op()
+			 * wouldn't be called.
 			 *
 			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
 			 * below.
@@ -17251,34 +17290,11 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	}
 }
 
-/* Adjusts the register min/max values in the case that the dst_reg and
- * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
- * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
- * Technically we can do similar adjustments for pointers to the same object,
- * but we don't support that right now.
- */
-static int reg_set_min_max(struct bpf_verifier_env *env,
-			   u8 opcode, bool is_jmp32)
+/* Check for invariant violations on the registers for both branches of a condition */
+static int regs_bounds_sanity_check_branches(struct bpf_verifier_env *env)
 {
 	int err;
 
-	/* If either register is a pointer, we can't learn anything about its
-	 * variable offset from the compare (unless they were a pointer into
-	 * the same object, but we don't bother with that).
-	 */
-	if (env->false_reg1.type != SCALAR_VALUE || env->false_reg2.type != SCALAR_VALUE)
-		return 0;
-
-	/* fallthrough (FALSE) branch */
-	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
-	reg_bounds_sync(&env->false_reg1);
-	reg_bounds_sync(&env->false_reg2);
-
-	/* jump (TRUE) branch */
-	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
-	reg_bounds_sync(&env->true_reg1);
-	reg_bounds_sync(&env->true_reg2);
-
 	err = reg_bounds_sanity_check(env, &env->true_reg1, "true_reg1");
 	err = err ?: reg_bounds_sanity_check(env, &env->true_reg2, "true_reg2");
 	err = err ?: reg_bounds_sanity_check(env, &env->false_reg1, "false_reg1");
@@ -17670,7 +17686,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	copy_register_state(&env->false_reg2, src_reg);
 	copy_register_state(&env->true_reg1, dst_reg);
 	copy_register_state(&env->true_reg2, src_reg);
-	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
+	pred = is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >= 0) {
 		/* If we get here with a dst_reg pointer type it is because
 		 * above is_branch_taken() special cased the 0 comparison.
@@ -17734,7 +17750,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return PTR_ERR(other_branch);
 	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
 
-	err = reg_set_min_max(env, opcode, is_jmp32);
+	err = regs_bounds_sanity_check_branches(env);
 	if (err)
 		return err;
 
-- 
2.43.0

