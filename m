Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F2BEFFD
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775413240; cv=none; b=M7LocdkQbtoJVvaGn5tTzYy3pOrBpmcA8b1YOjo7d/yERhvIkcWQE33piyA44hHc//k9Bhpp4gkTlxLBc3JyScfpwK406ARybZA42GbQCZPc3TFqt8p6mrujEeXpQyGbt6SgPgEWAl6CiCuQBO/aYiQG2RKRBYHfnjAUe/5b7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775413240; c=relaxed/simple;
	bh=72fANRVZT0GqLvGh+kysEvTp+ZbmwfQeWlEiI9WOnaA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K9OBsN3OzQ1xc+cA2OrqgTJKp9vgNJaUlgbm3BCJ8yQramikE1a2haaamQZ7sBTHMerHCICx9FRT2V/MbKqFXiU4BmjSelENmP+9yGdDL0SQKKde6MsVdJPbo+SA++/pzWrAD/A/iGCRI4T3oE+tSsVFm9imedQjfTMLms6jv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBtKGPvQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBtKGPvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A714C116C6;
	Sun,  5 Apr 2026 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775413240;
	bh=72fANRVZT0GqLvGh+kysEvTp+ZbmwfQeWlEiI9WOnaA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BBtKGPvQs2HLEafowjp8Y9RZ/bsu7Yuxay1Y5VK1pfG4MvzZV7Y1uUYFbN25IME/q
	 kcgAHx5eVKjLxdw7ukXPQQ3bk1GrsLV9Ba+ci0XBd6ao7HFTe7IR68OMaex2U24FsR
	 JAVCZ6mqvuzcNXeOV5sbofGtUCvW8raEv4mlhfx+V2P0jbAfbcyyhrSSs/r4IlG9YW
	 wNJrVOWZghFTzag+L2nQvlkMFNUaMujQfgAMC+EmcrGf7btwXdhtkf5TL4nLpR9j2W
	 /GzAifRSUiv5vlGwv40onfKb3JIA7xmVJfJ5lTCZwosde5M6d/XQFLJbdIhMWe9TgY
	 6yDyjDKl59S2A==
Content-Type: multipart/mixed; boundary="===============2017921023896144597=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <adcc0eb54109467ffa3e970608a73ba0b39230928555d09663cd771441c010dd@mail.kernel.org>
In-Reply-To: <20260405172611.1336162-1-yonghong.song@linux.dev>
References: <20260405172611.1336162-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  5 Apr 2026 18:20:40 +0000 (UTC)

--===============2017921023896144597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *env, int argno)
> +{
> +	struct bpf_func_state *caller;
> +	int spi;
> +
> +	if (argno < MAX_BPF_FUNC_REG_ARGS)
> +		return &cur_regs(env)[argno + 1];
> +
> +	caller = cur_func(env);
> +	spi = caller->incoming_stack_arg_depth / BPF_REG_SIZE + (argno - MAX_BPF_FUNC_REG_ARGS);
> +	return &caller->stack_arg_slots[spi].spilled_ptr;
> +}
> +
>  static enum kfunc_ptr_arg_type
>  get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  		       struct bpf_kfunc_call_arg_meta *meta,

[ ... ]

>  {
>  	u32 regno = argno + 1;
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	struct bpf_reg_state *reg = &regs[regno];

When check_kfunc_args() calls this function for a stack arg (argno >= 5),
the stack arg state was placed into regs[BPF_REG_1], but this local
reg reads regs[argno + 1] instead, which is a callee-saved register
(BPF_REG_6 through BPF_REG_9) or the frame pointer (BPF_REG_10).

For argno >= 10 (MAX_BPF_FUNC_ARGS is 12), this reads past
regs[MAX_BPF_REG - 1] into adjacent struct fields, since
bpf_func_state.regs[] only has 11 entries (BPF_REG_0..BPF_REG_10).

This reg is used later for register_is_null() and base_type(reg->type),
which would cause wrong argument type classification for pointer-typed
stack args.  The is_kfunc_arg_mem_size() lookahead a few lines below
was correctly updated to use get_kfunc_arg_reg() -- should this local
reg use the same helper?

> 	if (argno + 1 < nargs &&
> -	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
> -	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
> +	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1)) ||
> +	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1))))
>  		arg_mem_size = true;

[ ... ]

> 		case KF_ARG_PTR_TO_MEM_SIZE:
>  		{
>  			struct bpf_reg_state *buff_reg = &regs[regno];
>  			const struct btf_param *buff_arg = &args[i];
> -			struct bpf_reg_state *size_reg = &regs[regno + 1];
> +			struct bpf_reg_state *size_reg;
>  			const struct btf_param *size_arg = &args[i + 1];
> +			struct bpf_reg_state saved_size_reg = {};
> +			bool size_is_stack_arg = false;
> +
> +			if (i >= MAX_BPF_FUNC_REG_ARGS) {
> +				size_is_stack_arg = true;
> +				saved_size_reg = regs[regno + 1];
> +				regs[regno + 1] = *get_kfunc_arg_reg(env, i + 1);
> +				verbose(env, "Use reg %d to represent mem_size\n", regno + 1);
> +			}
> +			size_reg = &regs[regno + 1];

Is there a missing case when the pointer arg is the last register arg
(i == MAX_BPF_FUNC_REG_ARGS - 1, i.e. i == 4) and the size arg is
the first stack arg (i + 1 == 5)?

In that case i < MAX_BPF_FUNC_REG_ARGS, so is_stack_arg is false and
regno is 5 (BPF_REG_5).  The condition "i >= MAX_BPF_FUNC_REG_ARGS"
is false, so size_is_stack_arg stays false.  Then size_reg becomes
&regs[6], which is BPF_REG_6 (a callee-saved register) instead of
the stack arg slot for arg 5.

The get_kfunc_ptr_arg_type() lookahead correctly handles this boundary
with get_kfunc_arg_reg(env, argno + 1), so the arg gets classified as
KF_ARG_PTR_TO_MEM_SIZE, but then the actual size check reads from the
wrong register.

Would something like "if (i + 1 >= MAX_BPF_FUNC_REG_ARGS)" be the
right condition here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024
--===============2017921023896144597==--
