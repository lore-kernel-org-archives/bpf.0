Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385667;
	b=wmYe2bF1RioOoFyYEbhYhlZWSk55Ru0KBjdvzOmPQjk05RdCg/VdUy+mV8NNPF/lshME
	 xps56lWLlLcWocXOZg+fkWb+HscetMUJBDT1lu7rRsDOb2zDFv+6OwEcNhPWlyX5UZA/J
	 FoHfapDtQHez82XT2WDFaEFmTKb8Yc7vqCpZzhCybtJMOcSLEmxaxK/qQBkxbunmX84e4
	 aZg8yxYOAQ/YmzTGtc8sv14GHmgMH8WfPtexzefYZpb6tM/XJSIQV+DC1+cdgBlQoz47F
	 oRTiC28OfW8PEg9lVFVImqe7SsD++CcYpYbpXo7PfW00OvqNp+62wIatpGU24sgyk8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385667;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FAhJ9F0zWmj3HF2hZIslz8o28d92TPTbi06KLdhZNcw=;
	b=mRJNHJ8danRoskvPyDJ54Be2HlpEqSjLGkotTf8+USEaCpetlMpSWGnV/EgQmgs5awHZ
	 cO3WPSmSn6v5puOhjl/1wpg6MLlJyvQjSxlShL7rF8ToCmBWZIQMn9PdMJOwr9nojEnX0
	 OD6lQdvCUeIRXBvi0sMrEm2dSl64qGpvkESckp9r2g1TJ5lAWpWsCi7fVB7dc/DMPXIH/
	 dPy50/+EuAreYKPSqgK4K0DBCFj7BDcIPWezt1mNPDwj3d7pN0JRKe5h51lKdV6RJAUzP
	 WoJ6X8NhT/gh+rbGs9j06UO008P4e42/QLS0LyDW0iqudBEmxgKDnlg351uGhs1j6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj7AMCub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15560A3819
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj7AMCub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A241F00A05;
	Wed, 11 Nov 2026 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385667;
	bh=FAhJ9F0zWmj3HF2hZIslz8o28d92TPTbi06KLdhZNcw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jj7AMCubRT8sCrtv1KXuBUvAFTRgOLllT+8O205pvQOSCi19JHzT4Q8CQKlfvCMtX
	 xUcfUX1BFlVjlA3LrPLvKNtNPq3rdW+2rSQyPYZNsBsLzokDmt8m3FHEc3TNobclaH
	 JaRG8nRUaixi+ngEOEY2isDIY5u+xtbGXCqK7RUUihhWugCrQc9p/TWb75w7fqG0P6
	 GZ2r6pgs0U+5WdYxozT7jcfSV7vWEPUYNvHyXCwouQ06/hJbweGDIUFIdKf0kU6Vz9
	 VDoJGK0ILyDxsy3VuufP71xg56VJgFqvO/bmbHNpAlf58xILkM9lLDS9Cwz5RHEPzr
	 p6ShIloovoZ6w==
Content-Type: multipart/mixed; boundary="===============0357976187805268378=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <77584581f8614e4e09982684129f8c6e8f113c9f8a7523d93e81f1e5017ba123@mail.kernel.org>
In-Reply-To: <20261111051341.2800252-14-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-14-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 13/29] bpf: Value number the phis of scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:27:46 +0000 (UTC)

--===============0357976187805268378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Value number the phis of scalar evolution

TL;DR: Nit only: the header comment of set_expr_base() in kernel/bpf/scev.c is
now stale, since phis given a base by mk_phi() are no longer their own base;
no functional bug.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -272,10 +282,13 @@ static void set_expr_base(struct scev *scev, struct expr *e, u32 id)
>  	struct expr *x;
>  	s64 imm = 0;
>  
> +	e->arena_add = 0;
> +	/* mk_phi() found the base */
> +	if (e->def.phi && e->base)
> +		return;
>  	e->base = id;
>  	e->off = 0;
>  	e->bits = 64;

This isn't a bug, but the header comment of set_expr_base() was not updated
and now contradicts this early return:

 * @e gets the id @id. (+ x imm), an extension and a partial spill of x have
 * the base of x, which was constructed earlier. Every other expression is its
 * own base.

A phi that mk_phi() value numbered reaches here with e->base set to the phi
of the bases, so it is not its own base.

Could the sentence name that case as an exception, for example "Every other
expression is its own base, except a phi that mk_phi() gave a base."?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982641817
--===============0357976187805268378==--
