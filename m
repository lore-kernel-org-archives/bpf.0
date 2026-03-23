Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9393B95FD
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282753; cv=none; b=BBqnwtUZgAsg75cWUGcXHHZH+tjYlyMZW5feMhKowZ/B4Yo+pZmos/AlEGuNlSzA71beFOqGATCEvejhOJR4RJ9IZ2J0wjwEMX2yfRTu79v+zoFA/6Fiq26TwNmnN/oLaAINUaTQIa/ZaiJUAa4FpFFqg34hXeZ9Re3RxsZKNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282753; c=relaxed/simple;
	bh=jLnxELhczPU3kpwV/4VR/Q5eokjhSBoDv188DTKxGX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKqQKJYunVwFB5VNFq8eQNXjda6BqDNCr5UmK/m2hMsgV0d8Z0I0g9og6dydNtAZOt82OWQLssYk/zjbBYcSpiGPK+nzUZHMEuLI5RWxXDReiHOHhUiGACJHO70QzlV+ELc5QhwUQFdfWbWF+2ovqSuIv669sFSDGg4tudoJLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+tHiKL+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+tHiKL+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b45bb7548so3175538f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774282750; x=1774887550; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XStIfK6rvudApTpSwAYEHbi+WTGfDg3J4EJR2CvHhDM=;
        b=d+tHiKL+2Jtvf3Xu3bFsPBasgq7pGtKCw6ZiqDF/u0h+07/+2b0HDi/Q1iaQ5KRVUG
         LLW6n2PtxyVUl6Pogoz9igsknCi7Xfv5H20SYUYUZo4Nl3MuyGfCw1DHfBHGwmh9uEVB
         4Aan8k+zqaGobDHKY2gQ0Orxkh6D1UoRhhitopWDF4vVXcdcrhHi0iOMaFbzSyV7q2pa
         1MjyW+QTK7i407HNUArWmx0v1s+eGtZ5Mtvy3P+nMctgxUzRtjinT+TMUtVsHyusa1Sb
         a7YPf4iIr190hOtmH0oFuz8E6ixN4bjti6JdBSOvmAUny4+CN7eiisXZouQkssnLy+YC
         hOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282750; x=1774887550;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XStIfK6rvudApTpSwAYEHbi+WTGfDg3J4EJR2CvHhDM=;
        b=jQo/7O/93W5f5BVZHkmIHE6rZXCnW5gTstnfWhmIqjvycdI2D35T6pTnQnDJR29aID
         q1DZ3awoy1RF2sZInXqJ3PzxOC3NoQhGYtlCSizy9oVQJyMzt6UFIkAc/aCyJc8SpXSy
         37MP6E6taN/ev9rSEOcylkm3cSyEWZNOZ1SENLgBwAQ2/cADcXDwbfBikH+TCYOI7bZ9
         Lk1vgOLetKFQLR4tAriQCiZYv5PjlOMytfHnyX093vS7s51YAG3Niwtw4KzoGDuPgpYb
         0cV4VKnpQ9Dx6BeiqjabRKb675utnCFoc4WNiHb/HbUybnuzI6mDcOJMD2hb+YTL+QpC
         Fdnw==
X-Forwarded-Encrypted: i=1; AJvYcCVneNnV/qlD6Wf9zBwR3IOLD7fZRJ7SS2srG//nv1EEuq9/AQpPN1jj0oOGgc/tZvVQAeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxssiAqqMeBbiTsbvdd0PBTSA/ebcnfgw7GHUuszNSchDIvV0IN
	OI9eIvszmQ35vtfWthjM53Z2KayT7HxUUhKMW1IxJpxwFmgmplMz7AsH
X-Gm-Gg: ATEYQzwDEMK0VPOuuOPNjCxIanDz/pySuOkjb1KYXOQLCdpyottPK5frheCC4xLqD0D
	u1cN+YSd4hVN9EueBUEuIvVHQjIsIOjIeDO9djcJGcwrSfXjBNxS+Nmrl7zqwHK0gmwV0TZfHG9
	BupsMmud9jN/0TFGqM3XzWY6t5SFIKQ0bPMbNmPjFV22tWaECV9GZdG0iVhxrTlRJ99RGdDAJlW
	03EPitiNVj91GjgdKsBpNFkbz8X+46qwxeWQskwDlSGP079yrxFbRpnbpYwT4vhxN1/TrMcKEC4
	hsRtEk4Q3JB/SIrh7vpywzWwN6SR5cCGe6D5zQtc0rUdUVJJxZffahv10DRtgk0C+R/QTPQaVVP
	CQUe9HTE4kuaK8wPLsKJYnIe7XtxOo8dOZS6ShySZQSVy4zXbQu7vLtTnIgueaEUJ1sJxE5EwXM
	/jKsqfhbSppqkszYQClZKB3+nTWw==
