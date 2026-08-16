Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48E3A6B6F;
	Sun, 16 Aug 2026 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916572; cv=none; b=Qubu3WdkCbiuD32jYIpL4x4MjOPkR3Y8+EYB1G7rO6f7nwikuDMCq2TrOgykXG12j2qr+NenNHJ24/TdBmXbtV6TdyOQJTSmuH7Ymg++eAQ3fe92xUucaVu1HMXEVaYz28iz6L5kBl1jJZQRY5aNnKC9OoTMfCvGlCsrBcY3+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916572; c=relaxed/simple;
	bh=jai8Tr4CR5av01PtXLlgrvaG4GhQp3mS/FEevnhiW9Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sAnjbsffIE9/LieaaakCXkSU+m9kbEp0MWg+ftBfmVhEah6dEZGB6MeSmtoQ18e+lnwOZvD0L6DHX2LA5nI/pPVhMw9nIAciLyyzwFikL3nrN5PnwCr8wc07Ks/Qcijxh2BcClGSOIuvzSKFEzDYrl4OFb+WUqA0tynvXV9tMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ+spRqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ+spRqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DE31F000E9;
	Sun, 16 Aug 2026 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786916571;
	bh=baamzSbf90gaukAI3rssXuoFlEPQKZMF8NRCk5r0CRA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IQ+spRqD+SqA8CeDtUni6RBXJVPOtRSaXzYtyEYCq4Js9f3Ju1nbjxBjcvCAwJTJ8
	 eMnXZvtTmJvwHSsLrREIXu2howEoqkWwXMSVXJfHILmPIDOYJfgZV5nhmHvJsBd2Wz
	 hV/101brsrx/6g/4gGtnZSXASqS311iQswYfuZb3rSPpblQmxiYC3UjMoXfo9mCfsU
	 dnyZREJ1lzm1UGH/c8FQF07rSkmPxBHOJfZJIk1rIOfgqUz+4qnH9BlmrIj1kCd1wv
	 gt2HHjiN5FmK6CQp1x2IYA/sQgsBmwrJTmFNEZ1NYFmD6IeiNpt/vnkCOTfS7TQe+1
	 ew3w0ajcB8BEg==
Content-Type: multipart/mixed; boundary="===============7404879943641751349=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2940a10adc8aa9f733ead7d394caa6bf6bb2d85b0a0fcc63a3fdd6f6732f722f@mail.kernel.org>
In-Reply-To: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH] bpf: reject stack-argument callback subprograms
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 21:42:50 +0000 (UTC)

--===============7404879943641751349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Helper callbacks enter BPF subprograms through bpf_callback_t, whose
> runtime ABI supplies five arguments. BTF validation nevertheless permits
> static callback subprograms to declare more than five arguments when JIT
> stack arguments are supported.
>
> This lets verifier state for a callback use outgoing stack argument slots
> prepared at the helper call site. The helper does not pass those slots. On
> x86-64, callback loads of arguments seven and later therefore read the
> helper native frame instead of the synthetic values checked by the
> verifier. KASAN reports a slab OOB write.

This isn't a bug, but would it be worth extending this paragraph to cover
argument six as well?  The new check rejects everything above five args,
and arch/x86/net/bpf_jit_comp.c documents that incoming arg 6 is read from
R9, which similarly doesn't match the value the verifier believes the
caller stored at r11-8.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 7e0ce5db28a0..5acc3b63ca84 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -79,6 +86,32 @@ __naked void stack_arg_two_subprogs(void)
>  	);
>  }
>
> +SEC("tc")
> +__description("stack_arg: callback with incoming stack args")
> +__failure
> +__msg("callback subprog cannot have stack args")
> +__naked void stack_arg_callback_many_args(void)
> +{
> +	asm volatile (
> +		"r6 = 0;"
> +		"*(u64 *)(r11 - 32) = 0;"
> +		"*(u64 *)(r11 - 24) = 0;"
> +		"*(u64 *)(r11 - 16) = 0;"
> +		"*(u64 *)(r11 - 8) = 0;"
> +		"r1 = 1;"
> +		"r2 = %[callback_9args];"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"call %[bpf_loop];"
> +		"r0 = 0;"
> +		"exit;"
> +		:
> +		: __imm_ptr(callback_9args),
> +		  __imm(bpf_loop)
> +		: __clobber_all
> +	);
> +}

This isn't a bug, but could the unused 'r6 = 0' be dropped?  It's written
but never read, and the asm clobber list is __clobber_all.

Also, would a one-line comment on the four r11 stores help the next
reader?  They're what makes the outgoing stack-arg slots initialized so
the new check is the one that fires.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31972309086
--===============7404879943641751349==--
