Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DB2236FD
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480396; cv=none; b=JU9xpWEW0AOrHFZZfVK0yHXaKDtP1glEiQOg3M8Xty4aCMyn2tUn7Zv93TcPg6PlMrgLkq/XnIqS4PX5ZAqfq1tKTqgjLASs/Tqsr7EDrU4sk8OlPIkRDzgbcDi/zUzXOHPLtmwEYet1nwFcrSdG4UDJRQvX4hIyQ3NIVo6noqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480396; c=relaxed/simple;
	bh=/YeYm1CwKeAk/bvMQNnei+Yhdadj1whe07vxfZ+XUbk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W4v0PuK2p3V4ekl85YkzbACRnxgYuP+WQSMzrmGhRoMPh+cQqMBkjn+KErsQx7TMiJpgjV+5JHOOhR8QavQ/9ijIq3qxCgcCkxNEvyp9+4tet3C0bQmESXCXLJFCxDR+2MzgMML5FmHev4b013ynfDrRADIHpJQ5Og6p5HfIM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uguG2Srl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uguG2Srl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2DCC2BCB0;
	Mon, 11 May 2026 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480396;
	bh=/YeYm1CwKeAk/bvMQNnei+Yhdadj1whe07vxfZ+XUbk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uguG2Srlr04CTlDlf6VPoeBjsvKfHOF22mnN4PASm8Tf77HTnp9yxwvmf2zvwCdMm
	 gfubaJblmF7AexaimQpFNErvvCvtYCSKaIDFL+pt/kmaM+5hLcdYl5Y+LBrz6p5+zX
	 uzk6a2Vg8iQcvzmzKVhDSQnvPXkrX9oHHz/67zI1RpqLh+0668NVJZYUg4wfyG3pcC
	 qsMXtHTchh2wVzkP7R3FrO2fGnfh6Ga7rVwtmucaWjZHUEPwzsZHpYhlqSLmQBYmtf
	 7awiNLd39pD6DsmPjlG3nt1/AoeDMrpNOvcLBvM07+rSN1tNz9RgszDlbIzPXyAVHH
	 vcayfIdIinMnw==
Content-Type: multipart/mixed; boundary="===============0833904406519515579=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1bb0dfc54cc2dbe6a38c21af2717f1b575ba60ba66a763952f38ada03a65bf85@mail.kernel.org>
In-Reply-To: <20260511053327.1883871-1-yonghong.song@linux.dev>
References: <20260511053327.1883871-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/24] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:55 +0000 (UTC)

--===============0833904406519515579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 321b9d69cf9c..f9020a4ea005 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -402,6 +402,7 @@ struct bpf_func_state {
>  	bool in_callback_fn;
>  	bool in_async_callback_fn;
>  	bool in_exception_callback_fn;
> +	bool no_stack_arg_load;

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index bd9c22945050..c249eb40c6d6 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -833,6 +833,32 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
>  	return true;
>  }
>
> +/*
> + * Compare stack arg slots between old and current states.
> + * Outgoing stack args are path-local state and must agree for pruning.
> + */
> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
> +			   enum exact_level exact)
> +{
> +	int i, nslots;
> +
> +	nslots = max(old->out_stack_arg_cnt, cur->out_stack_arg_cnt);
> +	for (i = 0; i < nslots; i++) {
> +		struct bpf_reg_state *old_arg, *cur_arg;
> +		struct bpf_reg_state not_init = { .type = NOT_INIT };
> +
> +		old_arg = i < old->out_stack_arg_cnt ?
> +			  &old->stack_arg_regs[i] : &not_init;
> +		cur_arg = i < cur->out_stack_arg_cnt ?
> +			  &cur->stack_arg_regs[i] : &not_init;
> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *cur,
>  		    struct bpf_idmap *idmap)
>  {
> @@ -924,6 +950,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>  	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>  		return false;
>
> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
> +		return false;
> +
>  	return true;
>  }

In v2 (May 7), bot+bpf-ci@kernel.org raised a concern that
no_stack_arg_load is not compared during state pruning in
func_states_equal():

    "The same issue applies to state pruning: func_states_equal/
    stack_arg_safe does not compare no_stack_arg_load either, so a
    state with no_stack_arg_load=true can be pruned to an old state
    with no_stack_arg_load=false incorrectly. Should no_stack_arg_load
    be placed before stack (to be memcpy'd) or should copy_stack_state()
    explicitly assign it?"

The field placement was fixed (moving no_stack_arg_load before 'stack'
so it gets copied by memcpy), but func_states_equal() still does not
explicitly compare this field.

Could this allow incorrect pruning? If a BPF program writes to stack
args and calls a function on one path (setting no_stack_arg_load=true),
then branches and tries to read from stack args on another path, the
verifier might incorrectly prune to the old state with
no_stack_arg_load=false, missing the enforcement that stack arg reads
must happen before writes/calls.

Looking at func_states_equal():

kernel/bpf/states.c:func_states_equal() {
    if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
        return false;

    if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
        return false;

    return true;
}

Should no_stack_arg_load be compared here, similar to how other boolean
flags in bpf_func_state are handled during state comparison?

Reference: https://lore.kernel.org/bpf/11c51daec78a68837f719172ae1c21db8b3e98e0a76aa5bcd59c8b089760c40d@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============0833904406519515579==--