X-Received: by 2002:a05:6000:2007:b0:43b:5356:a7f9 with SMTP id ffacd0b85a97d-43b6428b369mr19698235f8f.52.1774282749299;
        Mon, 23 Mar 2026 09:19:09 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647036e0sm31051937f8f.21.2026.03.23.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:19:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based
 on range violations
In-Reply-To: <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
Date: Mon, 23 Mar 2026 16:19:08 +0000
Message-ID: <87ldfijz7n.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>
> This patch fixes the invariant violations that can happen after we
> refine ranges & tnum based on an incorrectly-detected branch condition.
> For example, the branch is always true, but we miss it in
> is_branch_taken; we then refine based on the branch being false and end
> up with incoherent ranges (e.g. umax < umin).
>
> To avoid this, we can simulate the refinement on both branches. More
> specifically, this patch simulates both branches taken using
> regs_refine_cond_op and reg_bounds_sync. If the resulting register
> states are ill-formed on one of the branches, is_branch_taken can mark
> that branch as "never taken".
>
> On a more formal note, we can deduce a branch is not taken when
> regs_refine_cond_op or reg_bounds_sync returns an ill-formed state
> because the branch operators are sound (formally verified). Soundness
> means that the verifier is guaranteed to produce sound outputs on the
> taken branches. On the non-taken branch (explored because of
> imprecision in the bounds), the verifier is free to produce any output.
> We use ill-formedness as a signal that the branch is dead and prune
> that branch.
>
> This patch moves the refinement logic for both branches from
> reg_set_min_max to their own function, simulate_both_branches_taken,
> which is called from is_scalar_branch_taken. As a result,
> reg_set_min_max now only runs sanity checks and has been renamed to
> reg_bounds_sanity_check_branches to reflect that.
>
> We have had five patches fixing specific cases of invariant violations
> in the past, all added with selftests:
> - commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
>   min/max boundary")
> - commit efc11a667878 ("bpf: Improve bounds when tnum has a single
>   possible value")
> - commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
>   logic")
> - commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
>   boundary")
> - commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
>   JSET")
>
> To confirm that this patch addresses all invariant violations, we have
> also reverted those five commits and verified that their related
> selftests don't cause any invariant violation warnings anymore. Those
> selftests still fail but only because of mis-detected branches or
> less-precise bounds than expected. This demonstrates that the current
> patch is enough to avoid the invariant violation warning AND that the
> previous five patches are still useful to improve branch detection.
>
> In addition to the selftests, this change was also tested with the
> Cilium complexity test suite: all programs were successfully loaded and
> it didn't change the number of processed instructions.
>
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> ---
>  kernel/bpf/verifier.c | 84 +++++++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8d7ad5f21ed6..0b4f622efec1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16717,11 +16717,48 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
>  	}));
>  }
>  
> +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> +				u8 opcode, bool is_jmp32);
> +static u8 rev_opcode(u8 opcode);
> +
> +/* Learn more information about live branches by simulating both branches being
> + * taken using regs_refine_cond_op. Because regs_refine_cond_op is sound when
> + * the branch is taken, if it produces ill-formed register bounds, it must mean
> + * that the branch is dead.
> + */
Sorry for being nit-picky, could you please use kernel style comment style +
maybe reword it a little bit, instead of:

/*
 * Because regs_refine_cond_op is sound when
 * the branch is taken, if it produces ill-formed register bounds, it must mean
 * that the branch is dead.
 */
Something like:
/*
 * regs_refine_cond_op() is sound, so producing ill-formed register
 * bounds for the branch means that branch is dead.
 */

