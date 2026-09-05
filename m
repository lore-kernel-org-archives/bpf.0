Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA7242D88
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588340; cv=none; b=ulRDDXoXY82MQMHHTBECdubudUrE+8HB1JJKyV0b8js+jlsiG4oj7u1i6Nx/ngsgxWpZ3+Z2lKBUH2x10VHjWzJNFW8kvcR10kZOX2lgQeZ5wFA/YU2SKDGxj78N7XVh/dH8Fe4YcqS+GLWlQMdMXzuFcPLD8I1K90MpoAm0sKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588340; c=relaxed/simple;
	bh=hLWSrN6xKSmnQUBKWN0bCojbZFjF1lzg6LoY+PFNV8U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qfh6VBMFwIUwnGscVQramzeVwmaMQIy7lnl7/VI+zpMApX9LRiCGk6PwR+F86fjfRWSYnTfX/b2TdyTgfVaDrCz/YbHjI757l4/x8eeFv7T5zZzLz414bhbgd3sPTUk+TrBeIfmBr+uFBB4m5fk4fGgPfRMcOqNYnjN5nLekCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWKceoq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWKceoq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBA81F00A3E;
	Sat,  5 Sep 2026 06:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788588338;
	bh=Ye4jfK2Q+mXjuoIA3wxy26nlfUDkY0XjwBxieZYFS+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mWKceoq5gEYubIYW6rLTjpDnU9lf8j6luRHpVGeMoS2NxssJ0KCgnoTqL5X8M/AQ3
	 rG9qOFZrRIZ96075LiBZJp3V4YEoz05JozUwKChhA+wlNcdhxguz0EY6rNLtx1JxLG
	 NYOi2nZkiGKTS0TbAy6iIYTEe8CMTUSVFPfZfPw8Mttuy0jCxL1ip/d62N3We16WnO
	 zKDDn5k6/yFEU0PcSSV9mVqqhYwIKSIytqu3mqWS7w/A3l77I/DbdZEBM0DxGJ1c1x
	 mwP7uZTIxzSrE6OCcpu9LjU9cMXfbxfQ6bIr8+Be4FUd4tD+QwjHC3UKv9mLsNnyYG
	 8YMiAd2W9kt+g==
Content-Type: multipart/mixed; boundary="===============0972319795297009131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <652367e7a2ca75e71c0b7c2cadc8b760551008853bbe831dd596f65cb993e285@mail.kernel.org>
In-Reply-To: <20260905051224.2325381-2-memxor@gmail.com>
References: <20260905051224.2325381-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Verify global subprogs in each sleepability context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 06:05:37 +0000 (UTC)

--===============0972319795297009131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a7eb2185c35..66d04244c737 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1650,8 +1650,9 @@ static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags
>  struct bpf_func_info_aux {
>  	u16 linkage;
>  	bool unreliable;
> -	bool called : 1;
> -	bool verified : 1;
> +	/* Indexed by in_sleepable. */
> +	bool called[2];
> +	bool verified[2];
>  };

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b51e7ee1a3f..f759a020c8a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9957,6 +9957,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (err == -EFAULT)
>  		return err;
>  	if (bpf_subprog_is_global(env, subprog)) {
> +		struct bpf_func_info_aux *sub_aux = subprog_aux(env, subprog);
>  		const char *sub_name = bpf_subprog_name(env, subprog);
>  		const char *operation;
>  		bool returns_void;
> @@ -9988,11 +9989,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		if (env->log.level & BPF_LOG_LEVEL)
>  			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
>  				subprog, sub_name);
> +		sub_aux->called[in_sleepable_context(env)] = true;
>  		returns_void = subprog_returns_void(env, subprog);
>  		if (env->subprog_info[subprog].changes_pkt_data)
>  			clear_all_pkt_pointers(env);
> -		/* mark global subprog for verifying after main prog */
> -		subprog_aux(env, subprog)->called = true;
>  		if (returns_void)
>  			bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
>  		else

[ ... ]

