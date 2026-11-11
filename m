Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384354;
	b=s6Vjr8ujMiCBRni0+oyCh2lcVO4VXVywbucN0+/nTA/GBjsBOXnSUtOHCYF7vOWJhzRo
	 AHm8wuyD3JlatulaLGN1c176eWTQhpzDskWixenJyU62vWZEYhAwFkjaQPpoHNhWMksNr
	 IONA5InrUEVr2cG2em80PldElFUmQMM8/PqhOLSi63fYpKLSlhYHfI16sHoVhwsI4QVz2
	 8GpGX9WRJiH/NVwIS56NdcNxWDYaEMeAN8wXghC9vNWKzz9WaCGfqaIdGAUglZPnPST4F
	 hpiiK67DwaZAJyc6jD0EUqtOdh920UAABMeInrwCVxM8PqZZITpZMQvX7qsOZwzS9Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384354;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jwObVC/mvexbREQ1uAgKavk9FT5aQB2RrfBQjYiY2kU=;
	b=uunnyj12C+/hBTI1Mu1PNoaWG3T6XJjz2lNnFMinopDBYr6hq/vHSDg9vpBFQ8xrqDUW
	 al2KIm+dkCrA3ciXBuSRujzmrvtWUB7J2lQKNUpCoBJdYn9yJEzpZwskSAfd1Xar8CURI
	 M4m1g7ium14pFVjM+93eGMNuMzxMreZ+XuVXNWKRbCqmYeWl64rOSs+sFH8MvYi/NdI4Q
	 BwtTtvEiXpKW5Nz8szzZl1UHLE19J2BGspjq3eqaoCBjSDKBKfA/g01+WXPqyEO36afX1
	 xHY/fmK8QtNePN5zc4aXfEu0PxDuCwmPJJ/to64+Q+WF/rkltcuLoOkjHBJaYxhHzEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWHvoXGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEF606A31C;
	Wed, 11 Nov 2026 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWHvoXGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729C01F00A05;
	Wed, 11 Nov 2026 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384354;
	bh=jwObVC/mvexbREQ1uAgKavk9FT5aQB2RrfBQjYiY2kU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fWHvoXGA9uxV8RUS6OuY+mCGi/lkhCTBTYEeU3ghs2/agxnPTiJTyj3Q/PVMYhczJ
	 kIJWZsrMTFwDZ9VKRRSQjMuGydqU1VMK84FdHjhYHTU/TF0ZHLfdK6EcHdnCFobzMQ
	 CMa0ZEiNAFqaRUspbSM6LEZneI3sNBxc1e7yqmLaLccdViUokEaMLbk3J0mRyl1a9O
	 t+inMJn9rrHh3TDyHnICLjiCSGvdQqI7YpC9gIwFddULTBcDxGm1AUrtm8kjWvjca1
	 ENL5pm8up/Vbw4idTI3CrHWyMalEqq8BFvtSOJN540EIlH63GpkKAdP6/7A7+LshgH
	 14USs/FZnm4UQ==
Content-Type: multipart/mixed; boundary="===============8814559659898024532=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5f4ff580aef8f7a6be0c0f1c320916596da0e7d72e15424c72bf7142fc7654cb@mail.kernel.org>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
From: bot+bpf-ci@kernel.org
To: k.chen@smail.nju.edu.cn,yonghong.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sumit.semwal@linaro.org,christian.koenig@amd.com,phasta@kernel.org,linux-media@vger.kernel.org,dri-devel@lists.freedesktop.org,linaro-mm-sig@lists.linaro.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:05:53 +0000 (UTC)

--===============8814559659898024532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: make dmabuf iterator stay drained after NULL

TL;DR: Nit only: the new comment in bpf_iter_dmabuf_next() describes the
pre-patch restart behavior, not the code it sits on; the review suggests
rewording it to explain why the sentinel exists.

> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c

[ ... ]

> @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
>  {
>  	struct bpf_iter_dmabuf_kern *kit = (void *)it;
>  
> +	/*
> +	 * The verifier assumes that an iterator which returned NULL keeps
> +	 * returning NULL (see process_iter_next_call()).  Without this check
> +	 * the NULL left by the last dma_buf_iter_next() would be interpreted
> +	 * as "not started" and the iteration would restart from the list head.
> +	 */
> +	if (kit->dmabuf == DMABUF_ITER_DONE)
> +		return NULL;
> +
>  	if (kit->dmabuf)
>  		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
>  	else
>  		kit->dmabuf = dma_buf_iter_begin();
>  
> +	if (!kit->dmabuf) {
> +		kit->dmabuf = DMABUF_ITER_DONE;
> +		return NULL;
> +	}
> +

This isn't a bug, but is the second sentence of the comment above
describing the pre-patch behavior rather than the code it sits on?

With this patch no NULL is ever left in kit->dmabuf, since the block
above replaces it with DMABUF_ITER_DONE:

    if (!kit->dmabuf) {
            kit->dmabuf = DMABUF_ITER_DONE;
            return NULL;
    }

If only the "if (kit->dmabuf == DMABUF_ITER_DONE)" check were removed, the
iteration would not restart from the list head.  The sentinel would take
the "if (kit->dmabuf)" branch and be passed to
dma_buf_iter_next((struct dma_buf *)1).

The restart described is the bug being fixed, which is already in the
changelog.  Could the comment instead say why the sentinel exists, for
example: once begin()/next() returns NULL, park the iterator at
DMABUF_ITER_DONE so it is not mistaken for a fresh (NULL) iterator, and
keep returning NULL as process_iter_next_call() requires?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982427559
--===============8814559659898024532==--
