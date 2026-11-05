Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876395;
	b=uKUyEfSvNtwk7Vaa3NIGiItqAUew1wAxmoXjfNQLC0arM9sdk/9vpLcb+loUrysI//O1
	 PcC9o/QuuL6l0lZweKogVygpuaiOJO4lHnPeKvCSloKcJUunWctyj8vY0yPpb98wcd7Dl
	 3V5Y653F2kQ8wdMF6OIVWbnUEYZQ3VzzPwCLivMrO8uupItdNMZK55+qCIJANt6eYX8MB
	 WqSBr5PJ87QU6kD+Tgax071LVlmY5O6M0ItwpXR6bVXcOSJlEnwN0hjn/2nMdf5w2FTZw
	 XgYXDJbyfBGB1kmnkgcrOWNIAsaAx9E+lUvT+sLeq2BE5+S6QQpgMqmOTBhVF8BZg+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876395;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=t5+p9iJMZToojqhmNYvXQKxqNfYJdePkWIrp9noGGxI=;
	b=o3WCgRd2yGfjqDZVAXXRoEDf6M68xswMjScEzQeLt6Aio8C8C1k6HUfkVVTynRAESewd
	 2LJlmS4+9aPJFynDje2VsqdzhX/cG1pni9jaF9Rh2DH9+KogSk4tGuS3aQmIu+i0QVtF3
	 GMeRjOJ+jtzXzyXAaf58dMWbQPfF7wIxILIKqEmu5y1x3EjXt5wHZ99C39Kdcgyy9Zj0g
	 DTcXl84oQBL0QrTEoyh5jMLwHIapMQcnbhYJQP+LwDZItkT5ForNd1Rjz2wo6ZVnRjFan
	 EHVA6kjwPWWk1xaUuNbDfPIXXGBbailC2tPTJcbo1avVBXxmADahwZyalnqW1n1q2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPTXPSFP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D1606D816
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPTXPSFP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548441F00A21;
	Thu,  5 Nov 2026 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876394;
	bh=t5+p9iJMZToojqhmNYvXQKxqNfYJdePkWIrp9noGGxI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RPTXPSFP3n3eMASPTaI4hLhz92MWMEtMXudCs/gnnjTAmDaB8e3BMo1b2HL2knJrf
	 Dq8X9TPDzKdfMkmwt1UZ71wMAJbL5Vqz9gvGNyJma9a+GFeGFh0klsknVpjhYVjgxf
	 STDn0fINtxWjjDKacW7I7d6+MvHMfzo5DQRvJJFSgQYp80+pPBcBFtceoDtxRG8AO6
	 dfpfbKGs7/CO+a1Eqib1SIiUQhUFlmrhYX/gG1PDAzG3TvBqtvtUoC7gbgMOxA62sB
	 vivOkxBnWiJdeN4nhvk0T9qrIsRYgVuToH3MIF30qYPuZTGPtMnGN+5HRLm524hbp6
	 /hFuaC0v8zhig==
Content-Type: multipart/mixed; boundary="===============5606202118295207002=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <feb942065da5a4dce372fc631d390e52b381ef87f223f83d51cd350d92822066@mail.kernel.org>
In-Reply-To: <20261105102343.311331-2-jolsa@kernel.org>
References: <20261105102343.311331-2-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 10:59:54 +0000 (UTC)

--===============5606202118295207002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Honor const on generic kfunc memory arguments

TL;DR: Comment and kfuncs.rst claim the compiler enforces const, but casts
drop it; a kfunc writing through a const memory arg could corrupt verifier
state. No in-tree case found; docs should state the contract.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13448,6 +13448,22 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
>  	return btf_param_match_suffix(btf, arg, "__szk");
>  }
>  
> +/* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
> +static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
> +					     const struct btf_param *arg)
> +{
> +	const struct btf_type *t = btf_type_skip_modifiers(btf, arg->type, NULL);
> +	u32 id, ref_id;
> +
> +	btf_type_skip_modifiers(btf, t->type, &ref_id);
> +	for (id = t->type; id != ref_id; id = t->type) {
> +		t = btf_type_by_id(btf, id);
> +		if (btf_kind(t) == BTF_KIND_CONST)
> +			return MEM_RDONLY;
> +	}
> +	return MEM_WRITE;
> +}

This isn't a bug, but is the comment "The compiler enforces it" accurate?
In C a cast silently drops const, and one registered kfunc already does
this:

    __bpf_kfunc int bpf_ct_set_status(const struct nf_conn___init *nfct,
                                      u32 status)
    {
            return nf_ct_change_status_common((struct nf_conn *)nfct, status);
    }

That argument is ARG_PTR_TO_BTF_ID today, so this patch does not reach it.

With MEM_RDONLY returned from kfunc_arg_mem_flag(), func_arg_access_type()
yields BPF_READ only, so the BPF_WRITE handling is skipped:

- check_stack_range_initialized() does not clobber the stack, so spilled
  pointers and known constants survive the call.
- check_map_access_type() accepts BPF_F_RDONLY_PROG map values, whose
  contents the verifier constant-folds.
- check_reg_type() accepts PTR_TO_MEM|MEM_RDONLY and PTR_TO_BUF|MEM_RDONLY.
- may_access_direct_pkt_data() no longer sets seen_direct_write for packet
  pointers.

A kfunc taking a pointer to const scalar, void or scalar-only struct memory
that writes through it after a cast would corrupt state the verifier
believes is intact.  I did not find an in-tree kfunc that does this, so it
is not a live problem.

Could the comment, and the new kfuncs.rst paragraph that only says the
verifier checks such memory for read access, state the actual contract,
for example that a kfunc must not write through a const memory argument
because the verifier relies on it?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42012074982
--===============5606202118295207002==--
