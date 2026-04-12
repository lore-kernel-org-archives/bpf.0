Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871421FE451
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972601; cv=none; b=WBMoxN52LrEcxSksoYkHv5D3jgb8i+dPls5qUbRWVbuXV8gJ/Ge+BjAa3nTooLSeAZFXwUaonoqy5i5Z09cSU/vXC6MGF6AeJR+w6Y+2Z86rvkCqvUhm8LlRzfEhcUHwVi2w4fbw0UEMoWvNsO6SAAp6sLaB9CwTGoIk3S78eQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972601; c=relaxed/simple;
	bh=TYZk653/IJbUc00ugD0dJjRAtK+g4KRJ5VZajvwwOtQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WYr5r6umLWeXE4kB1wMAV4k09LnSgcCnxknOXZpFdPfmkN2pXCI6fmj5SZL+zFxhSfI2/RA9rR/7Nepn4v44ImgoXRjLqa3Au5zPsbytqK23M9vu4bMciJzeA9iLc4v2FumFrIsv4EZtEf4HmKOfrEzy0/ZNY9EbpZnsYpEs2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poNcy+ut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poNcy+ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C03C19424;
	Sun, 12 Apr 2026 05:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972601;
	bh=TYZk653/IJbUc00ugD0dJjRAtK+g4KRJ5VZajvwwOtQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=poNcy+uta8y81WQBIrilRPW06uQEBPzFr1rdPzseAqgZi05IeTi8dMJw1XbsjIe+X
	 1d+ML1Pa5Woe+t31XMgD1BSiJxqOBNrCoQxpQaIgeEpULJ6RHY9ir9wOg8W8sBz5CH
	 N7/Wzgh3tjGyamBsXBfkkLah8ITqTfVEG1rwBxk7dYa86XdnIRY3U8/eVSjsV/MbuK
	 Wvw4JeKNG4dNYKSVA/DQY5zlH6zgAjPb7js0v63wc9CvFFuixeTQHBsT+0PqDBT+nb
	 p/qDw4zhktKyXRElUeDjPIOlA9+LinxFMPQGfR7foP6yxz4x5Y0QBHyHoYrpDhFwiU
	 8ImYCnN/qMySA==
Content-Type: multipart/mixed; boundary="===============0069160052411199773=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <257c9ac68d5ab6ec929cd3d53c54793a848a6cfa07a65e9473ee66a4d44f2cc3@mail.kernel.org>
In-Reply-To: <20260412050033.267815-1-yonghong.song@linux.dev>
References: <20260412050033.267815-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:21 +0000 (UTC)

--===============0069160052411199773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 32864dbc2c4e..ec57b9a6b417 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1664,16 +1699,48 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image

[ ... ]

> +	/*
> +	 * The verifier guarantees that neither tail_call_reachable nor
> +	 * priv_stack is set when outgoing stack args exist, so R9 is
> +	 * always available.

[ ... ]

> @@ -2243,6 +2377,18 @@ st:			if (is_imm8(insn->off))
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>  		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>  			insn_off = insn->off;
> +			if (adjust_stack_arg_off) {
> +				if (insn_off == 8) {
> +					/* Incoming arg 6: read from r9 */
> +					EMIT_mov(dst_reg, X86_REG_R9);
> +					break;
> +				}

[ ... ]

> @@ -3757,7 +3907,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		prog->aux->jit_data = jit_data;
>  	}
>  	priv_stack_ptr = prog->aux->priv_stack_ptr;
> -	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
> +	/*
> +	 * x86-64 uses R9 for both private stack frame pointer and
> +	 * outgoing arg 6, so disable private stack when outgoing
> +	 * stack args are present.
> +	 */
> +	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack &&
> +	    prog->aux->stack_arg_depth == prog->aux->incoming_stack_arg_depth) {

This condition disables priv_stack when outgoing stack args are present,
but R9 is also used for incoming arg 6. Could a subprog with incoming
stack args (incoming_stack_arg_depth > 0) and no outgoing stack args
still get priv_stack allocated here?

The condition stack_arg_depth == incoming_stack_arg_depth is true when
outgoing is zero, regardless of the incoming depth. When priv_stack is
allocated, emit_priv_frame_ptr() in the prologue overwrites R9:

  emit_mov_imm64(&prog, X86_REG_R9, ...priv_frame_ptr...);

Later, the LDX handler for incoming arg 6 reads R9 expecting the
caller's 6th argument:

  if (insn_off == 8) {
      EMIT_mov(dst_reg, X86_REG_R9);
      break;
  }

For a subprog with 6+ args and >= 64 bytes of stack (triggering
PRIV_STACK_ADAPTIVE in check_max_stack_depth_subprog()), R9 would
contain the private stack frame pointer instead of the incoming arg 6
value.

The comment also says "outgoing arg 6" but should this also mention
incoming arg 6, since both use R9?

Would changing the condition to check that stack_arg_depth is zero
(no stack args at all) be the right fix here?

>  		/* Allocate actual private stack size with verifier-calculated
>  		 * stack size plus two memory guards to protect overflow and
>  		 * underflow.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============0069160052411199773==--
