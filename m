Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E173246FE
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677145; cv=none; b=kc9pK1Sz/eBjsyBEARUG/f0JLnOEJ1N5dLEdSM9Eyw8UH8q46aYRjv/ht5HeiqO0hQi1DTch03tRiJWSp7qYv3UzDa5IorQVTWlojBQdtb4Ez9MZse913JpQuPcel3uHXHy+N3p2428Mi0j14ocA/p78B5GY2xABYlsiJPQ9EgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677145; c=relaxed/simple;
	bh=lkRYUP0CQqhJFv28v0xUpwJVmnqY1Gda61vqxO/hDxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iex+U683+N11nc2GziNHuTMgRsC0gdv07xmjP9OQieUjQ7+3xneT3AAvrBKAeOpb1xNwJyrxxfjTULGVp0+rwW9SP1wFwxZiXTyJM+juWXfbfEtVNQM+tWQwwIaBneluyXxUpciNEMCRFFyW0d3UtMV+gYIdLiXAxwUCdtEERsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYv9c72q; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYv9c72q"
Message-ID: <49ac3434-e441-4681-99ba-a1ed735417dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773677141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C0nriLycJRgBWtwXORu4DTAPeWPKQtvN2yalOvskN8=;
	b=LYv9c72q/wN0lxcXA1B3N0I7jqZs8viZzQIqt6U3AV3kDrVwguBPOjrWedw6Q9RsshA/sw
	A+Sp1MsmDQ7eOiw/kPPAXd2Egm6yI0LUUn7uAexx11NAyqzGQbjS/ZCuTqjowjwDyFsOS/
	D0qdKRJ+rz8BuNXBLdKilk5xxLqIzwI=
Date: Mon, 16 Mar 2026 09:05:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] s390/bpf: Zero-extend bpf prog return values and kfunc
 arguments
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
References: <20260313174807.581826-1-iii@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260313174807.581826-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/13/26 10:46 AM, Ilya Leoshkevich wrote:
> s390x ABI requires callers to zero-extend unsigned arguments and
> sign-extend signed arguments, and callees to zero-extend unsigned
> return values and sign-extend signed return values.
> 
> s390 BPF JIT currently implements only sign extension. Fix this
> omission and implement zero extension too.
> 
> Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
> Closes: https://lore.kernel.org/bpf/20260312080113.843408-1-hbathini@linux.ibm.com/
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 15 deletions(-)

Hi Ilya,

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This bug made the BPF CI red. I applied as temporary CI diff.

Interestingly, an AI bot investigated the test failure and came up
with a similar patch [1]. Gotta teach it to scan upstream for existing
fixes first :)

Thank you!

[1] https://github.com/kernel-patches/vmtest/issues/459


> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 1f9a6b728beb..d08d159b6319 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -830,25 +830,34 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
>  }
>  
>  /*
> - * Sign-extend the register if necessary
> + * Sign- or zero-extend the register if necessary
>   */
> -static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
> +static int sign_zero_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
>  {
> -	if (!(flags & BTF_FMODEL_SIGNED_ARG))
> -		return 0;
> -
>  	switch (size) {
>  	case 1:
> -		/* lgbr %r,%r */
> -		EMIT4(0xb9060000, r, r);
> +		if (flags & BTF_FMODEL_SIGNED_ARG)
> +			/* lgbr %r,%r */
> +			EMIT4(0xb9060000, r, r);
> +		else
> +			/* llgcr %r,%r */
> +			EMIT4(0xb9840000, r, r);
>  		return 0;
>  	case 2:
> -		/* lghr %r,%r */
> -		EMIT4(0xb9070000, r, r);
> +		if (flags & BTF_FMODEL_SIGNED_ARG)
> +			/* lghr %r,%r */
> +			EMIT4(0xb9070000, r, r);
> +		else
> +			/* llghr %r,%r */
> +			EMIT4(0xb9850000, r, r);
>  		return 0;
>  	case 4:
> -		/* lgfr %r,%r */
> -		EMIT4(0xb9140000, r, r);
> +		if (flags & BTF_FMODEL_SIGNED_ARG)
> +			/* lgfr %r,%r */
> +			EMIT4(0xb9140000, r, r);
> +		else
> +			/* llgfr %r,%r */
> +			EMIT4(0xb9160000, r, r);
>  		return 0;
>  	case 8:
>  		return 0;
> @@ -1798,9 +1807,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
>  				return -1;
>  
>  			for (j = 0; j < m->nr_args; j++) {
> -				if (sign_extend(jit, BPF_REG_1 + j,
> -						m->arg_size[j],
> -						m->arg_flags[j]))
> +				if (sign_zero_extend(jit, BPF_REG_1 + j,
> +						     m->arg_size[j],
> +						     m->arg_flags[j]))
>  					return -1;
>  			}
>  		}
> @@ -2566,7 +2575,7 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
>  	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, p->bpf_func);
>  	/* stg %r2,retval_off(%r15) */
>  	if (save_ret) {
> -		if (sign_extend(jit, REG_2, m->ret_size, m->ret_flags))
> +		if (sign_zero_extend(jit, REG_2, m->ret_size, m->ret_flags))
>  			return -1;
>  		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
>  			      tjit->retval_off);

