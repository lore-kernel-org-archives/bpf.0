Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8A36C588
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862551; cv=none; b=UQyUHb+5z/KZBNvNgC5R7czWOCllaVM6Qh8Z6tQxqDgTkQsNp8dBjJ4kD6URNaicjtgW2EBFWN9Ll8Ddkqsabay8U6zeUtxuIksaaSisA77cqQgGPQ7y5hwy1Lvtc0cS1ySFgrZB8gkm+raSjNA7v6I/vyVdeAFl0kOAQ6j0k+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862551; c=relaxed/simple;
	bh=pl6VXsqMi7x+n+KlvAtu1iLBucZ8nI4trEY+EToj9AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iH5+IDAKxFLWu3rRf6m/vCoEkf7Fc6wYazuNuELZoLY9ytclgDN4wT+WR6dHeBAHVn0Ldt6EBPPf95K6wLVgqFM1wTWTnz36Vf4BT77UsqDZ3V02AskovPB18uRcQmQkGrNU/mAmi7fv5XLvF5L0+qwK/hM/4u8l3CcQtlvB7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqXiiYUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqXiiYUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4B1F000FF;
	Thu,  1 Oct 2026 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862546;
	bh=5EGX8+CGC8s7gEcmA+e7bLclTbQpkpanEra5MRa2zg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqXiiYUASXxIc6xiaa5lC8/p48ZwAVLFYtwJRoOUwPPSpnVWwNunrVj82AuQUOGOm
	 ulr0Qa2GbgD/yiHHwlJT93fzXePI4wsneVWVuu5b9N27Qtw0/12P3NB8OOfCTjUNSv
	 eDAZyGeQqUGXAAI90DdKlZgNeQoHJDpmRLXbr1Ggu6pUte0BkqHK3Rh+lgwr4btlX5
	 zkK95PB+j22pfoYBjWvdbBiN/+bgCWikS0ByF8NOtX5iEf8wEyAfU1iwTebxliJx18
	 0lcwpXYKeutCb3EPCafy7nZZEOeh58XNBckqoqVQuUEU/8lRCzoaPZbINutELEpYMt
	 k3SfjrDuWlqnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 12/22] bpf, x86: Dispatch exception cleanup
 pads at run time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001133108.1341965-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133108.1341965-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:49:06 +0000
Message-Id: <20261001134906.B6F4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: verifier bypass via BPF exception unwind abort on traced fram=
es
--

commit 8f24ec5b2338fd8477df1e09b72647e4de2ae3d4
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Dispatch exception cleanup pads at run time

This commit introduces runtime dispatch of exception cleanup pads using the
ORC unwinder. It implements arch_bpf_stack_walk_ra() to traverse the stack
and rewrite return addresses to point to their corresponding cleanup pads.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 6c7a0578760e7..544e8fd759ad4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -4614,6 +4628,32 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *=
cookie, u64 ip, u64 sp, u64 bp
>  #endif
>  }
> =20
> +void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64=
 sp, u64 bp, u64 *ra),
> +			    void *cookie)
> +{
> +#if defined(CONFIG_UNWINDER_ORC)
> +	struct unwind_state state;
> +	unsigned long addr, *ra;
> +
> +	for (unwind_start(&state, current, NULL, NULL); !unwind_done(&state);
> +	     unwind_next_frame(&state)) {
> +		addr =3D unwind_get_return_address(&state);
> +		ra =3D unwind_get_return_address_ptr(&state);
> +		if (!addr || !ra)
> +			break;
> +		/*
> +		 * A traced return: the slot holds a function graph or kretprobe
> +		 * trampoline, not @addr, so it cannot be rewritten. Stopping
> +		 * leaves BPF frames returning to unverified paths, so warn.
> +		 */
> +		if (WARN_ON_ONCE(READ_ONCE_NOCHECK(*ra) !=3D addr))
> +			break;

[Severity: High]
The comment above notes that this leaves BPF frames returning to unverified
paths. Since the verifier assumes bpf_throw() does not return and prunes
instructions following it, won't aborting the stack walk here allow the
execution of those unverified instructions?

Could a user with tracing permissions intentionally attach a tracer (like
kretprobe or fgraph) to trigger this break, bypassing the verifier and
forcing the execution of unverified BPF code?

> +		if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 =
*)ra))
> +			break;
> +	}
> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001133006.1335=
369-1-yonghong.song@linux.dev?part=3D12
