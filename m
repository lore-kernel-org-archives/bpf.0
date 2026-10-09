Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4B4B826B
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547675; cv=none; b=IOfot75YGqvWCLdcJotWra4EZAJ4vFxtF7MpGaVyY/Q9ddhqwHGYaP4YrL+1Ap8VXJRs1Dd6m2y7d8viI5zwYXOmuzrX1zD6bmJeHb2EfQy5fNSwEr/OiGzDYVV/bIlsYWzbQ/B/c5bHMjXTs6gN4UD+R37U6GpaXVw7vMSEezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547675; c=relaxed/simple;
	bh=AiYM3eTDZMWnh9h7svcRVrEZHY3YAL5DEgZsoIXMLZY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=shqwlP/izTGMf2WixwoUuqQy/axlr4r4I1fyPqOrOq99T70+oJgCbKExRqd+IG45dvWkZ6Pr7wk8AQJ2laKKqCuUsI6yIRSXkIsfw+ZAOoQdadu5hwLvfM+0xRPXyU/toVOo2vxMoipe1ABXsq1WmP3z0fetA/3TSZKdN6Vyocc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M09zU3Jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M09zU3Jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5521F000FF;
	Fri,  9 Oct 2026 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547669;
	bh=xqcN0aMyX0B2bhH3bSiKnIpXZ3CB6MqZ9D5E7oVQt3k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M09zU3JljA9BWb6P8jESskYdqPIpZZE6aVjLQAfIprOaUc5U0KmKXI6G3QlE70Z6A
	 0EV7UUGCd0GiNwLRyUzoPcwULyq6UKQc1v8Nrz/EDkbq2vfao2KhaIMDQYuVU7okfo
	 HDiH6w9fQaY6i9DlA9543PdMbfxl2uEraAWfpPPERuMIAQpKHHuPUcNt2rkW+WGE44
	 pS/GiNoGtp+mAOr+psHY1XJaUeIvirA0m2f2P+KuzMbySP33IcA9fUEi/BIWM3T1YB
	 RC9cp5SkKIe99Ww8Orf7BB6HUC2pGqFxIvQSpwmJH4oyQjBUccVaPFnmJvg+ffOJrC
	 DG4ZfWthrDGAA==
Content-Type: multipart/mixed; boundary="===============7593964883018961575=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <74cf013bf83826c26d439bdb003b302e24de6b10bdec3e9816356c96ad1bd4cc@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-51-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-51-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 51/51] selftests/bpf: tests for SCEV analysis and loop widening
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:48 +0000 (UTC)

--===============7593964883018961575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for SCEV analysis and loop widening

TL;DR: Nit only, in the selftest: nested_loop1() and expr_chain() pass an
unused __imm(bpf_get_prandom_u32) operand that could be dropped.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> new file mode 100644
> index 000000000000..59c4b2864db0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> +__naked void nested_loop1(void)
> +{
> +	asm volatile ("					\
> +	r6 = 0;						\
> +1:							\
> +	if r6 == 2 goto 2f;				\
> +	r6 += 1;					\
> +	r7 = 0;						\
> +3:							\
> +	if r7 == 2 goto 4f;				\
> +	r7 += 1;					\
> +	goto 3b;					\
> +4:							\
> +	goto 1b;					\
> +2:							\
> +	r0 = r7;					\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

This isn't a bug, but nested_loop1() never calls bpf_get_prandom_u32.  Could
the __imm(bpf_get_prandom_u32) operand be dropped here, and in expr_chain()
too, so the asm uses ": : : __clobber_all" like the neighbouring loop tests?

The tests that do call the helper (meet_agrees, meet_disagrees) need the
operand, but these two do not.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============7593964883018961575==--
