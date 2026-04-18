Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D4245019
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473565; cv=none; b=cfr1N9xZyKEKNEacYU5jTdbzv5D4ACVyFLDTpIqIvXsAEv+wly37J6/soamaT4SVs9w2jgZ4hC3SOxS01EUJL5lRlGtxgQ52fzbKSTIPklKRqyADppBVndrPCGd/8D4c9AuiqzubMHJT7gaMbO7HEYDr3btkkBmQq96RCn6f8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473565; c=relaxed/simple;
	bh=H1a2St9Ybbl1UrsF1dHwsFZEr/K6PyKA6gePRMOzixE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MadO77gkv1o09yD63NgBpdjyxYNYNNCuwGuKAne0eGUNL7+qLaP9Ds/IfMAXwiyAomlVTwnkFWVkcOXQvlOpMjgNkaPB2ArMjtLwDYQoiUTwsV0sNhtSTygp0rCMffV57d6ws/WwCpw2nYXIdXWL7JONw9hQhkATblFt10m7k38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExTl6xim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExTl6xim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5120C19425;
	Sat, 18 Apr 2026 00:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473564;
	bh=H1a2St9Ybbl1UrsF1dHwsFZEr/K6PyKA6gePRMOzixE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ExTl6ximy+EY0IN/ioTb22w6xiFFLgcXo8NTrX/lphP7W1cPavC1t4lvxomoShbdM
	 uU8uzgIRkTB01rsfoZtRGf+rL1Zr0779oegzRo/0RjMyjTRHPNGQCSI/RAhk0NBLZi
	 MTOyyfJ+rtzyVbqgFY64vkQuztzIaBSUy913I+HCg7LhYCW5Maesa8znTWw7/I4Fz8
	 vaC1fIy6d/4nexMTwaxD0oDkGUk5EwJXxncYb5GuI4ju7N1cKZmmN4ClDorau+9GK8
	 ymQnYGeDd6WoW8e34+cHnUzLVNqYyzZ0pD7rSzA6z/VC18tapgrPms3vvKj4LhRcpl
	 5ZkztnFtlr4EQ==
Content-Type: multipart/mixed; boundary="===============5858879229129043948=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dce4ce2de406cbd89d8c9a50bee1bee3d5701b3b1d77da8bb2c8d9c9d90b279b@mail.kernel.org>
In-Reply-To: <20260417034713.2627100-1-yonghong.song@linux.dev>
References: <20260417034713.2627100-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 03/16] bpf: Refactor to handle memory and size together
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 00:52:44 +0000 (UTC)

--===============5858879229129043948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2bedaa193d54..7a7024d94cf0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7020,15 +7020,17 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>  /* verify arguments to helpers or kfuncs consisting of a pointer and an access
>   * size.
>   *
> - * @regno is the register containing the access size. regno-1 is the register
> - * containing the pointer.
> + * @mem_regno is the register containing the pointer, mem_regno+1 is the register
> + * containing the access size.
>   */
>  static int check_mem_size_reg(struct bpf_verifier_env *env,
> -			      struct bpf_reg_state *reg, u32 regno,
> +			      struct bpf_reg_state *mem_reg,
> +			      struct bpf_reg_state *size_reg, u32 mem_regno,
>  			      enum bpf_access_type access_type,
>  			      bool zero_size_allowed,
>  			      struct bpf_call_arg_meta *meta)
>  {
> +	int size_regno = mem_regno + 1;
>  	int err;
>
>  	/* This is used to refine r0 return value bounds for helpers

The refactoring passes size_reg as a parameter to prepare for stack
arguments, but this code still hardcodes size_regno as mem_regno + 1.
Does this assumption hold when stack arguments are used, where the size
might not be at mem_regno + 1?

Looking at how mark_chain_precision() is called later in this function:

>  	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
>  				      access_type, zero_size_allowed, meta);
>  	if (!err)
> -		err = mark_chain_precision(env, regno);
> +		err = mark_chain_precision(env, size_regno);

The incorrect size_regno value would cause mark_chain_precision() to mark
the wrong register for precision tracking. For example, if the memory
pointer is passed in R5 and the size is in a stack slot, mem_regno would
be 5, making size_regno 6. This would incorrectly backtrack BPF_REG_6
instead of the stack slot containing the size argument.

Could this break verifier state pruning when the commit message's stated
goal of handling "stack arguments as they may be beyond registers 1-5" is
implemented?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============5858879229129043948==--
