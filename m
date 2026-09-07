Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D73CAE8D
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798037; cv=none; b=VBmC5k6J/OivGRiztfQz5I1N3lMBRowyDnfgSgTvwNzGjMhP7WW+DAcZobtjec4cyCR1KkeoUpXJJOaYnAzpqL3H0DouIk+Ymjr0E0Gy0oYgXlKprak31JI0QRf91FsfBtbHk5/ucJ6ISTW8etC68NFrprt1ytd9I0FOLsx0GGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798037; c=relaxed/simple;
	bh=RLor3ZmtD+73wJoeeTh4LEzGmPpbXNClZ9Tk5tarLWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NkR6QemzInPwbWj1nndqjl2l/mLwen9bMePSnt+wPOeKtFDMiBL4CmFruVUJQtCDYI4WaCLQtyUUM7P1HfUeNfsji14HpSYRI82FNZbTEHd4D5iOhU/f3Zg9Z/HoFxFxLm1tn2R4/bmX6GObDu134EYqLSQiav8BUszSkv+wn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6tmg9B5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6tmg9B5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC21F00A3A;
	Mon,  7 Sep 2026 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798030;
	bh=+kMfC2KD92WqEpDuzOPo/xK9EDX0frOeIVjnhPRKdqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6tmg9B519uh95HhkJvUXB6Ek6lWL+m4r21gh4uZK6K1bWHu6YIIGu/bDnqFBhgE5
	 gSscHIyQD06I9JIFzt8brlWBRVw7Qa/ec0IVLV7mB5iS6+YjE420RR4Db4LUcNe0Cr
	 hCezC0zD67dUszzE5Yt9wX42/C8stn+pvhgX5AWCEVqY+P301sBfrqNm7MIyLX3skY
	 UG0f6fF7EgTOhmRAul0mWY99I0LPafYoU1rnLppAdKyhLRCBZ7lRUST8Pur9L1fim+
	 pY9rP+V/V3DalCgzYg9oh4V5PscTffelC1CWK+Wa81ouvmDT9Asg2VOYQPYZH91lty
	 ox8pqxgp3btLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, x86: Use global buffer for trampoline
 size generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907160538.922450-1-jolsa@kernel.org>
References: <20260907160538.922450-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 16:20:29 +0000
Message-Id: <20260907162030.60EC21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent BPF trampoline size calculations cause data races and=
 severe cacheline bouncing on the globally shared `trampoline_size_image` b=
uffer.
--

commit d4cd8458939c8e8adafba04b2627a4ef1338ac21
Author: Jiri Olsa <jolsa@kernel.org>
Subject: bpf, x86: Use global buffer for trampoline size generation

This commit replaces the per-invocation allocation of a temporary
trampoline buffer in arch_bpf_trampoline_size() with a globally shared
buffer allocated during initialization. This reduces the time it takes
to calculate the required size by reusing the writable scratch page.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index bba351944202c..13ef0d53ca296 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -4000,24 +4010,14 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
>  			     struct bpf_tramp_nodes *tnodes, void *func_addr)
>  {
>  	struct bpf_tramp_image im;
> -	void *image;
> -	int ret;
> =20
> -	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
> -	 *
> -	 * We cannot use kvmalloc here, because we need image to be in
> -	 * module memory range.
> -	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
> -	 * that returns writable memory in the module address space.
> -	 */
> -	image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
> -	if (!image)
> +	if (!trampoline_size_image)
>  		return -ENOMEM;
> =20
> -	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
> -					    m, flags, tnodes, func_addr);
> -	execmem_free(image);
> -	return ret;
> +	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
> +					     trampoline_size_image + PAGE_SIZE,
> +					     trampoline_size_image, m, flags,
> +					     tnodes, func_addr);
>  }

[Severity: Medium]
Can this lead to concurrent modifications of the shared scratch buffer?

If multiple threads attach trampolines or load BPF struct_ops programs
simultaneously, they might both invoke arch_bpf_trampoline_size() and
execute lockless writes into trampoline_size_image (such as inside
emit_code()).

For example, bpf_struct_ops_map_update_elem() calls into the trampoline size
calculation while holding only a per-map lock, allowing parallel updates
across different maps.

While the generated bytes are ultimately discarded and the calculation
depends on local pointer arithmetic rather than the buffer's contents, do
these concurrent lockless writes risk severe cacheline bouncing? This could
degrade concurrent attachment performance and will likely trigger KCSAN data
race warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907160538.9224=
50-1-jolsa@kernel.org?part=3D1
