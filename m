Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795054100;
	b=YrWs9P6Cn4gZclMk8KWENZM/bEIe5EFU0XF/BiElwvj4C75zrpp9aStcXsKvze21H6+l
	 Fq538rTnOVSdyvWG35i9GZctiXaL5COwfFMiTWYG49rSp1WwHyImoJRlBIMGGk+Zz2umV
	 WxvDJi9LvHkCWW7YumIAJT1VIH8JKoHr12RZJEt7hRcv2cqsUUalsu8Cwwco6fUVjhIPU
	 /0X+8ToTa8z7u1BZ0NCTnf2igGMVNK0VI67ReuLyIzNQJbcNap8aRUz0iuXD7ysEIkXUY
	 drzzoCRIVhZRljKj20QWVXLXLK7UjDTF5HMQP+STNhpkdE2u0FN/ecv88sST/vMg5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795054100;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=W0m7JvEwQLZ/Oaltu1aF1zpqaTQGfoNPoFaP9y010Ec=;
	b=Kco2ojJCzD3e0Ir7RIURzdtZKl91+tbkktim6Cvxy5Z85dxY4rT07jJLwfJqG2cpff9H
	 6DZuGL5ridCO9/spRUBysSGRv58kxlUAN8WZFgSqoeg6bSJiDyB7B8oCHdhn0kYYnSPTs
	 xSbvcbhxdAI74rqtIkLmU/GY7uC4B2GfobuYPwAxJN60ItKdv1FoMJsgwrIxsF3FS9PG1
	 ljvvc8CaofADj54HANWtHMLM4u1LtVuwAwMSJvqWa5w2B8C2SexFrUu//tLulxEGAnsBt
	 +//5NeJK8Fz6fWXT28o6FKzRerd5IwgYd6q94Me1NoUjJ4ln7m6s7mXe9/TTvI48Kqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clhVia1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B22606A32F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clhVia1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B12C1F000C6;
	Thu, 19 Nov 2026 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795054099;
	bh=W0m7JvEwQLZ/Oaltu1aF1zpqaTQGfoNPoFaP9y010Ec=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=clhVia1X8TIjXUD7DPAaOHQS6EYNASCUlHXesVx3zhtFcTKudjj+d0dUPohs+7mUc
	 8K6y+XpFqqzW695cF//wnSJ/nm386qkv1IOxhUCjgcYkCKDiaEERdTjsw29ud5WTpu
	 9o1Hk2GKhLVw2CblDoFyJXtzxqn798XSBBOOYUKq7NGHCeng6qhQTvnieBQIGeFzKr
	 cOtN/oAS8o/Sql2uAMs9L+s5meGYvAC1/wnYpcYtn5a2LMAUd3nhemri/RNZ1n3oXR
	 49EOgsXtde8mPkvPIpZIVLx+nQIiMHEq8gw3/zZORyhaEyfly6lHFwVy+seRCI5Q1L
	 6Wk3+pWvLUkrQ==
Content-Type: multipart/mixed; boundary="===============1004920874132415660=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <381ff35f8ba3f7ee9a07fea44a2fca8a409a99bc97b15a93d5264e718e4b426a@mail.kernel.org>
In-Reply-To: <20261119012909.3657417-4-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Remove BPF_MAX_TRAMP_LINKS
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 02:08:19 +0000 (UTC)

--===============1004920874132415660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove BPF_MAX_TRAMP_LINKS

TL;DR: Nit only: the new comment above BPF_TRAMP_IMAGE_MAX_SIZE in bpf.h is
garbled and doesn't say what the 4 KB cap is for; a rewording is suggested.
Not a bug.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -1343,26 +1344,18 @@ static inline u32 btf_func_model_arg_slots(const struct btf_func_model *m, u32 a
>   */
>  #define BPF_TRAMP_F_INDIRECT		BIT(8)
>  
> -/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> - * bytes on x86. The trampoline image has to fit in PAGE_SIZE.
> +/*
> + * The image of a trampoline is not larger, also where pages are. That limits
> + * the number of programs: the index of a session cookie fits in its 8 bits,
> + * and the offsets into the stack frame fit in the instructions of each JIT.
>   */
> -enum {
> -#if defined(__s390x__) || defined(__powerpc64__)
> -	BPF_MAX_TRAMP_LINKS = 27,
> -#elif defined(__x86_64__)
> -	BPF_MAX_TRAMP_LINKS = 36,
> -#elif defined(__aarch64__)
> -	BPF_MAX_TRAMP_LINKS = 37,
> -#else
> -	BPF_MAX_TRAMP_LINKS = 38,
> -#endif
> -};
> +#define BPF_TRAMP_IMAGE_MAX_SIZE	SZ_4K

this isn't a bug, but is the first sentence of this comment meant to read
"The image of a trampoline is not larger, also where pages are."?

It doesn't say what the image is not larger than, and "also where pages
are" leaves out the word "larger".  The meaning only becomes clear from the
commit message: the image is capped at 4 KB even on kernels with 16 KB or
64 KB pages.

Since this comment is the only place in the code explaining why the cap
exists, could it be reworded along these lines?

  A trampoline image is never larger than this, even on kernels with
  larger pages.  That bounds the number of programs, so that the index of
  a session cookie fits in its 8 bits and the stack offsets fit in each
  JIT's instructions.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44438671971
--===============1004920874132415660==--
