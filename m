Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC72E62B7
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918176; cv=none; b=uMYaypzpb2ISsCPzUREwzByeDoLhbzY/kpa0P9DpUBkeUnP5aJNcvQjEVuyLYsP0G3VXT8zRJQGxKDZ1BrQljj4Hqco0e+pq2pahUaRmnXTElrhoZq32EKUyKDf9c1oR2o/XuGCYM+oOfdX8xIT4Y5MGgwohXuq/2pDpcLeJgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918176; c=relaxed/simple;
	bh=OcsuOU/aBIaAONQEZko5hGsBP7T9jXXDhMxtpmgjoLU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WXih2gpt0kpbWO1lf7/57B1WIYh1KSAa4piq/4VsACV9PDKHfOsPe0gTnH62eTrBBWaXbOeI8nPN0azAUZp0apzEVhkkOxa7oA11ysRH1P1mE6Uh/a4sXliUMWz/r/KtpoyCjf3trAuYcmv2Kz6wcTO7hNC6XZKVLUGFesjGRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5NRTkkf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5NRTkkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FBEC2BCB2;
	Thu, 23 Apr 2026 04:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918175;
	bh=OcsuOU/aBIaAONQEZko5hGsBP7T9jXXDhMxtpmgjoLU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g5NRTkkfaz2ur5KVtSaVeIkBScyQQZR5YMAzeJW9N3lSdaYlnizNM0txQCL06aNcp
	 8C200mdjoHWxBIfc899cIxyONhHPA6uEVfLMa4JyiBzFkWY50zU/z3ahHCnvHmS4Bw
	 v+dikcwINdkNeiY8OFH+tbHWvvwRf4FnbxxQG7W/hInCln2hZK8mm2ahDWTphr7u5a
	 Go3jIQbFdy4sj7xwtPtWrryUYeYWotU7zoAjtRTa03a9DCBQoFdhdAFNn9KSpoLRYg
	 +FQH0Zu9WijCSXG5LuwHac0SEHp+c5/kYMF4JLO3UUeTOrX7cUlQFz9AuH6uE980Lz
	 HmikI3QbBIsCg==
Content-Type: multipart/mixed; boundary="===============9157370519787508111=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <005e4a9d553a642ee20ce998ad780682b5e481e8abcc8ce3dbbcf459e4691e52@mail.kernel.org>
In-Reply-To: <20260423033446.2538321-1-yonghong.song@linux.dev>
References: <20260423033446.2538321-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Refactor to avoid redundant calculation of bpf_reg_state
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,memxor@gmail.com,ameryhung@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Apr 2026 04:22:55 +0000 (UTC)

--===============9157370519787508111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d123449f5552..debae6133e4c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3929,13 +3929,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  static int check_stack_write_var_off(struct bpf_verifier_env *env,
>  				     /* func where register points to */
>  				     struct bpf_func_state *state,
> -				     int ptr_regno, int off, int size,
> +				     struct bpf_reg_state *ptr_reg, int off, int size,
>  				     int value_regno, int insn_idx)
>  {
>  	struct bpf_func_state *cur; /* state of the current function */
>  	int min_off, max_off;
>  	int i, err;
> -	struct bpf_reg_state *ptr_reg = NULL, *value_reg = NULL;
> +	struct bpf_reg_state *value_reg = NULL;
>  	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
>  	bool writing_zero = false;
>  	/* set if the fact that we're writing a zero is used to let any
> @@ -3944,7 +3944,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>  	bool zero_used = false;
>
>  	cur = env->cur_state->frame[env->cur_state->curframe];
> -	ptr_reg = &cur->regs[ptr_regno];

The comment on the second parameter above still reads "func where
register points to" but this is no longer accurate now that ptr_reg
is passed directly as a parameter rather than being derived from
ptr_regno within the function.

While the function-level comment for check_stack_write was updated to
reflect the parameter change from ptr_regno to reg, this inline
parameter comment was not similarly updated.



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24815670157
--===============9157370519787508111==--
