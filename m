Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D335950;
	Tue, 22 Sep 2026 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041636; cv=none; b=tHvMzrZa+qaG3b67mOPVE1hkkGm7Ck47dXFQUHzKQV18gOAbXqoLBEIKMdU2l87jW98+U1sowPSzUKgXQPxlwoMM4ySAu/Gq8/d66h29wSWHWLq4Wa/fon+AILiRRQBewrUMm/lK18aYVtSdi8qqbseRkU2y2cV2y4BLA9IXMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041636; c=relaxed/simple;
	bh=P4cWs59fPLpdZiJfbFmlcyCdSFuvJpAsJ5W+WfsUxBg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RFmg68wEkXRfsDs5h1unUx7GePpy4tfHIzOpX1AhCmbHEK49WQtUayzO4lN6ZFwKsBDcO3JWcN/4yCit20OG85i9W+kPfOHMpnVPnsHUIpmLyFaP0MjWIMNey5pGd9oEEJSZEXu2vLteVXjZh31vJvxt2F82zgt0a0FnzAMcDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4kQ+c/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4kQ+c/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D761F000FF;
	Tue, 22 Sep 2026 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041634;
	bh=kYCtTqAp0FpGIEPCO6wZN02nOVvmRN6t7ooHdj1rSZM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j4kQ+c/bXo8sXJRfZmIwBbKGlmHMOj8GOn04vIRK+BLCjok4WDLq2aB3bKjNGQt5j
	 j4F0wrkLQ3/E+jSTlb+H7YQApCPOLE+oiYu9sXg0sbZ3YEys+OcBnizOtsqEhHalgm
	 cp9d2/IeB5lJ90JHzK3bKJ9mAvkjbcWRhFDUm1tdv9rep/hFvH0iKVsTqeDP55arOY
	 nGBgJm05WjVGIW62924uQse55FOpI/zNVS26dvR7UgcPPrJNKFa7egsIaOLWuViYIn
	 YCPhjQxvaGrsVKunBVmQmv2VNhgcrHgOsPQkDDRcHn8ie4ZWZPm8pTfjafVdY1fm0d
	 nMHEwO8+0JsDg==
Content-Type: multipart/mixed; boundary="===============0048666262407725720=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95fa69c85978e3cf60ef6fed25b5b38278934373c921777ab38b4202d7bf75b6@mail.kernel.org>
In-Reply-To: <20260922010333.1226537-7-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-7-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 6/6] selftests/bpf: Cover callback-frame map key lifetime
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: ameryhung@gmail.com,emil@etsalapatis.com,npc@anthropic.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 01:47:13 +0000 (UTC)

--===============0048666262407725720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover callback-frame map key lifetime
>
> Parking the key in callback_ctx and dereferencing it after the iteration
> is rejected for array and percpu-array maps, whose key lives in
> bpf_for_each_array_elem()'s frame.
>
> Two cases must keep verifying, and are the reason the declaration is not
> in the shared map_set_for_each_callback_args(): the same shape over a
> hash map, whose key points into the element, and parking the element
> value, which lives until map teardown.

This isn't a bug, but would it read more precisely to split these - the
hash-map case as the reason the declaration is per-map-ops, and the
parked-value case as a guard that only the key was declared frame-scoped?

Looking at 6cd471d244f2, the placement decision is driven by the first case
(hash_park_map_key), since that's what would break if mark_frame_scoped_arg
for BPF_REG_2 moved into the shared map_set_for_each_callback_args. The
second case (array_park_map_value) parks R3 (PTR_TO_MAP_VALUE), which no
placement of a BPF_REG_2 declaration can affect.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> index 1fbcc5228306..2e0c56888953 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

[ ... ]

> @@ -800,4 +814,81 @@ __naked void check_add_const_regsafe_off(void)
>  	: __clobber_common);
>  }
>
> +struct key_ctx {
> +	__u32 *key;
> +};
> +
> +static long park_key_cb(struct bpf_map *map, __u32 *key, __u64 *value,
> +			void *context)
> +{
> +	struct key_ctx *c = context;
> +
> +	c->key = key;
> +	return 0;
> +}
> +
> +/* bpf_for_each_array_elem() passes a key from its own stack frame. */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int array_park_map_key(void *ctx)
> +{
> +	struct key_ctx c = {};
> +
> +	bpf_for_each_map_elem(&map, park_key_cb, &c, 0);
> +	if (c.key)
> +		return *c.key;
> +	return 0;
> +}
> +
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int percpu_array_park_map_key(void *ctx)
> +{
> +	struct key_ctx c = {};
> +
> +	bpf_for_each_map_elem(&percpu_map, park_key_cb, &c, 0);
> +	if (c.key)
> +		return *c.key;
> +	return 0;
> +}
> +
> +/* A hash key points into the element, which outlives the callback. */
> +SEC("?raw_tp")
> +__success
> +int hash_park_map_key(void *ctx)
> +{
> +	struct key_ctx c = {};
> +
> +	bpf_for_each_map_elem(&hash_map, park_key_cb, &c, 0);
> +	if (c.key)
> +		return *c.key;
> +	return 0;
> +}
> +
> +struct value_ctx {
> +	__u64 *value;
> +};
> +
> +static long park_value_cb(struct bpf_map *map, __u32 *key, __u64 *value,
> +			  void *context)
> +{
> +	struct value_ctx *c = context;
> +
> +	c->value = value;
> +	return 0;
> +}
> +
> +/* Only the key is frame-scoped; the element lives until map teardown. */
> +SEC("?raw_tp")
> +__success
> +int array_park_map_value(void *ctx)
> +{
> +	struct value_ctx c = {};
> +
> +	bpf_for_each_map_elem(&map, park_value_cb, &c, 0);
> +	if (c.value)
> +		return *c.value;
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35674974944
--===============0048666262407725720==--