> @@ -19560,13 +19565,14 @@ static void free_states(struct bpf_verifier_env *env)
>  	}
>  }
>
> -static int do_check_common(struct bpf_verifier_env *env, int subprog)
> +static int do_check_common(struct bpf_verifier_env *env, int subprog, bool in_sleepable)
>  {
>  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
>  	struct bpf_subprog_info *sub = subprog_info(env, subprog);
>  	struct bpf_prog_aux *aux = env->prog->aux;
>  	struct bpf_verifier_state *state;
>  	struct bpf_reg_state *regs;
> +	u32 old_insns_total = sub->insns_total;
>  	u32 insn_processed = env->insn_processed;
>  	int ret, i;
>
> @@ -19579,7 +19585,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>  	state->curframe = 0;
>  	state->speculative = false;
>  	state->branches = 1;
> -	state->in_sleepable = env->prog->sleepable;
> +	state->in_sleepable = in_sleepable;
>  	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
>  	if (!state->frame[0]) {
>  		kfree(state);

Can this change break check_css_task_iter_allowlist()?

That function currently uses in_sleepable(env) to decide whether to allow
bpf_iter_css_task_new(), per its comment:

  "Any sleepable progs are also safe since bpf_check_attach_target() enforce
   them can only be attached to some specific hook points."

Before this patch, do_check_common() always set state->in_sleepable =
env->prog->sleepable, so in_sleepable(env) matched the program-level
sleepability even for global subprogs. After this patch, when a global
subprog is called from inside bpf_rcu_read_lock() or a similar protected
region in a sleepable program, in_sleepable_context(env) is false in
check_func_call(), so the global subprog is verified with in_sleepable ==
false.

If that global subprog then calls bpf_iter_css_task_new(),
check_css_task_iter_allowlist() sees in_sleepable(env) == false and rejects
it with "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable
progs", even though:

1. The iterator itself never sleeps (it is marked only KF_ITER_NEW, not
   KF_SLEEPABLE, so it only takes spin_lock_irq(&css_set_lock));

2. The allowlist check is meant to prove the attach point does not already
   hold css_set_lock, which is a property of the program's attach type, not
   of the current RCU/preempt nesting;

3. The identical call written directly in the main program under the same
   bpf_rcu_read_lock() is still accepted, because there in_sleepable remains
   true. Only the version factored into a global subprog is newly rejected.

Should check_css_task_iter_allowlist() consult env->prog->sleepable directly
instead of in_sleepable(env), so that normalizing a protected sleepable caller
to in_sleepable=false at the global-subprog root does not affect allowlist
decisions?

> @@ -19721,7 +19727,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>  	 * Accumulate their total counts as total counts of the main or
>  	 * global subprog hosting the async call.
>  	 */
> -	env->subprog_info[subprog].insns_total = env->insn_processed - insn_processed;
> +	env->subprog_info[subprog].insns_total = old_insns_total +
> +						(env->insn_processed - insn_processed);
>  	return ret;
>  }

[ ... ]

> @@ -19749,45 +19756,55 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_prog_aux *aux = env->prog->aux;
>  	struct bpf_func_info_aux *sub_aux;
> -	int i, ret, new_cnt;
> +	int context, i, j, ret, new_cnt;
>
>  	if (!aux->func_info)
>  		return 0;
>
>  	/* exception callback is presumed to be always called */
> -	if (env->exception_callback_subprog)
> -		subprog_aux(env, env->exception_callback_subprog)->called = true;
> +	if (env->exception_callback_subprog) {
> +		sub_aux = subprog_aux(env, env->exception_callback_subprog);
> +		sub_aux->called[env->prog->sleepable] = true;
> +	}
>
>  again:
>  	new_cnt = 0;
> -	for (i = 1; i < env->subprog_cnt; i++) {
> +	/*
> +	 * Walk callers before callees so each global subprog normally sees all
> +	 * of its contexts before it is verified. Async callback cycles can add a
> +	 * context to an earlier subprog, so repeat until every called context is
> +	 * verified.
> +	 */
> +	for (j = env->subprog_cnt - 1; j >= 0; j--) {
> +		i = env->subprog_topo_order[j];
> +		if (!i)
> +			continue;
>  		if (!bpf_subprog_is_global(env, i))
>  			continue;
>
>  		sub_aux = subprog_aux(env, i);
> -		if (!sub_aux->called || sub_aux->verified)
> -			continue;
> +		for (context = 0; context < ARRAY_SIZE(sub_aux->called); context++) {
> +			if (!sub_aux->called[context] || sub_aux->verified[context])
> +				continue;
>
> -		env->insn_idx = env->subprog_info[i].start;
> -		WARN_ON_ONCE(env->insn_idx == 0);
> -		ret = do_check_common(env, i);
> -		if (ret) {
> -			return ret;
> -		} else if (env->log.level & BPF_LOG_LEVEL) {
> -			verbose(env, "Func#%d ('%s') is safe for any args that match its prototype\n",
> -				i, bpf_subprog_name(env, i));
> -		}
> +			env->insn_idx = env->subprog_info[i].start;
> +			WARN_ON_ONCE(env->insn_idx == 0);
> +			ret = do_check_common(env, i, context);
> +			if (ret)
> +				return ret;
> +			if (env->log.level & BPF_LOG_LEVEL)
> +				verbose(env, "Func#%d ('%s') is safe for any args "
> +					"that match its prototype\n",
> +					i, bpf_subprog_name(env, i));
>
> -		/* We verified new global subprog, it might have called some
> -		 * more global subprogs that we haven't verified yet, so we
> -		 * need to do another pass over subprogs to verify those.
> -		 */
> -		sub_aux->verified = true;
> -		new_cnt++;
> +			sub_aux->verified[context] = true;
> +			new_cnt++;
> +		}
>  	}
>
> -	/* We can't loop forever as we verify at least one global subprog on
> -	 * each pass.
> +	/*
> +	 * We can't loop forever as each pass verifies at least one new context,
> +	 * and there are only two contexts per global subprog.
>  	 */
>  	if (new_cnt)
>  		goto again;
> @@ -19800,7 +19817,7 @@ static int do_check_main(struct bpf_verifier_env *env)
>  	int ret;
>
>  	env->insn_idx = 0;
> -	ret = do_check_common(env, 0);
> +	ret = do_check_common(env, 0, env->prog->sleepable);
>  	if (!ret)
>  		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
>  	return ret;

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33947189666
--===============0972319795297009131==--
