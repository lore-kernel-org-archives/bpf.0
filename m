Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461413EA66
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359590; cv=none; b=QcL6qk6Ja13B6JiKmWRVWPrWZEyadsBohzqWEjmH9G2hy6mHsHEczlh5qWldv0Zbr+i43WjyladeIZ+7APRB1QCjD9hqWS/8k/dUZ/xJOYcghOQiVXrgb7w7lkY8QYd0a/s8eGvUFyz/21VRaE801ofvOvH/lsLb13/SOdABlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359590; c=relaxed/simple;
	bh=UDN6y9xgBy/NaTOMqJojqxk/RKetjkJYICkyxBJdI4Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gLzaHrJkQ4LI72cwQMclvgfYZiVSqCMLdMJk3TKZrJFLzPLU+SRs4MjL6W6P2UeiXFlGjZO2GJA3h29OSLjf8EzZcfI1pdiMlL+1rjBzF3H7QzXbLtAl3vgpz18zmSaH9707igNd+lSVuynH3Hs+PJ61dbTEiPvIqnAceYq69hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owyl8Rxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owyl8Rxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09001F000E9;
	Sat, 22 Aug 2026 00:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359589;
	bh=XOEfbg6DOtV1k8kbbZZ5ijEXOPSjthYYbELSmvm3pn4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Owyl8RxpWIfdTySRY9T+jM0YHsEwFJ7miJK8fmyxDrx4PZ3zIzDuhKRT9Sf6REk/g
	 RS6y0Nmblr7AfsYXWgtrojO+skGmahCJjtdjvKEqkhcGKo/UEKXi+vhQ/bpjm1/PfV
	 Bxi+m1/KaMc10Q0kYfp3ni0wSxaEorg0sYf62OOHdZzWVKBLRv41nZIS29urH5IHll
	 4SVEw3NNrn0tUTBlYWqQqIL6kn7ZZNtZROEyTh4d8Ee12p6OROdd+JQv9st88+6fXj
	 DbHtlt6W6DB82s3c6Wg8XCTVB1iPbaHgD8pPf9Mtb608nfTOEwJi61n2BkClQkTPic
	 jEjmcUI9hSqCg==
Content-Type: multipart/mixed; boundary="===============2524534819715560195=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <be662c3500204166bdf6398bd1a8c974ecf43b4ab56052772e9eaedb4cd951f7@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-8-memxor@gmail.com>
References: <20260821233516.3426127-8-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/14] bpf, loongarch: Fix stack arguments for indirect trampolines
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: yangtiezhu@loongson.cn,chenhuacai@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:28 +0000 (UTC)

--===============2524534819715560195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 29c281bef28ef..d193293a0fd25 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1662,17 +1662,18 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
>  	return ret;
>  }
>
> -static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off)
> +static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_off, bool is_struct_ops)
>  {
> +	int stack_args_off = is_struct_ops ? 0 : 16;
>  	int i;
>
>  	for (i = 0; i < nr_arg_slots; i++) {
>  		if (i < LOONGARCH_MAX_REG_ARGS)
>  			emit_insn(ctx, std, LOONGARCH_GPR_A0 + i, LOONGARCH_GPR_FP, -args_off);
>  		else {
> -			/* Skip slots for T0 and FP of traced function */
> +			/* Skip the saved T0 and FP slots for a traced function. */
>  			emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
> -				  16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
> +				  stack_args_off + (i - LOONGARCH_MAX_REG_ARGS) * 8);
>  			emit_insn(ctx, std, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP, -args_off);
>  		}
>  		args_off -= 8;

This isn't a bug, but does the updated comment still accurately describe
what happens in both cases?

When is_struct_ops is true, stack_args_off is 0, so the code loads stack
arguments directly from FP+0 without skipping anything. The indirect
trampoline prologue saves RA and FP below FP, not above it, so there are
no saved slots to skip in that case.

The comment now says "Skip the saved T0 and FP slots for a traced
function," but it sits on a line that executes for both traced functions
(where the skip happens) and indirect trampolines (where it doesn't).

Could the comment be moved or reworded to reflect that the skipping only
applies to the fentry case? For instance, a comment on the stack_args_off
initialization could explain both frame layouts.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============2524534819715560195==--
