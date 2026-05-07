Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BC332909
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191877; cv=none; b=YY0OfpyMbhOd9fYVmj9cSTfH1RfOcxYuTOx+wFGspdSS+t2QXr0DuNRiAg6sOkIxomj5MVHN64cafMD/+tKOpDumlpxbmKrdBvS6cpccVIzWcx3tQvlQwC/H0wxMlrZg4E1aO4ZI5K8cgbYdqc8igz4GjqqHlMJpqVNBqxlwYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191877; c=relaxed/simple;
	bh=87G3Hk3JLkos73xwtBc4KDVEWwk99bKOFvB43bI8wgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GAIkcjYXtIkWwUpmSSLJ7tBEo26+Ol2kTvCvRjriJxV5abavpi14uFGApTRW3umniFCFXfH1nPtEGHGymXefkJOcV0ijOeh2I8uWhPutvQdfSN1F/0Z8QcbcoyEbsJMeSrahdMr+thWsukH6rrOMZ/JOwtu3MK1QsD0LFZpEwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC2ahtUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC2ahtUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C3C2BCB8;
	Thu,  7 May 2026 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191877;
	bh=87G3Hk3JLkos73xwtBc4KDVEWwk99bKOFvB43bI8wgk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NC2ahtUoebYuWeDaBAszHp0TYhVGoyI2HOv8E5U8AUKK4sCC4D2uKg6Rh4IQxA1iR
	 mPBx4AxbYhVoRK1+hwnJpuZXN72rh9BRZHe3XRLV3gm5H+U2DzrlDC9BLL6jBtGarz
	 8iuoq56nJJRGvbbL4f4Rcm9hEB2Jev67ae1u6sr7MrN7QAqIGCmifbjiOVTq0wW+gs
	 IR6iKY3/fSFStrDjTQVg0pRtTGrbVRJtvJWnEbCLzQfPw72qmWTET7KK4MQEHuh0Gj
	 TtWiXh5gDxqZpAOCm2XEc2NOI/kI2mu1fugdJmT03dG44xr3ZNj/JmYZK4MVoWPsz8
	 MG4cgyXIlvVgQ==
Content-Type: multipart/mixed; boundary="===============7758425178321564980=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b03ce38af2e3d574b5a79963da1a4db70e896e6712b2bf2e9fce69178433540d@mail.kernel.org>
In-Reply-To: <20260507213145.1139004-1-yonghong.song@linux.dev>
References: <20260507213145.1139004-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 19/23] selftests/bpf: Add verifier tests for stack argument validation
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:17 +0000 (UTC)

--===============7758425178321564980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> new file mode 100644
> index 000000000000..b4f680e3b6a1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c

[ ... ]

> +__noinline __used
> +static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
> +{
> +	return *f;
> +}

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pruning with different stack arg types")
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("invalid mem access 'scalar'")
> +__naked void stack_arg_pruning_type_mismatch(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 = r0;"
> +		/* local = 0 on program stack */
> +		"r7 = 0;"
> +		"*(u64 *)(r10 - 8) = r7;"
> +		/* Branch based on random value */
> +		"if r6 s> 3 goto l0_%=;"
> +		/* Path 1: store stack pointer to outgoing arg6 */
> +		"r1 = r10;"
> +		"r1 += -8;"
> +		"*(u64 *)(r11 - 8) = r1;"
> +		"goto l1_%=;"
> +	"l0_%=:"
> +		/* Path 2: store scalar to outgoing arg6 */
> +		"*(u64 *)(r11 - 8) = 42;"
> +	"l1_%=:"
> +		/* Call subprog that dereferences arg6 */
> +		"r1 = r6;"
> +		"r2 = 0;"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"r5 = 0;"
> +		"call subprog_deref_arg6;"
> +		"exit;"
> +		:: __imm(bpf_get_prandom_u32)
> +		: __clobber_all
> +	);
> +}

The Sashiko AI bot and bpf-ci raised concerns in v6 and April 24 versions
about test fragility in this test and similar ones. Since
subprog_deref_arg6 is standard C (not __naked), LLVM determines which
register is used for dereferencing. If a future LLVM version chooses a
different register, the tests will fail because the verifier error will
mention the new register instead of R1.

In v6, you mentioned using a regex like __msg("R{{[0-9]}} invalid mem
access 'scalar'"), but the current code removed the register prefix
entirely. While this may be intentional to avoid specifying a register,
could the tests benefit from either using regex to match the register
dynamically, or making subprog_deref_arg6 a __naked function to guarantee
the register choice?

Reference: https://lore.kernel.org/bpf/20260419172100.A89FEC2BCAF@smtp.kernel.org/

> +SEC("tc")
> +__description("stack_arg: release_reference invalidates stack arg slot")
> +__failure
> +__msg("invalid mem access 'scalar'")
> +__naked void stack_arg_release_ref(void)

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pkt pointer in stack arg slot invalidated after pull_data")
> +__failure
> +__msg("invalid mem access 'scalar'")
> +__naked void stack_arg_stale_pkt_ptr(void)

[ ... ]

> +SEC("tc")
> +__description("stack_arg: null propagation rejects deref on null branch")
> +__failure
> +__msg("invalid mem access 'scalar'")
> +__naked void stack_arg_null_propagation_fail(void)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============7758425178321564980==--