> +static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
> +{
> +	/* Fallthrough (FALSE) branch */
> +	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
> +	reg_bounds_sync(&env->false_reg1);
> +	reg_bounds_sync(&env->false_reg2);
This is probably more related to patch 2: is it necessary to have both
true/false_reg1/2 pairs, it looks like we process false branch before
the true branch and they never intersect, don't they? So it worth
removing a pair of bpf_reg_states from env?
> +	/* If there is a range bounds violation in *any* of the abstract values in
> +	 * either reg_states in the FALSE branch (i.e. reg1, reg2), the
> +	 * FALSE branch must be dead. Only TRUE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
> +		return 1;
> +
> +	/* Jump (TRUE) branch */
> +	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
> +	reg_bounds_sync(&env->true_reg1);
> +	reg_bounds_sync(&env->true_reg2);
> +	/* If there is a range bounds violation in *any* of the abstract values in
> +	 * either reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the
> +	 * TRUE branch must be dead. Only FALSE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
> +		return 0;
> +
> +	/* Both branches are possible, we can't determine which one will be taken. */
> +	return -1;
> +}
> +
>  /*
>   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
>   */
> -static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> -				  u8 opcode, bool is_jmp32)
> +static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *reg1,
> +				  struct bpf_reg_state *reg2, u8 opcode, bool is_jmp32)
>  {
>  	struct tnum t1 = is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_off;
>  	struct tnum t2 = is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_off;
> @@ -16873,7 +16910,7 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
>  		break;
>  	}
>  
> -	return -1;
> +	return simulate_both_branches_taken(env, opcode, is_jmp32);
>  }
>  
>  static int flip_opcode(u32 opcode)
> @@ -16944,8 +16981,8 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
>   * -1 - unknown. Example: "if (reg1 < 5)" is unknown when register value
>   *      range [0,10]
>   */
> -static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
> -			   u8 opcode, bool is_jmp32)
> +static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *reg1,
> +			   struct bpf_reg_state *reg2, u8 opcode, bool is_jmp32)
>  {
>  	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is_jmp32)
>  		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
> @@ -16983,7 +17020,7 @@ static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_state *reg
>  	}
>  
>  	/* now deal with two scalars, but not necessarily constants */
> -	return is_scalar_branch_taken(reg1, reg2, opcode, is_jmp32);
> +	return is_scalar_branch_taken(env, reg1, reg2, opcode, is_jmp32);
>  }
>  
>  /* Opcode that corresponds to a *false* branch condition.
> @@ -17074,8 +17111,8 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>  			/* u32_min_value is not equal to 0xffffffff at this point,
>  			 * because otherwise u32_max_value is 0xffffffff as well,
>  			 * in such a case both reg1 and reg2 would be constants,
> -			 * jump would be predicted and reg_set_min_max() won't
> -			 * be called.
> +			 * jump would be predicted and regs_refine_cond_op()
> +			 * wouldn't be called.
>  			 *
>  			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
>  			 * below.
> @@ -17182,34 +17219,11 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>  	}
>  }
>  
> -/* Adjusts the register min/max values in the case that the dst_reg and
> - * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> - * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
> - * Technically we can do similar adjustments for pointers to the same object,
> - * but we don't support that right now.
> - */
> -static int reg_set_min_max(struct bpf_verifier_env *env,
> -			   u8 opcode, bool is_jmp32)
> +/* Check for invariant violations on the registers for both branches of a condition */
> +static int regs_bounds_sanity_check_branches(struct bpf_verifier_env *env)
>  {
>  	int err;
>  
> -	/* If either register is a pointer, we can't learn anything about its
> -	 * variable offset from the compare (unless they were a pointer into
> -	 * the same object, but we don't bother with that).
> -	 */
> -	if (env->false_reg1.type != SCALAR_VALUE || env->false_reg2.type != SCALAR_VALUE)
> -		return 0;
> -
> -	/* fallthrough (FALSE) branch */
> -	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
> -	reg_bounds_sync(&env->false_reg1);
> -	reg_bounds_sync(&env->false_reg2);
> -
> -	/* jump (TRUE) branch */
> -	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
> -	reg_bounds_sync(&env->true_reg1);
> -	reg_bounds_sync(&env->true_reg2);
> -
>  	err = reg_bounds_sanity_check(env, &env->true_reg1, "true_reg1");
>  	err = err ?: reg_bounds_sanity_check(env, &env->true_reg2, "true_reg2");
>  	err = err ?: reg_bounds_sanity_check(env, &env->false_reg1, "false_reg1");
> @@ -17595,7 +17609,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	copy_register_state(&env->false_reg2, src_reg);
>  	copy_register_state(&env->true_reg1, dst_reg);
>  	copy_register_state(&env->true_reg2, src_reg);
> -	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> +	pred = is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
>  	if (pred >= 0) {
>  		/* If we get here with a dst_reg pointer type it is because
>  		 * above is_branch_taken() special cased the 0 comparison.
> @@ -17659,7 +17673,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return PTR_ERR(other_branch);
>  	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
>  
> -	err = reg_set_min_max(env, opcode, is_jmp32);
> +	err = regs_bounds_sanity_check_branches(env);
>  	if (err)
>  		return err;
>  
> -- 
> 2.43.0
