Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939099;
	b=yUl4dDApJR9dSJ03VXnx1teZk9T6WNdgrbwuFQUz9jxbp+WYm39Im3CD6yN+4FpQLo6O
	 vyBgVRO+qF3PeVJrnU6b2yGM+2OtK4upPM7pLcwoQ927lWQcyRByZW7EL1L01HFtkCO2m
	 ikj7Ah/mYWitdZolk0mqeIe1h8BEjXgfX0elfGJOMOMui3y45HNV30JsDAMnSShN0l/cT
	 Ov39Ul6AeABmQhAiR4l7FkOGoMPvCyCDGSnsLKs2TCvgYTNDcWK1XXlfAe3urGn+u5BdY
	 nnuUVSehfHENAVYwo4h/WTdR98x4xh5PZiTyKPXNvQpXlSlA5X7siGcAHfqLB1n7exA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939099;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=s/kqWwMzu7vCKvkJd7pVuZMkiI+rgg/+sJKmDC5EIa4=;
	b=FszGay8Ykzip8Pb/jDrok95EWN3zidJuDpPkLDEY93DHdEwopr5gP2jD77p/mo7FyQsx
	 ntrEswf85PYZB2jFZbZvdMt3XaeVjNjcFTXJlnxX9w6wBJQV14l1HPXf2KzDAI1DiWaO7
	 7M2+X2987oAZPd9AkuJyINvkMO0UU8Yv7vWGaxY7ZoUbOyP0Jw5NQxFLrcTOYYdbFi6Nk
	 74hf9XkE4yraSyZzWFokcfEIzSTdi0OCmN1Bp3kG3YjkxJ8daH75VKOGNGnccV1y9GZlp
	 iQVLsmCOmHS1EvaeJ74cDiukYx7NvRRmXqr/dtIQkLaukpEaYRoF4xTwwNxJxBws8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmUUSmxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EA606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmUUSmxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AAF1F0089F;
	Fri,  6 Nov 2026 04:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939098;
	bh=s/kqWwMzu7vCKvkJd7pVuZMkiI+rgg/+sJKmDC5EIa4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AmUUSmxK2ZaQYzB1TE0m5084irZNMwWH6P9/UoclRaNt4W19+flgd0eP6mtt56EKi
	 AulUaLgudkA7dsaHHIu1o84L1+oCWnTEfATwKJPXnkuvp/QhSuMzvnRuJ8gm8jJYzT
	 s4N1bntqaEKvOgr4Xa/t/TKZdbDTJWLkVOH+rhkMVl24Sxbpfij51SY0XnUEVhMxdi
	 bfrBUAPxwGRs0aQPOFbIbskfDoiUY2VWKbBRLiYo8GaY+sIlUZFWoafKou+qT5yfMR
	 0O2HtXRS0nhXXMoTF5bIJNlTdjzyS3zdZqixwQ5Ik4V8YpF30S9RFb2maCXTrCdEzq
	 /hseWfqUzX3OA==
Content-Type: multipart/mixed; boundary="===============1877315600829698008=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <644690e38c45a876ca35660ae89e8ebda63cf971fad497ab5fc84aa325bc983e@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-25-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-25-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 24/45] bpf: Remove precision tracking
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:24:58 +0000 (UTC)

--===============1877315600829698008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove precision tracking

TL;DR: Nit only: in check_stack_read_fixed_off(), the first two branches are
now identical after insn_flags removal, so the if/else chain could possibly
collapse into one mark_reg_stack_read() call.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -4356,18 +4174,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>
>  				if (spill_cnt == size &&
>  				    tnum_is_const(reg->var_off) && reg->var_off.value == 0) {
> -					__mark_reg_const_zero(env, &state->regs[dst_regno]);
> -					/* this IS register fill, so keep insn_flags */
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
>  				} else if (zero_cnt == size) {
>  					/* similarly to mark_reg_stack_read(), preserve zeroes */
> -					__mark_reg_const_zero(env, &state->regs[dst_regno]);
> -					insn_flags = 0; /* not restoring original register state */
> +					__mark_reg_const_zero(&state->regs[dst_regno]);
>  				} else {
> -					err = mark_reg_stack_read(env, reg_state, off, off + size,
> -								  dst_regno);
> -					if (err)
> -						return err;
> -					insn_flags = 0; /* not restoring original register state */
> +					mark_reg_stack_read(env, reg_state, off, off + size,
> +							    dst_regno);
>  				}

This isn't a bug, but now that insn_flags is gone, the first two branches
have the same body, and mark_reg_stack_read() already produces a const
zero in both of those cases.

Could the if/else chain be replaced by a single call to
mark_reg_stack_read(env, reg_state, off, off + size, dst_regno)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============1877315600829698008==--
