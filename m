Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7195223E334
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885930; cv=none; b=f5BtHr2nRTcTVHvo4D2CGxWymESbfLqrubTL2LO7H4OpsAohGcsXrK9PnMp2nQBxplUSfGp08YNhD/RE3wiyMOGMANpIE8UO3VXos53Sq4lBKEn0xUIQnvwS9aTHdadVcoU47cKXp7tSfshohbLY/S+V/O/mLTrMivvmIjWa4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885930; c=relaxed/simple;
	bh=elNPjadFvqueyjShTEaluDT7mTRA/bzHugrSGt2Axd4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Mj9kMrxwaCFGdAK/Zw6Hjc1GhrWC6dyLyPJ8X/dTlPaVouHE0/c0KLHw7qK5cMjxhjhm9kizj5GPGd1r5veDJ7I7FolVDdwqftcvUQsw3wwlijn1VCVZMjh4mrqAhwsEd/oAS+KQSUEwnCvTxDW3GekjcuPQQO28ZXPwIDZ3Jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcNMycRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcNMycRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62F41F000FF;
	Sun, 20 Sep 2026 06:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885929;
	bh=FbTfQsEplxd9JOen2KPTPQzjUYnoX6JGlUZBGGSaDNw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XcNMycRdsvS9gdmty5VNt/ZSmth0KTYTDbtE/nzRAA9EBhVNvvO0dszj16bPEtPlf
	 j+xR9JMUKVnYdxWk9RHhkAfdEC0nuNthbCuHpNQTCKeXvRPiVICw4aPGDbtjBostuv
	 usJ/c/LM6GqbKu87fbxUEX4MTLXiUc7eKAzPfoT0jad5LvycWHAfXy6rdUMmQSQzr0
	 8Gp7v8QKwY8dVlgc37OQsSbNHY8P7YNH2ax6047dEhnRy8jUBXCd4XO0JNA7/rI9w8
	 Q+IbWFjZGjvkXvhMH5cGR5V5Lzfl3OKeH+kZeeZe5wW+8ezJNjBtnWH74mtXC1TliY
	 6k45u0YS03mQA==
Content-Type: multipart/mixed; boundary="===============7432319729430540131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16d53b65310325ae6e5c4c49c2ddbc02146050c34ffba04b25a071a70ffdf9cf@mail.kernel.org>
In-Reply-To: <20260920054317.870021-1-yonghong.song@linux.dev>
References: <20260920054317.870021-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 10/20] bpf: Dispatch exception cleanup pads from bpf_throw()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:32:07 +0000 (UTC)

--===============7432319729430540131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5033b934ffd9..0502b9fc4a6d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 4859d6484cc8..d4dcbcf4fb25 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> @@ -499,3 +501,164 @@ int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx)
>
>  	return pad ? (int)pad - 1 : -1;
>  }
> +
> +int bpf_cleanup_alloc_info(struct bpf_prog_aux *aux)
> +{
> +	if (aux->exc)
> +		return 0;
> +	aux->exc = kzalloc_obj(struct bpf_exception_info, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	return aux->exc ? 0 : -ENOMEM;
> +}
> +
> +int bpf_cleanup_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_info *recs, u32 cnt)
> +{
> +	struct bpf_exception_info *exc = aux->exc;
> +	struct bpf_cleanup_range *ranges;
> +	u32 i, n_at, *at;
> +
> +	if (!cnt) {
> +		kvfree(recs);
> +		return 0;
> +	}

This isn't a bug, but bpf_cleanup_attach_info()'s only caller already
returns early when cnt is zero - is the `if (!cnt)` arm here reachable,
or would dropping it (and letting the caller keep owning that case) make
the recs ownership easier to follow?

> +
> +	ranges = kvcalloc(cnt, sizeof(*ranges), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 558653d3046d..169cbf9f4415 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1114,6 +1124,129 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
>  	env->subprog_info[env->subprog_cnt].start = env->prog->len;
>  }
>
> +static int cleanup_pad_body_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
> +					u32 start, u32 end)
> +{
> +	unsigned long *bits;
> +	u32 i, cnt = 0;
> +
> +	for (i = start; i < end; i++)
> +		if (env->insn_aux_data[i].in_cleanup_pad)
> +			cnt++;
> +	if (!cnt)
> +		return 0;
> +
> +	bits = bitmap_zalloc(end - start, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	if (!bits)
> +		return -ENOMEM;
> +
> +	for (i = start; i < end; i++)
> +		if (env->insn_aux_data[i].in_cleanup_pad)
> +			__set_bit(i - start, bits);
> +
> +	sub->aux->exc->pad_body = bits;
> +	sub->aux->exc->nr_pad_body = end - start;
> +	return 0;
> +}

This isn't a bug, but would naming this field after the bitmap size
rather than nr_pad_body make it clearer that it is the bit count and not
the number of pad-body instructions, given the nr_throw_at /
nr_resume_at siblings are true counts?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============7432319729430540131==--
