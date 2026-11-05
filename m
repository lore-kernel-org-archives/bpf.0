Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914509;
	b=0Ym0Xkv8oJnIbmY7Jq+QVlEXLvsoOA6otyIF9XTmf6G6QSHzj+SbJJpQsuA0/+q02keu
	 K8huPu7dvhl6dAHceLNE2VI61XF75hGwKCjmzn7TjgLgvhO6EWY2m0+SripYn9z36fJ8F
	 5NGytvBxjV3cl/7J4SmR38LExgVRDhdzNyHzfwz4lGyNbGCsLBOi2sHilcAdJ+SjKWeti
	 Eh1/b3DkN8DJhD2+9Tsx7BJWQpTqGOR4xkF0TjBRM55+wBZV+pTBzrIVXAG376IrUJ7Gg
	 vGCn5+SunMCGCc97W54eJwn9zlUVe5fbScJB746Ug6rXqJp5UrlaKO3i/UEJDvqR4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914509;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TE4kOjjo0cgWQTIKispsQnMGW3D2FvOni5Ymt/zwYcQ=;
	b=dIqY2kEgHv+smsOqe8zFcJn9GPC2JLAZ+D0GPv+zLTwdivEh6ZVrJJUIJgJbuPz04n8W
	 kYNNxMvasZVT2/NZNyQ0CtDpq7jOKtRNHAdvjkaFF+cG+1ZwXe1szx3+pGJGXdKg3/Ug1
	 mV3KhryW1i/BZouhLIlacITwShPg7KeJ+E4ubkPZO1YiIPYq9nddt1sP8vxI5KIfPaE8Y
	 5PW7LIgNZlIZPc/n4YTn/o9hy9peYB11FFMZZeIeoVWRnxxlUR8KIikFtXLe9SNCCWmDP
	 4o2R110QOuPtwl1ycLd1tfLD9sl32R4Q872JCKjaY+pZNaFSUyZ8+3jgjioiy2uvwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28eX+If;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74694606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D28eX+If
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB11F008A1;
	Thu,  5 Nov 2026 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914509;
	bh=TE4kOjjo0cgWQTIKispsQnMGW3D2FvOni5Ymt/zwYcQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D28eX+If9i9SYsEid7o/PG+JQVyC5zvg8sY0lfsR9OvUKYNjkf5Wesq/g+4mYerz7
	 htOb9aRHSeIdDPVrYwWbNo57jPLDrE9H5Zhv/9TGtpvWR2Ym388H9y5GFMYprmMiY0
	 ZNHqvXh2oGWX7s46HzQr1Bdo5HuLSJrskI2M/xCVbFs+8X2HcoAffXKeWAAyYyXTax
	 zHDh5kb6uXZNjSLeP/bWxI9uV6H/z3Q/pW5K1ANtL0yDvoxgI/9wmiiBWn5q6fic83
	 iva0RcJ2ciGi8gbg91fkMS8Q8aBlfMNk2FMGo2K6RB1qh12tElitNZPRaMOGphJzjR
	 B3kEkbmMbURLg==
Content-Type: multipart/mixed; boundary="===============8669720878926876841=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <57aeeb6bdf5e95c77f6e802ac4ff81fea43b98c4bed15f9f6680e2d2e8428f7b@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-32-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-32-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 31/35] selftests/bpf: Test states that are not joined
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:09 +0000 (UTC)

--===============8669720878926876841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test states that are not joined

TL;DR: Nits only, in selftests: SHAPE_MANY() in verifier_jumps_ahead.c has
unused operands, label and map, and verifier_var_off.c redundantly redeclares
bpf_iter_num_* kfuncs already in bpf_helpers.h.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_jumps_ahead.c

[ ... ]

> +#define SHAPE_MANY(first, last, use)					\
> +	asm volatile (							\
> +		first							\
[ ... ]
> +	"1:"								\
> +		use							\
> +		"r0 = *(u64 *)(r9 + 0);"				\
> +	"2:"								\
> +		"r0 = 0;"						\
> +		"exit;"							\
> +		:							\
> +		: __imm(bpf_get_prandom_u32), __imm(bpf_map_lookup_elem),	\
> +		  __imm_addr(shape_map),				\
> +		  __imm_const(data, offsetof(struct __sk_buff, data)),	\
> +		  __imm_const(data_end, offsetof(struct __sk_buff, data_end))	\
> +		: __clobber_all						\
> +	)
> +
> +SEC("socket")
> +__description("shape: nothing in a register stands for a pointer")
> +__success __log_level(2)
> +__msg("processed 135 insns")
> +__naked void shape_unset(void)
> +{
> +	SHAPE_MANY("",
> +		   "r8 = r10;",
> +		   "if r7 < 2 goto +1;"
> +		   "r0 = *(u64 *)(r8 - 8);");
> +}

This isn't a bug, but shape_unset() is the only user of SHAPE_MANY() and it
passes "" for first.  The asm only references bpf_get_prandom_u32, so the
bpf_map_lookup_elem, shape_map, data and data_end operands, the "2:" label
and the shape_map array map itself are never used.

Are these left over from other shape tests, or could SHAPE_MANY() be
trimmed to what shape_unset() needs?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c

[ ... ]

> +extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
> +extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
> +extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;

This isn't a bug, but bpf_helpers.h already declares bpf_iter_num_new(),
bpf_iter_num_next() and bpf_iter_num_destroy() with the same prototypes.
Could these three extern lines be dropped, as verifier_live_stack.c does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============8669720878926876841==--
