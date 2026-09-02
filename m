Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52985378D76
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334875; cv=none; b=Fy22xRLGXFMdwlnPM5Dtw8KwOYv4tTR6unPqeKyt37WRnwFOHySDvUELW8us3KC1OlLgvzxeMwy6/K1TFGhYEKRuviYEMLvFWmlrD0cjL1AKRt8PEv9yFvgPaHLEy6XY8ME59XnF9Xz8BBWD21eSmGX7I3O9jESqmbvcn8st92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334875; c=relaxed/simple;
	bh=VHZa4U4t8Is75tAFaVsVGm25RsKxa6OC1mnrJ19r1M0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pnRD96LGKFLA9i+HrY3Je78Xj2wD8niozv6fJhQ3ooifwWozS7R3cLMlHHcJPHqf43l9HmXK3xOzhTA1FGpH12pVKS/N2ICpsiG/MW1AAL3KhXmLZ+tE2db6IRd/VnisdZjRZg5aDmYDHHibbMr8MYf5FtEZ3jwUQF3zshSfvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa7TyxqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa7TyxqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591C41F000E9;
	Wed,  2 Sep 2026 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334873;
	bh=gyiUaeAtb1nZu0CUSwVQUa9uS4b1lqxm/eMLEoUr/pA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Pa7TyxqR2dRrZ9uqnEgxaT19Fwtfc79QgwwW8oPpRUXyjhxyI8GD1PVc4jgFXmQor
	 gu6o8VWDkertsOGv7XhkPxmX7SR2Iv5ljuk4tebGeT0N8uCqnMkr7DABstS50y90TY
	 C0QaDh23bcK9OZuSai5DsBvc89gWvsfEfW5gOs/y8r5Ds2u9+C3FsC7mAKZiTEGzAF
	 i+5vmnkKjAVQwWPMsbG5DFuGKQwSA5cqyWz277D5enl6SzU+mHfuSRGxywTbwPCpUg
	 AMc21QldtfrmwE/+prSehBczke04ooyxkLkK1yWSSmAVrmEKNEzpRXCYVdiVpuXO0o
	 MNt9WRG6t2Vgw==
Content-Type: multipart/mixed; boundary="===============2520145911564385793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da1f216ffd5f1f1102cb82245064b6f60f6e893f6a2e6cb46983206195f49c75@mail.kernel.org>
In-Reply-To: <20260902065226.25201-1-fw@strlen.de>
References: <20260902065226.25201-1-fw@strlen.de>
Subject: Re: [PATCH bpf] selftests/bpf: Add tests to assert that netfilter progs cannot write to skb
From: bot+bpf-ci@kernel.org
To: fw@strlen.de,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,fw@strlen.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 07:41:13 +0000 (UTC)

--===============2520145911564385793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> index e2cbc5bda65e..7e304331409f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
> @@ -113,4 +113,82 @@ int with_valid_ctx_access_test6(struct bpf_nf_ctx *ctx)
>  	return th->dest == bpf_htons(22) ? NF_ACCEPT : NF_DROP;
>  }
>
> +SEC("netfilter")
> +__description("netfilter test prog with skb write access")
> +__failure __msg("only read is supported")
> +int skb_len_write(struct bpf_nf_ctx *ctx)
> +{
> +	ctx->skb->len = 1;
> +	return 1;
> +}
> +
> +SEC("netfilter")
> +__description("netfilter test prog with skb data write access")
> +__failure __msg("cannot write into rdonly_untrusted_mem")
> +int with_invalid_data_write_test4(struct bpf_nf_ctx *ctx)

This isn't a bug, but would a name like skb_data_write read better here,
given with_invalid_ctx_access_test4() already exists in this file and the
other new progs carry no test number?

> +{
> +	ctx->skb->data[0] = 0;
> +	return 1;
> +}

[ ... ]

> +SEC("netfilter")
> +__description("netfilter test prog with bpf dynptr_slice_write + write")
> +__failure __msg("cannot write into rdonly_mem")
> +int with_dynptr_store(struct bpf_nf_ctx *ctx)

This isn't a bug, but should this description say bpf_dynptr_slice() (the
helper the prog actually calls) rather than 'bpf dynptr_slice_write'? The
neighbouring descriptions spell the callee exactly ('netfilter test prog
with bpf_dynptr_write', 'netfilter test prog with bpf_dynptr_slice_rdwr'),
and no helper named dynptr_slice_write exists.

> +{
> +	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
> +	u8 buffer_iph[20] = {};
> +	struct bpf_dynptr ptr;
> +	struct iphdr *iph;
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr))
> +		return 1;
> +
> +	iph = bpf_dynptr_slice(&ptr, 0, buffer_iph, sizeof(buffer_iph));
> +	if (!iph)
> +		return 0;
> +	iph->protocol = 42;
> +
> +	return 1;
> +}

Regarding the commit message:

>     Assert that bpf netfilter program type exposes readonly access to the
>     skb, either via direct packet access or via dynptr API.

This isn't a bug, but since netfilter progs have no direct packet access,
would it be clearer to describe this case as writing through ctx->skb (BTF
walk) instead of 'direct packet access'? The test (ctx->skb->data[0] = 0)
walks a BTF pointer, which is why the expected message is 'cannot write
into rdonly_untrusted_mem' rather than a packet-access error.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33601668670
--===============2520145911564385793==--
