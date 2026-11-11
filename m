Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385304;
	b=f6IMd9DEfK0oCePD0j2DgiPiXAyx8G5Ov8hqmwag4DRJCXM30i+vEJGKp5tlORpoKGEB
	 hf6eVl2KjjiV42OSuyZ/6XT4UQubLaJqa9YueUkvsLwKUvaiunKB1ZNuPciz1IVD++cB1
	 4NEUK/pjEVc9xEs7kC6cDdZnqCHZUuGbmCLgNEQlwo3jCB0P9MtmhNUgwiKbolYGmKlmm
	 0qk4qnDigI52HFIDFl1Gqr2Yz1GsCNr3QudPc14nJkM8J+rielDrCNQ48W9r7D9Eju56c
	 6jCCCX2sXDHOx/ROnrKz1b+Nk9awx2wB6XqQg+H1As93BShGH7XkLVJsouUBHqeIbzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385304;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=MYDngarCQ45mUSeexDEj1Ba5k1M8XVDaHjliIce1Nlg=;
	b=C0hXcWerzL0wQSg6YWBRwHFt8sE8ain7wumIegLUmfCa5PumfUkKBhq1lRPLEhnHdWO/
	 koGkDEI3i6qqLSkN9jViCpwT7DQefDVte19yKNU5WaPU276N1I0ClDSV/dQHY3paeKors
	 wVa59WhM0tbiGQIIGCOOGl8zWHCEMu8dvuY3NvqKfhznCplEX36u9Giwd7mSOyeU/rM27
	 /a7zhToY+y/NsrQ6styEqbZY/mPl16jC9FxzBPKqkxfPfbja3HFplbS59hiE0Gs0asbR1
	 QkJ2B44NjY5Yt6+fxKG7c2kCwqRWPp90UpdpWnv3zftyWok+AaNUqJCaN6mP/bAipWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9y0JxFY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628D606A331;
	Wed, 11 Nov 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9y0JxFY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EB1F00A05;
	Wed, 11 Nov 2026 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385304;
	bh=MYDngarCQ45mUSeexDEj1Ba5k1M8XVDaHjliIce1Nlg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J9y0JxFYC2F4SbWlUPdB5tZoOQ+X8kfAOSGy8nJD3QYebJE9ivth0KaRiS84OQ2hT
	 uZt/QXlPoxtt9K3H4j6MfDxFVXSeaQuR+E2l0lj/QEOOaFfIwz1nuhOhscmIcNI51e
	 wD+q2X94rxPX14lW6WRhlHBsEV8zlVS1YNwa8d5biuEVbqFBoEMj6KqHNLUKPBTYmQ
	 YJQYjTa4/hKjTzPI/CiNfesfXRtQvsXhDJSKZtqoVgY/Rn20CpKwXAtlJZN+SZr82d
	 gNu0zE7sx2oV/MboNQ+fISUEk4GcC6LaJnr3ChUqjghALGicDYS5/+uWR4wJIl4TTj
	 DJSdSUdzERljQ==
Content-Type: multipart/mixed; boundary="===============8619726833200934663=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c4f98afcae91b54b30f5e9fdab98125cdccf00b1c7a71afff1b16e931798c314@mail.kernel.org>
In-Reply-To: <20261110164046.454431-14-a.s.protopopov@gmail.com>
References: <20261110164046.454431-14-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/18] bpf: Check the return values of fmod_ret programs on found targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:21:42 +0000 (UTC)

--===============8619726833200934663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check the return values of fmod_ret programs on found targets

TL;DR: Possible wrong behaviour: fmod_ret programs on 64-bit found targets
don't require the JIT, so in the interpreter -14 may reach callers as
4294967282; a later commit fixes this, leaving a narrow gap here.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_id,
> +			       unsigned long addr, const char *tname)
> +{

[ ... ]

> +	if (!cnt)
> +		goto invalid;
> +
> +	aux->fmodret_retvals = retvals;
> +	aux->fmodret_retval_cnt = cnt;
> +	return 0;

For a found target that returns a 64-bit integer (size == 8),
check_fmodret_retval() accepts the full 64-bit R0, so "r0 = -14" is
accepted as the s64 value -14.  Nothing here makes such a program require
the JIT.

If the program runs in the interpreter, prog->bpf_func is
__bpf_prog_runN(), which is declared in kernel/bpf/core.c as:

  static unsigned int PROG_NAME(stack_size)(const void *ctx,
                                            const struct bpf_insn *insn)

so only the low 32 bits of R0 come back.  The x86 trampoline handles
interpreted programs, stores all of RAX and returns it to the caller of
the traced function, so the caller of a long-returning found target would
see 4294967282 instead of -14.

That value is non-zero, so the function body is skipped, but it is not an
error value either.  Callers would treat the skipped call as a success
that returned a large positive value, which is the case the commit message
says the check is meant to prevent ("Returning such a value instead of
calling the function looks to the callers like a real failure").

Should fmodret_retval_init() set env->prog->jit_required = 1 when
size == 8?  A later commit in this series, c4a7eee0c4d7 ("bpf: Require the
JIT for fmod_ret programs on found 64-bit targets"), adds
"if (size == 8) env->prog->jit_required = 1;" right after these
assignments.  No found target carries the tag until 8659bd72073c
("resolve_btfids: Tag fmod_ret candidates as targets"), which comes after
that fix, so the window is narrow, but it is still a gap in this commit's
own logic.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42981885558
--===============8619726833200934663==--
