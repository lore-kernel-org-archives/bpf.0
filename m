Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2F42314E;
	Thu, 14 May 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770528; cv=none; b=p97C4Ob0BptPrpAj0kvViPjFwBVIdVWmUFqERjiwh8nLZN+n+HnL83t6dLZOq3oyULxKUtQA6+qA+X2xiDX3lnMhoDkHGuw2vmC6AQ8XRFsrnKznNgREygN/Qr7f0O9H2fmXhsU37JVkfPqbm84up7qiZgynE7GgU/RNUtxT+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770528; c=relaxed/simple;
	bh=veGuoM8sKxxER/MFBO80jwN5xp52BjYJJbIhiYWMvWg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FEZkRTLhZURRBhz+lh/wcnJ4SNpEtCrnHditbsrq6CnrR0HoOxlN6Y+btH0tZVCI3vYJ9cMNWQUiPsiA/cpLJ+cKIRIIJ/gTUVrK0GkkZ2Fnzn2rkPk0X5l95hvO5EoaqbG7LiTsuyRz1rgdNW5sQPm7QdJuBW42CDmQRmfZRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwd1ub8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwd1ub8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E34C2BCB3;
	Thu, 14 May 2026 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778770527;
	bh=veGuoM8sKxxER/MFBO80jwN5xp52BjYJJbIhiYWMvWg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Uwd1ub8mEeJOajMGLLIE2vDSqCyDLsShuzn113z5t4rnuA2KTokOlx3ehMtkr9Tzk
	 0eCUJ7dwyZLSk1i2ckee7pn8Sl251DNZ9sLESl6qo8bhDpn9F9Ad9AW2vuGHu7jko6
	 YaskQ54/vA0W08OsTepIzhiJCgJu0vyKa2hDDog8IR8BOBNvSW/FlBKSGscoolU5Iu
	 LcvRCTzH1yVI9T7iv2vIf1Ws12432VPKIhqS+XK0xEKl+V806KkxP7aaAT9WjI6oPS
	 DgByQoAsHLGcOhFiX2F3K56JQKfRMpsBZXk6rffQPPBsXEbg02hYRWYAUvfDUY9VsJ
	 HVAd1vIOTpIMQ==
Content-Type: multipart/mixed; boundary="===============3471622894231792099=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org>
In-Reply-To: <20260514135342.22130-8-jolsa@kernel.org>
References: <20260514135342.22130-8-jolsa@kernel.org>
Subject: Re: [PATCH 7/7] selftests/bpf: Add tests for uprobe nop10 red zone clobbering
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 14 May 2026 14:55:27 +0000 (UTC)

--===============3471622894231792099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 82b3c0ce9253..d553485e7db5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index be34c4087ff5..606601ccdc42 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> index f00cb52874e0..0ee78fb050a1 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
> index b359b389f6c0..5e38f8605b02 100644
> --- a/tools/testing/selftests/bpf/usdt_2.c
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -13,4 +13,17 @@ void usdt_2(void)
>  	USDT(optimized_attach, usdt_2);
>  }
>
> +static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
> +static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
> +static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
> +
> +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> +{
> +	unsigned long a1 = usdt_red_zone_arg1;
> +	unsigned long a2 = usdt_red_zone_arg2;
> +	unsigned long a3 = usdt_red_zone_arg3;
> +
> +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> +}
> +
>  #endif

Is this test reliable across different compiler versions and optimizations?

The USDT macro uses the "nor" inline assembly constraint, which allows the
compiler to allocate these operands to CPU registers. Because there is no
register pressure in usdt_red_zone_trigger(), modern compilers might allocate
a1, a2, and a3 directly to registers rather than the stack's red zone.

If the operands are placed in registers, the uprobe CALL optimization
clobbering [rsp-8] will not corrupt them. This could cause the test to pass
even on buggy kernels, creating a false positive.

Would it be safer to explicitly force these operands into the red zone using
inline assembly constraints, rather than depending on the compiler's register
allocator?

Reference: https://lore.kernel.org/bpf/20260509021238.AE98FC2BCB0@smtp.kernel.org/
Raised by: sashiko-bot@kernel.org on Sat, 09 May 2026


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25864669093
--===============3471622894231792099==--
